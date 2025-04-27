using System.Windows;
using System.Windows.Input;
using NoteApp.ViewModels;

namespace NoteApp
{
    public partial class NoteEditorWindow : Window
    {
        public NoteEditorWindow()
        {
            InitializeComponent();
        }

        private void TagInput_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                var viewModel = DataContext as NoteEditorViewModel;
                viewModel?.AddTag();
            }
        }
    }
}