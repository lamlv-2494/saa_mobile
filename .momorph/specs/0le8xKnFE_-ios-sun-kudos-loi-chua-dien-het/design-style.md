# Design Style: [iOS] Sun*Kudos - Lỗi Chưa Điền Hết

**Frame ID**: `0le8xKnFE_`
**Frame Name**: `[iOS] Sun*Kudos_Lỗi chưa điền hết`
**Figma File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-14

---

## Design Tokens

> Sử dụng chung design tokens với màn hình parent `PV7jBVZU1N`.
> Xem chi tiết tại [design-style.md của PV7jBVZU1N](../PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/design-style.md).

### Màu sắc bổ sung (Trạng thái lỗi)

| Tên Token | Giá trị Hex/RGBA | Opacity | Sử dụng |
|-----------|-----------------|---------|---------|
| --color-error | `#D4271D` | 100% | Border input lỗi, text lỗi |
| --color-error-bg | `rgba(212, 39, 29, 0.15)` | 15% | Nền error banner |
| --color-error-border | `#D4271D` | 100% | Border error banner |
| --color-error-text | `#FFFFFF` | 100% | Text trong error banner |

### Typography bổ sung

| Tên Token | Font Family | Size | Weight | Line Height | Letter Spacing |
|-----------|-------------|------|--------|-------------|----------------|
| --text-error-banner | Montserrat | 13px | 500 | 18px | 0px |
| --text-error-field | Montserrat | 12px | 400 | 16px | 0px |

---

## Layout Specifications

### Container

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| width | 375px | iPhone standard |
| height | 989px (scrollable) | Dài hơn bình thường do error banner |
| background | `#00101A` | Dark theme |

> Layout tổng thể giống `PV7jBVZU1N` nhưng thêm Error Banner ở đầu form và border đỏ trên các trường lỗi.

### Layout Structure (ASCII) — Phần khác biệt

```
┌─────────────────────────────────────────────── 375px ──────────────────────────────────────────┐
│  Header (giống PV7jBVZU1N)                                                                     │
│                                                                                              │
│  ┌─ A. Header Text ────────────────────────────────────────────────────────────────────────┐  │
│  │  "Gửi lời cám ơn và ghi nhận đến đồng đội"                                              │  │
│  └──────────────────────────────────────────────────────────────────────────────────────────┘  │
│                                                                                              │
│  ┌═══ 1. ERROR BANNER (335px, NEW) ════════════════════════════════════════════════════════┐  │
│  │  bg: rgba(212,39,29,0.15), border: 1px #D4271D, r: 8px, padding: 12px                  │  │
│  │                                                                                          │  │
│  │  "Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!"                   │  │
│  │  (13px/500, white)                                                                       │  │
│  └══════════════════════════════════════════════════════════════════════════════════════════┘  │
│                                                                                              │
│  ┌─ B. Form Fields (gap: 16px) ────────────────────────────────────────────────────────────┐  │
│  │                                                                                          │  │
│  │  B.1. "Người nhận *"                                                                    │  │
│  │  ┌─ B.2. Recipient Dropdown ── BORDER ĐỎ (#D4271D) ──────────────────────────────────┐ │  │
│  │  │  [placeholder: "Tìm kiếm"]                                                          │ │  │
│  │  └────────────────────────────────────────────────────────────────────────────────────┘ │  │
│  │                                                                                          │  │
│  │  B.3. "Danh hiệu *"                                                                    │  │
│  │  ┌─ B.4. Title Input ── (bình thường nếu đã điền, ĐỎ nếu trống) ────────────────────┐ │  │
│  │  │  [text hoặc placeholder]                                                              │ │  │
│  │  └────────────────────────────────────────────────────────────────────────────────────┘ │  │
│  │                                                                                          │  │
│  │  ... (các trường khác — border đỏ nếu trống/lỗi) ...                                    │  │
│  │                                                                                          │  │
│  │  D. Textarea ── BORDER ĐỎ (#D4271D) nếu trống ──                                       │  │
│  │                                                                                          │  │
│  │  E. Hashtag ── INDICATOR LỖI nếu 0 tag ──                                               │  │
│  │                                                                                          │  │
│  └──────────────────────────────────────────────────────────────────────────────────────────┘  │
│                                                                                              │
│  ┌─ Bottom Actions ────────────────────────────────────────────────────────────────────────┐  │
│  │  [Hủy]    [Gửi đi ← vẫn enabled]                                                       │  │
│  └──────────────────────────────────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Component Style Details

### 1. Error Banner (MỚI — chỉ có ở trạng thái lỗi)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:10124` | - |
| width | 335px (100% - padding) | `double.infinity` |
| min-height | auto (fit content) | Wrap content |
| padding | 12px | `EdgeInsets.all(12)` |
| background | `rgba(212, 39, 29, 0.15)` | `Color(0x26D4271D)` |
| border | 1px solid `#D4271D` | `Border.all(color: Color(0xFFD4271D))` |
| border-radius | 8px | `BorderRadius.circular(8)` |
| margin-bottom | 16px | `SizedBox(height: 16)` dưới banner |

