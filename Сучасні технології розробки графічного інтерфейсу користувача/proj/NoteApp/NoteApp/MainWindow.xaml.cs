using System.Windows;
using NoteApp.Services;
using NoteApp.ViewModels;

namespace NoteApp
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            DataContext = new MainViewModel(new NoteService());
        }
    }
}