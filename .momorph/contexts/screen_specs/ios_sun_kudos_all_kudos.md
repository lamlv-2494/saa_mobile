# Screen Spec: [iOS] Sun*Kudos_All Kudos

## Screen Info

| Key | Value |
|-----|-------|
| Screen ID | j_a2GQWKDJ |
| Frame ID | 6891:15995 |
| Status | discovered |
| Platform | iOS |
| Screen Type | Danh sách (List) |

## Mô tả

Màn hình hiển thị toàn bộ danh sách Kudos trong hệ thống Sun* Annual Awards 2025. Đây là màn hình dạng danh sách cuộn dọc, mỗi item là một thẻ Kudo nổi bật (Highlight) hiển thị thông tin người gửi - người nhận, nội dung lời cảm ơn, hashtag và các hành động tương tác (thả tim, chia sẻ). Người dùng có thể duyệt qua tất cả Kudos đã được gửi trong hệ thống.

---

## Phân tích điều hướng

### Điều hướng đến (Incoming)

| Từ màn hình | Trigger | Độ tin cậy |
|-------------|---------|------------|
| [iOS] Home | Nhấn icon Kudos trên FAB (mms_6_float button > Kudos Logo) | High |
| [iOS] Sun*Kudos | Nhấn nút xem tất cả Kudos | High |
| Bottom Navigation (bất kỳ màn hình nào) | Nhấn tab "Kudos" trên bottom nav | Medium |

### Điều hướng đi (Outgoing)

| Đến màn hình | Trigger | Node ID | Độ tin cậy | Ghi chú |
|--------------|---------|---------|------------|---------|
| Màn hình trước (Home / Sun*Kudos) | Nhấn nút Back | 6891:16004 (mm_media_back) | High | Back button trên TopNavigation |
| [iOS] Sun*Kudos_View kudo | Nhấn vào thẻ Kudo bất kỳ | 6891:16171 (mms_B.3_KUDO - Highlight) | High | Mỗi thẻ Kudo là một item có thể nhấn |
| [iOS] Sun*Kudos_View kudo ẩn danh | Nhấn vào thẻ Kudo ẩn danh | - | Medium | Nếu Kudo là ẩn danh, chuyển sang màn view ẩn danh |
| [iOS] Profile bản thân / Profile người khác | Nhấn vào avatar/tên người gửi hoặc người nhận | I6891:16171;89:2951 (Infor) | Medium | Có thể điều hướng đến profile người dùng |
| [iOS] Home | Nhấn tab "SAA 2025" bottom nav | I6891:16694;75:2054 (saa) | High | Bottom Navigation |
| Awards screen | Nhấn tab "Awards" bottom nav | I6891:16694;75:2057 (award) | High | Bottom Navigation |
| [iOS] Sun*Kudos | Nhấn tab "Kudos" bottom nav | I6891:16694;75:2060 (kudos) | High | Bottom Navigation - tab đang active |
| [iOS] Profile bản thân | Nhấn tab "Profile" bottom nav | I6891:16694;75:2063 (profile) | High | Bottom Navigation |

### Quy tắc điều hướng
- **Hành vi nút Back**: Quay về màn hình trước đó (Home hoặc Sun*Kudos)
- **Deep link**: Có thể hỗ trợ - `/kudos/all`
- **Yêu cầu đăng nhập**: Có

---

## Component Schema

### Layout

