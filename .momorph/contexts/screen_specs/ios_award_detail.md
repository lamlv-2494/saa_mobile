# Màn hình: Award Detail (Chi tiết giải thưởng)

> Màn hình chi tiết giải thưởng - hiển thị thông tin từng loại giải dựa trên dropdown filter.
> Cập nhật lần cuối: 2026-04-14

## Thông tin màn hình

| Key | Value |
|-----|-------|
| Tên màn hình | Award Detail |
| Nhóm | Awards |
| Trạng thái | discovered |
| Số biến thể | 6 |

### Danh sách biến thể (Variants)

| # | Tên biến thể | Screen ID | Dropdown Value | Số lượng giải | Đơn vị | Giá trị giải |
|---|--------------|-----------|----------------|---------------|--------|--------------|
| 1 | Award_Top talent | c-QM3_zjkG | Top Talent | 10 | Cá nhân | 7.000.000 VNĐ / giải |
| 2 | Award_Top project | FQoJZLkG_d | Top Project | 02 | Tập thể | 15.000.000 VNĐ / giải |
| 3 | Award_Top project leader | QQvsfK3yaK | Top Project Leader | 03 | Cá nhân | 7.000.000 VNĐ / giải |
| 4 | Award_Best Manager | 7y195PPTxQ | Best Manager | 01 | Cá nhân | 10.000.000 VNĐ / giải |
| 5 | Award_Signature 2025 - Creator | O98TwiHaJe | Signature 2025 - Creator | 01 | Cá nhân hoặc tập thể | 5.000.000 VNĐ (cá nhân) / 8.000.000 VNĐ (tập thể) |
| 6 | Award_MVP | b2BuS8HYIt | MVP (Most Valuable Person) | 01 | Cá nhân | 15.000.000 VNĐ / giải |

> **Lưu ý:** Tất cả 6 biến thể chia sẻ cùng layout. Chỉ khác nhau ở nội dung (tên giải, mô tả, số lượng, đơn vị, giá trị) dựa trên giá trị dropdown filter. Riêng Signature 2025 - Creator có thêm 1 dòng giá trị giải thưởng (cho cá nhân + cho tập thể).

## Mô tả

Màn hình hiển thị thông tin chi tiết về một giải thưởng cụ thể trong hệ thống Sun* Annual Awards 2025. Người dùng có thể chuyển đổi giữa các giải thưởng thông qua dropdown filter. Nội dung bao gồm hình ảnh huy hiệu giải, tiêu đề, mô tả chi tiết tiêu chí giải, số lượng giải, và giá trị tiền thưởng.

## Phân tích điều hướng (Navigation)

### Điều hướng đến (Incoming)

| Nguồn | Hành động | Độ tin cậy |
|--------|-----------|-----------|
| [iOS] Home | Nhấn "Award card: Chi tiết" | Cao |
| [iOS] Home | Nhấn Bottom Nav: Awards | Cao |
| Dropdown filter (nội bộ) | Chọn loại giải khác | Cao |

### Điều hướng đi (Outgoing)

| Thành phần | Mục tiêu | Hành động | Độ tin cậy |
|------------|----------|-----------|-----------|
| Bottom Nav: SAA 2025 | [iOS] Home | on_click | Cao |
| Bottom Nav: Awards | (active - trang hiện tại) | - | Cao |
| Bottom Nav: Kudos | [iOS] Sun*Kudos | on_click | Cao |
| Bottom Nav: Profile | [iOS] Profile bản thân | on_click | Cao |
| Header: Language | [iOS] Language dropdown | on_click | Cao |
| Header: Search | [iOS] Sun*Kudos_Searching | on_click | Trung bình |
| Header: Notification | Màn hình thông báo (chưa xác định) | on_click | Thấp |
| Nút "Chi tiết" (Sun* Kudos) | [iOS] Sun*Kudos | on_click | Cao |
| Dropdown filter | Chuyển đổi giữa 6 loại giải (nội bộ) | on_click | Cao |

## Sơ đồ thành phần (Component Schema)

### Layout tổng thể

