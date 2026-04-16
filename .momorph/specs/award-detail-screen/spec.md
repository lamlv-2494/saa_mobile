# Đặc tả tính năng: Màn hình Chi tiết Giải thưởng (Award Detail)

**Frame IDs**: `c-QM3_zjkG`, `FQoJZLkG_d`, `QQvsfK3yaK`, `7y195PPTxQ`, `O98TwiHaJe`, `b2BuS8HYIt`
**Frame Names**: `[iOS] Award_Top talent`, `[iOS] Award_Top project`, `[iOS] Award_Top project leader`, `[iOS] Award_Best Manager`, `[iOS] Award_Signature 2025 - Creator`, `[iOS] Award_MVP`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-14
**Trạng thái**: Bản nháp

---

## Tổng quan

Màn hình Chi tiết Giải thưởng (Award Detail) là một **màn hình dùng chung** hiển thị thông tin chi tiết về từng loại giải thưởng trong hệ thống SAA 2025. Người dùng có thể chuyển đổi giữa 6 loại giải thưởng thông qua **dropdown filter**, nội dung sẽ thay đổi động theo loại giải được chọn.

### 6 loại giải thưởng:

| Loại giải | Dropdown Text | Số lượng | Đơn vị | Giá trị | Ghi chú |
|-----------|--------------|----------|--------|---------|---------|
| Top Talent | Top Talent | 10 | Cá nhân | 7.000.000 VNĐ | cho mỗi giải thưởng |
| Top Project | Top Project | 02 | Tập thể | 15.000.000 VNĐ | cho mỗi giải thưởng |
| Top Project Leader | Top Project Leader | 03 | Cá nhân | 7.000.000 VNĐ | cho mỗi giải thưởng |
| Best Manager | Best Manager | 01 | Cá nhân | 10.000.000 VNĐ | cho mỗi giải thưởng |
| Signature 2025 - Creator | Signature 2025 - Creator | 01 | Cá nhân hoặc tập thể | 5.000.000 VNĐ (cá nhân) / 8.000.000 VNĐ (tập thể) | cho giải cá nhân / cho giải tập thể |
| MVP | MVP (Most Valuable Person) | 01 | Cá nhân | 15.000.000 VNĐ | cho giải cá nhân |

---

## User Scenarios & Testing *(bắt buộc)*

### User Story 1 - Xem thông tin chi tiết giải thưởng (Priority: P1)

Là một Sunner, tôi muốn xem thông tin chi tiết về một giải thưởng cụ thể để hiểu rõ ý nghĩa, tiêu chí và giá trị của giải.

**Lý do ưu tiên**: Đây là mục đích chính của màn hình — hiển thị đầy đủ thông tin giải thưởng.

**Test độc lập**: Truy cập màn hình Awards, chọn một giải bất kỳ từ dropdown → hiển thị đầy đủ: hình ảnh huy hiệu, tên giải, mô tả, số lượng, giá trị.

**Acceptance Scenarios**:

1. **Given** người dùng nhấn tab Awards từ bottom nav, **When** màn hình load xong, **Then** hiển thị giải thưởng mặc định (Top Talent) với đầy đủ thông tin: hình huy hiệu, tên, mô tả, số lượng (10 Cá nhân), giá trị (7.000.000 VNĐ cho mỗi giải thưởng).
2. **Given** người dùng nhấn vào card giải "Best Manager" trên Home, **When** màn hình Awards load xong, **Then** dropdown hiển thị "Best Manager" và nội dung hiển thị chi tiết giải Best Manager (không phải Top Talent).
3. **Given** màn hình đã load, **When** người dùng cuộn xuống, **Then** hiển thị thêm phần mô tả dài, số liệu thống kê, và khu vực Sun* Kudos.

---

### User Story 2 - Chuyển đổi giữa các loại giải thưởng (Priority: P1)

Là một Sunner, tôi muốn chuyển đổi nhanh giữa các loại giải thưởng để so sánh thông tin.

**Lý do ưu tiên**: Dropdown là tương tác chính duy nhất trên màn hình, cho phép duyệt tất cả 6 giải.

