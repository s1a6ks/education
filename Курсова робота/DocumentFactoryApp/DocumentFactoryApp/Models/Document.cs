// Models/Document.cs
using System;

namespace DocumentFactory.Models
{
    // Абстрактний клас Document
    public abstract class Document
    {
        public string? Title { get; set; }
        public string? Author { get; set; }
        public DateTime CreatedDate { get; set; } = DateTime.Now;

        // Метод для отримання деталей конкретного документа
        public abstract string GetDetails();
    }

    // Конкретна реалізація - Звіт
    public class Report : Document
    {
        public string? Department { get; set; }
        public string? Summary { get; set; }
        public int PageCount { get; set; }

        public override string GetDetails()
        {
            return $"Звіт: {Title}\nВідділ: {Department}\nАвтор: {Author}\nДата створення: {CreatedDate}\nСторінок: {PageCount}\nРезюме: {Summary}";
        }
    }

    // Конкретна реалізація - Лист
    public class Letter : Document
    {
        public string? Recipient { get; set; }
        public string? Subject { get; set; }
        public bool IsUrgent { get; set; }

        public override string GetDetails()
        {
            string urgentMark = IsUrgent ? "[ТЕРМІНОВО] " : "";
            return $"Лист: {urgentMark}{Title}\nОтримувач: {Recipient}\nТема: {Subject}\nАвтор: {Author}\nДата створення: {CreatedDate}";
        }
    }

    // Конкретна реалізація - Презентація
    public class Presentation : Document
    {
        public int SlideCount { get; set; }
        public string? Theme { get; set; }
        public string? TargetAudience { get; set; }

        public override string GetDetails()
        {
            return $"Презентація: {Title}\nТема: {Theme}\nАудиторія: {TargetAudience}\nАвтор: {Author}\nДата створення: {CreatedDate}\nСлайдів: {SlideCount}";
        }
    }
}