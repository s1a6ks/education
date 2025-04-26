using System.Windows;
using NotesApp.ViewModels;

namespace NotesApp.Views
{
    public partial class NoteEditorWindow : Window
    {
        public NoteEditorWindow()
        {
            InitializeComponent();

            // Підписка на команду скасування для закриття вікна
            this.Loaded += (s, e) =>
            {
                if (DataContext is NoteEditorViewModel viewModel)
                {
                    // Use reflection to set the read-only properties if necessary
                    var cancelCommandProperty = typeof(NoteEditorViewModel).GetProperty(nameof(NoteEditorViewModel.CancelCommand));
                    var saveCommandProperty = typeof(NoteEditorViewModel).GetProperty(nameof(NoteEditorViewModel.SaveCommand));

                    if (cancelCommandProperty != null && cancelCommandProperty.CanWrite)
                    {
                        cancelCommandProperty.SetValue(viewModel, new RelayCommand(_ =>
                        {
                            this.DialogResult = false;
                            this.Close();
                        }));
                    }

                    if (saveCommandProperty != null && saveCommandProperty.CanWrite)
                    {
                        saveCommandProperty.SetValue(viewModel, new RelayCommand(_ =>
                        {
                            this.DialogResult = true;
                            this.Close();
                        }));
                    }
                }
            };
        }
    }
}