using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QuanLyMyPham.Models;

namespace QuanLyMyPham.Controllers
{
    public class KhachHangController : Controller
    {
        //
        // GET: /KhachHang/
        Sa_1DataContext dl = new Sa_1DataContext();
        public ActionResult MenuLoaiSP()
        {
            List<Loai> ds = dl.Loais.ToList();
            return PartialView(ds);
        }
        public ActionResult SanPham()
        {
            List<SanPham> ds = dl.SanPhams.ToList();
            return View(ds);
        }

        public ActionResult HTSP_TheoLoai(int id)
        {
            List<SanPham> ds = dl.SanPhams.Where(t => t.MaLoai == id).ToList();
            return View("SanPham", ds);
        }
        [HttpPost]
        public ActionResult XLTimKiem(FormCollection fc)
        {
            string tensp = fc["search"];
            List<SanPham> ds1 = dl.SanPhams.Where(t => t.TenSP.Contains(tensp)).ToList();
            if (ds1.Count > 0)
            {
                return View("SanPham", ds1);
            }
            return View("SanPham");
        }
        public ActionResult ChietTietSP(int id)
        {
            SanPham ds = dl.SanPhams.FirstOrDefault(t => t.MaSP == id);
            return View(ds);
        }
        public GioHang1 LayGioHang()
        {
            GioHang1 gio = (GioHang1)Session["gh"];
            if (gio == null)
                gio = new GioHang1();
            return gio;
        }
        public void LuuGioHang(GioHang1 gio)
        {
            Session["gh"] = gio;
        }
        public ActionResult ChonMua(int id)
        {
            GioHang1 g = LayGioHang();
            Item i = g.dssp.FirstOrDefault(t => t.maSP == id);
            if (i == null)
            {
                Item x = new Item(id, 1);
                g.Them(x);
            }
            else
            {
                i.soLuong++;
            }
            LuuGioHang(g);
            return RedirectToAction("SanPham");
        }
        public ActionResult XemGioHang()
        {
            GioHang1 g = LayGioHang();
            List<Item> ds = g.dssp;
            return View(ds);
        }
        public ActionResult Xoa(int id)
        {
            GioHang1 g = LayGioHang();
            Item i = g.dssp.FirstOrDefault(t => t.maSP == id);
            if (i != null)
            {
                g.Xoa(i.maSP);
            }
            LuuGioHang(g);
            return RedirectToAction("XemGioHang");
        }
        public ActionResult SuaSoLuong(int SanPhamID, int soluongmoi)
        {
            GioHang1 g = LayGioHang();
            Item itemSua = g.dssp.FirstOrDefault(t => t.maSP == SanPhamID);
            if (itemSua != null)
            {
                itemSua.soLuong = soluongmoi;
            }
            else
            {
                Item x = new Item(SanPhamID, soluongmoi);
                g.Them(x);
            }
            LuuGioHang(g);
            return RedirectToAction("XemGioHang");

        }

        public ActionResult XacNhanDatHang()
        {
            KhachHang kh = (KhachHang)Session["kh"];
            if (kh != null)
            {

                return View(kh);
            }
            else
            {
                return RedirectToAction("DangNhap", "TaiKhoan");
            }


        }
        [HttpPost]
        public ActionResult XacNhanDatHang(FormCollection coll)
        {

            KhachHang kh = (KhachHang)Session["kh"];
            if (kh != null)//kiểm tra có khách hàng ko
            {
                GioHang1 gio = (GioHang1)Session["gh"];
                if (Session["gh"] == null && gio.dssp.Count == 0)
                    return RedirectToAction("XemGioHang");
                HoaDon hd = new HoaDon();
                GiaoHang giao = new GiaoHang();

                hd.NgayHoaDon = DateTime.Now;
                hd.MaKH = kh.MaKH;
                hd.NgayGiao = Convert.ToDateTime(coll["date"]);
                hd.ThanhTien = gio.TongTien();
                dl.HoaDons.InsertOnSubmit(hd);
                dl.SubmitChanges();
                nhapChiTietHoaDon(hd, gio);
                giao.MaHoaDon = hd.MaHoaDon;
                giao.DiaChi = coll["dchi"];
                dl.GiaoHangs.InsertOnSubmit(giao);
                dl.SubmitChanges();
                return View("HoanThanhDatHang", giao);
            }
            else
            {
                return RedirectToAction("DangNhap", "TaiKhoan");
            }
        }
        public int nhapChiTietHoaDon(HoaDon hd, GioHang1 gio)//thêm chi tiết hóa đơn cùng mã hóa đơn
        {
            if (hd != null)
            {
                foreach (Item i in gio.dssp)
                {
                    ChiTietHoaDon ct = new ChiTietHoaDon();
                    ct.MaHoaDon = hd.MaHoaDon;
                    ct.MaSP = i.maSP;
                    ct.SoLuong = i.soLuong;
                    dl.ChiTietHoaDons.InsertOnSubmit(ct);
                    dl.SubmitChanges();
                }
                return 1;
            }
            return -1;
        }
        public ActionResult HoanThanhDatHang()
        {
            GiaoHang giao = new GiaoHang();//trả về thông tin giao hàng khi xác nhận đơn hàng thành công trên XNDH
            return View(giao);
        }
        public ActionResult LocSPTheoGia(string id)
        {
            if (id == "duoi200")
            {
                List<SanPham> ds = dl.SanPhams.Where(t => t.Gia <= 200000.0).ToList();
                return View("SanPham", ds);
            }
            else if (id == "tu200den400")
            {
                List<SanPham> ds = dl.SanPhams.Where(t => t.Gia > 200000.0 && t.Gia <= 400000.0).ToList();
                return View("SanPham", ds);
            }
            else
            {
                List<SanPham> ds = dl.SanPhams.Where(t => t.Gia > 400000.0).ToList();
                return View("SanPham", ds);
            }
        }

    }
}
