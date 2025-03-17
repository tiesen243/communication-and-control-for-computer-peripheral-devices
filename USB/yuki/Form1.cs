using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Windows.Forms;
using UsbLibrary;

namespace yuki
{
    public enum ControlSource
    {
        Auto,
        Manual,
    }

    public enum Mode
    {
        Mode1,
        Mode2,
        Mode3,
        Night,
        Day,
    }

    public partial class Yuki : System.Windows.Forms.Form
    {
        #region Initialization

        private ControlSource controlSource = ControlSource.Manual;
        private Mode mode = Mode.Mode1;
        private Mode timeMode = Mode.Day;

        private readonly char[] RECEIVE_MSGS = { 'M', 'A', 'R', 'O', 'Y', 'G', 'E', 'S' };
        private readonly char[] SEND_MSGS = { 'T', 'D', 'N', 'I', 'S' };

        byte[] readbuff = new byte[8];
        byte[] writebuff = new byte[8];

        public Yuki()
        {
            InitializeComponent();
            pictureBox_led_status.Image = Properties.Resources.off;

            this.BackColor = backgroundColor;
            this.ForeColor = foregroundColor;
            StyleButton(button_save_time, primaryColor);
            StyleButton(button_mode_1, primaryColor);
            StyleButton(button_mode_2, primaryColor);
            StyleButton(button_mode_3, primaryColor);
            StyleButton(button_control_state, primaryColor);
            StyleInput(textBox_red_value);
            StyleInput(textBox_yellow_value);
            StyleInput(textBox_green_value);
        }

        private void Yuki_Load(object sender, EventArgs e)
        {
            timer.Start();
            usbHidPort.VendorId = 0x04D8;
            usbHidPort.ProductId = 0x0001;
            usbHidPort.RegisterHandle(this.Handle);
            usbHidPort.CheckDevicePresent();
        }

        private void Yuki_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult dialogResult = MessageBox.Show(
                "Are you sure you want to exit?",
                "Exit",
                MessageBoxButtons.YesNo
            );
            if (dialogResult == DialogResult.No)
                e.Cancel = true;
            else
                e.Cancel = false;
        }

        #endregion


        #region Connectivity


        private void usbHidPort_OnSpecifiedDeviceArrived(object sender, EventArgs e)
        {
            label_status.Text = "Connected";
            label_status.ForeColor = connectedColor;

            button_control_state.Enabled = true;
            button_control_state.Text = "Manual";

            toggle(true);

            sendMsg(SEND_MSGS[3]);
        }

        private void usbHidPort_OnSpecifiedDeviceRemoved(object sender, EventArgs e)
        {
            if (InvokeRequired)
                Invoke(
                    new EventHandler(usbHidPort_OnSpecifiedDeviceRemoved),
                    new object[] { sender, e }
                );
            else
            {
                label_status.Text = "Disconnected";
                label_status.ForeColor = disconnectedColor;

                button_control_state.Enabled = false;
                button_control_state.Text = "No Signal";

                toggle(false);
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

        private void usbHidPort_OnDeviceArrived(object sender, EventArgs e) { }

        private void usbHidPort_OnDeviceRemoved(object sender, EventArgs e) { }

        #endregion


        #region Communication

        private void sendMsg(char msg)
        {
            try
            {
                if (usbHidPort.SpecifiedDevice == null)
                    return;

                writebuff[1] = (byte)msg;
                usbHidPort.SpecifiedDevice.SendData(writebuff);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK);
            }
        }

        private void usbHidPort_OnDataRecieved(object sender, UsbLibrary.DataRecievedEventArgs args)
        {
            char data = (char)args.data[1];

            if (InvokeRequired)
            {
                Invoke(
                    new EventHandler<UsbLibrary.DataRecievedEventArgs>(usbHidPort_OnDataRecieved),
                    new object[] { sender, args }
                );
                return;
            }

            if (data == RECEIVE_MSGS[0])
            {
                button_control_state.Text = "Manual";
                controlSource = ControlSource.Manual;
                toggle(true);
            }
            else if (data == RECEIVE_MSGS[1])
            {
                button_control_state.Text = "Auto";
                controlSource = ControlSource.Auto;
                toggle(true);
            }
            else if (data == RECEIVE_MSGS[2])
                pictureBox_led_status.Image = Properties.Resources.red;
            else if (data == RECEIVE_MSGS[3])
                pictureBox_led_status.Image = Properties.Resources.off;
            else if (data == RECEIVE_MSGS[4])
                pictureBox_led_status.Image = Properties.Resources.yellow;
            else if (data == RECEIVE_MSGS[5])
                pictureBox_led_status.Image = Properties.Resources.green;
            else if (data == RECEIVE_MSGS[6])
                MessageBox.Show("Time saved failed", "Error", MessageBoxButtons.OK);
            else if (data == RECEIVE_MSGS[7])
                MessageBox.Show("Time saved successfully", "Success", MessageBoxButtons.OK);
            else if (data >= '1' && data <= '3')
                label_mode_value.Text = data.ToString();
        }

        #endregion


        #region Control

        private void button_control_state_Click(object sender, EventArgs e)
        {
            sendMsg(SEND_MSGS[0]);
        }

        private void button_mode_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string mode = btn.Text;
            sendMsg(mode.Substring(mode.Length - 1)[0]);
        }

