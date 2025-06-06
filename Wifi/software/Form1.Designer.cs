﻿namespace software
{
    partial class Software
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
            {
                components.Dispose();
            }
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Software));
            this.groupBox_connection = new System.Windows.Forms.GroupBox();
            this.label_PORT = new System.Windows.Forms.Label();
            this.label_IP = new System.Windows.Forms.Label();
            this.textBox_PORT = new System.Windows.Forms.TextBox();
            this.textBox_IP = new System.Windows.Forms.TextBox();
            this.label_status = new System.Windows.Forms.Label();
            this.button_connect = new System.Windows.Forms.Button();
            this.groupBox_information = new System.Windows.Forms.GroupBox();
            this.label_id = new System.Windows.Forms.Label();
            this.label_name = new System.Windows.Forms.Label();
            this.pictureBox_led_status = new System.Windows.Forms.PictureBox();
            this.button_control_state = new System.Windows.Forms.Button();
            this.label_control = new System.Windows.Forms.Label();
            this.label_mode_value = new System.Windows.Forms.Label();
            this.label_mode = new System.Windows.Forms.Label();
            this.label_time_value = new System.Windows.Forms.Label();
            this.label_time = new System.Windows.Forms.Label();
            this.Controller = new System.Windows.Forms.GroupBox();
            this.button_mode_3 = new System.Windows.Forms.Button();
            this.button_mode_2 = new System.Windows.Forms.Button();
            this.button_mode_1 = new System.Windows.Forms.Button();
            this.button_save_time = new System.Windows.Forms.Button();
            this.textBox_green_value = new System.Windows.Forms.TextBox();
            this.label_green = new System.Windows.Forms.Label();
            this.textBox_yellow_value = new System.Windows.Forms.TextBox();
            this.label_yellow = new System.Windows.Forms.Label();
            this.textBox_red_value = new System.Windows.Forms.TextBox();
            this.label_red = new System.Windows.Forms.Label();
            this.label_title = new System.Windows.Forms.Label();
            this.timer = new System.Windows.Forms.Timer(this.components);
            this.richTextBox_log = new System.Windows.Forms.RichTextBox();
            this.groubBox_logs = new System.Windows.Forms.GroupBox();
            this.groupBox_connection.SuspendLayout();
            this.groupBox_information.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_led_status)).BeginInit();
            this.Controller.SuspendLayout();
            this.groubBox_logs.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox_connection
            // 
            this.groupBox_connection.Controls.Add(this.label_PORT);
            this.groupBox_connection.Controls.Add(this.label_IP);
            this.groupBox_connection.Controls.Add(this.textBox_PORT);
            this.groupBox_connection.Controls.Add(this.textBox_IP);
            this.groupBox_connection.Controls.Add(this.label_status);
            this.groupBox_connection.Controls.Add(this.button_connect);
            this.groupBox_connection.Location = new System.Drawing.Point(14, 77);
            this.groupBox_connection.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.groupBox_connection.Name = "groupBox_connection";
            this.groupBox_connection.Padding = new System.Windows.Forms.Padding(12, 8, 12, 8);
            this.groupBox_connection.Size = new System.Drawing.Size(457, 150);
            this.groupBox_connection.TabIndex = 0;
            this.groupBox_connection.TabStop = false;
            this.groupBox_connection.Text = "Connection Status";
            // 
            // label_PORT
            // 
            this.label_PORT.AutoSize = true;
            this.label_PORT.Font = new System.Drawing.Font("Geist", 14F);
            this.label_PORT.Location = new System.Drawing.Point(154, 40);
            this.label_PORT.Name = "label_PORT";
            this.label_PORT.Size = new System.Drawing.Size(59, 24);
            this.label_PORT.TabIndex = 6;
            this.label_PORT.Text = "PORT";
            // 
            // label_IP
            // 
            this.label_IP.AutoSize = true;
            this.label_IP.Font = new System.Drawing.Font("Geist", 14F);
            this.label_IP.Location = new System.Drawing.Point(11, 40);
            this.label_IP.Name = "label_IP";
            this.label_IP.Size = new System.Drawing.Size(27, 24);
            this.label_IP.TabIndex = 5;
            this.label_IP.Text = "IP";
            // 
            // textBox_PORT
            // 
            this.textBox_PORT.Location = new System.Drawing.Point(219, 40);
            this.textBox_PORT.Name = "textBox_PORT";
            this.textBox_PORT.Size = new System.Drawing.Size(53, 28);
            this.textBox_PORT.TabIndex = 4;
            this.textBox_PORT.Text = "3000";
            this.textBox_PORT.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.textBox_PORT.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.validateInput);
            // 
            // textBox_IP
            // 
            this.textBox_IP.Location = new System.Drawing.Point(44, 40);
            this.textBox_IP.Name = "textBox_IP";
            this.textBox_IP.Size = new System.Drawing.Size(104, 28);
            this.textBox_IP.TabIndex = 3;
            this.textBox_IP.Text = "192.168.1.100";
            this.textBox_IP.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.textBox_IP.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.validateInput);
            // 
            // label_status
            // 
            this.label_status.Font = new System.Drawing.Font("Geist Medium", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label_status.ForeColor = System.Drawing.Color.Red;
            this.label_status.Location = new System.Drawing.Point(15, 96);
            this.label_status.Name = "label_status";
            this.label_status.Size = new System.Drawing.Size(427, 27);
            this.label_status.TabIndex = 2;
            this.label_status.Text = "Disconnected";
            this.label_status.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // button_connect
            // 
            this.button_connect.Location = new System.Drawing.Point(278, 37);
            this.button_connect.Margin = new System.Windows.Forms.Padding(9, 3, 3, 3);
            this.button_connect.Name = "button_connect";
            this.button_connect.Size = new System.Drawing.Size(164, 32);
            this.button_connect.TabIndex = 1;
            this.button_connect.Text = "Connect";
            this.button_connect.UseVisualStyleBackColor = true;
            this.button_connect.Click += new System.EventHandler(this.button_connect_Click);
            // 
            // groupBox_information
            // 
            this.groupBox_information.Controls.Add(this.label_id);
            this.groupBox_information.Controls.Add(this.label_name);
            this.groupBox_information.Controls.Add(this.pictureBox_led_status);
            this.groupBox_information.Controls.Add(this.button_control_state);
            this.groupBox_information.Controls.Add(this.label_control);
            this.groupBox_information.Controls.Add(this.label_mode_value);
            this.groupBox_information.Controls.Add(this.label_mode);
            this.groupBox_information.Controls.Add(this.label_time_value);
            this.groupBox_information.Controls.Add(this.label_time);
            this.groupBox_information.Location = new System.Drawing.Point(14, 237);
            this.groupBox_information.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.groupBox_information.Name = "groupBox_information";
            this.groupBox_information.Padding = new System.Windows.Forms.Padding(12, 8, 12, 8);
            this.groupBox_information.Size = new System.Drawing.Size(457, 174);
            this.groupBox_information.TabIndex = 1;
            this.groupBox_information.TabStop = false;
            this.groupBox_information.Text = "Information";
            // 
            // label_id
            // 
            this.label_id.AutoSize = true;
            this.label_id.Font = new System.Drawing.Font("Geist", 16F);
            this.label_id.Location = new System.Drawing.Point(325, 122);
            this.label_id.Name = "label_id";
            this.label_id.Size = new System.Drawing.Size(117, 28);
            this.label_id.TabIndex = 7;
            this.label_id.Text = "22653991";
            // 
            // label_name
            // 
            this.label_name.AutoSize = true;
            this.label_name.Font = new System.Drawing.Font("Geist", 16F);
            this.label_name.Location = new System.Drawing.Point(214, 122);
            this.label_name.Name = "label_name";
            this.label_name.Size = new System.Drawing.Size(103, 28);
            this.label_name.TabIndex = 7;
            this.label_name.Text = "Trần Tiến";
            // 
            // pictureBox_led_status
            // 
            this.pictureBox_led_status.ErrorImage = null;
            this.pictureBox_led_status.Image = global::software.Properties.Resources.off;
            this.pictureBox_led_status.InitialImage = null;
            this.pictureBox_led_status.Location = new System.Drawing.Point(219, 32);
            this.pictureBox_led_status.Margin = new System.Windows.Forms.Padding(12, 3, 3, 12);
            this.pictureBox_led_status.Name = "pictureBox_led_status";
            this.pictureBox_led_status.Size = new System.Drawing.Size(223, 74);
            this.pictureBox_led_status.TabIndex = 6;
            this.pictureBox_led_status.TabStop = false;
            // 
            // button_control_state
            // 
            this.button_control_state.Enabled = false;
            this.button_control_state.Location = new System.Drawing.Point(104, 120);
            this.button_control_state.Name = "button_control_state";
            this.button_control_state.Size = new System.Drawing.Size(92, 34);
            this.button_control_state.TabIndex = 5;
            this.button_control_state.Text = "No Signal";
            this.button_control_state.UseVisualStyleBackColor = true;
            this.button_control_state.Click += new System.EventHandler(this.button_control_state_Click);
            // 
            // label_control
            // 
            this.label_control.AutoSize = true;
            this.label_control.Font = new System.Drawing.Font("Geist", 14F);
            this.label_control.Location = new System.Drawing.Point(16, 124);
            this.label_control.Margin = new System.Windows.Forms.Padding(3, 12, 3, 12);
            this.label_control.Name = "label_control";
            this.label_control.Size = new System.Drawing.Size(79, 24);
            this.label_control.TabIndex = 4;
            this.label_control.Text = "Control:";
            // 
            // label_mode_value
            // 
            this.label_mode_value.AutoSize = true;
            this.label_mode_value.Font = new System.Drawing.Font("Geist", 14F);
            this.label_mode_value.Location = new System.Drawing.Point(100, 77);
            this.label_mode_value.Name = "label_mode_value";
            this.label_mode_value.Size = new System.Drawing.Size(22, 24);
            this.label_mode_value.TabIndex = 3;
            this.label_mode_value.Text = "3";
            this.label_mode_value.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // label_mode
            // 
            this.label_mode.AutoSize = true;
            this.label_mode.Font = new System.Drawing.Font("Geist", 14F);
            this.label_mode.Location = new System.Drawing.Point(15, 77);
            this.label_mode.Margin = new System.Windows.Forms.Padding(3, 12, 3, 12);
            this.label_mode.Name = "label_mode";
            this.label_mode.Size = new System.Drawing.Size(66, 24);
            this.label_mode.TabIndex = 2;
            this.label_mode.Text = "Mode:";
            // 
            // label_time_value
            // 
            this.label_time_value.AutoSize = true;
            this.label_time_value.Font = new System.Drawing.Font("Geist", 14F);
            this.label_time_value.Location = new System.Drawing.Point(100, 32);
            this.label_time_value.Name = "label_time_value";
            this.label_time_value.Size = new System.Drawing.Size(48, 24);
            this.label_time_value.TabIndex = 1;
            this.label_time_value.Text = "hole";
            // 
            // label_time
            // 
            this.label_time.AutoSize = true;
            this.label_time.Font = new System.Drawing.Font("Geist", 14F);
            this.label_time.Location = new System.Drawing.Point(15, 32);
            this.label_time.Margin = new System.Windows.Forms.Padding(3, 0, 3, 12);
            this.label_time.Name = "label_time";
            this.label_time.Size = new System.Drawing.Size(58, 24);
            this.label_time.TabIndex = 0;
            this.label_time.Text = "Time:";
            // 
            // Controller
            // 
            this.Controller.Controls.Add(this.button_mode_3);
            this.Controller.Controls.Add(this.button_mode_2);
            this.Controller.Controls.Add(this.button_mode_1);
            this.Controller.Controls.Add(this.button_save_time);
            this.Controller.Controls.Add(this.textBox_green_value);
            this.Controller.Controls.Add(this.label_green);
            this.Controller.Controls.Add(this.textBox_yellow_value);
            this.Controller.Controls.Add(this.label_yellow);
            this.Controller.Controls.Add(this.textBox_red_value);
            this.Controller.Controls.Add(this.label_red);
            this.Controller.Location = new System.Drawing.Point(14, 421);
            this.Controller.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Controller.Name = "Controller";
            this.Controller.Padding = new System.Windows.Forms.Padding(12, 8, 12, 8);
            this.Controller.Size = new System.Drawing.Size(457, 200);
            this.Controller.TabIndex = 1;
            this.Controller.TabStop = false;
            this.Controller.Text = "Controller";
            // 
            // button_mode_3
            // 
            this.button_mode_3.Enabled = false;
            this.button_mode_3.Location = new System.Drawing.Point(219, 149);
            this.button_mode_3.Margin = new System.Windows.Forms.Padding(12, 3, 3, 12);
            this.button_mode_3.Name = "button_mode_3";
            this.button_mode_3.Size = new System.Drawing.Size(223, 40);
            this.button_mode_3.TabIndex = 9;
            this.button_mode_3.Text = "Mode 3";
            this.button_mode_3.UseVisualStyleBackColor = true;
            this.button_mode_3.Click += new System.EventHandler(this.button_mode_Click);
            // 
            // button_mode_2
            // 
            this.button_mode_2.Enabled = false;
            this.button_mode_2.Location = new System.Drawing.Point(219, 96);
            this.button_mode_2.Margin = new System.Windows.Forms.Padding(12, 3, 3, 12);
            this.button_mode_2.Name = "button_mode_2";
            this.button_mode_2.Size = new System.Drawing.Size(223, 40);
            this.button_mode_2.TabIndex = 8;
            this.button_mode_2.Text = "Mode 2";
            this.button_mode_2.UseVisualStyleBackColor = true;
            this.button_mode_2.Click += new System.EventHandler(this.button_mode_Click);
            // 
            // button_mode_1
            // 
            this.button_mode_1.Enabled = false;
            this.button_mode_1.Location = new System.Drawing.Point(219, 41);
            this.button_mode_1.Margin = new System.Windows.Forms.Padding(12, 3, 3, 12);
            this.button_mode_1.Name = "button_mode_1";
            this.button_mode_1.Size = new System.Drawing.Size(223, 40);
            this.button_mode_1.TabIndex = 7;
            this.button_mode_1.Text = "Mode 1";
            this.button_mode_1.UseVisualStyleBackColor = true;
            this.button_mode_1.Click += new System.EventHandler(this.button_mode_Click);
            // 
            // button_save_time
            // 
            this.button_save_time.Enabled = false;
            this.button_save_time.Location = new System.Drawing.Point(15, 148);
            this.button_save_time.Name = "button_save_time";
            this.button_save_time.Size = new System.Drawing.Size(177, 41);
            this.button_save_time.TabIndex = 6;
            this.button_save_time.Text = "Save Changes";
            this.button_save_time.UseVisualStyleBackColor = true;
            this.button_save_time.Click += new System.EventHandler(this.button_save_time_Click);
            // 
            // textBox_green_value
            // 
            this.textBox_green_value.Enabled = false;
            this.textBox_green_value.Location = new System.Drawing.Point(100, 109);
            this.textBox_green_value.Name = "textBox_green_value";
            this.textBox_green_value.Size = new System.Drawing.Size(92, 28);
            this.textBox_green_value.TabIndex = 5;
            this.textBox_green_value.Text = "10";
            this.textBox_green_value.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.textBox_green_value.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.validateInput);
            this.textBox_green_value.Leave += new System.EventHandler(this.validateTime);
            // 
            // label_green
            // 
            this.label_green.AutoSize = true;
            this.label_green.Font = new System.Drawing.Font("Geist", 14F);
            this.label_green.Location = new System.Drawing.Point(15, 109);
            this.label_green.Margin = new System.Windows.Forms.Padding(3, 12, 3, 12);
            this.label_green.Name = "label_green";
            this.label_green.Size = new System.Drawing.Size(62, 24);
            this.label_green.TabIndex = 4;
            this.label_green.Text = "Green";
            // 
            // textBox_yellow_value
            // 
            this.textBox_yellow_value.Enabled = false;
            this.textBox_yellow_value.Location = new System.Drawing.Point(100, 75);
            this.textBox_yellow_value.Name = "textBox_yellow_value";
            this.textBox_yellow_value.Size = new System.Drawing.Size(92, 28);
            this.textBox_yellow_value.TabIndex = 3;
            this.textBox_yellow_value.Text = "3";
            this.textBox_yellow_value.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.textBox_yellow_value.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.validateInput);
            this.textBox_yellow_value.Leave += new System.EventHandler(this.validateTime);
            // 
            // label_yellow
            // 
            this.label_yellow.AutoSize = true;
            this.label_yellow.Font = new System.Drawing.Font("Geist", 14F);
            this.label_yellow.Location = new System.Drawing.Point(15, 75);
            this.label_yellow.Margin = new System.Windows.Forms.Padding(3, 12, 3, 12);
            this.label_yellow.Name = "label_yellow";
            this.label_yellow.Size = new System.Drawing.Size(68, 24);
            this.label_yellow.TabIndex = 2;
            this.label_yellow.Text = "Yellow";
            // 
            // textBox_red_value
            // 
            this.textBox_red_value.Enabled = false;
            this.textBox_red_value.Location = new System.Drawing.Point(100, 41);
            this.textBox_red_value.Name = "textBox_red_value";
            this.textBox_red_value.Size = new System.Drawing.Size(92, 28);
            this.textBox_red_value.TabIndex = 1;
            this.textBox_red_value.Text = "5";
            this.textBox_red_value.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.textBox_red_value.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.validateInput);
            this.textBox_red_value.Leave += new System.EventHandler(this.validateTime);
            // 
            // label_red
            // 
            this.label_red.AutoSize = true;
            this.label_red.Font = new System.Drawing.Font("Geist", 14F);
            this.label_red.Location = new System.Drawing.Point(15, 41);
            this.label_red.Margin = new System.Windows.Forms.Padding(3, 12, 3, 12);
            this.label_red.Name = "label_red";
            this.label_red.Size = new System.Drawing.Size(45, 24);
            this.label_red.TabIndex = 0;
            this.label_red.Text = "Red";
            // 
            // label_title
            // 
            this.label_title.AutoSize = true;
            this.label_title.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label_title.Location = new System.Drawing.Point(81, 25);
            this.label_title.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label_title.Name = "label_title";
            this.label_title.Size = new System.Drawing.Size(323, 29);
            this.label_title.TabIndex = 2;
            this.label_title.Text = "Communication using WiFi";
            // 
            // timer
            // 
            this.timer.Tick += new System.EventHandler(this.timer_Tick);
            // 
            // richTextBox_log
            // 
            this.richTextBox_log.Font = new System.Drawing.Font("GeistMono NF", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.richTextBox_log.Location = new System.Drawing.Point(15, 27);
            this.richTextBox_log.Margin = new System.Windows.Forms.Padding(12, 3, 3, 12);
            this.richTextBox_log.Name = "richTextBox_log";
            this.richTextBox_log.ReadOnly = true;
            this.richTextBox_log.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical;
            this.richTextBox_log.Size = new System.Drawing.Size(427, 100);
            this.richTextBox_log.TabIndex = 10;
            this.richTextBox_log.Text = "";
            // 
            // groubBox_logs
            // 
            this.groubBox_logs.Controls.Add(this.richTextBox_log);
            this.groubBox_logs.Font = new System.Drawing.Font("Geist", 12F);
            this.groubBox_logs.Location = new System.Drawing.Point(14, 629);
            this.groubBox_logs.Name = "groubBox_logs";
            this.groubBox_logs.Size = new System.Drawing.Size(457, 140);
            this.groubBox_logs.TabIndex = 3;
            this.groubBox_logs.TabStop = false;
            this.groubBox_logs.Text = "Logs";
            // 
            // Software
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(484, 781);
            this.Controls.Add(this.groubBox_logs);
            this.Controls.Add(this.groupBox_information);
            this.Controls.Add(this.Controller);
            this.Controls.Add(this.label_title);
            this.Controls.Add(this.groupBox_connection);
            this.Font = new System.Drawing.Font("Geist", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MaximizeBox = false;
            this.Name = "Software";
            this.Text = "Traffic Light";
            this.TopMost = true;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form_FormClosing);
            this.Load += new System.EventHandler(this.Form_Load);
            this.groupBox_connection.ResumeLayout(false);
            this.groupBox_connection.PerformLayout();
            this.groupBox_information.ResumeLayout(false);
            this.groupBox_information.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_led_status)).EndInit();
            this.Controller.ResumeLayout(false);
            this.Controller.PerformLayout();
            this.groubBox_logs.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox_connection;
        private System.Windows.Forms.GroupBox groupBox_information;
        private System.Windows.Forms.GroupBox Controller;
        private System.Windows.Forms.Label label_title;
        private System.Windows.Forms.Button button_connect;
        private System.Windows.Forms.Label label_status;
        private System.Windows.Forms.Label label_time;
        private System.Windows.Forms.Label label_time_value;
        private System.Windows.Forms.Timer timer;
        private System.Windows.Forms.Label label_mode;
        private System.Windows.Forms.Label label_control;
        private System.Windows.Forms.Label label_mode_value;
        private System.Windows.Forms.Button button_control_state;
        private System.Windows.Forms.PictureBox pictureBox_led_status;
        private System.Windows.Forms.Label label_red;
        private System.Windows.Forms.Label label_yellow;
        private System.Windows.Forms.TextBox textBox_red_value;
        private System.Windows.Forms.TextBox textBox_green_value;
        private System.Windows.Forms.Label label_green;
        private System.Windows.Forms.TextBox textBox_yellow_value;
        private System.Windows.Forms.Button button_mode_1;
        private System.Windows.Forms.Button button_save_time;
        private System.Windows.Forms.Button button_mode_3;
        private System.Windows.Forms.Button button_mode_2;
        private System.Windows.Forms.TextBox textBox_PORT;
        private System.Windows.Forms.TextBox textBox_IP;
        private System.Windows.Forms.Label label_PORT;
        private System.Windows.Forms.Label label_IP;
        private System.Windows.Forms.Label label_name;
        private System.Windows.Forms.Label label_id;
        private System.Windows.Forms.RichTextBox richTextBox_log;
        private System.Windows.Forms.GroupBox groubBox_logs;
    }
}
