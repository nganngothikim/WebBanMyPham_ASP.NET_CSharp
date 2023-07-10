using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QuanLyMyPham.Models;

namespace QuanLyMyPham.Controllers
{
    public class TaiKhoanController : Controller
    {
        //
        // GET: /TaiKhoan/
        Sa_1DataContext dl = new Sa_1DataContext();
        public ActionResult KhoiTao()
        {
            KhachHang kh = (KhachHang)Session["kh"];
            if (kh != null)
                ViewBag.chao = "Xin chào, " + kh.HoTen;
            return PartialView();
        }
        public ActionResult KhoiTao_AD()
        {
            Admin ad = (Admin)Session["ad"];
            if (ad != null)
                ViewBag.chao = "Xin chào, " + ad.User;
            return PartialView();
        }
        public ActionResult DangNhap()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DangNhap(FormCollection fc)
        {
            KhachHang kh = dl.KhachHangs.FirstOrDefault(t => (t.Email == fc["name"] && t.MatKhau == fc["password"]) || (t.HoTen == fc["name"] && t.MatKhau == fc["password"]));
            if (kh != null)
            {
                Session["kh"] = kh;
                return RedirectToAction("SanPham", "KhachHang");
            }
            else
            {
                Admin ad = dl.Admins.FirstOrDefault(t => t.User == fc["name"] && t.Pass == fc["password"]);
                if (ad != null)
                {
                    Session["ad"] = ad;
                    return RedirectToAction("SanPham", "QuanLy");
                }
            }
            return View();
        }

        public ActionResult DangKy()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DangKy(KhachHang d, FormCollection fc)
        {
            d.MaKH = "KH0" + (dl.KhachHangs.Count() + 1).ToString();
            d.HoTen = fc["name"];
            d.DienThoai = fc["phone"];
            d.Email = fc["email"];
            d.MatKhau = fc["password"];
            dl.KhachHangs.InsertOnSubmit(d);
            dl.SubmitChanges();
            return RedirectToAction("DangNhap", "TaiKhoan");
        }
        public ActionResult DangXuat()
        {
            Session.Clear();
            Session.RemoveAll();
            return RedirectToAction("DangNhap", "TaiKhoan");
        }
    }
}
