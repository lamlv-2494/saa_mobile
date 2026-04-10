# Design Style: [iOS] Login

**Frame ID**: `8HGlvYGJWq`
**Frame Name**: `[iOS] Login`
**Figma Link**: https://momorph.ai/files/9ypp4enmFmdK3YAFJLIu6C/frames/8HGlvYGJWq
**Extracted At**: 2026-04-09

---

## Design Tokens

### Colors

| Token Name | Hex Value | Opacity | Usage |
|------------|-----------|---------|-------|
| --color-bg-dark | #00101A | 100% | Nền chính màn hình Login |
| --color-bg-gradient-start | #00101A | 90% | Gradient header bắt đầu |
| --color-bg-gradient-mid | #00101A | 30% | Gradient header giữa (76.44%) |
| --color-bg-gradient-end | #00101A | 0% | Gradient header kết thúc |
| --color-text-white | #FFFFFF | 100% | Text chính (description, footer, status bar) |
| --color-button-bg | #FFEA9E | 100% | Nền nút Login With Google |
| --color-button-text | #00101A | 100% | Text nút Login |
| --color-flag-bg | #00101A | 100% | Nền icon cờ Vietnam |
| --color-button-pressed | #E6D28E | 100% | Nền nút Login khi pressed (darken 10%) |
| --color-button-disabled | #FFEA9E | 50% | Nền nút Login khi disabled |
| --color-error-bg | #EF4444 | 90% | Nền SnackBar lỗi |
| --color-loading-spinner | #00101A | 100% | Loading spinner trên nút |

### Typography

| Token Name | Font Family | Size | Weight | Line Height | Letter Spacing |
|------------|-------------|------|--------|-------------|----------------|
| --text-status-bar | SF Pro Text | 15px | 600 | 20px | -0.5px |
| --text-language-code | Montserrat | 14px | 500 | 20px | 0px |
| --text-description | Montserrat | 14px | 300 | 20px | 0.25px |
| --text-button-label | Montserrat | 14px | 500 | 20px | 0px |
| --text-copyright | Montserrat | 12px | 400 | 16px | 0px |
| --text-error | Montserrat | 14px | 400 | 20px | 0px |

### Spacing

| Token Name | Value | Usage |
|------------|-------|-------|
| --spacing-screen-padding-x | 20px | Padding trái/phải nội dung chính |
| --spacing-header-top | 52px | Khoảng cách logo từ top |
| --spacing-logo-tagline | 156px | Từ cuối logo đến đầu tagline (96 → 252) |
| --spacing-tagline-desc | 32px | Từ cuối tagline đến đầu description (361 → 393) |
| --spacing-desc-button | 193px | Từ cuối description đến đầu button (433 → 626) |
| --spacing-button-footer | 98px | Từ cuối button đến đầu footer (666 → 764) |
| --spacing-footer-padding-x | 90px | Padding trái/phải footer |

### Border & Radius

| Token Name | Value | Usage |
|------------|-------|-------|
| --radius-button | 4px | Nút Login With Google |
| --radius-language | 4px | Language selector |
| --radius-status-time | 24px | Status bar time |

### Shadows

| Token Name | Value | Usage |
|------------|-------|-------|
| Không có shadow | - | Màn hình Login không sử dụng shadow |

---

## Layout Specifications

### Container

| Property | Value | Notes |
|----------|-------|-------|
| width | 375px | iPhone standard width |
| height | 812px | iPhone standard height |
| background-color | #00101A | Nền tối |

### Layout Structure (ASCII)

