# Thông số thiết kế — [iOS] Home

> Screen ID: `OuH1BUTYT0` | Frame: `[iOS] Home` | Node ID: `6885:8978`

## 1. Design Tokens

### 1.1 Bảng màu

| Token | Hex / RGBA | Sử dụng |
|-------|-----------|---------|
| `--color-bg-primary` | `#00101A` / `rgba(0, 16, 26, 1)` | Nền chính màn hình |
| `--color-text-primary` | `#FFFFFF` / `rgba(255, 255, 255, 1)` | Text chính, label, icon |
| `--color-text-accent` | `#FFEA9E` / `rgba(255, 234, 158, 1)` | Text nổi bật (ngày, địa điểm, tiêu đề section, tab active) |
| `--color-button-primary-bg` | `#FFEA9E` / `rgba(255, 234, 158, 1)` | Nền nút chính (About Award, Chi tiết, FAB) |
| `--color-button-primary-text` | `#00101A` / `rgba(0, 16, 26, 1)` | Text nút chính |
| `--color-button-outline-bg` | `rgba(255, 234, 158, 0.10)` | Nền nút outline (About Kudos) |
| `--color-button-outline-border` | `#998C5F` | Viền nút outline |
| `--color-notification-badge` | `#D4271D` / `rgba(212, 39, 29, 1)` | Chấm thông báo |
| `--color-countdown-border` | `#FFEA9E` | Viền ô số đếm ngược |
| `--color-nav-bg` | `rgba(255, 234, 158, 0.15)` | Nền thanh điều hướng dưới |
| `--color-kudos-banner-text` | `#DBD1C1` / `rgba(219, 209, 193, 1)` | Text "KUDOS" trên banner |
| `--color-divider` | `rgba(46, 57, 64, 1)` | Đường kẻ phân cách section header |
| `--color-header-gradient` | `linear-gradient(180deg, #00101A 0%, ... rgba(0,16,26,0) 100%)` | Gradient overlay header |

### 1.2 Typography

| Kiểu chữ | Font Family | Size | Weight | Line Height | Letter Spacing | Sử dụng |
|-----------|-------------|------|--------|-------------|----------------|---------|
| Tiêu đề section | Montserrat | 22px | 500 | 28px | 0% | "Hệ thống giải thưởng", "Sun* Kudos" |
| Số đếm ngược | Digital Numbers | 32px | 400 | — | 0% | Chữ số countdown |
| Nhãn đếm ngược | Montserrat | 18px | 400 | 24px | 0.5px | "DAYS", "HOURS", "MINUTES" |
| Giá trị nổi bật | Montserrat | 18px | 400 | 24px | 0.5px | Ngày sự kiện, địa điểm |
| Body text | Montserrat | 14px | 300 | 20px | 0.25px | Mô tả, nhãn thông tin |
| Body text (normal) | Montserrat | 14px | 400 | 20px | 0.25px | Ghi chú livestream |
| Nhãn nút | Montserrat | 14px | 500 | 20px | 0px | Text nút bấm |
| Nhãn section | Montserrat | 12px | 400 | 16px | 0% | "Sun* Annual Awards 2025", label tab nav |
| Ngôn ngữ | Montserrat | 14px | 500 | 20px | 0px | "VN" bộ chọn ngôn ngữ |
| Banner Kudos | SVN-Gotham | 27.96px | 400 | 6.99px | -13% | Text "KUDOS" trên banner |
| FAB divider | Montserrat | 24px | 400 | 32px | 0px | Ký tự "/" trong FAB |
| Status Bar | SF Pro Text | 15px | 600 | 20px | -0.5px | Giờ hệ thống "9:41" |

### 1.3 Spacing

