# Design Style: [iOS] Sun*Kudos - Tất cả Kudos

**Frame ID**: `j_a2GQWKDJ`
**Frame Name**: `[iOS] Sun*Kudos_All Kudos`
**Figma Link**: Figma file key `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-13

---

## Design Tokens

### Màu sắc

| Token | Hex | Opacity | Sử dụng |
|-------|-----|---------|---------|
| --color-bg-dark | #00101A | 100% | Nền màn hình chính |
| --color-surface-card | #FFF8E1 | 100% | Nền thẻ kudos |
| --color-primary / accent | #FFEA9E | 100% | Viền thẻ, divider, tiêu đề "ALL KUDOS" |
| --color-text-dark | #00101A | 100% | Text nội dung trên card sáng |
| --color-text-white | #FFFFFF | 100% | Text trên nền tối (tiêu đề nav, tên header) |
| --color-text-secondary | #999999 | 100% | Phòng ban, thời gian, text phụ |
| --color-hashtag | #D4271D | 100% | Hashtag text |
| --color-content-border | #FFEA9E | 40% opacity | Nền khung nội dung (rgba(255, 234, 158, 0.40)) |
| --color-content-border-stroke | #FFEA9E | 100% | Viền khung nội dung (0.463px solid) |
| --color-divider | #FFEA9E | 100% | Đường phân cách trong card |
| --color-badge-border | #FFEA9E | 100% | Viền badge danh hiệu |
| --color-gradient-top | Gradient | - | linear-gradient(180deg, #00101A 0%, transparent 100%) |
| --color-separator | #2E3940 | 100% | Đường phân cách header |

### Typography

| Token | Font Family | Size | Weight | Line Height | Letter Spacing |
|-------|-------------|------|--------|-------------|----------------|
| --text-nav-title | Helvetica Neue | 17px | 500 | 24px | 0.5px |
| --text-header-event | Montserrat | 12px | 400 | 16px | 0% |
| --text-header-title | Montserrat | 22px | 500 | 28px | 0% |
| --text-sender-name | Montserrat | 10px | 400 | 16px | 0% |
| --text-department | Montserrat | 10px | 500 | ~9.26px | 0.046px |
| --text-badge | Montserrat | 6px | 700 | ~7.5px | 0.038px |
| --text-timestamp | Montserrat | 10px | 500 | ~11.1px | 0.23px |
| --text-card-title | Montserrat | 10px | 700 | ~11.1px | 0.23px |
| --text-content | Montserrat | 10px | 400 | 14px | 0px |
| --text-hashtag | Montserrat | 10px | 400 | ~11.1px | 0.23px |
| --text-heart-count | Montserrat | 10px | 400 | ~14.8px | 0px |
| --text-action-label | Montserrat | 10px | 500 | ~11.1px | 0.069px |

### Spacing

| Token | Giá trị | Sử dụng |
|-------|---------|---------|
| --spacing-page-horizontal | 20px | Padding ngang toàn trang (header) |
| --spacing-card-padding | 8px 12px | Padding bên trong thẻ kudos |
| --spacing-card-gap | 12px | Khoảng cách giữa các thẻ kudos |
| --spacing-inner-gap | 8px | Gap giữa các section trong card |
| --spacing-name-gap | 4px | Gap giữa tên và phòng ban |
| --spacing-header-gap | 4px | Gap giữa header event và title |
| --spacing-action-padding | 4px | Padding nút action |

### Border & Radius

| Token | Giá trị | Sử dụng |
|-------|---------|---------|
| --radius-card | 8px | Border radius thẻ kudos |
| --radius-avatar | 24px (full circle) | Avatar tròn |
| --radius-badge | 22.217px | Border radius badge danh hiệu |
| --radius-content-box | 5.554px | Border radius khung nội dung |
| --radius-action-btn | 2px | Border radius nút action |
| --border-card | 1px solid #FFEA9E | Viền thẻ kudos |
| --border-avatar | 0.865px solid #FFFFFF | Viền avatar |
| --border-content | 0.463px solid #FFEA9E | Viền khung nội dung |
| --border-badge | 0.231px solid #FFEA9E | Viền badge danh hiệu |

### Shadows

| Token | Giá trị | Sử dụng |
|-------|---------|---------|
| --shadow-badge-text | 0 0.179px 0.714px #000 | Text shadow trên badge |
| --shadow-badge-glow | 0 0 0.602px #FFF | Text shadow badge variant "Legend" |

---

## Layout Specifications

### Container

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-------|
| width | 375px | Thiết kế cho iPhone (mobile-first) |
| height | 1338px | Chiều cao nội dung (scrollable) |
| background | #00101A | Nền tối |

### Cấu trúc Layout (ASCII)

```
┌─────────────────────────────────────────────────────────┐
│  Screen (375px, bg: #00101A)                             │
│                                                          │
│  ┌──────────────────────────────────────────────────┐   │
│  │  StatusBar (375 x 47px)                           │   │
│  └──────────────────────────────────────────────────┘   │
│                                                          │
│  ┌──────────────────────────────────────────────────┐   │
│  │  TopNavigation (375 x 42px, y: 47px)              │   │
│  │  ┌────────┐  ┌────────────────────┐               │   │
│  │  │ ← Back │  │ "All Kudos" (17px) │               │   │
│  │  │  24x24  │  │  Helvetica Neue    │               │   │
│  │  └────────┘  └────────────────────┘               │   │
│  └──────────────────────────────────────────────────┘   │
│                                                          │
│  ┌──────────────────────────────────────────────────┐   │
│  │  Background (Key Visual + Gradients)              │   │
│  └──────────────────────────────────────────────────┘   │
│                                                          │
│  ┌──────────────────────────────────────────────────┐   │
│  │  Header (336px, x: 20px, y: 113px)                │   │
│  │  "Sun* Annual Awards 2025" (12px, #FFF)           │   │
│  │  ──────────────────────── (1px, #2E3940)          │   │
│  │  "ALL KUDOS" (22px, 500, #FFEA9E)                 │   │
│  └──────────────────────────────────────────────────┘   │
│                                                          │
│  ┌──────────────────────────────────────────────────┐   │
│  │  Kudos List (274px, gap: 12px, centered)          │   │
│  │                                                    │   │
│  │  ┌────────────────────────────────────────────┐   │   │
│  │  │  Kudos Card (bg: #FFF8E1, r: 8px)          │   │   │
│  │  │  border: 1px solid #FFEA9E                  │   │   │
│  │  │  padding: 8px 12px                          │   │   │
│  │  │                                              │   │   │
│  │  │  ┌──────────────────────────────────────┐   │   │   │
│  │  │  │ Sender ──→── Receiver (row, gap: 8px) │   │   │   │
│  │  │  │ [Avatar] Name    [Arrow] [Avatar] Name│   │   │   │
│  │  │  │  24x24   Dept+Badge  16px  24x24      │   │   │   │
│  │  │  └──────────────────────────────────────┘   │   │   │
│  │  │  ─── divider (1px, #FFEA9E) ───             │   │   │
│  │  │  Timestamp (10px, #999)                      │   │   │
│  │  │  Title (10px, 700, #00101A, center)          │   │   │
│  │  │  ┌──────────────────────────────────────┐   │   │   │
│  │  │  │ Content Box (bg: #FFEA9E40, r: 5.5px)│   │   │   │
│  │  │  │ border: 0.463px solid #FFEA9E        │   │   │   │
│  │  │  │ padding: 4px                          │   │   │   │
│  │  │  │ "Cảm ơn..." (10px, 400, #00101A)     │   │   │   │
│  │  │  └──────────────────────────────────────┘   │   │   │
│  │  │  Hashtags (10px, #D4271D)                    │   │   │
│  │  │  ─── divider (1px, #FFEA9E) ───             │   │   │
│  │  │  ┌──────────────────────────────────────┐   │   │   │
│  │  │  │ Actions (row, space-between)          │   │   │   │
│  │  │  │ [1.000 ♥]    [Copy Link] [Xem chi tiết]│  │   │   │
│  │  │  └──────────────────────────────────────┘   │   │   │
│  │  └────────────────────────────────────────────┘   │   │
│  │                                                    │   │
│  │  ┌────────────────────────────────────────────┐   │   │
│  │  │  Kudos Card 2 (cùng cấu trúc)              │   │   │
│  │  └────────────────────────────────────────────┘   │   │
│  │  ... (repeat)                                      │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

---

## Chi tiết Style từng Component

### TopNavigation

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `6891:16002` | - |
| width | 375px | Full width |
| height | 42px | - |
| background | Transparent (overlay trên gradient) | - |
| Back icon size | 24x24px | Node: `6891:16004` |
| Title text | "All Kudos" | Node: `6891:16006` |
| Title font | Helvetica Neue, 17px, 500, #FFFFFF | line-height: 24px |
| Title alignment | Center | - |

---

### Header Section

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `6891:16644` | Instance of component `6885:8015` |
| width | 336px | - |
| position | x: 20px, y: 113px | Padding trái 20px |
| gap | 4px | Giữa các phần tử |
| Event text | "Sun* Annual Awards 2025" | 12px, 400, #FFFFFF |
| Divider | 336 x 1px, #2E3940 | - |
| Title text | "ALL KUDOS" | 22px, 500, #FFEA9E |

---

### Kudos Card (KUDO - Highlight)

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `6891:16171` (card 1) | Component: `6885:8424` |
| **Container ID** | `6891:16170` | Danh sách chứa tất cả cards |
| container width | Responsive: `screenWidth - 2 * 20px` (Figma: 274px trên 375px) | Scale theo màn hình |
| container gap | 12px | Giữa các cards |
| container layout | flex, column, align-items: center | - |
| container padding | 0px 20px | Horizontal padding |
| card background | #FFF8E1 | - |
| card border | 1px solid #FFEA9E | - |
| card border-radius | 8px | - |
| card padding | 8px 12px | - |
| card gap | 8px | Giữa các section trong card |

---

### Sender/Receiver Header (trao nhận)

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `I6891:16171;89:2950` | - |
| layout | flex, row, gap: 8px, align-items: center | - |
| width | 250px | - |
| height | 62px | - |

#### Avatar

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID (sender)** | `I6891:16171;89:2951;89:2598` | - |
| **Node ID (receiver)** | `I6891:16171;89:2954;89:2717` | - |
| size | 24 x 24px | - |
| border | 0.865px solid #FFFFFF | - |
| border-radius | 24px (circle) | - |
| background | Image cover, fallback: #EEE | - |

#### Thông tin người dùng

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `I6891:16171;89:2951;89:2599` | - |
| layout | flex, column, gap: 4px | - |
| width | 109px | - |
| Tên | 10px, 400, #00101A, maxLines: 1 | Truncate với "..." |
| Phòng ban | 10px, 500, #999999 | line-height: ~9.26px |
| Badge | 6px, 700, #FFFFFF trên nền gradient | text-shadow |

#### Arrow Icon

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `I6891:16171;89:2952` | - |
| size | 16 x 16px | Component: `6885:8257` |
| padding | 7.4px vertical | Căn giữa theo chiều dọc |

---

### Nội dung Card (B.4)

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `I6891:16171;89:2956` | - |
| layout | flex, column, gap: 8px, align-items: flex-end | - |
| width | 250px | - |

#### Thời gian

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `I6891:16171;89:2957` | - |
| font | Montserrat, 10px, 500, #999999 | - |
| text-align | left | - |
| Ví dụ | "10:00 - 10/30/2025" | - |

#### Tiêu đề (Category)

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `I6891:16171;89:2958` | - |
| font | Montserrat, 10px, 700, #00101A | - |
| text-align | center | - |
| Ví dụ | "IDOL GIỚI TRẺ" | Tên category/giải thưởng |

#### Khung nội dung

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `I6891:16171;89:2960` | - |
| background | rgba(255, 234, 158, 0.40) | #FFEA9E ở 40% |
| border | 0.463px solid #FFEA9E | - |
| border-radius | 5.554px | - |
| padding | 4px | - |
| Text font | Montserrat, 10px, 400, #00101A | line-height: 14px |
| Text align | justified | - |
| maxLines | 3 | Truncate với "..." |

#### Hashtag

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `I6891:16171;89:2969` | - |
| font | Montserrat, 10px, 400, #D4271D | - |
| Ví dụ | "#Dedicated #Inspiring" | - |
| maxLines | 2 | Truncate |

---

### Action Bar (B.4.4)

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `I6891:16171;89:2972` | - |
| layout | flex, row, space-between, align-items: center | - |
| width | 250px | - |
| height | 24px | - |
| gap | ~11.1px | - |

#### Heart

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `I6891:16171;89:2973` | - |
| Count font | Montserrat, 10px, 400, #00101A | - |
| Icon size | 16 x 16px | Component: `6885:8259` |
| Ví dụ | "1.000" + heart icon | - |

#### Copy Link Button

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `I6891:16171;89:3019` | - |
| padding | 4px | - |
| border-radius | 2px | - |
| Label font | Montserrat, 10px, 500, #00101A | - |
| Icon size | 16 x 16px | Component: `6885:8261` |
| Label | "Copy Link" | - |

#### Xem chi tiết Button

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `I6891:16171;89:3026` | - |
| padding | 4px | - |
| border-radius | 2px | - |
| Label font | Montserrat, 10px, 500, #00101A | - |
| Arrow icon size | 16 x 16px | Component: `6885:8012` |
| Label | "Xem chi tiết" | - |

---

### Divider Lines

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID (divider 1)** | `I6891:16171;89:2955` | Giữa sender/receiver và content |
| **Node ID (divider 2)** | `I6891:16171;89:2971` | Giữa hashtag và action |
| width | 250px | Full width card content |
| height | ~0px (hairline) | - |
| color | #FFEA9E | - |

---

### Background

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Node ID** | `6891:15996` | Group chứa bg layers |
| Key Visual | Image, aspect-ratio: 189/155 | Node: `6891:15997` |
| Shadow Left | Gradient 90deg, #00101A → transparent | Node: `6891:15998` |
| Shadow Bottom | Gradient 90deg (rotated -90deg) | Node: `6891:15999` |
| Top Gradient | Gradient 180deg, #00101A → transparent, opacity: 0.9 | Node: `6891:16000` |

---

## Component Hierarchy với Styles

```
Screen (375x1338, bg: #00101A)
├── mm_media_bg (GROUP — key visual + gradient overlays)
│   ├── Key Visual Image (aspect-ratio: 189/155)
│   ├── Shadow Left (gradient left → transparent)
│   └── Shadow Bottom (gradient bottom → transparent)
├── TopNavigation (375x89, gradient overlay, opacity: 0.9)
│   ├── StatusBar (375x47)
│   └── Navigation Content (375x42)
│       ├── Back Icon (24x24, position: 7px left)
│       └── Title "All Kudos" (17px, 500, #FFF, center)
├── Header (336px, x: 20px, gap: 4px)
│   ├── Event Label "Sun* Annual Awards 2025" (12px, 400, #FFF)
│   ├── Divider (1px, #2E3940)
│   └── Title "ALL KUDOS" (22px, 500, #FFEA9E)
└── Kudos Card List (274px, gap: 12px, column, center-aligned)
    └── Kudos Card (bg: #FFF8E1, border: 1px solid #FFEA9E, r: 8px, p: 8px 12px)
        ├── Sender/Receiver Row (250px, row, gap: 8px)
        │   ├── Sender Info (109px, column, gap: 4px/8px)
        │   │   ├── Avatar (24x24, circle, border: 0.865px #FFF)
        │   │   ├── Name (10px, 400, #00101A)
        │   │   └── Dept (10px, 500, #999) + Badge (6px, 700, gradient bg)
        │   ├── Arrow Icon (16x16, centered vertically)
        │   └── Receiver Info (109px, same structure as Sender)
        ├── Divider (250px, #FFEA9E)
        ├── Content Section (250px, column, gap: 8px)
        │   ├── Timestamp (10px, 500, #999)
        │   ├── Category Title (10px, 700, #00101A, center)
        │   ├── Content Box (bg: #FFEA9E40, border: 0.463px #FFEA9E, r: 5.5px, p: 4px)
        │   │   └── Text (10px, 400, #00101A, justified, maxLines: 3)
        │   └── Hashtags (10px, 400, #D4271D)
        ├── Divider (250px, #FFEA9E)
        └── Action Bar (250px, row, space-between)
            ├── Heart (count text + icon 16x16)
            ├── Copy Link (label + icon 16x16, p: 4px)
            └── Xem chi tiết (label + arrow icon 16x16, p: 4px)
```

---

### Bottom Navigation Bar

| Thuộc tính | Giá trị | Ghi chú |
|----------|---------|-----|
| **Ghi chú** | Không visible trong frame Figma | SCREENFLOW xác nhận có 4 tab |
| Tabs | SAA (Home), Awards, Kudos, Profile | - |
| Active tab | Kudos | Màn hình thuộc section Kudos |
| Style | Tái sử dụng bottom nav component từ Home screen | Xem spec Home (`OuH1BUTYT0`) |

> **Lưu ý**: Bottom nav không xuất hiện trong frame Figma của All Kudos nhưng SCREENFLOW ghi nhận navigation qua bottom nav. Cần xác nhận với design team xem bottom nav có hiển thị trên màn hình này không.

---

### Component States — Interactive Elements

#### Heart Button States

| State | Icon | Count Color | Hành vi |
|-------|------|-------------|---------|
| Default (chưa like) | Heart outline, 16x16 | #00101A | Bấm được |
| Liked (đã like) | Heart filled, 16x16 | Accent color | Bấm để unlike |
| Disabled (không có quyền) | Heart outline, 16x16, opacity: 0.4 | #999999 | Không bấm được |

#### Copy Link Button States

| State | Hành vi |
|-------|---------|
| Default | Hiện label "Copy Link" + icon |
| Tapped | Copy URL vào clipboard, hiện snackbar |
| No shareUrl | Ẩn hoặc disable |

#### Xem chi tiết Button States

| State | Hành vi |
|-------|---------|
| Default | Hiện label "Xem chi tiết" + arrow icon |
| Tapped | Navigate đến màn chi tiết |

---

## Responsive Specifications

### Breakpoints

| Tên | Ghi chú |
|-----|-------|
| Mobile | Thiết kế chính — 375px (iPhone) |

Màn hình này chỉ dành cho mobile. Không cần responsive cho tablet/desktop.

### Responsive Changes — Mobile

| Thành phần | Ghi chú |
|-----------|---------|
| Card List width | **Scale responsive**: `screenWidth - 2 * horizontalPadding` (trên 375px = 335px với padding 20px). Figma hiện 274px là giá trị thiết kế, KHÔNG dùng cố định. |
| Font sizes | **Giữ theo Figma** (10px cho hầu hết text). Đây là quyết định xác nhận — KHÔNG scale lên như code Home screen. |
| Padding | 20px horizontal cho header và card list |

---

## Icon Specifications

| Tên Icon | Size | Sử dụng | Component ID |
|----------|------|---------|--------------|
| ic_back (mũi tên trái) | 24x24 | Nút quay lại trên TopNavigation | `6891:16823` |
| ic_arrow_forward | 16x16 | Mũi tên giữa sender → receiver | `6885:8257` |
| ic_heart | 16x16 | Icon heart trong action bar | `6885:8259` |
| ic_link / copy | 16x16 | Icon copy link | `6885:8261` |
| ic_arrow_detail | 16x16 | Icon mũi tên "Xem chi tiết" | `6885:8012` |

---

## Animation & Transitions

| Phần tử | Thuộc tính | Duration | Easing | Trigger |
|---------|----------|----------|--------|---------|
| Screen | slide-in từ phải | 300ms | ease-out | Mở màn hình |
| Screen | slide-out sang phải | 300ms | ease-out | Back/swipe back |
| Heart icon | scale + color | 200ms | ease-in-out | Toggle heart |
| Kudos cards | fade-in | 150ms | ease-in | Load thêm infinite scroll |

---

## Implementation Mapping

| Design Element | Figma Node ID | Flutter Widget | Ghi chú |
|----------------|---------------|----------------|---------|
| TopNavigation | `6891:16002` | `AppBar` / Custom Widget | Tái sử dụng TopNavigation component |
| Header | `6891:16644` | `SectionHeaderWidget` | Tái sử dụng từ shared |
| Kudos Card | `6891:16171` | Variant mới của `KudosFeedCard` | Cần điều chỉnh style cho nền sáng |
| Sender/Receiver | `I6891:16171;89:2950` | `_SenderReceiverHeader` | Tái sử dụng từ `KudosFeedCard` với style khác |
| Content | `I6891:16171;89:2956` | `KudosContentCard` | Cần variant cho nền sáng + thêm title |
| Action Bar | `I6891:16171;89:2972` | Phần action trong `KudosContentCard` | Tái sử dụng |
| Heart Button | `I6891:16171;89:2973` | `HeartButton` | Tái sử dụng |
| Badge | `I6891:16171;89:2951;89:2697` | Custom Badge Widget | Component `6885:8331` |

---

## Ghi chú

- Tất cả màu sắc PHẢI sử dụng `AppColors` constants, KHÔNG hardcode hex.
- Tất cả text PHẢI sử dụng `GoogleFonts.montserrat()` hoặc theme text styles.
- Icon PHẢI sử dụng SVG qua `flutter_gen` (Assets.icons.xxx).
- Card trên All Kudos có nền sáng (#FFF8E1) — khác với card trên Home (nền tối). Cần tạo variant hoặc parameterize widget hiện tại.
- **Font size**: Đã xác nhận giữ theo Figma (10px). Code cho màn hình này KHÔNG dùng chung font size với Home screen.
- **Sender/Receiver layout cột**: Figma hiện layout **cột** (avatar → name → dept+badge xếp dọc, width: 109px). Cần tạo widget mới — KHÔNG tái sử dụng `_SenderReceiverHeader` (layout hàng) từ Home.
- **Card width responsive**: `screenWidth - 2 * 20px` thay vì 274px cố định. Các child elements bên trong card tự stretch theo.
- Badge danh hiệu (Rising Hero, Legend Hero) sử dụng nhiều layer gradient background — có thể cần image asset thay vì render bằng code.
- **Bottom Navigation Bar**: SCREENFLOW xác nhận có bottom nav trên màn hình này nhưng Figma frame không hiển thị rõ. Giả định có — tái sử dụng bottom nav component chung.