**Test độc lập**: Nhấn dropdown → hiển thị danh sách 6 giải → chọn giải khác → nội dung thay đổi.

**Acceptance Scenarios**:

1. **Given** dropdown đang hiển thị "Top Talent", **When** người dùng nhấn vào dropdown, **Then** hiển thị danh sách 6 loại giải: Top Talent, Top Project, Top Project Leader, Best Manager, Signature 2025 - Creator, MVP.
2. **Given** danh sách dropdown đang mở, **When** người dùng chọn "Top Project", **Then** nội dung thay đổi: hình huy hiệu → TOP PROJECT, tên → "Top Project", mô tả → mô tả Top Project, số lượng → "02 Tập thể", giá trị → "15.000.000 VNĐ cho mỗi giải thưởng".
3. **Given** người dùng chọn "Signature 2025 - Creator", **When** nội dung load xong, **Then** hiển thị **2 block "Giá trị giải thưởng" riêng biệt** (mỗi block có icon + label "Giá trị giải thưởng" + value riêng, cách nhau bởi divider): block 1 = "5.000.000 VNĐ cho giải cá nhân", block 2 = "8.000.000 VNĐ cho giải tập thể".

---

### User Story 3 - Điều hướng tới trang Sun* Kudos (Priority: P2)

Là một Sunner, tôi muốn tìm hiểu thêm về phong trào Sun* Kudos bằng cách nhấn nút "Chi tiết".

**Lý do ưu tiên**: Kudos là tính năng phụ, nhưng quan trọng cho việc khám phá thêm nội dung SAA.

**Test độc lập**: Cuộn xuống phần Sun* Kudos → nhấn nút "Chi tiết" → điều hướng đến trang Kudos.

**Acceptance Scenarios**:

1. **Given** người dùng cuộn đến phần Sun* Kudos, **When** nhấn nút "Chi tiết", **Then** điều hướng đến trang chi tiết Sun* Kudos.

---

### User Story 4 - Đa ngôn ngữ (Priority: P2)

Là một Sunner quốc tế, tôi muốn xem thông tin giải thưởng bằng ngôn ngữ tôi chọn.

**Lý do ưu tiên**: Hỗ trợ VN/EN theo yêu cầu i18n.

**Test độc lập**: Chuyển ngôn ngữ từ VN sang EN → tất cả label/text thay đổi ngôn ngữ tương ứng.

**Acceptance Scenarios**:

1. **Given** ngôn ngữ đang là VN, **When** người dùng đổi sang EN, **Then** tiêu đề, label, mô tả giải thưởng hiển thị bằng tiếng Anh.

---

### Edge Cases

- Khi API trả về danh sách giải thưởng rỗng → hiển thị trạng thái empty: icon placeholder + text "Chưa có dữ liệu giải thưởng" (i18n) + nút retry.
- Khi mạng chậm → hiển thị skeleton/shimmer cho toàn bộ content area (badge image, text blocks, stat rows) khi đang fetch dữ liệu giải thưởng.
- Khi API trả về lỗi (timeout, 500, no internet) → hiển thị trạng thái error: icon lỗi + message mô tả lỗi (i18n) + nút "Thử lại" (PrimaryButton).
- Khi giải Signature có cả 2 mức giá trị (cá nhân + tập thể) → layout cần hiển thị 2 dòng prize riêng biệt.
- Khi chuyển giải qua dropdown → scroll position PHẢI reset về đầu phần Award Detail (để người dùng thấy badge image của giải mới).
- Khi nhấn dropdown lần nữa sau khi đã chọn → giải hiện tại được highlight trong danh sách.
- Khi badge_image_url là null hoặc URL lỗi → hiển thị placeholder image mặc định (PNG).

---

## UI/UX Requirements *(từ Figma)*

### Cấu trúc màn hình