| Token | Giá trị | Sử dụng |
|-------|---------|---------|
| `--spacing-content-gap` | 32px | Khoảng cách giữa các phần tử hero |
| `--spacing-section-gap` | 24px | Khoảng cách giữa sections (awards, kudos) |
| `--spacing-countdown-gap` | 16px | Khoảng cách giữa các đơn vị đếm ngược |
| `--spacing-countdown-num-gap` | 8px | Khoảng cách giữa các ô số |
| `--spacing-countdown-label-gap` | 4px | Khoảng cách giữa số và nhãn |
| `--spacing-note-gap` | 16px | Khoảng cách trong khối mô tả chủ đề |
| `--spacing-card-gap` | 16px | Khoảng cách giữa các card giải thưởng |
| `--spacing-card-inner-gap` | 12px | Khoảng cách giữa phần tử trong card |
| `--spacing-header-gap` | 4px | Khoảng cách giữa nhãn section và tiêu đề |
| `--spacing-button-padding` | 12px | Padding nút chính |
| `--spacing-outline-btn-padding` | 10px | Padding nút outline |
| `--spacing-nav-padding` | 0 24px | Padding ngang thanh nav |
| `--spacing-language-padding` | 4px 0px 4px 8px | Padding bộ chọn ngôn ngữ |
| `--spacing-fab-padding` | 8px | Padding nội bộ FAB |
| `--spacing-tab-gap` | 4px | Khoảng cách icon-label trong tab |

### 1.4 Viền & Bo góc

| Token | Giá trị | Sử dụng |
|-------|---------|---------|
| `--radius-button` | 4px | Bo góc nút bấm |
| `--radius-fab` | 100px | Dạng pill FAB |
| `--radius-language` | 4px | Bộ chọn ngôn ngữ |
| `--radius-notification-dot` | 100px | Badge tròn thông báo |
| `--radius-home-icon` | 4px | Icon home trong nav |
| `--border-outline-btn` | 1px solid #998C5F | Viền nút outline |
| `--border-countdown-box` | 0.5px solid #FFEA9E | Viền ô số đếm ngược |
| `--border-award-img` | 0.455px solid #FFEA9E | Viền ảnh giải thưởng |
| `--border-section-divider` | 1px solid rgba(46, 57, 64, 1) | Đường kẻ header section |

### 1.5 Hiệu ứng

| Token | Giá trị | Sử dụng |
|-------|---------|---------|
| Header opacity | 0.9 | Độ trong suốt header |
| Countdown box opacity | 0.5 | Nền ô số đếm ngược |
| Countdown box gradient | `linear-gradient(180deg, #FFF 0%, rgba(255,255,255,0.10) 100%)` | Fill ô số đếm ngược |
| Shadow Left | `linear-gradient(90deg, #00101A 0%, #10181F 19%, transparent 77%)` | Đổ bóng trái ảnh hero |
| Shadow Bottom | `linear-gradient(90deg, #00101A 0%, #00101A 25%, transparent 100%)` | Đổ bóng dưới ảnh hero |

### 1.6 Trạng thái tương tác (Interactive States)

> Figma chỉ cung cấp trạng thái Default. Các trạng thái khác được suy luận theo platform conventions.

#### Nút chính (Primary Button: About Award, Chi tiết Kudos)
| Trạng thái | Thuộc tính | Giá trị |
|-----------|-----------|---------|
| Default | background | `#FFEA9E` |
| Pressed | background | `#E6D38E` (darken 10%) |
| Disabled | background | `rgba(255, 234, 158, 0.4)` |
| Disabled | text color | `rgba(0, 16, 26, 0.5)` |

#### Nút outline (About Kudos)
| Trạng thái | Thuộc tính | Giá trị |
|-----------|-----------|---------|
| Default | background | `rgba(255, 234, 158, 0.10)` |
| Pressed | background | `rgba(255, 234, 158, 0.20)` |
| Disabled | border | `rgba(153, 140, 95, 0.4)` |
| Disabled | text color | `rgba(255, 255, 255, 0.4)` |

#### Nút text-only (Chi tiết trong award card)
| Trạng thái | Thuộc tính | Giá trị |
|-----------|-----------|---------|
| Default | background | transparent |
| Default | text color | `#FFFFFF` |
| Pressed | text color | `rgba(255, 255, 255, 0.7)` |

#### FAB
| Trạng thái | Thuộc tính | Giá trị |
|-----------|-----------|---------|
| Default | background | `#FFEA9E` |
| Pressed | background | `#E6D38E` (darken 10%) |
| Debounce | behavior | Chống nhấn đúp 300ms |

#### Tab Navigation
| Trạng thái | Thuộc tính | Giá trị |
|-----------|-----------|---------|
| Active | icon + text color | `#FFEA9E` |
| Inactive | icon + text color | `#FFFFFF` |
| Pressed | opacity | 0.7 |

### 1.7 Safe Area

| Vùng | Xử lý |
|------|-------|
| Top (notch/status bar) | Header bao gồm status bar 44px — tự xử lý bởi `SafeArea` hoặc `MediaQuery.of(context).padding.top` |
| Bottom (home indicator) | Thanh nav dưới 72px đã bao gồm safe area padding — bottom tab nằm trên home indicator |

