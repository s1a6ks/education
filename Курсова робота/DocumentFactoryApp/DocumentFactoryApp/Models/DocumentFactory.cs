// Models/DocumentFactory.cs
using System;

namespace DocumentFactory.Models
{
    // Фабричний метод для створення документів
    public class DocumentFactory
    {
        // Метод для створення документа відповідного типу
        public Document CreateDocument(string documentType)
        {
            switch (documentType.ToLower())
            {
                case "report":
                    return new Report();
                case "letter":
                    return new Letter();
                case "presentation":
                    return new Presentation();
                default:
                    throw new ArgumentException($"Невідомий тип документа: {documentType}");
            }
        }
    }
}