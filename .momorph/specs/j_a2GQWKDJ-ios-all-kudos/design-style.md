# Design Style: [iOS] Sun*Kudos — All Kudos

**Frame ID**: `j_a2GQWKDJ`
**Frame Name**: `[iOS] Sun*Kudos_All Kudos`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-14

---

## Design Tokens

### Màu sắc

| Token | Hex | Opacity | Sử dụng |
|-------|-----|---------|---------|
| --color-bg-screen | #00101A | 100% | Nền màn hình chính |
| --color-card-bg | #FFF8E1 | 100% | Nền thẻ Kudo (highlight) |
| --color-primary-gold | #FFEA9E | 100% | Tiêu đề section, viền thẻ, divider trong thẻ |
| --color-content-bg | rgba(255, 234, 158, 0.40) | 40% | Nền khung nội dung lời cảm ơn |
| --color-text-dark | #00101A (rgba(0,16,26,1)) | 100% | Text chính trong thẻ (tên, nội dung, title) |
| --color-text-white | #FFFFFF | 100% | Text trên nền tối (navbar, header) |
| --color-text-secondary | #999999 (rgba(153,153,153,1)) | 100% | Text phụ (mã nhân viên, thời gian) |
| --color-hashtag | #D4271D (rgba(212,39,29,1)) | 100% | Hashtag text |
| --color-divider-header | #2E3940 (rgba(46,57,64,1)) | 100% | Đường kẻ ngang header |
| --color-card-border | #FFEA9E | 100% | Viền thẻ kudo |
| --color-content-border | #FFEA9E | 100% | Viền khung nội dung |
| --color-divider-card | #FFEA9E | 100% | Đường kẻ phân cách trong thẻ |
| --color-gradient-top | linear-gradient(180deg, #00101A → transparent) | 90% opacity | Gradient TopNavigation |

### Typography

| Token | Font Family | Size | Weight | Line Height | Letter Spacing | Sử dụng |
|-------|-------------|------|--------|-------------|----------------|---------|
| --text-navbar-title | Helvetica Neue | 17px | 500 | 24px | — | Tiêu đề "All Kudos" trên navbar |
| --text-header-subtitle | Montserrat | 12px | 400 | 16px | 0% | "Sun* Annual Awards 2025" |
| --text-section-title | Montserrat | 22px | 500 | 28px | — | "ALL KUDOS" |
| --text-sender-name | Montserrat | 10px | 400 | 16px | — | Tên người gửi/nhận |
| --text-employee-code | Montserrat | 10px | 500 | ~9.26px | — | Mã nhân viên (CECV10) |
| --text-badge-label | — | — | — | — | — | Label badge (Rising Hero, Legend Hero) |
| --text-post-time | Montserrat | 10px | 500 | ~11.11px | — | Thời gian đăng |
| --text-kudos-title | Montserrat | 10px | 700 | ~11.11px | — | Tiêu đề kudos (VD: "IDOL GIỚI TRẺ") |
| --text-content | Montserrat | 10px | 400 | 14px | — | Nội dung lời cảm ơn |
| --text-hashtag | Montserrat | 10px | 400 | ~11.11px | — | Hashtag (#Dedicated) |
| --text-heart-count | Montserrat | 10px | 400 | ~14.81px | — | Số lượt heart |
| --text-action-btn | Montserrat | 10px | 500 | ~11.11px | — | Nút hành động (Copy Link, Xem chi tiết) |

### Spacing

| Token | Giá trị | Sử dụng |
|-------|---------|---------|
| --spacing-screen-padding-x | 20px | Padding ngang màn hình (tính từ vị trí header) |
| --spacing-header-gap | 4px | Khoảng cách giữa các phần trong header |
| --spacing-card-padding | 8px 12px | Padding bên trong thẻ kudo |
| --spacing-card-gap | 8px | Khoảng cách giữa các section trong thẻ |
| --spacing-list-gap | 12px | Khoảng cách giữa các thẻ kudo |
| --spacing-sender-info-gap | 4px | Khoảng cách trong thông tin người gửi |
| --spacing-trao-nhan-gap | 8px | Khoảng cách giữa sender → arrow → receiver |
| --spacing-content-padding | 4px | Padding khung nội dung |
| --spacing-action-gap | ~11.11px | Khoảng cách giữa các nút action |
| --spacing-button-padding | 4px | Padding nút action |
| --spacing-button-icon-gap | 4px | Khoảng cách icon-text trong nút |

### Border & Radius

| Token | Giá trị | Sử dụng |
|-------|---------|---------|
| --radius-avatar | 50% (circle) | Avatar người gửi/nhận (ELLIPSE) |
| --radius-card | 0px | Thẻ kudo (không bo góc) |
| --radius-action-btn | 2px | Nút hành động |
| --radius-badge | (theo design badge) | Badge danh hiệu |
| --border-card | 1px solid #FFEA9E | Viền thẻ kudo |
| --border-avatar | 0.865px solid #FFF | Viền avatar |
| --border-content | 0.463px solid #FFEA9E | Viền khung nội dung |
| --border-badge | 0.231px solid #FFEA9E | Viền badge danh hiệu |
| --border-divider | 1px | Đường kẻ phân cách (height: 0, dùng background color) |

---

## Layout Specifications

### Container

| Thuộc tính | Giá trị | Ghi chú |
|------------|---------|---------|
| width | 375px | Thiết kế cho iPhone (mobile-only) |
| height | dynamic (1338px trong design) | Scroll dọc |
| background | #00101A | Nền tối |

### Grid/Flex Layout

| Thuộc tính | Giá trị | Ghi chú |
|------------|---------|---------|
| display | flex | Layout chính |
| flex-direction | column | Xếp dọc |
| align-items | center | Căn giữa ngang |

### Cấu trúc Layout (ASCII)

```
┌─────────────────────────────────────────────┐ 375px
│ Screen (bg: #00101A)                        │
│                                             │
│ ┌─────────────────────────────────────────┐ │
│ │ TopNavigation (gradient, opacity: 0.9)  │ │ h: 89px
│ │ ┌─────────────────────────────────────┐ │ │
│ │ │ StatusBar                    47px   │ │ │
│ │ ├─────────────────────────────────────┤ │ │
│ │ │ ← Back    "All Kudos"       42px   │ │ │
│ │ └─────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────┘ │
│                                             │
│ ┌──── mm_media_bg (background layer) ─────┐ │
│ │ Key Visual + Shadows (absolute pos)     │ │
│ └─────────────────────────────────────────┘ │
│                                             │
│ ┌─ header (336px, gap: 4px) ──────────────┐ │
│ │ "Sun* Annual Awards 2025"  12px/400     │ │
│ │ ────────────────── (divider 1px)        │ │
│ │ "ALL KUDOS"  22px/500  gold             │ │
│ └─────────────────────────────────────────┘ │
│                                             │
│ ┌─ Danh sách Kudo (274px, gap: 12px) ─────┐ │
│ │                                         │ │
│ │ ┌─ KUDO Card (p: 8px 12px) ───────────┐ │ │
│ │ │ ┌── trao nhận (250px, h: 62px) ────┐ │ │ │
│ │ │ │ [Avatar+Info] → [Arrow] → [Info] │ │ │ │
│ │ │ └─────────────────────────────────┘ │ │ │
│ │ │ ── divider (gold, 250px) ──         │ │ │
│ │ │ ┌── Nội dung (250px) ──────────────┐│ │ │
│ │ │ │ Thời gian: "10:00 - 10/30/2025" ││ │ │
│ │ │ │ Title: "IDOL GIỚI TRẺ"          ││ │ │
│ │ │ │ ┌─ Content box (bg: gold/40%) ─┐ ││ │ │
│ │ │ │ │ "Cảm ơn người em..."         │ ││ │ │
│ │ │ │ └─────────────────────────────┘ ││ │ │
│ │ │ │ "#Dedicated #Inspiring..."       ││ │ │
│ │ │ └─────────────────────────────────┘│ │ │
│ │ │ ── divider (gold, 250px) ──         │ │ │
│ │ │ ┌── Action (250px, h: 24px) ──────┐│ │ │
│ │ │ │ [Heart 1.000] [Copy] [Chi tiết] ││ │ │
│ │ │ └─────────────────────────────────┘│ │ │
│ │ └─────────────────────────────────────┘ │ │
│ │                                         │ │
│ │ ┌─ KUDO Card ─────────────────────────┐ │ │
│ │ │ (Cùng cấu trúc như trên)            │ │ │
│ │ └─────────────────────────────────────┘ │ │
│ │ ... (lặp lại cho mỗi kudos)            │ │
│ └─────────────────────────────────────────┘ │
│                                             │
│ ┌─ Bottom Navigation Bar ─────────────────┐ │
│ │ [Home] [Kudos] [SAA] [Ranking] [Me]     │ │
│ └─────────────────────────────────────────┘ │
└─────────────────────────────────────────────┘
```

---

## Chi tiết Style theo Component

### TopNavigation

| Thuộc tính | Giá trị | Ghi chú |
|------------|---------|---------|
| **Node ID** | 6891:16000 | — |
| width | 375px | Full width |
| height | 89px (47px StatusBar + 42px Content) | — |
| background | linear-gradient(180deg, #00101A → transparent) | Gradient fade |
| opacity | 0.9 | — |
| position | absolute, z-index: 1 | Nổi trên background |

### _TopNavigation-content

| Thuộc tính | Giá trị | Ghi chú |
|------------|---------|---------|
| **Node ID** | 6891:16002 | — |
| width | 375px | — |
| height | 42px | — |
| Nút Back (←) | icon chevron-left, màu trắng | Quay lại Kudos screen |
| Title text | "All Kudos" - Helvetica Neue 17px/500, #FFF | Căn giữa |

### Header Section

| Thuộc tính | Giá trị | Ghi chú |
|------------|---------|---------|
| **Node ID** | 6891:16644 | INSTANCE |
| width | 336px | — |
| height | 53px | — |
| padding | 0px | — |
| gap | 4px | Khoảng cách giữa subtitle, divider, title |
| display | flex | — |
| flex-direction | column | — |
| align-items | flex-start | — |

#### Header — Subtitle

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | I6891:16644;75:1884 |
| text | "Sun* Annual Awards 2025" |
| font | Montserrat 12px/400, line-height: 16px |
| color | #FFFFFF |

#### Header — Divider

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | I6891:16644;75:1885 |
| width | 336px |
| height | 1px |
| background | #2E3940 |

#### Header — Section Title

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | I6891:16644;75:1887 |
| text | "ALL KUDOS" |
| font | Montserrat 22px/500, line-height: 28px |
| color | #FFEA9E (gold) |

### Danh sách Kudo (List Container)

| Thuộc tính | Giá trị | Ghi chú |
|------------|---------|---------|
| **Node ID** | 6891:16170 | — |
| width | 274px | — |
| height | dynamic (1060px trong design với 4 cards) | — |
| gap | 12px | Khoảng cách giữa các thẻ |
| display | flex | — |
| flex-direction | column | — |
| align-items | center | — |

### KUDO Card (mms_B.3_KUDO - Highlight)

| Thuộc tính | Giá trị | Ghi chú |
|------------|---------|---------|
| **Node IDs** | 6891:16171, 6891:16172, 6891:16173, 6891:16578 | 4 cards mẫu |
| background | #FFF8E1 | Nền vàng nhạt |
| padding | 8px 12px | — |
| gap | 8px | Khoảng cách giữa sections bên trong |
| border | 1px solid #FFEA9E | Viền vàng gold |
| display | flex | — |
| flex-direction | column (implied) | — |

#### B.3 — Trao nhận (Sender → Receiver)

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | I6891:16171;89:2950 |
| width | 250px |
| height | 62px |
| display | flex, row |
| gap | 8px |
| align-items | center |

##### B.3.1 / B.3.5 — Avatar (Sender / Receiver)

| Thuộc tính | Giá trị |
|------------|---------|
| **Node IDs** | 89:2598 (sender), 89:2717 (receiver) |
| Kích thước | 24x24px |
| Shape | ELLIPSE (circle) |
| border | 0.865px solid #FFF |
| background | url(image) cover |

##### B.3.2 — Thông tin người gửi/nhận

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | 89:2599 |
| width | 109px |
| height | 30px |
| gap | 4px |
| flex-direction | column |
| **Tên**: | Montserrat 10px/400, lh: 16px, color: #00101A |
| **Mã NV**: | Montserrat 10px/500, lh: ~9.26px, color: #999 |
| **Dot separator**: | 2x2px circle, #999 |
| **Badge danh hiệu**: | 45x9px, border: 0.231px solid #FFEA9E |

##### B.3.4 — Icon mũi tên

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | 89:2952 |
| width | 16px |
| height | 62px (full height, icon centered) |
| Icon size | 16x16px |

#### Divider trong thẻ

| Thuộc tính | Giá trị |
|------------|---------|
| **Node IDs** | 89:2955, 89:2971 |
| width | 250px |
| height | 0px (dùng border hoặc thin line) |
| color | #FFEA9E |

#### B.4 — Nội dung lời cảm ơn

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | 89:2956 |
| width | 250px |
| gap | 8px |
| flex-direction | column |
| align-items | flex-end |

##### B.4.1 — Thời gian đăng

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | 89:2957 |
| font | Montserrat 10px/500, lh: ~11.11px |
| color | #999999 |
| Mẫu | "10:00 - 10/30/2025" |

##### Tiêu đề Kudos (vd: "IDOL GIỚI TRẺ")

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | 89:2958 |
| font | Montserrat 10px/700, lh: ~11.11px |
| color | #00101A |

##### B.4.2 — Nội dung (Content Box)

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | 89:2959 |
| Container (89:2960) | bg: rgba(255,234,158,0.40), padding: 4px, border: 0.463px solid #FFEA9E |
| Text | Montserrat 10px/400, lh: 14px, color: #00101A |
| Max lines | ~3 dòng (truncate với "...") |

##### B.4.3 — Hashtag

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | 89:2969 |
| font | Montserrat 10px/400, lh: ~11.11px |
| color | #D4271D (đỏ) |
| Max lines | ~2 dòng (truncate) |

#### B.4.4 — Action Bar

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | 89:2972 |
| width | 250px |
| height | 24px |
| display | flex, row |
| gap | ~11.11px |
| align-items | center |

##### Hearts

| Thuộc tính | Giá trị |
|------------|---------|
| **Node ID** | 89:2973 |
| Layout | flex, row, gap: ~1.85px |
| Text "1.000" | Montserrat 10px/400, lh: ~14.81px, color: #00101A |
| Icon heart | 16x16px |

##### Buttons (Copy Link, Xem chi tiết)

| Thuộc tính | Giá trị |
|------------|---------|
| **Node IDs** | 89:3019 (Copy Link), 89:3026 (Xem chi tiết) |
| height | 24px |
| padding | 4px |
| border-radius | 2px |
| display | flex, row, gap: 4px |
| Text | Montserrat 10px/500, lh: ~11.11px, color: #00101A |
| Icon | 16x16px (copy icon / arrow icon) |

---

## Cấu trúc phân cấp Component

```
Screen (bg: #00101A, 375×dynamic)
├── mm_media_bg (absolute - background key visual + shadows)
│   ├── Shadow Left (gradient left → transparent)
│   ├── MM_MEDIA_Keyvisual BG (image)
│   └── Shadow Bottom (gradient bottom)
│
├── TopNavigation (absolute, z:1, gradient, opacity: 0.9)
│   ├── StatusBar (47px)
│   └── _TopNavigation-content (42px)
│       ├── Back button (← icon, #FFF)
│       └── Title "All Kudos" (Helvetica Neue 17px/500, #FFF)
│
├── header (336px, flex-col, gap: 4px)
│   ├── Subtitle "Sun* Annual Awards 2025" (12px/400, #FFF)
│   ├── Divider (1px, #2E3940)
│   └── Section Title "ALL KUDOS" (22px/500, #FFEA9E)
│
└── Danh sách Kudo (274px, flex-col, gap: 12px)
    └── KUDO Card × N (bg: #FFF8E1, border: 1px #FFEA9E, p: 8px 12px)
        ├── trao nhận (flex-row, 250px, h: 62px, gap: 8px)
        │   ├── Infor Sender (flex-col, 109px, gap: 8px)
        │   │   ├── Avatars (24×24px circle, border: 0.865px #FFF)
        │   │   └── Info (name + code + badge)
        │   ├── Arrow Icon (16×16px centered)
        │   └── Infor Receiver (same as Sender)
        │
        ├── Divider (250px, #FFEA9E)
        │
        ├── Nội dung (flex-col, 250px, gap: 8px)
        │   ├── Thời gian "10:00 - 10/30/2025" (10px/500, #999)
        │   ├── Title "IDOL GIỚI TRẺ" (10px/700, #00101A)
        │   ├── Content Box (bg: gold/40%, border: #FFEA9E)
        │   │   └── Text nội dung (10px/400, #00101A)
        │   └── Hashtags (10px/400, #D4271D)
        │
        ├── Divider (250px, #FFEA9E)
        │
        └── Action Bar (flex-row, 250px, h: 24px)
            ├── Hearts (icon + "1.000")
            └── Buttons
                ├── [Copy Link] (icon + text, r: 2px)
                └── [Xem chi tiết] (icon + text, r: 2px)
```

---

## Icon Specifications

| Icon | Kích thước | Màu | Sử dụng |
|------|-----------|------|---------|
| ic_back (chevron-left) | 24x24 | #FFFFFF | Nút quay lại trên navbar |
| ic_arrow_right | 16x16 | #00101A | Mũi tên sender → receiver |
| ic_heart | 16x16 | (theo state) | Nút like/heart |
| ic_copy_link | 16x16 | #00101A | Nút copy link |
| ic_arrow_detail | 16x16 | #00101A | Nút xem chi tiết |

---

## Animation & Transitions

| Element | Thuộc tính | Duration | Easing | Trigger |
|---------|------------|----------|--------|---------|
| PageView transition | page animation | 300ms | ease-in-out | Tap "Xem tất cả" từ Kudos screen |
| Heart button | scale + color | 200ms | ease-out | Tap heart |
| Card appear | opacity + translateY | 150ms | ease-out | Scroll into view (optional) |

---

## Ghi chú

- Tất cả màu sắc PHẢI dùng theme tokens, không hardcode hex trực tiếp trong widget.
- Font chính là **Montserrat** cho content, **Helvetica Neue** cho navbar.
- Đây là thiết kế **mobile-only** (375px), không có responsive breakpoints khác.
- Background key visual là ảnh tĩnh với shadows overlay, reuse từ Kudos screen chính.
- Thẻ Kudo card trong All Kudos dùng cùng component `KUDO - Highlight` như trong Kudos screen chính.
- PageView **KHÔNG cho phép swipe** — chỉ animate khi tap "Xem tất cả" từ Kudos screen.
- Icons **PHẢI** dùng SVG format qua `flutter_svg` và truy cập qua `Assets.icons.*`.
