using System;
using System.Threading;
using System.Diagnostics;

class Lab5
{
    static int n = 4;
    static double[,] A = new double[n, n];
    static double[] b = new double[n];
    static double[] x = new double[n];
    static double[] xNew = new double[n];
    static double eps = 0.0001;
    static int maxIter = 100;

    static void GenerateSystem()
    {
        Random rand = new Random();

        for (int i = 0; i < n; i++)
        {
            double sum = 0;
            for (int j = 0; j < n; j++)
            {
                if (i != j)
                {
                    A[i, j] = rand.Next(1, 5);
                    sum += Math.Abs(A[i, j]);
                }
            }
            A[i, i] = sum + rand.Next(5, 10);
            b[i] = rand.Next(10, 50);
            x[i] = 0;
        }

        Console.WriteLine("Матриця A та вектор b:");
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
                Console.Write($"{A[i, j],6:F1} ");
            Console.WriteLine($" | {b[i],6:F1}");
        }
        Console.WriteLine();
    }

    static void CalculateEquations(int start, int end)
    {
        for (int i = start; i < end; i++)
        {
            double sum = b[i];
            for (int j = 0; j < n; j++)
            {
                if (i != j)
                    sum -= A[i, j] * x[j];
            }
            xNew[i] = sum / A[i, i];
        }
    }

    static bool CheckConvergence()
    {
        for (int i = 0; i < n; i++)
            if (Math.Abs(xNew[i] - x[i]) > eps)
                return false;
        return true;
    }

    static void SolveWithThreads()
    {
        Console.WriteLine("=== РОЗВ'ЯЗАННЯ З 2 ПОТОКАМИ ===\n");

        for (int i = 0; i < n; i++)
            x[i] = 0;

        Stopwatch sw = Stopwatch.StartNew();
        int iter = 0;

        for (iter = 0; iter < maxIter; iter++)
        {
            Thread t1 = new Thread(() => CalculateEquations(0, 2));
            Thread t2 = new Thread(() => CalculateEquations(2, 4));

            t1.Start();
            t2.Start();

            t1.Join();
            t2.Join();

            if (CheckConvergence())
                break;

            for (int i = 0; i < n; i++)
                x[i] = xNew[i];
        }

        sw.Stop();

        Console.WriteLine($"Ітерацій: {iter + 1}");
        Console.WriteLine("Розв'язок:");
        for (int i = 0; i < n; i++)
            Console.WriteLine($"x[{i}] = {x[i]:F6}");
        Console.WriteLine($"\nЧас виконання: {sw.ElapsedMilliseconds} мс\n");
    }

    static void SolveWithoutThreads()
    {
        Console.WriteLine("=== РОЗВ'ЯЗАННЯ БЕЗ ПОТОКІВ ===\n");

        for (int i = 0; i < n; i++)
            x[i] = 0;

        Stopwatch sw = Stopwatch.StartNew();
        int iter = 0;

        for (iter = 0; iter < maxIter; iter++)
        {
            CalculateEquations(0, 4);

            if (CheckConvergence())
                break;

            for (int i = 0; i < n; i++)
                x[i] = xNew[i];
        }

        sw.Stop();

        Console.WriteLine($"Ітерацій: {iter + 1}");
        Console.WriteLine("Розв'язок:");
        for (int i = 0; i < n; i++)
            Console.WriteLine($"x[{i}] = {x[i]:F6}");
        Console.WriteLine($"\nЧас виконання: {sw.ElapsedMilliseconds} мс\n");
    }

    static void Main()
    {
        Console.WriteLine("Метод Якобі для СЛАР\n");

        GenerateSystem();
        SolveWithThreads();
        SolveWithoutThreads();

        Console.WriteLine("\nПеревірка (підставимо розв'язок в рівняння):");
        for (int i = 0; i < n; i++)
        {
            double sum = 0;
            for (int j = 0; j < n; j++)
                sum += A[i, j] * x[j];
            Console.WriteLine($"Рівняння {i + 1}: {sum:F4} ≈ {b[i]:F4} (похибка {Math.Abs(sum - b[i]):F6})");
        }
    }
}