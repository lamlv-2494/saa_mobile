# Design Style: [iOS] Profile nguoi khac

**Frame ID**: `bEpdheM0yU`
**Frame Name**: `[iOS] Profile nguoi khac`
**Figma File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Figma Image**: [Xem anh](https://momorph.ai/api/images/9ypp4enmFmdK3YAFJLIu6C/6885:10395/2d6b44ede5685689ae76b802af4b15fe.png)
**Ngay trich xuat**: 2026-04-14

---

## Design Tokens

### Mau sac

| Token | Hex | Opacity | Su dung |
|-------|-----|---------|---------|
| --color-bg-screen | #00101A | 100% | Nen man hinh chinh |
| --color-surface-card | #FFF8E1 | 100% | Nen the Kudos |
| --color-primary-gold | #FFEA9E | 100% | Mau accent chinh — tieu de, text highlight, border, badge |
| --color-primary-10 | rgba(255, 234, 158, 0.10) | 10% | Nen dropdown filter, nen button CTA |
| --color-primary-40 | rgba(255, 234, 158, 0.40) | 40% | Nen khung noi dung kudos |
| --color-border | #998C5F | 100% | Border cho button, dropdown |
| --color-text-white | #FFFFFF | 100% | Text chinh tren nen toi |
| --color-text-accent | #FFEA9E | 100% | Text highlight (tieu de, danh hieu, so lieu) |
| --color-text-secondary | #999999 | 100% | Text phu (thoi gian, ma team) |
| --color-text-dark | #00101A | 100% | Text tren card sang (Kudos card) |
| --color-divider | #2E3940 | 100% | Duong ke phan cach |
| --color-heart | #F17676 | 100% | Icon heart |
| --color-hashtag | #D4271D | 100% | Text hashtag |
| --color-badge-bg | #1A1A2E | 100% | Nen icon huy hieu |
| --color-cta-bg | rgba(255, 234, 158, 0.10) | 10% | Nen nut "Gui loi cam on" |

### Typography

| Token | Font Family | Size | Weight | Line Height | Letter Spacing | Su dung |
|-------|-------------|------|--------|-------------|----------------|---------|
| --text-navbar-title | Helvetica Neue | 17px | 500 | 24px | -- | Tieu de navbar (neu co) |
| --text-user-name | Montserrat | 16px | 700 | 22px | 0px | Ten nguoi dung |
| --text-team-code | Montserrat | 12px | 500 | 16px | 0px | Ma team |
| --text-badge-title | Montserrat | 12px | 500 | 16px | 0px | Danh hieu (Legend Hero) |
| --text-section-label | Montserrat | 14px | 500 | 20px | 0px | Label section |
| --text-badge-name | Montserrat | 10px | 400 | 12px | 0px | Ten huy hieu (duoi icon) |
| --text-section-title | Montserrat | 22px | 500 | 28px | 0px | Tieu de "KUDOS" |
| --text-section-subtitle | Montserrat | 12px | 400 | 16px | 0px | "Sun* Annual Awards 2025" |
| --text-dropdown-label | Montserrat | 14px | 500 | 20px | 0px | Label dropdown filter |
| --text-button-cta | Montserrat | 14px | 600 | 20px | 0px | Nut "Gui loi cam on" |
| --text-card-name | Montserrat | 10px | 400 | 16px | 0px | Ten nguoi gui/nhan trong card |
| --text-card-time | Montserrat | 10px | 500 | 11px | 0px | Thoi gian dang |
| --text-card-title | Montserrat | 10px | 700 | 11px | 0px | Tieu de kudos |
| --text-card-content | Montserrat | 10px | 400 | 14px | 0px | Noi dung loi cam on |
| --text-card-hashtag | Montserrat | 10px | 400 | 11px | 0px | Hashtag |
| --text-card-action | Montserrat | 10px | 500 | 11px | 0px | Nut hanh dong |
| --text-heart-count | Montserrat | 10px | 400 | 15px | 0px | So luot heart |
| --text-nav-label | Montserrat | 10px | 500 | 12px | 0px | Label bottom nav tab |
| --text-status-bar | SF Pro Text | 15px | 600 | 20px | -0.5px | Thoi gian status bar iOS |

### Spacing

| Token | Gia tri | Su dung |
|-------|---------|---------|
| --spacing-xs | 4px | Gap nho |
| --spacing-sm | 8px | Gap giua items, padding nho |
| --spacing-md | 10px | Padding button |
| --spacing-lg | 12px | Padding card, gap giua stat rows, gap giua badges |
| --spacing-xl | 16px | Gap dropdown, gap giua elements |
| --spacing-2xl | 20px | Padding ngang man hinh |
| --spacing-3xl | 24px | Gap giua sections chinh |
| --spacing-4xl | 32px | Gap lon |

### Border & Radius

| Token | Gia tri | Su dung |
|-------|---------|---------|
| --radius-avatar | 50% (circle) | Avatar nguoi dung va avatar tren card |
| --radius-badge-icon | 50% (circle) | Icon huy hieu |
| --radius-card-kudos | 0px | The kudos (khong bo goc) |
| --radius-dropdown | 4px | Dropdown filter button |
| --radius-cta-button | 4px | Nut "Gui loi cam on" |
| --radius-action-btn | 2px | Nut hanh dong tren card |
| --border-card-kudos | 1px solid #FFEA9E | Vien the kudos |
| --border-avatar | 0.865px solid #FFF | Vien avatar |
| --border-dropdown | 1px solid #998C5F | Vien dropdown button |
| --border-cta | 1px solid #998C5F | Vien nut CTA |
| --border-divider | 1px | Duong ke phan cach |

### Shadows

| Token | Gia tri | Su dung |
|-------|---------|---------|
| --shadow-none | none | Phan lon components (flat design) |

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
|  [<] Header (co nut back)                      |
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
|  [Revival] [Touch Of Light] [Stay Gold]        |
|  [Flow To Horizon] [Beyond The Boundary]       |
|  [Root Futher]                                 |
|                                                |
|  +-------------------------------------------+|
|  | [Gui loi cam on]  (CTA button, full width)||
|  +-------------------------------------------+|
|                                                |
|  +-------------------------------------------+|
|  |  Sun* Annual Awards 2025                  ||
|  |  KUDOS (large gold text)                  ||
|  +-------------------------------------------+|
|  [Dropdown: Da nhan (N) v]                     |
|                                                |
|  +-------------------------------------------+|
|  |  Kudos Card 1 (highlight)                 ||
|  +-------------------------------------------+|
|  +-------------------------------------------+|
|  |  Kudos Card 2 (highlight)                 ||
|  +-------------------------------------------+|
|  +-------------------------------------------+|
|  |  Kudos Card 3 (highlight)                 ||
|  +-------------------------------------------+|
|  +-------------------------------------------+|
|  |  Kudos Card 4 (normal)                    ||
|  +-------------------------------------------+|
|  +-------------------------------------------+|
|  |  Kudos Card 5 (normal)                    ||
|  +-------------------------------------------+|
|                                                |
+-----------------------------------------------+
|  [SAA 2025] [Awards] [Kudos] [Profile]         |
+-----------------------------------------------+
```

---

## Chi tiet Style tung Component

### 1. Header voi nut Back

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| height | 44px | `AppBar(toolbarHeight: 44)` |
| background | transparent (overlay tren scroll) | `Colors.transparent` |
| back icon | Chevron left SVG, 24x24, white | `Assets.icons.icBack.svg()` |
| title | Khong co (hoac ten nguoi dung) | -- |

### 2. Member Info Container (Node: 6885:10401)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| layout | Column, center aligned | `Column(crossAxisAlignment: center)` |
| padding | 16px top, 20px horizontal | `EdgeInsets` |
| gap | 8px giua avatar va ten | `SizedBox(height: 8)` |

### 2.1. Avatar

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| size | 64x64px | `CircleAvatar(radius: 32)` |
| shape | Circle | `ClipOval` |
| border | 0.865px solid #FFF | `Border.all(color: Colors.white, width: 0.865)` |
| fallback | Chu cai dau tren nen gradient | `Text(initial)` |

### 2.2. User Name

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| font | Montserrat 16px Bold | `TextStyle(fontSize: 16, fontWeight: FontWeight.w700)` |
| color | #FFFFFF | `Colors.white` |

### 2.3. Team Code

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| font | Montserrat 12px Medium | `TextStyle(fontSize: 12, fontWeight: FontWeight.w500)` |
| color | #999999 | `Color(0xFF999999)` |

### 2.4. Badge Title

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| font | Montserrat 12px Medium | `TextStyle(fontSize: 12, fontWeight: FontWeight.w500)` |
| color | #FFEA9E | `Color(0xFFFFEA9E)` |

### 3. Badge Collection Section (Node: 6885:10411)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| layout | Wrap (nhieu hang) | `Wrap(spacing: 12, runSpacing: 12)` |
| padding | 20px horizontal | `EdgeInsets.symmetric(horizontal: 20)` |
| gap | 12px (giua cac badge) | `spacing: 12` |

### 3.x. Badge Item (Node: 6885:10412 - 6885:10417)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| layout | Column (icon + ten) | `Column(children: [icon, text])` |
| icon size | 44x44px | `Container(width: 44, height: 44)` |
| icon shape | Circle | `BoxDecoration(shape: BoxShape.circle)` |
| icon background | #1A1A2E | `Color(0xFF1A1A2E)` |
| name font | Montserrat 10px Regular | `TextStyle(fontSize: 10, fontWeight: FontWeight.w400)` |
| name color | #FFFFFF | `Colors.white` |
| gap (icon -> name) | 4px | `SizedBox(height: 4)` |

**Danh sach huy hieu theo thiet ke**:
| No | Node ID | Ten |
|----|---------|-----|
| 3.1 | 6885:10412 | Revival |
| 3.2 | 6885:10413 | Touch Of Light |
| 3.3 | 6885:10414 | Stay Gold |
| 3.4 | 6885:10415 | Flow To Horizon |
| 3.5 | 6885:10416 | Beyond The Boundary |
| 3.6 | 6885:10417 | Root Futher |

### A.1. Button "Gui loi cam on" (Node: 6885:10427)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| width | 100% (tru padding ngang) | `double.infinity` |
| height | 44px | `SizedBox(height: 44)` |
| background | rgba(255, 234, 158, 0.10) | `Color(0xFFFFEA9E).withOpacity(0.1)` |
| border | 1px solid #998C5F | `Border.all(color: Color(0xFF998C5F))` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| font | Montserrat 14px SemiBold | `TextStyle(fontSize: 14, fontWeight: FontWeight.w600)` |
| color | #FFEA9E | `Color(0xFFFFEA9E)` |
| text | i18n key: profile.sendKudosButton | `context.t.profile.sendKudosButton` |
| icon | Pencil/edit SVG (truoc text) | `Assets.icons.icEdit.svg()` |
| alignment | Center | `MainAxisAlignment.center` |

### 6. Kudos Section Header (Node: 6885:10418)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| background | Decorative banner image | `Assets.images.xxx` |
| subtitle font | Montserrat 12px Regular | `TextStyle(fontSize: 12, fontWeight: FontWeight.w400)` |
| subtitle color | #FFFFFF | `Colors.white` |
| title font | Montserrat 22px Medium | `TextStyle(fontSize: 22, fontWeight: FontWeight.w500)` |
| title color | #FFEA9E | `Color(0xFFFFEA9E)` |

### 7. Kudos Filter Dropdown (Node: 6885:10419)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| background | rgba(255, 234, 158, 0.10) | `Color(0xFFFFEA9E).withOpacity(0.1)` |
| border | 1px solid #998C5F | `Border.all(color: Color(0xFF998C5F))` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| padding | 8px 12px | `EdgeInsets.symmetric(horizontal: 12, vertical: 8)` |
| font | Montserrat 14px Medium | `TextStyle(fontSize: 14, fontWeight: FontWeight.w500)` |
| color | #FFEA9E | `Color(0xFFFFEA9E)` |
| icon | Chevron down SVG | `Assets.icons.icChevronDown.svg()` |

### A. Dropdown Overlay

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| background | #00101A | `Color(0xFF00101A)` |
| border | 1px solid #998C5F | `Border.all(color: Color(0xFF998C5F))` |
| border-radius | 4px | `BorderRadius.circular(4)` |
| options | 2 pill buttons (Da nhan, Da gui) | `Column` |
| option background | rgba(255, 234, 158, 0.10) | `Color(0xFFFFEA9E).withOpacity(0.1)` |
| option font | Montserrat 14px Medium | `TextStyle(fontSize: 14, fontWeight: FontWeight.w500)` |
| option color | #FFEA9E | `Color(0xFFFFEA9E)` |

### 8. Kudos Card (Reusable — tham chieu component chung)

> Kudos card su dung cung component voi man hinh Sun*Kudos (screenId: `fO0Kt19sZZ`), All Kudos (screenId: `j_a2GQWKDJ`), va Profile ban than (screenId: `hSH7L8doXB`). Xem chi tiet tai `.momorph/specs/fO0Kt19sZZ-ios-sun-kudos/design-style.md`.

**Hai loai card trong man hinh nay**:

| Loai | Mo ta | So luong |
|------|-------|---------|
| Highlight (B.3 - KUDO Highlight) | Card lon voi anh thu nho | 3 cards dau |
| Normal (B.3 - KUDO Normal) | Card nho khong co anh | Cac card con lai |

| Thuoc tinh | Gia tri |
|-----------|---------|
| background | #FFF8E1 |
| border | 1px solid #FFEA9E |
| content-bg | rgba(255, 234, 158, 0.40) |
| text-dark | #00101A |
| card-gap | 8px |
| list-gap | 12px |

### 9. Bottom Navigation Bar (Node: 6885:10428)

| Thuoc tinh | Gia tri | Flutter |
|-----------|---------|---------|
| height | 83px (bao gom safe area) | `BottomNavigationBar` |
| background | #00101A | `Color(0xFF00101A)` |
| border-top | 1px solid #2E3940 | `Border(top: BorderSide(...))` |
| inactive tab color | #999999 | `Color(0xFF999999)` |
| icon size | 24x24px | SVG via `Assets.icons` |
| label font | Montserrat 10px Medium | `TextStyle(fontSize: 10, fontWeight: FontWeight.w500)` |
| tabs | SAA 2025, Awards, Kudos, Profile (tat ca inactive) | 4 items |

> **Ghi chu**: Tren man hinh Profile nguoi khac, khong co tab nao active vi day la man hinh push (khong phai man hinh chinh cua tab).

---

## Phan cap Component voi Styles

```
Screen (bg: #00101A)
+-- ScrollView
|   +-- Header (h: 44px, transparent, co nut back)
|   |   +-- Back Icon (SVG, 24x24, white)
|   |
|   +-- MemberInfoContainer (py: 16px, px: 20px, center)
|   |   +-- Avatar (64x64, circle, border: white)
|   |   +-- UserName (Montserrat 16px Bold, white)
|   |   +-- TeamCode (Montserrat 12px Medium, #999)
|   |   +-- BadgeTitle (Montserrat 12px Medium, #FFEA9E)
|   |
|   +-- IconCollectionLabel (Montserrat 14px Medium, #FFEA9E, px: 20px)
|   |
|   +-- BadgeCollectionSection (px: 20px, Wrap, gap: 12px)
|   |   +-- BadgeItem (Column, 44x44 circle icon + 10px name) x 6
|   |       - Revival
|   |       - Touch Of Light
|   |       - Stay Gold
|   |       - Flow To Horizon
|   |       - Beyond The Boundary
|   |       - Root Futher
|   |
|   +-- CTAButton "Gui loi cam on" (mx: 20px, h: 44px, bg: primary-10, border: #998C5F, radius: 4)
|   |   +-- EditIcon (SVG)
|   |   +-- Label (Montserrat 14px SemiBold, #FFEA9E)
|   |
|   +-- KudosSectionHeader (banner image)
|   |   +-- Subtitle "Sun* Annual Awards 2025" (Montserrat 12px, white)
|   |   +-- Title "KUDOS" (Montserrat 22px Medium, #FFEA9E)
|   |
|   +-- FilterDropdown (bg: primary-10, border: #998C5F, radius: 4px)
|   |   +-- Label "Da nhan (N)" (Montserrat 14px Medium, #FFEA9E)
|   |   +-- ChevronDown Icon (SVG)
|   |
|   +-- KudosList (Column, gap: 12px)
|       +-- KudosCard (highlight) x 3
|       +-- KudosCard (normal) x N
|           +-- SenderReceiverBlock
|           +-- ContentBlock
|           +-- ActionBar
|
+-- BottomNavBar (h: 83px, bg: #00101A, border-top: #2E3940)
    +-- Tab "SAA 2025" (inactive, #999)
    +-- Tab "Awards" (inactive, #999)
    +-- Tab "Kudos" (inactive, #999)
    +-- Tab "Profile" (inactive, #999)
```

---

## Icon Specifications

| Icon | Size | Color | Su dung | Asset path |
|------|------|-------|---------|------------|
| ic_back | 24x24 | #FFFFFF | Nut back tren header | `Assets.icons.icBack.svg()` |
| ic_edit | 16x16 | #FFEA9E | Icon trong nut CTA | `Assets.icons.icEdit.svg()` |
| ic_chevron_down | 16x16 | #FFEA9E | Dropdown indicator | `Assets.icons.icChevronDown.svg()` |
| ic_heart | 16x16 | #F17676 | Heart reaction (filled) | `Assets.icons.icHeart.svg()` |
| ic_heart_outline | 16x16 | #F17676 | Heart reaction (unfilled) | `Assets.icons.icHeartOutline.svg()` |
| ic_copy | 16x16 | #999999 | Copy link action | `Assets.icons.icCopy.svg()` |
| ic_arrow_right | 12x12 | #00101A | Sender -> Receiver arrow | `Assets.icons.icArrowRight.svg()` |
| ic_external | 16x16 | #999999 | "Xem chi tiet" action | `Assets.icons.icExternal.svg()` |
| ic_home | 24x24 | #999999 | Nav tab SAA 2025 | `Assets.icons.icHome.svg()` |
| ic_trophy | 24x24 | #999999 | Nav tab Awards | `Assets.icons.icTrophy.svg()` |
| ic_kudos | 24x24 | #999999 | Nav tab Kudos | `Assets.icons.icKudos.svg()` |
| ic_profile | 24x24 | #999999 | Nav tab Profile | `Assets.icons.icProfile.svg()` |
| badge icons | 44x44 | Original | Huy hieu collection | `Assets.icons.icBadge{Name}.svg()` |

---

## Animation & Transitions

| Element | Thuoc tinh | Duration | Easing | Trigger |
|---------|-----------|----------|--------|---------|
| Push transition | slide from right | 300ms | ease-in-out | Navigate to profile |
| Pop transition | slide to right | 300ms | ease-in-out | Back button / swipe back |
| Dropdown overlay | opacity, transform | 200ms | ease-out | Open/Close |
| Heart toggle | scale, color | 150ms | ease-in-out | Tap |

---

## Responsive Specifications

> Ung dung chi danh cho mobile iOS — khong co breakpoints responsive. Width co dinh 375px (iPhone standard), su dung `MediaQuery` de xu ly cac kich thuoc man hinh khac nhau.

---

## So sanh voi Profile ban than

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
- Font Montserrat duoc su dung xuyen suot.
- Kudos card la reusable component — cung widget class cho Profile, Kudos feed, va All Kudos.
- Badge collection co the reuse widget tu Profile ban than (chi khac la co hien thi ten ben duoi).
