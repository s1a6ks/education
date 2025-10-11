/*Console.OutputEncoding = System.Text.Encoding.UTF8;


Console.WriteLine("Лабораторна робота № 1");

Thread secondThread = new Thread(() =>
{
    Thread.Sleep(5000);
    Console.WriteLine("Рік навчання: 3 курс");
    Console.WriteLine("Студент: Горецький Максим");
});

secondThread.Start();
secondThread.Join();

Console.WriteLine("Перше завдання виконав.");
Console.ReadLine();


Console.OutputEncoding = System.Text.Encoding.UTF8;*/

/*string[] words = { "я", "люблю", "Україну!" };


Thread t1 = new Thread(() => { Thread.Sleep(0); Console.WriteLine(words[0]); });
Thread t2 = new Thread(() => { Thread.Sleep(2000); Console.WriteLine(words[1]); });

t1.Start();
t2.Start();


Thread.Sleep(500);
Console.WriteLine(words[2]);

t1.Join();
t2.Join();
Console.ReadLine();*/




Random rnd = new Random();
int[] array = new int[20];
for (int i = 0; i < array.Length; i++)
    array[i] = rnd.Next(-10, 11);

Console.WriteLine("Масив: " + string.Join(", ", array));

int max1 = int.MinValue;
int max2 = int.MinValue;

Thread t1 = new Thread(() =>
{
    for (int i = 0; i < array.Length / 2; i++)
        if (array[i] > max1) max1 = array[i];
});

Thread t2 = new Thread(() =>
{
    for (int i = array.Length - 1; i >= array.Length / 2; i--)
        if (array[i] > max2) max2 = array[i];
});

t1.Start();
t2.Start();

t1.Join();
t2.Join();

int maxValue = Math.Max(max1, max2);
Console.WriteLine("Максимальний елемент масиву: " + maxValue);

Console.ReadLine();