| Thành phần | Mô tả | Tương tác |
|-----------|-------|-----------|
| Header (mms_1_header) | Logo SAA + nút ngôn ngữ, tìm kiếm, thông báo | Nhấn: chọn ngôn ngữ, mở tìm kiếm, mở thông báo |
| KV Kudos Banner (mms_A) | Text "Hệ thống ghi nhận và cảm ơn" + Logo KUDOS | Hiển thị tĩnh |
| Section Header (mms_B) | Tiêu đề "Hệ thống giải thưởng SAA 2025" + Dropdown filter | Nhấn dropdown: chọn loại giải |
| Award Badge Image (mms_2.3) | Hình huy hiệu giải thưởng dạng tròn 160x160 | Hiển thị tĩnh |
| Award Info | Tên giải + icon + mô tả chi tiết | Hiển thị tĩnh, cuộn |
| Award Stats | Số lượng giải thưởng + Giá trị giải thưởng | Hiển thị tĩnh |
| Sun* Kudos Block (mms_2.4) | Banner Kudos + mô tả + nút "Chi tiết" | Nhấn nút: điều hướng |
| Bottom Nav Bar (mms_3) | 4 tab: SAA 2025, Awards (active), Kudos, Profile | Nhấn tab: chuyển màn hình |

### Luồng điều hướng

- **Từ**: Tab Awards trên bottom navigation / Trang chủ SAA 2025
- **Đến**: Trang chi tiết Sun* Kudos (qua nút "Chi tiết")
- **Tab active**: Awards (highlight màu vàng)

### Yêu cầu giao diện