```
┌─────────────────────────────────────────┐ 0px
│  Background Image (full screen)          │
│  ┌─────────────────────────────────────┐ │
│  │  Header Gradient (h: 104px)          │ │ 0px
│  │  ┌──────────┐          ┌──────────┐ │ │
│  │  │ StatusBar│          │  StatusBar│ │ │ 0-44px
│  │  └──────────┘          └──────────┘ │ │
│  │  ┌────────┐            ┌─────────┐  │ │
│  │  │  Logo  │            │ 🇻🇳 VN ▼│  │ │ 52-96px
│  │  │ 48x44  │            │  90x32  │  │ │
│  │  └────────┘            └─────────┘  │ │
│  └─────────────────────────────────────┘ │ 104px
│                                          │
│  ┌─────────────────────────────────────┐ │
│  │  ROOT FURTHER (247x109)              │ │ 252-361px
│  │  (Logo/Tagline image)                │ │
│  └─────────────────────────────────────┘ │
│                                          │
│  ┌─────────────────────────────────────┐ │
│  │  Description Text (335x40)           │ │ 393-433px
│  │  "Bắt đầu hành trình..."            │ │
│  └─────────────────────────────────────┘ │
│                                          │
│                                          │
│       ┌───────────────────────┐          │
│       │  LOGIN With Google G  │          │ 626-666px
│       │      246x40           │          │
│       └───────────────────────┘          │
│                                          │
│  ┌─────────────────────────────────────┐ │
│  │  Footer (375x48)                     │ │ 764-812px
│  │  "Bản quyền thuộc về Sun* © 2025"   │ │
│  └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘ 812px
```

---

## Component Style Details

### Background Image - Keyvisual BG

| Property | Value | Flutter |
|----------|-------|--------|
| **Node ID** | 6885:8965 | - |
| width | 375px | `double.infinity` |
| height | 812px | `double.infinity` |
| background | Key visual image | `DecorationImage(fit: BoxFit.cover)` |
| aspect-ratio | 121/262 | Phủ toàn màn hình |

---

### Header Gradient Overlay

| Property | Value | Flutter |
|----------|-------|--------|
| **Node ID** | 6885:8972 | - |
| width | 375px | `double.infinity` |
| height | 104px | `104.0` |
| opacity | 0.9 | `Opacity(opacity: 0.9)` |
| background | Linear gradient | `LinearGradient` |
| gradient | 180deg: #00101A 0% → rgba(0,16,26,0.30) 76.44% → rgba(0,16,26,0) 100% | Xem chi tiết bên dưới |

**Gradient stops:**
| Position | Color | Opacity |
|----------|-------|---------|
| 0% | #00101A | 100% |
| 76.44% | #00101A | 30% |
| 84.62% | #00101A | 20% |
| 88.70% | #00101A | 15% |
| 92.79% | #00101A | 10% |
| 96.39% | #00101A | 5% |
| 100% | #00101A | 0% |

---

### Logo - Sun* Annual Awards

| Property | Value | Flutter |
|----------|-------|--------|
| **Node ID** | 6885:8977 | - |
| width | 48px | `48.0` |
| height | 44px | `44.0` |
| position | left: 20px, top: 52px | `Positioned(left: 20, top: 52)` |
| content | Logo image (cover) | `Image.asset(fit: BoxFit.cover)` |
| gap (internal) | 10px | - |

---

### Language Selector

| Property | Value | Flutter |
|----------|-------|--------|
| **Node ID** | 6885:8976 | - |
| width | 90px | `90.0` |
| height | 32px | `32.0` |
| position | right: 20px, top: 64px | `Positioned(right: 20, top: 64)` |
| padding | 4px 0px 4px 8px | `EdgeInsets.fromLTRB(8, 4, 0, 4)` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| display | flex, row | `Row` |
| gap | 8px | `SizedBox(width: 8)` |
| align-items | center | `CrossAxisAlignment.center` |

**Children:**
- Flag icon (24x24px, Node: I6885:8976;65:2466)
- Language code text "VN" (14px, Montserrat, weight 500, white)
- Dropdown arrow icon (24x24px, Node: I6885:8976;65:2468)

**States:**
| State | Flag Icon | Label | Changes |
|-------|-----------|-------|---------|
| Default (VN) | 🇻🇳 Vietnam flag | "VN" | Trạng thái khởi tạo |
| Default (EN) | 🇬🇧 UK flag | "EN" | Sau khi chọn English |
| Pressed | Giữ nguyên flag hiện tại | Giữ nguyên label | Mở PopupMenu bên dưới selector (VN/EN) |

