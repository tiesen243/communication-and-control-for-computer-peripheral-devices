using System;
using System.IO.Ports;
using System.Windows.Forms;

namespace app
{
    public partial class Form1 : Form
    {
        bool control_source = false;
        bool is_night_mode = false;

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

        /* ------------------------- START: Connect / Disconnect  Handlers ------------------------- */

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
                textBox_status.Text = "Connected";
                textBox_status.ForeColor = this.successColor;
                button_connect.Enabled = false;
                button_disconnect.Enabled = true;
                send_data(SEND_MSG[6].ToString());

                checkBox_control.Enabled = true;

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
                textBox_status.Text = "Disconnected";
                textBox_status.ForeColor = this.destructiveColor;
                button_connect.Enabled = true;
                button_disconnect.Enabled = false;

                update_checkbox(false);
                checkBox_control.Enabled = false;
                checkBox_control.Text = "No Signal";

                button_mode_1.Enabled = false;
                button_mode_2.Enabled = false;
                button_mode_3.Enabled = false;

                ShowConnectionMessage("Connection Closed");
            }
            catch (Exception)
            {
                ShowConnectionMessage("Error closing connection", true);
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

        /* ------------------------- END: Connect / Disconnect  Handlers ------------------------- */

        /* ------------------------- START: Control Handlers ------------------------- */

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

            if ((date.Hour >= 23 || date.Hour < 5) && !is_night_mode)
            {
                send_data(SEND_MSG[5].ToString());
                is_night_mode = true;
            }
            else if ((date.Hour < 23 && date.Hour >= 5) && is_night_mode)
            {
                send_data(SEND_MSG[4].ToString());
                is_night_mode = false;
            }
        }

        /* ------------------------- END: Control Handlers ------------------------- */

        /* ------------------------- Data Received Handler ------------------------- */
        private void serialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            string data = serialPort.ReadExisting();
            this.Invoke(
                new EventHandler(
                    delegate
                    {
                        if (data == RECEIVE_MSG[8].ToString())
                        {
                            update_checkbox(true);
                            control_source = true;

                            button_mode_1.Enabled = true;
                            button_mode_2.Enabled = true;
                            button_mode_3.Enabled = true;
                        }
                        else if (data == RECEIVE_MSG[7].ToString())
                        {
                            update_checkbox(false);
                            control_source = false;

                            button_mode_1.Enabled = false;
                            button_mode_2.Enabled = false;
                            button_mode_3.Enabled = false;
                        }
                        else if (data == RECEIVE_MSG[0].ToString())
                        {
                            button_mode_1.BackColor = activeColor;
                            button_mode_2.BackColor = primaryColor;
                            button_mode_3.BackColor = primaryColor;
                        }
                        else if (data == RECEIVE_MSG[1].ToString())
                        {
                            button_mode_1.BackColor = primaryColor;
                            button_mode_2.BackColor = activeColor;
                            button_mode_3.BackColor = primaryColor;
                        }
                        else if (data == RECEIVE_MSG[2].ToString())
                        {
                            button_mode_1.BackColor = primaryColor;
                            button_mode_2.BackColor = primaryColor;
                            button_mode_3.BackColor = activeColor;
                        }
                        else if (data == RECEIVE_MSG[3].ToString())
                        {
                            pictureBox_led.Image = app.Properties.Resources.red;
                        }
                        else if (data == RECEIVE_MSG[6].ToString())
                        {
                            pictureBox_led.Image = app.Properties.Resources.yellow;
                        }
                        else if (data == RECEIVE_MSG[4].ToString())
                        {
                            pictureBox_led.Image = app.Properties.Resources.green;
                        }
                        else if (data == RECEIVE_MSG[5].ToString())
                        {
                            pictureBox_led.Image = app.Properties.Resources.off;
                        }
                    }
                )
            );
        }

        /* ------------------------- START: Helper Functions ------------------------- */

        private void update_checkbox(bool value)
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

        /* ------------------------- END: Helper Functions ------------------------- */
    }
}
