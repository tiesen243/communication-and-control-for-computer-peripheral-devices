﻿using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO.Ports;
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

    public partial class Software : System.Windows.Forms.Form
    {
        #region Initialization

        private ControlSource controlSource = ControlSource.Manual;
        private Mode timeMode = Mode.Day;

        public Software()
        {
            InitializeComponent();
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
        }

        private void Yuki_Load(object sender, EventArgs e)
        {
            timer.Start();

            string[] ports = SerialPort.GetPortNames();
            comboBox_Comp.Items.AddRange(ports);
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
            {
                if (serialPort.IsOpen)
                    serialPort.Close();
                e.Cancel = false;
            }
        }

        #endregion


        #region Connectivity

        private void comboBox_Comp_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox_Comp.SelectedItem != null)
            {
                button_connect.Enabled = true;
                serialPort.PortName = comboBox_Comp.SelectedItem.ToString();
            }
        }

        private void button_connect_Click(object sender, EventArgs e)
        {
            try
            {
                if (serialPort.IsOpen)
                {
                    serialPort.Close();
                    comboBox_Comp.Enabled = true;

                    button_connect.Text = "Connect";
                    StyleButton(button_connect, connectedColor);

                    label_status.Text = "Disconnected";
                    label_status.ForeColor = disconnectedColor;

                    button_control_state.Enabled = false;
                    button_control_state.Text = "No Signal";

                    toggle(false);
                }
                else
                {
                    serialPort.Open();
                    comboBox_Comp.Enabled = false;

                    button_connect.Text = "Disconnect";
                    StyleButton(button_connect, disconnectedColor);

                    label_status.Text = "Connected";
                    label_status.ForeColor = connectedColor;

                    button_control_state.Enabled = true;
                    button_control_state.Text = "Manual";

                    toggle(true);

                    sendMsg("I");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK);
            }
        }

        #endregion


        #region Communication

        private void sendMsg(string msg)
        {
            try
            {
                serialPort.Write(msg);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK);
            }
        }

        private void serialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            string data = serialPort.ReadExisting();
            this.Invoke(
                new EventHandler(
                    delegate
                    {
                        handleReceivedData(data);
                    }
                )
            );
        }

        #endregion


        #region Control

        private void button_control_state_Click(object sender, EventArgs e)
        {
            sendMsg("T");
        }

        private void button_mode_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string mode = btn.Text;
            sendMsg(mode.Substring(mode.Length - 1)[0].ToString());
        }

        private void handleReceivedData(string data)
        {
            if (data == "M")
            {
                button_control_state.Text = "Manual";
                controlSource = ControlSource.Manual;
                toggle(true);
            }
            else if (data == "A")
            {
                button_control_state.Text = "Auto";
                controlSource = ControlSource.Auto;
                toggle(true);
            }
            else if (data == "R")
                pictureBox_led_status.Image = Properties.Resources.red;
            else if (data == "Y")
                pictureBox_led_status.Image = Properties.Resources.yellow;
            else if (data == "G")
                pictureBox_led_status.Image = Properties.Resources.green;
            else if (data == "O")
                pictureBox_led_status.Image = Properties.Resources.off;
            else if (data == "E")
                MessageBox.Show("Time saved failed", "Error", MessageBoxButtons.OK);
            else if (data == "S")
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

            serialPort.Write("S" + redTime + yellowTime + greenTime);
            System.Threading.Thread.Sleep(200);
            serialPort.Write("S" + redTime + yellowTime + greenTime);
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            DateTime current = DateTime.Now;

            label_time_value.Text = current.ToString("HH:mm:ss");

            if (!serialPort.IsOpen)
                return;

            if ((current.Hour >= 23 || current.Hour < 5) && timeMode != Mode.Night)
            {
                timeMode = Mode.Night;
                sendMsg("N");
            }
            else if ((current.Hour >= 5 && current.Hour < 23) && timeMode != Mode.Day)
            {
                timeMode = Mode.Day;
                sendMsg("D");
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
        }

        private void validateInput(object sender, KeyPressEventArgs e)
        {
            if (
                !char.IsDigit(e.KeyChar)
                && e.KeyChar != (char)Keys.Back
                && e.KeyChar != (char)Keys.Delete
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
        private Color disconnectedColor = Color.FromArgb(220, 38, 38);
        #endregion
    }
}
