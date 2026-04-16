# Design Style: Language Dropdown (Chọn ngôn ngữ)

**Frame ID**: `uUvW6Qm1ve`
**Frame Name**: `[iOS] Language dropdown`
**Figma Link**: https://www.figma.com/design/9ypp4enmFmdK3YAFJLIu6C?node-id=6891:15508
**Ngày trích xuất**: 2026-04-14

---

## Design Tokens

### Màu sắc

| Token | Hex | Opacity | Sử dụng |
|-------|-----|---------|---------|
| --color-bg-dropdown | #00070C | 100% | Nền dropdown container |
| --color-border-dropdown | #998C5F | 100% | Viền dropdown |
| --color-option-selected-bg | rgba(255, 234, 158, 0.20) | 100% | Nền option đang chọn |
| --color-text-option | #FFFFFF | 100% | Text mã ngôn ngữ |

### Typography

| Token | Font Family | Size | Weight | Line Height | Letter Spacing |
|-------|-------------|------|--------|-------------|----------------|
| --text-language-code | Montserrat | 14px | 500 | 20px | 0.1px |
| --text-trigger-code | Montserrat | 14px | 500 | 20px | 0px |

### Spacing

| Token | Giá trị | Sử dụng |
|-------|---------|---------|
| --spacing-dropdown-padding | 6px | Padding bên trong dropdown |
| --spacing-option-padding | 16px | Padding bên trong option |
| --spacing-flag-text-gap | 4px | Khoảng cách giữa cờ và text |

### Border & Radius

| Token | Giá trị | Sử dụng |
|-------|---------|---------|
| --radius-dropdown | 8px | Bo góc dropdown container |
| --radius-option-selected | 2px | Bo góc option đang chọn (highlight) |
| --radius-option-unselected | 0px | Không bo góc option chưa chọn |
| --border-dropdown | 1px solid #998C5F | Viền dropdown |

---

## Layout Specifications

### Cấu trúc Layout (ASCII)

```
                                    ┌──────────────────┐
                                    │  Trigger Button   │
                                    │  [🇻🇳 VN ▼]       │
                                    └──────────────────┘
                                    ┌──────────────────┐
                                    │  Dropdown (A)     │
                                    │  p:6px, r:8px     │
                                    │  bg:#00070C       │
                                    │  border:#998C5F   │
                                    │  ┌──────────────┐│
                                    │  │ A.1 [🇻🇳 VN] ││  ← selected (bg highlight)
                                    │  │ h:40, r:2    ││
                                    │  ├──────────────┤│
                                    │  │ A.2 [🇬🇧 EN] ││
                                    │  │ h:40         ││
                                    │  └──────────────┘│
                                    └──────────────────┘
```

---

## Chi tiết Style từng Component

### Trigger Button (Language)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | 6891:15521 | - |
| width | 90px | - |
| height | 32px | - |
| padding | 4px 0px 4px 8px | `EdgeInsets.fromLTRB(8, 4, 0, 4)` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| gap | 8px | khoảng cách giữa country và icon down |
| flag-icon | 24x24 (SVG) | `Assets.icons.flags.vn.svg()` |
| text | Montserrat 14px w500, #FFF | - |
| down-arrow | 24x24 (SVG) | `Assets.icons.icDown.svg()` |

### Dropdown Container (A)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | 6891:15595 | - |
| display | inline-flex, column | `Column` |
| padding | 6px | `EdgeInsets.all(6)` |
| background | #00070C | `Color(0xFF00070C)` |
| border | 1px solid #998C5F | `Border.all(color: Color(0xFF998C5F))` |
| border-radius | 8px | `BorderRadius.circular(8)` |
| position | absolute, dưới trigger | Overlay/Popup |

### Option - Tiếng Việt (A.1 - Selected)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | 6891:15596 | - |
| width | 108px | - |
| height | 40px | - |
| background | rgba(255, 234, 158, 0.20) | `Color(0xFFFFEA9E).withOpacity(0.2)` |
| border-radius | 2px | `BorderRadius.circular(2)` |
| padding (inner) | 16px | - |
| flag-icon | 24x24 VN flag (SVG) | `Assets.icons.flags.vn.svg()` |
| text | "VN", Montserrat 14px w500, #FFF | - |
| gap | 4px | khoảng cách giữa cờ và text |

### Option - Tiếng Anh (A.2 - Unselected)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | 6891:15597 | - |
| width | 110px | - |
| height | 40px | - |
| background | transparent | - |
| border-radius | 0px | - |
| padding (inner) | 16px | - |
| flag-icon | 24x24 EN flag (SVG) | `Assets.icons.flags.en.svg()` |
| text | "EN", Montserrat 14px w500, #FFF | - |
| gap | 4px | khoảng cách giữa cờ và text |

---

## Icon Specifications

| Tên Icon | Kích thước | Sử dụng |
|----------|-----------|---------|
| flags/vn | 24x24 (SVG) | Cờ Việt Nam |
| flags/en | 24x24 (SVG) | Cờ Anh |
| ic_down | 24x24 (SVG) | Mũi tên xuống trigger |

---

## Animation & Transitions

| Phần tử | Thuộc tính | Thời lượng | Easing | Trigger |
|---------|-----------|-----------|--------|---------|
| Dropdown | opacity, transform | 150ms | ease-out | Mở/Đóng |

---

## Ghi chú

- Dropdown là overlay nhỏ, không phải BottomSheet hay Dialog.
- Vị trí: Ngay dưới trigger button, căn phải.
- Option đang chọn có nền highlight `rgba(255, 234, 158, 0.20)`.
- Icon cờ quốc gia PHẢI là SVG, đặt trong `assets/icons/flags/`.
- Tất cả icon **PHẢI** nằm trong **Icon Component** thay vì svg files hoặc img tags trực tiếp.
