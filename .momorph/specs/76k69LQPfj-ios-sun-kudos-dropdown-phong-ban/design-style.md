# Design Style: [iOS] Sun*Kudos_dropdown phòng ban

**Frame ID**: `76k69LQPfj`
**Frame Name**: `[iOS] Sun*Kudos_dropdown phòng ban`
**Figma File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-14

---

## Design Tokens

> Design tokens giống hệt Dropdown Hashtag (`V5GRjAdJyb`). Chỉ liệt kê phần **khác biệt** (dữ liệu hiển thị).

### Màu sắc

| Tên Token | Giá trị Hex/RGBA | Opacity | Sử dụng |
|-----------|-----------------|---------|---------|
| --color-background | `#00101A` | 100% | Nền chính (phía sau overlay) |
| --color-tag-selected-bg | `#FFEA9E` | 100% | Nền tag đang chọn |
| --color-tag-unselected-bg | `rgba(255, 234, 158, 0.10)` | 10% | Nền tag chưa chọn |
| --color-tag-border | `#998C5F` | 100% | Border tag |
| --color-text-tag-selected | `#00101A` | 100% | Text tag đang chọn |
| --color-text-tag-unselected | `#FFFFFF` | 100% | Text tag chưa chọn |

### Typography

| Tên Token | Font Family | Size | Weight | Line Height | Letter Spacing |
|-----------|-------------|------|--------|-------------|----------------|
| --text-tag | Montserrat | 12px | 500 | 16px | 0px |

### Spacing

| Tên Token | Giá trị | Sử dụng |
|-----------|---------|---------|
| --spacing-tag-gap | 8px | Gap giữa các tag pills |
| --spacing-dropdown-padding | 12px | Padding dropdown container |

### Border & Radius

| Tên Token | Giá trị | Sử dụng |
|-----------|---------|---------|
| --radius-tag | 16px | Border radius tag pill |
| --radius-dropdown | 8px | Border radius dropdown container |
| --border-tag | 1px solid #998C5F | Border tag unselected |
| --border-tag-selected | 1px solid #FFEA9E | Border tag selected |

---

## Layout Specifications

### Dropdown Container (A)

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| position | Overlay dưới dropdown button "Phòng ban" | Absolute/Popup |
| width | Auto (fit content, max 335px) | Theo nội dung |
| max-height | 200px | Scroll nếu vượt quá |
| padding | 12px | Padding trong |
| background | rgba(0, 16, 26, 0.95) | Nền tối bán trong suốt |
| border | 1px solid #998C5F | Border container |
| border-radius | 8px | Bo góc |
| backdrop-filter | blur(10px) | Hiệu ứng blur nền phía sau |

### Cấu trúc Layout (ASCII)

```
┌─ Dropdown Container ────────────────────┐
│  ┌─────┐ ┌──────┐ ┌─────┐ ┌──────┐    │
│  │ CEV │ │ CECV │ │ DCC │ │ HN1  │    │
│  │(sel)│ │      │ │     │ │      │    │
│  └─────┘ └──────┘ └─────┘ └──────┘    │
│  ┌──────┐ ┌──────┐ ┌──────┐           │
│  │ HCM1 │ │ DN1  │ │ JP1  │           │
│  └──────┘ └──────┘ └──────┘           │
└──────────────────────────────────────────┘
```

> Tags sử dụng **Wrap layout** (flex-wrap) — tự động xuống dòng khi hết chỗ.

---

## Chi tiết Style

### Tag Selected (A.1)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Background** | #FFEA9E (vàng đậm) |
| **Border** | 1px solid #FFEA9E |
| **Text color** | #00101A (tối) |
| **Border-radius** | 16px |
| **Padding** | 6px 12px |
| **Font** | Montserrat 12px/16px, weight 500 |

### Tag Unselected (A.2)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Background** | rgba(255, 234, 158, 0.10) |
| **Border** | 1px solid #998C5F |
| **Text color** | #FFFFFF |
| **Border-radius** | 16px |
| **Padding** | 6px 12px |
| **Font** | Montserrat 12px/16px, weight 500 |

---

### Tag "Tất cả" (Reset filter)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Style** | Giống Tag Selected khi không có filter nào active (mặc định) |
| **Style khi có filter** | Giống Tag Unselected (để người dùng bấm reset) |
| **Vị trí** | Luôn ở đầu danh sách (trước các phòng ban) |
| **Text** | "Tất cả" (i18n) |

### Loading State (trong dropdown)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Spinner** | CircularProgressIndicator, 24x24px, color #FFEA9E |
| **Position** | Center trong dropdown container |
| **Min height** | 60px |

### Empty State (không có phòng ban)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Text** | "Chưa có phòng ban nào" (i18n) |
| **Font** | Montserrat 12px/16px, weight 400, color #999999 |
| **Position** | Center trong dropdown container |

---

## Khác biệt so với Dropdown Hashtag

| Thuộc tính | Dropdown Hashtag | Dropdown Phòng ban |
|-----------|-----------------|-------------------|
| Vị trí | Dưới button "Hashtag" | Dưới button "Phòng ban" |
| Dữ liệu | Hashtag names (#Teamwork...) | Department codes (CEV, CECV...) |
| API endpoint | `/api/v1/hashtags` | `/api/v1/departments` |
| State trong ViewModel | `selectedHashtag` | `selectedDepartment` |

> Tất cả style (colors, typography, spacing, border) giống hệt nhau — chỉ khác dữ liệu.

---

## Animation & Transitions

| Element | Property | Duration | Easing | Trigger |
|---------|----------|----------|--------|---------|
| Dropdown | opacity, transform | 150ms | ease-out | Open/Close |
| Tag | background-color, color | 100ms | ease-in-out | Select/Deselect |

---

## Tham chiếu

- Design tokens đầy đủ: [Dropdown Hashtag design-style.md](../V5GRjAdJyb-ios-sun-kudos-dropdown-hashtag/design-style.md)

---

## Ghi chú

- Dropdown Phòng ban và Dropdown Hashtag NÊN dùng chung 1 generic `FilterDropdown` widget.
- Tất cả icons PHẢI dùng SVG format.
- Asset paths PHẢI dùng `flutter_gen` (`Assets.xxx`).
- Chỉ 1 dropdown được mở tại 1 thời điểm.
