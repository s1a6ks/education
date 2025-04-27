using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml;
using Newtonsoft.Json;
using NoteApp.Models;
using Formatting = Newtonsoft.Json.Formatting;

namespace NoteApp.Services
{
    public interface INoteService
    {
        List<Note> GetAllNotes();
        Note GetNoteById(string id);
        void AddNote(Note note);
        void UpdateNote(Note note);
        void DeleteNote(string id);
        void PermanentlyDeleteNote(string id);
        void RestoreNote(string id);
        List<string> GetAllTags();
    }

    public class NoteService : INoteService
    {
        private List<Note> _notes;
        private readonly string _dataFilePath;

        public NoteService()
        {
            // Set up the data file path in AppData
            var appDataPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "NoteApp");

            // Ensure directory exists
            if (!Directory.Exists(appDataPath))
            {
                Directory.CreateDirectory(appDataPath);
            }

            _dataFilePath = Path.Combine(appDataPath, "notes.json");
            LoadNotes();
        }

        private void LoadNotes()
        {
            if (File.Exists(_dataFilePath))
            {
                try
                {
                    var json = File.ReadAllText(_dataFilePath);
                    _notes = JsonConvert.DeserializeObject<List<Note>>(json) ?? new List<Note>();
                }
                catch (Exception)
                {
                    _notes = new List<Note>();
                }
            }
            else
            {
                _notes = new List<Note>();
            }
        }

        private void SaveNotes()
        {
            var json = JsonConvert.SerializeObject(_notes, Formatting.Indented);
            File.WriteAllText(_dataFilePath, json);
        }

        public List<Note> GetAllNotes()
        {
            return _notes.ToList();
        }

        public Note GetNoteById(string id)
        {
            return _notes.FirstOrDefault(n => n.Id == id);
        }

        public void AddNote(Note note)
        {
            if (note == null) throw new ArgumentNullException(nameof(note));

            _notes.Add(note);
            SaveNotes();
        }

        public void UpdateNote(Note note)
        {
            if (note == null) throw new ArgumentNullException(nameof(note));

            var existingNote = _notes.FirstOrDefault(n => n.Id == note.Id);
            if (existingNote != null)
            {
                var index = _notes.IndexOf(existingNote);
                _notes[index] = note;
                SaveNotes();
            }
        }

        public void DeleteNote(string id)
        {
            var note = _notes.FirstOrDefault(n => n.Id == id);
            if (note != null)
            {
                note.Status = NoteStatus.Trash;
                SaveNotes();
            }
        }

        public void PermanentlyDeleteNote(string id)
        {
            var note = _notes.FirstOrDefault(n => n.Id == id);
            if (note != null)
            {
                _notes.Remove(note);
                SaveNotes();
            }
        }

        public void RestoreNote(string id)
        {
            var note = _notes.FirstOrDefault(n => n.Id == id);
            if (note != null && note.Status == NoteStatus.Trash)
            {
                note.Status = NoteStatus.Active;
                SaveNotes();
            }
        }

        public List<string> GetAllTags()
        {
            return _notes
                .Where(n => n.Status != NoteStatus.Trash)
                .SelectMany(n => n.Tags)
                .Distinct()
                .ToList();
        }
    }
}