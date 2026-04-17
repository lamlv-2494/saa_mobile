# Screen Spec: [iOS] Home

## Screen Info

| Key | Value |
|-----|-------|
| Screen ID | OuH1BUTYT0 |
| Frame ID | 6885:8978 |
| Figma Link | https://www.figma.com/design/9ypp4enmFmdK3YAFJLIu6C/?node-id=6885-8978 |
| Status | discovered / implemented |
| Platform | iOS |
| Screen Type | Home / Landing (Tab 0) |
| Discovered At | 2026-04-10 |
| Last Updated | 2026-04-17 |

## Description

Màn hình Home là trang chủ (tab 0) của ứng dụng Sun* Annual Awards 2025. Đây là trung tâm điều hướng với:

- **Branding "ROOT FURTHER"** và key visual nền tối ánh vàng.
- **Countdown timer** đếm ngược thời gian thực tới sự kiện 26/12/2025.
- **Thông tin sự kiện** (thời gian, địa điểm Âu Cơ Art Center, livestream Facebook).
- **CTA**: nút "ABOUT AWARD" và "ABOUT KUDOS" dẫn tới các section giới thiệu.
- **Theme description**: mô tả tinh thần "Root Further".
- **Awards Section**: danh sách horizontal các hạng mục giải thưởng (Top Talent, Top Project, v.v.) kèm nút "Chi tiết" dẫn tới `AwardScreen`.
- **Kudos Section**: banner + mô tả Sun*Kudos, nút "Chi tiết" chuyển sang tab Kudos.
- **FAB**: icon Pencil (gửi Kudos) + icon S/Kudos (mở feed Kudos).
- **Bottom Navigation**: 4 tab — SAA 2025 (active), Awards, Kudos, Profile.
- **Header**: Logo + language switcher (VN/EN) + icon Search + icon Bell (có badge khi có thông báo chưa đọc). Header có hiệu ứng fade khi scroll (`opacity` giảm từ 0.9 → 0 trong khoảng scroll 0–150px).

---

## Navigation Analysis

### Incoming Navigation (From)

| From Screen | Trigger | Confidence |
|-------------|---------|------------|
| [iOS] Login (`8HGlvYGJWq`) | Đăng nhập thành công qua Google OAuth | High |
| Bất kỳ màn hình có bottom nav | Tap tab "SAA 2025" | High |
| Deep link `/` | Ngoài ứng dụng | Medium |

### Outgoing Navigation (To)

| Target Screen | Trigger Element | Node ID | Confidence | Notes |
|---------------|-----------------|---------|------------|-------|
| Language dropdown overlay | Tap language switcher (VN flag) | `I6885:9057;88:1829` | High | `LanguageDropdown` widget → `localeNotifierProvider.changeLocale()` |
| [iOS] Sun*Kudos_Searching (`hldqjHoSRH`) | Tap icon search | `I6885:9057;88:1869` | Medium | Hiện chưa điều hướng (TODO trong code: `context.push('/search')`) |
| Notifications panel (`_b68CBWKl5`) | Tap icon bell | `I6885:9057;88:1830` | Medium | Hiện chưa điều hướng (TODO: `context.push('/notifications')`) |
| Awards overview (Award tab) | Tap nút "ABOUT AWARD" | `6885:9026` (mms_2.2_Button) | Medium | TODO: chưa điều hướng trong code |
| Kudos overview (Kudos tab) | Tap nút "ABOUT KUDOS" | `6885:9027` (mms_2.3_Button) | Medium | TODO: chưa điều hướng trong code |
| [iOS] Award_Top talent (`c-QM3_zjkG`) | Tap "Chi tiết" trên award card | `6885:9033..9035` | High | `currentTabIndexProvider = 1` + set `initialAwardSlugProvider` |
| [iOS] Sun*Kudos (`fO0Kt19sZZ`) | Tap "Chi tiết" Kudos section | `6885:9055` (mms_5.3_Button) | High | `currentTabIndexProvider = 2` |
| [iOS] Send Kudos (`7fFAb-K35a`) | Tap icon Pencil trên FAB | `I6885:9058;75:2164` | High | `context.push('/send-kudos')` |
| [iOS] Sun*Kudos (`fO0Kt19sZZ`) | Tap icon S/Kudos trên FAB | `I6885:9058;75:2166` | High | `currentTabIndexProvider = 2` |
| [iOS] Home (active) | Tap tab "SAA 2025" | `I6885:9056;75:2009` | High | Active tab — không điều hướng |
| Awards screen | Tap tab "Awards" | `I6885:9056;75:2012` | High | `currentTabIndexProvider = 1` |
| [iOS] Sun*Kudos (`fO0Kt19sZZ`) | Tap tab "Kudos" | `I6885:9056;75:2015` | High | `currentTabIndexProvider = 2` |
| [iOS] Profile bản thân (`hSH7L8doXB`) | Tap tab "Profile" | `I6885:9056;75:2018` | High | `currentTabIndexProvider = 3` |

