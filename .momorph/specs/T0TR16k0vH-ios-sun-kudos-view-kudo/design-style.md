# Design Style: [iOS] Sun*Kudos_View kudo

**Frame ID**: `T0TR16k0vH`
**Frame Name**: `[iOS] Sun*Kudos_View kudo`
**Figma File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-14

---

## Design Tokens

### Màu sắc

| Tên Token | Giá trị Hex/RGBA | Opacity | Sử dụng |
|-----------|-----------------|---------|---------|
| --color-background | `#00101A` | 100% | Nền chính toàn màn hình |
| --color-surface-card | `#FFF8E1` | 100% | Nền card kudos detail |
| --color-primary | `#FFEA9E` | 100% | Border card, divider trong card, accent |
| --color-primary-40 | `rgba(255, 234, 158, 0.40)` | 40% | Nền khung nội dung kudos |
| --color-border | `#998C5F` | 100% | Border hình ảnh đính kèm |
| --color-text-primary | `#FFFFFF` | 100% | Text chính trên nền tối (tiêu đề nav) |
| --color-text-dark | `#00101A` | 100% | Text trên card sáng (nội dung, tên, action) |
| --color-text-secondary | `#999999` | 100% | Text phòng ban, thời gian đăng |
| --color-text-hashtag | `#D4271D` | 100% | Text hashtag |
| --color-heart | `#F17676` | 100% | Icon heart (filled state) |
| --color-avatar-border | `#FFFFFF` | 100% | Border avatar tròn |

### Typography

| Tên Token | Font Family | Size | Weight | Line Height | Letter Spacing |
|-----------|-------------|------|--------|-------------|----------------|
| --text-nav-title | Helvetica Neue | 17px | 500 | 24px | 0.5px |
| --text-kudo-title | Montserrat | 10px | 700 | 11.1px | 0.23px |
| --text-sender-name | Montserrat | 10px | 400 | 16px | 0% |
| --text-department | Montserrat | 10px | 500 | 9.26px | 0.046px |
| --text-badge | Montserrat | 6px | 700 | 7.5px | 0.038px |
| --text-timestamp | Montserrat | 10px | 500 | 11.1px | 0.23px |
| --text-content | Montserrat | 10px | 400 | 14px | 0px |
| --text-hashtag | Montserrat | 10px | 400 | 11.1px | 0.23px |
| --text-action | Montserrat | 10px | 500 | 11.1px | 0.069px |
| --text-heart-count | Montserrat | 10px | 400 | 14.8px | 0px |

### Spacing

| Tên Token | Giá trị | Sử dụng |
|-----------|---------|---------|
| --spacing-xs | 4px | Gap items trong badge, gap hình ảnh |
| --spacing-sm | 8px | Padding card, gap giữa sections trong card |
| --spacing-md | 12px | Padding horizontal card |
| --spacing-lg | 24px | Gap giữa card và content sections |

### Border & Radius

| Tên Token | Giá trị | Sử dụng |
|-----------|---------|---------|
| --radius-card | 8px | Border radius card kudos |
| --radius-avatar | 24px | Avatar tròn |
| --radius-content-frame | 5.554px | Khung nội dung kudos |
| --radius-image | 8.043px | Thumbnail hình ảnh đính kèm |
| --radius-badge | 22.217px | Badge danh hiệu |
| --border-card | 1px solid #FFEA9E | Border card chính |
| --border-content | 0.463px solid #FFEA9E | Border khung nội dung |
| --border-avatar | 0.865px solid #FFFFFF | Border avatar |
| --border-image | 0.447px solid #998C5F | Border thumbnail |
| --border-badge | 0.231px solid #FFEA9E | Border badge danh hiệu |

---

## Layout Specifications

### Container

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| width | 375px | iPhone standard |
| height | 924px | Full screen |
| background | #00101A | Nền tối |

### Card Kudos Detail (B.3)

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| width | 335px | Card width |
| padding | 8px 12px | Padding trong card |
| background | #FFF8E1 | Nền vàng nhạt |
| border | 1px solid #FFEA9E | Border vàng |
| border-radius | 8px | Bo góc |
| gap | 8px | Khoảng cách giữa sections |

