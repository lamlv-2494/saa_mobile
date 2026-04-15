# Design Style: [iOS] Sun*Kudos_dropdown hashtag

**Frame ID**: `V5GRjAdJyb`
**Frame Name**: `[iOS] Sun*Kudos_dropdown hashtag`
**Figma File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-14

---

## Design Tokens

### Màu sắc

| Tên Token | Giá trị Hex/RGBA | Opacity | Sử dụng |
|-----------|-----------------|---------|---------|
| --color-background | `#00101A` | 100% | Nền chính (phía sau overlay) |
| --color-dropdown-bg | `#FFF8E1` | 100% | Nền dropdown container (sáng) |
| --color-tag-selected-bg | `#FFEA9E` | 100% | Nền tag đang chọn |
| --color-tag-unselected-bg | `rgba(255, 234, 158, 0.10)` | 10% | Nền tag chưa chọn |
| --color-tag-border | `#998C5F` | 100% | Border tag |
| --color-text-tag-selected | `#00101A` | 100% | Text tag đang chọn (tối trên nền sáng) |
| --color-text-tag-unselected | `#FFFFFF` | 100% | Text tag chưa chọn (sáng trên nền tối) |
| --color-primary | `#FFEA9E` | 100% | Accent chính |

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
| --radius-tag | 16px | Border radius tag pill (rounded) |
| --radius-dropdown | 8px | Border radius dropdown container |
| --border-tag | 1px solid #998C5F | Border tag unselected |
| --border-tag-selected | 1px solid #FFEA9E | Border tag selected |
| --border-dropdown | 1px solid #998C5F | Border dropdown container |

---

## Layout Specifications

### Dropdown Container (A)

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| position | Overlay dưới dropdown button "Hashtag" | Absolute/Popup |
| width | Auto (fit content, max 335px) | Theo nội dung |
| max-height | 200px | Scroll nếu vượt quá |
| padding | 12px | Padding trong |
| background | rgba(0, 16, 26, 0.95) | Nền tối bán trong suốt |
| border | 1px solid #998C5F | Border container |
| border-radius | 8px | Bo góc |
| backdrop-filter | blur(10px) | Hiệu ứng blur nền phía sau |

### Tag Pill

| Thuộc tính | Giá trị (Unselected) | Giá trị (Selected) |
|-----------|----------------------|---------------------|
| padding | 6px 12px | 6px 12px |
| border-radius | 16px | 16px |
| background | rgba(255, 234, 158, 0.10) | #FFEA9E |
| border | 1px solid #998C5F | 1px solid #FFEA9E |
| text color | #FFFFFF | #00101A |
| font | Montserrat 12px/16px, weight 500 | Montserrat 12px/16px, weight 500 |

### Cấu trúc Layout (ASCII)

```
┌─ Dropdown Container ────────────────────┐
│  ┌──────────┐ ┌──────────┐ ┌────────┐  │
│  │ #Teamwork│ │#Dedicated│ │#Inspir │  │
│  │ (selected)│ │          │ │        │  │
│  └──────────┘ └──────────┘ └────────┘  │
│  ┌──────────┐ ┌──────────┐             │
│  │#Creative │ │ #Support │             │
│  └──────────┘ └──────────┘             │
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
| **Font** | Montserrat 12px/16px, weight 500 |

### Tag Unselected (A.2)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Background** | rgba(255, 234, 158, 0.10) (vàng nhạt 10%) |
| **Border** | 1px solid #998C5F |
| **Text color** | #FFFFFF (sáng) |
| **Border-radius** | 16px |
| **Font** | Montserrat 12px/16px, weight 500 |

---

### Tag "Tất cả" (Reset filter)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Style** | Giống Tag Selected khi không có filter nào active (mặc định) |
| **Style khi có filter** | Giống Tag Unselected (để người dùng bấm reset) |
| **Vị trí** | Luôn ở đầu danh sách (trước các hashtag) |
| **Text** | "Tất cả" (i18n) |

### Loading State (trong dropdown)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Spinner** | CircularProgressIndicator, 24x24px, color #FFEA9E |
| **Position** | Center trong dropdown container |
| **Min height** | 60px |

### Empty State (không có hashtag)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Text** | "Chưa có hashtag nào" (i18n) |
| **Font** | Montserrat 12px/16px, weight 400, color #999999 |
| **Position** | Center trong dropdown container |

---

## Animation & Transitions

| Element | Property | Duration | Easing | Trigger |
|---------|----------|----------|--------|---------|
| Dropdown | opacity, transform | 150ms | ease-out | Open/Close |
| Tag | background-color, color | 100ms | ease-in-out | Select/Deselect |

---

## Ghi chú

- Dropdown xuất hiện ngay dưới button "Hashtag" trên Highlight section.
- Layout tag sử dụng Wrap (tự động xuống dòng) — không phải horizontal scroll.
- Tất cả icons PHẢI dùng SVG format.
- Asset paths PHẢI dùng `flutter_gen` (`Assets.xxx`).
- Dropdown này render trên cùng overlay layer với Dropdown Phòng ban — chỉ 1 dropdown mở tại 1 thời điểm.