#### Error Text

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| text | "Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!" | i18n: `t.kudos.send.validationError` |
| font-family | Montserrat | `GoogleFonts.montserrat()` |
| font-size | 13px | `fontSize: 13` |
| font-weight | 500 | `fontWeight: FontWeight.w500` |
| color | `#FFFFFF` | `Colors.white` |
| line-height | 18px | `height: 1.38` |

---

### Input Fields — Trạng thái lỗi

#### B.2. Recipient Dropdown (Error State)

| Thuộc tính | Giá trị thay đổi | Flutter |
|-----------|------------------|--------|
| border | 1px solid `#D4271D` (thay vì #998C5F) | `Border.all(color: Color(0xFFD4271D))` |

#### B.4. Danh hiệu Input (Error State)

| Thuộc tính | Giá trị thay đổi | Flutter |
|-----------|------------------|--------|
| border | 1px solid `#D4271D` (thay vì #998C5F) | `Border.all(color: Color(0xFFD4271D))` |

#### D. Message Textarea (Error State)

| Thuộc tính | Giá trị thay đổi | Flutter |
|-----------|------------------|--------|
| border | 1px solid `#D4271D` | `Border.all(color: Color(0xFFD4271D))` |

#### E. Hashtag Section (Error State)

| Thuộc tính | Giá trị thay đổi | Flutter |
|-----------|------------------|--------|
| Add button border | 1px dashed `#D4271D` (thay vì #998C5F) | Border đỏ |

---

### Input Fields — Trạng thái bình thường (đã điền)

> Giữ nguyên style bình thường (border: #998C5F) cho các trường đã có giá trị.

---

### I. Send Button — Vẫn enabled khi có lỗi

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| background | `#FFEA9E` | Vẫn enabled — cho phép retry |
| text-color | `#00101A` | Giữ nguyên |
| enabled | true | Người dùng có thể bấm lại sau khi sửa |

---

## Component Hierarchy with Styles (Error State)

```
Screen (bg: #00101A, 375x989)
├── Header Overlay
│
├── ScrollView (flex: 1, padding: 0 20px)
│   ├── A. Header Text (16px/500, white)
│   │
│   ├── ★ 1. ERROR BANNER [NEW]
│   │   (w: 335, bg: #D4271D/15%, border: 1px #D4271D, r: 8, p: 12)
│   │   └── Text "Bạn cần điền đủ..." (13px/500, white)
│   │
│   ├── B. Form Fields (gap: 16px)
│   │   ├── B.1. "Người nhận *"
│   │   ├── B.2. Dropdown [border: #D4271D ← ERROR] ★
│   │   ├── B.3. "Danh hiệu *"
│   │   ├── B.4. Input [border: #D4271D ← ERROR nếu trống] ★
│   │   ├── B.5. "Tiêu chuẩn cộng đồng"
│   │   ├── B.7. Label nội dung
│   │   ├── C. Toolbar
│   │   ├── D. Textarea [border: #D4271D ← ERROR nếu trống] ★
│   │   ├── D.1. Hint
│   │   │
│   │   ├── E. Hashtag [border: #D4271D ← ERROR nếu 0 tag] ★
│   │   │
│   │   ├── F. Image (bình thường — không bắt buộc)
│   │   │
│   │   └── G. Anonymous Toggle (bình thường)
│   │
│   └── Spacer
│
├── Bottom Actions
│   ├── H. Cancel (enabled)
│   └── I. Send (ENABLED — cho phép retry) ★
│
└── Safe Area (34px)
```

---

## Trạng thái chuyển đổi (State Transitions)

| Từ trạng thái | Hành động | Đến trạng thái |
|---------------|-----------|----------------|
| Form bình thường | Bấm "Gửi đi" (thiếu trường) | Error state (hiện banner + border đỏ) |
| Error state | Điền trường bị lỗi | Border trường đó quay lại #998C5F |
| Error state | Bắt đầu sửa bất kỳ trường nào | Error banner ẩn đi |
| Error state | Điền đủ + bấm "Gửi đi" | Submit → Loading → Success/Error |
| Error state | Bấm "Gửi đi" (vẫn thiếu) | Error banner hiển thị lại (shake animation) |

---

## Icon Specifications

| Tên Icon | Kích thước | Màu sắc | Sử dụng |
|----------|-----------|---------|---------|
| ic_warning | 16x16 | `#D4271D` | Icon cảnh báo trong error banner (tùy chọn) |

> Nếu thêm icon cảnh báo, PHẢI sử dụng format SVG.

---

## Animation & Transitions

| Phần tử | Thuộc tính | Thời lượng | Easing | Trigger |
|---------|-----------|-----------|--------|---------|
| Error Banner | slide-down + fade-in (h: 0→auto) | 200ms | ease-out | Validation fail |
| Error Banner | slide-up + fade-out | 150ms | ease-in | Người dùng sửa form |
| Input border | border-color (#998C5F → #D4271D) | 150ms | ease-in-out | Validation fail |
| Input border | border-color (#D4271D → #998C5F) | 150ms | ease-in-out | Trường được sửa |
| Error Banner | shake (translateX: 0→-5→5→0) | 300ms | ease-in-out | Submit lại vẫn lỗi |
| Scroll | scrollTo (error banner/first error) | 300ms | ease-out | Validation fail |

---

## Implementation Mapping

| Phần tử Design | Figma Node ID | Flutter Widget | File |
|----------------|---------------|----------------|------|
| Error Banner | `6885:10124` | `ValidationErrorBanner` | `validation_error_banner.dart` |
| Error Border (input) | N/A (state change) | `InputDecoration.error` | inline |

---

## Ghi chú

- Đây KHÔNG phải màn hình riêng — chỉ là trạng thái (error state) của `PV7jBVZU1N`.
- Error banner là widget mới cần implement — `ValidationErrorBanner`.
- Text lỗi chính xác từ Figma: "Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!"
- Validation chạy local trong `SendKudosViewModel.submit()`.
- Các trường cần validate khi submit:
  - `recipientId` (not null) — Người nhận bắt buộc
  - `title` (not empty, not whitespace only, max 100 chars) — Danh hiệu bắt buộc
  - `message` (not empty, not whitespace only, max 1000 chars) — Nội dung bắt buộc
  - `hashtags` (length >= 1, max 5) — Hashtag bắt buộc ít nhất 1
  - `recipientId != currentUserId` — Không gửi cho chính mình
- Nút "Gửi đi" vẫn enabled ở error state — cho phép submit lại ngay sau khi sửa.
- Height 989px = 941px (normal) + ~48px (error banner height).