**Interaction:** Sử dụng Flutter `PopupMenuButton` — menu popup hiển thị BÊN DƯỚI trigger widget (offset: 48px), không đè lên. Popup hiển thị 2 items: VN (cờ + label) và EN (cờ + label). Item đang chọn có icon check.

---

### Root Further Tagline

| Property | Value | Flutter |
|----------|-------|--------|
| **Node ID** | 6885:8967 | - |
| width | 247px | `247.0` |
| height | 109px | `109.0` |
| position | left: 20px, top: 252px | `Positioned(left: 20, top: 252)` |
| content | "ROOT FURTHER" image | `Image.asset(fit: BoxFit.cover)` |

---

### Description Text

| Property | Value | Flutter |
|----------|-------|--------|
| **Node ID** | 6885:8968 | - |
| width | 335px | Dùng constraint padding 20px mỗi bên |
| height | 40px (2 dòng) | Auto |
| position | left: 20px, top: 393px | `Positioned(left: 20, top: 393)` |
| font-family | Montserrat | `GoogleFonts.montserrat()` |
| font-size | 14px | `fontSize: 14` |
| font-weight | 300 (Light) | `fontWeight: FontWeight.w300` |
| line-height | 20px | `height: 20/14` (~1.43) |
| letter-spacing | 0.25px | `letterSpacing: 0.25` |
| color | #FFFFFF | `Colors.white` |
| text-align | left | `TextAlign.left` |
| content | "Bắt đầu hành trình của bạn cùng SAA 2025.\nĐăng nhập để khám phá!" | i18n (slang) |

---

### Login With Google Button

| Property | Value | Flutter |
|----------|-------|--------|
| **Node ID** | 6885:8969 | - |
| width | 246px | `246.0` |
| height | 40px | `40.0` |
| position | centered horizontally, top: 626px | `Align(alignment: Alignment.center)` |
| padding | 12px | `EdgeInsets.all(12)` |
| background-color | #FFEA9E | `Color(0xFFFFEA9E)` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| display | flex, row, center | `Row(mainAxisAlignment: MainAxisAlignment.center)` |
| gap | 8px | `SizedBox(width: 8)` |

**Button Label:**
| Property | Value | Flutter |
|----------|-------|--------|
| **Node ID** | I6885:8969;28:1998 | - |
| text | "LOGIN With Google " | i18n (slang) |
| font-family | Montserrat | `GoogleFonts.montserrat()` |
| font-size | 14px | `fontSize: 14` |
| font-weight | 500 (Medium) | `fontWeight: FontWeight.w500` |
| line-height | 20px | `height: 20/14` |
| color | #00101A | `Color(0xFF00101A)` |
| text-align | center | `TextAlign.center` |

**Button Icon (Google):**
| Property | Value | Flutter |
|----------|-------|--------|
| **Node ID** | I6885:8969;28:1997 | - |
| width | 24px | `24.0` |
| height | 24px | `24.0` |
| content | Google logo | Icon component |

**States:**
| State | Property | Value | Flutter |
|-------|----------|-------|--------|
| Default | background | #FFEA9E | `Color(0xFFFFEA9E)` |
| Pressed | background | #E6D28E | `Color(0xFFE6D28E)` |
| Pressed | transform | scale(0.98) | `Transform.scale(scale: 0.98)` |
| Loading | background | #FFEA9E, opacity 0.7 | `Color(0xFFFFEA9E).withOpacity(0.7)` |
| Loading | content | CircularProgressIndicator, 20px, color #00101A | Thay thế text + icon |
| Loading | interaction | disabled | `AbsorbPointer` hoặc `IgnorePointer` |
| Disabled | background | #FFEA9E, opacity 0.5 | `Color(0xFFFFEA9E).withOpacity(0.5)` |
| Disabled | text color | #00101A, opacity 0.5 | `Color(0xFF00101A).withOpacity(0.5)` |
| Disabled | interaction | disabled | `AbsorbPointer` |

