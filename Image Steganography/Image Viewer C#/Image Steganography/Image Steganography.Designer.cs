namespace Image_Steganography
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
            this.ImageViewer = new System.Windows.Forms.PictureBox();
            this.SaveAsBitmap = new System.Windows.Forms.Button();
            this.SaveAsTextFile = new System.Windows.Forms.Button();
            this.LoadBitMap = new System.Windows.Forms.Button();
            this.LoadTextFile = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.FilePath = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.ImageViewer)).BeginInit();
            this.SuspendLayout();
            // 
            // ImageViewer
            // 
            this.ImageViewer.Location = new System.Drawing.Point(12, 3);
            this.ImageViewer.Name = "ImageViewer";
            this.ImageViewer.Size = new System.Drawing.Size(560, 290);
            this.ImageViewer.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.ImageViewer.TabIndex = 0;
            this.ImageViewer.TabStop = false;
            // 
            // SaveAsBitmap
            // 
            this.SaveAsBitmap.Font = new System.Drawing.Font("Comic Sans MS", 8.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.SaveAsBitmap.Location = new System.Drawing.Point(294, 299);
            this.SaveAsBitmap.Name = "SaveAsBitmap";
            this.SaveAsBitmap.Size = new System.Drawing.Size(130, 50);
            this.SaveAsBitmap.TabIndex = 3;
            this.SaveAsBitmap.Text = "Save As Bitmap";
            this.SaveAsBitmap.UseVisualStyleBackColor = true;
            this.SaveAsBitmap.Click += new System.EventHandler(this.SaveAsBitmap_Click);
            // 
            // SaveAsTextFile
            // 
            this.SaveAsTextFile.Font = new System.Drawing.Font("Comic Sans MS", 8.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.SaveAsTextFile.Location = new System.Drawing.Point(431, 299);
            this.SaveAsTextFile.Name = "SaveAsTextFile";
            this.SaveAsTextFile.Size = new System.Drawing.Size(130, 50);
            this.SaveAsTextFile.TabIndex = 4;
            this.SaveAsTextFile.Text = "Save As TextFile";
            this.SaveAsTextFile.UseVisualStyleBackColor = true;
            this.SaveAsTextFile.Click += new System.EventHandler(this.SaveAsTextFile_Click);
            // 
            // LoadBitMap
            // 
            this.LoadBitMap.Font = new System.Drawing.Font("Comic Sans MS", 8.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.LoadBitMap.Location = new System.Drawing.Point(22, 299);
            this.LoadBitMap.Name = "LoadBitMap";
            this.LoadBitMap.Size = new System.Drawing.Size(130, 50);
            this.LoadBitMap.TabIndex = 1;
            this.LoadBitMap.Text = "Load BitMap";
            this.LoadBitMap.UseVisualStyleBackColor = true;
            this.LoadBitMap.Click += new System.EventHandler(this.LoadBitMap_Click);
            // 
            // LoadTextFile
            // 
            this.LoadTextFile.Font = new System.Drawing.Font("Comic Sans MS", 8.25F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.LoadTextFile.Location = new System.Drawing.Point(158, 299);
            this.LoadTextFile.Name = "LoadTextFile";
            this.LoadTextFile.Size = new System.Drawing.Size(130, 50);
            this.LoadTextFile.TabIndex = 2;
            this.LoadTextFile.Text = "Load TextFile";
            this.LoadTextFile.UseVisualStyleBackColor = true;
            this.LoadTextFile.Click += new System.EventHandler(this.LoadTextFile_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Comic Sans MS", 11F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))));
            this.label1.Location = new System.Drawing.Point(18, 350);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(88, 22);
            this.label1.TabIndex = 5;
            this.label1.Text = "File Path: ";
            // 
            // FilePath
            // 
            this.FilePath.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.FilePath.Location = new System.Drawing.Point(102, 352);
            this.FilePath.Name = "FilePath";
            this.FilePath.ReadOnly = true;
            this.FilePath.Size = new System.Drawing.Size(459, 20);
            this.FilePath.TabIndex = 6;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(584, 380);
            this.Controls.Add(this.FilePath);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.LoadTextFile);
            this.Controls.Add(this.LoadBitMap);
            this.Controls.Add(this.SaveAsTextFile);
            this.Controls.Add(this.SaveAsBitmap);
            this.Controls.Add(this.ImageViewer);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Name = "Form1";
            this.Text = "Image Steganography";
            ((System.ComponentModel.ISupportInitialize)(this.ImageViewer)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.PictureBox ImageViewer;
        private System.Windows.Forms.Button SaveAsBitmap;
        private System.Windows.Forms.Button SaveAsTextFile;
        private System.Windows.Forms.Button LoadBitMap;
        private System.Windows.Forms.Button LoadTextFile;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox FilePath;
    }
}

