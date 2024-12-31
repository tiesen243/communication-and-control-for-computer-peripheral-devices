using System;
using System.IO.Ports;
using System.Windows.Forms;

namespace sw
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            string[] ports = SerialPort.GetPortNames();
            comboBox_COMP.Items.AddRange(ports);
        }

        private void button_Connect_Click(object sender, EventArgs e)
        {
            if (comboBox_COMP.Text == "") MessageBox.Show("Please select a COM port", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            else
            {
                if (serialPort.IsOpen) MessageBox.Show("Port is already open", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                else
                {
                    try
                    {
                        serialPort.Open();
                        MessageBox.Show("Connection Opened", Text, MessageBoxButtons.OK, MessageBoxIcon.Information);
                        textBox_Status.Text = "Connected";
                        textBox_Status.BackColor = System.Drawing.Color.Green;
                    }
                    catch (Exception)
                    {
                        MessageBox.Show("Error opening connection", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
        }

        private void button_Disconnect_Click(object sender, EventArgs e)
        {
            if (serialPort.IsOpen)
            {
                serialPort.Close();
                MessageBox.Show("Connection Closed", Text, MessageBoxButtons.OK, MessageBoxIcon.Information);
                textBox_Status.Text = "Disconnected";
                textBox_Status.BackColor = System.Drawing.Color.Red;
            }
            else MessageBox.Show("Connection is already closed", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        private void checkBox_Control_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                if (serialPort.IsOpen)
                {
                    if (!checkBox_Control.Checked) serialPort.Write("U");
                    else serialPort.Write("C");
                }
                else MessageBox.Show("Connection is closed", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            catch (Exception)
            {
                MessageBox.Show("Error sending data", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button_mode_1_Click(object sender, EventArgs e)
        {
            try
            {
                if (serialPort.IsOpen) serialPort.Write("1");
                else MessageBox.Show("Connection is closed", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            catch (Exception)
            {
                MessageBox.Show("Error sending data", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button_mode_2_Click(object sender, EventArgs e)
        {
            try
            {
                if (serialPort.IsOpen) serialPort.Write("2");
                else MessageBox.Show("Connection is closed", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            catch (Exception)
            {
                MessageBox.Show("Error sending data", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button_mode_3_Click(object sender, EventArgs e)
        {
            try
            {
                if (serialPort.IsOpen) serialPort.Write("3");
                else MessageBox.Show("Connection is closed", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            catch (Exception)
            {
                MessageBox.Show("Error sending data", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void serialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            string data = serialPort.ReadExisting();
            this.Invoke(new EventHandler(delegate
            {
                if (data == "!")
                {
                    textBox_mode.Text = "Mode 1";
                }
                else if (data == "@")
                {
                    textBox_mode.Text = "Mode 2";
                }
                else if (data == "#")
                {
                    textBox_mode.Text = "Mode 3";
                }
            }));
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult result = MessageBox.Show("Do you want to close the connection?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
            if (result == DialogResult.Yes)
            {
                if (serialPort.IsOpen) serialPort.Close();
                e.Cancel = false;
            }
            else e.Cancel = true;
        }
    }
}