---

### Footer

| Property | Value | Flutter |
|----------|-------|--------|
| **Node ID** | 6885:8970 | - |
| width | 375px | `double.infinity` |
| height | 48px | `48.0` |
| position | bottom: 0px | `Positioned(bottom: 0)` |
| padding | 16px 90px | `EdgeInsets.symmetric(horizontal: 90, vertical: 16)` |
| display | flex, row, center | `Row(mainAxisAlignment: MainAxisAlignment.center)` |

**Copyright Text:**
| Property | Value | Flutter |
|----------|-------|--------|
| **Node ID** | 6885:8971 | - |
| text | "Bản quyền thuộc về Sun* © 2025" | i18n (slang) |
| font-family | Montserrat | `GoogleFonts.montserrat()` |
| font-size | 12px | `fontSize: 12` |
| font-weight | 400 (Regular) | `fontWeight: FontWeight.w400` |
| line-height | 16px | `height: 16/12` (~1.33) |
| color | #FFFFFF | `Colors.white` |
| text-align | center | `TextAlign.center` |

---

### Error SnackBar (trạng thái lỗi)

| Property | Value | Flutter |
|----------|-------|--------|
| width | match parent - 32px (padding 16px mỗi bên) | `double.infinity` |
| height | auto | Hug content |
| position | bottom: 80px (trên footer) | `SnackBar` hoặc custom positioned |
| padding | 12px 16px | `EdgeInsets.symmetric(horizontal: 16, vertical: 12)` |
| background-color | #EF4444, opacity 0.9 | `Color(0xFFEF4444).withOpacity(0.9)` |
| border-radius | 8px | `BorderRadius.circular(8)` |
| font-family | Montserrat | `GoogleFonts.montserrat()` |
| font-size | 14px | `fontSize: 14` |
| font-weight | 400 | `fontWeight: FontWeight.w400` |
| text color | #FFFFFF | `Colors.white` |
| duration | 4 giây | `Duration(seconds: 4)` |
| dismiss | Tap hoặc auto | `SnackBarBehavior.floating` |

---

## Component Hierarchy with Styles

```
[iOS] Login (375x812, bg: #00101A)
├── Background Image (full screen, cover)
│   └── Keyvisual BG (6885:8965)
│
├── Header Gradient (375x104, gradient overlay, opacity: 0.9)
│   ├── StatusBar (375x44, system iOS status bar)
│   │   ├── Time "9:41" (SF Pro Text, 15px, w600, white)
│   │   └── Icons (battery, wifi, signal)
│   │
│   ├── Logo (48x44, left: 20, top: 52)
│   │   └── SAA Logo Image (cover)
│   │
│   └── Language Selector (90x32, right: 20, top: 64, radius: 4)
│       ├── Flag Icon VN (24x24)
│       ├── "VN" (Montserrat, 14px, w500, white)
│       └── Arrow Down Icon (24x24)
│
├── Root Further Tagline (247x109, left: 20, top: 252)
│   └── Tagline Image (cover)
│
├── Description Text (335x40, left: 20, top: 393)
│   └── "Bắt đầu hành trình..." (Montserrat, 14px, w300, white)
│
├── Login Button (246x40, center-x, top: 626, bg: #FFEA9E, radius: 4)
│   ├── "LOGIN With Google" (Montserrat, 14px, w500, #00101A)
│   └── Google Icon (24x24)
│
├── Footer (375x48, bottom: 0, px: 90, py: 16)
│   └── "Bản quyền thuộc về Sun* © 2025" (Montserrat, 12px, w400, white)
│
└── [Conditional] Error SnackBar (floating, bottom: 80, bg: #EF4444/90%)
    └── Error message text (Montserrat, 14px, w400, white)
```

---

## Responsive Specifications