```
FRAME [Award Detail Screen]
├── INSTANCE [header] - Thanh header (sticky top)
│   ├── INSTANCE [StatusBar] - iOS status bar
│   ├── INSTANCE [mm_media_logo] - Logo SAA 2025
│   └── FRAME [actions] - Cụm hành động
│       ├── INSTANCE [language] - Chọn ngôn ngữ (VN flag + dropdown)
│       ├── INSTANCE [mm_media_search] - Icon tìm kiếm
│       └── INSTANCE [mm_media_notification] - Icon thông báo + badge
├── GROUP [bg] - Background artwork
├── FRAME [content] - Khu vực nội dung cuộn dọc
│   ├── FRAME [mms_A_KV Kudos] - Banner giới thiệu Kudos
│   │   ├── TEXT ["Hệ thống ghi nhận và cảm ơn"]
│   │   └── GROUP [kudo logo] - Logo KUDOS
│   ├── FRAME [mms_B_Highlight] - Khối nổi bật giải thưởng
│   │   └── FRAME [mms_B.1_header]
│   │       ├── INSTANCE [header] - "Sun* Annual Awards 2025" + "Hệ thống giải thưởng"
│   │       └── FRAME [filter] - Dropdown chọn giải
│   │           └── FRAME [dropdown]
│   │               ├── TEXT [tên giải đang chọn]
│   │               └── INSTANCE [IC] - Icon mũi tên xuống
│   ├── FRAME [award] - Khối thông tin chi tiết giải
│   │   ├── INSTANCE [mm_media_Picture-Award] - Hình ảnh huy hiệu giải
│   │   └── FRAME [award info]
│   │       ├── FRAME [title] - Icon + Tên giải
│   │       ├── TEXT [mô tả chi tiết giải]
│   │       ├── RECTANGLE [divider]
│   │       ├── FRAME [Số lượng giải thưởng]
│   │       │   ├── FRAME [title] - Icon huy hiệu + Label
│   │       │   └── FRAME [number] - Giá trị + Đơn vị
│   │       ├── RECTANGLE [divider]
│   │       └── FRAME [Giá trị giải thưởng]
│   │           ├── FRAME [title] - Icon cờ + Label
│   │           └── FRAME [number] - Số tiền + Ghi chú
│   └── FRAME [kudos] - Khối quảng bá Sun* Kudos
│       ├── INSTANCE [header] - "Phong trào ghi nhận" + "Sun* Kudos"
│       ├── FRAME [mm_media_Sunkudos] - Banner Kudos
│       ├── FRAME [note] - Mô tả "Điểm mới SAA 2025"
│       └── INSTANCE [Button] - Nút "Chi tiết" + icon mũi tên
└── INSTANCE [nav bar] - Bottom Navigation (sticky bottom)
    └── FRAME [Tabs]
        ├── FRAME [saa] - Tab "SAA 2025" (inactive)
        ├── FRAME [award] - Tab "Awards" (active - highlight vàng)
        ├── FRAME [kudos] - Tab "Kudos" (inactive)
        └── FRAME [profile] - Tab "Profile" (inactive)
```

### Phân cấp thành phần

| Cấp | Thành phần | Loại | Ghi chú |
|-----|-----------|------|---------|
| Organism | Header | INSTANCE | Tái sử dụng từ Home |
| Organism | Bottom Nav Bar | INSTANCE | Tái sử dụng từ Home, tab Awards active |
| Organism | Award Information Block | FRAME | Chứa ảnh + info + stats |
| Organism | Sun* Kudos Block | FRAME | Banner + mô tả + nút chi tiết |
| Molecule | Dropdown Filter | FRAME | Chọn loại giải thưởng |
| Molecule | Award Stats (Số lượng) | FRAME | Icon + label + giá trị + đơn vị |
| Molecule | Award Stats (Giá trị) | FRAME | Icon + label + số tiền + ghi chú |
| Molecule | Header Actions | FRAME | Language + Search + Notification |
| Atom | Award Badge Image | INSTANCE | Huy hiệu tròn với tên giải |
| Atom | Award Icon | INSTANCE | Icon giải thưởng bên cạnh tiêu đề |
| Atom | Diamond Icon | INSTANCE | Icon huy hiệu cho phần số lượng |
| Atom | Flag Icon | INSTANCE | Icon cờ cho phần giá trị |
| Atom | Notification Badge | FRAME | Badge đỏ trên icon chuông |

## Form Fields

Không có form nhập liệu trên màn hình này. Chỉ có dropdown filter để chọn loại giải.

| Thành phần | Loại | Giá trị mặc định | Tùy chọn |
|-----------|------|-------------------|----------|
| Dropdown filter giải thưởng | Dropdown/Select | Top Talent | Top Talent, Top Project, Top Project Leader, Best Manager, Signature 2025 - Creator, MVP (Most Valuable Person) |

## API Mapping

### Khi tải trang (On Load)

| Method | Endpoint | Mục đích |
|--------|----------|---------|
| GET | /api/awards | Lấy danh sách các loại giải thưởng cho dropdown |
| GET | /api/awards/:id | Lấy chi tiết giải thưởng đang chọn (tên, mô tả, số lượng, giá trị, hình ảnh) |

### Khi người dùng thao tác (On User Action)

| Hành động | Method | Endpoint | Mục đích |
|-----------|--------|----------|---------|
| Chọn giải trong dropdown | GET | /api/awards/:id | Lấy chi tiết giải thưởng mới được chọn |

## State Management

| State | Loại | Mô tả |
|-------|------|-------|
| selectedAwardId | Local | ID giải thưởng đang được chọn trong dropdown |
| awardDetail | Local/Async | Dữ liệu chi tiết giải thưởng hiện tại |
| awardsList | Global | Danh sách các loại giải thưởng (dùng chung cho dropdown) |
| isLoading | Local | Trạng thái đang tải dữ liệu |
| currentLanguage | Global | Ngôn ngữ hiện tại (VN/EN) |
| notificationCount | Global | Số thông báo chưa đọc |

## UI States

| Trạng thái | Mô tả |
|-----------|-------|
| Loading | Hiển thị skeleton/shimmer khi đang tải chi tiết giải thưởng |
| Success | Hiển thị đầy đủ thông tin giải thưởng như thiết kế |
| Error | Hiển thị thông báo lỗi khi không tải được dữ liệu |
| Empty | Không áp dụng (luôn có dữ liệu giải thưởng) |
| Switching | Khi người dùng chọn giải khác từ dropdown, hiển thị transition/animation |

## Metadata phân tích

| Key | Value |
|-----|-------|
| Ngày phân tích | 2026-04-14 |
| Độ phức tạp | Trung bình |
| Thành phần tái sử dụng | Header, Bottom Nav Bar, Award Section Header |
| Ghi chú đặc biệt | Signature 2025 - Creator có layout hơi khác (2 dòng giá trị giải: cá nhân + tập thể). Các biến thể khác chỉ có 1 dòng giá trị. |