### Cấu trúc Layout (ASCII)

```
┌─────────────────────────────────────────┐ 375px
│  Top Navigation (gradient overlay)       │
│  ┌──────┐  ┌────────┐                   │
│  │ Back │  │ "Kudo" │                   │
│  └──────┘  └────────┘                   │
│                                          │
│  ┌─ Card B.3 (335px) ──────────────────┐│
│  │ ┌────────┐  →  ┌────────┐          ││
│  │ │ Sender │     │Receiver│          ││
│  │ │ Avatar │     │ Avatar │          ││
│  │ │ + Info │     │ + Info │          ││
│  │ └────────┘     └────────┘          ││
│  │ ─── divider (#FFEA9E) ─────────── ││
│  │ Thời gian: 10:00 - 10/30/2025      ││
│  │ Tiêu đề: NGƯỜI HÙNG CỦA LÒNG EM   ││
│  │ ┌─ Nội dung (border frame) ───────┐││
│  │ │  Full text nội dung kudos        │││
│  │ │  (scrollable nếu dài)           │││
│  │ └─────────────────────────────────┘││
│  │ [img][img][img][img][img]           ││
│  │ #Dedicated #Inspiring ...           ││
│  │ ─── divider (#FFEA9E) ─────────── ││
│  │ 10 ❤  |  Copy Link  |  Xem chi tiết││
│  └──────────────────────────────────────┘│
│                                          │
│  ┌─────────── Nav Bar ─────────────────┐│
│  │ SAA 2025 │ Awards │ Kudos* │Profile ││
│  └──────────────────────────────────────┘│
└──────────────────────────────────────────┘
```

---

## Chi tiết Style từng Component

### Top Navigation

