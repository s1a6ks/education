// ViewModels/MainViewModel.cs
using DocumentFactory.Models;
using DocumentFactory.Services;
using DocumentFactory.Views;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Windows;
using System.Windows.Input;

namespace DocumentFactory.ViewModels
{
    public class MainViewModel : ViewModelBase
    {
        private readonly DocumentService _documentService;
        private Document _currentDocument;
        private string _selectedDocumentType;
        private string _statusMessage;
        private bool _isReportSelected;
        private bool _isLetterSelected;
        private bool _isPresentationSelected;

        // Загальні властивості документа
        private string _title;
        private string _author;

        // Властивості для Report
        private string _department;
        private string _summary;
        private int _pageCount;

        // Властивості для Letter
        private string _recipient;
        private string _subject;
        private bool _isUrgent;

        // Властивості для Presentation
        private int _slideCount;
        private string _theme;
        private string _targetAudience;

        // Колекція доступних типів документів
        public ObservableCollection<string> DocumentTypes { get; private set; }

        // Команди
        public ICommand CreateDocumentCommand { get; private set; }
        public ICommand SaveAsJsonCommand { get; private set; }
        public ICommand SaveAsXmlCommand { get; private set; }
        public ICommand LoadFromJsonCommand { get; private set; }
        public ICommand LoadFromXmlCommand { get; private set; }
        public ICommand ClearFieldsCommand { get; private set; }
        public ICommand ShowDetailsCommand { get; private set; }

        public MainViewModel()
        {
            _documentService = new DocumentService();
            DocumentTypes = new ObservableCollection<string> { "Report", "Letter", "Presentation" };

            // Ініціалізація команд
            CreateDocumentCommand = new RelayCommand(CreateDocument, CanCreateDocument);
            SaveAsJsonCommand = new RelayCommand(SaveAsJson, () => CurrentDocument != null);
            SaveAsXmlCommand = new RelayCommand(SaveAsXml, () => CurrentDocument != null);
            LoadFromJsonCommand = new RelayCommand(LoadFromJson);
            LoadFromXmlCommand = new RelayCommand(LoadFromXml);
            ClearFieldsCommand = new RelayCommand(ClearFields);
            ShowDetailsCommand = new RelayCommand(ShowDocumentDetails, () => CurrentDocument != null);

            // Встановлення типу за замовчуванням
            SelectedDocumentType = "Report";
        }

        public string SelectedDocumentType
        {
            get => _selectedDocumentType;
            set
            {
                if (SetProperty(ref _selectedDocumentType, value))
                {
                    // Встановлюємо видимість полів відповідно до обраного типу документа
                    IsReportSelected = value == "Report";
                    IsLetterSelected = value == "Letter";
                    IsPresentationSelected = value == "Presentation";

                    // Очищаємо поля форми при зміні типу документа
                    ClearFields();
                }
            }
        }

        public Document CurrentDocument
        {
            get => _currentDocument;
            set => SetProperty(ref _currentDocument, value);
        }

        public string StatusMessage
        {
            get => _statusMessage;
            set => SetProperty(ref _statusMessage, value);
        }

        // Загальні властивості документа
        public string Title
        {
            get => _title;
            set => SetProperty(ref _title, value);
        }

        public string Author
        {
            get => _author;
            set => SetProperty(ref _author, value);
        }

        // Властивості для Report
        public string Department
        {
            get => _department;
            set => SetProperty(ref _department, value);
        }

        public string Summary
        {
            get => _summary;
            set => SetProperty(ref _summary, value);
        }

        public int PageCount
        {
            get => _pageCount;
            set => SetProperty(ref _pageCount, value);
        }

        // Властивості для Letter
        public string Recipient
        {
            get => _recipient;
            set => SetProperty(ref _recipient, value);
        }

        public string Subject
        {
            get => _subject;
            set => SetProperty(ref _subject, value);
        }

        public bool IsUrgent
        {
            get => _isUrgent;
            set => SetProperty(ref _isUrgent, value);
        }

        // Властивості для Presentation
        public int SlideCount
        {
            get => _slideCount;
            set => SetProperty(ref _slideCount, value);
        }

        public string Theme
        {
            get => _theme;
            set => SetProperty(ref _theme, value);
        }

        public string TargetAudience
        {
            get => _targetAudience;
            set => SetProperty(ref _targetAudience, value);
        }

        // Прапорці видимості полів
        public bool IsReportSelected
        {
            get => _isReportSelected;
            set => SetProperty(ref _isReportSelected, value);
        }

