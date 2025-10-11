using System;
using System.Threading;

class Lab6
{
    static double[,] A;
    static double[] b;
    static int n;

    static void Task1_GaussJordan()
    {
        Console.WriteLine("=== ЗАВДАННЯ 1: Метод Жордана-Гауса ===\n");

        n = 3;
        A = new double[,] { { 2, 1, -1 }, { -3, -1, 2 }, { -2, 1, 2 } };
        b = new double[] { 8, -11, -3 };

        Console.WriteLine("Початкова система:");
        PrintSystem();

        for (int k = 0; k < n; k++)
        {
            double pivot = A[k, k];
            for (int j = 0; j < n; j++)
                A[k, j] /= pivot;
            b[k] /= pivot;

            Thread[] threads = new Thread[n - 1];
            int threadIdx = 0;

            for (int i = 0; i < n; i++)
            {
                if (i != k)
                {
                    int row = i;
                    threads[threadIdx] = new Thread(() =>
                    {
                        double factor = A[row, k];
                        for (int j = 0; j < n; j++)
                            A[row, j] -= factor * A[k, j];
                        b[row] -= factor * b[k];
                    });
                    threads[threadIdx].Start();
                    threadIdx++;
                }
            }

            foreach (var t in threads)
                if (t != null) t.Join();
        }

        Console.WriteLine("\nРозв'язок:");
        for (int i = 0; i < n; i++)
            Console.WriteLine($"x[{i}] = {b[i]:F4}");
    }

    static void Task1_GaussJordan_N()
    {
        Console.WriteLine("\n\n=== ЗАВДАННЯ 1: Метод Жордана-Гауса (N=5) ===\n");

        n = 5;
        A = new double[n, n];
        b = new double[n];
        Random rand = new Random();

        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
                A[i, j] = rand.Next(1, 10);
            A[i, i] += 20;
            b[i] = rand.Next(10, 50);
        }

        Console.WriteLine("Початкова система:");
        PrintSystem();

        for (int k = 0; k < n; k++)
        {
            double pivot = A[k, k];
            for (int j = 0; j < n; j++)
                A[k, j] /= pivot;
            b[k] /= pivot;

            Thread[] threads = new Thread[n - 1];
            int threadIdx = 0;

            for (int i = 0; i < n; i++)
            {
                if (i != k)
                {
                    int row = i;
                    threads[threadIdx] = new Thread(() =>
                    {
                        double factor = A[row, k];
                        for (int j = 0; j < n; j++)
                            A[row, j] -= factor * A[k, j];
                        b[row] -= factor * b[k];
                    });
                    threads[threadIdx].Start();
                    threadIdx++;
                }
            }

            foreach (var t in threads)
                if (t != null) t.Join();
        }

        Console.WriteLine("\nРозв'язок:");
        for (int i = 0; i < n; i++)
            Console.WriteLine($"x[{i}] = {b[i]:F4}");
    }

    static void PrintSystem()
    {
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
                Console.Write($"{A[i, j],7:F2}");
            Console.WriteLine($" | {b[i],7:F2}");
        }
    }

    static double[] results = new double[10];

    static void Task2_Integral()
    {
        Console.WriteLine("\n\n=== ЗАВДАННЯ 2: Обчислення інтегралу (10 потоків) ===\n");
        Console.WriteLine("Інтеграл: ∫[0,10] x² dx\n");

        double a = 0, b = 10, h = 0.00001;
        int numThreads = 10;
        double segmentLength = (b - a) / numThreads;

        Thread[] threads = new Thread[numThreads];

        for (int i = 0; i < numThreads; i++)
        {
            int idx = i;
            double start = a + idx * segmentLength;
            double end = start + segmentLength;

            threads[i] = new Thread(() =>
            {
                double sum = 0, x = start;
                while (x < end)
                {
                    sum += x * x * h;
                    x += h;
                }
                results[idx] = sum;
                Console.WriteLine($"Потік {idx + 1}: [{start:F2}, {end:F2}] = {sum:F4}");
            });
            threads[i].Start();
        }

        foreach (var t in threads)
            t.Join();

        double total = 0;
        foreach (var r in results)
            total += r;

        double exact = Math.Pow(b, 3) / 3 - Math.Pow(a, 3) / 3;

        Console.WriteLine($"\nРезультат: {total:F6}");
        Console.WriteLine($"Точне значення: {exact:F6}");
        Console.WriteLine($"Похибка: {Math.Abs(total - exact):F6}");
    }

    static void Main()
    {
        Task1_GaussJordan();
        Task1_GaussJordan_N();
        Task2_Integral();
    }
}