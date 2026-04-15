# Design Style: [iOS] Sun*Kudos - Gửi lời chúc Kudos

**Frame ID**: `PV7jBVZU1N`
**Frame Name**: `[iOS] Sun*Kudos_Gửi lời chúc Kudos`
**Figma File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-14

---

## Design Tokens

### Màu sắc

| Tên Token | Giá trị Hex/RGBA | Opacity | Sử dụng |
|-----------|-----------------|---------|---------|
| --color-background | `rgba(0, 16, 26, 1)` / `#00101A` | 100% | Nền chính toàn màn hình |
| --color-primary | `#FFEA9E` | 100% | Màu accent chính (vàng) — nút Send, tiêu đề, border active |
| --color-primary-10 | `rgba(255, 234, 158, 0.10)` | 10% | Nền input fields, dropdown |
| --color-border | `#998C5F` | 100% | Border cho input, dropdown, card |
| --color-text-primary | `#FFFFFF` | 100% | Text chính trên nền tối |
| --color-text-accent | `#FFEA9E` | 100% | Text label bắt buộc (*), tiêu đề |
| --color-text-secondary | `#999999` | 100% | Placeholder text, hint text |
| --color-text-dark | `#00101A` | 100% | Text trên nút Send (nền vàng) |
| --color-divider | `#2E3940` | 100% | Đường kẻ phân cách |
| --color-error | `#D4271D` | 100% | Text lỗi validation, border lỗi |
| --color-link | `#FFEA9E` | 100% | Text link "Tiêu chuẩn cộng đồng" |
| --color-toolbar-bg | `rgba(46, 57, 64, 0.5)` | 50% | Nền toolbar formatting |
| --color-toolbar-active | `#FFEA9E` | 100% | Icon toolbar khi active |
| --color-toolbar-inactive | `#FFFFFF` | 60% | Icon toolbar khi inactive |
| --color-chip-bg | `rgba(255, 234, 158, 0.15)` | 15% | Nền hashtag chip |
| --color-chip-border | `#998C5F` | 100% | Border hashtag chip |

### Typography

| Tên Token | Font Family | Size | Weight | Line Height | Letter Spacing |
|-----------|-------------|------|--------|-------------|----------------|
| --text-header | Montserrat | 16px | 500 | 22px | 0px |
| --text-label | Montserrat | 14px | 500 | 20px | 0px |
| --text-label-required | Montserrat | 14px | 700 | 20px | 0px |
| --text-body | Montserrat | 14px | 400 | 20px | 0px |
| --text-placeholder | Montserrat | 14px | 400 | 20px | 0px |
| --text-button-primary | Montserrat | 14px | 700 | 20px | 0px |
| --text-button-secondary | Montserrat | 14px | 500 | 20px | 0px |
| --text-caption | Montserrat | 12px | 400 | 16px | 0px |
| --text-hint | Montserrat | 12px | 400 | 16px | 0px |
| --text-link | Montserrat | 12px | 500 | 16px | 0px |
| --text-chip | Montserrat | 12px | 500 | 16px | 0px |
| --text-toolbar-icon | Montserrat | 14px | 700 | 20px | 0px |

### Spacing

| Tên Token | Giá trị | Sử dụng |
|-----------|---------|---------|
| --spacing-xs | 4px | Gap nhỏ giữa icon và text |
| --spacing-sm | 8px | Padding trong chip, gap trong toolbar |
| --spacing-md | 12px | Padding input fields, gap giữa fields |
| --spacing-lg | 16px | Gap giữa sections, padding horizontal form |
| --spacing-xl | 20px | Margin giữa các section lớn |
| --spacing-2xl | 24px | Padding top/bottom form |

### Border & Radius