        public bool IsLetterSelected
        {
            get => _isLetterSelected;
            set => SetProperty(ref _isLetterSelected, value);
        }

        public bool IsPresentationSelected
        {
            get => _isPresentationSelected;
            set => SetProperty(ref _isPresentationSelected, value);
        }

        // Методи
        private void CreateDocument()
        {
            try
            {
                // Валідація загальних полів
                if (string.IsNullOrWhiteSpace(Title))
                {
                    StatusMessage = "Помилка: Назва документа не може бути порожньою.";
                    return;
                }

                if (string.IsNullOrWhiteSpace(Author))
                {
                    StatusMessage = "Помилка: Автор документа не може бути порожнім.";
                    return;
                }

                // Створення документа за допомогою фабрики
                CurrentDocument = _documentService.CreateDocument(SelectedDocumentType);

                // Встановлення загальних властивостей
                CurrentDocument.Title = Title;
                CurrentDocument.Author = Author;
                CurrentDocument.CreatedDate = DateTime.Now;

                // Заповнення специфічних властивостей в залежності від типу документа
                switch (SelectedDocumentType)
                {
                    case "Report":
                        var report = (Report)CurrentDocument;

                        // Валідація специфічних полів для звіту
                        if (string.IsNullOrWhiteSpace(Department))
                        {
                            StatusMessage = "Помилка: Відділ не може бути порожнім.";
                            return;
                        }

                        report.Department = Department;
                        report.Summary = Summary;
                        report.PageCount = PageCount;
                        break;

                    case "Letter":
                        var letter = (Letter)CurrentDocument;

                        // Валідація специфічних полів для листа
                        if (string.IsNullOrWhiteSpace(Recipient))
                        {
                            StatusMessage = "Помилка: Отримувач не може бути порожнім.";
                            return;
                        }

                        if (string.IsNullOrWhiteSpace(Subject))
                        {
                            StatusMessage = "Помилка: Тема листа не може бути порожньою.";
                            return;
                        }

                        letter.Recipient = Recipient;
                        letter.Subject = Subject;
                        letter.IsUrgent = IsUrgent;
                        break;

                    case "Presentation":
                        var presentation = (Presentation)CurrentDocument;

                        // Валідація специфічних полів для презентації
                        if (string.IsNullOrWhiteSpace(Theme))
                        {
                            StatusMessage = "Помилка: Тема презентації не може бути порожньою.";
                            return;
                        }

                        if (string.IsNullOrWhiteSpace(TargetAudience))
                        {
                            StatusMessage = "Помилка: Цільова аудиторія не може бути порожньою.";
                            return;
                        }

                        presentation.Theme = Theme;
                        presentation.TargetAudience = TargetAudience;
                        presentation.SlideCount = SlideCount;
                        break;
                }

                StatusMessage = $"Документ \"{CurrentDocument.Title}\" успішно створено.";
            }
            catch (Exception ex)
            {
                StatusMessage = $"Помилка: {ex.Message}";
            }
        }

        private bool CanCreateDocument()
        {
            return !string.IsNullOrWhiteSpace(SelectedDocumentType);
        }

        private void SaveAsJson()
        {
            try
            {
                var saveFileDialog = new SaveFileDialog
                {
                    Filter = "JSON files (*.json)|*.json",
                    DefaultExt = ".json",
                    Title = "Зберегти документ як JSON"
                };

                if (saveFileDialog.ShowDialog() == true)
                {
                    _documentService.SaveAsJson(CurrentDocument, saveFileDialog.FileName);
                    StatusMessage = $"Документ збережено у JSON форматі: {saveFileDialog.FileName}";
                }
            }
            catch (Exception ex)
            {
                StatusMessage = $"Помилка при збереженні: {ex.Message}";
            }
        }

        private void SaveAsXml()
        {
            try
            {
                var saveFileDialog = new SaveFileDialog
                {
                    Filter = "XML files (*.xml)|*.xml",
                    DefaultExt = ".xml",
                    Title = "Зберегти документ як XML"
                };

                if (saveFileDialog.ShowDialog() == true)
                {
                    _documentService.SaveAsXml(CurrentDocument, saveFileDialog.FileName);
                    StatusMessage = $"Документ збережено у XML форматі: {saveFileDialog.FileName}";
                }
            }
            catch (Exception ex)
            {
                StatusMessage = $"Помилка при збереженні: {ex.Message}";
            }
        }