```
FRAME: [iOS] Sun*Kudos_All Kudos
├── FRAME: TopNavigation
│   ├── INSTANCE: StatusBar (iOS system status bar)
│   └── FRAME: _TopNavigation-content
│       ├── FRAME: ✏️ Left Accessory
│       │   └── INSTANCE: mm_media_back (Nút quay lại)
│       └── FRAME: ✏️ Title
│           └── TEXT: ✏️ Title ("All Kudos" / "Tất cả Kudos")
│
├── GROUP: mm_media_bg (Hình nền)
│   ├── Shadow Left
│   ├── MM_MEDIA_Keyvisual BG
│   └── Shadow Bottom
│
├── INSTANCE: header (Header SAA 2025)
│   ├── TEXT: "Sun* annual awards 2025"
│   └── TEXT: "Hệ thống giải thưởng"
│
├── FRAME: Danh sách Kudo (Danh sách cuộn dọc)
│   ├── INSTANCE: mms_B.3_KUDO - Highlight (Kudo item 1)
│   ├── INSTANCE: mms_B.3_KUDO - Highlight (Kudo item 2)
│   ├── INSTANCE: mms_B.3_KUDO - Highlight (Kudo item 3)
│   └── INSTANCE: mms_B.3_KUDO - Highlight (Kudo item 4)
│
└── INSTANCE: nav bar (Bottom Navigation)
    ├── saa (Home)
    ├── award (Awards)
    ├── kudos (Kudos - active)
    └── profile (Profile)
```

### Cấu trúc chi tiết mỗi Kudo Item (mms_B.3_KUDO - Highlight)

```
mms_B.3_KUDO - Highlight
├── FRAME: trao nhận (Thông tin người gửi - nhận)
│   ├── INSTANCE: Infor (Người gửi)
│   │   ├── mm_media_img
│   │   │   ├── mms_B.3.5_Avatar người nhận (ELLIPSE)
│   │   │   └── mms_B.3.1_Avatar người gửi (ELLIPSE)
│   │   └── mms_B.3.2_Thông tin người gửi
│   │       ├── TEXT: Tên người gửi
│   │       └── Huy hiệu + Sao (Cấp bậc, danh hiệu)
│   ├── mms_B.3.4_Icon mũi tên (→)
│   └── INSTANCE: Infor (Người nhận)
│       ├── mm_media_img
│       │   └── mms_B.3.5_Avatar người nhận (ELLIPSE)
│       └── mms_B.3.2_Thông tin người gửi
│           ├── TEXT: Tên người nhận
│           └── Huy hiệu + Sao (Cấp bậc, danh hiệu)
│
├── RECTANGLE: Divider
│
├── FRAME: mms_B.4_Nội dung lời cảm ơn
│   ├── TEXT: mms_B.4.1_Thời gian đăng
│   ├── TEXT: Tiêu đề (VD: "IDOL GIỚI TRẺ")
│   ├── FRAME: mms_B.4.2_Nội dung (Lời cảm ơn chi tiết)
│   └── FRAME: mms_B.4.3_Hashtag (VD: #Dedicated #Inspiring)
│
├── RECTANGLE: Divider
│
└── FRAME: mms_B.4.4_Action
    ├── Hearts (Icon tim + số lượng: "1.000")
    └── Buttons
        ├── Button (Chia sẻ / Comment)
        └── Button (Xem chi tiết / Forward)
```

### Component Hierarchy

| Level | Component | Type | Số lượng |
|-------|-----------|------|----------|
| Organism | TopNavigation | Navigation | 1 |
| Organism | header (SAA 2025) | Display | 1 |
| Organism | Danh sách Kudo | Scrollable List | 1 |
| Organism | nav bar | Navigation | 1 |
| Molecule | mms_B.3_KUDO - Highlight | Card | 4 (hiển thị, thực tế N items) |
| Molecule | trao nhận (Sender-Receiver) | Info Block | per card |
| Molecule | mms_B.4_Nội dung lời cảm ơn | Content Block | per card |
| Molecule | mms_B.4.4_Action | Action Bar | per card |
| Atom | mm_media_back (Back button) | Button | 1 |
| Atom | Avatar người gửi/nhận | Image | 2 per card |
| Atom | Tên người dùng | Text | 2 per card |
| Atom | Huy hiệu + Danh hiệu | Badge | 2 per card |
| Atom | Mũi tên (→) | Icon | 1 per card |
| Atom | Thời gian đăng | Text | 1 per card |
| Atom | Tiêu đề Kudo | Text | 1 per card |
| Atom | Nội dung lời cảm ơn | Text | 1 per card |
| Atom | Hashtags | Text | 1 per card |
| Atom | Heart icon + count | Button | 1 per card |
| Atom | Action buttons | Button | 2 per card |
| Atom | Nav Tab Item | Button | 4 |

### Main Components

