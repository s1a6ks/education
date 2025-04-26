using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Input;
using NotesApp.Models;
using NotesApp.Services;

namespace NotesApp.ViewModels
{
    public class NoteEditorViewModel : ViewModelBase
    {
        private readonly Note _originalNote;
        private readonly Action _onSave;
        private readonly Action _onCancel;
        private readonly ObservableCollection<Tag> _availableTags;
        private string _title;
        private string _content;
        private ObservableCollection<Tag> _tags;
        private Tag _selectedTag;

        public string Title
        {
            get => _title;
            set => SetProperty(ref _title, value);
        }

        public string Content
        {
            get => _content;
            set => SetProperty(ref _content, value);
        }

        public ObservableCollection<Tag> Tags
        {
            get => _tags;
            set => SetProperty(ref _tags, value);
        }

        public ObservableCollection<Tag> AvailableTags => _availableTags;

        public Tag SelectedTag
        {
            get => _selectedTag;
            set => SetProperty(ref _selectedTag, value);
        }

        public ICommand SaveCommand { get; }
        public ICommand CancelCommand { get; }
        public ICommand AddTagCommand { get; }
        public ICommand RemoveTagCommand { get; }

        public NoteEditorViewModel(Note note, ObservableCollection<Tag> availableTags, Action onSave, Action onCancel)
        {
            _originalNote = note;
            _availableTags = availableTags;
            _onSave = onSave;
            _onCancel = onCancel;

            Title = note.Title;
            Content = note.Content;
            Tags = new ObservableCollection<Tag>(note.Tags);

            SaveCommand = new RelayCommand(_ => Save());
            CancelCommand = new RelayCommand(_ => Cancel());
            AddTagCommand = new RelayCommand(_ => AddTag(), _ => CanAddTag());
            RemoveTagCommand = new RelayCommand(param => RemoveTag(param as Tag));
        }

        private void Save()
        {
            _originalNote.Title = Title;
            _originalNote.Content = Content;
            _originalNote.Tags = Tags.ToList();
            _originalNote.ModifiedAt = DateTime.Now;

            _onSave?.Invoke();
        }

        private void Cancel()
        {
            _onCancel?.Invoke();
        }

        private bool CanAddTag()
        {
            return SelectedTag != null && !Tags.Any(t => t.Id == SelectedTag.Id);
        }

        private void AddTag()
        {
            if (SelectedTag != null && !Tags.Any(t => t.Id == SelectedTag.Id))
            {
                Tags.Add(SelectedTag);
            }
        }

        private void RemoveTag(Tag tag)
        {
            if (tag != null)
            {
                Tags.Remove(tag);
            }
        }
    }
}