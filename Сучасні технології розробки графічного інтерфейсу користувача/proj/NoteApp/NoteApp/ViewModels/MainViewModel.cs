using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Windows.Input;
using NoteApp.Models;
using NoteApp.Services;

namespace NoteApp.ViewModels
{
    public class MainViewModel : INotifyPropertyChanged
    {
        private readonly INoteService _noteService;
        private ObservableCollection<Note> _allNotes;
        private ObservableCollection<Note> _filteredNotes;
        private string _currentSection;
        private string _searchText;

        public ObservableCollection<Note> AllNotes
        {
            get { return _allNotes; }
            set { SetProperty(ref _allNotes, value); }
        }

        public ObservableCollection<Note> FilteredNotes
        {
            get { return _filteredNotes; }
            set { SetProperty(ref _filteredNotes, value); }
        }

        public string CurrentSection
        {
            get { return _currentSection; }
            set { SetProperty(ref _currentSection, value); }
        }

        public string SearchText
        {
            get { return _searchText; }
            set
            {
                if (SetProperty(ref _searchText, value))
                {
                    FilterNotes();
                }
            }
        }

        // Commands
        public ICommand ShowAllNotesCommand { get; private set; }
        public ICommand ShowStarredCommand { get; private set; }
        public ICommand ShowTrashCommand { get; private set; }
        public ICommand ShowSearchCommand { get; private set; }
        public ICommand ShowTagsCommand { get; private set; }
        public ICommand ShowSettingsCommand { get; private set; }
        public ICommand CreateNoteCommand { get; private set; }
        public ICommand EditNoteCommand { get; private set; }
        public ICommand StarNoteCommand { get; private set; }
        public ICommand DeleteNoteCommand { get; private set; }

        public MainViewModel(INoteService noteService)
        {
            _noteService = noteService;
            AllNotes = new ObservableCollection<Note>(_noteService.GetAllNotes());
            FilteredNotes = new ObservableCollection<Note>(AllNotes);
            CurrentSection = "All Notes";

            InitializeCommands();
            ShowAllNotesView();
        }

        private void InitializeCommands()
        {
            ShowAllNotesCommand = new RelayCommand(_ => ShowAllNotesView());
            ShowStarredCommand = new RelayCommand(_ => ShowStarredView());
            ShowTrashCommand = new RelayCommand(_ => ShowTrashView());
            ShowSearchCommand = new RelayCommand(_ => ShowSearchView());
            ShowTagsCommand = new RelayCommand(_ => ShowTagsView());
            ShowSettingsCommand = new RelayCommand(_ => ShowSettingsView());
            CreateNoteCommand = new RelayCommand(_ => CreateNote());
            EditNoteCommand = new RelayCommand(note => EditNote(note as Note));
            StarNoteCommand = new RelayCommand(note => ToggleStarNote(note as Note));
            DeleteNoteCommand = new RelayCommand(note => DeleteNote(note as Note));
        }

        private void ShowAllNotesView()
        {
            CurrentSection = "All Notes";
            FilteredNotes = new ObservableCollection<Note>(
                AllNotes.Where(n => n.Status == NoteStatus.Active));
        }

        private void ShowStarredView()
        {
            CurrentSection = "Starred Notes";
            FilteredNotes = new ObservableCollection<Note>(
                AllNotes.Where(n => n.IsStarred && n.Status != NoteStatus.Trash));
        }

        private void ShowTrashView()
        {
            CurrentSection = "Trash";
            FilteredNotes = new ObservableCollection<Note>(
                AllNotes.Where(n => n.Status == NoteStatus.Trash));
        }

        private void ShowSearchView()
        {
            CurrentSection = "Search";
            SearchText = string.Empty;
            FilterNotes();
        }

        private void ShowTagsView()
        {
            CurrentSection = "Tags";
            // This would typically show a list of all tags
            // For now, we'll just show all notes
            FilteredNotes = new ObservableCollection<Note>(
                AllNotes.Where(n => n.Status != NoteStatus.Trash));
        }

