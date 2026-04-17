# Design Style: [iOS] Sun*Kudos - Màn hình chính Kudos

**Frame ID**: `fO0Kt19sZZ`
**Frame Name**: `[iOS] Sun*Kudos`
**Figma File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-13
**Ngày cập nhật**: 2026-04-16

---

## Design Tokens

### Màu sắc

| Tên Token | Giá trị Hex/RGBA | Opacity | Sử dụng |
|-----------|-----------------|---------|---------|
| --color-background | `rgba(0, 16, 26, 1)` / `#00101A` | 100% | Nền chính toàn màn hình |
| --color-surface-dark | `#00070C` | 100% | Nền card thống kê (D.1) |
| --color-surface-card | `#FFF8E1` | 100% | Nền thẻ Highlight Kudos |
| --color-primary | `#FFEA9E` | 100% | Màu accent chính (vàng) — tiêu đề, text highlight, border |
| --color-primary-10 | `rgba(255, 234, 158, 0.10)` | 10% | Nền button CTA, nền dropdown filter |
| --color-primary-15 | `rgba(255, 234, 158, 0.15)` | 15% | Nền hover/active nhẹ |
| --color-primary-40 | `rgba(255, 234, 158, 0.40)` | 40% | Accent trung bình |
| --color-border | `#998C5F` | 100% | Border cho button, card, dropdown |
| --color-text-primary | `rgba(255, 255, 255, 1)` / `#FFFFFF` | 100% | Text chính trên nền tối |
| --color-text-accent | `rgba(255, 234, 158, 1)` / `#FFEA9E` | 100% | Text highlight (tagline, tiêu đề section, số liệu) |
| --color-text-secondary | `rgba(153, 153, 153, 1)` / `#999999` | 100% | Text phụ, thời gian |
| --color-text-dark | `rgba(0, 16, 26, 1)` / `#00101A` | 100% | Text trên card sáng (Highlight card) |
| --color-divider | `rgba(46, 57, 64, 1)` / `#2E3940` | 100% | Đường kẻ phân cách section |
| --color-error | `rgba(212, 39, 29, 1)` / `#D4271D` | 100% | Notification badge |
| --color-heart | `rgba(241, 118, 118, 1)` / `#F17676` | 100% | Icon heart |
| --color-overlay-dark | `rgba(0, 16, 26, 0.50)` / `#09243280` | 50% | Overlay gradient |

### Typography

| Tên Token | Font Family | Size | Weight | Line Height | Letter Spacing |
|-----------|-------------|------|--------|-------------|----------------|
| --text-section-title | Montserrat | 22px | 500 | 28px | 0% |
| --text-body | Montserrat | 14px | 500 | 20px | 0px |
| --text-body-regular | Montserrat | 14px | 400 | 20px | 0px |
| --text-body-bold | Montserrat | 14px | 700 | 20px | 0.25px |
| --text-caption | Montserrat | 12px | 400 | 16px | 0% |
| --text-small | Montserrat | 10px | 400 | 12.77px | 0px |
| --text-button | Montserrat | 14px | 500 | 20px | 0px |
| --text-status-bar | SF Pro Text | 15px | 600 | 20px | -0.5px |
| --text-language | Montserrat | 14px | 500 | 20px | 0px |
| --text-spotlight-name | Montserrat | 8px (default) / 10px (highlighted) | 700 | auto | 0.06px |

### Spacing

| Tên Token | Giá trị | Sử dụng |
|-----------|---------|---------|
| --spacing-xs | 4px | Gap nhỏ (language country icon) |
| --spacing-sm | 8px | Gap giữa items trong card, padding nhỏ |
| --spacing-md | 10px | Padding button CTA |
| --spacing-lg | 12px | Padding card thống kê, gap giữa stat rows |
| --spacing-xl | 16px | Gap filter dropdowns, gap giữa elements |
| --spacing-2xl | 20px | Gap giữa kudos cards trong feed |
| --spacing-3xl | 24px | Gap giữa sections chính |
| --spacing-4xl | 32px | Gap slide indicator padding |

### Border & Radius

| Tên Token | Giá trị | Sử dụng |
|-----------|---------|---------|
| --radius-none | 0px | Container chính, frames |
| --radius-xs | 2px | Elements nhỏ |
| --radius-sm | 4px | Language dropdown, dropdown filter |
| --radius-md | 8px | Card thống kê (D.1) |
| --radius-lg | 24px | Status bar time |
| --radius-full | 100px | Notification badge dot |
| --border-width | 1px | Border button CTA, dropdown, highlight card |
| --border-width-thin | 0.794px | Border card thống kê |
| --border-width-spotlight | 0.29px | Border spotlight section |

### Shadows

| Tên Token | Giá trị | Sử dụng |
|-----------|---------|---------|
| --shadow-none | none | Phần lớn components (flat design) |

> **Ghi chú**: Thiết kế sử dụng gradient overlays thay vì box-shadow truyền thống.

### Gradients

| Tên | Giá trị | Sử dụng |
|-----|---------|---------|
| --gradient-header | `linear-gradient(180deg, #00101A 0%, rgba(0,16,26,0.30) 76.44%, rgba(0,16,26,0.00) 100%)` | Header fade-out |
| --gradient-carousel-next | `linear-gradient(270deg, #00101A 5.71%, rgba(0,16,26,0.50) 45.81%, rgba(255,255,255,0.00) 85.92%)` | Carousel cạnh phải |
| --gradient-shadow-left | `linear-gradient(90deg, #00101A 0.07%, #10181F 18.61%, rgba(0,16,26,0.00) 77.2%)` | Hero banner shadow trái |
| --gradient-shadow-bottom | `linear-gradient(90deg, #00101A 0%, #00101A 25.41%, rgba(0,16,26,0.00) 100%)` | Hero banner shadow dưới |

---

## Layout Specifications

### Container

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| width | 375px | iPhone standard |
| height | 2601px (scrollable) | Full content height |
| background | `#00101A` | Dark theme |
| overflow | scroll | Vertical scroll |

