# Design Style: [iOS] Sun*Kudos - Dropdown Hashtag

**Frame ID**: `aKWA2klsnt`
**Frame Name**: `[iOS] Sun*Kudos_Gửi lời chúc Kudos_dropdown hashtag`
**Figma File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-14

---

## Design Tokens

> Sử dụng chung design tokens với màn hình parent `PV7jBVZU1N`.
> Xem chi tiết tại [design-style.md của PV7jBVZU1N](../PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/design-style.md).

### Màu sắc bổ sung (Dropdown Hashtag)

| Tên Token | Giá trị Hex/RGBA | Opacity | Sử dụng |
|-----------|-----------------|---------|---------|
| --color-dropdown-bg | `#0A1A24` | 100% | Nền dropdown list |
| --color-dropdown-item-hover | `rgba(255, 234, 158, 0.08)` | 8% | Nền item khi hover/press |
| --color-dropdown-selected | `rgba(255, 234, 158, 0.15)` | 15% | Nền item đã chọn |
| --color-check-icon | `#FFEA9E` | 100% | Icon check khi đã chọn |
| --color-overlay | `rgba(0, 0, 0, 0.5)` | 50% | Overlay phía sau dropdown |

### Typography

| Tên Token | Font Family | Size | Weight | Line Height | Letter Spacing |
|-----------|-------------|------|--------|-------------|----------------|
| --text-hashtag-item | Montserrat | 14px | 500 | 20px | 0px |
| --text-hashtag-selected | Montserrat | 14px | 700 | 20px | 0px |

---

## Layout Specifications

### Dropdown Container

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| width | 335px | Bằng width form field |
| max-height | 240px | Tối đa ~6 items visible, scroll nếu dài hơn |
| background | `#0A1A24` | Nền tối |
| border | 1px solid `#998C5F` | Border vàng nhạt |
| border-radius | 4px | Cùng radius với input |
| overflow | scroll | Vertical scroll |
| position | absolute / overlay | Xuất hiện ngay dưới nút "+ Hashtag" |

### Layout Structure (ASCII)

```
┌─── Form (parent, behind overlay) ────────────────────────────────────────────┐
│  ...                                                                          │
│  ┌─ E. Hashtag Section ────────────────────────────────────────────────────┐  │
│  │  "Hashtag *"                                                            │  │
│  │  ┌─ Tag Group ──────────────────────────────────────────────────────┐   │  │
│  │  │  [#tag1 ✕] [+ Hashtag ▾]                                        │   │  │
│  │  └──────────────────────────────────────────────────────────────────┘   │  │
│  │                                                                         │  │
│  │  ┌═══ Dropdown Overlay (335px, max-h: 240px) ═══════════════════════┐  │  │
│  │  │                                                                   │  │  │
│  │  │  ┌─ A. Hashtag đã chọn (selected) ─────────────────────────────┐ │  │  │
│  │  │  │  "#teamwork"                              [✓ check icon]     │ │  │  │
│  │  │  │  bg: rgba(255,234,158,0.15), h: 44px, px: 12px              │ │  │  │
│  │  │  └──────────────────────────────────────────────────────────────┘ │  │  │
│  │  │                                                                   │  │  │
│  │  │  ┌─ Hashtag item (chưa chọn) ──────────────────────────────────┐ │  │  │
│  │  │  │  "#innovation"                                               │ │  │  │
│  │  │  │  bg: transparent, h: 44px, px: 12px                          │ │  │  │
│  │  │  └──────────────────────────────────────────────────────────────┘ │  │  │
│  │  │                                                                   │  │  │
│  │  │  ┌─ Hashtag item (chưa chọn) ──────────────────────────────────┐ │  │  │
│  │  │  │  "#leadership"                                               │ │  │  │
│  │  │  └──────────────────────────────────────────────────────────────┘ │  │  │
│  │  │  ... (scroll nếu có thêm)                                        │  │  │
│  │  └══════════════════════════════════════════════════════════════════┘  │  │
│  └─────────────────────────────────────────────────────────────────────────┘  │
│  ...                                                                          │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## Component Style Details

### A. Hashtag Item (Đã chọn)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6891:17707` | - |
| width | 100% (335px) | `double.infinity` |
| height | 44px | `height: 44` |
| padding | 0px 12px | `EdgeInsets.symmetric(horizontal: 12)` |
| background | `rgba(255, 234, 158, 0.15)` | `Color(0x26FFEA9E)` |
| display | flex-row, space-between | `Row(mainAxisAlignment: MainAxisAlignment.spaceBetween)` |

