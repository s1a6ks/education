using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Shapes;

namespace DrawingApp
{
    public partial class MainWindow : Window
    {
        private string selectedShape = "Ellipse"; // За замовченням

        public MainWindow()
        {
            InitializeComponent();
        }

        private void EllipseButton_Click(object sender, RoutedEventArgs e)
        {
            selectedShape = "Ellipse";
        }

        private void CircleButton_Click(object sender, RoutedEventArgs e)
        {
            selectedShape = "Circle";
        }

        private void RectangleButton_Click(object sender, RoutedEventArgs e)
        {
            selectedShape = "Rectangle";
        }

        private void SquareButton_Click(object sender, RoutedEventArgs e)
        {
            selectedShape = "Square";
        }

        private void LineButton_Click(object sender, RoutedEventArgs e)
        {
            selectedShape = "Line";
        }

        private void Canvas_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            Point clickPosition = e.GetPosition(DrawingCanvas);
            Shape shape = null;

            SolidColorBrush color = GetSelectedColor();

            Random rnd = new Random();
            int width = rnd.Next(30, 100);
            int height = rnd.Next(30, 100);

            switch (selectedShape)
            {
                case "Ellipse":
                    shape = new Ellipse { Width = width, Height = height, Fill = color };
                    break;
                case "Circle":
                    int size = rnd.Next(30, 100);
                    shape = new Ellipse { Width = size, Height = size, Fill = color };
                    break;
                case "Rectangle":
                    shape = new Rectangle { Width = width, Height = height, Fill = color };
                    break;
                case "Square":
                    int squareSize = rnd.Next(30, 100);
                    shape = new Rectangle { Width = squareSize, Height = squareSize, Fill = color };
                    break;
                case "Line":
                    Line line = new Line
                    {
                        X1 = clickPosition.X,
                        Y1 = clickPosition.Y,
                        X2 = clickPosition.X + rnd.Next(50, 150),
                        Y2 = clickPosition.Y + rnd.Next(-50, 50),
                        Stroke = color,
                        StrokeThickness = 3
                    };
                    DrawingCanvas.Children.Add(line);
                    return;
            }

            if (shape != null)
            {
                Canvas.SetLeft(shape, clickPosition.X);
                Canvas.SetTop(shape, clickPosition.Y);
                DrawingCanvas.Children.Add(shape);
            }
        }

        private SolidColorBrush GetSelectedColor()
        {
            string colorName = (ColorComboBox.SelectedItem as ComboBoxItem)?.Content.ToString();
            switch (colorName)
            {
                case "Червоний": return Brushes.Red;
                case "Зелений": return Brushes.Green;
                case "Синій": return Brushes.Blue;
                case "Жовтий": return Brushes.Yellow;
                case "Фіолетовий": return Brushes.Purple;
                default: return Brushes.White;
            }
        }
    }
}
