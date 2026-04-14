# Design Style: Màn hình Chi tiết Giải thưởng (Award Detail)

**Frame IDs**: `c-QM3_zjkG`, `FQoJZLkG_d`, `QQvsfK3yaK`, `7y195PPTxQ`, `O98TwiHaJe`, `b2BuS8HYIt`
**Frame Names**: `[iOS] Award_Top talent` ... `[iOS] Award_MVP`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-14

---

## Design Tokens

### Màu sắc

| Token Name | Hex Value | Opacity | Sử dụng |
|------------|-----------|---------|---------|
| --color-bg-primary | #00101A | 100% | Nền chính toàn màn hình |
| --color-text-gold | #FFEA9E | 100% | Tiêu đề, label chính, tab active |
| --color-text-white | #FFFFFF | 100% | Text nội dung, mô tả |
| --color-text-dark | #00101A | 100% | Text trên nút primary (gold) |
| --color-divider | #2E3940 | 100% | Đường phân cách (1px) |
| --color-border-gold | #998C5F | 100% | Viền dropdown |
| --color-dropdown-bg | rgba(255, 234, 158, 0.10) | 10% | Nền dropdown |
| --color-btn-primary | #FFEA9E | 100% | Nền nút "Chi tiết" |
| --color-badge-red | #D4271D | 100% | Badge thông báo |
| --color-navbar-bg | rgba(255, 234, 158, 0.15) | 15% | Nền bottom nav bar |
| --color-award-border | #FFEA9E | 100% (0.455px) | Viền huy hiệu giải thưởng |
| --color-award-glow | #FAE287 | - | Box shadow huy hiệu |
| --color-kudos-bg | #0F0F0F | 100% | Nền banner Kudos |
| --color-kudos-text | #DBD1C1 | 100% | Text logo KUDOS |

### Typography

| Token Name | Font Family | Size | Weight | Line Height | Letter Spacing |
|------------|-------------|------|--------|-------------|----------------|
| --text-section-subtitle | Montserrat | 12px | 400 | 16px | 0% |
| --text-section-title | Montserrat | 22px | 500 | 28px | 0% |
| --text-kv-subtitle | Montserrat | 14px | 500 | 20px | 0px |
| --text-dropdown | Montserrat | 14px | 400 | 20px | 0.25px |
| --text-award-title | Montserrat | 14px | 700 | 20px | 0px |
| --text-award-body | Montserrat | 14px | 300 | 20px | 0.25px |
| --text-stat-value | Montserrat | 18px | 700 | 24px | 0.5px |
| --text-stat-unit | Montserrat | 14px | 300 | 20px | 0.25px |
| --text-stat-label | Montserrat | 14px | 700 | 20px | 0px |
| --text-btn-label | Montserrat | 14px | 500 | 20px | 0px |
| --text-nav-label | Montserrat | 12px | 400 | 16px | 0% |
| --text-kudos-logo | SVN-Gotham | ~28px | 400 | ~7px | -13% |
| --text-lang-code | Montserrat | 14px | 500 | 20px | 0px |

### Spacing

| Token Name | Giá trị | Sử dụng |
|------------|---------|---------|
| --spacing-screen-h | 20px | Padding ngang nội dung (từ cạnh trái) |
| --spacing-content-width | 335px | Chiều rộng vùng nội dung |
| --spacing-section-gap | 40px | Khoảng cách giữa các section chính |
| --spacing-inner-gap-lg | 24px | Gap trong section |
| --spacing-inner-gap-md | 16px | Gap giữa components |
| --spacing-inner-gap-sm | 12px | Gap giữa title và content |
| --spacing-inner-gap-xs | 8px | Gap giữa icon và text |
| --spacing-inner-gap-xxs | 4px | Gap giữa sub-items |

### Border & Radius

| Token Name | Giá trị | Sử dụng |
|------------|---------|---------|
| --radius-dropdown | 4px | Dropdown filter |
| --radius-btn | 4px | Nút "Chi tiết" |
| --radius-award-badge | 11.429px | Huy hiệu giải thưởng |
| --radius-kudos-banner | 4.653px | Banner Kudos |
| --radius-navbar | 20px 20px 0 0 | Bottom nav bar (top corners) |
| --border-divider | 1px solid #2E3940 | Đường phân cách |
| --border-dropdown | 1px solid #998C5F | Viền dropdown |
| --border-award-badge | 0.455px solid #FFEA9E | Viền huy hiệu |

