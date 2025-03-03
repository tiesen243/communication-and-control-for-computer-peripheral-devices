using System;
using System.Drawing;
using System.Windows.Forms;
using UsbLibrary;

namespace app
{
    public partial class Form1 : Form
    {
        byte[] readbuff = new byte[2];
        byte[] writebuff = new byte[2];

        bool control_source = false;

        /*
         * 0 for manual, 1 for auto
         * Manual: use button to change mode
         * Auto: use PC to change mode
         */

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            usbHidPort.VendorId = 0x04D8;
            usbHidPort.ProductId = 0x0001;

            usbHidPort.CheckDevicePresent();
            pictureBox_led.Image = app.Properties.Resources.off;
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult answer = MessageBox.Show(
                "Do you want to exit the program?",
                "Question",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question
            );
            if (answer == DialogResult.No)
                e.Cancel = true;
        }

        private void usbHidPort_OnDataRecieved(object sender, DataRecievedEventArgs args)
        {
            if (InvokeRequired)
            {
                try
                {
                    Invoke(
                        new DataRecievedEventHandler(usbHidPort_OnDataRecieved),
                        new object[] { sender, args }
                    );
                }
                catch { }
            }
            else
            {
                if (usbHidPort.SpecifiedDevice != null)
                {
                    readbuff = args.data;

                    Console.WriteLine(readbuff);

                    if (readbuff[1] == 'A')
                    {
                        checkBox_control.Checked = true;
                        checkBox_control.Text = "Auto mode";
                        control_source = true;
                    }
                    else if (readbuff[1] == 'M')
                    {
                        checkBox_control.Checked = false;
                        checkBox_control.Text = "Manual mode";
                        control_source = false;
                    }
                    else if (readbuff[1] == 'U')
                    {
                        textBox_mode.Text = "1";
                    }
                    else if (readbuff[1] == 'K')
                    {
                        textBox_mode.Text = "2";
                    }
                    else if (readbuff[1] == 'I')
                    {
                        textBox_mode.Text = "3";
                    }
                    else if (readbuff[1] == 'R')
                    {
                        pictureBox_led.Image = app.Properties.Resources.red;
                    }
                    else if (readbuff[1] == 'Y')
                    {
                        pictureBox_led.Image = app.Properties.Resources.yellow;
                    }
                    else if (readbuff[1] == 'G')
                    {
                        pictureBox_led.Image = app.Properties.Resources.green;
                    }
                    else if (readbuff[1] == 'O')
                    {
                        pictureBox_led.Image = app.Properties.Resources.off;
                    }
                }
            }
        }

        private void usbHidPort_OnDataSend(object sender, EventArgs e) { }

        private void usbHidPort_OnDeviceArrived(object sender, EventArgs e) { }

        private void usbHidPort_OnDeviceRemoved(object sender, EventArgs e) { }

        private void usbHidPort_OnSpecifiedDeviceArrived(object sender, EventArgs e)
        {
            textBox_status.Text = "Connected!";
            textBox_status.BackColor = Color.Green;
            checkBox_control.Checked = false;
            checkBox_control.Text = "Manual mode";
            pictureBox_led.Image = app.Properties.Resources.off;
        }

        private void usbHidPort_OnSpecifiedDeviceRemoved(object sender, EventArgs e)
        {
            if (InvokeRequired)
                Invoke(
                    new EventHandler(usbHidPort_OnSpecifiedDeviceRemoved),
                    new Object[] { sender, e }
                );
            else
            {
                textBox_status.Text = "Disconnected!";
                textBox_status.BackColor = Color.Red;
                checkBox_control.Checked = false;
                checkBox_control.Text = "No signal";
                pictureBox_led.Image = app.Properties.Resources.off;
            }
        }

        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);
            usbHidPort.RegisterHandle(Handle);
        }

        protected override void WndProc(ref Message m)
        {
            usbHidPort.ParseMessages(ref m);
            base.WndProc(ref m);
        }

        private void checkBox_control_CheckedChanged(object sender, EventArgs e)
        {
            if (usbHidPort.SpecifiedDevice != null)
            {
                if (checkBox_control.Checked)
                {
                    writebuff[1] = (byte)'T';
                    usbHidPort.SpecifiedDevice.SendData(writebuff);
                }
            }
            else
                MessageBox.Show("Device not found");
        }

        private void button_mode_1_Click(object sender, EventArgs e)
        {
            if (usbHidPort.SpecifiedDevice != null)
            {
                if (!control_source)
                {
                    MessageBox.Show(
                        "Can not control in manual mode",
                        "Warning",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Warning
                    );
                    return;
                }

                writebuff[1] = (byte)'1';
                usbHidPort.SpecifiedDevice.SendData(writebuff);
            }
            else
                MessageBox.Show("Device not found");
        }

        private void button_mode_2_Click(object sender, EventArgs e)
        {
            if (usbHidPort.SpecifiedDevice != null)
            {
                if (!control_source)
                {
                    MessageBox.Show(
                        "Can not control in manual mode",
                        "Warning",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Warning
                    );
                    return;
                }

                writebuff[1] = (byte)'2';
                usbHidPort.SpecifiedDevice.SendData(writebuff);
            }
            else
                MessageBox.Show("Device not found");
        }

        private void button_mode_3_Click(object sender, EventArgs e)
        {
            if (usbHidPort.SpecifiedDevice != null)
            {
                if (!control_source)
                {
                    MessageBox.Show(
                        "Can not control in manual mode",
                        "Warning",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Warning
                    );
                    return;
                }

                writebuff[1] = (byte)'3';
                usbHidPort.SpecifiedDevice.SendData(writebuff);
            }
            else
                MessageBox.Show("Device not found");
        }
    }
}
