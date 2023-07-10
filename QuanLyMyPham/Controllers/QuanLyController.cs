using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QuanLyMyPham.Models;

namespace QuanLyMyPham.Controllers
{
    public class QuanLyController : Controller
    {
        //
        // GET: /QuanLy/
        Sa_1DataContext dl = new Sa_1DataContext();
        public ActionResult MenuLoaiSP()
        {
            List<Loai> ds = dl.Loais.ToList();
            return PartialView(ds);
        }
        // Quản lý danh sách loại
        public ActionResult DSLoai()
        {
            List<Loai> ds = dl.Loais.ToList();
            return View(ds);
        }
        public ActionResult ThemL()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ThemL(Loai d)
        {
            //string tenfile = fileUpload.FileName;
            //d.DuongDan = "/HinhAnh/" + tenfile;
            //string fulltenfile = Server.MapPath("/HinhAnh/" + tenfile);
            //fileUpload.SaveAs(fulltenfile);
            

            dl.Loais.InsertOnSubmit(d);
            dl.SubmitChanges();
            return RedirectToAction("DSLoai", d);
        }
        public ActionResult XoaL(int id)
        {
            var sp = dl.Loais.FirstOrDefault(t => t.MaLoai == id);
            return View(sp);
        }
        [HttpPost]
        public ActionResult XoaL(int id, FormCollection coll)
        {
            //Tìm 1 thể loại trong sql
            Loai ft = dl.Loais.FirstOrDefault(t => t.MaLoai == id); //tìm được thể loại cũ
            if (ft.SanPhams.Count == 0)
            {//nếu trong bảng SanPhams không có dữ liệu thì sẽ xóa
                dl.Loais.DeleteOnSubmit(ft);
                dl.SubmitChanges(); //được thêm vào sql
                return RedirectToAction("DSLoai");
            }
            else
            {
                return RedirectToAction("ThongBao");
            }
        }
        public ActionResult ThongBao()
        {        
            return View();
        }
        public ActionResult SuaL(int id)
        {
            Loai t = dl.Loais.FirstOrDefault(s => s.MaLoai == id);
            return View(t);
        }

        [HttpPost]

        public ActionResult SuaL(Loai t)
        {
            Loai ft = dl.Loais.FirstOrDefault(s => s.MaLoai == t.MaLoai);
            ft.TenLoai = t.TenLoai;
            
            UpdateModel(ft);
            dl.SubmitChanges();

            return RedirectToAction("DSLoai");
        }
        // Quản lý sản phẩm
        public ActionResult SanPham()
        {
            List<SanPham> ds = dl.SanPhams.ToList();
            return View(ds);
        }
        public ActionResult ThemSP()
        {
            ViewBag.maloai = new SelectList(dl.Loais.ToList(), "MaLoai", "TenLoai");
            return View();
        }
        [HttpPost]
        public ActionResult ThemSP(SanPham d, HttpPostedFileBase fileUpload)
        {
            //string tenfile = fileUpload.FileName;
            //d.DuongDan = "/HinhAnh/" + tenfile;
            //string fulltenfile = Server.MapPath("/HinhAnh/" + tenfile);
            //fileUpload.SaveAs(fulltenfile);

            fileUpload.SaveAs(Server.MapPath("/HinhAnh/" + fileUpload.FileName));
            d.DuongDan = fileUpload.FileName;

            d.MaSP = dl.SanPhams.Count() + 1;

            dl.SanPhams.InsertOnSubmit(d);
            dl.SubmitChanges();
            return RedirectToAction("SanPham", d);
        }
        public ActionResult XoaSP(int id)
        {
            var sp = dl.SanPhams.FirstOrDefault(t => t.MaSP == id);
            return View(sp);
        }
        [HttpPost]
        public ActionResult XoaSP(int id, FormCollection coll)
        {
            //Tìm 1 thể loại trong sql
            SanPham ft = dl.SanPhams.FirstOrDefault(t => t.MaSP == id); //tìm được thể loại cũ
            //if (ft.Tintucs.Count == 0)
            {//nếu trong bảng Tintucs không có dữ liệu thì sẽ xóa
                dl.SanPhams.DeleteOnSubmit(ft);
                dl.SubmitChanges(); //được thêm vào sql
                return RedirectToAction("SanPham");
            }
        }
        public ActionResult SuaSP(int id)
        {
            SanPham t = dl.SanPhams.FirstOrDefault(s => s.MaSP == id);
            return View(t);
        }

        [HttpPost]

        public ActionResult SuaSP(SanPham t)
        {
            SanPham ft = dl.SanPhams.FirstOrDefault(s => s.MaSP == t.MaSP);
            ft.TenSP = t.TenSP;
            ft.Gia = t.Gia;
            ft.MoTa = t.MoTa;
            
            UpdateModel(ft);
            dl.SubmitChanges();

            return RedirectToAction("SanPham");
        }
        public ActionResult HTSP_TheoLoai(int id)
        {
            List<SanPham> ds = dl.SanPhams.Where(t => t.MaLoai == id).ToList();
            return View("SanPham", ds);
        }
        // Quản lý khách hàng
        public ActionResult KhachHang()
        {
            List<KhachHang> ds = dl.KhachHangs.ToList();
            return View(ds);
        }

      
        //Quản lý đơn hàng
        public ActionResult HoaDon()
        {
            List<HoaDon> ds = dl.HoaDons.ToList();
            return View(ds);
        }

        public ActionResult ChiTietHD_MaHoaDon(int id)
        {
            List<ChiTietHoaDon> ds = dl.ChiTietHoaDons.Where(t => t.MaHoaDon == id).ToList();
            return PartialView(ds);
        }
        [HttpPost]
        public ActionResult XLTimKiem(FormCollection fc)
        {
            string tensp = fc["search"];
            List<SanPham> ds1 = dl.SanPhams.Where(t => t.TenSP.Contains(tensp)).ToList();
            List<KhachHang> ds2 = dl.KhachHangs.Where(t => t.HoTen.Contains(tensp)).ToList();
            if (ds1.Count > 0)
            {
                return View("SanPham", ds1);
            }
            else
            {
                if (ds2.Count > 0)
                {
                    return View("KhachHang", ds2);
                }
                return View("SanPham", ds1);
            }
            
        }

    }
}
