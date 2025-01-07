using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ProgressBar;

namespace app
{
    public partial class Form1 : Form
    {
        bool is_physics_control = true;

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            string[] ports = SerialPort.GetPortNames();
            comboBox_COMP.Items.AddRange(ports);
        }

        private void comboBox_COMP_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (serialPort.IsOpen) MessageBox.Show("Please close the connection first", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            else serialPort.PortName = comboBox_COMP.Text;
        }

        private void button_connect_Click(object sender, EventArgs e)
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
                        checkBox_control.Checked = true;
                        checkBox_control.Text = "Allows physical control";
                        MessageBox.Show("Connection Opened", Text, MessageBoxButtons.OK, MessageBoxIcon.Information);
                        textBox_status.Text = "Connected";
                        textBox_status.BackColor = System.Drawing.Color.Green;
                    }
                    catch (Exception)
                    {
                        MessageBox.Show("Error opening connection", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
        }

        private void button_disconnect_Click(object sender, EventArgs e)
        {
            if (serialPort.IsOpen)
            {
                serialPort.Write("Y");
                checkBox_control.Checked = false;
                checkBox_control.Text = "No signal";
                serialPort.Close();
                MessageBox.Show("Connection Closed", Text, MessageBoxButtons.OK, MessageBoxIcon.Information);
                textBox_status.Text = "Disconnected";
                textBox_status.BackColor = System.Drawing.Color.Red;
            }
            else MessageBox.Show("Connection is already closed", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        private void checkBox_control_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                if (serialPort.IsOpen)
                {
                    if (checkBox_control.Checked) serialPort.Write("Y");
                    else serialPort.Write("N");
                }
                else
                {
                    checkBox_control.CheckedChanged -= checkBox_control_CheckedChanged;
                    checkBox_control.Checked = false;
                    checkBox_control.CheckedChanged += new System.EventHandler(this.checkBox_control_CheckedChanged);
                    MessageBox.Show("Connection is closed", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
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
                if (serialPort.IsOpen)
                {
                    if (!is_physics_control) serialPort.Write("1");
                    else MessageBox.Show("No software control allowed", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
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
                if (serialPort.IsOpen)
                {
                    if (!is_physics_control) serialPort.Write("2");
                    else MessageBox.Show("No software control allowed", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
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
                if (serialPort.IsOpen)
                {
                    if (!is_physics_control) serialPort.Write("3");
                    else MessageBox.Show("No software control allowed", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
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
                switch (data)
                {
                    case "E":
                        is_physics_control = true;
                        checkBox_control.Checked = true;
                        checkBox_control.Text = "Allows physical control";
                        break;
                    case "D":
                        is_physics_control = false;
                        checkBox_control.Checked = false;
                        checkBox_control.Text = "Does not allow physical controls";
                        break;
                    case "!":
                        textBox_mode.Text = "1";
                        break;
                    case "@":
                        textBox_mode.Text = "2";
                        break;
                    case "#":
                        textBox_mode.Text = "3";
                        break;
                }
            }));
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult result = MessageBox.Show("Do you want to close the connection?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
            if (result == DialogResult.Yes)
            {
                if (serialPort.IsOpen)
                {
                    serialPort.Write("Y");
                    serialPort.Close();
                }
                e.Cancel = false;
            }
            else e.Cancel = true;
        }
    }
}