### Breakpoints

Đây là ứng dụng mobile Flutter — responsive dựa trên kích thước thiết bị.

| Device | Width Range | Notes |
|--------|-------------|-------|
| iPhone SE | 375px | Thiết kế gốc |
| iPhone Standard | 375-393px | Thiết kế chính |
| iPhone Pro Max | 428-430px | Mở rộng padding |
| Android | 360-412px | Tương tự iPhone |

### Responsive Changes

| Component | Strategy |
|-----------|----------|
| Background Image | `BoxFit.cover` — phủ toàn màn hình |
| Header | Cố định height 104px, stretch width |
| Logo | Cố định size 48x44, pin top-left |
| Language Selector | Cố định size 90x32, pin top-right |
| Tagline | Cố định size 247x109, pin left |
| Description | Stretch width (padding 20px mỗi bên) |
| Login Button | Cố định width 246px, center horizontally |
| Footer | Stretch width, center text |
| Vertical spacing | Sử dụng `Spacer` hoặc `Expanded` giữa các phần tử |

---

## Icon Specifications

| Icon Name | Size | Node ID | Usage |
|-----------|------|---------|-------|
| SAA Logo | 48x44 | 6885:8977 | Logo app góc trái trên |
| VN Flag | 24x24 | I6885:8976;65:2466 | Cờ Vietnam trong language selector |
| EN Flag | 24x24 | - | Cờ UK trong language selector (khi chọn EN) |
| Arrow Down | 24x24 | I6885:8976;65:2468 | Mũi tên dropdown |
| Google Logo | 24x24 | I6885:8969;28:1997 | Icon trong nút Login |

---

## Animation & Transitions

| Element | Property | Duration | Easing | Trigger |
|---------|----------|----------|--------|---------|
| Login Button | opacity, scale | 150ms | ease-in-out | Press/Release |
| Language Dropdown | opacity, translateY | 200ms | ease-out | Open/Close |
| Screen | opacity | 300ms | ease-in | Navigate away (sau login) |

---

## Implementation Mapping

| Design Element | Figma Node ID | Flutter Widget | File Path |
|----------------|---------------|----------------|-----------|
| Background | 6885:8965 | `Image.asset` + `BoxFit.cover` | `shared/widgets/` |
| Header Gradient | 6885:8972 | `Container` + `LinearGradient` | `features/auth/presentation/widgets/` |
| Logo | 6885:8977 | `Image.asset` | `shared/widgets/` |
| Language Selector | 6885:8976 | Custom `LanguageSelector` widget | `shared/widgets/` |
| Tagline | 6885:8967 | `Image.asset` | `features/auth/presentation/widgets/` |
| Description | 6885:8968 | `Text` | `features/auth/presentation/screens/` |
| Login Button | 6885:8969 | Custom `GoogleLoginButton` widget | `features/auth/presentation/widgets/` |
| Footer | 6885:8970 | `Text` | `shared/widgets/` |

---

## Notes

- Font chính: **Montserrat** — load qua `google_fonts` package (cache tự động sau lần đầu).
- Tất cả text PHẢI dùng **slang** (i18n) — không hardcode string.
- Tất cả màu sắc PHẢI định nghĩa trong **theme** — không hardcode hex.
- Icons PHẢI dùng **Icon Component** hoặc SVG asset — không dùng image tag.
- Background image là asset tĩnh — load từ `assets/images/`.
- Status bar: `SystemUiOverlayStyle.light` (text trắng trên nền tối).
- Orientation: **Portrait only** — lock rotation cho màn hình Login.
- SafeArea: Sử dụng `SafeArea` widget, đặc biệt cho iPhone có notch/Dynamic Island.
- Touch target: Interactive elements PHẢI đạt minimum 48x48dp hit area.
  - Language Selector: 90x32 visible, nhưng hit area PHẢI ≥ 48dp height.
  - Login Button: 246x40 visible, nhưng hit area PHẢI ≥ 48dp height.
