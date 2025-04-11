using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Windows.Forms;

namespace software
{
    public enum ControlSource
    {
        Auto,
        Manual,
    }

    public enum Mode
    {
        Night,
        Day,
    }

    public partial class Software : Form
    {
        #region Initialization

        private bool isConnected = false;
        IPEndPoint endPoint;
        Socket server;
        Socket client;

        private ControlSource controlSource = ControlSource.Manual;
        private Mode timeMode = Mode.Day;

        private readonly char[] RECEIVE_MSGS = { 'M', 'A', 'R', 'O', 'Y', 'G', 'E', 'S' };
        private readonly char[] SEND_MSGS = { 'T', 'D', 'N', 'I', 'S', 'Z' };

        public Software()
        {
            InitializeComponent();
            Control.CheckForIllegalCrossThreadCalls = false;

            pictureBox_led_status.Image = Properties.Resources.off;

            this.BackColor = backgroundColor;
            this.ForeColor = foregroundColor;
            StyleButton(button_connect, connectedColor);
            StyleButton(button_save_time, primaryColor);
            StyleButton(button_mode_1, primaryColor);
            StyleButton(button_mode_2, primaryColor);
            StyleButton(button_mode_3, primaryColor);
            StyleButton(button_control_state, primaryColor);
            StyleInput(textBox_red_value);
            StyleInput(textBox_yellow_value);
            StyleInput(textBox_green_value);
            StyleInput(textBox_IP);
            StyleInput(textBox_PORT);
        }

        private void Form_Load(object sender, EventArgs e)
        {
            timer.Start();
        }

        private void Form_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult dialogResult = MessageBox.Show(
                "Are you sure you want to exit?",
                "Exit",
                MessageBoxButtons.YesNo
            );
            if (dialogResult == DialogResult.No)
                e.Cancel = true;
            else
            {
                if (isConnected)
                {
                    server.Close();
                    client.Close();
                }
                e.Cancel = false;
            }
        }

        #endregion


        #region Connectivity

        private void button_connect_Click(object sender, EventArgs e)
        {
            try
            {
                if (isConnected)
                {
                    sendMsg(SEND_MSGS[5]);
                    System.Threading.Thread.Sleep(1000);
                    server.Close();
                    client.Close();

                    button_connect.Text = "Connect";
                    StyleButton(button_connect, connectedColor);

                    label_status.Text = "Disconnected";
                    label_status.ForeColor = disconnectedColor;

                    button_control_state.Enabled = false;
                    button_control_state.Text = "No Signal";

                    isConnected = false;

                    toggle(false);
                }
                else
                {
                    Thread t = new Thread(Endpoint_Thread)
                    {
                        IsBackground = true
                    };
                    t.Start();

                    button_connect.Text = "Disconnect";
                    button_connect.Enabled = false;
                    StyleButton(button_connect, disconnectedColor);

                    label_status.Text = "Waiting for connection...";
                    label_status.ForeColor = waitingColor;

                    button_control_state.Enabled = true;
                    button_control_state.Text = "Manual";
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK);
            }
        }

        private void Endpoint_Thread()
        {
            try
            {
                IPAddress ip = IPAddress.Parse(textBox_IP.Text);
                int port = int.Parse(textBox_PORT.Text);
                endPoint = new IPEndPoint(ip, port);

                server = new Socket(
                    AddressFamily.InterNetwork,
                    SocketType.Stream,
                    ProtocolType.Tcp
                );
                server.Bind(endPoint);
                server.Listen(10);

                client = server.Accept();
                label_status.Text = "Connected with " + client.RemoteEndPoint.ToString();
                label_status.ForeColor = connectedColor;
                button_connect.Enabled = true;
                isConnected = true;

                Thread t = new Thread(Receive_Thread)
                {
                    IsBackground = true
                };
                t.Start();

                toggle(true);

                System.Threading.Thread.Sleep(1000);
                sendMsg(SEND_MSGS[3]);
            }
            catch (System.Exception)
            {
                MessageBox.Show("Connection failed", "Error", MessageBoxButtons.OK);

                label_status.Text = "Disconnected";
                label_status.ForeColor = disconnectedColor;

                button_connect.Text = "Connect";
                button_connect.Enabled = true;
                StyleButton(button_connect, connectedColor);

                isConnected = false;

                textBox_IP.Enabled = true;
                textBox_PORT.Enabled = true;
                toggle(false);
            }
        }

        #endregion


