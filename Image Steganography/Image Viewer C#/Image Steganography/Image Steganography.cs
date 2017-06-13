using System;
using System.Drawing;
using System.Windows.Forms;

namespace Image_Steganography
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private void LoadBitMap_Click(object sender, EventArgs e)
        {
            OpenFileDialog Selector = new OpenFileDialog();
            Selector.Filter = "Image Files(*.jpg; *.jpeg; *.gif; *.bmp)|*.jpg; *.jpeg; *.gif; *.bmp";
            if (Selector.ShowDialog() == DialogResult.OK)
            {
                Bitmap Bmp = new Bitmap(Selector.FileName);
                ImageViewer.Image = Bmp;
                ImageView.Img = Bmp;
            }
            FilePath.Text = Selector.FileName;
        }
        private void LoadTextFile_Click(object sender, EventArgs e)
        {
            try
            {
                OpenFileDialog Selector = new OpenFileDialog();
                Selector.Filter = "Text Files(*.txt;)|*.txt;";
                if (Selector.ShowDialog() == DialogResult.OK)
                {
                    ImageView.LoadImgFromTxt(Selector.FileName);
                    ImageViewer.Image = ImageView.Img;
                }
                FilePath.Text = Selector.FileName;
            }
            catch (Exception)
            {
                MessageBox.Show("Please Provide A Valid Text File", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void SaveAsBitmap_Click(object sender, EventArgs e)
        {
            if (ImageView.Img != null)
            {
                SaveFileDialog Selector = new SaveFileDialog();
                Selector.Filter = "Image Files(*.jpg; *.jpeg; *.gif; *.bmp)|*.jpg; *.jpeg; *.gif; *.bmp";
                if (Selector.ShowDialog() == DialogResult.OK)
                {
                    ImageView.Img.Save(Selector.FileName);
                }
                FilePath.Text = Selector.FileName;
            }
        }

        private void SaveAsTextFile_Click(object sender, EventArgs e)
        {
            if (ImageView.Img != null)
            {
                SaveFileDialog Selector = new SaveFileDialog();
                Selector.Filter = "Text Files(*.txt;)|*.txt;";
                if (Selector.ShowDialog() == DialogResult.OK)
                {
                    ImageView.SaveAsTxt(Selector.FileName);
                }
                FilePath.Text = Selector.FileName;
            }
        }
    }
}