### Layout chính

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| display | flex | Column layout |
| flex-direction | column | Vertical stacking |
| position | relative | Cho absolute children |

### Layout Structure (ASCII)

```
┌─────────────────────────────────────────────── 375px ──────────────────────────────────────────┐
│  Header (h: 104px, position: absolute, z-index: 1)                                             │
│  ┌─ StatusBar (44px) ──────────────────────────────────────────────────────────────────────┐    │
│  │  [9:41]                                              [Signal] [WiFi] [Battery]          │    │
│  └────────────────────────────────────────────────────────────────────────────────────────── │    │
│  ┌─ Nav Row (60px) ───────────────────────────────────────────────────────────────────────┐    │
│  │  [Logo 48x44]     ...gap...      [🇻🇳 VN ▾] [🔍] [🔔•]                               │    │
│  └────────────────────────────────────────────────────────────────────────────────────────── │    │
│                                                                                              │
│  ═══════════════════════ Hero Banner Background (812px) ════════════════════════════════      │
│  ┌─ A. KV Kudos (221x67, gap: 8px) ──────────────────────────────────────────────────────┐  │
│  │  "Hệ thống ghi nhận và cảm ơn" (14px/500, color: #FFEA9E)                             │  │
│  │  [Sun* KUDOS Logo (221x39)]                                                            │  │
│  └────────────────────────────────────────────────────────────────────────────────────────── │  │
│                                                                                              │
│  ┌─ A.1. Button CTA (335x40, border: 1px #998C5F, bg: rgba(255,234,158,0.10)) ──────────┐  │
│  │  [✏️ icon 24x24]  " Hôm nay, bạn muốn gửi kudos đến ai?" (14px/500, white)            │  │
│  └────────────────────────────────────────────────────────────────────────────────────────── │  │
│  ═══════════════════════════════════════════════════════════════════════════════════════════  │
│                                                                                              │
│  ┌─ B. Highlight Section (335x389, gap: 24px) ──────────────────────────────────────────┐   │
│  │  ┌─ B.1. Header (335x109, gap: 16px) ──────────────────────────────────────────────┐ │   │
│  │  │  "Sun* Annual Awards 2025" (12px/400, white)                                    │ │   │
│  │  │  ──────────────────── divider (#2E3940, 1px) ───────────────────────────          │ │   │
│  │  │  "HIGHLIGHT KUDOS" (22px/500, #FFEA9E)                                           │ │   │
│  │  │  ┌── Filter (266x40, gap: 8px) ──────────────────────────────────────────────┐   │ │   │
│  │  │  │  [Hashtag ▾ (129px)]  [Phòng ban ▾]                                       │   │ │   │
│  │  │  │  border: 1px #998C5F, bg: rgba(255,234,158,0.10), padding: 8px             │   │ │   │
│  │  │  └────────────────────────────────────────────────────────────────────────────┘   │ │   │
│  │  └───────────────────────────────────────────────────────────────────────────────────┘ │   │
│  │                                                                                        │   │
│  │  ┌─ B.2. Carousel (335x256, gap: 16px) ─────────────────────────────────────────────┐ │   │
│  │  │  ┌──── B.3. Highlight Card ─────────────────────────────────────────────────────┐ │ │   │
│  │  │  │  bg: #FFF8E1, border: 1px #FFEA9E, padding: 8px 12px, gap: 8px              │ │ │   │
│  │  │  │  ┌─ Sender/Receiver Row (250x62) ──────────────────────────────────────┐     │ │ │   │
│  │  │  │  │  [Avatar 🔵] [Name + Badge]  →  [Avatar 🔵] [Name + Badge]         │     │ │ │   │
│  │  │  │  └──────────────────────────────────────────────────────────────────────┘     │ │ │   │
│  │  │  │  ──── divider (#FFEA9E) ────                                                 │ │ │   │
│  │  │  │  ┌─ B.4. Content (250px, gap: 8px) ────────────────────────────────────┐     │ │ │   │
│  │  │  │  │  "1 ngày trước" (time)                                               │     │ │ │   │
│  │  │  │  │  "Nội dung kudos message..."                                          │     │ │ │   │
│  │  │  │  │  [#hashtag1] [#hashtag2]                                              │     │ │ │   │
│  │  │  │  └──────────────────────────────────────────────────────────────────────┘     │ │ │   │
│  │  │  │  ──── divider (#FFEA9E) ────                                                 │ │ │   │
│  │  │  │  ┌─ B.4.4. Actions (250x24) ───────────────────────────────────────────┐     │ │ │   │
│  │  │  │  │  [❤️ 12]  [🔗 Copy Link]  [Xem chi tiết →]                          │     │ │ │   │
│  │  │  │  └──────────────────────────────────────────────────────────────────────┘     │ │ │   │
│  │  │  └──────────────────────────────────────────────────────────────────────────────┘ │ │   │
│  │  │  ← [gradient overlay 79px]                    [gradient overlay 79px] →           │ │   │
│  │  └───────────────────────────────────────────────────────────────────────────────────┘ │   │
│  │                                                                                        │   │
│  │  ┌─ B.5. Slide Indicator (335x24, gap: 32px) ───────────────────────────────────────┐ │   │
│  │  │              [◀]    2/5 (14px/700)    [▶]                                         │ │   │
│  │  └───────────────────────────────────────────────────────────────────────────────────┘ │   │
│  └────────────────────────────────────────────────────────────────────────────────────────┘   │
│                                                                                              │
│  ┌─ B.6+B.7. Spotlight Board (336x236, gap: 24px) ─────────────────────────────────────┐   │
│  │  "Sun* Annual Awards 2025" → divider → "SPOTLIGHT BOARD" (22px/500, #FFEA9E)         │   │
│  │  ┌─ B.7. Floating Names Canvas (border: 0.29px #998C5F, height: 159px) ─────────────┐│   │
│  │  │  [🔍 Tìm kiếm sunner] (top-left)                                                 ││   │
│  │  │  Nguyễn Văn A    Trần Thị B   Lê C ...  (floating Text labels)                  ││   │
│  │  │     Huỳnh D        Phạm E   Võ F                                                 ││   │
│  │  │  [388 KUDOS] (bottom-left)                                                       ││   │
│  │  └──────────────────────────────────────────────────────────────────────────────────┘│   │
│  └──────────────────────────────────────────────────────────────────────────────────────┘   │
│                                                                                              │
│  ┌─ C. All Kudos Section (336x1393, gap: 24px) ────────────────────────────────────────┐   │
│  │  "Sun* Annual Awards 2025" → divider → "ALL KUDOS" + [Xem tất cả →]                 │   │
│  │  ┌─ Content (gap: 20px) ──────────────────────────────────────────────────────────┐  │   │
│  │  │                                                                                │  │   │
│  │  │  ┌─ D.1. Statistics Block (border: 0.794px #998C5F, bg: #00070C, r: 8px) ──┐  │  │   │
│  │  │  │  padding: 12px, gap: 8px                                                 │  │  │   │
│  │  │  │  Số kudos nhận được ............ 25 (14px/700, #FFEA9E)                   │  │  │   │
│  │  │  │  Số kudos đã gửi .............. 25                                        │  │  │   │
│  │  │  │  Số hearts nhận được .......... 30 [🔥x2]                                 │  │  │   │
│  │  │  │  ──── divider ────                                                        │  │  │   │
│  │  │  │  Số hộp bí mật đã mở ......... 3                                          │  │  │   │
│  │  │  │  Số hộp bí mật chưa mở ....... 2                                          │  │  │   │
│  │  │  │  [🎁 Mở hộp bí mật]                                                      │  │  │   │
│  │  │  └──────────────────────────────────────────────────────────────────────────┘  │  │   │
│  │  │                                                                                │  │   │
│  │  │  ┌─ D.3. 10 Sunner nhận quà mới nhất ──────────────────────────────────────────┐    │  │   │
│  │  │  │  "TOP 10 SUNNER NHẬN QUÀ MỚI NHẤT" (title)                            │    │  │   │
│  │  │  │  1. [Avatar] Tên Sunner - Phòng ban  "Nhận được 1 áo phông SAA"         │    │  │   │
│  │  │  │  2. [Avatar] Tên Sunner - Phòng ban  "Nhận được 1 mũ SAA"              │    │  │   │
│  │  │  │  ... (10 rows)                                                          │    │  │   │
│  │  │  └──────────────────────────────────────────────────────────────────────── │    │  │   │
│  │  │                                                                                │  │   │
│  │  │  ┌─ C.3. Kudos Card ──────────────────────────────────────────────────────┐    │  │   │
│  │  │  │  [Avatar] Sender Name (badge) → sent → [Avatar] Receiver Name (badge)  │    │  │   │
│  │  │  │  "1 ngày trước"                                                        │    │  │   │
│  │  │  │  ┌─ Content Card (bg: #FFF8E1, border: 1px #FFEA9E) ────────────────┐ │    │  │   │
│  │  │  │  │  "Nội dung kudos..."                                              │ │    │  │   │
│  │  │  │  │  [#hashtag1] [#hashtag2]                                          │ │    │  │   │
│  │  │  │  │  [❤️ 12] [🔗] [Xem chi tiết →]                                   │ │    │  │   │
│  │  │  │  └──────────────────────────────────────────────────────────────────┘ │    │  │   │
│  │  │  └──────────────────────────────────────────────────────────────────────── │    │  │   │
│  │  │  ... (thêm nhiều kudos cards) ...                                          │  │   │
│  │  └────────────────────────────────────────────────────────────────────────────┘  │   │
│  └──────────────────────────────────────────────────────────────────────────────────┘   │
│                                                                                              │
│  ┌─ Nav Bar (375x72, position: fixed bottom) ───────────────────────────────────────────┐   │
│  │  [SAA 2025]  [Awards]  [Kudos ✓]  [Profile]                                          │   │
│  └──────────────────────────────────────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Chi tiết Style từng Component

### A. KV Kudos (Hero Banner)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9066` | - |
| width | 221px | `width: 221` |
| height | 67px | `height: 67` |
| gap | 8px | `SizedBox(height: 8)` |
| layout | column | `Column` |

