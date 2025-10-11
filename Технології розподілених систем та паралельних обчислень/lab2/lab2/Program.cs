using System;
using System.Threading;

class Lab2
{
    static int[,] A = new int[4, 4];
    static int[,] B = new int[4, 4];
    static int[,] C = new int[4, 4];
    static double[] results = new double[4];

    static void Task1_MatrixMultiplication()
    {
        Random rand = new Random();
        Console.WriteLine("ЗАВДАННЯ 1: Множення матриць 4×4\n");

        for (int i = 0; i < 4; i++)
            for (int j = 0; j < 4; j++)
            {
                A[i, j] = rand.Next(1, 11);
                B[i, j] = rand.Next(1, 11);
            }

        Console.WriteLine("Матриця A:");
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
                Console.Write($"{A[i, j],4}");
            Console.WriteLine();
        }

        Console.WriteLine("\nМатриця B:");
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
                Console.Write($"{B[i, j],4}");
            Console.WriteLine();
        }

        Thread[] threads = new Thread[4];
        for (int i = 0; i < 4; i++)
        {
            int row = i;
            threads[i] = new Thread(() =>
            {
                for (int j = 0; j < 4; j++)
                {
                    int sum = 0;
                    for (int k = 0; k < 4; k++)
                        sum += A[row, k] * B[k, j];
                    C[row, j] = sum;
                }
            });
            threads[i].Start();
        }

        for (int i = 0; i < 4; i++)
            threads[i].Join();

        Console.WriteLine("\nМатриця C (A × B):");
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
                Console.Write($"{C[i, j],4}");
            Console.WriteLine();
        }
    }

    static void Task2_Integral()
    {
        Console.WriteLine("\n\nЗАВДАННЯ 2: Інтеграл ∫[0,2] x² dx\n");

        double step1 = 0.0000001;
        double step2 = step1 / 2;
        double exact = 8.0 / 3.0;

        Console.WriteLine($"Точне значення: {exact:F10}");

        Thread[] threads = new Thread[4];
        for (int i = 0; i < 4; i++)
        {
            int idx = i;
            threads[i] = new Thread(() =>
            {
                double sum = 0;
                double x = idx * 0.5;
                while (x < (idx + 1) * 0.5)
                {
                    sum += x * x * step1;
                    x += step1;
                }
                results[idx] = sum;
            });
            threads[i].Start();
        }

        for (int i = 0; i < 4; i++)
            threads[i].Join();

        double i1 = 0;
        for (int i = 0; i < 4; i++)
            i1 += results[i];

        Console.WriteLine($"Результат 1 (h={step1}): {i1:F10}");

        for (int i = 0; i < 4; i++)
        {
            int idx = i;
            threads[i] = new Thread(() =>
            {
                double sum = 0;
                double x = idx * 0.5;
                while (x < (idx + 1) * 0.5)
                {
                    sum += x * x * step2;
                    x += step2;
                }
                results[idx] = sum;
            });
            threads[i].Start();
        }

        for (int i = 0; i < 4; i++)
            threads[i].Join();

        double i2 = 0;
        for (int i = 0; i < 4; i++)
            i2 += results[i];

        Console.WriteLine($"Результат 2 (h={step2}): {i2:F10}");
        Console.WriteLine($"Різниця: {Math.Abs(i1 - i2):F15}");
    }

    static void Main()
    {
        Task1_MatrixMultiplication();
        Task2_Integral();
    }
}