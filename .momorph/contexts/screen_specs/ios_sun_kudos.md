# Screen: [iOS] Sun*Kudos

## Screen Info

| Property | Value |
|----------|-------|
| **Figma Frame ID** | fO0Kt19sZZ |
| **Figma Node ID** | 6885:9059 |
| **Figma Link** | https://www.figma.com/design/9ypp4enmFmdK3YAFJLIu6C?node-id=fO0Kt19sZZ |
| **Screen Group** | Kudos |
| **Status** | discovered |
| **Discovered At** | 2026-04-16 |
| **Last Updated** | 2026-04-16 |

---

## Description

Màn hình chính **Sun*Kudos** là trang feed trung tâm của hệ thống ghi nhận và cảm ơn (Kudos) trong ứng dụng Sun* Annual Awards 2025. Đây là màn hình cho phép Sunner xem các kudos nổi bật (Highlight Kudos carousel), mạng lưới kết nối (Spotlight Board), toàn bộ feed kudos (All Kudos), thống kê cá nhân, và danh sách 10 Sunner nhận quà mới nhất. Người dùng có thể gửi kudos mới thông qua nút CTA trên hero banner.

**Platform**: iOS Mobile (375px width)  
**Scroll height**: 2601px (scrollable)  
**Theme**: Dark (#00101A), accent vàng (#FFEA9E)

---

## Navigation Analysis

### Incoming Navigations (From)

| Source Screen | Trigger | Condition |
|---------------|---------|-----------|
| [iOS] Home | Tap "Kudos" bottom tab | Always |
| [iOS] Home | Tap "ABOUT KUDOS" button | Always |
| [iOS] Home | Tap Kudos icon on FAB | Always |
| Any screen | Tap "Kudos" bottom tab | Always (via BottomNav) |

### Outgoing Navigations (To)

| Target Screen | Trigger Element | Screen ID | Confidence | Notes |
|---------------|-----------------|-----------|------------|-------|
| [iOS] Sun*Kudos_Gửi lời chúc Kudos | Tap CTA button "Hôm nay, bạn muốn gửi kudos đến ai?" (Hero) | PV7jBVZU1N | High | Button Node: 6885:9083. Xuất hiện 2 lần: trên hero và cuối feed |
| [iOS] Sun*Kudos_Gửi lời chúc Kudos | Tap CTA button (Bottom of feed) | PV7jBVZU1N | High | Node: 6891:21267 — cùng style/hành vi với hero CTA |
| [iOS] Sun*Kudos_All Kudos | Tap link "Xem tất cả" trong ALL KUDOS header | j_a2GQWKDJ | High | C.1 section link |
| [iOS] Sun*Kudos_View kudo | Tap "Xem chi tiết" trên Highlight card hoặc Feed card | T0TR16k0vH | High | B.4.4 Actions row |
| Hashtag Dropdown (screenId: V5GRjAdJyb) | Tap Dropdown Button "Hashtag" (B.1.1) | V5GRjAdJyb | High | Node: 6885:9088 — mở overlay chọn hashtag |
| Department Dropdown (screenId: 76k69LQPfj) | Tap Dropdown Button "Phòng ban" (B.1.2) | 76k69LQPfj | High | Node: 6885:9089 — mở overlay chọn phòng ban |
| [iOS] Sun*Kudos_Search Sunner | Tap ô "Tìm kiếm sunner" trong Spotlight Board | 3jgwke3E8O | High | B.7 — Spotlight search input |
| [iOS] Open secret box | Tap "Mở hộp bí mật" (khi unopened > 0) | kQk65hSYF2 | High | D.2 button — chỉ enabled khi secret_boxes_unopened > 0 |
| [iOS] Profile người khác | Tap avatar/tên trên kudos card | bEpdheM0yU | High | C.3 / B.3 — Sender hoặc Receiver avatar |
| [iOS] Language dropdown | Tap Language switcher (VN flag) trên Header | uUvW6Qm1ve | High | Header — Language component |
| [iOS] Sun*Kudos_Searching | Tap Search icon trên Header | hldqjHoSRH | High | Header — Search icon (Node: I6885:9065;88:1869) |
| [iOS] Home | Tap "SAA 2025" bottom tab | OuH1BUTYT0 | High | Nav Bar tab 1 |
| Awards screen | Tap "Awards" bottom tab | - | High | Nav Bar tab 2 |
| [iOS] Profile bản thân | Tap "Profile" bottom tab | hSH7L8doXB | High | Nav Bar tab 4 |

### Navigation Rules
- **Back behavior**: Back về màn hình trước (thường là Home hoặc previous tab)
- **Deep link support**: No (chưa xác định)
- **Auth required**: Yes — Sunner phải đăng nhập
- **Bottom Nav active tab**: "Kudos" (tab 3)

---

## Component Schema

### Layout Structure

```
┌─────────────────────────── 375px ──────────────────────────────┐
│  Header (h:104, absolute, z:1, gradient, opacity:0.9)          │
│  ┌── StatusBar (44px) ────────────────────────────────────┐    │
│  │  [9:41]                     [Signal][WiFi][Battery]    │    │
│  └────────────────────────────────────────────────────────┘    │
│  ┌── Nav Row (60px) ──────────────────────────────────────┐    │
│  │  [Logo 48x44]    [🇻🇳 VN ▾]  [🔍]  [🔔•]              │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ══════════ Hero Banner Background (812px) ══════════════      │
│  [A. KV Kudos 221x67] + [A.1. CTA Button 335x40]              │
│  ══════════════════════════════════════════════════════════    │
│                                                                 │
│  ┌── B. Highlight Section (335x389) ──────────────────────┐    │
│  │  [B.1. Header: "HIGHLIGHT KUDOS" + 2 dropdowns]        │    │
│  │  [B.2. Carousel: tối đa 5 thẻ kudos]                   │    │
│  │  [B.5. Slide Indicator: ◀ 2/5 ▶]                       │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ┌── Spotlight Board (336x236) ───────────────────────────┐    │
│  │  [Header: "SPOTLIGHT BOARD"]                           │    │
│  │  [B.7. Network Chart + Search + "388 KUDOS"]           │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ┌── C. All Kudos (336x1393) ─────────────────────────────┐    │
│  │  [C.1. Header: "ALL KUDOS" + "Xem tất cả →"]           │    │
│  │  [D.1. Stats Block: kudos nhận/gửi, hearts, hộp]       │    │
│  │  [D.3. 10 Sunner nhận quà mới nhất]                    │    │
│  │  [C.3. Kudos Cards (infinite scroll)]                  │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ┌── Nav Bar (375x72, fixed bottom) ─────────────────────┐    │
│  │  [SAA 2025]  [Awards]  [Kudos ✓]  [Profile]            │    │
│  └────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
```

### Component Hierarchy

```
Screen (Scaffold, bg: #00101A, scroll: vertical)
├── Header (Organism, absolute, z:1)
│   ├── StatusBar (Atom)
│   ├── Logo (Atom, 48x44)
│   ├── LanguageDropdown (Molecule, 90x32)
│   ├── SearchIcon (Atom, 24x24)
│   └── NotificationIcon (Atom, 24x24 + red dot 8x8)
├── HeroBanner (Organism)
│   ├── KeyVisualBackground (Atom, image)
│   ├── KVKudos/Tagline + Logo (Molecule, 221x67)
│   └── CTAButton (Atom, 335x40) → SendKudos
├── HighlightSection (Organism, 335x389)
│   ├── HighlightHeader (Molecule)
│   │   ├── SectionHeader (Organism, reusable)
│   │   └── FilterRow (Molecule)
│   │       ├── HashtagDropdownButton (Atom, 129x40) → HashtagDropdown
│   │       └── DepartmentDropdownButton (Atom, auto x40) → DepartmentDropdown
│   ├── HighlightCarousel (Organism, PageView)
│   │   └── HighlightKudosCard (Molecule, max 5)
│   │       ├── SenderReceiverRow (Molecule)
│   │       ├── ContentArea (Molecule)
│   │       └── ActionsRow (Molecule) → KudosDetail / Heart / CopyLink
│   └── SlideIndicator (Molecule, 335x24)
├── SpotlightBoard (Organism, 336x236)
│   ├── SectionHeader (reusable)
│   └── NetworkChart (Atom, InteractiveViewer)
│       └── SpotlightSearchInput (Atom) → SearchSunner
├── AllKudosSection (Organism, 336x1393)
│   ├── SectionHeader + "Xem tất cả" link (Molecule) → AllKudos
│   ├── PersonalStatsCard (Organism)
│   │   ├── StatRows (Molecules)
│   │   └── OpenSecretBoxButton (Atom) → OpenSecretBox
│   ├── TopGiftRecipientsCard (Organism)
│   │   └── RecipientRows x10 (Molecules)
│   └── KudosFeedCards (Organisms, infinite scroll)
│       └── KudosFeedCard (Organism)
│           ├── SenderReceiverHeader (Molecule) → UserProfile
│           └── KudosContentCard (Molecule) → KudosDetail
└── BottomNavBar (Organism, fixed)
    └── 4 Tabs (Atoms)
```

### Main Components

| Component | Type | Node ID | Description | Reusable |
|-----------|------|---------|-------------|----------|
| Header | Organism | 6885:9065 | App bar với logo, language, search, notification | Yes |
| HeroBanner | Organism | 6885:9060 | Banner với KV background + CTA button | No |
| CTAButton (Hero) | Atom | 6885:9083 | "Hôm nay, bạn muốn gửi kudos đến ai?" — primary CTA | Yes (reused ở feed bottom: 6891:21267) |
| HighlightSection | Organism | 6885:9084 | Container highlight carousel | No |
| SectionHeader | Organism | 6885:9085 | Subtitle + Divider + Title pattern (reusable x3) | Yes |
| HashtagDropdownButton | Atom | 6885:9088 | Filter button "Hashtag", 129x40 | Yes |
| DepartmentDropdownButton | Atom | 6885:9089 | Filter button "Phòng ban", auto width | Yes |
| HighlightKudosCard | Molecule | 6885:9091-93 | Thẻ highlight kudos trong carousel | Yes |
| SlideIndicator | Molecule | 6885:9098 | Paging indicator ◀ 2/5 ▶ | Yes |
| SpotlightBoard | Organism | 6885:9101 | Network chart pan-zoom | No |
| AllKudosSection | Organism | 6885:9220 | Container toàn bộ All Kudos | No |
| PersonalStatsCard | Organism | 6885:9223 | Thống kê cá nhân (border vàng, bg tối) | Yes |
| OpenSecretBoxButton | Atom | - | "Mở hộp bí mật", có trạng thái disabled | Yes |
| KudosFeedCard | Organism | - | Card kudos trong feed (sender→receiver + content) | Yes |
| KudosContentCard | Molecule | - | Content card bg:#FFF8E1 (reused ở Highlight + Feed) | Yes |
| BottomNavBar | Organism | 6885:9064 | 4 tabs: SAA 2025, Awards, Kudos, Profile | Yes |

---

## Form Fields

Không có form nhập liệu trực tiếp trên màn hình này. Các tương tác chính là:
- Dropdown filter (Hashtag, Phòng ban) → mở overlay chọn
- Heart/Like toggle trên kudos card
- Copy Link action
- Các navigation buttons

---

## API Mapping

### On Screen Load

| API | Method | Purpose | Response Usage |
|-----|--------|---------|----------------|
| /api/v1/kudos/highlight | GET | Top 5 highlight kudos (sort by heartCount DESC) | Hiển thị carousel B.2 |
| /api/v1/kudos | GET | All kudos feed (paginated, page=1, limit=10) | Hiển thị C.3 feed |
| /api/v1/spotlight/network | GET | Dữ liệu network graph cho Spotlight Board | Render B.7 network chart |
| /api/v1/users/me/stats | GET | Thống kê cá nhân: kudos nhận/gửi, hearts, secret boxes | D.1 stats block |
| /api/v1/kudos/top-recipients | GET | Top 10 Sunner nhận quà mới nhất (sort by created_at DESC) | D.3 list |
| /api/v1/hashtags | GET | Danh sách hashtags cho dropdown B.1.1 | Populate hashtag overlay |
| /api/v1/departments | GET | Danh sách phòng ban cho dropdown B.1.2 | Populate department overlay |

### On User Action

| Action | API | Method | Request Body | Response |
|--------|-----|--------|--------------|----------|
| Chọn Hashtag filter | /api/v1/kudos/highlight | GET | `?hashtag_id={id}` | Reload carousel (reset về page 1) |
| Chọn Phòng ban filter | /api/v1/kudos/highlight | GET | `?department_id={id}` | Reload carousel (reset về page 1) |
| Bấm heart/like | /api/v1/kudos/{id}/heart | POST | `{}` | `{heartCount}` — optimistic update |
| Bấm unlike (toggle) | /api/v1/kudos/{id}/heart | DELETE | - | `{heartCount}` — optimistic update |
| Scroll đến cuối feed | /api/v1/kudos | GET | `?page={next}` | Append kudos vào list (infinite scroll) |
| Bấm "Mở hộp bí mật" | /api/v1/users/me/secret-boxes/next | GET | - | `{boxId}` |
| Mở hộp bí mật (tiếp theo) | /api/v1/users/me/secret-boxes/{boxId}/open | POST | `{}` | Navigate to Open Secret Box screen |
| Pull-to-refresh | Tất cả On Load APIs | GET | - | Reload toàn bộ dữ liệu |

### Error Handling

| Error Code | Message | UI Action |
|------------|---------|-----------|
| 401 | Unauthorized | Redirect về Login |
| 404 | Kudos not found | Hiển thị toast error |
| 422 | Validation failed | Hiển thị inline error |
| 500 | Server error | Hiển thị retry banner |
| Network error | No connection | Hiển thị error state + nút retry |

---

## State Management

### Local State

| State | Type | Initial | Purpose |
|-------|------|---------|---------|
| pageController | PageController | page 0 | Carousel position, reset khi filter thay đổi |
| scrollController | ScrollController | top | Infinite scroll cho All Kudos feed |

### Global State (KudosState — freezed, AsyncNotifier)

| State | Type | Initial | Purpose |
|-------|------|---------|---------|
| highlightKudos | List<Kudos> | [] | Top 5 highlight kudos |
| allKudos | List<Kudos> | [] | Feed kudos (paginated) |
| personalStats | PersonalStats? | null | Thống kê cá nhân |
| recentGiftRecipients | List<GiftRecipientRanking> | [] | Top 10 sunner nhận quà |
| spotlightData | SpotlightNetwork? | null | Network graph data |
| selectedHashtag | Hashtag? | null | Filter hashtag (null = tất cả) |
| selectedDepartment | Department? | null | Filter phòng ban (null = tất cả) |
| currentHighlightPage | int | 0 | Trang carousel hiện tại |
| hasMoreKudos | bool | true | Còn kudos để load (pagination) |

---

## UI States

### Loading State

| Section | Loading UI |
|---------|-----------|
| Highlight Kudos | Shimmer placeholder (3 thẻ) |
| Spotlight Board | Shimmer placeholder |
| All Kudos Feed | Shimmer placeholder (3 rows) |
| Personal Stats | Shimmer placeholder |
| Top 10 Sunner | Shimmer placeholder |

### Error State

| Section | Error UI |
|---------|---------|
| Highlight Kudos | Thông báo lỗi + nút "Thử lại" |
| Spotlight Board | Thông báo lỗi + nút "Thử lại" |
| All Kudos Feed | Thông báo lỗi + nút "Thử lại" |
| Personal Stats | Ẩn section |
| Top 10 Sunner | Ẩn section |

### Empty State

| Section | Empty UI |
|---------|---------|
| Highlight Kudos | "Hiện tại chưa có Kudos nào." |
| Spotlight Board | "Chưa có dữ liệu." |
| All Kudos Feed | "Chưa có Kudos nào được gửi." |
| Personal Stats | Hiển thị tất cả giá trị = 0 |
| Top 10 Sunner | "Chưa có dữ liệu." |
| Filter không có kết quả | "Không tìm thấy Kudos phù hợp." |

### Success State
- Heart toggle: icon chuyển từ outlined → filled (#F17676), scale animation 200ms spring
- Copy link: snackbar "Đã sao chép liên kết" trong 2 giây
- Mở hộp bí mật: navigate sang Open secret box screen

---

## Analysis Metadata

| Property | Value |
|----------|-------|
| Analyzed By | Screen Flow Discovery |
| Analysis Date | 2026-04-16 |
| Needs Deep Analysis | No (đã có spec.md chi tiết) |
| Confidence Score | High |
| Spec Source | .momorph/specs/fO0Kt19sZZ-ios-sun-kudos/spec.md |
| Design Style Source | .momorph/specs/fO0Kt19sZZ-ios-sun-kudos/design-style.md |

### Next Steps
- [x] Spec đã được tạo tại `.momorph/specs/fO0Kt19sZZ-ios-sun-kudos/spec.md`
- [x] Design style đã được trích xuất tại `.momorph/specs/fO0Kt19sZZ-ios-sun-kudos/design-style.md`
- [ ] Xác nhận screenId cho Hashtag Dropdown (V5GRjAdJyb) và Department Dropdown (76k69LQPfj)
- [ ] Review API contract với backend team (xem `.momorph/contexts/api-docs.yaml`)
- [ ] Implementation plan tại `.momorph/specs/fO0Kt19sZZ-ios-sun-kudos/plan.md`