**Tagline Text**:
| Thuộc tính | Giá trị |
|-----------|---------|
| **Node ID** | `6885:9068` |
| text | "Hệ thống ghi nhận và cảm ơn" |
| fontSize | 14px |
| fontFamily | Montserrat |
| fontWeight | 500 (Medium) |
| lineHeight | 20px |
| color | `#FFEA9E` |

---

### A.1. Button ghi nhận (Send Kudos CTA)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9083` |  |
| width | 335px | `double.infinity` (với padding) |
| height | 40px | `height: 40` |
| gap | 8px | `spacing: 8` |
| padding | 10px | `EdgeInsets.all(10)` |
| background | `rgba(255, 234, 158, 0.10)` | `Color(0x1AFFEA9E)` |
| border | 1px solid `#998C5F` | `Border.all(color: Color(0xFF998C5F))` |
| layout | row, center | `Row(mainAxisAlignment: center)` |

**Icon**: 24x24, Node ID: `I6885:9083;28:2013`
**Label**: "Hôm nay, bạn muốn gửi kudos đến ai?", 14px/500, white, center

**States:**
| Trạng thái | Thay đổi |
|-----------|----------|
| Default | background: `rgba(255, 234, 158, 0.10)`, border: `#998C5F` |
| Pressed/Tap | background: `rgba(255, 234, 158, 0.15)`, scale: 0.98 |
| Disabled | Không có trạng thái disable (luôn enabled) |

> **Ghi chú**: Button CTA xuất hiện 2 lần trên màn hình — 1 lần ở hero banner (Node: `6885:9083`) và 1 lần ở cuối feed (Node: `6891:21267`). Cùng style và hành vi.

---

