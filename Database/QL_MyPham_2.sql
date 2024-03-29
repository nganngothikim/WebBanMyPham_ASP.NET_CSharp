USE [master]
GO
/****** Object:  Database [QL_MYPHAM]    Script Date: 20/12/2022 15:50:59 ******/
CREATE DATABASE [QL_MYPHAM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QL_MYPHAM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QL_MYPHAM.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QL_MYPHAM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QL_MYPHAM_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QL_MYPHAM] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QL_MYPHAM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QL_MYPHAM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET ARITHABORT OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QL_MYPHAM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QL_MYPHAM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QL_MYPHAM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QL_MYPHAM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QL_MYPHAM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QL_MYPHAM] SET  MULTI_USER 
GO
ALTER DATABASE [QL_MYPHAM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QL_MYPHAM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QL_MYPHAM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QL_MYPHAM] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QL_MYPHAM]
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_NEXTID]    Script Date: 20/12/2022 15:50:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[AUTO_NEXTID](@ma varchar(4), @str varchar(2), @size int)
returns varchar(4)
AS
	BEGIN
		if(@ma = '')
			set @ma = @str + REPLICATE(0, @size - LEN(@str))
		declare @sl_ma int, @maMoi varchar(4)
		set @ma = LTRIM(RTRIM(@ma))
		set @sl_ma = REPLACE(@ma, @str, '') + 1
		set @size = @size - LEN(@str)
		set @maMoi = @str + REPLICATE(0, @size - LEN(@str))
		set @maMoi = @str + RIGHT(REPLICATE(0, @size) + CONVERT(varchar(Max), @sl_ma), @size)
		return @maMoi
	END