        private void LoadFromJson()
        {
            try
            {
                var openFileDialog = new OpenFileDialog
                {
                    Filter = "JSON files (*.json)|*.json",
                    Title = "Відкрити документ з JSON"
                };

                if (openFileDialog.ShowDialog() == true)
                {
                    CurrentDocument = _documentService.LoadFromJson(openFileDialog.FileName);
                    UpdateFormFromDocument();
                    StatusMessage = $"Документ завантажено з JSON файлу: {openFileDialog.FileName}";
                }
            }
            catch (Exception ex)
            {
                StatusMessage = $"Помилка при завантаженні: {ex.Message}";
            }
        }

        private void LoadFromXml()
        {
            try
            {
                var openFileDialog = new OpenFileDialog
                {
                    Filter = "XML files (*.xml)|*.xml",
                    Title = "Відкрити документ з XML"
                };

                if (openFileDialog.ShowDialog() == true)
                {
                    // Діалог вибору типу документа для завантаження з XML
                    var result = MessageBox.Show("Виберіть тип документа для завантаження:\n\n" +
                                                "Так - для Report\n" +
                                                "Ні - для Letter\n" +
                                                "Скасувати - для Presentation",
                                                "Вибір типу документа",
                                                MessageBoxButton.YesNoCancel);

                    string documentType;
                    switch (result)
                    {
                        case MessageBoxResult.Yes:
                            documentType = "Report";
                            break;
                        case MessageBoxResult.No:
                            documentType = "Letter";
                            break;
                        case MessageBoxResult.Cancel:
                            documentType = "Presentation";
                            break;
                        default:
                            return;
                    }

                    CurrentDocument = _documentService.LoadFromXml(openFileDialog.FileName, documentType);
                    UpdateFormFromDocument();
                    StatusMessage = $"Документ завантажено з XML файлу: {openFileDialog.FileName}";
                }
            }
            catch (Exception ex)
            {
                StatusMessage = $"Помилка при завантаженні: {ex.Message}";
            }
        }

        private void UpdateFormFromDocument()
        {
            if (CurrentDocument == null) return;

            // Обов'язково спочатку встановлюємо тип документа, щоб відповідні поля стали видимими
            if (CurrentDocument is Report)
            {
                SelectedDocumentType = "Report";
            }
            else if (CurrentDocument is Letter)
            {
                SelectedDocumentType = "Letter";
            }
            else if (CurrentDocument is Presentation)
            {
                SelectedDocumentType = "Presentation";
            }

            // Встановлення загальних властивостей
            Title = CurrentDocument.Title;
            Author = CurrentDocument.Author;

            // Заповнення специфічних полів залежно від типу документа
            if (CurrentDocument is Report report)
            {
                Department = report.Department;
                Summary = report.Summary;
                PageCount = report.PageCount;
            }
            else if (CurrentDocument is Letter letter)
            {
                Recipient = letter.Recipient;
                Subject = letter.Subject;
                IsUrgent = letter.IsUrgent;
            }
            else if (CurrentDocument is Presentation presentation)
            {
                Theme = presentation.Theme;
                TargetAudience = presentation.TargetAudience;
                SlideCount = presentation.SlideCount;
            }
        }

        // Метод для очищення полів форми (виконується за командою)
        private void ClearFields()
        {
            // Очищення всіх полів форми
            Title = string.Empty;
            Author = string.Empty;
            Department = string.Empty;
            Summary = string.Empty;
            PageCount = 0;
            Recipient = string.Empty;
            Subject = string.Empty;
            IsUrgent = false;
            Theme = string.Empty;
            TargetAudience = string.Empty;
            SlideCount = 0;
            StatusMessage = "Всі поля очищено.";

            // Очищаємо поточний документ
            CurrentDocument = null;
        }

        // Метод для відображення інформації про документ у окремому вікні
        private void ShowDocumentDetails()
        {
            if (CurrentDocument == null) return;

            var detailsWindow = new DocumentDetailsWindow(CurrentDocument);
            detailsWindow.Owner = Application.Current.MainWindow;
            detailsWindow.ShowDialog();
        }
    }

    // Клас для реалізації команд
    public class RelayCommand : ICommand
    {
        private readonly Action _execute;
        private readonly Func<bool> _canExecute;

        public RelayCommand(Action execute, Func<bool> canExecute = null)
        {
            _execute = execute ?? throw new ArgumentNullException(nameof(execute));
            _canExecute = canExecute;
        }

        public event EventHandler CanExecuteChanged
        {
            add { CommandManager.RequerySuggested += value; }
            remove { CommandManager.RequerySuggested -= value; }
        }

        public bool CanExecute(object parameter)
        {
            return _canExecute == null || _canExecute();
        }

        public void Execute(object parameter)
        {
            _execute();
        }
    }
}