### B.1. Highlight Header

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9085` | - |
| width | 335px | fill |
| height | 109px | wrap content |
| gap | 16px | `SizedBox(height: 16)` |

**Section Subtitle** ("Sun* Annual Awards 2025"):
| Thuộc tính | Giá trị |
|-----------|---------|
| fontSize | 12px |
| fontWeight | 400 (Regular) |
| lineHeight | 16px |
| color | white |

**Divider**:
| Thuộc tính | Giá trị |
|-----------|---------|
| **Node ID** | `I6885:9086;75:1885` |
| height | 1px |
| color | `#2E3940` |

**Section Title** ("HIGHLIGHT KUDOS"):
| Thuộc tính | Giá trị |
|-----------|---------|
| fontSize | 22px |
| fontWeight | 500 |
| lineHeight | 28px |
| color | `#FFEA9E` |

---

### B.1.1. Dropdown Button "Hashtag"

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9088` | - |
| width | 129px (fixed) | `width: 129` |
| height | 40px | `height: 40` |
| padding | 8px | `EdgeInsets.all(8)` |
| gap | 8px | `spacing: 8` giữa label và icon dropdown |
| background | `rgba(255, 234, 158, 0.10)` | `Color(0x1AFFEA9E)` |
| border | 1px solid `#998C5F` | `Border.all(color: Color(0xFF998C5F))` |
| borderRadius | 4px (suy luận từ filter container) | `BorderRadius.circular(4)` |
| layout | Row (label + dropdown icon) | `Row` |

**Label** ("Hashtag"):
| Thuộc tính | Giá trị |
|-----------|---------|
| fontSize | 14px |
| fontFamily | Montserrat |
| fontWeight | 500 |
| lineHeight | 20px |
| color | white (`#FFFFFF`) |

**Dropdown Icon**: 24x24, white, icon mũi tên xuống

**States:**
| Trạng thái | Thay đổi |
|-----------|----------|
| Default | background: `rgba(255, 234, 158, 0.10)`, border: `#998C5F` |
| Pressed/Tap | background: `rgba(255, 234, 158, 0.15)` |
| Đã chọn filter | Label thay bằng tên hashtag đã chọn, có thể thêm icon "x" để xóa filter |

---

### B.1.2. Dropdown Button "Phòng ban"

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9089` | - |
| width | auto (fit content) | `null` (intrinsic width) |
| height | 40px | `height: 40` |
| padding | 8px | `EdgeInsets.all(8)` |
| gap | 8px | `spacing: 8` giữa label và icon dropdown |
| background | `rgba(255, 234, 158, 0.10)` | `Color(0x1AFFEA9E)` |
| border | 1px solid `#998C5F` | `Border.all(color: Color(0xFF998C5F))` |
| borderRadius | 4px (suy luận từ filter container) | `BorderRadius.circular(4)` |
| layout | Row (label + dropdown icon) | `Row` |

**Label** ("Phòng ban"):
| Thuộc tính | Giá trị |
|-----------|---------|
| fontSize | 14px |
| fontFamily | Montserrat |
| fontWeight | 500 |
| lineHeight | 20px |
| color | white (`#FFFFFF`) |

**Dropdown Icon**: 24x24, white, icon mũi tên xuống

**States:**
| Trạng thái | Thay đổi |
|-----------|----------|
| Default | background: `rgba(255, 234, 158, 0.10)`, border: `#998C5F` |
| Pressed/Tap | background: `rgba(255, 234, 158, 0.15)` |
| Đã chọn filter | Label thay bằng tên phòng ban đã chọn, có thể thêm icon "x" để xóa filter |

> **Ghi chú quan trọng**: Cả 2 dropdown button B.1.1 và B.1.2 nằm trong **Filter container** (Node ID: `6885:9087`, width: 266px, height: 40px, gap: 8px, layout: Row). Khi bấm, mỗi button mở một overlay/bottom sheet riêng biệt chứa danh sách options.

---

### B.3. KUDO Highlight Card

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9091`, `6885:9092`, `6885:9093` | - |
| gap | 8px | `SizedBox(height: 8)` |
| padding | 8px 12px | `EdgeInsets.symmetric(vertical: 8, horizontal: 12)` |
| background | `#FFF8E1` | `Color(0xFFFFF8E1)` |
| border | 1px solid `#FFEA9E` | `Border.all(color: Color(0xFFFFEA9E))` |
| borderRadius | 4px (suy luận từ card style) | `BorderRadius.circular(4)` |

**Sender/Receiver Row** (B.3.1 → B.3.4 → B.3.5):
| Thuộc tính | Giá trị |
|-----------|---------|
| **Node ID** | `I6885:9092;89:2950` |
| width | 250px |
| height | 62px |
| gap | 8px |
| layout | Row |

**Content Divider** trong card:
| Thuộc tính | Giá trị |
|-----------|---------|
| **Node ID** | `I6885:9092;89:2955` |
| height | 0px (hairline) |
| color | `#FFEA9E` |

**Content Area** (B.4):
| Thuộc tính | Giá trị |
|-----------|---------|
| **Node ID** | `I6885:9092;89:2956` |
| width | 250px |
| height | 121px |
| gap | 8px |

**Action Row** (B.4.4):
| Thuộc tính | Giá trị |
|-----------|---------|
| **Node ID** | `I6885:9092;89:2972` |
| width | 250px |
| height | 24px |
| gap | ~11px |

**Carousel Card States (TC_FUN_038):**
| Trạng thái | Mô tả | Visual |
|-----------|-------|--------|
| Active (center) | Thẻ đang được chọn, ở giữa carousel | Hiển thị đầy đủ, rõ nét, không fade |
| Side (trái/phải) | Thẻ kề bên, visible một phần qua gradient overlay | Mờ dần qua gradient `rgba(0,16,26,0.50)` → `rgba(0,16,26,1)` |

**Content Truncation Rules:**
| Context | Max Lines | Test Case |
|---------|-----------|-----------|
| Message text trong Highlight card | 3 dòng | TC_GUI_005 |
| Sender name trong Highlight card | 1 dòng + "..." | TC_GUI_005 |
| Message text trong All Kudos feed | 5 dòng | TC_GUI_003 |
| Hashtag tags | 1 dòng | TC_GUI_004 |