        private void button_save_time_Click(object sender, EventArgs e)
        {
            string redTime =
                textBox_red_value.Text.Length == 1
                    ? "0" + textBox_red_value.Text
                    : textBox_red_value.Text;
            string yellowTime =
                textBox_yellow_value.Text.Length == 1
                    ? "0" + textBox_yellow_value.Text
                    : textBox_yellow_value.Text;
            string greenTime =
                textBox_green_value.Text.Length == 1
                    ? "0" + textBox_green_value.Text
                    : textBox_green_value.Text;

            if (redTime.Length != 2 || yellowTime.Length != 2 || greenTime.Length != 2)
            {
                MessageBox.Show(
                    "Please enter valid time values (1-99)",
                    "Error",
                    MessageBoxButtons.OK
                );
                return;
            }

            /*serialPort.Write(SEND_MSGS[4].ToString() + redTime + yellowTime + greenTime);*/
            /*System.Threading.Thread.Sleep(200);*/
            /*serialPort.Write(SEND_MSGS[4].ToString() + redTime + yellowTime + greenTime);*/
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            DateTime current = DateTime.Now;

            label_time_value.Text = current.ToString("HH:mm:ss");

            if (usbHidPort.SpecifiedDevice == null)
                return;

            if ((current.Hour >= 23 || current.Hour < 5) && timeMode != Mode.Night)
            {
                timeMode = Mode.Night;
                sendMsg(SEND_MSGS[2]);
            }
            else if ((current.Hour >= 5 && current.Hour < 23) && timeMode != Mode.Day)
            {
                timeMode = Mode.Day;
                sendMsg(SEND_MSGS[1]);
            }
        }

        #endregion


        #region Helpers

        private void toggle(bool isEnabled)
        {
            if (InvokeRequired)
            {
                Invoke(
                    (MethodInvoker)
                        delegate
                        {
                            toggle(isEnabled);
                        }
                );
                return;
            }

            button_mode_1.Enabled = isEnabled && controlSource == ControlSource.Auto;
            button_mode_2.Enabled = isEnabled && controlSource == ControlSource.Auto;
            button_mode_3.Enabled = isEnabled && controlSource == ControlSource.Auto;
            button_save_time.Enabled = isEnabled;

            textBox_red_value.Enabled = isEnabled;
            textBox_yellow_value.Enabled = isEnabled;
            textBox_green_value.Enabled = isEnabled;
        }

        private void validateTime(object sender, KeyPressEventArgs e)
        {
            if (!char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back)
                e.Handled = true;

            if (sender is TextBox textBox && char.IsDigit(e.KeyChar))
                if (textBox.Text.Length >= 2 && textBox.SelectionLength == 0)
                    e.Handled = true;
        }

        private void StyleInput(TextBox input)
        {
            input.BorderStyle = BorderStyle.None;
            input.BackColor = backgroundColor;
            input.ForeColor = foregroundColor;
            input.TextAlign = HorizontalAlignment.Center;
        }

        private void StyleButton(Button btn, Color backColor)
        {
            btn.FlatStyle = FlatStyle.Flat;
            btn.FlatAppearance.BorderSize = 0;
            btn.BackColor = backColor;
            btn.ForeColor = primaryForegroundColor;
            this.RoundComponent(btn, 8);

            btn.Paint += (s, e) =>
            {
                Color textColor = btn.Enabled
                    ? primaryForegroundColor
                    : primaryForegroundColorDisabled;
                TextRenderer.DrawText(
                    e.Graphics,
                    btn.Text,
                    btn.Font,
                    btn.ClientRectangle,
                    textColor,
                    TextFormatFlags.VerticalCenter | TextFormatFlags.HorizontalCenter
                );
            };

            btn.MouseDown += (s, e) =>
            {
                btn.FlatAppearance.BorderSize = 0;
                btn.BackColor = Color.FromArgb(
                    Math.Max(backColor.R - 20, 0),
                    Math.Max(backColor.G - 20, 0),
                    Math.Max(backColor.B - 20, 0)
                );
            };

            btn.MouseUp += (s, e) => btn.BackColor = backColor;
            ;
        }

        private void RoundComponent(Control component, int radius)
        {
            using (GraphicsPath path = new GraphicsPath())
            {
                Rectangle r = component.ClientRectangle;
                path.AddArc(r.X, r.Y, radius, radius, 180, 90);
                path.AddArc(r.Width - radius, r.Y, radius, radius, 270, 90);
                path.AddArc(r.Width - radius, r.Height - radius, radius, radius, 0, 90);
                path.AddArc(r.X, r.Height - radius, radius, radius, 90, 90);
                path.CloseFigure();
                component.Region = new Region(path);
            }
        }

        #endregion


        #region Color Variables
        private Color backgroundColor = Color.FromArgb(250, 250, 250);
        private Color foregroundColor = Color.FromArgb(10, 10, 10);
        private Color primaryColor = Color.FromArgb(23, 23, 23);
        private Color primaryForegroundColor = Color.FromArgb(250, 250, 250);
        private Color primaryForegroundColorDisabled = Color.FromArgb(163, 163, 163);
        private Color connectedColor = Color.FromArgb(22, 163, 74);
        private Color disconnectedColor = Color.FromArgb(220, 38, 38);
        #endregion
    }
}
