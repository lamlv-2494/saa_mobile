# Design Style: [iOS] Profile ban than

**Frame ID**: `hSH7L8doXB`
**Frame Name**: `[iOS] Profile ban than`
**Figma File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Figma Image**: [Xem anh](https://momorph.ai/api/images/9ypp4enmFmdK3YAFJLIu6C/6885:10333/7637afb582dce1bbc2dad336d2ff29fc.png)
**Ngay trich xuat**: 2026-04-14

---

## Design Tokens

### Mau sac

| Token | Hex | Opacity | Su dung |
|-------|-----|---------|---------|
| --color-bg-screen | #00101A | 100% | Nen man hinh chinh |
| --color-surface-dark | #00070C | 100% | Nen card thong ke |
| --color-surface-card | #FFF8E1 | 100% | Nen the Kudos (highlight card) |
| --color-primary-gold | #FFEA9E | 100% | Mau accent chinh — tieu de section, text highlight, border |
| --color-primary-10 | rgba(255, 234, 158, 0.10) | 10% | Nen dropdown filter |
| --color-primary-40 | rgba(255, 234, 158, 0.40) | 40% | Nen khung noi dung kudos |
| --color-border | #998C5F | 100% | Border cho card thong ke, button |
| --color-text-white | #FFFFFF | 100% | Text chinh tren nen toi |
| --color-text-accent | #FFEA9E | 100% | Text highlight (tieu de section, so lieu) |
| --color-text-secondary | #999999 | 100% | Text phu (thoi gian, ma team) |
| --color-text-dark | #00101A | 100% | Text tren card sang (Kudos card) |
| --color-divider | #2E3940 | 100% | Duong ke phan cach |
| --color-heart | #F17676 | 100% | Icon heart |
| --color-hashtag | #D4271D | 100% | Text hashtag |
| --color-spam | #FF8C00 | 100% | Label spam (orange pill) |
| --color-icon-dark | #1A1A2E | 100% | Nen icon badge trong bo suu tap |

### Typography

| Token | Font Family | Size | Weight | Line Height | Letter Spacing | Su dung |
|-------|-------------|------|--------|-------------|----------------|---------|
| --text-user-name | Montserrat | 18px | 700 | 24px | 0px | Ten nguoi dung (mau vang #FFEA9E) |
| --text-team-code | Montserrat | 14px | 400 | 20px | 0px | Ma team (CEVC3) — mau trang #FFFFFF |
| --text-badge-title | Montserrat | 12px | 500 | 16px | 0px | Danh hieu — chi de tham khao; implementation dung PNG asset |
| --text-section-label | Montserrat | 12px | 400 | 16px | 0px | Label section "Bo suu tap icon cua toi" (mau trang #FFFFFF) |
| --text-stat-label | Montserrat | 12px | 400 | 16px | 0px | Label thong ke |
| --text-stat-value | Montserrat | 14px | 700 | 20px | 0px | Gia tri thong ke (so) |
| --text-section-title | Montserrat | 22px | 500 | 28px | 0px | Tieu de "KUDOS" |
| --text-section-subtitle | Montserrat | 12px | 400 | 16px | 0px | "Sun* Annual Awards 2025" |
| --text-dropdown-label | Montserrat | 14px | 500 | 20px | 0px | Label dropdown filter |
| --text-card-name | Montserrat | 10px | 400 | 16px | 0px | Ten nguoi gui/nhan trong card |
| --text-card-time | Montserrat | 10px | 500 | 11px | 0px | Thoi gian dang |
| --text-card-title | Montserrat | 10px | 700 | 11px | 0px | Tieu de kudos (VD: IDOL GIOI TRE) |
| --text-card-content | Montserrat | 10px | 400 | 14px | 0px | Noi dung loi cam on |
| --text-card-hashtag | Montserrat | 10px | 400 | 11px | 0px | Hashtag (#Dedicated) |
| --text-card-action | Montserrat | 10px | 500 | 11px | 0px | Nut hanh dong (Copy Link, Xem chi tiet) |
| --text-heart-count | Montserrat | 10px | 400 | 15px | 0px | So luot heart |
| --text-button | Montserrat | 14px | 500 | 20px | 0px | Nut "Mo Secret Box" |
| --text-nav-label | Montserrat | 10px | 500 | 12px | 0px | Label bottom nav tab |
| --text-status-bar | SF Pro Text | 15px | 600 | 20px | -0.5px | Thoi gian status bar iOS |

### Spacing

| Token | Gia tri | Su dung |
|-------|---------|---------|
| --spacing-xs | 4px | Gap nho (icon-text, language indicator) |
| --spacing-sm | 8px | Gap giua items trong card, padding nho |
| --spacing-md | 10px | Padding button CTA |
| --spacing-lg | 12px | Padding card thong ke, gap giua stat rows |
| --spacing-xl | 16px | Gap dropdown filter, gap giua elements |
| --spacing-2xl | 20px | Padding ngang man hinh |
| --spacing-3xl | 24px | Gap giua sections chinh |
| --spacing-4xl | 32px | Gap lon |

### Border & Radius

| Token | Gia tri | Su dung |
|-------|---------|---------|
| --radius-avatar | 50% (circle) | Avatar nguoi dung va avatar tren card |
| --radius-icon-badge | 50% (circle) | Icon badge trong bo suu tap |
| --radius-card-stats | 8px | Card thong ke |
| --radius-card-kudos | 0px | The kudos (khong bo goc) |
| --radius-dropdown | 4px | Dropdown filter button |
| --radius-action-btn | 2px | Nut hanh dong tren card |
| --radius-pill | 100px | Spam label pill |
| --border-card-stats | 0.794px solid #998C5F | Vien card thong ke |
| --border-card-kudos | 1px solid #FFEA9E | Vien the kudos |
| --border-avatar | 0.865px solid #FFF | Vien avatar |
| --border-dropdown | 1px solid #998C5F | Vien dropdown button |
| --border-divider | 1px | Duong ke phan cach (height: 0, dung background color) |

### Shadows

| Token | Gia tri | Su dung |
|-------|---------|---------|
| --shadow-none | none | Phan lon components (flat design) |

> **Ghi chu**: Thiet ke su dung flat design — khong co box-shadow truyen thong.

---

## Layout Specifications

### Container

| Thuoc tinh | Gia tri | Ghi chu |
|-----------|---------|---------|
| width | 375px | iPhone standard |
| height | Scrollable | Khong gioi han chieu cao |
| background | #00101A | Nen toi |
| padding-x | 20px | Padding ngang |

### Cau truc Layout (ASCII)

```
+-----------------------------------------------+
|  Status Bar (iOS)                              |
+-----------------------------------------------+
|  App Header (Logo, VN flag, Search, Bell)      |
+-----------------------------------------------+
|                                                |
|  +-------------------------------------------+|
|  |  Avatar (circle, 64px)                    ||
|  |  Ten: Huynh Duong Xuan Nhat              ||
|  |  Team: CEVC3                              ||
|  |  Badge: Legend Hero                       ||
|  +-------------------------------------------+|
|                                                |
|  Bo suu tap icon cua toi                       |
|  [icon] [icon] [icon] [icon] [icon] [icon]     |
|                                                |
|  +-------------------------------------------+|
|  |  THONG KE (dark panel)                    ||
|  |  So Kudos ban nhan duoc          5        ||
|  |  So Kudos ban da gui             25       ||
|  |  So tim ban nhan duoc            25       ||
|  |  ─────────────────────────────────        ||
|  |  So Secret Box ban da mo         25       ||
|  |  So Secret Box chua mo           25       ||
|  |  [Mo Secret Box]                          ||
|  +-------------------------------------------+|
|                                                |
|  +-------------------------------------------+|
|  |  Sun* Annual Awards 2025                  ||
|  |  KUDOS (large gold text)                  ||
|  +-------------------------------------------+|
|  [Dropdown: Da gui (5) v]                      |
|                                                |
|  +-------------------------------------------+|
|  |  Kudos Card 1 (highlight)                 ||
|  |  Sender -> Receiver                       ||
|  |  Timestamp | Category | Message           ||
|  |  Photos | Hashtags                        ||
|  |  Heart | Copy Link | Xem chi tiet         ||
|  +-------------------------------------------+|
|  +-------------------------------------------+|
|  |  Kudos Card 2                             ||
|  +-------------------------------------------+|
|  +-------------------------------------------+|
|  |  Kudos Card 3                             ||
|  +-------------------------------------------+|
|                                                |
+-----------------------------------------------+
|  [SAA 2025] [Awards] [Kudos] [Profile*]        |
+-----------------------------------------------+
```

---

## Chi tiet Style tung Component

### 1. Profile Info Container (Node: 6885:10339)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| layout | Column, center aligned | `Column(crossAxisAlignment: center)` |
| padding | 16px top, 20px horizontal | `EdgeInsets` |
| gap | 8px giua avatar va ten | `SizedBox(height: 8)` |

### 1.1. Avatar

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| size | 72x72px | `CircleAvatar(radius: 36)` |
| shape | Circle | `ClipOval` |
| border | 1.911px solid #FFF | `Border.all(color: Colors.white, width: 1.911)` |
| fallback | Chu cai dau tren nen gradient | `Text(initial)` |

### 1.1.1. Profile Info Container gap

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| gap (avatar → name group) | 24px | `SizedBox(height: 24)` |
| layout | Column, center aligned | `Column(crossAxisAlignment: CrossAxisAlignment.center)` |

### 1.2. User Name

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| font | Montserrat 18px Bold | `TextStyle(fontSize: 18, fontWeight: FontWeight.w700)` |
| color | #FFEA9E (vang) | `Color(0xFFFFEA9E)` |

### 1.3. Team Code

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| font | Montserrat 14px Regular | `TextStyle(fontSize: 14, fontWeight: FontWeight.w400)` |
| color | #FFFFFF (trang) | `Colors.white` |

### 1.4. Hero Tier Image

> **Ghi chu quan trong**: Danh hieu hero tier (Legend Hero, Rising Hero, v.v.) KHONG hien thi la text ma hien thi la anh PNG local. Figma mock dung text nhung implementation su dung asset.

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| loai | Anh PNG local (khong phai text) | `Image.asset(...)` hoac `Assets.images.xxx.image(...)` |
| nguon | `AssetMapper.heroTierImage(heroTier)` voi `heroTier` la slug string | `UserProfile.heroTier: String` — vi du: `'legend_hero'`, `'rising_hero'`, `'none'` |
| fallback | Khong hien thi neu heroTier = 'none' hoac asset khong tim thay | `if (img == null) SizedBox.shrink()` |
| height | ~20px (chieu cao anhanh) | `height: 20` |

### 2. Icon Collection Section (Node: 6885:10349)

> **Ghi chu**: Section nay hoan toan la display-only — icon badge KHONG co tuong tac.

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| layout | Column | `Column` |
| padding | 20px horizontal | `EdgeInsets.symmetric(horizontal: 20)` |
| gap | 12px (label -> icons) | `SizedBox(height: 12)` |

### 2.1. Icon Badge Slot (Node: 6885:10351)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| size | 32x32px | `Container(width: 32, height: 32)` |
| shape | Circle | `BoxDecoration(shape: BoxShape.circle)` |
| background | Dark (#1A1A2E) | `Color(0xFF1A1A2E)` |
| gap (giua badges) | 14px | `SizedBox(width: 14)` |

### 3. Statistics Container (Node: 6885:10358)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| background | #00070C | `Color(0xFF00070C)` |
| border | 0.794px solid #998C5F | `Border.all(color: Color(0xFF998C5F), width: 0.794)` |
| border-radius | 8px | `BorderRadius.circular(8)` |
| padding | 12px | `EdgeInsets.all(12)` |
| margin | 20px horizontal | `EdgeInsets.symmetric(horizontal: 20)` |

### 3.1. Stat Row

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| layout | Row, space-between | `Row(mainAxisAlignment: MainAxisAlignment.spaceBetween)` |
| label font | Montserrat 12px Regular | `TextStyle(fontSize: 12, fontWeight: FontWeight.w400)` |
| label color | #FFFFFF | `Colors.white` |
| value font | Montserrat 14px Bold | `TextStyle(fontSize: 14, fontWeight: FontWeight.w700)` |
| value color | #FFEA9E | `Color(0xFFFFEA9E)` |
| gap giua rows | 12px | `SizedBox(height: 12)` |

### 3.2. Content Divider (Node: 6885:10375)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| height | 0px (visual separator) | `Divider(height: 1)` |
| color | #2E3940 | `Color(0xFF2E3940)` |
| margin | 12px vertical | `EdgeInsets.symmetric(vertical: 12)` |

### 3.3. Button "Mo Secret Box" (Node: 6885:10386)

> **Ghi chu**: Day la nut PRIMARY (solid gold background) — KHONG phai secondary outline button.

**Trang thai Enabled (secretBoxUnopened > 0):**

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| width | 100% (312px) | `double.infinity` |
| height | 40px | `SizedBox(height: 40)` |
| background | #FFEA9E (solid gold) | `Color(0xFFFFEA9E)` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| font | Montserrat 14px Medium | `TextStyle(fontSize: 14, fontWeight: FontWeight.w500)` |
| text color | #00101A (toi) | `Color(0xFF00101A)` |
| text | "Mo Secret Box" | i18n key |
| icon | 24x24px (ben phai text) | `Assets.icons.icXxx.svg()` |
| gap (icon-text) | 8px | `gap: 8px` |

**Trang thai Disabled (secretBoxUnopened == 0):**

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| background | #FFEA9E voi opacity 0.4 | `Color(0xFFFFEA9E).withOpacity(0.4)` |
| text color | #00101A voi opacity 0.4 | `Color(0xFF00101A).withOpacity(0.4)` |
| cursor | not-allowed | `IgnorePointer` hoac `onPressed: null` |

### 4. Kudos Section Header (Node: 6885:10387)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| background | Decorative banner image | `Assets.images.kudosKeyVisualBg` |
| subtitle font | Montserrat 12px Regular | `TextStyle(fontSize: 12, fontWeight: FontWeight.w400)` |
| subtitle color | #FFFFFF | `Colors.white` |
| title font | Montserrat 22px Medium | `TextStyle(fontSize: 22, fontWeight: FontWeight.w500)` |
| title color | #FFEA9E | `Color(0xFFFFEA9E)` |

### 4.1. Kudos Filter Dropdown (Node: 6885:10388)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| background | rgba(255, 234, 158, 0.10) | `Color(0xFFFFEA9E).withOpacity(0.1)` |
| border | 1px solid #998C5F | `Border.all(color: Color(0xFF998C5F))` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| padding | 8px 12px | `EdgeInsets.symmetric(horizontal: 12, vertical: 8)` |
| font | Montserrat 14px Medium | `TextStyle(fontSize: 14, fontWeight: FontWeight.w500)` |
| color | #FFEA9E | `Color(0xFFFFEA9E)` |
| icon | Chevron down SVG | `Assets.icons.icChevronDown.svg()` |

### A. Dropdown Overlay (Node: 6891:17101)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| background | #00070C | `Color(0xFF00070C)` |
| border | 1px solid #998C5F | `Border.all(color: Color(0xFF998C5F))` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| padding | 6px | `EdgeInsets.all(6)` |
| width | 118px | `width: 118` |
| options | 2 pill buttons (Da nhan, Da gui) | `Column` |

**Option button (moi option):**

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| width | 106px | `width: 106` |
| height | 40px | `height: 40` |
| padding | 16px 12px | `EdgeInsets.symmetric(horizontal: 12, vertical: 16)` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| font | Montserrat 14px Medium | `TextStyle(fontSize: 14, fontWeight: FontWeight.w500)` |
| color | #FFFFFF | `Colors.white` |

**Trang thai option:**

| Trang thai | Background | Ghi chu |
|-----------|-----------|---------|
| Dang duoc chon (selected) | rgba(255, 234, 158, 0.10) | Option hien tai dang active |
| Khong duoc chon | Transparent | Khong co nen dac biet |

> **Ghi chu vi tri**: Overlay hien thi phia duoi filter button, vi tri khop voi Figma design. Widget: dung `Overlay` hoac `Stack` + `Positioned` can chinh theo cung canh voi dropdown button.

### 5. Kudos Card (Reusable — tham chieu component chung)

> Kudos card su dung cung component voi man hinh Sun*Kudos (screenId: `fO0Kt19sZZ`) va All Kudos (screenId: `j_a2GQWKDJ`). Xem chi tiet tai `.momorph/specs/fO0Kt19sZZ-ios-sun-kudos/design-style.md` va `.momorph/specs/j_a2GQWKDJ-ios-all-kudos/design-style.md`.

| Thuoc tinh | Gia tri |
|-----------|---------|
| background | #FFF8E1 |
| border | 1px solid #FFEA9E |
| content-bg | rgba(255, 234, 158, 0.40) |
| text-dark | #00101A |
| card-gap | 8px |

### 6. Bottom Navigation Bar (Node: 6885:10394)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| height | 83px (bao gom safe area) | `BottomNavigationBar` |
| background | #00101A | `Color(0xFF00101A)` |
| border-top | 1px solid #2E3940 | `Border(top: BorderSide(...))` |
| active tab color | #FFEA9E | `Color(0xFFFFEA9E)` |
| inactive tab color | #999999 | `Color(0xFF999999)` |
| icon size | 24x24px | SVG via `Assets.icons` |
| label font | Montserrat 10px Medium | `TextStyle(fontSize: 10, fontWeight: FontWeight.w500)` |
| tabs | SAA 2025, Awards, Kudos, Profile (active) | 4 items |

---

## Phan cap Component voi Styles

```
Screen (bg: #00101A)
+-- ScrollView
|   +-- AppHeader (h: 44px, flex, items-center, justify-between)
|   |   +-- Logo SAA 2025 (image asset)
|   |   +-- VN Flag (SVG icon)
|   |   +-- Search Icon (SVG, 24x24, color: white)
|   |   +-- Bell Icon (SVG, 24x24, color: white)
|   |
|   +-- ProfileInfoContainer (column, gap: 24px, center)
|   |   +-- Avatar (72x72, circle, border: 1.911px white)
|   |   +-- NameGroup (Column, gap: 4px)
|   |       +-- UserName (Montserrat 18px Bold, #FFEA9E)
|   |       +-- DetailRow (Row, gap: 4.78px)
|   |           +-- TeamCode (Montserrat 14px Regular, #FFFFFF)
|   |           +-- SeparatorDot (2x2px, #999999)
|   |           +-- HeroTierImage (PNG asset, height: ~12px)
|   |
|   +-- IconCollectionSection (px: 20px)
|   |   +-- SectionLabel (Montserrat 12px Regular, #FFFFFF)
|   |   +-- IconRow (Row, gap: 14px)
|   |       +-- IconBadgeSlot (32x32, circle, dark bg) x N
|   |
|   +-- StatisticsContainer (mx: 20px, p: 12px, bg: #00070C, border: #998C5F, radius: 8)
|   |   +-- StatRow "Kudos nhan" (label: white, value: #FFEA9E)
|   |   +-- StatRow "Kudos gui"
|   |   +-- StatRow "Hearts nhan"
|   |   +-- Divider (#2E3940)
|   |   +-- StatRow "Secret Box da mo"
|   |   +-- StatRow "Secret Box chua mo"
|   |   +-- Button "Mo Secret Box" (bg: primary-10, border: #998C5F, text: #FFEA9E)
|   |
|   +-- KudosSectionHeader (banner image)
|   |   +-- Subtitle "Sun* Annual Awards 2025" (Montserrat 12px, white)
|   |   +-- Title "KUDOS" (Montserrat 22px Medium, #FFEA9E)
|   |
|   +-- FilterDropdown (bg: primary-10, border: #998C5F, radius: 4px)
|   |   +-- Label "Da gui (5)" (Montserrat 14px Medium, #FFEA9E)
|   |   +-- ChevronDown Icon (SVG)
|   |
|   +-- KudosList (Column, gap: 24px)
|       +-- KudosCard (reusable component) x N
|           +-- SenderReceiverBlock
|           +-- ContentBlock
|           +-- ActionBar
|
+-- BottomNavBar (h: 83px, bg: #00101A, border-top: #2E3940)
    +-- Tab "SAA 2025" (inactive, #999)
    +-- Tab "Awards" (inactive, #999)
    +-- Tab "Kudos" (inactive, #999)
    +-- Tab "Profile" (active, #FFEA9E)
```

---

## Icon Specifications

| Icon | Size | Color | Su dung | Asset path |
|------|------|-------|---------|------------|
| ic_search | 24x24 | #FFFFFF | Header search | `Assets.icons.icSearch.svg()` |
| ic_notification | 24x24 | #FFFFFF | Header bell | `Assets.icons.icNotification.svg()` |
| ic_chevron_down | 16x16 | #FFEA9E | Dropdown indicator | `Assets.icons.icChevronDown.svg()` |
| ic_heart | 16x16 | #F17676 | Heart reaction (filled) | `Assets.icons.icHeart.svg()` |
| ic_heart_outline | 16x16 | #F17676 | Heart reaction (unfilled) | `Assets.icons.icHeartOutline.svg()` |
| ic_copy | 16x16 | #999999 | Copy link action | `Assets.icons.icCopy.svg()` |
| ic_arrow_right | 12x12 | #00101A | Sender -> Receiver arrow | `Assets.icons.icArrowRight.svg()` |
| ic_external | 16x16 | #999999 | "Xem chi tiet" action | `Assets.icons.icExternal.svg()` |
| ic_home | 24x24 | #999999 / #FFEA9E | Nav tab SAA 2025 | `Assets.icons.icHome.svg()` |
| ic_trophy | 24x24 | #999999 / #FFEA9E | Nav tab Awards | `Assets.icons.icTrophy.svg()` |
| ic_kudos | 24x24 | #999999 / #FFEA9E | Nav tab Kudos | `Assets.icons.icKudos.svg()` |
| ic_profile | 24x24 | #999999 / #FFEA9E | Nav tab Profile | `Assets.icons.icProfile.svg()` |
| vn flag | 20x14 | Original | Language indicator | `Assets.icons.flags.vn.svg()` |

---

## Animation & Transitions

| Element | Thuoc tinh | Duration | Easing | Trigger |
|---------|-----------|----------|--------|---------|
| Dropdown overlay | opacity, transform | 200ms | ease-out | Open/Close |
| Heart toggle | scale, color | 150ms | ease-in-out | Tap |
| Pull-to-refresh | - | - | system default | Pull down |

---

## Responsive Specifications

> Ung dung chi danh cho mobile iOS — khong co breakpoints responsive. Width co dinh 375px (iPhone standard), su dung `MediaQuery` de xu ly cac kich thuoc man hinh khac nhau.

---

## So sanh voi Profile nguoi khac

| Thuoc tinh | Profile ban than (`hSH7L8doXB`) | Profile nguoi khac (`bEpdheM0yU`) |
|-----------|--------------------------------|-----------------------------------|
| Header | App header (logo, search, bell) | Header voi nut back |
| Statistics Container | Co (dark panel voi thong ke) | Khong co |
| Button "Mo Secret Box" | Co | Khong co |
| Button "Gui loi cam on" | Khong co | Co (CTA chinh) |
| Badge Collection | Icon collection (chi icon) | Badge collection (icon + ten) |
| Bottom Nav | Profile tab active | Tat ca tab inactive |
| Route | Tab navigation (tab 4) | Push navigation (voi userId param) |

---

## Ghi chu

- Tat ca mau sac nen su dung theme tokens de ho tro dark mode (neu can trong tuong lai).
- Icons PHAI su dung SVG format va render qua `flutter_svg`.
- Asset paths PHAI su dung `flutter_gen` (`Assets.xxx`), khong hardcode string.
- Font Montserrat duoc su dung xuyen suot — dam bao da duoc khai bao trong pubspec.yaml.
- Kudos card la reusable component — cung widget class cho Profile, Kudos feed, va All Kudos.