---

### B.5. Slide Indicator

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9098` | - |
| width | 335px | fill |
| height | 24px | `height: 24` |
| gap | 32px | `spacing: 32` |
| padding | 0 144px | `EdgeInsets.symmetric(horizontal: 144)` |
| layout | Row, center | `Row(mainAxisAlignment: center)` |

**Arrow icons**: 24x24 mỗi bên
**Page Number** ("2/5"):
| Thuộc tính | Giá trị |
|-----------|---------|
| **Node ID** | `I6885:9098;93:2086` |
| fontSize | 14px |
| fontWeight | 700 (Bold) |
| lineHeight | 20px |
| letterSpacing | 0.25px |

---

### B.7. Spotlight Section (Floating Names Canvas)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9101` | - |
| height | 159px | `height: 159` |
| border | 0.29px solid `#998C5F` | `Border.all(width: 0.29, color: Color(0xFF998C5F))` |
| overflow | hidden | `ClipRRect` |
| background | `#00101A` (dark) | `Color(0xFF00101A)` |

**Rendering Logic:**

```
ClipRRect(borderRadius: 8)
└── Container(height: 159, color: #00101A)
    └── Stack(fit: StackFit.expand)
        │
        ├── [Layer 1] InteractiveViewer (panEnabled, scaleEnabled)
        │   └── SizedBox(width: 700, height: 130)  ← canvas pan area (tên names)
        │       └── Stack
        │           └── [for each SpotlightEntry]
        │               Positioned(left: entry.x, top: entry.y,
        │                 child: Text(entry.name,
        │                   style: TextStyle(
        │                     color: highlightedId == entry.userId ? #FFEA9E : white(alpha 178),
        │                     fontSize: highlightedId == entry.userId ? 10px : 8px,
        │                     fontWeight: w700,
        │                   )
        │                 )
        │               )
        │
        ├── [Layer 2] Positioned(top: 8, left: 7) → B.7.3 Search Input (fixed, không pan)
        │
        ├── [Layer 3] Positioned(top: 11, left: 18) → B.7.1 KUDOS Count (fixed, không pan)
        │
        └── [Layer 4] Positioned(top: 124, left: 14) → Live Activity Feed (fixed)
            └── Column(
                  for each activity in recentActivity:
                    Text("${activity.timestamp} ${activity.receiverName} đã nhận được một Kudos mới",
                      style: TextStyle(fontSize: 4.06px, fontWeight: 700, color: white, opacity: 0.3))
                )
```

> **Ghi chú thiết kế**: Search Input (B.7.3), KUDOS Count (B.7.1), và Live Feed đều là **fixed overlays** trong outer Stack — KHÔNG nằm bên trong `InteractiveViewer`, nên chúng không pan/zoom theo canvas. Chỉ các name labels mới nằm trong InteractiveViewer. Highlight state (`_highlightedUserId`) là local widget state, KHÔNG trong model.

**Name Label (mỗi SpotlightEntry)** — highlight dựa trên `_highlightedUserId` widget state:
| Trạng thái | fontSize | fontWeight | color | Điều kiện |
|-----------|---------|---------|-------|----------|
| Default | 8px | 700 | `rgba(255,255,255, 0.70)` | `_highlightedUserId != entry.userId` |
| Highlighted | 10px | 700 | `#FFEA9E` | `_highlightedUserId == entry.userId` |

**Search Input** (B.7.3):
| Thuộc tính | Giá trị |
|-----------|---------|
| **Node ID** | `6885:9216` |
| width | ~64px |
| height | ~11px (scaled) |
| border | 0.198px solid `#998C5F` |
| background | `rgba(255, 234, 158, 0.10)` |
| padding | 4.75px 3.17px |
| action | Tap → navigate screenId: `3jgwke3E8O` |

**Kudos Count Label** (B.7.1 — fixed overlay, top-left area):
| Thuộc tính | Giá trị |
|-----------|---------|
| **Node ID** | `6885:9219` |
| text | `"${spotlight.totalKudos} KUDOS"` (dynamic từ Supabase) |
| fontSize | 10.44px (`10.4452543258667px` exact) |
| fontWeight | 400 |
| color | white |
| position | top: ~11px, left: ~18px (absolute trong B.7 container, cạnh search input) |

**Live Activity Feed** (fixed overlay trong B.7, tại top: 124px, left: 14px):
| Thuộc tính | Giá trị |
|-----------|---------|
| **Node ID** | `6885:9101` (child TEXT nodes) |
| text format | `"{timestamp} {receiverName} đã nhận được một Kudos mới"` |
| timestamp format | `"HH:MMam/pm"` (ví dụ: "08:30PM") |
| source | `spotlight.recentActivity` (List\<SpotlightActivity\>) — 10 items gần nhất |
| layout | `Column` các `Text` rows |
| fontSize | `4.062px` (Figma scale) — tương đương ~8px sau scale |
| fontWeight | 700 |
| opacity | 0.3 (30%) |
| color | white |
| position trong canvas | top: ~124px, left: ~14px (absolute trong B.7 container) |

---

