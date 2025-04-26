using System;
using System.Windows;
using NotesApp.Services;
using NotesApp.ViewModels;
using NotesApp.Views;

namespace NotesApp
{
    public partial class App : Application
    {
        private void Application_Startup(object sender, StartupEventArgs e)
        {
            // Створення сервісів
            var jsonStorage = new JsonStorage();

            // Створення головного вікна
            var mainWindow = new MainWindow();

            // Створення навігаційного сервісу
            var navigationService = new NavigationService(mainWindow);

            // Створення головної ViewModel
            var mainViewModel = new MainViewModel(jsonStorage, navigationService);

            // Встановлення контексту даних
            mainWindow.DataContext = mainViewModel;

            // Відображення головного вікна
            mainWindow.Show();
        }
    }

    // Конвертер для зміни кольору залежно від булевого значення  
    public class BoolToColorConverter : System.Windows.Data.IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (value is bool boolValue)
            {
                if (parameter is string colors)
                {
                    string[] colorParts = colors.Split('|');
                    if (colorParts.Length == 2)
                    {
                        var brushConverter = new System.Windows.Media.BrushConverter();
                        return boolValue
                            ? brushConverter.ConvertFromString(colorParts[0])
                            : brushConverter.ConvertFromString(colorParts[1]);
                    }
                }

                return boolValue
                    ? System.Windows.Media.Brushes.Green
                    : System.Windows.Media.Brushes.Gray;
            }

            return System.Windows.Media.Brushes.Gray;
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}