# Design Style: [iOS] Sun*Kudos - Dropdown Tên Người Nhận

**Frame ID**: `5MU728Tjck`
**Frame Name**: `[iOS] Sun*Kudos_Gửi lời chúc Kudos_dropdown tên người nhận`
**Figma File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-14

---

## Design Tokens

> Sử dụng chung design tokens với màn hình parent `PV7jBVZU1N`.
> Xem chi tiết tại [design-style.md của PV7jBVZU1N](../PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/design-style.md).

### Màu sắc bổ sung (Dropdown Người Nhận)

| Tên Token | Giá trị Hex/RGBA | Opacity | Sử dụng |
|-----------|-----------------|---------|---------|
| --color-dropdown-bg | `#0A1A24` | 100% | Nền dropdown list |
| --color-dropdown-item-hover | `rgba(255, 234, 158, 0.08)` | 8% | Nền item khi press |
| --color-avatar-fallback-bg | `rgba(255, 234, 158, 0.20)` | 20% | Nền avatar fallback |
| --color-avatar-fallback-text | `#FFEA9E` | 100% | Text initials avatar fallback |
| --color-department-text | `#999999` | 100% | Text đơn vị/phòng ban |
| --color-overlay | `rgba(0, 0, 0, 0.5)` | 50% | Overlay phía sau dropdown |

### Typography

| Tên Token | Font Family | Size | Weight | Line Height | Letter Spacing |
|-----------|-------------|------|--------|-------------|----------------|
| --text-user-name | Montserrat | 14px | 600 | 20px | 0px |
| --text-department | Montserrat | 12px | 400 | 16px | 0px |
| --text-search | Montserrat | 14px | 400 | 20px | 0px |

---

## Layout Specifications

### Dropdown Container

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| width | 335px | Bằng width input field |
| max-height | 280px | Tối đa ~5 items visible, scroll nếu dài hơn |
| background | `#0A1A24` | Nền tối |
| border | 1px solid `#998C5F` | Border vàng nhạt |
| border-radius | 4px | Cùng radius với input |
| overflow | scroll | Vertical scroll |
| position | absolute / overlay | Xuất hiện ngay dưới input "Người nhận" |

### Layout Structure (ASCII)

```
┌─── Form (parent, behind overlay) ────────────────────────────────────────────┐
│  ...                                                                          │
│  ┌─ B.1. "Người nhận *" ───────────────────────────────────────────────────┐ │
│  │  ┌─ B.2. Search Input (h: 44px, border: 1px #FFEA9E ← focused) ──────┐│ │
│  │  │  [🔍] "Nguyễn..." (typing)                          [✕ clear]      ││ │
│  │  └────────────────────────────────────────────────────────────────────┘│ │
│  │                                                                        │ │
│  │  ┌═══ B. Dropdown List (335px, max-h: 280px) ══════════════════════┐  │ │
│  │  │                                                                  │  │ │
│  │  │  ┌─ B.1. Result Item 1 (h: 56px, px: 12px) ───────────────────┐│  │ │
│  │  │  │  ┌─────┐                                                     ││  │ │
│  │  │  │  │ 🧑  │  B.1.2. "Nguyễn Văn A"  (14px/600, white)        ││  │ │
│  │  │  │  │ 36px │         "Phòng Engineering" (12px/400, #999)      ││  │ │
│  │  │  │  └─────┘                                                     ││  │ │
│  │  │  └──────────────────────────────────────────────────────────────┘│  │ │
│  │  │  ── divider (#2E3940) ──────────────────────────────────────────│  │ │
│  │  │  ┌─ Result Item 2 (h: 56px, px: 12px) ────────────────────────┐│  │ │
│  │  │  │  ┌─────┐                                                     ││  │ │
│  │  │  │  │ 🧑  │  "Nguyễn Thị B"  (14px/600, white)               ││  │ │
│  │  │  │  │ 36px │  "Phòng Design" (12px/400, #999)                 ││  │ │
│  │  │  │  └─────┘                                                     ││  │ │
│  │  │  └──────────────────────────────────────────────────────────────┘│  │ │
│  │  │  ── divider ────────────────────────────────────────────────────│  │ │
│  │  │  ┌─ B.3. Result Item 3 ────────────────────────────────────────┐│  │ │
│  │  │  │  ...                                                         ││  │ │
│  │  │  └──────────────────────────────────────────────────────────────┘│  │ │
│  │  │  ... (scroll nếu có thêm)                                       │  │ │
│  │  └═════════════════════════════════════════════════════════════════┘  │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│  ...                                                                          │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## Component Style Details

### B.2. Search Input (Focus State — khi dropdown mở)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| width | 100% (335px) | `double.infinity` |
| height | 44px | `height: 44` |
| padding | 0px 12px | `EdgeInsets.symmetric(horizontal: 12)` |
| background | `rgba(255,234,158,0.10)` | `Color(0x1AFFEA9E)` |
| border | 1px solid `#FFEA9E` | Focus state |
| border-radius | 4px | `BorderRadius.circular(4)` |
| icon-left | ic_search, 20x20, #999 | `Assets.icons.icSearch.svg()` |
| icon-right (khi có text) | ic_close, 16x16, #999 | Clear button: `Assets.icons.icClose.svg()` |
| placeholder | "Tìm kiếm" | i18n: `t.kudos.send.searchPlaceholder` |
| autofocus | true | `autofocus: true` |

