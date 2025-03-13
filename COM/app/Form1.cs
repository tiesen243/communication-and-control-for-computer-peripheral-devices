using System;
using System.IO.Ports;
using System.Windows.Forms;

namespace app
{
    public partial class Form1 : Form
    {
        #region Constants and Fields

        // Communication constants
        private static readonly char[] RECEIVE_MSG =
        {
            'K',
            'Z',
            'E',
            'R',
            'G',
            'O',
            'Y',
            'M',
            'A',
        };
        private static readonly char[] SEND_MSG = { '1', '2', '3', 'T', 'D', 'N', 'I' };

        // State tracking
        private bool controlSource = false;
        private bool isNightMode = false;

        #endregion


        #region Initialization

        public Form1()
        {
            InitializeComponent();

            this.textBox_status.ForeColor = this.destructiveColor;
            this.textBox_status.BackColor = this.backgroundColor;

            this.button_connect.BackColor = this.successColor;
            this.button_connect.ForeColor = this.primaryForegroundColor;

            this.button_disconnect.BackColor = this.destructiveColor;
            this.button_disconnect.ForeColor = this.primaryForegroundColor;

            this.button_mode_1.BackColor = this.primaryColor;
            this.button_mode_1.ForeColor = this.primaryForegroundColor;

            this.button_mode_2.BackColor = this.primaryColor;
            this.button_mode_2.ForeColor = this.primaryForegroundColor;

            this.button_mode_3.BackColor = this.primaryColor;
            this.button_mode_3.ForeColor = this.primaryForegroundColor;

            this.pictureBox_led.Image = app.Properties.Resources.off;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            string[] ports = SerialPort.GetPortNames();
            comboBox_COMP.Items.AddRange(ports);

            timer.Start();
        }

        #endregion


        #region Form Events

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

        #endregion


        #region Connection Management

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
                UpdateConnectionStatus(true);
                send_data(SEND_MSG[6].ToString());
                ShowConnectionMessage("Connection Opened");
            }
            catch (Exception)
            {
                ShowConnectionMessage("Error opening connection", true);
            }
        }

        private void button_disconnect_Click(object sender, EventArgs e)
        {
            try
            {
                serialPort.Close();
                UpdateConnectionStatus(false);
                ShowConnectionMessage("Connection Closed");
            }
            catch (Exception)
            {
                ShowConnectionMessage("Error closing connection", true);
            }
        }

        #endregion


        #region Control Functions

        private void checkBox_control_CheckedChanged(object sender, EventArgs e)
        {
            send_data(SEND_MSG[3].ToString());
        }

        private void button_mode_1_Click(object sender, EventArgs e)
        {
            send_data(SEND_MSG[0].ToString());
        }

        private void button_mode_2_Click(object sender, EventArgs e)
        {
            send_data(SEND_MSG[1].ToString());
        }

        private void button_mode_3_Click(object sender, EventArgs e)
        {
            send_data(SEND_MSG[2].ToString());
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            DateTime date = DateTime.Now;

            clock.Text = date.ToString();

            if (!serialPort.IsOpen)
                return;

            bool shouldBeNightMode = date.Hour >= 23 || date.Hour < 5;

            if (shouldBeNightMode && !isNightMode)
            {
                send_data(SEND_MSG[5].ToString());
                isNightMode = true;
            }
            else if (!shouldBeNightMode && isNightMode)
            {
                send_data(SEND_MSG[4].ToString());
                isNightMode = false;
            }
        }

        #endregion


        #region Communication

        private void serialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            string data = serialPort.ReadExisting();
            this.Invoke(
                new EventHandler(
                    delegate
                    {
                        if (data == RECEIVE_MSG[8].ToString())
                        {
                            this.updateControl(true);
                        }
                        else if (data == RECEIVE_MSG[7].ToString())
                        {
                            this.updateControl(false);
                        }
                        else if (data == RECEIVE_MSG[0].ToString())
                        {
                            this.updateButton(1);
                        }
                        else if (data == RECEIVE_MSG[1].ToString())
                        {
                            this.updateButton(2);
                        }
                        else if (data == RECEIVE_MSG[2].ToString())
                        {
                            this.updateButton(3);
                        }
                        else
                        {
                            this.UpdateLedStatus(data);
                        }
                    }
                )
            );
        }

        private void updateControl(bool value)
        {
            updateCheckbox(value);
            controlSource = value;

            button_mode_1.Enabled = value;
            button_mode_2.Enabled = value;
            button_mode_3.Enabled = value;
        }

        private void updateButton(int index)
        {
            button_mode_1.BackColor = index == 1 ? activeColor : primaryColor;
            button_mode_2.BackColor = index == 2 ? activeColor : primaryColor;
            button_mode_3.BackColor = index == 3 ? activeColor : primaryColor;
        }

        private void UpdateLedStatus(string data)
        {
            if (data == RECEIVE_MSG[3].ToString())
                pictureBox_led.Image = Properties.Resources.red;
            else if (data == RECEIVE_MSG[6].ToString())
                pictureBox_led.Image = Properties.Resources.yellow;
            else if (data == RECEIVE_MSG[4].ToString())
                pictureBox_led.Image = Properties.Resources.green;
            else if (data == RECEIVE_MSG[5].ToString())
                pictureBox_led.Image = Properties.Resources.off;
        }

        #endregion


        #region Helper Methods

        private void UpdateConnectionStatus(bool connected)
        {
            if (connected)
            {
                textBox_status.Text = "Connected";
                textBox_status.ForeColor = successColor;
                button_connect.Enabled = false;
                button_disconnect.Enabled = true;
                checkBox_control.Enabled = true;
            }
            else
            {
                textBox_status.Text = "Disconnected";
                textBox_status.ForeColor = destructiveColor;
                button_connect.Enabled = true;
                button_disconnect.Enabled = false;

                updateCheckbox(false);
                checkBox_control.Enabled = false;
                checkBox_control.Text = "No Signal";

                button_mode_1.Enabled = false;
                button_mode_2.Enabled = false;
                button_mode_3.Enabled = false;
            }
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

        private void updateCheckbox(bool value)
        {
            checkBox_control.CheckedChanged -= checkBox_control_CheckedChanged;
            checkBox_control.Checked = value;
            checkBox_control.Text = value ? "Auto Control" : "Manual Control";
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

        #endregion
    }
}
