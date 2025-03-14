using System;
using System.Windows.Forms;
using UsbLibrary;

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
        private static readonly char[] SEND_MSG = { '1', '2', '3', 'T', 'D', 'N', 'I', 'S' };

        // State tracking
        private bool controlSource = false;
        private bool isNightMode = false;

        byte[] readbuff = new byte[8];
        byte[] writebuff = new byte[8];

        #endregion


        #region Initialization

        public Form1()
        {
            InitializeComponent();

            this.BackColor = this.backgroundColor;
            this.ForeColor = this.foregroundColor;

            this.textBox_status.ForeColor = this.destructiveColor;
            this.textBox_status.BackColor = this.backgroundColor;

            this.button_submitTime.BackColor = this.primaryColor;
            this.button_submitTime.ForeColor = this.primaryForegroundColor;

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
            usbHidPort.VendorId = 0x04D8;
            usbHidPort.ProductId = 0x0001;
            usbHidPort.CheckDevicePresent();

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
                e.Cancel = false;
            else
                e.Cancel = true;
        }

        #endregion


        #region Connection Management

        private void usbHidPort_OnSpecifiedDeviceArrived(object sender, EventArgs e)
        {
            UpdateConnectionStatus(true);
            send_data(SEND_MSG[6].ToString());
            textBox_redTime.Text = "05";
            textBox_yellowTime.Text = "03";
            textBox_greenTime.Text = "10";
        }

        private void usbHidPort_OnSpecifiedDeviceRemoved(object sender, EventArgs e)
        {
            if (InvokeRequired)
                Invoke(
                    new EventHandler(usbHidPort_OnSpecifiedDeviceRemoved),
                    new object[] { sender, e }
                );
            else
                UpdateConnectionStatus(false);
        }

        private void usbHidPort_OnDeviceArrived(object sender, EventArgs e) { }

        private void usbHidPort_OnDeviceRemoved(object sender, EventArgs e) { }

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

        private void button_submitTime_Click(object sender, EventArgs e)
        {
            try
            {
                if (usbHidPort.SpecifiedDevice == null)
                    return;

                if (
                    !TryParseTimeInput(textBox_redTime.Text, out byte redDigit1, out byte redDigit2)
                    || !TryParseTimeInput(
                        textBox_yellowTime.Text,
                        out byte yellowDigit1,
                        out byte yellowDigit2
                    )
                    || !TryParseTimeInput(
                        textBox_greenTime.Text,
                        out byte greenDigit1,
                        out byte greenDigit2
                    )
                )
                {
                    MessageBox.Show(
                        "Invalid time format. Please enter two-digit numbers.",
                        "Input Error",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Error
                    );
                    return;
                }

                writebuff = new byte[]
                {
                    0,
                    writebuff[0],
                    redDigit1,
                    redDigit2,
                    yellowDigit1,
                    yellowDigit2,
                    greenDigit1,
                    greenDigit2,
                };

                usbHidPort.SpecifiedDevice.SendData(writebuff);

                MessageBox.Show(
                    "Time settings submitted successfully",
                    "Success",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Information
                );
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

        private void timer_Tick(object sender, EventArgs e)
        {
            DateTime date = DateTime.Now;

            clock.Text = date.ToString();

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

        private void usbHidPort_OnDataRecieved(object sender, DataRecievedEventArgs args)
        {
            byte data = args.data[1];
            if (data == RECEIVE_MSG[8])
            {
                this.updateControl(true);
            }
            else if (data == RECEIVE_MSG[7])
            {
                this.updateControl(false);
            }
            else if (data == RECEIVE_MSG[0])
            {
                this.updateButton(1);
            }
            else if (data == RECEIVE_MSG[1])
            {
                this.updateButton(2);
            }
            else if (data == RECEIVE_MSG[2])
            {
                this.updateButton(3);
            }
            else
            {
                this.UpdateLedStatus(data);
            }
        }

        private void updateControl(bool value)
        {
            if (this.InvokeRequired)
            {
                this.Invoke(new Action<bool>(updateControl), value);
            }
            else
            {
                updateCheckbox(value);
                controlSource = value;

                button_mode_1.Enabled = value;
                button_mode_2.Enabled = value;
                button_mode_3.Enabled = value;
            }
        }

        private void updateButton(int index)
        {
            button_mode_1.BackColor = index == 1 ? activeColor : primaryColor;
            button_mode_2.BackColor = index == 2 ? activeColor : primaryColor;
            button_mode_3.BackColor = index == 3 ? activeColor : primaryColor;
        }

        private void UpdateLedStatus(byte data)
        {
            if (data == RECEIVE_MSG[3])
                pictureBox_led.Image = Properties.Resources.red;
            else if (data == RECEIVE_MSG[6])
                pictureBox_led.Image = Properties.Resources.yellow;
            else if (data == RECEIVE_MSG[4])
                pictureBox_led.Image = Properties.Resources.green;
            else if (data == RECEIVE_MSG[5])
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
                checkBox_control.Enabled = true;
                button_submitTime.Enabled = true;
            }
            else
            {
                textBox_status.Text = "Disconnected";
                textBox_status.ForeColor = destructiveColor;

                updateCheckbox(false);
                checkBox_control.Enabled = false;
                checkBox_control.Text = "No Signal";
                button_submitTime.Enabled = false;

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
            if (checkBox_control.InvokeRequired)
            {
                checkBox_control.Invoke(new Action<bool>(updateCheckbox), value);
            }
            else
            {
                checkBox_control.CheckedChanged -= checkBox_control_CheckedChanged;
                checkBox_control.Checked = value;
                checkBox_control.Text = value ? "Auto Control" : "Manual Control";
                checkBox_control.CheckedChanged += new System.EventHandler(
                    checkBox_control_CheckedChanged
                );
            }
        }

        private void validateTextBox(object sender, KeyPressEventArgs e)
        {
            // Allow only digits, backspace, and delete
            if (
                !char.IsDigit(e.KeyChar)
                && e.KeyChar != (char)Keys.Back
                && e.KeyChar != (char)Keys.Delete
            )
            {
                e.Handled = true;
                return;
            }

            // If the input is a digit, check if it would make the value exceed 99
            if (char.IsDigit(e.KeyChar))
            {
                TextBox textBox = (TextBox)sender;
                string potentialValue = textBox.Text;

                // If the cursor is not at the end, insert the character at the right position
                if (textBox.SelectionLength > 0)
                {
                    potentialValue = potentialValue.Remove(
                        textBox.SelectionStart,
                        textBox.SelectionLength
                    );
                }
                potentialValue = potentialValue.Insert(
                    textBox.SelectionStart,
                    e.KeyChar.ToString()
                );

                // Try to parse the potential value
                if (int.TryParse(potentialValue, out int value))
                {
                    // Reject if the value is out of range (1-99)
                    if (value < 1 || value > 99)
                    {
                        e.Handled = true;
                    }
                }
            }
        }

        private void formatTextBox(object sender, EventArgs e)
        {
            TextBox textBox = (TextBox)sender;
            if (string.IsNullOrWhiteSpace(textBox.Text))
                return;

            if (int.TryParse(textBox.Text, out int value))
            {
                // Ensure value is between 1 and 99
                value = Math.Max(1, Math.Min(99, value));

                // Format with leading zero if less than 10
                if (value < 10)
                    textBox.Text = "0" + value;
                else
                    textBox.Text = value.ToString();
            }
        }

        private bool TryParseTimeInput(string input, out byte firstDigit, out byte secondDigit)
        {
            firstDigit = secondDigit = 0;

            if (
                string.IsNullOrEmpty(input)
                || input.Length != 2
                || !char.IsDigit(input[0])
                || !char.IsDigit(input[1])
            )
                return false;

            firstDigit = (byte)input[0];
            secondDigit = (byte)input[1];
            return true;
        }

        private void send_data(string data)
        {
            try
            {
                if (usbHidPort.SpecifiedDevice == null)
                    return;

                writebuff[1] = (byte)data[0];
                usbHidPort.SpecifiedDevice.SendData(writebuff);
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

        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);
            usbHidPort.RegisterHandle(Handle);
        }

        protected override void WndProc(ref Message m)
        {
            base.WndProc(ref m);
            usbHidPort.ParseMessages(ref m);
        }

        #endregion
    }
}