### Carousel Navigation Overlay

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9096` (right), `6885:9094` (left) | - |
| width | 79px | `width: 79` |
| height | 260px | match carousel height |
| padding | 0 8px 0 47px | - |
| background | `linear-gradient(270deg, #00101A 5.71%, rgba(0,16,26,0.50) 45.81%, rgba(255,255,255,0.00) 85.92%)` | `LinearGradient` |

**Arrow icon**: 24x24, Node ID: `6885:9097`

---

### C. All Kudos Section

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9220` | - |
| width | 336px | fill |
| height | 1393px | wrap content |
| gap | 24px | `SizedBox(height: 24)` |

**Header** (C.1): Cùng pattern với B.1 header — subtitle + divider + title ("ALL KUDOS")

**"Xem tất cả" Link** (C.2):
| Thuộc tính | Giá trị |
|-----------|---------|
| fontSize | 14px |
| fontFamily | Montserrat |
| fontWeight | 500 |
| lineHeight | 20px |
| color | `#FFEA9E` (accent) |
| text | "Xem tất cả →" |
| position | Cùng hàng với title "ALL KUDOS", căn phải |

**Content**: gap: 20px giữa các items

---

### C.3. Kudos Card (Feed — All Kudos)

Mỗi kudos card trong feed All Kudos gồm 2 phần: header (sender → receiver) và content card.

**Header Row** (Sender → sent → Receiver):
| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| layout | Row, wrap | `Wrap` hoặc `Row` |
| gap | 8px | `spacing: 8` |

- **Avatar** (C.3.1, C.3.3): hình tròn, kích thước ~32-40px, `ClipOval`
- **Tên + Danh hiệu** (C.3.1, C.3.3): Tên (14px/500, white) + Badge danh hiệu icon bên cạnh
- **Icon "sent"** (C.3.2): icon mũi tên/indicator giữa sender và receiver, color accent

**Thời gian** (C.3.4):
| Thuộc tính | Giá trị |
|-----------|---------|
| fontSize | 12px |
| fontWeight | 400 |
| lineHeight | 16px |
| color | `#999999` (text-secondary) |

**Content Card** (C.3.5):
| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| background | `#FFF8E1` | `Color(0xFFFFF8E1)` |
| border | 1px solid `#FFEA9E` | `Border.all(color: Color(0xFFFFEA9E))` |
| borderRadius | 4px | `BorderRadius.circular(4)` |
| padding | 8px 12px | `EdgeInsets.symmetric(vertical: 8, horizontal: 12)` |
| gap | 8px | giữa nội dung, hashtags, actions |

- **Nội dung**: 14px/400, `#00101A` (text-dark trên card sáng)
- **Hashtags**: Chip/tag dạng text `#hashtag`, 12px/400
- **Actions Row**: Heart (icon + count), Copy Link, "Xem chi tiết" — cùng pattern với B.4.4

**Heart Icon States:**
| Trạng thái | Icon | Màu | Count |
|-----------|------|-----|-------|
| Chưa like | outlined heart | `#999999` | Số hiện tại |
| Đã like | filled heart | `#F17676` | Số hiện tại + 1 |
| Animation | scale 1.0 → 1.3 → 1.0 | `#F17676` | 200ms spring |

---

### D.3. 10 Sunner nhận quà mới nhất

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| layout | Column | `Column` |
| gap | 12px | giữa các rows |

**Title** (D.3.1):
| Thuộc tính | Giá trị |
|-----------|---------|
| fontSize | 14px |
| fontWeight | 700 |
| lineHeight | 20px |
| color | `#FFEA9E` |

**Recipient Row** (D.3.2):
| Thuộc tính | Giá trị |
|-----------|---------|
| layout | Row, space-between |
| height | ~32px |
| gap | 8px |
| tap action | Bấm → navigate Profile người khác (screenId: `bEpdheM0yU`) |

- **Rank number**: 14px/700, `#FFEA9E`
- **Avatar**: hình tròn, ~24-32px, `ClipOval`
- **Name**: 14px/400, white
- **Department**: 12px/400, `#999999`
- **rewardName**: 12px/400, `#FFEA9E` — mô tả phần quà (ví dụ: "Nhận được 1 áo phông SAA"), nguồn: `GiftRecipientRanking.rewardName` = `award_category_name` từ Supabase

**Star Badge (Hero Tier) — hiển thị trên avatar người nhận:**
| `users.hero_tier` | `badgeLevel` | Hiển thị | Màu |
|-------------------|-------------|----------|-----|
| `none` | 0 | Không badge | - |
| `new_hero` | 1 | 1 badge star | `#FFEA9E` |
| `rising_hero` | 2 | 2 badge stars | `#FFEA9E` |
| `super_hero` | 3 | 3 badge stars | `#FFEA9E` |
| `legend_hero` | 4 | 4 badge stars | `#FFEA9E` |

> Mapping thực hiện trong `_mapUserSummary()` tại `KudosRemoteDatasource`.

---

### D.1. Personal Statistics Block

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9223` | - |
| padding | 12px | `EdgeInsets.all(12)` |
| gap | 8px | `SizedBox(height: 8)` |
| background | `#00070C` | `Color(0xFF00070C)` |
| border | 0.794px solid `#998C5F` | `Border.all(width: 0.794, color: Color(0xFF998C5F))` |
| borderRadius | 8px | `BorderRadius.circular(8)` |

**Stat Row** (D.1.2, D.1.3, D.1.4, D.1.6, D.1.7):
| Thuộc tính | Giá trị |
|-----------|---------|
| width | 312px |
| height | 20px |
| layout | Row, space-between |
| gap | ~6.35px |

**Stat Label**: 14px, Montserrat, weight 400-500, white
**Stat Value**: 14px, Montserrat, weight 700, `#FFEA9E`

**D.2. Button "Mở hộp bí mật"**:
| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| width | fill (312px) | `double.infinity` |
| height | 40px | `height: 40` |
| padding | 10px | `EdgeInsets.all(10)` |
| background | `rgba(255, 234, 158, 0.10)` | `Color(0x1AFFEA9E)` |
| border | 1px solid `#998C5F` | `Border.all(color: Color(0xFF998C5F))` |
| borderRadius | 4px | `BorderRadius.circular(4)` |
| layout | Row, center (icon + label) | `Row(mainAxisAlignment: center)` |
| label | "Mở hộp bí mật", 14px/500, white | — |
| icon | gift box icon, 24x24 | — |

**States (TC_FUN_039):**
| Trạng thái | Thay đổi | Điều kiện |
|-----------|----------|-----------|
| Default | background: `rgba(255, 234, 158, 0.10)`, border: `#998C5F` | `secret_boxes_unopened > 0` |
| Pressed/Tap | background: `rgba(255, 234, 158, 0.15)` | Đang bấm |
| Disabled | opacity: 0.5, không bấm được | `secret_boxes_unopened = 0` |

---

### Header (App Bar)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9065` | - |
| width | 375px | full width |
| height | 104px | `height: 104` |
| position | absolute, z-index: 1 | `Positioned` hoặc `SliverAppBar` |
| opacity | 0.9 | `opacity: 0.9` |
| background | gradient fade-out | `LinearGradient` |

**Logo**: 48x44, Node ID: `I6885:9065;88:1827`
**Language Dropdown**: 90x32, border-radius: 4px, gap: 8px, padding: 4px 0 4px 8px
**Search Icon**: 24x24, Node ID: `I6885:9065;88:1869`
**Notification Icon**: 24x24 + red dot (8x8, radius: 100px), Node ID: `I6885:9065;88:1830`

---

### Nav Bar (Bottom)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9064` | - |
| width | 375px | full width |
| height | 72px | `height: 72` |
| position | fixed bottom | `bottomNavigationBar` |

---

## Component Hierarchy với Styles

```
Screen (bg: #00101A, w: 375, h: 2601, scroll)
├── Header (h: 104, absolute, z: 1, gradient, opacity: 0.9)
│   ├── StatusBar (h: 44, SF Pro Text 15px/600)
│   ├── Logo (48x44, image)
│   ├── Language (90x32, border: #998C5F, r: 4px)
│   │   ├── Flag Icon (24x24)
│   │   ├── "VN" (14px/500, white)
│   │   └── Chevron Down (24x24)
│   ├── Search Icon (24x24)
│   └── Notification (24x24 + red dot 8x8)
│
├── Hero Background (GROUP, 1130x812)
│   ├── Key Visual BG (image)
│   ├── Shadow Left (gradient LR)
│   └── Shadow Bottom (gradient TB)
│
├── A. KV Kudos (221x67, gap: 8)
│   ├── Tagline (14px/500, #FFEA9E)
│   └── KUDOS Logo (221x39)
│
├── A.1. CTA Button (335x40, border: 1px #998C5F, bg: primary-10)
│   ├── Pencil Icon (24x24)
│   └── Label (14px/500, white, center)
│
├── B. Highlight (335x389, gap: 24)
│   ├── B.1. Header (335x109, gap: 16)
│   │   ├── Subtitle (12px/400, white)
│   │   ├── Divider (1px, #2E3940)
│   │   ├── Title "HIGHLIGHT KUDOS" (22px/500, #FFEA9E)
│   │   └── Filters (266x40, gap: 8) — 2 dropdown buttons
│   │       ├── B.1.1 Dropdown Button "Hashtag" (129x40, border: #998C5F, bg: primary-10, r: 4px)
│   │       └── B.1.2 Dropdown Button "Phòng ban" (auto x40, same style as B.1.1)
│   │
│   ├── B.2. Carousel (335x256, gap: 16)
│   │   ├── B.3. Card (bg: #FFF8E1, border: 1px #FFEA9E, p: 8px 12px)
│   │   │   ├── Sender/Receiver Row (250x62)
│   │   │   ├── Divider (#FFEA9E)
│   │   │   ├── Content (250px, gap: 8)
│   │   │   │   ├── Time (text)
│   │   │   │   ├── Message (text)
│   │   │   │   └── Hashtags (tags)
│   │   │   ├── Divider (#FFEA9E)
│   │   │   └── Actions (250x24, gap: ~11)
│   │   ├── Gradient Overlay Left (79x260)
│   │   └── Gradient Overlay Right (79x260)
│   │
│   └── B.5. Slide Indicator (335x24, gap: 32)
│       ├── Arrow Left (24x24)
│       ├── "2/5" (14px/700, white)
│       └── Arrow Right (24x24)
│
├── B.6+B.7. Spotlight (336x236, gap: 24)
│   ├── Header (same pattern as B.1)
│   └── Floating Names Canvas (h: 159, border: 0.29px #998C5F, bg: #00101A)
│       ├── InteractiveViewer → Stack(700x400) of Positioned(Text) name labels
│       ├── Positioned(top-left): Search Input (64x11, border: #998C5F)
│       └── Positioned(top: 11, left: 18): "388 KUDOS" (10.44px/400, white, fixed overlay)
│
├── C. All Kudos (336x1393, gap: 24)
│   ├── Header (same pattern)
│   └── Content (gap: 20)
│       ├── D.1. Stats Block (border: 0.794px #998C5F, bg: #00070C, r: 8px, p: 12)
│       │   ├── Stat Rows (312x20 each, space-between)
│       │   │   └── Label (14px/400-500, white) + Value (14px/700, #FFEA9E)
│       │   ├── Divider
│       │   └── CTA "Mở hộp bí mật"
│       │
│       ├── D.3. 10 Sunner nhận quà mới nhất
│       │   ├── Title
│       │   └── Rows (rank + avatar + name + department + rewardName) [tap → profile bEpdheM0yU]
│       │
│       └── C.3. Kudos Cards (multiple, infinite scroll)
│           ├── Sender → Receiver Header
│           ├── Time Label
│           └── Content Card (bg: #FFF8E1, border: #FFEA9E)
│
└── Nav Bar (375x72, fixed bottom)
    └── 4 Tabs: SAA 2025 | Awards | Kudos | Profile
```

---

## Responsive Specifications

### Breakpoints

| Tên | Min Width | Max Width | Ghi chú |
|-----|-----------|-----------|---------|
| Mobile (iOS) | 375px | 428px | iPhone 13/14/15 series |

> **Ghi chú**: Đây là ứng dụng mobile-only (Flutter). Không có responsive breakpoints cho tablet/desktop trong thiết kế hiện tại. Layout scale dựa trên `MediaQuery` width.

### Responsive Changes

#### iPhone SE (375px) - Thiết kế chính
- Tất cả measurements ở trên áp dụng trực tiếp.

#### iPhone Pro Max (~428px)
| Thành phần | Thay đổi |
|-----------|----------|
| Container | width: fill, padding horizontal giữ nguyên 20px mỗi bên |
| Cards | width: expand theo available space |
| Carousel | card width proportional |

---

## Icon Specifications

| Tên Icon | Kích thước | Màu | Sử dụng |
|----------|-----------|-----|---------|
| logo_homepage | 48x44 | image | App logo trên header |
| icon_search | 24x24 | white | Tìm kiếm trên header |
| icon_notification | 24x24 | white | Thông báo trên header |
| icon_notification_dot | 8x8 | `#D4271D` | Badge thông báo mới |
| icon_pencil | 24x24 | white/accent | Icon trong CTA button |
| icon_dropdown | 24x24 | white | Mũi tên dropdown |
| icon_arrow_right | 24x24 | white | Navigation arrow |
| icon_next | 24x24 | white | Carousel next |
| icon_prev | 24x24 | white | Carousel previous |
| icon_heart | varies | `#F17676` | Heart/like icon |
| icon_copy_link | varies | accent | Copy link action |
| flag_vn | 20x15 | image | Cờ Việt Nam |
| icon_sent | varies | accent | Biểu tượng "sent" giữa sender → receiver |
| icon_fire | varies | accent | Badge x2 bonus |
| icon_gift_box | varies | accent | Hộp bí mật |

---

## Animation & Transitions

| Element | Thuộc tính | Duration | Easing | Trigger |
|---------|-----------|----------|--------|---------|
| Carousel Card | translateX | 300ms | ease-in-out | Swipe / bấm arrow |
| Gradient Overlay | opacity | 200ms | ease-out | Khi carousel slide |
| Heart Icon | scale | 200ms | spring | Bấm like |
| Spotlight Canvas | transform | continuous | linear | Pan/zoom gesture (InteractiveViewer) |
| Dropdown | height, opacity | 200ms | ease-out | Bấm dropdown |
| CTA Button | opacity | 150ms | ease-in-out | Tap |

---

## Implementation Mapping (Flutter)

| Design Element | Figma Node ID | Flutter Widget | Ghi chú |
|---------------|---------------|---------------|---------|
| Screen Container | `6885:9059` | `Scaffold` + `CustomScrollView` | bg: `#00101A` |
| Header | `6885:9065` | `SliverAppBar` (floating, transparent) | gradient background |
| Hero Banner | `6885:9060` | `Stack` + `Image.asset` | Assets.images.kvBg |
| CTA Button | `6885:9083` | `OutlinedButton` / custom widget | border: `#998C5F` |
| Highlight Section | `6885:9084` | `Column` | gap: 24 |
| Section Header | `6885:9085` | Reusable `SectionHeader` widget | subtitle + divider + title pattern |
| Dropdown Button Hashtag (B.1.1) | `6885:9088` | Custom `FilterDropdownButton` widget | width: 129, label: "Hashtag" |
| Dropdown Button Phòng ban (B.1.2) | `6885:9089` | Custom `FilterDropdownButton` widget (reuse) | width: auto, label: "Phòng ban" |
| Highlight Carousel | `6885:9090` | `PageView` + gradient overlay | 5 cards max |
| Highlight Card | `6885:9091` | `HighlightKudosCard` widget | bg: `#FFF8E1` |
| Slide Indicator | `6885:9098` | Custom `PageIndicator` widget | "2/5" format |
| Spotlight Board | `6885:9101` | `InteractiveViewer` + `Stack` of `Positioned(Text(...))` | floating name labels; KHÔNG dùng CustomPaint circles/edges |
| All Kudos Feed | `6885:9220` | `SliverList` | lazy loading |
| Kudos Card (C.3) | - | `KudosFeedCard` widget | Header (sender→receiver) + Content card |
| Content Card (C.3.5) | - | `KudosContentCard` widget | bg: `#FFF8E1`, reusable cho cả Highlight và Feed |
| Stats Block (D.1) | `6885:9223` | `PersonalStatsCard` widget | bg: `#00070C` |
| 10 Sunner nhận quà mới nhất (D.3) | - | `TopGiftRecipientsCard` widget | 10 rows, sort by recency; mỗi row tap → Profile người khác (bEpdheM0yU); hiển thị rewardName thay cho timestamp |
| "Xem tất cả" Link (C.2) | - | `TextButton` / `GestureDetector` | color: `#FFEA9E`, align right |
| "Mở hộp bí mật" Button (D.2) | - | Reuse `FilterDropdownButton` style | same CTA pattern |
| Heart Toggle | - | Custom `HeartButton` widget | outlined ↔ filled, optimistic update |
| Nav Bar | `6885:9064` | `BottomNavigationBar` | 4 tabs |

---

## Ghi chú

- Tất cả màu sắc PHẢI sử dụng theme tokens để hỗ trợ future theming.
- Font Montserrat PHẢI được load qua `google_fonts` package.
- Tất cả icons PHẢI dùng SVG assets qua `flutter_gen` (`Assets.icons.icXxx.svg(...)`).
- Dark theme là mặc định — không có light theme variant trong thiết kế.
- Section header pattern (subtitle + divider + title) lặp lại 3 lần → widget `SectionHeaderWidget` đã tồn tại trong `shared/widgets/`.
- Highlight card background (`#FFF8E1`) là light color trên dark background → tạo visual contrast.
- **Spotlight**: Khi `spotlight.entries.isEmpty` → hiển thị empty container 159px với text "Chưa có dữ liệu.". Khi có data → `InteractiveViewer` + `Stack` of `Positioned(Text(...))` với tên người gửi kudos gần đây. KHÔNG dùng `CustomPaint` circles/edges. KHÔNG dùng `Image.asset`.
- **Hero tier badge**: Đọc từ `users.hero_tier` (DB enum), map sang `badgeLevel` 0-4 trong `_mapUserSummary()`.
- **Kudos ẩn danh**: Khi `isAnonymous = true`, ẩn thông tin sender (avatar + tên), hiển thị `senderAlias` (nếu người gửi đặt nickname, field `kudos.sender_alias` VARCHAR max 50 chars) hoặc "Người gửi ẩn danh" nếu `senderAlias == null`.
- Color contrast PHẢI đáp ứng WCAG AA (4.5:1 cho text thường).
