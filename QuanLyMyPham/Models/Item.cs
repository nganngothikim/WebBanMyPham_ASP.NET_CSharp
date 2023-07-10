using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuanLyMyPham.Models
{
    public class Item
    {
        Sa_1DataContext dl = new Sa_1DataContext();
        public int maSP { get; set; }
        public string tenSP { get; set; }
        public string anhBia { get; set; }
        public float donGia { get; set; }
        public string moTa { get; set; }      
        public int soLuong { get; set; }
        public float thanhTien { get { return soLuong * donGia; } }

        public Item(int ms)
        {
            maSP = ms;
            SanPham s = dl.SanPhams.FirstOrDefault(t => t.MaSP == ms);
            tenSP = s.TenSP;
            anhBia = s.DuongDan;
            donGia = float.Parse(s.Gia.ToString());
            moTa = s.MoTa;
            soLuong = 1;
        }
        public Item(int ms, int sl)
        {
            maSP = ms;
            SanPham s = dl.SanPhams.FirstOrDefault(t => t.MaSP == ms);
            tenSP = s.TenSP;
            anhBia = s.DuongDan;
            donGia = float.Parse(s.Gia.ToString());
            moTa = s.MoTa;
            soLuong = sl;
        }

    }

    public class GioHang1
    {
        public List<Item> dssp;
        public GioHang1()
        {
            dssp = new List<Item>();
        }
        public void Them(Item x)
        {
            dssp.Add(x);
        }
        public int SLMatHang()
        {
            return dssp.Count();
        }
        public int TongSL()
        {
            return dssp.Sum(t => t.soLuong);
        }
        public float TongTien()
        {
            return dssp.Sum(t => t.thanhTien);
        }
        public int Xoa(int ma)
        {
            Item sp = dssp.Find(n => n.maSP == ma);
            if (sp != null)
            {
                dssp.Remove(sp);
                return 1;
            }
            return -1;

        }
        public int XoaAll()
        {
            if (dssp != null)
            {
                dssp.Clear();
                return 1;
            }
            return -1;

        }
    }
}