| Thuộc tính | Giá trị |
|-----------|---------|
| **Position** | Fixed top, z-index cao |
| **Background** | linear-gradient(180deg, #00101A → transparent) opacity 0.9 |
| **Height** | 89px (47px status bar + 42px nav content) |
| **Back icon** | 24x24px, SVG, padding 7px 9px 9px 9px |
| **Title "Kudo"** | Helvetica Neue, 17px, 500, #FFFFFF, center |

### Sender/Receiver Info Row (trao nhận)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Layout** | Row, justify-content: space-between, width 311px |
| **Avatar** | 24x24px, circle (border-radius: 24px), border 0.865px solid #FFF |
| **Tên** | Montserrat 10px/16px, weight 400, color #00101A, width 109px |
| **Phòng ban** | Montserrat 10px/9.26px, weight 500, color #999999 |
| **Badge danh hiệu** | 45x9px, border-radius 22.217px, border 0.231px solid #FFEA9E |
| **Badge text** | Montserrat 6px/7.5px, weight 700, color #FFF, text-shadow |
| **Icon mũi tên** | 16x16px, center, padding vertical 7.4px |

### Nội dung Kudos (B.4)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Tiêu đề** | Montserrat 10px/11.1px, weight 700, color #00101A, text-align center, letter-spacing 0.23px |
| **Thời gian** | Montserrat 10px/11.1px, weight 500, color #999999, letter-spacing 0.23px |
| **Khung nội dung** | border 0.463px solid #FFEA9E, background rgba(255,234,158,0.40), border-radius 5.554px, padding 4px |
| **Text nội dung** | Montserrat 10px/14px, weight 400, color #00101A, text-align justified |
| **Divider** | height 0px (line), background #FFEA9E, width 311px |

### Hình ảnh đính kèm (F.2)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Layout** | Row, gap 4px |
| **Thumbnail size** | 32x32px |
| **Border** | 0.447px solid #998C5F |
| **Border-radius** | 8.043px |
| **Background** | #FFF |
| **Image fit** | cover, border-radius 1.787px |

### Hashtag (B.4.3)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Text** | Montserrat 10px/11.1px, weight 400, letter-spacing 0.23px |
| **Color** | #D4271D |
| **Width** | 311px (full card width) |
| **Max lines** | 2 (truncate với "...") |

### Action Bar (B.4.4)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Layout** | Row, justify-content: space-between, width 311px |
| **Heart count text** | Montserrat 10px/14.8px, weight 400, color #00101A |
| **Heart icon** | 16x16px, SVG |
| **Copy Link** | Montserrat 10px/11.1px, weight 500, color #00101A, padding 4px |
| **Copy Link icon** | 16x16px, SVG |
| **Xem chi tiết** | Montserrat 10px/11.1px, weight 500, color #00101A, padding 4px |
| **Arrow icon** | 16x16px, SVG |

### Nav Bar

| Thuộc tính | Giá trị |
|-----------|---------|
| **Height** | 72px |
| **Background** | rgba(255, 234, 158, 0.15), backdrop-filter blur(20px) |
| **Border-radius** | 20px 20px 0 0 |
| **Tab active color** | #FFEA9E (Kudos tab) |
| **Tab inactive color** | #FFFFFF |
| **Tab font** | Montserrat 12px/16px, weight 400 |

---

## Component States

### Heart Icon States

| Trạng thái | Icon | Color | Ghi chú |
|-----------|------|-------|---------|
| Chưa thích (outlined) | ic_heart | #00101A | Viền heart, không fill |
| Đã thích (filled) | ic_heart_filled | #F17676 | Fill hồng đỏ |
| Đang xử lý (loading) | ic_heart | #999999 (opacity 50%) | Disabled trong khi gửi request |

### Toast/Snackbar "Đã sao chép liên kết"

| Thuộc tính | Giá trị |
|-----------|---------|
| **Position** | Bottom center, trên Nav Bar, margin-bottom 88px |
| **Background** | rgba(0, 16, 26, 0.85) |
| **Border-radius** | 8px |
| **Padding** | 12px 16px |
| **Text** | Montserrat 14px/20px, weight 500, color #FFFFFF |
| **Duration** | 2 giây, fade-out |

### Loading State (Shimmer)

| Thuộc tính | Giá trị |
|-----------|---------|
| **Shimmer base color** | rgba(255, 234, 158, 0.10) |
| **Shimmer highlight color** | rgba(255, 234, 158, 0.25) |
| **Card placeholder** | 335px width, 400px height, border-radius 8px |

### Error State

| Thuộc tính | Giá trị |
|-----------|---------|
| **Text** | Montserrat 14px/20px, weight 400, color #999999, text-align center |
| **Retry button** | Montserrat 14px/20px, weight 500, color #FFEA9E, padding 8px 16px |

---

## Icon Specifications

| Icon Name | Size | Sử dụng | Format |
|-----------|------|---------|--------|
| ic_back | 24x24px | Nút quay lại | SVG |
| ic_sent_arrow | 16x16px | Icon "sent" giữa sender/receiver | SVG |
| ic_heart / ic_heart_filled | 16x16px | Heart toggle | SVG |
| ic_copy_link | 16x16px | Nút copy link | SVG |
| ic_arrow_right | 16x16px | Mũi tên "Xem chi tiết" | SVG |

---

## Background

| Thuộc tính | Giá trị |
|-----------|---------|
| Key Visual BG | 881.27 x 722.72px, cover, opacity phía sau |
| Shadow Left | linear-gradient(90deg, #00101A 0.07%, #10181F 18.61%, transparent 77.2%) |
| Shadow Bottom | linear-gradient(90deg, #00101A 0%, #00101A 25.41%, transparent 100%), rotate(-90deg) |

---

## Ghi chú

- Design chung dark theme với card sáng (#FFF8E1) — giống Highlight Card trên Kudos feed.
- Tất cả icons PHẢI dùng SVG format.
- Asset paths PHẢI dùng `flutter_gen` (`Assets.xxx`).
- Màn hình này chia sẻ cùng design tokens với màn hình chính Kudos (`fO0Kt19sZZ`).