## 2. Chi tiết Style từng Component

### 2.1 Header Bar (`mms_1_header`)
- **Node ID**: `6885:9057`
- **Kích thước**: 375 × 104px
- **Nền**: Linear gradient (tối → trong suốt, từ trên xuống)
- **Opacity**: 0.9
- **Vị trí**: Absolute, z-index 1 (sticky overlay)
- **Phần tử con**:
  - Status bar: 375 × 44px (hệ thống)
  - Logo: 48 × 44px (ảnh asset)
  - Hàng actions: 122 × 32px, gap 10px
    - Bộ chọn ngôn ngữ: 90 × 32px, radius 4px, padding 4px 0 4px 8px, gap 8px
      - Icon cờ VN: 24 × 24px (lá cờ Việt Nam với ngôi sao vàng trên nền đỏ, kích thước cờ 20 × 15px bên trong)
      - Text "VN": 14px/500 Montserrat, trắng
      - Mũi tên dropdown: 24 × 24px
    - Icon tìm kiếm: 24 × 24px
    - Icon chuông thông báo: 24 × 24px
      - Chấm badge: 8 × 8px, `#D4271D`, radius 100px

### 2.2 Nội dung Hero (`mms_2_content`)
- **Node ID**: `6885:8983`
- **Kích thước**: 335 × 453px
- **Gap**: 32px giữa phần tử con
- **Phần tử con**:
  - Logo Root Further: 247 × 109px (ảnh asset)
  - Khối đếm ngược: 335 × 112px, gap 8px
    - "Coming soon": 14px/300 Montserrat, trắng
    - Bộ đếm: 268 × 84px, gap 16px
      - Mỗi đơn vị (Days/Hours/Minutes): 72 × 84px, gap 4px
        - Hai ô số: 32 × 56px mỗi ô, gap 8px
          - Viền: 0.5px solid #FFEA9E, opacity 0.5
          - Nền: gradient trắng → 10% trắng
          - Số: 32px Digital Numbers, trắng, canh giữa
        - Nhãn: 18px/400 Montserrat, trắng
  - Khối thông tin sự kiện:
    - Dòng ngày: "Thời gian:" 14px/300 trắng + "26/12/2025" 18px/400 `#FFEA9E`
    - Dòng địa điểm: "Địa điểm:" 14px/300 trắng + "Âu Cơ Art Center" 18px/400 `#FFEA9E`
    - Ghi chú livestream: 14px/400 Montserrat, trắng, 2 dòng
  - Hàng nút:
    - "ABOUT AWARD": 160 × 40px, nền `#FFEA9E`, text `#00101A`, 14px/500, radius 4px, padding 12px, gap 8px
    - "ABOUT KUDOS": 159 × 40px, nền `rgba(255,234,158,0.10)`, viền 1px `#998C5F`, text trắng, 14px/500, padding 10px, gap 8px

### 2.3 Mô tả chủ đề (`mms_3_note`)
- **Node ID**: `6885:9028`
- **Kích thước**: 335 × 240px, gap 16px
- **Text**: 14px/300 Montserrat, line-height 20px, letter-spacing 0.25px, trắng
- **Nội dung**: Đoạn text nhiều dòng mô tả tinh thần "Root Further"

### 2.4 Phần Giải thưởng (`mms_4_awards`)
- **Node ID**: `6885:9030`
- **Kích thước**: 1040 × 375px (container cuộn ngang)
- **Gap**: 24px giữa header và danh sách

#### Header Section (`mms_4.1_header`)
- **Node ID**: `6885:9031`
- **Kích thước**: 335 × 53px, gap 4px
- Đường kẻ phân cách: 335 × 1px, `rgba(46, 57, 64, 1)`
- Nhãn: "Sun* Annual Awards 2025" — 12px/400 Montserrat, trắng
- Tiêu đề: "Hệ thống giải thưởng" — 22px/500 Montserrat, `#FFEA9E`

