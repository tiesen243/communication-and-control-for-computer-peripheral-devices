using System.Windows.Forms;

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
            this.backgroundColor = System.Drawing.Color.FromArgb(250, 250, 250);
            this.foregroundColor = System.Drawing.Color.FromArgb(10, 10, 10);
            this.primaryColor = System.Drawing.Color.FromArgb(23, 23, 23);
            this.primaryForegroundColor = System.Drawing.Color.FromArgb(250, 250, 250);
            this.successColor = System.Drawing.Color.FromArgb(22, 163, 74);
            this.destructiveColor = System.Drawing.Color.FromArgb(220, 53, 69);

            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources =
                new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.label_title = new System.Windows.Forms.Label();
            this.groupBox_connect = new System.Windows.Forms.GroupBox();
            this.label_serial_port = new System.Windows.Forms.Label();
            this.comboBox_COMP = new System.Windows.Forms.ComboBox();
            this.textBox_status = new System.Windows.Forms.TextBox();
            this.button_connect = new System.Windows.Forms.Button();
            this.button_disconnect = new System.Windows.Forms.Button();
            this.groupBox_controller = new System.Windows.Forms.GroupBox();
            this.pictureBox_led = new System.Windows.Forms.PictureBox();
            this.label_mode = new System.Windows.Forms.Label();
            this.textBox_mode = new System.Windows.Forms.TextBox();
            this.button_mode_1 = new System.Windows.Forms.Button();
            this.button_mode_2 = new System.Windows.Forms.Button();
            this.checkBox_control = new System.Windows.Forms.CheckBox();
            this.button_mode_3 = new System.Windows.Forms.Button();
            this.serialPort = new System.IO.Ports.SerialPort(this.components);
            this.groupBox_connect.SuspendLayout();
            this.groupBox_controller.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_led)).BeginInit();
            this.SuspendLayout();
            //
            // label_title
            //
            this.label_title.Font = new System.Drawing.Font(
                "Microsoft Sans Serif",
                15.75F,
                System.Drawing.FontStyle.Regular,
                System.Drawing.GraphicsUnit.Point,
                ((byte)(0))
            );
            this.label_title.Location = new System.Drawing.Point(16, 16);
            this.label_title.Name = "label_title";
            this.label_title.Size = new System.Drawing.Size(550, 24);
            this.label_title.TabIndex = 6;
            this.label_title.Text = "Communication with Traffic Lights";
            this.label_title.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            //
            // groupBox_connect
            //
            this.groupBox_connect.Controls.Add(this.label_serial_port);
            this.groupBox_connect.Controls.Add(this.comboBox_COMP);
            this.groupBox_connect.Controls.Add(this.textBox_status);
            this.groupBox_connect.Controls.Add(this.button_connect);
            this.groupBox_connect.Controls.Add(this.button_disconnect);
            this.groupBox_connect.Location = new System.Drawing.Point(16, 56);
            this.groupBox_connect.Name = "groupBox_connect";
            this.groupBox_connect.Padding = new System.Windows.Forms.Padding(8);
            this.groupBox_connect.Size = new System.Drawing.Size(250, 164);
            this.groupBox_connect.TabIndex = 0;
            this.groupBox_connect.TabStop = false;
            this.groupBox_connect.Text = "Connection";
            //
            // label_serial_port
            //
            this.label_serial_port.Location = new System.Drawing.Point(8, 32);
            this.label_serial_port.Name = "label_serial_port";
            this.label_serial_port.Size = new System.Drawing.Size(84, 20);
            this.label_serial_port.TabIndex = 1;
            this.label_serial_port.Text = "Serial port";
            //
            // comboBox_COMP
            //
            this.comboBox_COMP.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_COMP.FormattingEnabled = true;
            this.comboBox_COMP.Location = new System.Drawing.Point(108, 28);
            this.comboBox_COMP.Name = "comboBox_COMP";
            this.comboBox_COMP.Size = new System.Drawing.Size(134, 28);
            this.comboBox_COMP.TabIndex = 0;
            this.comboBox_COMP.SelectedIndexChanged += new System.EventHandler(
                this.comboBox_COMP_SelectedIndexChanged
            );
            //
            // textBox_status
            //
            this.textBox_status.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.textBox_status.Location = new System.Drawing.Point(55, 72);
            this.textBox_status.Name = "textBox_status";
            this.textBox_status.ReadOnly = true;
            this.textBox_status.Size = new System.Drawing.Size(140, 19);
            this.textBox_status.ForeColor = this.destructiveColor;
            this.textBox_status.BackColor = this.backgroundColor;
            this.textBox_status.TabIndex = 2;
            this.textBox_status.Text = "Disconnected";
            this.textBox_status.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            //
            // button_connect
            //
            this.button_connect.Location = new System.Drawing.Point(8, 108);
            this.button_connect.Name = "button_connect";
            this.button_connect.Size = new System.Drawing.Size(109, 40);
            this.button_disconnect.UseVisualStyleBackColor = false;
            this.button_connect.TabIndex = 3;
            this.button_connect.Text = "Connect";
            this.button_connect.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button_connect.FlatAppearance.BorderSize = 0;
            this.button_connect.BackColor = this.successColor;
            this.button_connect.ForeColor = this.primaryForegroundColor;
            this.button_connect.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(
                21,
                128,
                61
            );
            this.button_connect.Click += new System.EventHandler(this.button_connect_Click);
            //
            // button_disconnect
            //
            this.button_disconnect.Location = new System.Drawing.Point(133, 108);
            this.button_disconnect.Name = "button_disconnect";
            this.button_disconnect.Size = new System.Drawing.Size(109, 40);
            this.button_disconnect.TabIndex = 4;
            this.button_disconnect.Text = "Disconnect";
            this.button_disconnect.UseVisualStyleBackColor = false;
            this.button_disconnect.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button_disconnect.FlatAppearance.BorderSize = 0;
            this.button_disconnect.BackColor = this.destructiveColor;
            this.button_disconnect.ForeColor = this.primaryForegroundColor;
            this.button_disconnect.FlatAppearance.MouseOverBackColor =
                System.Drawing.Color.FromArgb(185, 28, 28);

            this.button_disconnect.Click += new System.EventHandler(this.button_disconnect_Click);

            //
            // groupBox_controller
            //
            this.groupBox_controller.Controls.Add(this.pictureBox_led);
            this.groupBox_controller.Controls.Add(this.label_mode);
            this.groupBox_controller.Controls.Add(this.textBox_mode);
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
            // pictureBox_led
            //
            this.pictureBox_led.Location = new System.Drawing.Point(188, 20);
            this.pictureBox_led.Name = "pictureBox_led";
            this.pictureBox_led.Size = new System.Drawing.Size(50, 50);
            this.pictureBox_led.TabIndex = 8;
            this.pictureBox_led.TabStop = false;
            //
            // label_mode
            //
            this.label_mode.AutoSize = true;
            this.label_mode.Location = new System.Drawing.Point(16, 72);
            this.label_mode.Name = "label_mode";
            this.label_mode.Size = new System.Drawing.Size(106, 20);
            this.label_mode.TabIndex = 0;
            this.label_mode.Text = "Current mode";
            //
            // textBox_mode
            //
            this.textBox_mode.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.textBox_mode.Location = new System.Drawing.Point(116, 72);
            this.textBox_mode.Name = "textBox_mode";
            this.textBox_mode.ReadOnly = true;
            this.textBox_mode.Size = new System.Drawing.Size(50, 20);
            this.textBox_mode.BackColor = this.backgroundColor;
            this.textBox_mode.TabIndex = 2;
            this.textBox_mode.Text = "3";
            this.textBox_mode.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            //
            // button_mode_1
            //
            this.button_mode_1.Location = new System.Drawing.Point(16, 110);
            this.button_mode_1.Name = "button_mode_1";
            this.button_mode_1.Size = new System.Drawing.Size(72, 40);
            this.button_mode_1.TabIndex = 4;
            this.button_mode_1.Text = "Mode 1";
            this.button_mode_1.UseVisualStyleBackColor = false;
            this.button_mode_1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button_mode_1.FlatAppearance.BorderSize = 0;
            this.button_mode_1.BackColor = this.primaryColor;
            this.button_mode_1.ForeColor = this.primaryForegroundColor;
            this.button_mode_1.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(
                20,
                20,
                20
            );
            this.button_mode_1.Click += new System.EventHandler(this.button_mode_1_Click);
            //
            // button_mode_2
            //
            this.button_mode_2.Location = new System.Drawing.Point(90, 110);
            this.button_mode_2.Name = "button_mode_2";
            this.button_mode_2.Size = new System.Drawing.Size(72, 40);
            this.button_mode_2.TabIndex = 5;
            this.button_mode_2.Text = "Mode 2";
            this.button_mode_2.UseVisualStyleBackColor = false;
            this.button_mode_2.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button_mode_2.FlatAppearance.BorderSize = 0;
            this.button_mode_2.BackColor = this.primaryColor;
            this.button_mode_2.ForeColor = this.primaryForegroundColor;
            this.button_mode_2.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(
                20,
                20,
                20
            );
            this.button_mode_2.Click += new System.EventHandler(this.button_mode_2_Click);
            //
            // checkBox_control
            //
            this.checkBox_control.AutoSize = true;
            this.checkBox_control.Location = new System.Drawing.Point(16, 32);
            this.checkBox_control.Name = "checkBox_control";
            this.checkBox_control.Size = new System.Drawing.Size(93, 24);
            this.checkBox_control.TabIndex = 5;
            this.checkBox_control.Text = "No signal";
            this.checkBox_control.UseVisualStyleBackColor = true;
            this.checkBox_control.CheckedChanged += new System.EventHandler(
                this.checkBox_control_CheckedChanged
            );
            //
            // button_mode_3
            //
            this.button_mode_3.Location = new System.Drawing.Point(164, 110);
            this.button_mode_3.Name = "button_mode_3";
            this.button_mode_3.Size = new System.Drawing.Size(72, 40);
            this.button_mode_3.TabIndex = 6;
            this.button_mode_3.Text = "Mode 3";
            this.button_mode_3.UseVisualStyleBackColor = false;
            this.button_mode_3.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button_mode_3.FlatAppearance.BorderSize = 0;
            this.button_mode_3.BackColor = this.primaryColor;
            this.button_mode_3.ForeColor = this.primaryForegroundColor;
            this.button_mode_3.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(
                20,
                20,
                20
            );
            this.button_mode_3.Click += new System.EventHandler(this.button_mode_3_Click);
            //
            // serialPort
            //
            this.serialPort.PortName = "COM2";
            this.serialPort.DataReceived += new System.IO.Ports.SerialDataReceivedEventHandler(
                this.serialPort_DataReceived
            );
            //
            // Form1
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(550, 236);
            this.BackColor = this.backgroundColor;
            this.ForeColor = this.foregroundColor;
            this.Controls.Add(this.label_title);
            this.Controls.Add(this.groupBox_controller);
            this.Controls.Add(this.groupBox_connect);
            this.Font = new System.Drawing.Font(
                "Microsoft Sans Serif",
                12F,
                System.Drawing.FontStyle.Regular,
                System.Drawing.GraphicsUnit.Point,
                ((byte)(0))
            );
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.Text = "Communication with Traffic Lights";
            this.TopMost = true;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(
                this.Form1_FormClosing
            );
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox_connect.ResumeLayout(false);
            this.groupBox_connect.PerformLayout();
            this.groupBox_controller.ResumeLayout(false);
            this.groupBox_controller.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_led)).EndInit();
            this.ResumeLayout(false);
        }

        #endregion

        private System.Drawing.Color backgroundColor;
        private System.Drawing.Color foregroundColor;
        private System.Drawing.Color primaryColor;
        private System.Drawing.Color primaryForegroundColor;
        private System.Drawing.Color successColor;
        private System.Drawing.Color destructiveColor;

        private System.Windows.Forms.GroupBox groupBox_connect;
        private System.Windows.Forms.GroupBox groupBox_controller;
        private System.Windows.Forms.TextBox textBox_status;
        private System.Windows.Forms.Label label_serial_port;
        private System.Windows.Forms.ComboBox comboBox_COMP;
        private System.Windows.Forms.Button button_disconnect;
        private System.Windows.Forms.Button button_connect;
        private System.Windows.Forms.CheckBox checkBox_control;
        private System.Windows.Forms.Button button_mode_1;
        private System.Windows.Forms.Button button_mode_2;
        private System.Windows.Forms.Button button_mode_3;
        private System.Windows.Forms.TextBox textBox_mode;
        private System.Windows.Forms.Label label_mode;
        private System.Windows.Forms.Label label_title;
        private System.IO.Ports.SerialPort serialPort;
        private System.Windows.Forms.PictureBox pictureBox_led;
    }
}
