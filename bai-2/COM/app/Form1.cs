using System;
using System.IO.Ports;
using System.Windows.Forms;

namespace app
{
    public partial class Form1 : Form
    {
        bool control_source = false;

        /*
         * true: auto mode
         * false: manual mode
         */

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            SetInitialControlState();

            string[] ports = SerialPort.GetPortNames();
            comboBox_COMP.Items.AddRange(ports);
        }

        private void comboBox_COMP_SelectedIndexChanged(object sender, EventArgs e)
        {
            serialPort.PortName = comboBox_COMP.Text;
            button_connect.Enabled = true;
        }

        private void button_connect_Click(object sender, EventArgs e)
        {
            try
            {
                serialPort.Open();
                control_source = false;
                update_checkbox(false);
                checkBox_control.Text = "Manual mode";

                SetInitialControlState(true);
                ShowConnectionMessage("Connection Opened");
            }
            catch (Exception)
            {
                MessageBox.Show(
                    "Error opening connection",
                    "Error",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error
                );
            }
        }

        private void button_disconnect_Click(object sender, EventArgs e)
        {
            serialPort.Close();
            control_source = false;
            update_checkbox(false);
            checkBox_control.Text = "No signal";

            SetInitialControlState(false);
            ShowConnectionMessage("Connection Closed");
        }

        private void checkBox_control_CheckedChanged(object sender, EventArgs e)
        {
            send_data("T");
        }

        private void button_mode_1_Click(object sender, EventArgs e)
        {
            send_data("1");
        }

        private void button_mode_2_Click(object sender, EventArgs e)
        {
            send_data("2");
        }

        private void button_mode_3_Click(object sender, EventArgs e)
        {
            send_data("3");
        }

        private void serialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            string data = serialPort.ReadExisting();
            this.Invoke(
                new EventHandler(
                    delegate
                    {
                        if (data == "A")
                        {
                            checkBox_control.Checked = true;
                            checkBox_control.Text = "Auto mode";
                            control_source = true;

                            button_mode_1.Enabled = true;
                            button_mode_2.Enabled = true;
                            button_mode_3.Enabled = true;
                        }
                        else if (data == "M")
                        {
                            checkBox_control.Checked = false;
                            checkBox_control.Text = "Manual mode";
                            control_source = false;

                            button_mode_1.Enabled = false;
                            button_mode_2.Enabled = false;
                            button_mode_3.Enabled = false;
                        }
                        else if (data == "U")
                        {
                            textBox_mode.Text = "1";
                        }
                        else if (data == "K")
                        {
                            textBox_mode.Text = "2";
                        }
                        else if (data == "I")
                        {
                            textBox_mode.Text = "3";
                        }
                        else if (data == "R")
                        {
                            pictureBox_led.Image = app.Properties.Resources.red;
                        }
                        else if (data == "Y")
                        {
                            pictureBox_led.Image = app.Properties.Resources.yellow;
                        }
                        else if (data == "G")
                        {
                            pictureBox_led.Image = app.Properties.Resources.green;
                        }
                        else if (data == "O")
                        {
                            pictureBox_led.Image = app.Properties.Resources.off;
                        }
                    }
                )
            );
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult result = MessageBox.Show(
                "Do you want to close the connection?",
                "Warning",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Warning
            );
            if (result == DialogResult.Yes)
            {
                if (serialPort.IsOpen)
                    serialPort.Close();

                e.Cancel = false;
            }
            else
            {
                e.Cancel = true;
            }
        }

        private void UpdateConnectionStatus(bool isConnected)
        {
            textBox_status.Text = isConnected ? "Connected" : "Disconnected";
            textBox_status.ForeColor = isConnected ? this.successColor : this.destructiveColor;
        }

        private void SetInitialControlState(bool isConnected = false)
        {
            button_disconnect.Enabled = isConnected;
            button_connect.Enabled = !isConnected && comboBox_COMP.SelectedItem != null;
            comboBox_COMP.Enabled = !isConnected;

            pictureBox_led.Image = app.Properties.Resources.off;
            checkBox_control.Enabled = isConnected;

            bool modeButtonsEnabled = isConnected && control_source;
            button_mode_1.Enabled = modeButtonsEnabled;
            button_mode_2.Enabled = modeButtonsEnabled;
            button_mode_3.Enabled = modeButtonsEnabled;

            UpdateConnectionStatus(isConnected);
        }

        private void ShowConnectionMessage(string message, bool isError = false)
        {
            MessageBox.Show(
                message,
                isError ? "Error" : Text,
                MessageBoxButtons.OK,
                isError ? MessageBoxIcon.Error : MessageBoxIcon.Information
            );
        }

        private void update_checkbox(bool value)
        {
            checkBox_control.CheckedChanged -= checkBox_control_CheckedChanged;
            checkBox_control.Checked = value;
            checkBox_control.CheckedChanged += new System.EventHandler(
                checkBox_control_CheckedChanged
            );
        }

        private void send_data(string data)
        {
            try
            {
                serialPort.Write(data);
            }
            catch (Exception)
            {
                MessageBox.Show(
                    "Error sending data",
                    "Error",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error
                );
            }
        }
    }
}
