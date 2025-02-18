namespace app
{
    partial class Form1
    {
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.ComboBox comboBox_COMP;
        private System.Windows.Forms.Button button_connect;
        private System.Windows.Forms.Button button_disconnect;
        private System.Windows.Forms.CheckBox checkBox_control;
        private System.Windows.Forms.Button button_mode_1;
        private System.Windows.Forms.Button button_mode_2;
        private System.Windows.Forms.Button button_mode_3;
        private System.Windows.Forms.TextBox textBox_status;
        private System.Windows.Forms.TextBox textBox_mode;
        private System.Windows.Forms.PictureBox pictureBox_led;
        private System.IO.Ports.SerialPort serialPort;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.comboBox_COMP = new System.Windows.Forms.ComboBox();
            this.button_connect = new System.Windows.Forms.Button();
            this.button_disconnect = new System.Windows.Forms.Button();
            this.checkBox_control = new System.Windows.Forms.CheckBox();
            this.button_mode_1 = new System.Windows.Forms.Button();
            this.button_mode_2 = new System.Windows.Forms.Button();
            this.button_mode_3 = new System.Windows.Forms.Button();
            this.textBox_status = new System.Windows.Forms.TextBox();
            this.textBox_mode = new System.Windows.Forms.TextBox();
            this.pictureBox_led = new System.Windows.Forms.PictureBox();
            this.serialPort = new System.IO.Ports.SerialPort(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_led)).BeginInit();
            this.SuspendLayout();
            // 
            // comboBox_COMP
            // 
            this.comboBox_COMP.FormattingEnabled = true;
            this.comboBox_COMP.Location = new System.Drawing.Point(12, 12);
            this.comboBox_COMP.Name = "comboBox_COMP";
            this.comboBox_COMP.Size = new System.Drawing.Size(121, 21);
            this.comboBox_COMP.TabIndex = 0;
            this.comboBox_COMP.SelectedIndexChanged += new System.EventHandler(this.comboBox_COMP_SelectedIndexChanged);
            // 
            // button_connect
            // 
            this.button_connect.Location = new System.Drawing.Point(139, 10);
            this.button_connect.Name = "button_connect";
            this.button_connect.Size = new System.Drawing.Size(75, 23);
            this.button_connect.TabIndex = 1;
            this.button_connect.Text = "Connect";
            this.button_connect.UseVisualStyleBackColor = true;
            this.button_connect.Click += new System.EventHandler(this.button_connect_Click);
            // 
            // button_disconnect
            // 
            this.button_disconnect.Location = new System.Drawing.Point(220, 10);
            this.button_disconnect.Name = "button_disconnect";
            this.button_disconnect.Size = new System.Drawing.Size(75, 23);
            this.button_disconnect.TabIndex = 2;
            this.button_disconnect.Text = "Disconnect";
            this.button_disconnect.UseVisualStyleBackColor = true;
            this.button_disconnect.Click += new System.EventHandler(this.button_disconnect_Click);
            // 
            // checkBox_control
            // 
            this.checkBox_control.AutoSize = true;
            this.checkBox_control.Location = new System.Drawing.Point(12, 39);
            this.checkBox_control.Name = "checkBox_control";
            this.checkBox_control.Size = new System.Drawing.Size(86, 17);
            this.checkBox_control.TabIndex = 3;
            this.checkBox_control.Text = "Manual mode";
            this.checkBox_control.UseVisualStyleBackColor = true;
            this.checkBox_control.CheckedChanged += new System.EventHandler(this.checkBox_control_CheckedChanged);
            // 
            // button_mode_1
            // 
            this.button_mode_1.Location = new System.Drawing.Point(12, 62);
            this.button_mode_1.Name = "button_mode_1";
            this.button_mode_1.Size = new System.Drawing.Size(75, 23);
            this.button_mode_1.TabIndex = 4;
            this.button_mode_1.Text = "Mode 1";
            this.button_mode_1.UseVisualStyleBackColor = true;
            this.button_mode_1.Click += new System.EventHandler(this.button_mode_1_Click);
            // 
            // button_mode_2
            // 
            this.button_mode_2.Location = new System.Drawing.Point(93, 62);
            this.button_mode_2.Name = "button_mode_2";
            this.button_mode_2.Size = new System.Drawing.Size(75, 23);
            this.button_mode_2.TabIndex = 5;
            this.button_mode_2.Text = "Mode 2";
            this.button_mode_2.UseVisualStyleBackColor = true;
            this.button_mode_2.Click += new System.EventHandler(this.button_mode_2_Click);
            // 
            // button_mode_3
            // 
            this.button_mode_3.Location = new System.Drawing.Point(174, 62);
            this.button_mode_3.Name = "button_mode_3";
            this.button_mode_3.Size = new System.Drawing.Size(75, 23);
            this.button_mode_3.TabIndex = 6;
            this.button_mode_3.Text = "Mode 3";
            this.button_mode_3.UseVisualStyleBackColor = true;
            this.button_mode_3.Click += new System.EventHandler(this.button_mode_3_Click);
            // 
            // textBox_status
            // 
            this.textBox_status.Location = new System.Drawing.Point(12, 91);
            this.textBox_status.Name = "textBox_status";
            this.textBox_status.ReadOnly = true;
            this.textBox_status.Size = new System.Drawing.Size(283, 20);
            this.textBox_status.TabIndex = 7;
            this.textBox_status.Text = "Disconnected";
            this.textBox_status.BackColor = System.Drawing.Color.Red;
            // 
            // textBox_mode
            // 
            this.textBox_mode.Location = new System.Drawing.Point(12, 117);
            this.textBox_mode.Name = "textBox_mode";
            this.textBox_mode.ReadOnly = true;
            this.textBox_mode.Size = new System.Drawing.Size(283, 20);
            this.textBox_mode.TabIndex = 8;
            this.textBox_mode.Text = "Mode";
            // 
            // pictureBox_led
            // 
            this.pictureBox_led.Location = new System.Drawing.Point(12, 143);
            this.pictureBox_led.Name = "pictureBox_led";
            this.pictureBox_led.Size = new System.Drawing.Size(283, 106);
            this.pictureBox_led.TabIndex = 9;
            this.pictureBox_led.TabStop = false;
            // 
            // Form1
            // 
            this.ClientSize = new System.Drawing.Size(307, 261);
            this.Controls.Add(this.pictureBox_led);
            this.Controls.Add(this.textBox_mode);
            this.Controls.Add(this.textBox_status);
            this.Controls.Add(this.button_mode_3);
            this.Controls.Add(this.button_mode_2);
            this.Controls.Add(this.button_mode_1);
            this.Controls.Add(this.checkBox_control);
            this.Controls.Add(this.button_disconnect);
            this.Controls.Add(this.button_connect);
            this.Controls.Add(this.comboBox_COMP);
            this.Name = "Form1";
            this.Text = "Peripheral Device Control";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_led)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();
        }
    }
}

