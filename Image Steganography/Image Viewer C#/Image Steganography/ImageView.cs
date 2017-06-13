using System;
using System.Drawing;
using System.IO;

namespace Image_Steganography
{
    public static class ImageView
    {
        public static Bitmap Img = null;
        public static void LoadImgFromTxt(string FilePath)
        {
            StreamReader SR = new StreamReader(FilePath);
            int Height = Convert.ToInt32(SR.ReadLine());
            int Width = Convert.ToInt32(SR.ReadLine());

            Img = new Bitmap(Width, Height);

            for (int i = 0; i < Width; i++)
            {
                for (int j = 0; j < Height; j++)
                {
                    int R = Convert.ToInt32(SR.ReadLine());
                    int G = Convert.ToInt32(SR.ReadLine());
                    int B = Convert.ToInt32(SR.ReadLine());
                    Img.SetPixel(i, j, Color.FromArgb(R, G, B));
                }
            }
            SR.Close();
        }
        public static void SaveAsTxt(string FilePath)
        {
            StreamWriter SR = new StreamWriter(FilePath);
            SR.WriteLine(Img.Height);
            SR.WriteLine(Img.Width);

            int Height = Img.Height;
            int Width = Img.Width;

            for (int i = 0; i < Width; i++)
            {
                for (int j = 0; j < Height; j++)
                {
                    Color RGB = Img.GetPixel(i, j);
                    SR.WriteLine(RGB.R);
                    SR.WriteLine(RGB.G);
                    SR.WriteLine(RGB.B);
                }
            }
            SR.Close();
        }
    }
}
