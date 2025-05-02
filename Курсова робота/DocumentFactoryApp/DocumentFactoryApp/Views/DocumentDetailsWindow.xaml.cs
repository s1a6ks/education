// Views/DocumentDetailsWindow.xaml.cs
using DocumentFactory.Models;
using System.Windows;

namespace DocumentFactory.Views
{
    public partial class DocumentDetailsWindow : Window
    {
        public DocumentDetailsWindow(Document document)
        {
            InitializeComponent();

            if (document != null)
            {
                // Встановлюємо заголовок вікна залежно від типу документа
                string documentType = GetDocumentTypeName(document);
                TitleBlock.Text = $"Деталі документа: {documentType}";

                // Відображаємо деталі документа
                DetailsTextBlock.Text = document.GetDetails();
            }
        }

        private string GetDocumentTypeName(Document document)
        {
            if (document is Report)
                return "Звіт";
            else if (document is Letter)
                return "Лист";
            else if (document is Presentation)
                return "Презентація";
            else
                return "Невідомий тип";
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}