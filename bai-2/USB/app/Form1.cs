using System;
using System.IO.Ports;
using System.Windows.Forms;

namespace app
{
    public partial class Form1 : Form
    {
        bool is_physics_control = true;

        public Form1()
        {
            InitializeComponent();
            pictureBox_led.Image = app.Properties.Resources.off;
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
                        checkBox_control.CheckedChanged -= checkBox_control_CheckedChanged;
                        checkBox_control.Checked = false;
                        checkBox_control.CheckedChanged += new System.EventHandler(this.checkBox_control_CheckedChanged);
                        checkBox_control.Text = "Manual mode";
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
                serialPort.Write("Z");
                is_physics_control = true;
                checkBox_control.CheckedChanged -= checkBox_control_CheckedChanged;
                checkBox_control.Checked = false;
                checkBox_control.CheckedChanged += new System.EventHandler(this.checkBox_control_CheckedChanged);
                checkBox_control.Text = "Manual mode";
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
                    if (checkBox_control.Checked)
                    {
                        serialPort.Write("X");
                        is_physics_control = false;
                        checkBox_control.Text = "Auto mode";
                    }
                    else
                    {
                        serialPort.Write("Z");
                        is_physics_control = true;
                        checkBox_control.Text = "Manual mode";
                    }
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
                    else MessageBox.Show("Can not control in manual mode", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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
                    else MessageBox.Show("Can not control in manual mode", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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
                    else MessageBox.Show("Can not control in manual mode", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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
                        checkBox_control.Checked = false;
                        checkBox_control.Text = "Manual mode";
                        break;
                    case "D":
                        is_physics_control = false;
                        checkBox_control.Checked = true;
                        checkBox_control.Text = "Auto mode";
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
                    case "R":
                        pictureBox_led.Image = app.Properties.Resources.red;
                        break;
                    case "Y":
                        pictureBox_led.Image = app.Properties.Resources.yellow;
                        break;
                    case "G":
                        pictureBox_led.Image = app.Properties.Resources.green;
                        break;
                    case "O":
                        pictureBox_led.Image = app.Properties.Resources.off;
                        break;
                    default:
                        checkBox_control.Checked = false;
                        is_physics_control = true;
                        checkBox_control.Text = "Manual mode";
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
                    serialPort.Write("Z");
                    serialPort.Close();
                }
                e.Cancel = false;
            }
            else e.Cancel = true;
        }
    }
}
