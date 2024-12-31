namespace sw
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.button_Disconnect = new System.Windows.Forms.Button();
            this.button_Connect = new System.Windows.Forms.Button();
            this.textBox_Status = new System.Windows.Forms.TextBox();
            this.comboBox_COMP = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.textBox_mode = new System.Windows.Forms.TextBox();
            this.button_mode_3 = new System.Windows.Forms.Button();
            this.button_mode_2 = new System.Windows.Forms.Button();
            this.button_mode_1 = new System.Windows.Forms.Button();
            this.serialPort = new System.IO.Ports.SerialPort(this.components);
            this.checkBox_Control = new System.Windows.Forms.CheckBox();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.button_Disconnect);
            this.groupBox1.Controls.Add(this.button_Connect);
            this.groupBox1.Controls.Add(this.textBox_Status);
            this.groupBox1.Controls.Add(this.comboBox_COMP);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(13, 14);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.groupBox1.Size = new System.Drawing.Size(225, 183);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Communication Setup";
            // 
            // button_Disconnect
            // 
            this.button_Disconnect.Location = new System.Drawing.Point(118, 139);
            this.button_Disconnect.Name = "button_Disconnect";
            this.button_Disconnect.Size = new System.Drawing.Size(100, 25);
            this.button_Disconnect.TabIndex = 0;
            this.button_Disconnect.Text = "Disconnect";
            this.button_Disconnect.UseVisualStyleBackColor = true;
            this.button_Disconnect.Click += new System.EventHandler(this.button_Disconnect_Click);
            // 
            // button_Connect
            // 
            this.button_Connect.Location = new System.Drawing.Point(12, 139);
            this.button_Connect.Name = "button_Connect";
            this.button_Connect.Size = new System.Drawing.Size(100, 25);
            this.button_Connect.TabIndex = 0;
            this.button_Connect.Text = "Connect";
            this.button_Connect.UseVisualStyleBackColor = true;
            this.button_Connect.Click += new System.EventHandler(this.button_Connect_Click);
            // 
            // textBox_Status
            // 
            this.textBox_Status.BackColor = System.Drawing.Color.Red;
            this.textBox_Status.ForeColor = System.Drawing.Color.White;
            this.textBox_Status.Location = new System.Drawing.Point(52, 90);
            this.textBox_Status.Name = "textBox_Status";
            this.textBox_Status.ReadOnly = true;
            this.textBox_Status.Size = new System.Drawing.Size(120, 26);
            this.textBox_Status.TabIndex = 0;
            this.textBox_Status.Text = "Disconnected";
            this.textBox_Status.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // comboBox_COMP
            // 
            this.comboBox_COMP.FormattingEnabled = true;
            this.comboBox_COMP.Location = new System.Drawing.Point(103, 38);
            this.comboBox_COMP.Name = "comboBox_COMP";
            this.comboBox_COMP.Size = new System.Drawing.Size(115, 28);
            this.comboBox_COMP.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(8, 41);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(88, 20);
            this.label1.TabIndex = 2;
            this.label1.Text = "COMP Port";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.checkBox_Control);
            this.groupBox2.Controls.Add(this.textBox_mode);
            this.groupBox2.Controls.Add(this.button_mode_3);
            this.groupBox2.Controls.Add(this.button_mode_2);
            this.groupBox2.Controls.Add(this.button_mode_1);
            this.groupBox2.Location = new System.Drawing.Point(246, 14);
            this.groupBox2.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Padding = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.groupBox2.Size = new System.Drawing.Size(225, 183);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Mode Switcher";
            // 
            // textBox_mode
            // 
            this.textBox_mode.Location = new System.Drawing.Point(7, 90);
            this.textBox_mode.Name = "textBox_mode";
            this.textBox_mode.ReadOnly = true;
            this.textBox_mode.Size = new System.Drawing.Size(100, 26);
            this.textBox_mode.TabIndex = 3;
            this.textBox_mode.Text = "Mode 3";
            this.textBox_mode.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // button_mode_3
            // 
            this.button_mode_3.Location = new System.Drawing.Point(143, 139);
            this.button_mode_3.Name = "button_mode_3";
            this.button_mode_3.Size = new System.Drawing.Size(75, 25);
            this.button_mode_3.TabIndex = 2;
            this.button_mode_3.Text = "Mode 3";
            this.button_mode_3.UseVisualStyleBackColor = true;
            this.button_mode_3.Click += new System.EventHandler(this.button_mode_3_Click);
            // 
            // button_mode_2
            // 
            this.button_mode_2.Location = new System.Drawing.Point(143, 90);
            this.button_mode_2.Name = "button_mode_2";
            this.button_mode_2.Size = new System.Drawing.Size(75, 25);
            this.button_mode_2.TabIndex = 1;
            this.button_mode_2.Text = "Mode 2";
            this.button_mode_2.UseVisualStyleBackColor = true;
            this.button_mode_2.Click += new System.EventHandler(this.button_mode_2_Click);
            // 
            // button_mode_1
            // 
            this.button_mode_1.Location = new System.Drawing.Point(143, 38);
            this.button_mode_1.Name = "button_mode_1";
            this.button_mode_1.Size = new System.Drawing.Size(75, 25);
            this.button_mode_1.TabIndex = 0;
            this.button_mode_1.Text = "Mode 1";
            this.button_mode_1.UseVisualStyleBackColor = true;
            this.button_mode_1.Click += new System.EventHandler(this.button_mode_1_Click);
            // 
            // serialPort
            // 
            this.serialPort.PortName = "COM2";
            this.serialPort.DataReceived += new System.IO.Ports.SerialDataReceivedEventHandler(this.serialPort_DataReceived);
            // 
            // checkBox_Control
            // 
            this.checkBox_Control.AutoSize = true;
            this.checkBox_Control.Location = new System.Drawing.Point(7, 38);
            this.checkBox_Control.Name = "checkBox_Control";
            this.checkBox_Control.Size = new System.Drawing.Size(79, 24);
            this.checkBox_Control.TabIndex = 4;
            this.checkBox_Control.Text = "Control";
            this.checkBox_Control.UseVisualStyleBackColor = true;
            this.checkBox_Control.CheckedChanged += new System.EventHandler(this.checkBox_Control_CheckedChanged);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(484, 211);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.Text = "Den giao thong";
            this.TopMost = true;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button button_Connect;
        private System.Windows.Forms.TextBox textBox_Status;
        private System.Windows.Forms.ComboBox comboBox_COMP;
        private System.Windows.Forms.Button button_Disconnect;
        private System.IO.Ports.SerialPort serialPort;
        private System.Windows.Forms.Button button_mode_3;
        private System.Windows.Forms.Button button_mode_2;
        private System.Windows.Forms.Button button_mode_1;
        private System.Windows.Forms.TextBox textBox_mode;
        private System.Windows.Forms.CheckBox checkBox_Control;
    }
}

