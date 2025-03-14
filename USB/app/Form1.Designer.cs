namespace app
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
                components.Dispose();

            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.label_title = new System.Windows.Forms.Label();
            this.groupBox_connect = new System.Windows.Forms.GroupBox();
            this.button_submitTime = new System.Windows.Forms.Button();
            this.label_greenTime = new System.Windows.Forms.Label();
            this.label_yellowTime = new System.Windows.Forms.Label();
            this.label_redTime = new System.Windows.Forms.Label();
            this.textBox_greenTime = new System.Windows.Forms.TextBox();
            this.textBox_yellowTime = new System.Windows.Forms.TextBox();
            this.textBox_redTime = new System.Windows.Forms.TextBox();
            this.textBox_status = new System.Windows.Forms.TextBox();
            this.groupBox_controller = new System.Windows.Forms.GroupBox();
            this.clock = new System.Windows.Forms.Label();
            this.pictureBox_led = new System.Windows.Forms.PictureBox();
            this.button_mode_1 = new System.Windows.Forms.Button();
            this.button_mode_2 = new System.Windows.Forms.Button();
            this.checkBox_control = new System.Windows.Forms.CheckBox();
            this.button_mode_3 = new System.Windows.Forms.Button();
            this.timer = new System.Windows.Forms.Timer(this.components);
            this.usbHidPort = new UsbLibrary.UsbHidPort(this.components);
            this.groupBox_connect.SuspendLayout();
            this.groupBox_controller.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_led)).BeginInit();
            this.SuspendLayout();
            // 
            // label_title
            // 
            this.label_title.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label_title.Location = new System.Drawing.Point(16, 16);
            this.label_title.Name = "label_title";
            this.label_title.Size = new System.Drawing.Size(550, 24);
            this.label_title.TabIndex = 6;
            this.label_title.Text = "Communication with Traffic Lights";
            this.label_title.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // groupBox_connect
            // 
            this.groupBox_connect.Controls.Add(this.button_submitTime);
            this.groupBox_connect.Controls.Add(this.label_greenTime);
            this.groupBox_connect.Controls.Add(this.label_yellowTime);
            this.groupBox_connect.Controls.Add(this.label_redTime);
            this.groupBox_connect.Controls.Add(this.textBox_greenTime);
            this.groupBox_connect.Controls.Add(this.textBox_yellowTime);
            this.groupBox_connect.Controls.Add(this.textBox_redTime);
            this.groupBox_connect.Controls.Add(this.textBox_status);
            this.groupBox_connect.Location = new System.Drawing.Point(16, 56);
            this.groupBox_connect.Name = "groupBox_connect";
            this.groupBox_connect.Padding = new System.Windows.Forms.Padding(8);
            this.groupBox_connect.Size = new System.Drawing.Size(250, 164);
            this.groupBox_connect.TabIndex = 0;
            this.groupBox_connect.TabStop = false;
            this.groupBox_connect.Text = "Connection";
            // 
            // button_submitTime
            // 
            this.button_submitTime.Enabled = false;
            this.button_submitTime.FlatAppearance.BorderSize = 0;
            this.button_submitTime.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button_submitTime.Location = new System.Drawing.Point(151, 95);
            this.button_submitTime.Name = "button_submitTime";
            this.button_submitTime.Size = new System.Drawing.Size(88, 58);
            this.button_submitTime.TabIndex = 11;
            this.button_submitTime.Text = "Save Changes";
            this.button_submitTime.UseVisualStyleBackColor = true;
            this.button_submitTime.Click += new System.EventHandler(this.button_submitTime_Click);
            // 
            // label_greenTime
            // 
            this.label_greenTime.AutoSize = true;
            this.label_greenTime.Location = new System.Drawing.Point(11, 133);
            this.label_greenTime.Name = "label_greenTime";
            this.label_greenTime.Size = new System.Drawing.Size(54, 20);
            this.label_greenTime.TabIndex = 10;
            this.label_greenTime.Text = "Green";
            // 
            // label_yellowTime
            // 
            this.label_yellowTime.AutoSize = true;
            this.label_yellowTime.Location = new System.Drawing.Point(11, 101);
            this.label_yellowTime.Name = "label_yellowTime";
            this.label_yellowTime.Size = new System.Drawing.Size(55, 20);
            this.label_yellowTime.TabIndex = 10;
            this.label_yellowTime.Text = "Yellow";
            // 
            // label_redTime
            // 
            this.label_redTime.AutoSize = true;
            this.label_redTime.Location = new System.Drawing.Point(11, 69);
            this.label_redTime.Name = "label_redTime";
            this.label_redTime.Size = new System.Drawing.Size(39, 20);
            this.label_redTime.TabIndex = 10;
            this.label_redTime.Text = "Red";
            // 
            // textBox_greenTime
            // 
            this.textBox_greenTime.Location = new System.Drawing.Point(89, 127);
            this.textBox_greenTime.Name = "textBox_greenTime";
            this.textBox_greenTime.Size = new System.Drawing.Size(40, 26);
            this.textBox_greenTime.TabIndex = 3;
            this.textBox_greenTime.Text = "10";
            this.textBox_greenTime.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.textBox_greenTime.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.validateTextBox);
            this.textBox_greenTime.Leave += new System.EventHandler(this.formatTextBox);
            // 
            // textBox_yellowTime
            // 
            this.textBox_yellowTime.Location = new System.Drawing.Point(89, 95);
            this.textBox_yellowTime.Name = "textBox_yellowTime";
            this.textBox_yellowTime.Size = new System.Drawing.Size(40, 26);
            this.textBox_yellowTime.TabIndex = 2;
            this.textBox_yellowTime.Text = "03";
            this.textBox_yellowTime.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.textBox_yellowTime.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.validateTextBox);
            this.textBox_yellowTime.Leave += new System.EventHandler(this.formatTextBox);
            // 
            // textBox_redTime
            // 
            this.textBox_redTime.Location = new System.Drawing.Point(89, 63);
            this.textBox_redTime.Name = "textBox_redTime";
            this.textBox_redTime.Size = new System.Drawing.Size(40, 26);
            this.textBox_redTime.TabIndex = 1;
            this.textBox_redTime.Text = "05";
            this.textBox_redTime.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.textBox_redTime.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.validateTextBox);
            this.textBox_redTime.Leave += new System.EventHandler(this.formatTextBox);
            // 
            // textBox_status
            // 
            this.textBox_status.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.textBox_status.Location = new System.Drawing.Point(55, 37);
            this.textBox_status.Name = "textBox_status";
            this.textBox_status.ReadOnly = true;
            this.textBox_status.Size = new System.Drawing.Size(140, 19);
            this.textBox_status.TabIndex = 0;
            this.textBox_status.Text = "Disconnected";
            this.textBox_status.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // groupBox_controller
            // 
            this.groupBox_controller.Controls.Add(this.clock);
            this.groupBox_controller.Controls.Add(this.pictureBox_led);
            this.groupBox_controller.Controls.Add(this.button_mode_1);
            this.groupBox_controller.Controls.Add(this.button_mode_2);
            this.groupBox_controller.Controls.Add(this.checkBox_control);
            this.groupBox_controller.Controls.Add(this.button_mode_3);
            this.groupBox_controller.Location = new System.Drawing.Point(284, 56);
            this.groupBox_controller.Name = "groupBox_controller";
            this.groupBox_controller.Padding = new System.Windows.Forms.Padding(8);
            this.groupBox_controller.Size = new System.Drawing.Size(250, 164);
            this.groupBox_controller.TabIndex = 0;
            this.groupBox_controller.TabStop = false;
            this.groupBox_controller.Text = "Controller";
            // 
            // clock
            // 
            this.clock.AutoSize = true;
            this.clock.Location = new System.Drawing.Point(12, 72);
            this.clock.Name = "clock";
            this.clock.Size = new System.Drawing.Size(45, 20);
            this.clock.TabIndex = 9;
            this.clock.Text = "clock";
            // 
            // pictureBox_led
            // 
            this.pictureBox_led.Location = new System.Drawing.Point(188, 20);
            this.pictureBox_led.Name = "pictureBox_led";
            this.pictureBox_led.Size = new System.Drawing.Size(50, 50);
            this.pictureBox_led.TabIndex = 8;
            this.pictureBox_led.TabStop = false;
            // 
            // button_mode_1
            // 
            this.button_mode_1.Enabled = false;
            this.button_mode_1.FlatAppearance.BorderSize = 0;
            this.button_mode_1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button_mode_1.Location = new System.Drawing.Point(16, 110);
            this.button_mode_1.Name = "button_mode_1";
            this.button_mode_1.Size = new System.Drawing.Size(72, 40);
            this.button_mode_1.TabIndex = 4;
            this.button_mode_1.Text = "Mode 1";
            this.button_mode_1.UseVisualStyleBackColor = false;
            this.button_mode_1.Click += new System.EventHandler(this.button_mode_1_Click);
            // 
            // button_mode_2
            // 
            this.button_mode_2.Enabled = false;
            this.button_mode_2.FlatAppearance.BorderSize = 0;
            this.button_mode_2.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button_mode_2.Location = new System.Drawing.Point(90, 110);
            this.button_mode_2.Name = "button_mode_2";
            this.button_mode_2.Size = new System.Drawing.Size(72, 40);
            this.button_mode_2.TabIndex = 5;
            this.button_mode_2.Text = "Mode 2";
            this.button_mode_2.UseVisualStyleBackColor = false;
            this.button_mode_2.Click += new System.EventHandler(this.button_mode_2_Click);
            // 
            // checkBox_control
            // 
            this.checkBox_control.AutoSize = true;
            this.checkBox_control.Enabled = false;
            this.checkBox_control.Location = new System.Drawing.Point(16, 32);
            this.checkBox_control.Name = "checkBox_control";
            this.checkBox_control.Size = new System.Drawing.Size(93, 24);
            this.checkBox_control.TabIndex = 5;
            this.checkBox_control.Text = "No signal";
            this.checkBox_control.UseVisualStyleBackColor = true;
            this.checkBox_control.CheckedChanged += new System.EventHandler(this.checkBox_control_CheckedChanged);
            // 
            // button_mode_3
            // 
            this.button_mode_3.Enabled = false;
            this.button_mode_3.FlatAppearance.BorderSize = 0;
            this.button_mode_3.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button_mode_3.Location = new System.Drawing.Point(164, 110);
            this.button_mode_3.Name = "button_mode_3";
            this.button_mode_3.Size = new System.Drawing.Size(72, 40);
            this.button_mode_3.TabIndex = 6;
            this.button_mode_3.Text = "Mode 3";
            this.button_mode_3.UseVisualStyleBackColor = false;
            this.button_mode_3.Click += new System.EventHandler(this.button_mode_3_Click);
            // 
            // timer
            // 
            this.timer.Tick += new System.EventHandler(this.timer_Tick);
            // 
            // usbHidPort
            // 
            this.usbHidPort.ProductId = 0;
            this.usbHidPort.VendorId = 0;
            this.usbHidPort.OnSpecifiedDeviceArrived += new System.EventHandler(this.usbHidPort_OnSpecifiedDeviceArrived);
            this.usbHidPort.OnSpecifiedDeviceRemoved += new System.EventHandler(this.usbHidPort_OnSpecifiedDeviceRemoved);
            this.usbHidPort.OnDeviceArrived += new System.EventHandler(this.usbHidPort_OnDeviceArrived);
            this.usbHidPort.OnDeviceRemoved += new System.EventHandler(this.usbHidPort_OnDeviceRemoved);
            this.usbHidPort.OnDataRecieved += new UsbLibrary.DataRecievedEventHandler(this.usbHidPort_OnDataRecieved);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(550, 236);
            this.Controls.Add(this.label_title);
            this.Controls.Add(this.groupBox_controller);
            this.Controls.Add(this.groupBox_connect);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.Text = "Communication with Traffic Lights";
            this.TopMost = true;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox_connect.ResumeLayout(false);
            this.groupBox_connect.PerformLayout();
            this.groupBox_controller.ResumeLayout(false);
            this.groupBox_controller.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_led)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Drawing.Color backgroundColor = System.Drawing.Color.FromArgb(
            ((int)(((byte)(250)))),
            ((int)(((byte)(250)))),
            ((int)(((byte)(250))))
        );
        private System.Drawing.Color foregroundColor = System.Drawing.Color.FromArgb(
            ((int)(((byte)(10)))),
            ((int)(((byte)(10)))),
            ((int)(((byte)(10))))
        );
        private System.Drawing.Color primaryColor = System.Drawing.Color.FromArgb(
            ((int)(((byte)(29)))),
            ((int)(((byte)(78)))),
            ((int)(((byte)(216))))
        );
        private System.Drawing.Color primaryForegroundColor = System.Drawing.Color.FromArgb(
            ((int)(((byte)(248)))),
            ((int)(((byte)(250)))),
            ((int)(((byte)(252))))
        );
        private System.Drawing.Color activeColor = System.Drawing.Color.FromArgb(
            ((int)(((byte)(30)))),
            ((int)(((byte)(64)))),
            ((int)(((byte)(175))))
        );
        private System.Drawing.Color successColor = System.Drawing.Color.FromArgb(
            ((int)(((byte)(22)))),
            ((int)(((byte)(163)))),
            ((int)(((byte)(74))))
        );
        private System.Drawing.Color destructiveColor = System.Drawing.Color.FromArgb(
            ((int)(((byte)(220)))),
            ((int)(((byte)(38)))),
            ((int)(((byte)(38))))
        );

        private System.Windows.Forms.GroupBox groupBox_connect;
        private System.Windows.Forms.GroupBox groupBox_controller;
        private System.Windows.Forms.TextBox textBox_status;
        private System.Windows.Forms.CheckBox checkBox_control;
        private System.Windows.Forms.Button button_mode_1;
        private System.Windows.Forms.Button button_mode_2;
        private System.Windows.Forms.Button button_mode_3;
        private System.Windows.Forms.Label label_title;
        private System.Windows.Forms.PictureBox pictureBox_led;
        private System.Windows.Forms.Timer timer;
        private System.Windows.Forms.Label clock;
        private UsbLibrary.UsbHidPort usbHidPort;
        private System.Windows.Forms.TextBox textBox_greenTime;
        private System.Windows.Forms.TextBox textBox_yellowTime;
        private System.Windows.Forms.TextBox textBox_redTime;
        private System.Windows.Forms.Label label_redTime;
        private System.Windows.Forms.Label label_greenTime;
        private System.Windows.Forms.Label label_yellowTime;
        private System.Windows.Forms.Button button_submitTime;
    }
}
