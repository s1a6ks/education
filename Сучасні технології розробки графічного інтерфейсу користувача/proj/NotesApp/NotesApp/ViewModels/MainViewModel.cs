using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Input;
using NotesApp.Models;
using NotesApp.Services;

namespace NotesApp.ViewModels
{
    public class MainViewModel : ViewModelBase
    {
        private readonly JsonStorage _jsonStorage;
        private readonly NavigationService _navigationService;
        private ObservableCollection<Note> _allNotes;
        private ObservableCollection<Note> _filteredNotes;
        private ObservableCollection<Tag> _tags;
        private string _searchText;
        private Note _selectedNote;
        private string _currentView = "Notes"; // Notes, Starred, Trash, Tags

        public ObservableCollection<Note> FilteredNotes
        {
            get => _filteredNotes;
            set => SetProperty(ref _filteredNotes, value);
        }

        public ObservableCollection<Tag> Tags
        {
            get => _tags;
            set => SetProperty(ref _tags, value);
        }

        public string SearchText
        {
            get => _searchText;
            set
            {
                if (SetProperty(ref _searchText, value))
                {
                    FilterNotes();
                }
            }
        }

        public Note SelectedNote
        {
            get => _selectedNote;
            set => SetProperty(ref _selectedNote, value);
        }

        public string CurrentView
        {
            get => _currentView;
            set
            {
                if (SetProperty(ref _currentView, value))
                {
                    FilterNotes();
                }
            }
        }

        public ICommand AddNoteCommand { get; }
        public ICommand EditNoteCommand { get; }
        public ICommand DeleteNoteCommand { get; }
        public ICommand RestoreNoteCommand { get; }
        public ICommand TogglePinCommand { get; }
        public ICommand ToggleStarCommand { get; }
        public ICommand ChangeViewCommand { get; }

        public MainViewModel(JsonStorage jsonStorage, NavigationService navigationService)
        {
            _jsonStorage = jsonStorage;
            _navigationService = navigationService;
            _allNotes = new ObservableCollection<Note>();
            _filteredNotes = new ObservableCollection<Note>();
            _tags = new ObservableCollection<Tag>();

            AddNoteCommand = new RelayCommand(_ => AddNote());
            EditNoteCommand = new RelayCommand(param => EditNote(param as Note));
            DeleteNoteCommand = new RelayCommand(param => DeleteNote(param as Note));
            RestoreNoteCommand = new RelayCommand(param => RestoreNote(param as Note));
            TogglePinCommand = new RelayCommand(param => TogglePin(param as Note));
            ToggleStarCommand = new RelayCommand(param => ToggleStar(param as Note));
            ChangeViewCommand = new RelayCommand(param => CurrentView = param as string);

            LoadData();
        }

        private async void LoadData()
        {
            var notes = await _jsonStorage.LoadNotesAsync();
            _allNotes = new ObservableCollection<Note>(notes);
            var tags = await _jsonStorage.LoadTagsAsync();
            Tags = new ObservableCollection<Tag>(tags);
            FilterNotes();
        }

        private async void SaveData()
        {
            await _jsonStorage.SaveNotesAsync(_allNotes.ToList());
            await _jsonStorage.SaveTagsAsync(Tags.ToList());
        }

        private void FilterNotes()
        {
            IEnumerable<Note> filtered = _allNotes;

            // Фільтрація по поточному представленню
            switch (CurrentView)
            {
                case "Notes":
                    filtered = filtered.Where(n => !n.IsDeleted);
                    break;
                case "Starred":
                    filtered = filtered.Where(n => n.IsStarred && !n.IsDeleted);
                    break;
                case "Trash":
                    filtered = filtered.Where(n => n.IsDeleted);
                    break;
                case "Tags":
                    // Тут може бути додаткова логіка фільтрації по тегам
                    filtered = filtered.Where(n => !n.IsDeleted);
                    break;
            }

            // Фільтрація по пошуку
            if (!string.IsNullOrWhiteSpace(SearchText))
            {
                string searchLower = SearchText.ToLower();
                filtered = filtered.Where(n =>
                    n.Title.ToLower().Contains(searchLower) ||
                    n.Content.ToLower().Contains(searchLower) ||
                    n.Tags.Any(t => t.Name.ToLower().Contains(searchLower)));
            }

            // Спочатку закріплені нотатки, потім по даті модифікації
            filtered = filtered.OrderByDescending(n => n.IsPinned)
                              .ThenByDescending(n => n.ModifiedAt);

            FilteredNotes = new ObservableCollection<Note>(filtered);
        }

        private void AddNote()
        {
            var newNote = new Note
            {
                Title = "Нова нотатка",
                Content = "",
                CreatedAt = DateTime.Now,
                ModifiedAt = DateTime.Now
            };

            _allNotes.Add(newNote);
            SaveData();
            FilterNotes();
            EditNote(newNote);
        }

        private void EditNote(Note note)
        {
            if (note == null) return;

            // Відкриття вікна редагування нотатки через NavigationService
            _navigationService.OpenNoteEditor(note, Tags, () => {
                SaveData();
                FilterNotes();
            });
        }

        private void DeleteNote(Note note)
        {
            if (note == null) return;

            if (CurrentView == "Trash")
            {
                _allNotes.Remove(note);
            }
            else
            {
                note.IsDeleted = true;
            }

            SaveData();
            FilterNotes();
        }

        private void RestoreNote(Note note)
        {
            if (note == null || !note.IsDeleted) return;

            note.IsDeleted = false;
            SaveData();
            FilterNotes();
        }

        private void TogglePin(Note note)
        {
            if (note == null) return;

            note.IsPinned = !note.IsPinned;
            SaveData();
            FilterNotes();
        }

        private void ToggleStar(Note note)
        {
            if (note == null) return;

            note.IsStarred = !note.IsStarred;
            SaveData();
            FilterNotes();
        }
    }
}