- Chi tiết thiết kế → xem [design-style.md](design-style.md)
- Màn hình cuộn dọc (scrollable)
- Header cố định ở trên cùng với gradient fade
- Bottom nav bar cố định ở dưới cùng
- Background tối (#00101A) với hình nền key visual

### Accessibility

- Dropdown filter: semantic label rõ ràng ("Chọn loại giải thưởng")
- Hình huy hiệu: `semanticLabel` mô tả tên giải (ví dụ: "Huy hiệu giải Top Talent")
- Nút "Chi tiết": semantic hint "Mở trang chi tiết Sun* Kudos"
- Bottom nav tabs: mỗi tab có `semanticLabel` rõ ràng
- Text contrast: đảm bảo WCAG AA — text vàng #FFEA9E trên nền tối #00101A (ratio ≈ 12.5:1, pass)

---

## Requirements *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Hệ thống PHẢI hiển thị đầy đủ thông tin giải thưởng: hình huy hiệu, tên, mô tả, số lượng, đơn vị, giá trị tiền thưởng.
- **FR-002**: Hệ thống PHẢI cung cấp dropdown để chuyển đổi giữa 6 loại giải thưởng.
- **FR-003**: Khi chọn giải từ dropdown, nội dung PHẢI thay đổi động (không load lại trang).
- **FR-004**: Giải "Signature 2025 - Creator" PHẢI hiển thị 2 mức giá trị riêng biệt (cá nhân + tập thể).
- **FR-005**: Nút "Chi tiết" trong phần Sun* Kudos PHẢI điều hướng đến trang chi tiết Kudos.
- **FR-006**: Bottom nav bar PHẢI highlight tab "Awards" đang active.
- **FR-007**: Tất cả static labels PHẢI hỗ trợ đa ngôn ngữ (VN/EN) thông qua slang i18n. Nội dung dynamic từ Supabase dùng cột `_vi`/`_en`.
- **FR-008**: Nội dung mô tả, tên giải, số lượng, giá trị PHẢI được fetch từ Supabase (không hardcode).
- **FR-009**: Khi mở từ bottom nav (không có context) → mặc định hiển thị Top Talent. Khi mở từ Home qua award card → hiển thị giải tương ứng với card đã nhấn.
- **FR-010**: Dropdown PHẢI mở dưới dạng PopupMenu nằm ngay bên dưới widget dropdown button.
- **FR-011**: Layout Prize Stat PHẢI render động theo số lượng AwardPrize records — không hardcode 1 hay 2 block. Giải "Signature 2025 - Creator" hiện có 2 block, các giải khác có 1 block.

### Phân loại Text: i18n (slang) vs Supabase

| Text | Nguồn | Ghi chú |
|------|-------|---------|
| "Hệ thống ghi nhận và cảm ơn" | slang i18n | Static label |
| "Sun* Annual Awards 2025" | slang i18n | Static label |
| "Hệ thống giải thưởng SAA 2025" | slang i18n | Static label |
| "Số lượng giải thưởng" | slang i18n | Static label |
| "Giá trị giải thưởng" | slang i18n | Static label |
| "Phong trào ghi nhận" | slang i18n | Static label |
| "Sun* Kudos" | slang i18n | Static label |
| "Chi tiết" (nút) | slang i18n | Static label |
| "ĐIỂM MỚI CỦA SAA 2025" + mô tả Kudos | slang i18n | Static label (cùng nội dung cho cả 6 giải) |
| Tên giải (Top Talent, Top Project, ...) | Supabase `name_vi`/`name_en` | Dynamic content |
| Mô tả giải thưởng | Supabase `description_vi`/`description_en` | Dynamic content |
| Số lượng + đơn vị (10 Cá nhân, 02 Tập thể) | Supabase `quantity`, `unit_vi`/`unit_en` | Dynamic content |
| Giá trị tiền (7.000.000 VNĐ) | Supabase `value_amount` | Dynamic content, format số |
| Ghi chú giải (cho mỗi giải thưởng) | Supabase `note_vi`/`note_en` | Dynamic content |
| "Chưa có dữ liệu giải thưởng" | slang i18n | Empty state |
| "Không thể tải dữ liệu" | slang i18n | Error state |
| "Thử lại" | slang i18n | Retry button |
| "Chọn loại giải thưởng" | slang i18n | Dropdown semantic label |

### Yêu cầu kỹ thuật

- **TR-001**: Dữ liệu giải thưởng PHẢI được cache sau lần fetch đầu tiên để chuyển giải mượt mà.
- **TR-002**: Hình huy hiệu giải thưởng PHẢI dùng PNG (key visual) theo constitution.
- **TR-003**: Kiến trúc MVVM: 1 AwardViewModel + 1 AwardState chứa selectedAwardType và danh sách awards.
- **TR-004**: Tất cả asset paths PHẢI dùng flutter_gen (Assets.xxx).
- **TR-005**: PHẢI tái sử dụng shared widgets đã có: `BottomNavBar`, `SectionHeaderWidget`, `PrimaryButton`, `OutlineButton`.

### Thực thể chính

> **LƯU Ý**: Model `AwardCategory` đã tồn tại tại `lib/features/home/data/models/award_category.dart` với các field: `id` (int), `name`, `imageUrl`, `description`, `sortOrder`. Model này cần được **mở rộng** (không tạo mới) để hỗ trợ thêm các field cho Award Detail screen.

- **AwardCategory (mở rộng)**: Cần thêm các field: `nameEn`, `descriptionEn`, `quantity`, `unit` (vi), `unitEn`, `badgeImageUrl` (thay cho `imageUrl`), `slug`.
- **AwardPrize (mới)**: Cho giải có nhiều mức giá trị — fields: `id`, `awardCategoryId`, `prizeType` (individual/team), `valueAmount` (VNĐ), `noteVi`, `noteEn`, `sortOrder`.

---

## State Management

### Local State (AwardState — freezed)

| State | Kiểu | Giá trị ban đầu | Mục đích |
|-------|------|-----------------|---------|
| selectedCategoryIndex | int | 0 (Top Talent) hoặc index từ navigation argument | Giải đang được chọn trong dropdown |
| categories | List\<AwardCategory\> | [] | Danh sách 6 loại giải (cache sau fetch) |

### Global State (đã có)

| State | Provider | Read/Write | Mục đích |
|-------|---------|-----------|---------|
| locale | localeNotifierProvider | Read | Ngôn ngữ hiện tại (VN/EN) để hiển thị text đúng |
| notificationCount | - | Read | Số thông báo chưa đọc (badge trên icon chuông) |

### UI States

| Trạng thái | Mô tả |
|-----------|-------|
| Loading | Skeleton/shimmer toàn bộ content khi lần đầu fetch danh sách giải |
| Success | Hiển thị đầy đủ thông tin giải thưởng |
| Error | Thông báo lỗi + nút retry khi không tải được dữ liệu |
| Switching | Khi chọn giải khác từ dropdown → thay đổi nội dung ngay (dữ liệu đã cache, không cần loading) |

### Quy tắc format số tiền

- Format theo locale VN: dùng dấu chấm phân cách hàng nghìn (ví dụ: `7.000.000 VNĐ`)
- Format theo locale EN: dùng dấu phẩy phân cách (ví dụ: `7,000,000 VND`)
- Đơn vị tiền tệ: VNĐ (VN) / VND (EN)

---

## API Dependencies

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|---------|-----------|
| /rest/v1/award_categories?select=*,award_prizes(*) | GET | Lấy danh sách giải thưởng kèm mức giá trị | Mới |

> **Ghi chú**: Dùng Supabase REST convention (`/rest/v1/`). Chỉ cần 1 query duy nhất với nested select để lấy cả `award_prizes`. Kết quả cache trên client — khi chuyển giải qua dropdown không cần gọi API lại.

### Cấu trúc dữ liệu dự kiến (Supabase)

```sql
-- Bảng award_categories
CREATE TABLE award_categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT UNIQUE NOT NULL, -- 'top_talent', 'top_project', etc.
  name_vi TEXT NOT NULL,
  name_en TEXT NOT NULL,
  description_vi TEXT NOT NULL,
  description_en TEXT NOT NULL,
  quantity INTEGER NOT NULL,
  unit_vi TEXT NOT NULL, -- 'Cá nhân', 'Tập thể'
  unit_en TEXT NOT NULL,
  badge_image_url TEXT,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Bảng award_prizes (cho giải có nhiều mức giá trị)
CREATE TABLE award_prizes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  award_category_id UUID REFERENCES award_categories(id),
  prize_type TEXT NOT NULL, -- 'individual', 'team'
  value_amount BIGINT NOT NULL, -- VNĐ
  note_vi TEXT NOT NULL, -- 'cho mỗi giải thưởng', 'cho giải cá nhân'
  note_en TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0
);
```

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường được

- **SC-001**: Tất cả 6 loại giải thưởng hiển thị đúng thông tin từ Figma.
- **SC-002**: Chuyển đổi giải qua dropdown mượt mà, không delay đáng kể.
- **SC-003**: Layout pixel-perfect so với thiết kế Figma (sai lệch < 2px).
- **SC-004**: Hỗ trợ đa ngôn ngữ VN/EN hoạt động đúng cho tất cả text.

---

## Ngoài phạm vi

- Chức năng bình chọn/đề cử giải thưởng (sẽ ở màn hình khác).
- Hiển thị danh sách người đạt giải (chưa có trong thiết kế).
- Push notification cho kết quả giải thưởng.
- Animation chuyển đổi giữa các giải (không thấy trong Figma).

---

## Dependencies

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [ ] API specifications (`.momorph/API.yml`) — cần tạo
- [ ] Database schema (`.momorph/database.sql`) — cần tạo/mở rộng bảng award_categories, thêm bảng award_prizes
- [x] Screen flow documented (`.momorph/contexts/SCREENFLOW.md`) — đã cập nhật 2026-04-14
- [x] Screen spec documented (`.momorph/contexts/screen_specs/ios_award_detail.md`) — đã tạo 2026-04-14

---

## Ghi chú

- Cả 6 màn hình chia sẻ **cùng một layout** — chỉ khác dữ liệu content. Nên implement dưới dạng 1 widget/screen duy nhất với dữ liệu động.
- Giải "Signature 2025 - Creator" là trường hợp đặc biệt có 2 mức giá trị (cá nhân + tập thể) — cần xử lý layout linh hoạt.
- Header và Bottom Nav Bar là shared components đã có trong hệ thống (tái sử dụng từ các màn hình khác).
- Phần Sun* Kudos Block giống nhau ở tất cả 6 variants — cũng là component tái sử dụng.