#### Danh sách Card Giải thưởng (`mms_4.2_award list`)
- **Node ID**: `6885:9032`
- **Kích thước**: 1040 × 298px (cuộn ngang)
- **Gap**: 16px giữa các card
- **Mỗi Card**: 160 × 298px, gap 12px
  - Ảnh giải thưởng: 160 × 160px, viền 0.455px solid #FFEA9E
  - Tên giải: 14px/500 Montserrat, `#FFEA9E`
  - Mô tả: 14px/300 Montserrat, trắng, tối đa 3 dòng (60px), ellipsis
  - Nút "Chi tiết": 84 × 32px, nền transparent, text 14px/500 trắng, radius 4px, padding 10px 0 (text-only button với icon mũi tên)

### 2.5 Phần Kudos (`mms_5_kudos`)
- **Node ID**: `6885:9039`
- **Kích thước**: 335 × 490px, gap 24px

#### Header Section (`mms_5.1_header`)
- **Node ID**: `6885:9040`
- **Kích thước**: 335 × 53px, gap 4px
- Đường kẻ phân cách: 335 × 1px, `rgba(46, 57, 64, 1)`
- Nhãn: "Phong trào ghi nhận" — 12px/400 Montserrat, trắng
- Tiêu đề: "Sun* Kudos" — 22px/500 Montserrat, `#FFEA9E`

#### Banner Kudos (`mms_5.2_mm_media_Sunkudos`)
- **Node ID**: `6885:9041`
- **Kích thước**: 335 × 145px
- Nền tối với đường chéo vàng
- Text "KUDOS": 27.96px SVN-Gotham, `#DBD1C1`, letter-spacing -13%

#### Mô tả Kudos
- "ĐIỂM MỚI CỦA SAA 2025" tiêu đề + đoạn mô tả
- 14px Montserrat, trắng

#### Nút "Chi tiết" (`mms_5.3_Button`)
- **Node ID**: `6885:9055`
- **Kích thước**: 160 × 40px
- Cùng style nút chính vàng (About Award)
- Icon: 24 × 24px (mũi tên)

### 2.6 Nút hành động nổi — FAB (`mms_6_float button`)
- **Node ID**: `6885:9058`
- **Container**: 89 × 48px, nền `#FFEA9E`, radius 100px, padding 8px, gap 8px
- **Phần tử con**: 
  - Icon bút chì: 24 × 24px
  - Ký tự "/": 24px Montserrat, `#00101A`
  - Icon Kudos logo: 24 × 24px
- **Vị trí**: Cố định, góc dưới-phải, overlay

### 2.7 Thanh điều hướng dưới (`mms_7_nav bar`)
- **Node ID**: `6885:9056`
- **Kích thước**: 375 × 72px
- **Nền**: `rgba(255, 234, 158, 0.15)`
- **Vùng tab**: 375 × 54px, padding 0 24px
- **Tabs** (4 mục, mỗi tab 60 × 44px, gap 4px):
  - Active ("SAA 2025"): Icon 24×24 (radius 4px) + label 12px/400 Montserrat, `#FFEA9E`
  - Inactive ("Awards", "Kudos", "Profile"): Icon 24×24 + label 12px/400 Montserrat, trắng

## 3. Sơ đồ Layout