### Shadows

| Token Name | Giá trị | Sử dụng |
|------------|---------|---------|
| --shadow-award-badge | 0 1.905px 1.905px rgba(0,0,0,0.25), 0 0 2.857px #FAE287 | Huy hiệu giải thưởng (glow effect) |
| --shadow-none | none | Hầu hết các component khác |

---

## Layout Specifications

### Container

| Property | Giá trị | Ghi chú |
|----------|---------|---------|
| width | 375px | Chiều rộng màn hình iOS |
| background | #00101A | Nền tối |
| content-padding-x | 20px | Padding ngang |
| content-width | 335px | = 375 - 20*2 |

### Background

| Layer | Giá trị |
|-------|---------|
| Base | #00101A solid |
| Key Visual | URL image, positioned right, covers top ~812px |
| Shadow Left | linear-gradient(90deg, #00101A 0.07%, #10181F 18.61%, transparent 77.2%) |
| Shadow Bottom | linear-gradient(90deg, #00101A 0%, #00101A 25.41%, transparent 100%), rotated -90deg |

### Layout Structure (ASCII)

```
┌────────────────────────────────────────┐ 375px
│  ┌──── Header (fixed, z-index high) ──┐│ h: 104px
│  │ [StatusBar 44px]                   ││ gradient overlay, opacity 0.9
│  │ [Logo]              [VN▼][🔍][🔔] ││ h: 60px (below status bar)
│  └────────────────────────────────────┘│
│                                        │
│  ┌──── KV Banner ─────────────────────┐│ padding-top: 144px
│  │ "Hệ thống ghi nhận và cảm ơn"     ││ 14px/500, #FFEA9E
│  │ [🔥 Logo] KUDOS                    ││ h: 67px
│  └────────────────────────────────────┘│
│            gap: 40px                   │
│  ┌──── Section Header ───────────────┐ │
│  │ "Sun* Annual Awards 2025"         │ │ 12px/400, #FFF
│  │ ─────────────── (divider 1px)     │ │ #2E3940
│  │ "Hệ thống giải thưởng            │ │ 22px/500, #FFEA9E
│  │  SAA 2025"                        │ │
│  │ ┌──────────────────┐             │ │ gap: 16px
│  │ │ Top Talent    ▼  │             │ │ Dropdown: 160px w, 40px h
│  │ └──────────────────┘             │ │ border: 1px #998C5F, radius: 4px
│  └───────────────────────────────────┘ │
│            gap: 40px                   │
│  ┌──── Award Detail ─────────────────┐ │
│  │       ┌──────────┐               │ │
│  │       │  🏆 160  │               │ │ 160x160, centered, radius: 11.4px
│  │       │  x 160   │               │ │ box-shadow: glow gold
│  │       └──────────┘               │ │
│  │          gap: 16px                │ │
│  │ [🏅] Top Talent                   │ │ 14px/700, #FFEA9E, icon 24x24
│  │                                   │ │ gap: 12px
│  │ Giải thưởng Top Talent vinh danh  │ │ 14px/300, #FFF
│  │ những cá nhân xuất sắc...         │ │ multiline
│  │ ─────────── (divider)             │ │
│  │ [💎] Số lượng giải thưởng        │ │ 14px/700, #FFEA9E
│  │ 10  Cá nhân                       │ │ 18px/700 #FFF + 14px/300 #FFF
│  │ ─────────── (divider)             │ │
│  │ [🚩] Giá trị giải thưởng        │ │ 14px/700, #FFEA9E
│  │ 7.000.000 VNĐ  cho mỗi giải      │ │ 18px/700 #FFF + 14px/300 #FFF
│  └───────────────────────────────────┘ │
│            gap: 40px                   │
│  ┌──── Sun* Kudos Block ─────────────┐ │
│  │ "Phong trào ghi nhận"            │ │ 12px/400, #FFF
│  │ ─────────── (divider)             │ │
│  │ "Sun* Kudos"                      │ │ 22px/500, #FFEA9E
│  │ ┌────────────────────────────┐    │ │
│  │ │  Kudos Banner (145px h)    │    │ │ bg: #0F0F0F, radius: 4.65px
│  │ │      [🔥 KUDOS logo]      │    │ │ SVN-Gotham, #DBD1C1
│  │ └────────────────────────────┘    │ │
│  │ ĐIỂM MỚI CỦA SAA 2025           │ │ 14px/300, #FFF
│  │ Hoạt động ghi nhận...            │ │ multiline, 180px height
│  │ ┌──────────────┐                 │ │
│  │ │ Chi tiết  → │                 │ │ 160x40, bg: #FFEA9E, radius: 4px
│  │ └──────────────┘                 │ │ text: 14px/500, #00101A
│  └───────────────────────────────────┘ │
│                                        │
│  ┌──── Bottom Nav Bar (fixed) ───────┐ │ h: 72px
│  │  SAA 2025  Awards*  Kudos  Profile│ │ bg: rgba(255,234,158,0.15)
│  │  (white)  (gold)  (white)  (white)│ │ radius: 20px 20px 0 0
│  └───────────────────────────────────┘ │ backdrop-filter: blur(20px)
└────────────────────────────────────────┘
```

---

## Component Style Details

### Header (mms_1_header)

| Property | Giá trị | Flutter |
|----------|---------|--------|
| **Node ID** | 6885:10264 | - |
| width | 375px (full) | `double.infinity` |
| height | 104px | `104` |
| opacity | 0.9 | `Opacity(opacity: 0.9)` |
| background | linear-gradient(180deg, #00101A → transparent) | `LinearGradient` |
| position | fixed top | `Positioned(top: 0)` |

### Dropdown Filter

| Property | Giá trị | Flutter |
|----------|---------|--------|
| **Node ID** | 6885:10287 (Top Talent variant) | - |
| width | auto (fit content) | `IntrinsicWidth` |
| height | 40px | `40` |
| padding | 8px | `EdgeInsets.all(8)` |
| background | rgba(255, 234, 158, 0.10) | `Color(0x1AFFEA9E)` |
| border | 1px solid #998C5F | `Border.all(color: Color(0xFF998C5F))` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| text | 14px/400 Montserrat, #FFF | `TextStyle(...)` |
| icon | 24x24 dropdown arrow | `Icon(size: 24)` |

### Dropdown Filter — Trạng thái mở (Open State)

Dùng **PopupMenu** hiển thị ngay bên dưới widget dropdown.

| Property | Giá trị | Flutter |
|----------|---------|--------|
| position | ngay dưới dropdown button | `PopupMenuButton` với `offset` |
| item height | ~48px | `PopupMenuItem` |
| item text | 14px/400 Montserrat, #FFF | `TextStyle(...)` |
| selected item text | 14px/500 Montserrat, #FFEA9E | Highlight giải đang chọn |
| background | #00101A | `Color(0xFF00101A)` |
| border | 1px solid #998C5F | Theo style dropdown |
| border-radius | 4px | `BorderRadius.circular(4)` |
| divider | 1px #2E3940 giữa các items | `Divider(color: AppColors.divider)` |

### Award Badge Image (mm_media_Picture-Award)

| Property | Giá trị | Flutter |
|----------|---------|--------|
| **Node ID** | 6885:10293 (Top Talent variant) | - |
| width | 160px | `160` |
| height | 160px | `160` |
| border | 0.455px solid #FFEA9E | `Border.all(color: Color(0xFFFFEA9E), width: 0.455)` |
| border-radius | 11.429px | `BorderRadius.circular(11.429)` |
| box-shadow | 0 1.905px 1.905px rgba(0,0,0,0.25), 0 0 2.857px #FAE287 | `BoxShadow(...)` |
| mix-blend-mode | screen | `BlendMode.screen` |
| alignment | center horizontal | `Center()` |
| background | image from URL | `Image.network(...)` |

### Award Title Row

| Property | Giá trị | Flutter |
|----------|---------|--------|
| layout | Row: [icon 24x24] + gap 8px + [text] | `Row(children: [...])` |
| icon size | 24x24 | `SvgPicture.asset(width: 24, height: 24)` |
| text | 14px/700 Montserrat, #FFEA9E | `TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFFFEA9E))` |

### Award Description

| Property | Giá trị | Flutter |
|----------|---------|--------|
| text | 14px/300 Montserrat, #FFF | `TextStyle(fontWeight: FontWeight.w300, color: Colors.white)` |
| letter-spacing | 0.25px | `letterSpacing: 0.25` |
| width | 335px (full content width) | `double.infinity` |

### Stat Row (Số lượng / Giá trị)

| Property | Giá trị | Flutter |
|----------|---------|--------|
| layout | Column: [title row] + gap 12px + [value row] | `Column(...)` |
| title icon | 24x24 | `SvgPicture.asset(...)` |
| title text | 14px/700 Montserrat, #FFEA9E | `TextStyle(fontWeight: FontWeight.w700)` |
| value number | 18px/700 Montserrat, #FFF | `TextStyle(fontSize: 18, fontWeight: FontWeight.w700)` |
| value unit | 14px/300 Montserrat, #FFF | `TextStyle(fontSize: 14, fontWeight: FontWeight.w300)` |
| gap (number + unit) — Quantity | 4px | `SizedBox(width: 4)` |
| gap (amount + note) — Prize | 8px | `SizedBox(width: 8)` |

> **Lưu ý**: Gap giữa số và đơn vị khác nhau: Quantity stat dùng 4px, Prize stat dùng 8px (theo Figma data).

### Primary Button ("Chi tiết")

| Property | Giá trị | Flutter |
|----------|---------|--------|
| **Node ID** | 6885:10331 (Top Talent variant) | - |
| width | 160px | `160` |
| height | 40px | `40` |
| padding | 12px | `EdgeInsets.all(12)` |
| background | #FFEA9E | `Color(0xFFFFEA9E)` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| text | 14px/500 Montserrat, #00101A | `TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF00101A))` |
| icon | 24x24 arrow right | `SvgPicture.asset(...)` |
| layout | Row: [text] + gap 8px + [icon], center | `Row(mainAxisAlignment: MainAxisAlignment.center)` |

### Kudos Banner

| Property | Giá trị | Flutter |
|----------|---------|--------|
| width | 335px | `double.infinity` |
| height | ~145px | `145` |
| background | image + #0F0F0F fallback | `BoxDecoration(...)` |
| border-radius | 4.653px | `BorderRadius.circular(4.653)` |
| logo text | SVN-Gotham ~28px/400, #DBD1C1 | custom font |

### Bottom Navigation Bar

| Property | Giá trị | Flutter |
|----------|---------|--------|
| **Node ID** | 6885:10332 | - |
| width | 375px (full) | `double.infinity` |
| height | 72px | `72` |
| background | rgba(255, 234, 158, 0.15) | `Color(0x26FFEA9E)` |
| border-radius | 20px 20px 0 0 | `BorderRadius.only(topLeft: 20, topRight: 20)` |
| backdrop-filter | blur(20px) | `BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20))` |
| tab icon | 24x24 | active: #FFEA9E, inactive: #FFF |
| tab text | 12px/400 Montserrat | active: #FFEA9E, inactive: #FFF |
| tab gap (icon-text) | 4px | `SizedBox(height: 4)` |
| position | fixed bottom | `Positioned(bottom: 0)` |

---

## Component Hierarchy with Styles

```
AwardScreen (bg: #00101A)
├── Background Layers
│   ├── KeyVisual Image (positioned right, top 0, ~812px height)
│   ├── Shadow Left (linear-gradient horizontal)
│   └── Shadow Bottom (linear-gradient vertical, rotated)
│
├── Header (fixed top, h: 104px, gradient bg, opacity: 0.9, z-index high)
│   ├── StatusBar (h: 44px)
│   ├── Logo (48x44, left: 20px)
│   └── Actions (right aligned)
│       ├── Language [Flag+VN+▼] (90x32, radius: 4px)
│       ├── Search Icon (24x24)
│       └── Notification Icon (24x24) + Badge (8x8, #D4271D, radius: 100)
│
├── ScrollableContent (padding-top: 144px, padding-x: 20px)
│   │
│   ├── KV Kudos Banner (w: 221px, h: 67px, gap: 8px)
│   │   ├── Subtitle ("Hệ thống ghi nhận và cảm ơn", 14px/500, #FFEA9E)
│   │   └── Logo Row (gap: 9px, [fire icon 49x38] + [KUDOS text 163x39])
│   │
│   │── gap: 40px
│   │
│   ├── Section Header (w: 335px)
│   │   ├── Header Component (gap: 4px)
│   │   │   ├── Sub-label ("Sun* Annual Awards 2025", 12px/400, #FFF)
│   │   │   ├── Divider (1px, #2E3940)
│   │   │   └── Title ("Hệ thống giải thưởng\nSAA 2025", 22px/500, #FFEA9E)
│   │   └── Dropdown Filter (gap: 16px below header)
│   │       └── Button (h: 40px, border: #998C5F, bg: rgba(FFEA9E,0.1), radius: 4px)
│   │           ├── Text (14px/400, #FFF)
│   │           └── Arrow Down Icon (24x24)
│   │
│   │── gap: 40px
│   │
│   ├── Award Detail Block (w: 335px, gap: 16px)
│   │   ├── Badge Image (160x160, centered, radius: 11.4px, shadow: glow)
│   │   ├── Award Info (gap: 12px)
│   │   │   ├── Title Row ([icon 24x24] + [text 14px/700 #FFEA9E], gap: 8px)
│   │   │   └── Description (14px/300, #FFF, letter-spacing: 0.25px)
│   │   ├── Divider (1px, #2E3940)
│   │   ├── Quantity Stat (gap: 12px)
│   │   │   ├── Label Row ([diamond icon] + "Số lượng giải thưởng", gap: 8px)
│   │   │   └── Value Row ([number 18px/700 #FFF] + [unit 14px/300 #FFF], gap: 4px)
│   │   ├── Divider (1px, #2E3940)
│   │   ├── Prize Stat (gap: 12px) — 1 block cho hầu hết giải
│   │   │   ├── Label Row ([flag icon] + "Giá trị giải thưởng", gap: 8px)
│   │   │   └── Value Row ([amount 18px/700 #FFF] + [note 14px/300 #FFF], gap: 8px)
│   │   │
│   │   └── ** Signature 2025 - Creator: 2 blocks Prize Stat riêng biệt **
│   │       ├── Prize Stat 1 (cá nhân)
│   │       │   ├── Label Row ([flag icon] + "Giá trị giải thưởng")
│   │       │   └── Value Row (5.000.000 VNĐ + "cho giải cá nhân")
│   │       ├── Divider (1px, #2E3940)
│   │       └── Prize Stat 2 (tập thể)
│   │           ├── Label Row ([flag icon] + "Giá trị giải thưởng")
│   │           └── Value Row (8.000.000 VNĐ + "cho giải tập thể")
│   │
│   │── gap: 40px
│   │
│   └── Sun* Kudos Block (w: 335px, gap: 24px)
│       ├── Section Header ("Phong trào ghi nhận" / "Sun* Kudos")
│       ├── Kudos Banner (w: 335px, h: ~145px, bg: #0F0F0F, radius: 4.65px)
│       │   └── KUDOS Logo (SVN-Gotham, #DBD1C1)
│       ├── Note Text (14px/300, #FFF, w: 333px)
│       │   ├── "ĐIỂM MỚI CỦA SAA 2025" (bold line)
│       │   └── Mô tả hoạt động ghi nhận...
│       └── Button "Chi tiết" (160x40, bg: #FFEA9E, radius: 4px)
│           ├── Label (14px/500, #00101A)
│           └── Arrow Right Icon (24x24)
│
└── Bottom Nav Bar (fixed bottom, h: 72px, bg: rgba(FFEA9E,0.15), blur: 20px)
    └── Tabs Row (h: 54px, justify: space-between, padding-x: 24px)
        ├── SAA 2025 (icon 24x24 + text 12px, #FFF)
        ├── Awards (icon 24x24 + text 12px, #FFEA9E) ← ACTIVE
        ├── Kudos (icon 24x24 + text 12px, #FFF)
        └── Profile (icon 24x24 + text 12px, #FFF)
```

---

## Responsive Specifications

### Breakpoints

Ứng dụng Flutter mobile-only — chỉ có 1 breakpoint chính:

| Name | Chiều rộng | Ghi chú |
|------|-----------|---------|
| Mobile | 375px (design base) | iPhone standard |

### Responsive Changes

Vì là ứng dụng mobile, layout co giãn theo chiều rộng:
- Content width = screen width - 40px (20px mỗi bên)
- Hình huy hiệu giải luôn centered
- Text wrap tự nhiên

---

## Icon Specifications

| Icon Name | Size | Màu | Sử dụng |
|-----------|------|-----|---------|
| MM_MEDIA_IC Award | 24x24 | #FFEA9E | Tiêu đề tên giải |
| MM_MEDIA_IC Diamond | 24x24 | #FFEA9E | Label "Số lượng giải thưởng" |
| MM_MEDIA_IC award flag | 24x24 | #FFEA9E | Label "Giá trị giải thưởng" |
| MM_MEDIA_Down | 24x24 | #FFF | Mũi tên dropdown |
| mm_media_search | 24x24 | #FFF | Nút tìm kiếm header |
| mm_media_notification | 24x24 | #FFF | Nút thông báo header |
| mm_media_icon (arrow right) | 24x24 | #00101A | Trong nút "Chi tiết" |

---

## Animation & Transitions

| Element | Property | Mô tả |
|---------|----------|-------|
| Dropdown | open/close | Hiệu ứng mở/đóng danh sách chọn giải |
| Content switch | fade/slide | Khi chuyển giải, nội dung chuyển tiếp mượt mà |
| Header scroll | opacity | Gradient header fade khi cuộn |

---

## Implementation Mapping (Flutter)

| Design Element | Figma Node ID | Flutter Widget | Vị trí | Trạng thái |
|----------------|---------------|----------------|--------|-----------|
| Header | 6885:10264 | `HomeHeaderWidget` | `features/home/presentation/widgets/` | Đã có (tái sử dụng, có thể cần move sang shared) |
| KV Banner | 6885:10266 | `KvKudosBanner` | `features/award/presentation/widgets/` | Cần tạo mới |
| Section Header | 6885:10285 | `SectionHeaderWidget` | `shared/widgets/` | Đã có |
| Dropdown Filter | 6885:10287 | `AwardDropdownFilter` | `features/award/presentation/widgets/` | Cần tạo mới (dùng `OutlineButton` style) |
| Award Badge | 6885:10293 | `AwardBadgeImage` | `features/award/presentation/widgets/` | Cần tạo mới |
| Award Info | 6885:10294 | `AwardInfoBlock` | `features/award/presentation/widgets/` | Cần tạo mới |
| Stat Row | 6885:10300 | `AwardStatRow` | `features/award/presentation/widgets/` | Cần tạo mới |
| Kudos Block | 6885:10315 | `SunKudosBlock` | `features/award/presentation/widgets/` | Cần tạo mới |
| Button Primary | 6885:10331 | `PrimaryButton` | `shared/widgets/` | Đã có |
| Bottom Nav | 6885:10332 | `BottomNavBar` | `shared/widgets/` | Đã có |

### Shared Widgets đã có trong codebase

| Widget | File | Ghi chú |
|--------|------|---------|
| `BottomNavBar` | `lib/shared/widgets/bottom_nav_bar.dart` | Dùng `currentIndex=1` cho tab Awards |
| `SectionHeaderWidget` | `lib/shared/widgets/section_header_widget.dart` | Dùng cho tiêu đề section |
| `PrimaryButton` | `lib/shared/widgets/primary_button.dart` | Dùng cho nút "Chi tiết" |
| `OutlineButton` | `lib/shared/widgets/outline_button.dart` | Style tham khảo cho dropdown filter |
| `LanguageDropdown` | `lib/shared/widgets/language_dropdown.dart` | Dùng trong header |

---

## Ghi chú

- Tất cả màu sắc PHẢI được định nghĩa trong theme (`app_colors.dart`), KHÔNG hardcode.
- Font Montserrat là font chính, SVN-Gotham chỉ dùng cho logo KUDOS.
- Icons PHẢI dùng SVG format, render qua `flutter_svg`, truy cập qua `Assets.icons.xxx`.
- Hình huy hiệu giải thưởng dùng PNG, truy cập qua `Assets.images.xxx`.
- Background key visual là ảnh PNG lớn, cần optimize cho mobile.
- Đảm bảo contrast ratio đủ cho WCAG AA (text vàng #FFEA9E trên nền tối #00101A).
