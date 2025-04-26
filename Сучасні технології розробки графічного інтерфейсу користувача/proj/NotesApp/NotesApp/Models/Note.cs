using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace NotesApp.Models
{
    public class Note : INotifyPropertyChanged
    {
        private string _id;
        private string _title;
        private string _content;
        private DateTime _createdAt;
        private DateTime _modifiedAt;
        private bool _isPinned;
        private bool _isStarred;
        private bool _isDeleted;
        private List<Tag> _tags;

        public string Id
        {
            get => _id;
            set
            {
                _id = value;
                OnPropertyChanged();
            }
        }

        public string Title
        {
            get => _title;
            set
            {
                _title = value;
                OnPropertyChanged();
            }
        }

        public string Content
        {
            get => _content;
            set
            {
                _content = value;
                OnPropertyChanged();
            }
        }

        public DateTime CreatedAt
        {
            get => _createdAt;
            set
            {
                _createdAt = value;
                OnPropertyChanged();
            }
        }

        public DateTime ModifiedAt
        {
            get => _modifiedAt;
            set
            {
                _modifiedAt = value;
                OnPropertyChanged();
            }
        }

        public bool IsPinned
        {
            get => _isPinned;
            set
            {
                _isPinned = value;
                OnPropertyChanged();
            }
        }

        public bool IsStarred
        {
            get => _isStarred;
            set
            {
                _isStarred = value;
                OnPropertyChanged();
            }
        }

        public bool IsDeleted
        {
            get => _isDeleted;
            set
            {
                _isDeleted = value;
                OnPropertyChanged();
            }
        }

        public List<Tag> Tags
        {
            get => _tags;
            set
            {
                _tags = value;
                OnPropertyChanged();
            }
        }

        public Note()
        {
            Id = Guid.NewGuid().ToString();
            CreatedAt = DateTime.Now;
            ModifiedAt = DateTime.Now;
            Tags = new List<Tag>();
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null!)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}