```
┌─────────────────────────────── 375px ──────────────────────────────┐
│ HEADER (absolute, z:1)                              h: 104px      │
│ ┌─ StatusBar ─────────────────────────── 375×44 ─────────────────┐│
│ └────────────────────────────────────────────────────────────────┘│
│ ┌─ Logo(48×44) ── Actions(122×32: Lang|Search|Bell) ────────────┐│
│ └────────────────────────────────────────────────────────────────┘│
├──────────────────────────────────────────────────────────────────┤
│ BACKGROUND (absolute)                                            │
│ ┌─ Key Visual BG (881×723) + Shadow Left + Shadow Bottom ──────┐│
│ └──────────────────────────────────────────────────────────────┘│
├──────────────── NỘI DUNG CUỘN (335px căn giữa) ──────────────── │
│                                                                  │
│ ┌─ HERO CONTENT ──────── 335×453, gap:32 ──────────────────────┐│
│ │ Logo Root Further (247×109)                                   ││
│ │                                                               ││
│ │ ┌─ Đếm ngược ──── 268×84, gap:16 ──────────────────────────┐││
│ │ │ [2][0]  [2][0]  [2][0]                                    │││
│ │ │ DAYS    HOURS   MINUTES                                   │││
│ │ └──────────────────────────────────────────────────────────┘││
│ │ Thời gian: 26/12/2025                                       ││
│ │ Địa điểm: Âu Cơ Art Center                                  ││
│ │ Ghi chú livestream (2 dòng)                                  ││
│ │                                                               ││
│ │ ┌─[ABOUT AWARD]─┐ ┌─[ABOUT KUDOS]─┐                        ││
│ │ │  160×40 vàng   │ │ 159×40 outline│                        ││
│ │ └────────────────┘ └───────────────┘                        ││
│ └──────────────────────────────────────────────────────────────┘│
│                                                                  │
│ ┌─ MÔ TẢ CHỦ ĐỀ ─────────── 335×240 ─────────────────────────┐│
│ │ Đoạn body text (14px/300)                                     ││
│ └──────────────────────────────────────────────────────────────┘│
│                                                                  │
│ ┌─ PHẦN GIẢI THƯỞNG ── 1040×375 (cuộn ngang) ─────────────────┐│
│ │ Header: "Sun* Annual Awards 2025" / "Hệ thống giải thưởng"  ││
│ │ ┌─Card─┐ ┌─Card─┐ ┌─Card─┐  ... (160×298, gap:16)          ││
│ │ │ Ảnh  │ │ Ảnh  │ │ Ảnh  │                                  ││
│ │ │ Tên  │ │ Tên  │ │ Tên  │                                  ││
│ │ │ Mô tả│ │ Mô tả│ │ Mô tả│                                  ││
│ │ │ Link │ │ Link │ │ Link │                                  ││
│ │ └──────┘ └──────┘ └──────┘                                  ││
│ └──────────────────────────────────────────────────────────────┘│
│                                                                  │
│ ┌─ PHẦN KUDOS ──────────── 335×490, gap:24 ────────────────────┐│
│ │ Header: "Phong trào ghi nhận" / "Sun* Kudos"                 ││
│ │ ┌─ Banner ─── 335×145 ──────────────────────────────────────┐││
│ │ │ Nền tối + đường chéo vàng + text "KUDOS"                 │││
│ │ └──────────────────────────────────────────────────────────┘││
│ │ "ĐIỂM MỚI CỦA SAA 2025" + mô tả                            ││
│ │ ┌─[Chi tiết]──┐                                             ││
│ │ │ 160×40 vàng │                                             ││
│ │ └─────────────┘                                             ││
│ └──────────────────────────────────────────────────────────────┘│
│                                                                  │
├──────────────────────────────────────────────────────────────────┤
│ FAB (cố định, góc dưới-phải)               89×48, pill vàng    │
│ [Bút / S]                                                       │
├──────────────────────────────────────────────────────────────────┤
│ THANH NAV DƯỚI ──────────── 375×72 ──────────────────────────── │
│ ┌─[SAA 2025]─┬─[Awards]─┬─[Kudos]─┬─[Profile]─┐               │
│ │  active     │ inactive │inactive │ inactive  │               │
│ └────────────┴──────────┴─────────┴───────────┘               │
└──────────────────────────────────────────────────────────────────┘
```

## 4. Bảng ánh xạ Implementation

| Node ID | Tên Component | Flutter Widget | Ghi chú |
|---------|--------------|----------------|---------|
| `6885:9057` | Header | `HomeHeaderWidget` | Cố định, gradient overlay |
| `6885:8983` | Nội dung Hero | `HeroContentWidget` | Logo + đếm ngược + nút |
| `6885:8988` | Bộ đếm ngược | `CountdownTimerWidget` | Đếm ngược thời gian thực |
| `6885:9026` | Nút About Award | `PrimaryButton` (shared) | Style nền vàng |
| `6885:9027` | Nút About Kudos | `OutlineButton` (shared) | Style viền vàng |
| `6885:9028` | Mô tả chủ đề | `Text` widget | Khối text body |
| `6885:9030` | Phần Giải thưởng | `AwardsSectionWidget` | Header + danh sách ngang |
| `6885:9032` | Danh sách Card | `ListView.builder` horizontal | Cuộn ngang |
| `6885:9033` | Card Giải thưởng | `AwardCardWidget` (shared) | Ảnh + tên + mô tả + link |
| `6885:9039` | Phần Kudos | `KudosSectionWidget` | Header + banner + mô tả + nút |
| `6885:9058` | FAB | `FloatingActionButton` custom | Dạng pill, 2 hành động |
| `6885:9056` | Thanh Nav dưới | `BottomNavigationBar` custom | 4 tab, accent vàng |

## 5. Nền & Hiệu ứng thị giác