### Navigation Rules

- **Back behavior**: Home là root tab — không có back stack intra-tab.
- **Deep link support**: Mặc định `/` (root) → Home.
- **Auth required**: Yes — cần đăng nhập Google OAuth trước.
- **Tab switching**: Dùng `currentTabIndexProvider` (Riverpod `StateProvider<int>`) thông qua `MainScaffold`, không dùng `go_router` push.

---

## Component Schema

### Layout Structure

```
┌──────────────────────────────────────────┐
│  HEADER (Stack overlay, fade on scroll)  │
│  [Logo] [VN Flag ▾] [Search] [Bell•]     │
├──────────────────────────────────────────┤
│  HERO CONTENT (mms_2_content)            │
│  ┌──────────────────────────────────┐    │
│  │   ROOT FURTHER (Theme Logo)      │    │
│  │   Coming soon                    │    │
│  │   [20 DAYS] [20 HOURS] [20 MIN]  │    │
│  │   Thời gian: 26/12/2025          │    │
│  │   Địa điểm: Âu Cơ Art Center     │    │
│  │   Tường thuật: FB Sun* Family    │    │
│  │   [ABOUT AWARD] [ABOUT KUDOS]    │    │
│  └──────────────────────────────────┘    │
├──────────────────────────────────────────┤
│  THEME DESCRIPTION (mms_3_note)          │
│  "Root Further is not merely a name..."  │
├──────────────────────────────────────────┤
│  AWARDS SECTION (mms_4_awards)           │
│  [Sun* Annual Awards 2025]               │
│  Hệ thống giải thưởng                    │
│  ◀ [Top Talent] [Top Project] [...]  ▶   │
├──────────────────────────────────────────┤
│  KUDOS SECTION (mms_5_kudos) — optional  │
│  [Phong trào ghi nhận] Sun* Kudos        │
│  [Banner: S KUDOS]                       │
│  "ĐIỂM MỚI CỦA SAA 2025..."              │
│  [Chi tiết →]                            │
├──────────────────────────────────────────┤
│                              ┌─────────┐ │
│                              │ ✏ KUDOS │ │  ← FAB (Positioned)
│                              └─────────┘ │
├──────────────────────────────────────────┤
│  BOTTOM NAV (mms_7_nav bar)              │
│  [SAA●] [Awards] [Kudos] [Profile]       │
└──────────────────────────────────────────┘
```

### Component Hierarchy (Implementation)

```
HomeScreen (ConsumerStatefulWidget)
└── Scaffold (bgDark)
    └── Stack
        ├── RefreshIndicator
        │   └── CustomScrollView (ScrollController → header fade)
        │       ├── SliverToBoxAdapter → HeroContentWidget       ← mms_2_content
        │       ├── SliverToBoxAdapter → ThemeDescriptionWidget  ← mms_3_note
        │       ├── SliverToBoxAdapter → AwardsSectionWidget     ← mms_4_awards
        │       └── SliverToBoxAdapter → KudosSectionWidget      ← mms_5_kudos (if enabled)
        ├── HomeHeaderWidget (opacity animated)                  ← mms_1_header
        └── Positioned(right, bottom) → KudosFabWidget           ← mms_6_float button
```

> `mms_7_nav bar` không thuộc `HomeScreen` mà nằm trong `MainScaffold` (điều khiển bằng `currentTabIndexProvider`).

### Main Components

