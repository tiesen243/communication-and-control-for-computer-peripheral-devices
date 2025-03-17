using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO.Ports;
using System.Windows.Forms;

namespace yuki
{
    public enum ControlSource
    {
        Auto,
        Manual,
    }

    public partial class Yuki : System.Windows.Forms.Form
    {
        #region Initialization

        private ControlSource controlSource = ControlSource.Manual;

        public Yuki()
        {
            InitializeComponent();
            pictureBox_led_status.Image = Properties.Resources.red;

            this.BackColor = backgroundColor;
            this.ForeColor = foregroundColor;
            StyleButton(button_connect, connectedColor);
            StyleButton(button_save_time, primaryColor);
            StyleButton(button_mode_1, primaryColor);
            StyleButton(button_mode_2, primaryColor);
            StyleButton(button_mode_3, primaryColor);
            StyleInput(textBox_red_value);
            StyleInput(textBox_yellow_value);
            StyleInput(textBox_green_value);
        }

        private void Yuki_Load(object sender, EventArgs e)
        {
            timer.Start();

            string[] ports = SerialPort.GetPortNames();
            comboBox_Comp.Items.AddRange(ports);
        }

        #endregion


        #region Connectivity

        private void comboBox_Comp_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox_Comp.SelectedItem != null)
            {
                button_connect.Enabled = true;
            }
        }

        private void button_connect_Click(object sender, EventArgs e)
        {
            try
            {
                if (serialPort.IsOpen)
                {
                    serialPort.Close();
                    button_connect.Text = "Connect";
                    button_connect.BackColor = connectedColor;
                    label_status.Text = "Disconnected";
                    label_status.ForeColor = disconnectedColor;

                    button_mode_1.Enabled = false;
                    button_mode_2.Enabled = false;
                    button_mode_3.Enabled = false;
                    button_save_time.Enabled = false;
                }
                else
                {
                    serialPort.Open();
                    button_connect.Text = "Disconnect";
                    button_connect.BackColor = disconnectedColor;
                    label_status.Text = "Connected";
                    label_status.ForeColor = connectedColor;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        #endregion

        private void timer_Tick(object sender, EventArgs e)
        {
            DateTime current = DateTime.Now;

            label_time_value.Text = current.ToString("HH:mm:ss");
        }

        #region Helpers

        private void ToggleButton(bool isEnabled)
        {
            button_mode_1.Enabled = isEnabled && controlSource == ControlSource.Auto;
            button_mode_2.Enabled = isEnabled && controlSource == ControlSource.Auto;
            button_mode_3.Enabled = isEnabled && controlSource == ControlSource.Auto;
            button_save_time.Enabled = isEnabled;
        }

        private void StyleInput(TextBox input)
        {
            input.BorderStyle = BorderStyle.None;
            input.BackColor = backgroundColor;
            input.ForeColor = foregroundColor;
            input.TextAlign = HorizontalAlignment.Center;
            this.RoundComponent(input, 8);
        }

        private void StyleButton(Button btn, Color backColor)
        {
            btn.FlatStyle = FlatStyle.Flat;
            btn.FlatAppearance.BorderSize = 0;
            btn.BackColor = backColor;
            btn.ForeColor = primaryForegroundColor;
            btn.Paint += (s, e) =>
            {
                Color textColor = btn.Enabled
                    ? primaryForegroundColor
                    : primaryforegroundColorDisabled;
                TextRenderer.DrawText(
                    e.Graphics,
                    btn.Text,
                    btn.Font,
                    btn.ClientRectangle,
                    textColor,
                    TextFormatFlags.VerticalCenter | TextFormatFlags.HorizontalCenter
                );
            };
            this.RoundComponent(btn, 8);
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
        private Color primaryforegroundColorDisabled = Color.FromArgb(163, 163, 163);
        private Color connectedColor = Color.FromArgb(22, 163, 74);
        private Color disconnectedColor = Color.FromArgb(220, 38, 38);
        #endregion
    }
}