1. **TopNavigation** - Thanh điều hướng trên cùng với nút Back và tiêu đề màn hình
2. **mm_media_bg** - Hình nền toàn màn hình (key visual)
3. **header** - Header chung SAA 2025 với text "Hệ thống giải thưởng"
4. **Danh sách Kudo** - Danh sách cuộn dọc chứa các thẻ Kudo
5. **mms_B.3_KUDO - Highlight** - Component tái sử dụng cho mỗi Kudo item
6. **nav bar** - Bottom Navigation 4 tab (saa, award, kudos, profile)

---

## Form Fields

Không áp dụng - Màn hình này không có form nhập liệu.

---

## API Mapping

### Khi tải màn hình (On Load)

| Method | Endpoint | Mục đích | Response |
|--------|----------|----------|----------|
| GET | /api/kudos | Lấy danh sách tất cả Kudos (phân trang) | `{ data: [KudoItem], pagination: { page, totalPages, totalItems } }` |

### Khi người dùng thao tác (On User Action)

| Hành động | Method | Endpoint | Mục đích |
|-----------|--------|----------|----------|
| Cuộn xuống cuối danh sách | GET | /api/kudos?page={next} | Tải thêm Kudos (infinite scroll / pagination) |
| Nhấn nút Heart/Like | POST | /api/kudos/:id/like | Thả tim cho Kudo |
| Nhấn nút chia sẻ | - | - | Mở dialog chia sẻ (native share) |
| Nhấn vào thẻ Kudo | GET | /api/kudos/:id | Lấy chi tiết Kudo |

### Xử lý lỗi

| Mã lỗi | Thông báo | Hành động UI |
|---------|-----------|--------------|
| 401 | Chưa đăng nhập | Chuyển về màn hình Login |
| 500 | Lỗi server | Hiển thị nút Thử lại |
| Timeout | Mất kết nối | Hiển thị thông báo offline |

---

## State Management

### Local State

| State | Type | Default | Mô tả |
|-------|------|---------|-------|
| kudosList | List<KudoItem> | [] | Danh sách Kudos đã tải |
| isLoading | bool | true | Đang tải dữ liệu |
| isLoadingMore | bool | false | Đang tải thêm (pagination) |
| currentPage | int | 1 | Trang hiện tại |
| hasNextPage | bool | true | Còn trang tiếp theo không |

### Global State (Riverpod)

| Provider | Type | Mô tả |
|----------|------|-------|
| allKudosProvider | AsyncValue<PaginatedList<KudoItem>> | Danh sách Kudos phân trang |
| kudoLikeProvider | FamilyAsyncValue<bool, String> | Trạng thái like theo kudoId |

---

## UI States

### Loading
- Hiển thị skeleton/shimmer cho các thẻ Kudo (3-4 skeleton cards)
- Shimmer cho avatar, tên, nội dung, hashtag

### Error
- Hiển thị thông báo lỗi ở giữa màn hình
- Nút "Thử lại" để tải lại danh sách

### Success
- Danh sách Kudo hiển thị đầy đủ
- Cuộn mượt mà với lazy loading
- Animation heart khi thả tim

### Empty
- Hiển thị trạng thái trống "Chưa có Kudos nào"
- Có thể kèm CTA "Gửi Kudos đầu tiên"

### Loading More (Pagination)
- Hiển thị loading indicator ở cuối danh sách
- Tự động tải khi cuộn đến gần cuối

---

## Analysis Metadata

| Key | Value |
|-----|-------|
| Ngày phân tích | 2026-04-13 |
| Độ tin cậy | High |
| Độ phức tạp | Medium |
| Ghi chú | Màn hình danh sách với component Kudo tái sử dụng (mms_B.3_KUDO - Highlight); cần xử lý pagination/infinite scroll; mỗi card có nhiều tương tác (like, share, xem chi tiết, xem profile) |

### Bước tiếp theo
- [ ] Lấy design items chi tiết qua list_frame_design_items
- [ ] Trích xuất styles qua list_frame_styles
- [ ] Xác nhận API contract với backend
- [ ] Xác nhận logic phân trang (infinite scroll vs pagination)