| Component | Type | Node ID | Description | Reusable |
|-----------|------|---------|-------------|----------|
| HomeHeaderWidget | Organism | `6885:9057` (mms_1_header) | Header logo + language + search + bell | Yes (dùng chung Kudos/Profile) |
| HeroContentWidget | Organism | `6885:8983` (mms_2_content) | Theme logo + countdown + event info + CTA | No |
| CountdownTimerWidget | Molecule | `6885:8986` | Real-time countdown DD:HH:MM | Yes |
| CountdownDigitBox | Atom | `6885:8991..9013` | 1 ô chữ số countdown | Yes |
| EventInfoRow | Molecule | `6885:9017..9023` | 1 dòng thông tin (thời gian/địa điểm) | Yes |
| ThemeDescriptionWidget | Molecule | `6885:9028` (mms_3_note) | Text block mô tả theme | No |
| AwardsSectionWidget | Organism | `6885:9030` (mms_4_awards) | Header + horizontal list | No |
| AwardCardWidget | Molecule | `6885:9033..9035` (mms_4.2 item) | 1 card giải thưởng | Yes |
| KudosSectionWidget | Organism | `6885:9039` (mms_5_kudos) | Banner + description + CTA | No |
| KudosFabWidget | Molecule | `6885:9058` (mms_6_float button) | FAB Write Kudos + Kudos feed | No |
| LanguageDropdown | Atom | `I6885:9057;88:1829` | Dropdown chọn VN/EN | Yes |

---

## Form Fields

N/A — Màn hình Home không chứa form input.

---

## API Mapping

### On Screen Load (`HomeViewModel._fetchAll()` — parallel via `.wait`)

| Method | Endpoint (predicted) | Repository Call | Purpose | Response |
|--------|----------------------|-----------------|---------|----------|
| GET | `/event/info?locale={vi\|en}` | `getEventInfo(locale:)` | Fetch event theme, date, venue, livestream note, description | `EventInfo` |
| GET | `/awards?locale={vi\|en}` | `getAwardCategories(locale:)` | Fetch award categories list | `List<AwardCategory>` |
| GET | `/kudos/info` | `getKudosInfo()` | Fetch Kudos section content & enabled flag | `KudosInfo { title, description, isEnabled }` |
| GET | `/notifications/unread-count` | `getUnreadNotificationCount()` | Badge count for bell icon | `int` |

### On User Action

| Action | Behavior | Side Effects |
|--------|----------|--------------|
| Pull-to-refresh | `homeViewModelProvider.notifier.refresh()` | Reload toàn bộ 4 API song song |
| Tap "Chi tiết" award card | Set `initialAwardSlugProvider` + `currentTabIndexProvider = 1` | Chuyển tab Awards, scroll tới slug đã chọn |
| Tap "Chi tiết" Kudos section | `currentTabIndexProvider = 2` | Chuyển tab Kudos |
| Tap FAB Pencil | `context.push('/send-kudos')` | Push route gửi Kudos |
| Tap FAB Kudos Logo | `currentTabIndexProvider = 2` | Chuyển tab Kudos |
| Tap language switcher | `localeNotifierProvider.changeLocale(code)` | Đổi ngôn ngữ app + reload API do `ref.watch(localeNotifierProvider)` trong ViewModel |
| Tap "ABOUT AWARD" | TODO — chưa implement | (dự kiến) push/switch tới Awards intro |
| Tap "ABOUT KUDOS" | TODO — chưa implement | (dự kiến) push/switch tới Kudos intro |
| Tap search icon | TODO — chưa implement | (dự kiến) `context.push('/search')` |
| Tap notification bell | TODO — chưa implement | (dự kiến) `context.push('/notifications')` |

### Error Handling

| Error | UI |
|-------|-----|
| API lỗi toàn bộ | Full-screen error view với text `t.home.errorRetry` + nút `t.home.retry` |
| Fallback loading | Render `_fallbackEventInfo` (Root Further, 26/12/2025, Âu Cơ Art Center) trong khi chờ data |

---

## State Management

### Local State (HomeScreen)

| State | Type | Default | Purpose |
|-------|------|---------|---------|
| `_scrollController` | `ScrollController` | new | Lắng nghe scroll offset để fade header |
| `_headerOpacity` | `double` | 0.9 | Opacity của `HomeHeaderWidget` (0.0 → 0.9) |

### Global State (Riverpod)

| Provider | Kind | Read/Write | Purpose |
|----------|------|------------|---------|
| `homeViewModelProvider` | `AsyncNotifierProvider<HomeViewModel, HomeState>` | Read (watch) | State Home: event, awards, kudosInfo, unreadCount |
| `localeNotifierProvider` | custom notifier | Read/Write | Ngôn ngữ app (VN/EN), trigger reload khi đổi |
| `currentTabIndexProvider` | `StateProvider<int>` | Write | Chuyển tab trong `MainScaffold` |
| `initialAwardSlugProvider` | `StateProvider<String?>` | Write | Slug award cần auto-scroll trong `AwardScreen` |
| `homeRepositoryProvider` | Repository DI | Read | `HomeRepository` injection |

### Derived State (HomeState — Freezed)

