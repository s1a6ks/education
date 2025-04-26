using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using System.Xml;
using Newtonsoft.Json;
using NotesApp.Models;
using Formatting = Newtonsoft.Json.Formatting;

namespace NotesApp.Services
{
    public class JsonStorage
    {
        private readonly string _notesFilePath;
        private readonly string _tagsFilePath;

        public JsonStorage()
        {
            string appDataPath = Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData),
                "NotesApp");

            if (!Directory.Exists(appDataPath))
            {
                Directory.CreateDirectory(appDataPath);
            }

            _notesFilePath = Path.Combine(appDataPath, "notes.json");
            _tagsFilePath = Path.Combine(appDataPath, "tags.json");
        }

        public async Task<List<Note>> LoadNotesAsync()
        {
            if (!File.Exists(_notesFilePath))
            {
                return new List<Note>();
            }

            try
            {
                string json = await File.ReadAllTextAsync(_notesFilePath);
                return JsonConvert.DeserializeObject<List<Note>>(json) ?? new List<Note>();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error loading notes: {ex.Message}");
                return new List<Note>();
            }
        }

        public async Task SaveNotesAsync(List<Note> notes)
        {
            try
            {
                string json = JsonConvert.SerializeObject(notes, Formatting.Indented);
                await File.WriteAllTextAsync(_notesFilePath, json);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error saving notes: {ex.Message}");
            }
        }

        public async Task<List<Tag>> LoadTagsAsync()
        {
            if (!File.Exists(_tagsFilePath))
            {
                return new List<Tag>();
            }

            try
            {
                string json = await File.ReadAllTextAsync(_tagsFilePath);
                return JsonConvert.DeserializeObject<List<Tag>>(json) ?? new List<Tag>();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error loading tags: {ex.Message}");
                return new List<Tag>();
            }
        }

        public async Task SaveTagsAsync(List<Tag> tags)
        {
            try
            {
                string json = JsonConvert.SerializeObject(tags, Formatting.Indented);
                await File.WriteAllTextAsync(_tagsFilePath, json);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error saving tags: {ex.Message}");
            }
        }
    }
}