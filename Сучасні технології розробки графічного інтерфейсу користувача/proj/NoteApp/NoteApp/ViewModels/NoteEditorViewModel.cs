using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Windows.Input;
using NoteApp.Models;

namespace NoteApp.ViewModels
{
    public class NoteEditorViewModel : INotifyPropertyChanged
    {
        private Note _note;
        private string _title;
        private string _content;
        private ObservableCollection<string> _tags;
        private string _tagInput;

        public string Title
        {
            get { return _title; }
            set { SetProperty(ref _title, value); }
        }

        public string Content
        {
            get { return _content; }
            set { SetProperty(ref _content, value); }
        }

        public ObservableCollection<string> Tags
        {
            get { return _tags; }
            set { SetProperty(ref _tags, value); }
        }

        public string TagInput
        {
            get { return _tagInput; }
            set { SetProperty(ref _tagInput, value); }
        }

        public ICommand SaveCommand { get; private set; }
        public ICommand CancelCommand { get; private set; }
        public ICommand AddTagCommand { get; private set; }
        public ICommand RemoveTagCommand { get; private set; }

        public event EventHandler<DialogCloseEventArgs> RequestClose;

        public NoteEditorViewModel(Note note)
        {
            _note = note ?? new Note();
            Title = _note.Title;
            Content = _note.Content;
            Tags = new ObservableCollection<string>(_note.Tags);
            TagInput = string.Empty;

            SaveCommand = new RelayCommand(_ => Save());
            CancelCommand = new RelayCommand(_ => Cancel());
            AddTagCommand = new RelayCommand(_ => AddTag());
            RemoveTagCommand = new RelayCommand(tag => RemoveTag(tag as string));
        }

        private void Save()
        {
            // Update the note with current values
            _note.Title = Title;
            _note.Content = Content;
            _note.Tags.Clear();
            foreach (var tag in Tags)
            {
                _note.Tags.Add(tag);
            }
            _note.DateModified = DateTime.Now;

            // Close with success
            OnRequestClose(new DialogCloseEventArgs(true, _note));
        }

        private void Cancel()
        {
            // Close without saving
            OnRequestClose(new DialogCloseEventArgs(false, null));
        }

        public void AddTag()
        {
            if (string.IsNullOrWhiteSpace(TagInput)) return;

            // Split on commas and add individual tags
            var newTags = TagInput.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(t => t.Trim())
                .Where(t => !string.IsNullOrWhiteSpace(t))
                .ToList();

            foreach (var tag in newTags)
            {
                if (!Tags.Contains(tag))
                {
                    Tags.Add(tag);
                }
            }

            TagInput = string.Empty;
        }

        private void RemoveTag(string tag)
        {
            if (tag != null && Tags.Contains(tag))
            {
                Tags.Remove(tag);
            }
        }

        protected virtual void OnRequestClose(DialogCloseEventArgs e)
        {
            RequestClose?.Invoke(this, e);
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

    public class DialogCloseEventArgs : EventArgs
    {
        public bool DialogResult { get; }
        public Note Note { get; }

        public DialogCloseEventArgs(bool dialogResult, Note note)
        {
            DialogResult = dialogResult;
            Note = note;
        }
    }
}