```dart
HomeState({
  required EventInfo eventInfo,
  List<AwardCategory> awards = const [],
  KudosInfo kudosInfo = const KudosInfo(title: '', description: '', isEnabled: false),
  int unreadNotificationCount = 0,
});
```

---

## UI States

### Loading
- Render `_buildContent` với `_fallbackEventInfo` (giữ layout, không blank screen).
- Awards/Kudos section render rỗng (list `[]`, `isEnabled = false`).

### Error
- `_buildError()`: Center column với text lỗi i18n `t.home.errorRetry` + nút "Thử lại" (`t.home.retry`) → gọi `refresh()`.

### Success
- Countdown tick real-time tới `eventInfo.eventDate`.
- Awards list hiển thị horizontal scrollable cards.
- Kudos section chỉ render nếu `kudosInfo.isEnabled == true`.

### Empty
- `awards.isEmpty` → `AwardsSectionWidget` cần hỗ trợ empty state (hiện tại render list rỗng).
- `kudosInfo.isEnabled == false` → Kudos section bị ẩn hoàn toàn (`if (homeState.kudosInfo.isEnabled)`).

### Countdown Expired
- Khi `DateTime.now() >= eventInfo.eventDate` → `CountdownTimerWidget` cần fallback (hiện tại TBD, có thể hiển thị 0 hoặc "Event Started").

---

## Accessibility

| Requirement | Implementation |
|-------------|----------------|
| Text contrast | Dark bg + white/gold text đạt WCAG AA |
| Tap target | FAB và bottom nav ≥ 44×44 |
| Localization | Tất cả text qua `strings.g.dart` (i18n VN/EN) |
| Pull-to-refresh | Hỗ trợ gesture chuẩn iOS |

---

## Responsive Behavior

iOS-only, phone size. Layout cố định cho iPhone chuẩn (393pt).

---

## Design Tokens

| Token | Value | Usage |
|-------|-------|-------|
| `AppColors.bgDark` | Nền tối chính | Scaffold background |
| `AppColors.textWhite` | Text chính | Event info, countdown |
| `AppColors.textAccent` | Gold accent | Highlight, RefreshIndicator |
| `AppColors.outlineBtnBorder` | Border button | Nút "Thử lại" |
| Font: Montserrat (GoogleFonts) | — | Text toàn màn hình |
| Assets.images.keyVisualBg | — | Background key visual |
| Assets.images.kudosKeyVisualBg | — | Kudos section banner |

> Tuân thủ rule: asset paths qua `Assets.xxx` (flutter_gen), không hardcode string.

---

## Implementation Notes

### Files
- `lib/features/home/presentation/screens/home_screen.dart`
- `lib/features/home/presentation/viewmodels/home_viewmodel.dart`
- `lib/features/home/data/repositories/home_repository.dart`
- `lib/features/home/data/datasources/home_remote_datasource.dart`
- `lib/features/home/data/models/{event_info,award_category,kudos_info,home_state}.dart`
- `lib/features/home/presentation/widgets/{hero_content_widget,theme_description_widget,awards_section_widget,award_card_widget,kudos_section_widget,kudos_fab_widget,countdown_timer_widget,countdown_digit_box,event_info_row}.dart`
- `lib/shared/widgets/home_header_widget.dart`
- `lib/shared/widgets/language_dropdown.dart`

### Special Considerations
- **Single `ref.watch`** (constitution v1.2.0): HomeScreen chỉ watch `homeViewModelProvider` + `localeNotifierProvider`, truyền data xuống widget con qua constructor.
- **Fallback loading**: Luôn có layout tối thiểu khi loading (không blank screen).
- **Parallel fetching**: `Future.wait` với Dart 3 record pattern trong `_fetchAll`.
- **TODO routes**: `/search`, `/notifications`, About Award, About Kudos chưa implement.
- **Header fade**: Custom scroll listener tính `_headerOpacity` theo offset [0, 150].

---

## Analysis Metadata

| Property | Value |
|----------|-------|
| Analyzed By | Screen Flow Discovery |
| Analysis Date | 2026-04-10 (initial) / 2026-04-17 (update) |
| Needs Deep Analysis | No — đã có implementation đầy đủ |
| Confidence Score | High |
| Complexity | Medium |

### Next Steps
- [ ] Implement điều hướng TODO: `/search`, `/notifications`, ABOUT AWARD, ABOUT KUDOS.
- [ ] Xác định behavior `CountdownTimerWidget` khi countdown hết hạn.
- [ ] Thêm empty state UI cho `AwardsSectionWidget`.
- [ ] Kiểm tra API endpoints thực tế với backend (Supabase schema).
