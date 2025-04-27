using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace NoteApp.Models
{
    public class Note : INotifyPropertyChanged
    {
        private string _id;
        private string _title;
        private string _content;
        private DateTime _dateCreated;
        private DateTime _dateModified;
        private ObservableCollection<string> _tags;
        private bool _isStarred;
        private NoteStatus _status;

        public string Id
        {
            get { return _id; }
            set { SetProperty(ref _id, value); }
        }

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

        public DateTime DateCreated
        {
            get { return _dateCreated; }
            set { SetProperty(ref _dateCreated, value); }
        }

        public DateTime DateModified
        {
            get { return _dateModified; }
            set { SetProperty(ref _dateModified, value); }
        }

        public ObservableCollection<string> Tags
        {
            get { return _tags; }
            set { SetProperty(ref _tags, value); }
        }

        public bool IsStarred
        {
            get { return _isStarred; }
            set { SetProperty(ref _isStarred, value); }
        }

        public NoteStatus Status
        {
            get { return _status; }
            set { SetProperty(ref _status, value); }
        }

        public Note()
        {
            Id = Guid.NewGuid().ToString();
            DateCreated = DateTime.Now;
            DateModified = DateTime.Now;
            Tags = new ObservableCollection<string>();
            Status = NoteStatus.Active;
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

    public enum NoteStatus
    {
        Active,
        Starred,
        Trash
    }
}