GO
/****** Object:  Table [dbo].[Admin]    Script Date: 20/12/2022 15:50:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Admin](
	[User] [varchar](50) NOT NULL,
	[Pass] [nvarchar](50) NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 20/12/2022 15:50:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[MaHoaDon] [int] NOT NULL,
	[MaSP] [int] NOT NULL,
	[SoLuong] [int] NULL,
 CONSTRAINT [PK_ChiTiet] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC,
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GiaoHang]    Script Date: 20/12/2022 15:50:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoHang](
	[MaGH] [int] IDENTITY(1,1) NOT NULL,
	[MaHoaDon] [int] NOT NULL,
	[DiaChi] [nvarchar](100) NULL,
 CONSTRAINT [PK_GiaoHang] PRIMARY KEY CLUSTERED 
(
	[MaGH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 20/12/2022 15:50:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHoaDon] [int] IDENTITY(1,1) NOT NULL,
	[NgayHoaDon] [date] NULL,
	[MaKH] [varchar](4) NOT NULL,
	[NgayGiao] [date] NULL,
	[NgayThanhToan] [date] NULL,
	[ThanhTien] [real] NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 20/12/2022 15:50:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [varchar](4) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[DienThoai] [varchar](10) NULL,
	[Email] [varchar](50) NULL,
	[MatKhau] [varchar](50) NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Loai]    Script Date: 20/12/2022 15:50:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loai](
	[MaLoai] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](50) NULL,
 CONSTRAINT [PK_Loai] PRIMARY KEY CLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 20/12/2022 15:50:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSP] [int] IDENTITY(1,1) NOT NULL,
	[TenSP] [nvarchar](500) NULL,
	[DuongDan] [varchar](50) NULL,
	[Gia] [float] NULL,
	[MoTa] [nvarchar](500) NULL,
	[MaLoai] [int] NULL,
 CONSTRAINT [PK_SanPham] PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Admin] ([User], [Pass]) VALUES (N'admin1', N'123')
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (1, 1, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (1, 6, 2)
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (1, 8, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (2, 2, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (2, 3, 3)
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (2, 4, 2)
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (2, 7, 4)
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (3, 3, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (3, 8, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (3, 10, 2)
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (4, 2, 2)
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (4, 8, 1)
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSP], [SoLuong]) VALUES (4, 10, 3)
SET IDENTITY_INSERT [dbo].[HoaDon] ON 

INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayHoaDon], [MaKH], [NgayGiao], [NgayThanhToan], [ThanhTien]) VALUES (1, CAST(N'2020-11-03' AS Date), N'KH03', CAST(N'2020-11-05' AS Date), NULL, 847000)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayHoaDon], [MaKH], [NgayGiao], [NgayThanhToan], [ThanhTien]) VALUES (2, CAST(N'2020-11-03' AS Date), N'KH01', CAST(N'2020-11-05' AS Date), CAST(N'2020-11-04' AS Date), 2259000)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayHoaDon], [MaKH], [NgayGiao], [NgayThanhToan], [ThanhTien]) VALUES (3, CAST(N'2020-11-03' AS Date), N'KH02', CAST(N'2020-12-01' AS Date), NULL, 520000)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayHoaDon], [MaKH], [NgayGiao], [NgayThanhToan], [ThanhTien]) VALUES (4, CAST(N'2020-11-03' AS Date), N'KH04', CAST(N'2020-11-03' AS Date), CAST(N'2020-11-04' AS Date), 1793000)
SET IDENTITY_INSERT [dbo].[HoaDon] OFF
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DienThoai], [Email], [MatKhau]) VALUES (N'KH01', N'Nguyễn Hải Yến', N'0908049490', N'yennh@cntp.edu.vn                                 ', N'123456                                            ')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DienThoai], [Email], [MatKhau]) VALUES (N'KH02', N'Trương Thị Khánh Uyên', N'0912345678', N'uyenttk@gmail.com                                 ', N'654321                                            ')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DienThoai], [Email], [MatKhau]) VALUES (N'KH03', N'Nguyễn Văn Hòa', N'0986547213', N'hoanv@gmail.com                                   ', N'987654                                            ')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DienThoai], [Email], [MatKhau]) VALUES (N'KH04', N'Trần Thu Sang', N'0986532321', N'sangtt@gmail.com                                  ', N'789456                                            ')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DienThoai], [Email], [MatKhau]) VALUES (N'KH05', N'Đinh Duy Minh', N'0111222333', N'minhdd@gmail.com                                  ', N'777777                                            ')
SET IDENTITY_INSERT [dbo].[Loai] ON 

INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (1, N'Kem chống nắng')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (2, N'Son môi')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (3, N'Sữa rửa mặt')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (4, N'Tẩy trang')
INSERT [dbo].[Loai] ([MaLoai], [TenLoai]) VALUES (5, N'Kem dưỡng')
SET IDENTITY_INSERT [dbo].[Loai] OFF
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (1, N'Kem Chống Nắng Mỏng Nhẹ Bảo Vệ Tối Ưu La Roche-Posay Anthelios UVMune400 Invisible Fluid SPF50+ 50Ml', N'KCN01.png', 495000, N'là dòng sản phẩm với màng lọc độc quyền MEXORYL 400 mới có khả năng chống nắng phổ rộng, bảo vệ da toàn diện trước tất cả tác hại từ tia UVA dài, UVB, IR-A.', 1)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (2, N'Gel Chống Nắng Dưỡng Sáng, Ngừa Thâm Nám Vichy Capital Soleil Uv Age Daily 50Ml', N'KCN02.png', 675000, N'Gel chống nắng dưỡng sáng, ngăn ngừa thâm nám đốm nâu Vichy Capital Soleil UV Age Daily kết hợp tối ưu công nghệ chống nắng độc đáo INUTEC giúp ngăn cản tia cực tím tối đa & có kết cấu mỏng nhẹ như nước. Sản phẩm là bước tiếp nối thành công của dòng dưỡng LIFTACTIV & thuộc Top sản phẩm bán chạy nhất.', 1)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (3, N'Kem Chống Nắng Solar Smart UV Protector Carasun 70Ml', N'KCN03.png', 206000, N'Kem chống nắng với SPF 45 PA++++ bảo vệ da dưới tác hại của tia UVA, UVB và ánh nắng mặt trời. Cung cấp dưỡng chất nuôi dưỡng da. Cấp ẩm cho da, giữ da luôn tươi trẻ', 1)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (4, N'Tinh Chất Chống Nắng Sunplay Skin Aqua Hiệu Chỉnh Sắc Da Tone Up UV Latte Beige SPF50+ PA++++ 50g', N'KCN04.png', 185000, N'Chống nắng hiệu quả với SPF50+, PA++++ giúp ngăn ngừa đen sạm, nám, nếp nhăn, đốm nâu... Hiệu chỉnh tông da tái xanh, che phủ khuyết điểm tự nhiên giúp da ửng hồng. Giữ ẩm và dưỡng sáng da. Không chứa cồn, có thể làm lớp lót trang điểm', 1)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (5, N'Son Kem Lì Merzy The First Velvet Tint Green Edition', N'SON01.jpg ', 159000, N'Son Kem Lì, Bền Màu, Lâu Trôi Merzy The First Velvet Tint V6 Xanh Lá Green Edition là son kem lì đến từ thương hiệu Merzy nằm trong phiên bản giới hạn mới mang vỏ màu xanh, son có kết cấu chất son nhung mềm,mướt mịn với thông điệp #beyourself chính là lời nhắn gửi tới một nửa xinh đẹp của thế giới. ', 2)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (6, N'Son Tint Nước Siêu Lì Romand Glasting Water Tint 4g', N'SON02.jpg ', 148000, N'Son Tint Nước Siêu Lì, Lâu Trôi Romand Glasting Water Tint là son tint lì của thương hiệu Romand có chất son tint bóng tự như một lớp màng nước lướt nhẹ trên môi, chứa nhiều dưỡng chất giúp nuôi dưỡng đôi môi, son lên môi nhẹ và mướt mịn, dễ tán đều cùng với bảng màu rực rỡ đa dạng mang đến cho bạn đôi môi căng mọng tràn đầy sức sống, tự tin cả ngày dài.', 2)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (7, N'Son Kem Lì Etude Crema Velvet Tint 3.6g', N'SON03.jpg ', 149000, N'Son Kem Lì, Mịn Mượt Như Nhung Etude Crema Velvet ', 2)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (8, N'Son Dưỡng Môi The Cocoon Ben Tre Coconut Lip Balm 5g', N'SON04.jpg ', 56000, N'Son Dưỡng Môi Chiết Xuất Dầu Dừa Bến Tre The Cocoon Ben Tre Coconut Lip Balm là son dưỡng thuộc thương hiệu Cocoon với thành phần chính là dầu dừa có nguồn gốc từ Bến Tre, được bổ sung chiết xuất bơ hạt mỡ và vitamin E giúp mang lại đôi môi mềm mượt, hồng hào, chống khô môi, nứt nẻ do thời tiết  thuộc thương hiệu mỹ phẩm thuần chay Cocoon đến từ Việt Nam.', 2)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (9, N'Son Dearmay California Cherry Velvet Tint 4.4g', N'SON05.jpg ', 199000, N'Son Kem Lì, Lên Màu Chuẩn Dearmay California Cherry Velvet Tint là son kem lì thuộc thương hiệu Dearmay với kết cấu son velvet tint mịn mượt mang đến một đôi môi mịn lì hoàn hảo, cho bạn đôi môi ngọt ngào, xinh xắn thu hút mọi ánh nhìn.', 2)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (10, N'Son Thỏi Cao Cấp G9Skin First V-Fit Lipstick', N'SON06.jpg ', 129000, N'Son Thỏi Lì Chất Siêu Mịn, Vỏ Vàng Cao Cấp G9Skin First V-Fit Lipstick là son thỏi đến từ thương hiệu G9Skin với thiết kế vẻ ngoài sang trọng cùng bảng màu quyến rũ, rạng rỡ lôi cuốn cho bạn vẻ đẹp tinh tế, thời thượng thu hút mọi ánh nhìn.', 2)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (11, N'Sữa Rửa Mặt Cosrx Low pH Good Morning Gel Cleanser', N'SRM01.jpg', 137000, N'Sữa Rửa Mặt Dạng Gel Cosrx Low PH Good Morning Gel Cleanser là dòng sữa rửa mặt dịu nhẹ, thuộc thương hiệu Cosrx. Có độ pH gần như là làn da tự nhiên có khả năng làm sạch mà không gây khô căng da, dễ dàng làm sạch bụi bẩn, bã nhờn và lớp trang điểm, mang đến làn da sạch mịn, thông thoáng lỗ chân lông.', 3)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (12, N'Sữa Rửa Cetaphil Gentle Skin Cleanser', N'SRM02.jpg', 568000, N'Sữa Rửa Mặt Cetaphil Gentle Skin Cleanser là sữa rửa mặt với công thức lành tính giúp làm sạch bụi bẩn một cách nhẹ nhàng. Bên cạnh đó, Cetaphil Skin Cleanser còn không gây bít tắc lỗ chân lông, có khả năng duy trì độ ẩm tự nhiên và phù hợp với mọi loại da, kể cả làn da mỏng manh của bé sơ sinh thuộc thương Cetaphil được bác sĩ da liễu khuyên dùng đến từ Canada.', 3)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (13, N'Sữa Rửa Mặt Nhật Bản Hatomugi Cleansing & Facial Washing 130g', N'SRM03.jpg', 38000, N'Sữa Rửa Mặt Tẩy Trang & Làm Sáng Da Nhật Bản Hatomugi Cleansing & Facial Washing 130g là sữa rửa mặt thuộc thương hiệu Hatomugi giúp làm sạch bụi bẩn, dầu nhờn và dưỡng sáng da từ những thành phần tự nhiên như chiết xuất Ý Dĩ, Trái Đào, Lô Hội và tinh dầu hoa Trà Nhật Bản, mang đến làn da mịn màng, sáng hồng tự nhiên. Sản phẩm có thể dùng thay thế tẩy trang.', 3)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (14, N'Sữa Rửa Mặt Caryophy Portulaca Cleansing Foam 150ml', N'SRM04.jpg', 239000, N'Sữa Rửa Mặt Làm Sạch Sâu, Phục Hồi Da Caryophy Portulaca Cleansing Foam  là sữa rửa mặt với công thức chứa các thành phần lành tính như rau má, rau sam và xô thơm giúp vừa làm sạch sâu lỗ chân lông, quản lí điều tiết dầu nhờn, đặc biệt giúp kháng khuẩn, làm dịu và thúc đẩy nhanh quá trình phục hồi các thương tổn cho làn da mụn thuộc thương thuộc thương hiệu Caryophy đến từ Hàn Quốc', 3)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (15, N'Sữa Rửa Mặt Meishoku Bigan Facial Wash  15ml', N'SRM05.jpg', 41000, N'Sữa Rửa Mặt Tạo Bọt Ngăn Ngừa Mụn Meishoku Bigan Facial Wash là sữa rửa mặt thuộc thương hiệu Meishoku với công thức đặc biệt cùng hoạt chất Acid Salicylic không chỉ giúp làm thông thoáng lỗ chân lông, loại bỏ dầu nhờn, tế bào chết già cỗi mà còn cải thiện da mụn hiệu quả. Kết cấu bọt dày, mịn, siêu nhỏ dễ dàng  làm sạch hoàn toàn bụi bẩn và lớp trang điểm còn sót lại', 3)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (16, N'Sữa Rửa Useemi Gluta Plus Brightening Foam Cleanser 150ml', N'SRM06.jpg', 159000, N'Sữa Rửa Mặt Tạo Bọt Làm Sáng Da Dưỡng Trắng Useemi Gluta Plus Brightening Foam Cleanser là sữa rửa mặt  Chứa thành phần Niacinamide, Glutathione và vitamin E có khả năng làm sạch mọi bụi bẩn, lớp trang điểm và các tạp chất, làm sáng da và dưỡng trắng thuộc thương hiệu Useemi đến từ Hàn Quốc', 3)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (17, N'Dầu Tẩy Trang Cho Mọi Loại Da Biore 150Ml', N'TT01.png', 159000, N'Dầu tẩy trang Biore với công thức đặc biệt sẽ hòa tan lớp trang điểm dày trên mặt, tẩy sạch bụi bẩn, bã nhờn bám trên da, kể cả mascara không trôi mà không để lại cảm giác nhờn rít, khó chịu sau khi sử dụng. Có thể sử dụng sản phẩm khi mặt và tay đang ướt mà không sợ ảnh hưởng tới hiệu quả tẩy trang. Sản phẩm được nhập khẩu trực tiếp từ Nhật Bản.
', 4)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (18, N'Dầu Tẩy Trang Dưỡng Ẩm Advanced Nourish Hyaluronic Acid Cleansing Oil Hada Labo 200Ml', N'TT02.png', 181000, N'Advanced Nourish Hyaluron Cleansing Oil là sản phẩm tẩy trang với thành phần gồm Dầu Ô liu tinh khiết kết hợp cùng HA và SHA nhẹ nhàng làm sạch hiệu quả lớp trang điểm (kể cả mascara không trôi), giữ da luôn ẩm mượt và sáng mịn và khỏe mạnh hơn thấy rõ chỉ sau 4 tuần sử dụng đều đặn, đặc biệt an toàn và dịu nhẹ cho da, không gây cảm giác căng bóng, khó chịu sau khi sử dụng', 4)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (19, N'Dầu Tẩy Trang Dưỡng Ẩm Gokujyun Hada Labo 200Ml', N'TT03.png', 315000, N'Dầu Tẩy Trang Hada Labo Gokujyun Cleansing Oil là sản phẩm tẩy trang dạng dầu, sản phẩm sử dụng dầu Olive tinh khiết giúp nhanh chóng làm sạch lớp makeup kể cả sản phẩm lâu trôi & chống thấm nước, bổ sung thêm Super Hyaluronic Acid cấp nước và dưỡng ẩm sâu cho da mềm mịn, không khô căng sau khi tẩy trang. Công thức không chứa các thành phần có khả năng gây kích ứng, an toàn và dịu nhẹ cho mọi loại da', 4)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (20, N'Dầu Tẩy Trang Dưỡng Da dProgram 120Ml', N'TT04.png', 392000, N'Dầu Tẩy Trang Dưỡng Da dProgram 120Ml. Dầu tẩy trang dưỡng da dProgram được sản xuất tại Nhật Bản, dịu nhẹ làm sạch bụi bẩn ô nhiễm và lớp trang điểm khó trôi mà không gây ma sát lên da. Sản phẩm dịu nhẹ có thể dùng để tẩy trang mắt môi. Thích hợp cho mọi lọai da đặc biệt là da nhạy cảm', 4)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (21, N'Kem Dưỡng Dạng Gel Hatherine Morning Boost Clear Firming Cream 50ml', N'KEM01.jpg', 149000, N'Kem Dưỡng Dạng Gel Chống Lão Hóa, Đàn Hồi Da Hatherine Morning Boost Clear Firming Cream  là kem dưỡng với công thức không chứa dầu với kết cấu mỏng nhẹ có khả năng nạp đầy độ ẩm cho da. Chứa chiết xuất hoa cải dầu, Asparagus Officinalis Extract, và 3 loại Peptide giúp tăng sinh đàn hồi cho da, ngăn ngừa tình trạng lão hóa hiệu quả  thuộc thương hiệu Hatherine đến từ Hàn Quốc', 5)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (22, N'Kem Dưỡng Dạng Gel Hatherine Morning Boost Clear Firming Cream 50ml', N'KEM02.jpg', 337000, N'Gel Dưỡng Ẩm, Dưỡng Trắng Da Chiết Xuất Cây Hắc Mai Biển I''m From Vitamin Tree Water Gel là dòng kem dưỡng dạng gel, với chiết xuất thành phần chính là lá Hắc Mai Biển, Niacinamide giúp dưỡng trắng da hiệu quả, dưỡng ẩm cho da luôn mềm mại, bảo vệ da khỏi các tác nhân bên ngoài môi trường thuộc thương hiệu mỹ phẩm I''m From đến từ Hàn Quốc.', 5)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (23, N'Kem Dưỡng Ẩm, Cấp Nước Neutrogena Hydro Boost Water Gel', N'KEM03.jpg', 88000, N'Kem Dưỡng Ẩm, Cấp Nước Neutrogena Hydro Boost Water Gel là dòng kem dưỡng da thuộc thương hiệu dược mỹ phẩm Neutrogena đến từ Mỹ. Sở hữu công nghệ Hydro Boost độc quyền cùng các thành phần dưỡng chất thiết yếu giúp cấp nước và khóa ẩm suốt 72h, tăng cường hàng rào bảo vệ da tự nhên nuôi dưỡng làn da luôn khỏe đẹp.', 5)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (24, N'Kem Dưỡng Trắng Da, Mờ Thâm Nám Chỉ Trong 7 Ngày Angel''s Liquid 7 Day Glutathione 700 V-Cream 50ml ', N'KEM04.jpg', 372000, N'Kem Dưỡng Trắng Da, Mờ Thâm Nám Chỉ Trong 7 Ngày Angel''s Liquid 7 Day Glutathione 700 V-Cream là kem dưỡng trắng đặc trị thâm nám đến từ thương hiệu Angel''s Liquid, sản phẩm giúp loại bỏ lớp da xỉn màu và cân bằng độ ẩm mang lại hiệu quả cải thiện tông màu da cũng như giữ ẩm giúp da mềm mại mịn màng chỉ sau vài lần sử dụng', 5)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (25, N'Kem Dưỡng Da Klairs Midnight Blue Calming Cream', N'KEM05.jpg', 367000, N'Kem Dưỡng Da Làm Dịu, Phục Hồi Da Ban Đêm Klairs Midnight Blue Calming Cream 60ml là kem dưỡng với thành phần chính là Guaiazulene có nguồn gốc từ hoa cúc  và chiết xuất rau má Giúp phục hồi và làm dịu các vùng da đang dị ứng hoặc sưng đỏ, làm giảm vết sưng tấy, phục hồi làn da bị tổn thương, hình thành hàng rào dưỡng ẩm bảo vệ da khỏe mạnh, àm dịu da và giảm các tác hại do tia UV thuộc thương hiệu Klairs đến từ Hàn Quốc.', 5)
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [DuongDan], [Gia], [MoTa], [MaLoai]) VALUES (26, N'Kem Dưỡng  AHA-BHA-PHA 30 Days Miracle Cream 60g', N'KEM06.jpg', 289000, N'Kem Dưỡng "Thần Kỳ" Some By Mi AHA-BHA-PHA 30 Days Miracle Cream là kem dưỡng thuộc dòng AHA-BHA-PHA của thương hiệu Some By Mi kết hợp cả 3 thành phần AHA/BHA/PHA giúp loại bỏ tế bào chết, bổ sung độ ẩm và chứa chiết xuất rau má, tràm trà...giúp làm dịu và chăm sóc da mụn', 5)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_HoaDon] FOREIGN KEY([MaHoaDon])
REFERENCES [dbo].[HoaDon] ([MaHoaDon])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_HoaDon]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_SanPham] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_SanPham]
GO
ALTER TABLE [dbo].[GiaoHang]  WITH CHECK ADD  CONSTRAINT [FK_GiaoHang_HoaDon] FOREIGN KEY([MaHoaDon])
REFERENCES [dbo].[HoaDon] ([MaHoaDon])
GO
ALTER TABLE [dbo].[GiaoHang] CHECK CONSTRAINT [FK_GiaoHang_HoaDon]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_KhachHang]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_Loai] FOREIGN KEY([MaLoai])
REFERENCES [dbo].[Loai] ([MaLoai])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_Loai]
GO
USE [master]
GO
ALTER DATABASE [QL_MYPHAM] SET  READ_WRITE 
GO
