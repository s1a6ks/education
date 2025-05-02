// Services/DocumentService.cs
using DocumentFactory.Models;
using Newtonsoft.Json;
using System;
using System.IO;
using System.Xml.Serialization;
using System.Text;
using System.Xml;
using Formatting = Newtonsoft.Json.Formatting;

namespace DocumentFactory.Services
{
    public class DocumentService
    {
        private readonly DocumentFactory.Models.DocumentFactory _factory;

        public DocumentService()
        {
            _factory = new DocumentFactory.Models.DocumentFactory();
        }

        // Створення документа на основі типу
        public Document CreateDocument(string type)
        {
            return _factory.CreateDocument(type);
        }

        // Збереження документа у JSON форматі
        public void SaveAsJson(Document document, string filePath)
        {
            var settings = new JsonSerializerSettings
            {
                TypeNameHandling = TypeNameHandling.All,
                Formatting = Formatting.Indented
            };

            string json = JsonConvert.SerializeObject(document, settings);
            File.WriteAllText(filePath, json);
        }

        // Завантаження документа з JSON файлу
        public Document LoadFromJson(string filePath)
        {
            if (!File.Exists(filePath))
                throw new FileNotFoundException($"Файл не знайдено: {filePath}");

            string json = File.ReadAllText(filePath);
            var settings = new JsonSerializerSettings
            {
                TypeNameHandling = TypeNameHandling.All
            };

            return JsonConvert.DeserializeObject<Document>(json, settings);
        }

        // Збереження документа у XML форматі
        public void SaveAsXml(Document document, string filePath)
        {
            var serializer = new XmlSerializer(document.GetType());
            using (var writer = new StreamWriter(filePath))
            {
                serializer.Serialize(writer, document);
            }
        }

        // Завантаження документа з XML файлу
        public Document LoadFromXml(string filePath, string documentType)
        {
            if (!File.Exists(filePath))
                throw new FileNotFoundException($"Файл не знайдено: {filePath}");

            Type type = null;
            switch (documentType.ToLower())
            {
                case "report":
                    type = typeof(Report);
                    break;
                case "letter":
                    type = typeof(Letter);
                    break;
                case "presentation":
                    type = typeof(Presentation);
                    break;
                default:
                    throw new ArgumentException($"Невідомий тип документа: {documentType}");
            }

            var serializer = new XmlSerializer(type);
            using (var reader = new StreamReader(filePath))
            {
                return (Document)serializer.Deserialize(reader);
            }
        }
    }
}