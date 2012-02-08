using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO.Ports;

namespace OSD
{
    public partial class DTR : Form
    {
        SerialPort sp;

        public DTR()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            sp = new SerialPort();
            sp.BaudRate = 57600;
            sp.PortName = textBox1.Text;

            sp.DtrEnable = true;
            sp.RtsEnable = false;

            sp.Open();
            Console.WriteLine("Open dtr");

            System.Threading.Thread.Sleep(2000);

            sp.Close();
            Console.WriteLine("Close");
        }

        private void button3_Click(object sender, EventArgs e)
        {
            sp = new SerialPort();
            sp.BaudRate = 57600;
            sp.PortName = textBox1.Text;

            sp.DtrEnable = true;
            sp.RtsEnable = true;

            sp.Open();
            Console.WriteLine("Open dtr rts");

            System.Threading.Thread.Sleep(2000);

            sp.Close();
            Console.WriteLine("Close");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            sp = new SerialPort();
            sp.BaudRate = 57600;
            sp.PortName = textBox1.Text;

            sp.DtrEnable = false;
            sp.RtsEnable = true;

            sp.Open();
            Console.WriteLine("Open rts");

            System.Threading.Thread.Sleep(2000);

            sp.Close();
            Console.WriteLine("Close");
        }

        private void button4_Click(object sender, EventArgs e)
        {
            sp = new SerialPort();
            sp.BaudRate = 57600;
            sp.PortName = textBox1.Text;

            sp.DtrEnable = false;
            sp.RtsEnable = false;

            sp.Open();
            Console.WriteLine("Open");

            System.Threading.Thread.Sleep(2000);

            sp.Close();
            Console.WriteLine("Close");
        }
    }
}