---

### B. Dropdown List Container

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6891:17450` | - |
| width | 335px | `width: 335` |
| max-height | 280px | `constraints: BoxConstraints(maxHeight: 280)` |
| background | `#0A1A24` | `Color(0xFF0A1A24)` |
| border | 1px solid `#998C5F` | `Border.all(color: Color(0xFF998C5F))` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| padding | 4px 0px | `EdgeInsets.symmetric(vertical: 4)` |

---

### B.1. Result Item

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6891:17451` | - |
| width | 100% | `double.infinity` |
| height | 56px | `height: 56` |
| padding | 0px 12px | `EdgeInsets.symmetric(horizontal: 12)` |
| background | transparent | `Colors.transparent` |
| display | flex-row, center-vertical | `Row(crossAxisAlignment: CrossAxisAlignment.center)` |
| gap | 12px | `SizedBox(width: 12)` |

**Trạng thái:**
| Trạng thái | Thay đổi |
|-----------|---------|
| Default | bg: transparent |
| Press/Hover | bg: rgba(255,234,158,0.08) |

---

### B.1.1. Avatar

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `I6891:17451;490:5555` | - |
| width | 36px | `width: 36` |
| height | 36px | `height: 36` |
| border-radius | 100% (tròn) | `BorderRadius.circular(18)` |
| fit | cover | `BoxFit.cover` |
| fallback-bg | `rgba(255,234,158,0.20)` | `Color(0x33FFEA9E)` |
| fallback-text | initials, 14px/600, #FFEA9E | Chữ cái đầu tên |

---

### B.1.2. Tên và Đơn vị

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `I6891:17451;490:5557` | - |
| display | flex-column | `Column(crossAxisAlignment: CrossAxisAlignment.start)` |
| gap | 2px | `SizedBox(height: 2)` |

#### Tên người dùng

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| font-family | Montserrat | `GoogleFonts.montserrat()` |
| font-size | 14px | `fontSize: 14` |
| font-weight | 600 | `fontWeight: FontWeight.w600` |
| color | `#FFFFFF` | `Colors.white` |
| overflow | ellipsis | `TextOverflow.ellipsis` |
| max-lines | 1 | `maxLines: 1` |

#### Đơn vị/Phòng ban

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| font-family | Montserrat | `GoogleFonts.montserrat()` |
| font-size | 12px | `fontSize: 12` |
| font-weight | 400 | `fontWeight: FontWeight.w400` |
| color | `#999999` | `Color(0xFF999999)` |
| overflow | ellipsis | `TextOverflow.ellipsis` |
| max-lines | 1 | `maxLines: 1` |

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
└── Dropdown Container (w: 335, max-h: 280, bg: #0A1A24, border: 1px #998C5F, r: 4)
    └── ListView (scroll, py: 4)
        ├── ResultItem (h: 56, px: 12, bg: transparent)
        │   ├── Avatar (36x36, circle, cover / fallback: initials)
        │   └── Column (gap: 2)
        │       ├── Name (14px/600, white, ellipsis)
        │       └── Department (12px/400, #999, ellipsis)
        ├── Divider (1px, #2E3940, mx: 12)
        ├── ResultItem (h: 56)
        │   ├── Avatar
        │   └── Column
        │       ├── Name
        │       └── Department
        ├── Divider
        └── ... (more items, scroll)
```

---

## Icon Specifications

| Tên Icon | Kích thước | Màu sắc | Sử dụng |
|----------|-----------|---------|---------|
| ic_search | 20x20 | `#999999` | Icon search trong input |
| ic_close | 16x16 | `#999999` | Clear search text |

> Icons PHẢI sử dụng format SVG, access qua `Assets.icons.icXxx.svg()`.

---

## Animation & Transitions

| Phần tử | Thuộc tính | Thời lượng | Easing | Trigger |
|---------|-----------|-----------|--------|---------|
| Dropdown | opacity + scaleY (0→1) | 200ms | ease-out | Mở dropdown |
| Dropdown | opacity + scaleY (1→0) | 150ms | ease-in | Đóng dropdown |
| Result items | fade-in (staggered) | 100ms each | ease-out | Kết quả search load |
| Item | background-color | 100ms | ease-in-out | Press |

---

## Implementation Mapping

| Phần tử Design | Figma Node ID | Flutter Widget | File |
|----------------|---------------|----------------|------|
| Dropdown Container | `6891:17450` | `RecipientDropdown` | `recipient_dropdown.dart` |
| Result Item | `6891:17451` | `RecipientDropdownItem` | `recipient_dropdown_item.dart` |
| Avatar | `I6891:17451;490:5555` | `CircleAvatar` | inline |
| Name + Dept | `I6891:17451;490:5557` | `Column > Text` | inline |

---

## Ghi chú

- Dropdown là overlay widget, không phải route/screen mới.
- Implement bằng `OverlayEntry` hoặc custom dropdown widget.
- Search API gọi với debounce 300ms — sử dụng `Timer` hoặc Riverpod `debounce`.
- Avatar sử dụng `CachedNetworkImage` + fallback `CircleAvatar` với initials.
- Chỉ chọn được 1 người nhận — bấm item → đóng dropdown → cập nhật form.
- Khi mở dropdown lần 2 (đã có người chọn), input hiển thị tên đã chọn, cho phép xóa và tìm lại.
