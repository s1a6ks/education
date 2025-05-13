namespace kr
{
    public partial class Дарманський : Form
    {
        public Дарманський()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            FirstChildForm child1 = new();
            child1.MdiParent = this;
            child1.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            SecondChildForm child2 = new();
            child2.MdiParent = this;
            child2.Show();
        }

        private void HoretskyiForm_Load(object sender, EventArgs e)
        {

        }
    }
}