        #region Communication

        private void sendMsg(char msg)
        {
            try
            {
                byte[] data = Encoding.ASCII.GetBytes(msg.ToString());
                client.SendTo(data, data.Length, SocketFlags.None, client.RemoteEndPoint);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK);
            }
        }

        private void Receive_Thread()
        {
            try
            {
                while (true)
                {
                    byte[] data_received = new byte[1];
                    int temp = client.Receive(data_received);
                    string data = Encoding.ASCII.GetString(data_received, 0, temp);

                    handleReceivedData(data);
                }
            }
            catch (System.Exception)
            {
                MessageBox.Show("Connection lost", "Error", MessageBoxButtons.OK);

                client.Close();

                button_connect.Text = "Connect";
                StyleButton(button_connect, connectedColor);

                label_status.Text = "Disconnected";
                label_status.ForeColor = disconnectedColor;

                button_control_state.Enabled = false;
                button_control_state.Text = "No Signal";

                toggle(false);
            }
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

        private void handleReceivedData(string data)
        {
            if (data == RECEIVE_MSGS[0].ToString())
            {
                button_control_state.Text = "Manual";
                controlSource = ControlSource.Manual;
                toggle(true);
            }
            else if (data == RECEIVE_MSGS[1].ToString())
            {
                button_control_state.Text = "Auto";
                controlSource = ControlSource.Auto;
                toggle(true);
            }
            else if (data == RECEIVE_MSGS[2].ToString())
                pictureBox_led_status.Image = Properties.Resources.red;
            else if (data == RECEIVE_MSGS[3].ToString())
                pictureBox_led_status.Image = Properties.Resources.off;
            else if (data == RECEIVE_MSGS[4].ToString())
                pictureBox_led_status.Image = Properties.Resources.yellow;
            else if (data == RECEIVE_MSGS[5].ToString())
                pictureBox_led_status.Image = Properties.Resources.green;
            else if (data == RECEIVE_MSGS[6].ToString())
                MessageBox.Show("Time saved failed", "Error", MessageBoxButtons.OK);
            else if (data == RECEIVE_MSGS[7].ToString())
                MessageBox.Show("Time saved successfully", "Success", MessageBoxButtons.OK);
            else if (data.Length == 1 && data[0] >= '1' && data[0] <= '3')
                label_mode_value.Text = data;
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

            byte[] data = Encoding.ASCII.GetBytes(
                SEND_MSGS[4].ToString() + redTime + yellowTime + greenTime
            );
            client.SendTo(data, data.Length, SocketFlags.None, client.RemoteEndPoint);
            System.Threading.Thread.Sleep(200);
            client.SendTo(data, data.Length, SocketFlags.None, client.RemoteEndPoint);
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            DateTime current = DateTime.Now;

            label_time_value.Text = current.ToString("HH:mm:ss");

            if (!isConnected)
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
            button_mode_1.Enabled = isEnabled && controlSource == ControlSource.Auto;
            button_mode_2.Enabled = isEnabled && controlSource == ControlSource.Auto;
            button_mode_3.Enabled = isEnabled && controlSource == ControlSource.Auto;
            button_save_time.Enabled = isEnabled;

            textBox_red_value.Enabled = isEnabled;
            textBox_yellow_value.Enabled = isEnabled;
            textBox_green_value.Enabled = isEnabled;

            textBox_IP.Enabled = !isEnabled;
            textBox_PORT.Enabled = !isEnabled;
        }

        private void validateInput(object sender, KeyPressEventArgs e)
        {
            if (
                !char.IsDigit(e.KeyChar)
                && e.KeyChar != (char)Keys.Back
                && e.KeyChar != (char)Keys.Delete
                && e.KeyChar != '.'
            )
                e.Handled = true;
        }

        private void validateTime(object sender, EventArgs e)
        {
            if (sender is TextBox textBox)
            {
                if (int.Parse(textBox.Text) < 3)
                {
                    textBox.Text = "03";
                    MessageBox.Show("Minimum value is 3", "Error", MessageBoxButtons.OK);
                }
                else if (int.Parse(textBox.Text) > 10)
                {
                    textBox.Text = "10";
                    MessageBox.Show("Maximum value is 10", "Error", MessageBoxButtons.OK);
                }
            }
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
        private Color waitingColor = Color.FromArgb(234, 179, 8);
        private Color disconnectedColor = Color.FromArgb(220, 38, 38);
        #endregion
    }
}