| Tên Token | Giá trị | Sử dụng |
|-----------|---------|---------|
| --radius-sm | 4px | Input fields, dropdown |
| --radius-md | 8px | Toolbar container, image thumbnails |
| --radius-lg | 16px | Hashtag chips |
| --radius-full | 100px | Avatar, circular buttons |
| --border-width | 1px | Border input, dropdown, chip |
| --border-width-error | 1px | Border input khi lỗi (cùng width, đổi màu sang #D4271D) |

### Shadows

| Tên Token | Giá trị | Sử dụng |
|-----------|---------|---------|
| --shadow-none | none | Phần lớn components (flat design) |

> **Ghi chú**: Thiết kế sử dụng flat design trên nền tối, không có box-shadow.

### Gradients

| Tên | Giá trị | Sử dụng |
|-----|---------|---------|
| --gradient-header | `linear-gradient(180deg, #00101A 0%, rgba(0,16,26,0.30) 76.44%, rgba(0,16,26,0.00) 100%)` | Header fade-out overlay |

---

## Layout Specifications

### Container

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| width | 375px | iPhone standard |
| height | 941px (scrollable) | Full content height |
| background | `#00101A` | Dark theme |
| overflow | scroll | Vertical scroll |

### Layout chính

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| display | flex | Column layout |
| flex-direction | column | Vertical stacking |
| padding | 0px 20px | Horizontal padding |

### Layout Structure (ASCII)

```
┌─────────────────────────────────────────────── 375px ──────────────────────────────────────────┐
│  Header (position: absolute, z-index: 1)                                                       │
│  ┌─ StatusBar (44px) ──────────────────────────────────────────────────────────────────────┐    │
│  │  [9:41]                                              [Signal] [WiFi] [Battery]          │    │
│  └────────────────────────────────────────────────────────────────────────────────────────── │    │
│  ┌─ Nav Row ──────────────────────────────────────────────────────────────────────────────┐    │
│  │  [Logo 48x44]     ...gap...      [🇻🇳 VN ▾] [🔍] [🔔•]                               │    │
│  └────────────────────────────────────────────────────────────────────────────────────────── │    │
│                                                                                              │
│  ┌─ A. Header Text (padding: 0 20px) ──────────────────────────────────────────────────────┐  │
│  │  "Gửi lời cám ơn và ghi nhận đến đồng đội" (16px/500, white)                            │  │
│  └──────────────────────────────────────────────────────────────────────────────────────────┘  │
│                                                                                              │
│  ┌─ B. Form Fields (padding: 0 20px, gap: 16px) ──────────────────────────────────────────┐  │
│  │                                                                                          │  │
│  │  B.1. "Người nhận *" (14px/500, #FFEA9E)                                                │  │
│  │  ┌─ B.2. Recipient Dropdown (h: 44px, border: 1px #998C5F, r: 4px) ──────────────────┐ │  │
│  │  │  [placeholder: "Tìm kiếm" (14px/400, #999)]          [▾ chevron]                   │ │  │
│  │  └────────────────────────────────────────────────────────────────────────────────────┘ │  │
│  │                                                                                          │  │
│  │  B.3. "Danh hiệu *" (14px/500, #FFEA9E)                                                │  │
│  │  ┌─ B.4. Title Input (h: 44px, border: 1px #998C5F, r: 4px) ─────────────────────────┐ │  │
│  │  │  [placeholder: "Danh tặng một danh hiệu cho..." (14px/400, #999)]                   │ │  │
│  │  └────────────────────────────────────────────────────────────────────────────────────┘ │  │
│  │  B.5. "Tiêu chuẩn cộng đồng" (12px/500, #FFEA9E, underline)                           │  │
│  │                                                                                          │  │
│  │  B.7. Label nội dung (14px/500, #FFEA9E)                                                │  │
│  │  ┌─ C. Formatting Toolbar (h: 40px, bg: #2E3940/50%, r: 8px, gap: 8px) ──────────────┐ │  │
│  │  │  [B] [I] [S] [1.] [🔗] [❝]                                                         │ │  │
│  │  └────────────────────────────────────────────────────────────────────────────────────┘ │  │
│  │  ┌─ D. Message Textarea (min-h: 120px, border: 1px #998C5F, r: 4px) ─────────────────┐ │  │
│  │  │  [placeholder: "Hãy gửi gắm lời cám ơn và ghi nhận đến đồng đội tại đây nhé!"]    │ │  │
│  │  │  (14px/400, #999)                                                                    │ │  │
│  │  └────────────────────────────────────────────────────────────────────────────────────┘ │  │
│  │  D.1. "Bạn có thể '@ + tên' để nhắc tới đồng nghiệp khác" (12px/400, #999)            │  │
│  │                                                                                          │  │
│  │  ┌─ E. Hashtag Section (gap: 8px) ──────────────────────────────────────────────────────┐│  │
│  │  │  E.1. "Hashtag *" (14px/500, #FFEA9E)                                                ││  │
│  │  │  ┌─ E.2. Tag Group (gap: 8px, flex-wrap) ─────────────────────────────────────────┐  ││  │
│  │  │  │  [#tag1 ✕] [#tag2 ✕] [+ Hashtag (Tối đa 5)]                                   │  ││  │
│  │  │  │  chip: h:28px, bg: #FFEA9E/15%, border: 1px #998C5F, r: 16px, px: 12px         │  ││  │
│  │  │  └─────────────────────────────────────────────────────────────────────────────────┘  ││  │
│  │  └──────────────────────────────────────────────────────────────────────────────────────┘│  │
│  │                                                                                          │  │
│  │  ┌─ F. Image Section (gap: 8px) ────────────────────────────────────────────────────────┐│  │
│  │  │  F.1. "Image" (14px/500, white)                                                      ││  │
│  │  │  ┌─ Thumbnail Row (gap: 8px, flex-row) ───────────────────────────────────────────┐  ││  │
│  │  │  │  [📷 56x56, r:8px] [📷] [📷] [📷] [+ Image 56x56, r:8px, border dashed]       │  ││  │
│  │  │  └─────────────────────────────────────────────────────────────────────────────────┘  ││  │
│  │  └──────────────────────────────────────────────────────────────────────────────────────┘│  │
│  │                                                                                          │  │
│  │  ┌─ G. Anonymous Toggle (gap: 8px) ─────────────────────────────────────────────────────┐│  │
│  │  │  [☐ checkbox] "Gửi lời cám ơn và ghi nhận ẩn danh" (14px/400, white)                ││  │
│  │  └──────────────────────────────────────────────────────────────────────────────────────┘│  │
│  │                                                                                          │  │
│  └──────────────────────────────────────────────────────────────────────────────────────────┘  │
│                                                                                              │
│  ┌─ Bottom Actions (padding: 16px 20px, gap: 12px, flex-row) ──────────────────────────────┐  │
│  │  ┌─ H. Cancel (flex: 1, h: 48px, bg: #2E3940, r: 8px) ───┐                             │  │
│  │  │  [✕] "Hủy" (14px/500, white)                            │                             │  │
│  │  └─────────────────────────────────────────────────────────┘                             │  │
│  │  ┌─ I. Send (flex: 2, h: 48px, bg: #FFEA9E, r: 8px) ─────┐                             │  │
│  │  │  "Gửi đi" (14px/700, #00101A) [→ icon]                  │                             │  │
│  │  └─────────────────────────────────────────────────────────┘                             │  │
│  └──────────────────────────────────────────────────────────────────────────────────────────┘  │
│                                                                                              │
│  ┌─ Bottom Safe Area (34px) ───────────────────────────────────────────────────────────────┐  │
│  │  [Home Indicator]                                                                        │  │
│  └──────────────────────────────────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Component Style Details

### A. Header Text

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9904` | - |
| font-family | Montserrat | `GoogleFonts.montserrat()` |
| font-size | 16px | `fontSize: 16` |
| font-weight | 500 | `fontWeight: FontWeight.w500` |
| color | `#FFFFFF` | `color: Colors.white` |
| padding-top | 16px | `EdgeInsets.only(top: 16)` |

---

### B.2. Recipient Dropdown (Search Input)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9909` | - |
| width | 100% (335px) | `double.infinity` |
| height | 44px | `height: 44` |
| padding | 0px 12px | `EdgeInsets.symmetric(horizontal: 12)` |
| background | `rgba(255,234,158,0.10)` | `Color(0x1AFFEA9E)` |
| border | 1px solid `#998C5F` | `Border.all(color: Color(0xFF998C5F))` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| placeholder | "Tìm kiếm" | i18n: `t.kudos.send.searchPlaceholder` |
| placeholder-color | `#999999` | `Color(0xFF999999)` |
| icon | chevron-down (right) | `Assets.icons.icChevronDown.svg()` |

**Trạng thái:**
| Trạng thái | Thay đổi |
|-----------|---------|
| Default | border: 1px solid #998C5F |
| Focus | border: 1px solid #FFEA9E |
| Error | border: 1px solid #D4271D |
| Filled | Hiển thị tên người nhận thay placeholder, text-color: #FFFFFF |

---

### B.4. Danh hiệu Input

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:10001` | - |
| width | 100% (335px) | `double.infinity` |
| height | 44px | `height: 44` |
| padding | 0px 12px | `EdgeInsets.symmetric(horizontal: 12)` |
| background | `rgba(255,234,158,0.10)` | `Color(0x1AFFEA9E)` |
| border | 1px solid `#998C5F` | `Border.all(color: Color(0xFF998C5F))` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| placeholder | "Danh tặng một danh hiệu cho..." | i18n: `t.kudos.send.titlePlaceholder` |
| max-length | 100 | `maxLength: 100` |

**Trạng thái:**
| Trạng thái | Thay đổi |
|-----------|---------|
| Default | border: #998C5F |
| Focus | border: #FFEA9E |
| Error | border: 1px solid #D4271D |
| Filled | Hiển thị text đã nhập, counter "{n}/100" ở góc phải dưới |

---

### C. Formatting Toolbar

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9918` | - |
| width | 100% | `double.infinity` |
| height | 40px | `height: 40` |
| padding | 4px 8px | `EdgeInsets.symmetric(horizontal: 8, vertical: 4)` |
| background | `rgba(46, 57, 64, 0.5)` | `Color(0x802E3940)` |
| border-radius | 8px | `BorderRadius.circular(8)` |
| gap | 8px | `spacing: 8` |
| display | flex-row | `Row` |

### C.1-C.6. Toolbar Buttons

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| width | 32px | `width: 32` |
| height | 32px | `height: 32` |
| icon-size | 20px | `width: 20, height: 20` |
| icon-color (inactive) | `rgba(255,255,255,0.6)` | `Color(0x99FFFFFF)` |
| icon-color (active) | `#FFEA9E` | `Color(0xFFFFEA9E)` |
| border-radius | 4px | `BorderRadius.circular(4)` |

---

### D. Message Textarea

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9934` | - |
| width | 100% (335px) | `double.infinity` |
| min-height | 120px | `minLines: 6` |
| padding | 12px | `EdgeInsets.all(12)` |
| background | `rgba(255,234,158,0.10)` | `Color(0x1AFFEA9E)` |
| border | 1px solid `#998C5F` | `Border.all(color: Color(0xFF998C5F))` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| font-size | 14px | `fontSize: 14` |
| color | `#FFFFFF` | `Colors.white` |
| placeholder | "Hãy gửi gắm lời cám ơn và ghi nhận đến đồng đội tại đây nhé!" | i18n: `t.kudos.send.messagePlaceholder` |
| max-length | 1000 | `maxLength: 1000` |

**Trạng thái:**
| Trạng thái | Thay đổi |
|-----------|---------|
| Default | border: 1px solid #998C5F |
| Focus | border: 1px solid #FFEA9E |
| Error | border: 1px solid #D4271D |
| Filled | Hiển thị nội dung rich text, counter "{n}/1000" ở góc phải dưới (12px/400, #999) |

---

### E.2. Hashtag Chip

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9940` | - |
| height | 28px | `height: 28` |
| padding | 4px 12px | `EdgeInsets.symmetric(horizontal: 12, vertical: 4)` |
| background | `rgba(255,234,158,0.15)` | `Color(0x26FFEA9E)` |
| border | 1px solid `#998C5F` | `Border.all(color: Color(0xFF998C5F))` |
| border-radius | 16px | `BorderRadius.circular(16)` |
| font-size | 12px | `fontSize: 12` |
| font-weight | 500 | `fontWeight: FontWeight.w500` |
| color | `#FFEA9E` | `Color(0xFFFFEA9E)` |
| icon-close | 12x12, color: #999 | `Assets.icons.icClose.svg(width: 12)` |

### E.2. Add Hashtag Button

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| height | 28px | `height: 28` |
| padding | 4px 12px | `EdgeInsets.symmetric(horizontal: 12, vertical: 4)` |
| background | transparent | `Colors.transparent` |
| border | 1px dashed `#998C5F` | `Border.all(color: Color(0xFF998C5F))` (dashed) |
| border-radius | 16px | `BorderRadius.circular(16)` |
| text | "+ Hashtag (Tối đa 5)" | i18n: `t.kudos.send.addHashtag` |
| color | `#999999` | `Color(0xFF999999)` |

---

### F.2. Image Thumbnail

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9982` | - |
| width | 56px | `width: 56` |
| height | 56px | `height: 56` |
| border-radius | 8px | `BorderRadius.circular(8)` |
| fit | cover | `BoxFit.cover` |
| close-button | 16x16, position: top-right | `Positioned(top: -4, right: -4)` |

### F.5. Add Image Button

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| width | 56px | `width: 56` |
| height | 56px | `height: 56` |
| background | transparent | `Colors.transparent` |
| border | 1px dashed `#998C5F` | Dashed border |
| border-radius | 8px | `BorderRadius.circular(8)` |
| icon | + (center), 20x20 | `Assets.icons.icPlus.svg(width: 20)` |
| icon-color | `#999999` | `Color(0xFF999999)` |

---

### G. Anonymous Toggle (Checkbox)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9993` | - |
| height | 20px | Checkbox default |
| checkbox-size | 20x20 | `width: 20, height: 20` |
| checkbox-color (unchecked) | transparent, border: `#998C5F` | Default |
| checkbox-color (checked) | `#FFEA9E` | `activeColor: Color(0xFFFFEA9E)` |
| checkmark-color | `#00101A` | `checkColor: Color(0xFF00101A)` |
| label | "Gửi lời cám ơn và ghi nhận ẩn danh" | i18n: `t.kudos.send.anonymousLabel` |
| label-font | 14px/400, white | `fontSize: 14, fontWeight: FontWeight.w400` |
| gap | 8px | Spacing giữa checkbox và label |

---

### H. Cancel Button

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6891:16834` | - |
| flex | 1 | `Expanded(flex: 1)` |
| height | 48px | `height: 48` |
| background | `#2E3940` | `Color(0xFF2E3940)` |
| border | none | - |
| border-radius | 8px | `BorderRadius.circular(8)` |
| text | "Hủy" | i18n: `t.kudos.send.cancel` |
| text-color | `#FFFFFF` | `Colors.white` |
| font | 14px/500 | `fontSize: 14, fontWeight: FontWeight.w500` |
| icon | X (close), 16x16, white | `Assets.icons.icClose.svg()` |

**Trạng thái:**
| Trạng thái | Thay đổi |
|-----------|---------|
| Default | bg: #2E3940 |
| Pressed | bg: rgba(46, 57, 64, 0.7), scale: 0.98 |
| Disabled (khi đang submit) | bg: rgba(46, 57, 64, 0.5), text-color: rgba(255,255,255,0.5) |

---

### I. Send Button

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6891:16833` | - |
| flex | 2 | `Expanded(flex: 2)` |
| height | 48px | `height: 48` |
| background | `#FFEA9E` | `Color(0xFFFFEA9E)` |
| border | none | - |
| border-radius | 8px | `BorderRadius.circular(8)` |
| text | "Gửi đi" | i18n: `t.kudos.send.submit` |
| text-color | `#00101A` | `Color(0xFF00101A)` |
| font | 14px/700 | `fontSize: 14, fontWeight: FontWeight.w700` |
| icon | send/arrow, 16x16, #00101A | `Assets.icons.icSend.svg()` |

**Trạng thái:**
| Trạng thái | Thay đổi |
|-----------|---------|
| Default | bg: #FFEA9E |
| Pressed | bg: #E6D28E (darker), scale: 0.98 |
| Disabled | bg: rgba(255,234,158,0.4), text-color: rgba(0,16,26,0.5) |
| Loading (isSubmitting) | bg: #FFEA9E, hiển thị `CircularProgressIndicator(color: #00101A, strokeWidth: 2)` thay text, onPressed: null |

---

## Component Hierarchy with Styles

```
Screen (bg: #00101A, 375x941)
├── Header Overlay (gradient, z-index: 1)
│   ├── StatusBar (h: 44px)
│   └── NavRow (h: 60px)
│       ├── Logo (48x44)
│       └── Actions (language, search, notification)
│
├── ScrollView (flex: 1, padding: 0 20px)
│   ├── A. Header Text (16px/500, white, pt: 16px)
│   │
│   ├── B. Form Fields (gap: 16px)
│   │   ├── B.1. Label "Người nhận *" (14px/500, #FFEA9E)
│   │   ├── B.2. Recipient Dropdown (h: 44, border: 1px #998C5F, r: 4, bg: #FFEA9E/10%)
│   │   ├── B.3. Label "Danh hiệu *" (14px/500, #FFEA9E)
│   │   ├── B.4. Title Input (h: 44, border: 1px #998C5F, r: 4, bg: #FFEA9E/10%)
│   │   ├── B.5. Link "Tiêu chuẩn cộng đồng" (12px/500, #FFEA9E, underline)
│   │   ├── B.7. Label nội dung (14px/500, #FFEA9E)
│   │   ├── C. Toolbar (h: 40, bg: #2E3940/50%, r: 8, gap: 8)
│   │   │   ├── C.1. Bold (32x32, icon: 20px)
│   │   │   ├── C.2. Italic
│   │   │   ├── C.3. Strikethrough
│   │   │   ├── C.4. Numbered List
│   │   │   ├── C.5. Link
│   │   │   └── C.6. Quote
│   │   ├── D. Textarea (min-h: 120, border: 1px #998C5F, r: 4, bg: #FFEA9E/10%)
│   │   ├── D.1. Hint "@mention" (12px/400, #999)
│   │   │
│   │   ├── E. Hashtag Section (gap: 8px)
│   │   │   ├── E.1. Label "Hashtag *" (14px/500, #FFEA9E)
│   │   │   └── E.2. Tag Group (gap: 8, flex-wrap)
│   │   │       ├── Chip (h: 28, bg: #FFEA9E/15%, border: 1px #998C5F, r: 16)
│   │   │       └── Add Button (h: 28, border: dashed #998C5F, r: 16)
│   │   │
│   │   ├── F. Image Section (gap: 8px)
│   │   │   ├── F.1. Label "Image" (14px/500, white)
│   │   │   └── Thumbnail Row (gap: 8, flex-row)
│   │   │       ├── F.2-F.4. Thumbnails (56x56, r: 8)
│   │   │       └── F.5. Add Button (56x56, border: dashed, r: 8)
│   │   │
│   │   └── G. Anonymous Toggle (gap: 8, flex-row)
│   │       ├── Checkbox (20x20, border: #998C5F / active: #FFEA9E)
│   │       └── Label (14px/400, white)
│   │
│   └── Spacer
│
├── Bottom Actions (padding: 16px 20px, gap: 12, flex-row)
│   ├── H. Cancel (flex: 1, h: 48, bg: #2E3940, r: 8)
│   └── I. Send (flex: 2, h: 48, bg: #FFEA9E, r: 8)
│
└── Safe Area (34px)
```

---

## Responsive Specifications

### Breakpoints

| Tên | Min Width | Max Width |
|-----|-----------|-----------|
| Mobile (iOS) | 375px | 428px |

> Ứng dụng chỉ dành cho mobile — không có tablet/desktop breakpoints.

---

## Icon Specifications

| Tên Icon | Kích thước | Màu sắc | Sử dụng |
|----------|-----------|---------|---------|
| ic_chevron_down | 20x20 | `#999999` | Dropdown indicator |
| ic_bold | 20x20 | `#FFF/60%` → `#FFEA9E` (active) | Toolbar bold |
| ic_italic | 20x20 | `#FFF/60%` → `#FFEA9E` (active) | Toolbar italic |
| ic_strikethrough | 20x20 | `#FFF/60%` → `#FFEA9E` (active) | Toolbar strikethrough |
| ic_numbered_list | 20x20 | `#FFF/60%` → `#FFEA9E` (active) | Toolbar numbered list |
| ic_link | 20x20 | `#FFF/60%` → `#FFEA9E` (active) | Toolbar link |
| ic_quote | 20x20 | `#FFF/60%` → `#FFEA9E` (active) | Toolbar quote |
| ic_close | 12x12 | `#999999` | Xóa chip, đóng |
| ic_close_lg | 16x16 | `#FFFFFF` | Nút Hủy |
| ic_send | 16x16 | `#00101A` | Nút Gửi đi |
| ic_plus | 20x20 | `#999999` | Thêm image |
| ic_close_circle | 16x16 | `#D4271D` | Xóa thumbnail ảnh |

> Tất cả icons PHẢI sử dụng format SVG, render qua `flutter_svg`, và access qua `Assets.icons.icXxx.svg()`.

---

## Animation & Transitions

| Phần tử | Thuộc tính | Thời lượng | Easing | Trigger |
|---------|-----------|-----------|--------|---------|
| Screen | slide-up + fade-in | 300ms | ease-out | Mở form |
| Screen | slide-down + fade-out | 200ms | ease-in | Đóng form |
| Toolbar button | background-color | 150ms | ease-in-out | Toggle active |
| Input border | border-color | 150ms | ease-in-out | Focus/Error |
| Chip | scale + fade-in | 200ms | ease-out | Thêm hashtag |
| Chip | scale + fade-out | 150ms | ease-in | Xóa hashtag |
| Submit button | opacity | 150ms | ease-in-out | Enable/Disable |

---

## Implementation Mapping

| Phần tử Design | Figma Node ID | Flutter Widget | File |
|----------------|---------------|----------------|------|
| Screen | `6885:9883` | `SendKudosScreen` | `send_kudos_screen.dart` |
| Header Text | `6885:9904` | `Text` | inline |
| Recipient Dropdown | `6885:9909` | `RecipientDropdown` | `recipient_dropdown.dart` |
| Title Input | `6885:10001` | `TitleInputField` | `title_input_field.dart` |
| Formatting Toolbar | `6885:9918` | `FormattingToolbar` | `formatting_toolbar.dart` |
| Message Textarea | `6885:9934` | `MessageTextArea` | `message_text_area.dart` |
| Hashtag Section | `6885:9936` | `HashtagSection` | `hashtag_section.dart` |
| Image Section | `6885:9976` | `ImageSection` | `image_section.dart` |
| Anonymous Toggle | `6885:9993` | `AnonymousToggle` | `anonymous_toggle.dart` |
| Cancel Button | `6891:16834` | `ElevatedButton` | inline |
| Send Button | `6891:16833` | `ElevatedButton` | inline |

---

## Ghi chú

- Tất cả màu sắc tuân theo dark theme chung của ứng dụng SAA Mobile.
- Font chính là Montserrat — không sử dụng font khác ngoài StatusBar (SF Pro Text).
- Icons PHẢI là SVG, sử dụng `Assets.icons.icXxx.svg()` qua flutter_gen.
- Input fields có chung style: bg rgba(255,234,158,0.10), border 1px #998C5F, radius 4px.
- Nút Send (vàng) và Cancel (xám tối) tạo contrast rõ ràng cho primary/secondary action.