        private void ShowSettingsView()
        {
            CurrentSection = "Settings";
            // This would typically show settings UI
            // For now, we'll just clear the notes list
            FilteredNotes.Clear();
        }

        private void FilterNotes()
        {
            if (string.IsNullOrWhiteSpace(SearchText))
            {
                // If search text is empty, show based on current section
                switch (CurrentSection)
                {
                    case "All Notes":
                        ShowAllNotesView();
                        break;
                    case "Starred Notes":
                        ShowStarredView();
                        break;
                    case "Trash":
                        ShowTrashView();
                        break;
                    default:
                        FilteredNotes = new ObservableCollection<Note>(
                            AllNotes.Where(n => n.Status != NoteStatus.Trash));
                        break;
                }
            }
            else
            {
                // Filter based on search text
                var searchLower = SearchText.ToLower();
                FilteredNotes = new ObservableCollection<Note>(
                    AllNotes.Where(n => n.Status != NoteStatus.Trash &&
                                      (n.Title.ToLower().Contains(searchLower) ||
                                       n.Content.ToLower().Contains(searchLower) ||
                                       n.Tags.Any(t => t.ToLower().Contains(searchLower)))));
            }
        }

        private void CreateNote()
        {
            var noteViewModel = new NoteEditorViewModel(new Note());

            var editorWindow = new NoteEditorWindow
            {
                DataContext = noteViewModel
            };

            noteViewModel.RequestClose += (sender, e) =>
            {
                editorWindow.Close();

                if (e.DialogResult == true && e.Note != null)
                {
                    // Add the new note to the collection
                    _noteService.AddNote(e.Note);
                    AllNotes.Add(e.Note);
                    FilterNotes();
                }
            };

            editorWindow.ShowDialog();
        }


        private void EditNote(Note note)
        {
            if (note == null) return;

            var noteViewModel = new NoteEditorViewModel(note);

            var editorWindow = new NoteEditorWindow
            {
                DataContext = noteViewModel
            };

            noteViewModel.RequestClose += (sender, e) =>
            {
                editorWindow.Close();

                if (e.DialogResult == true && e.Note != null)
                {
                    // Update the note in the service
                    _noteService.UpdateNote(e.Note);

                    // Update the UI
                    var index = AllNotes.IndexOf(note);
                    if (index >= 0)
                    {
                        AllNotes[index] = e.Note;
                    }

                    FilterNotes();
                }
            };

            editorWindow.ShowDialog();
        }

        private void ToggleStarNote(Note note)
        {
            if (note == null) return;

            note.IsStarred = !note.IsStarred;
            _noteService.UpdateNote(note);
            FilterNotes();
        }

        private void DeleteNote(Note note)
        {
            if (note == null) return;

            // Soft delete - move to trash
            note.Status = NoteStatus.Trash;
            _noteService.UpdateNote(note);
            FilterNotes();
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected bool SetProperty<T>(ref T field, T value, [CallerMemberName] string propertyName = null)
        {
            if (EqualityComparer<T>.Default.Equals(field, value)) return false;
            field = value;
            OnPropertyChanged(propertyName);
            return true;
        }

        protected void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    // Simple implementation of ICommand
    public class RelayCommand : ICommand
    {
        private readonly Action<object> _execute;
        private readonly Predicate<object> _canExecute;

        public RelayCommand(Action<object> execute, Predicate<object> canExecute = null)
        {
            _execute = execute ?? throw new ArgumentNullException(nameof(execute));
            _canExecute = canExecute;
        }

        public bool CanExecute(object parameter)
        {
            return _canExecute == null || _canExecute(parameter);
        }

        public void Execute(object parameter)
        {
            _execute(parameter);
        }

        public event EventHandler CanExecuteChanged
        {
            add { CommandManager.RequerySuggested += value; }
            remove { CommandManager.RequerySuggested -= value; }
        }
    }
}