using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace NotesApp.Models
{
    public class Tag : INotifyPropertyChanged
    {
        private string _id;
        private string _name;
        private string _color;

        public string Id
        {
            get => _id;
            set
            {
                _id = value;
                OnPropertyChanged();
            }
        }

        public string Name
        {
            get => _name;
            set
            {
                _name = value;
                OnPropertyChanged();
            }
        }

        public string Color
        {
            get => _color;
            set
            {
                _color = value;
                OnPropertyChanged();
            }
        }

        public Tag()
        {
            Id = Guid.NewGuid().ToString();
        }

        public Tag(string name, string color) : this()
        {
            Name = name;
            Color = color;
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null!)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}