using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO.Ports;
using ArdupilotMega;

namespace OSD
{
    public partial class DTR : Form
    {
        ArduinoSTK sp = new ArduinoSTK();

        public DTR()
        {
            InitializeComponent();
        }

        void ser(ArduinoSTK sp)
        {
            if (sp.connectAP())
            {
                try
                {
                    byte[] test = sp.download(1024);
                    Console.WriteLine("Download OK!!");
                } catch (Exception ex) {
                    Console.WriteLine(ex.Message);
                }
            }
            else
            {
                Console.WriteLine("Failed connect");
            }

            //System.Threading.Thread.Sleep(2000);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            sp = new ArduinoSTK();
            sp.BaudRate = 57600;
            sp.PortName = textBox1.Text;

            sp.DtrEnable = true;
            sp.RtsEnable = false;

            sp.Open();
            Console.WriteLine("Open dtr");

            ser(sp);

            sp.Close();
            Console.WriteLine("Close");
        }

        private void button3_Click(object sender, EventArgs e)
        {
            sp = new ArduinoSTK();
            sp.BaudRate = 57600;
            sp.PortName = textBox1.Text;

            sp.DtrEnable = true;
            sp.RtsEnable = true;

            sp.Open();
            Console.WriteLine("Open dtr rts");

            ser(sp);

            sp.Close();
            Console.WriteLine("Close");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            sp = new ArduinoSTK();
            sp.BaudRate = 57600;
            sp.PortName = textBox1.Text;

            sp.DtrEnable = false;
            sp.RtsEnable = true;

            sp.Open();
            Console.WriteLine("Open rts");

            ser(sp);

            sp.Close();
            Console.WriteLine("Close");
        }

        private void button4_Click(object sender, EventArgs e)
        {
            sp = new ArduinoSTK();
            sp.BaudRate = 57600;
            sp.PortName = textBox1.Text;

            sp.DtrEnable = false;
            sp.RtsEnable = false;

            sp.Open();
            Console.WriteLine("Open");

            ser(sp);

            sp.Close();
            Console.WriteLine("Close");
        }

        private void button5_Click(object sender, EventArgs e)
        {
            sp.DtrEnable = !sp.DtrEnable;
            Console.WriteLine("DTR " + sp.DtrEnable);
        }

        private void button6_Click(object sender, EventArgs e)
        {
            sp.RtsEnable = !sp.RtsEnable;
            Console.WriteLine("RTS "+ sp.RtsEnable);

        }

        private void button7_Click(object sender, EventArgs e)
        {
            if (sp.IsOpen)
                sp.Close();

            Console.WriteLine("DTR " + sp.DtrEnable + " RTS " + sp.RtsEnable);

            sp.BaudRate = 57600;
            sp.PortName = textBox1.Text;

            sp.Open();
            Console.WriteLine("Open");

            ser(sp);
        }
    }
}