- **Key Visual**: Ảnh nền hero lớn (881 × 723px) đặt ở trên cùng
- **Shadow Left**: Gradient overlay `linear-gradient(90deg, #00101A 0%, #10181F 19%, transparent 77%)`
- **Shadow Bottom**: Gradient overlay `linear-gradient(90deg, #00101A 0%, #00101A 25%, transparent 100%)`
- **Chủ đề tổng thể**: Nền tối navy (`#00101A`) kết hợp accent vàng (`#FFEA9E`)

## 6. Asset Mapping — flutter_gen (BẮT BUỘC)

> Theo constitution v1.3.0: PHẢI sử dụng `flutter_gen` cho type-safe asset access.
> KHÔNG ĐƯỢC hardcode đường dẫn string. Chạy `dart run build_runner build` sau khi thêm/xóa asset.

### 6.1 Images (PNG/JPG) — `Assets.images.*`

| Asset file | flutter_gen reference | Sử dụng | Component |
|------------|----------------------|---------|-----------|
| `assets/images/home/key_visual_bg.png` | `Assets.images.home.keyVisualBg` | Ảnh nền hero | `HeroContentWidget` |
| `assets/images/home/root_further_logo.png` | `Assets.images.home.rootFurtherLogo` | Logo chủ đề | `HeroContentWidget` |
| `assets/images/home/logo_saa.png` | `Assets.images.home.logoSaa` | Logo header | `HomeHeaderWidget` |
| `assets/images/home/kudos_banner.png` | `Assets.images.home.kudosBanner` | Banner Kudos | `KudosSectionWidget` |

**Cách sử dụng**:
```dart
// ✅ ĐÚNG
Assets.images.home.keyVisualBg.image(fit: BoxFit.cover)
Assets.images.home.rootFurtherLogo.image(width: 247, height: 109)

// ❌ SAI
Image.asset('assets/images/home/key_visual_bg.png', fit: BoxFit.cover)
```

### 6.2 Icons (SVG) — `Assets.icons.*`

| Asset file | flutter_gen reference | Sử dụng | Component |
|------------|----------------------|---------|-----------|
| `assets/icons/ic_search.svg` | `Assets.icons.icSearch` | Icon tìm kiếm | `HomeHeaderWidget` |
| `assets/icons/ic_notification.svg` | `Assets.icons.icNotification` | Icon chuông | `HomeHeaderWidget` |
| `assets/icons/ic_arrow_down.svg` | `Assets.icons.icArrowDown` | Mũi tên dropdown | `LanguageSelector` |
| `assets/icons/ic_arrow_open.svg` | `Assets.icons.icArrowOpen` | Icon mũi tên nút | `PrimaryButton`, `OutlineButton` |
| `assets/icons/ic_pen.svg` | `Assets.icons.icPen` | Icon bút chì FAB | `KudosFabWidget` |
| `assets/icons/ic_kudos_logo.svg` | `Assets.icons.icKudosLogo` | Icon Kudos FAB | `KudosFabWidget` |
| `assets/icons/ic_home.svg` | `Assets.icons.icHome` | Tab Home | `BottomNavBar` |
| `assets/icons/ic_award.svg` | `Assets.icons.icAward` | Tab Awards | `BottomNavBar` |
| `assets/icons/ic_kudos.svg` | `Assets.icons.icKudos` | Tab Kudos | `BottomNavBar` |
| `assets/icons/ic_profile.svg` | `Assets.icons.icProfile` | Tab Profile | `BottomNavBar` |
| `assets/icons/flags/vn.svg` | `Assets.icons.flags.vn` | Cờ Việt Nam | `LanguageSelector` |
| `assets/icons/flags/en.svg` | `Assets.icons.flags.en` | Cờ Anh | `LanguageSelector` |

**Cách sử dụng**:
```dart
// ✅ ĐÚNG
Assets.icons.icSearch.svg(width: 24, height: 24,
    colorFilter: ColorFilter.mode(AppColors.textWhite, BlendMode.srcIn))

// ❌ SAI
SvgPicture.asset('assets/icons/ic_search.svg', width: 24, height: 24)
```

### 6.3 Fonts

| Asset file | flutter_gen reference | Sử dụng |
|------------|----------------------|---------|
| `assets/fonts/DigitalNumbers-Regular.ttf` | `Assets.fonts.digitalNumbersRegular` | Số đếm ngược |
