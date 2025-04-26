using System;
using System.Collections.ObjectModel;
using System.Windows;
using NotesApp.Models;
using NotesApp.ViewModels;
using NotesApp.Views;

namespace NotesApp.Services
{
    public class NavigationService
    {
        private readonly Window _mainWindow;

        public NavigationService(Window mainWindow)
        {
            _mainWindow = mainWindow;
        }

        public bool OpenNoteEditor(Note note, ObservableCollection<Tag> availableTags, Action onSave)
        {
            var editorViewModel = new NoteEditorViewModel(note, availableTags, onSave, null!);
            var editorWindow = new NoteEditorWindow
            {
                DataContext = editorViewModel,
                Owner = _mainWindow
            };

            return editorWindow.ShowDialog() ?? false;
        }
    }
}