#### A.1. Hashtag Text (Đã chọn)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6891:17710` | - |
| font-family | Montserrat | `GoogleFonts.montserrat()` |
| font-size | 14px | `fontSize: 14` |
| font-weight | 700 | `fontWeight: FontWeight.w700` |
| color | `#FFEA9E` | `Color(0xFFFFEA9E)` |

#### A.2. Icon Check (Đã chọn)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6891:17714` | - |
| size | 20x20 | `width: 20, height: 20` |
| color | `#FFEA9E` | `Color(0xFFFFEA9E)` |
| icon | checkmark | `Assets.icons.icCheck.svg()` |

---

### Hashtag Item (Chưa chọn)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| width | 100% (335px) | `double.infinity` |
| height | 44px | `height: 44` |
| padding | 0px 12px | `EdgeInsets.symmetric(horizontal: 12)` |
| background | transparent | `Colors.transparent` |
| font-family | Montserrat | `GoogleFonts.montserrat()` |
| font-size | 14px | `fontSize: 14` |
| font-weight | 500 | `fontWeight: FontWeight.w500` |
| color | `#FFFFFF` | `Colors.white` |
| icon | none | Không có icon check |

**Trạng thái:**
| Trạng thái | Thay đổi |
|-----------|---------|
| Default | bg: transparent, text: white |
| Press/Hover | bg: rgba(255,234,158,0.08) |
| Selected | bg: rgba(255,234,158,0.15), text: #FFEA9E, icon check visible |
| Disabled (max reached) | opacity: 0.4 |

---

### Divider giữa items

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| height | 1px | `height: 1` |
| color | `#2E3940` | `Color(0xFF2E3940)` |
| margin | 0px 12px | `EdgeInsets.symmetric(horizontal: 12)` |

---

## Component Hierarchy with Styles

```
Overlay (bg: rgba(0,0,0,0.5))
└── Dropdown Container (w: 335, max-h: 240, bg: #0A1A24, border: 1px #998C5F, r: 4)
    └── ListView (scroll)
        ├── HashtagItem [SELECTED] (h: 44, bg: #FFEA9E/15%, px: 12)
        │   ├── Text "#teamwork" (14px/700, #FFEA9E)
        │   └── Icon check (20x20, #FFEA9E)
        ├── Divider (1px, #2E3940)
        ├── HashtagItem (h: 44, bg: transparent, px: 12)
        │   └── Text "#innovation" (14px/500, white)
        ├── Divider
        ├── HashtagItem (h: 44, bg: transparent, px: 12)
        │   └── Text "#leadership" (14px/500, white)
        ├── Divider
        └── ... (more items)
```

---

## Icon Specifications

| Tên Icon | Kích thước | Màu sắc | Sử dụng |
|----------|-----------|---------|---------|
| ic_check | 20x20 | `#FFEA9E` | Indicator hashtag đã chọn |

> Icon PHẢI sử dụng format SVG, render qua `flutter_svg`, access qua `Assets.icons.icCheck.svg()`.

---

## Animation & Transitions

| Phần tử | Thuộc tính | Thời lượng | Easing | Trigger |
|---------|-----------|-----------|--------|---------|
| Dropdown | opacity + scaleY (0→1) | 200ms | ease-out | Mở dropdown |
| Dropdown | opacity + scaleY (1→0) | 150ms | ease-in | Đóng dropdown |
| Item | background-color | 100ms | ease-in-out | Press/Select |
| Check icon | scale (0→1) + fade-in | 150ms | ease-out | Chọn hashtag |
| Check icon | scale (1→0) + fade-out | 100ms | ease-in | Bỏ chọn |

---

## Implementation Mapping

| Phần tử Design | Figma Node ID | Flutter Widget | File |
|----------------|---------------|----------------|------|
| Dropdown Container | N/A (overlay) | `HashtagDropdown` | `hashtag_dropdown.dart` |
| Hashtag Item | `6891:17707` | `HashtagDropdownItem` | `hashtag_dropdown_item.dart` |
| Check Icon | `6891:17714` | `SvgPicture` | inline |

---

## Ghi chú

- Dropdown là overlay widget, không phải route/screen mới.
- Implement bằng `OverlayEntry` hoặc `PopupMenuButton` customized.
- Danh sách hashtag PHẢI được pre-load từ API khi form mở.
- Position dropdown ngay dưới nút "+ Hashtag" trong form.
- Khi đóng dropdown, chips trong Tag Group PHẢI đồng bộ ngay lập tức.
