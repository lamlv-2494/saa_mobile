# Implementation Plan: Màn hình chính SAA 2025

**Frame**: `OuH1BUTYT0-ios-home`
**Spec**: `spec.md` | **Design**: `design-style.md`
**Created**: 2026-04-10

---

## Tuân thủ Constitution

| Yêu cầu | Quy tắc Constitution | Trạng thái |
|----------|----------------------|-----------|
| Kiến trúc MVVM | Feature-based module, Riverpod providers | ✅ Áp dụng |
| Clean Code | Widget nhỏ, không hardcode, i18n (slang) | ✅ Áp dụng |
| Test-First (TDD) | Unit → Widget → Integration | ✅ Lên kế hoạch |
| Lint & Format | flutter_lints, dart format | ✅ Áp dụng |
| Freezed Models | @freezed + json_serializable | ✅ Áp dụng |
| Dependencies | Chỉ packages đã có trong pubspec.yaml | ✅ Áp dụng |
| Asset Access | flutter_gen type-safe (constitution v1.3.0) | ✅ Áp dụng |

---

## Quyết định kiến trúc

### Frontend

- **Pattern**: MVVM với Riverpod (theo mẫu `features/auth/`)
- **State**: 1 `AsyncNotifier<HomeState>` duy nhất cho toàn bộ Home feature (theo constitution v1.2.0). `StateProvider` cho local state đơn giản (tab index, scroll offset)
- **Scroll**: `CustomScrollView` với `SliverList` để header fade-on-scroll
- **Navigation**: `go_router` — cập nhật route `/home` từ placeholder → `HomeScreen`
- **i18n**: Thêm keys vào `strings_vi.i18n.json` và `strings_en.i18n.json` (slang)
- **Theme**: Mở rộng `AppColors` với tokens mới từ design-style.md

### Backend (Supabase)

- **Tables**: `events`, `award_categories` (xem `database-schema.sql`). **Lưu ý**: Không có bảng `kudos_info` riêng — dữ liệu KudosInfo (banner, title, description, isEnabled) cần được lưu trong bảng `events` (thêm columns) hoặc tạo bảng `feature_configs` mới. Tạm thời Phase 0-4 dùng mock data, quyết định DB structure khi implement Kudos feature
- **API**: Supabase client queries trực tiếp qua `supabase_flutter`, không cần REST endpoints riêng
- **RLS**: Row Level Security cho read-only access trên Home

---

## Cấu trúc dự án

### File mới tạo

| File | Mục đích |
|------|----------|
| **Generated (flutter_gen)** | |
| `lib/gen/assets.gen.dart` | Type-safe asset references (auto-generated, KHÔNG sửa tay) |
| **Data Layer** | |
| `lib/features/home/data/models/event_info.dart` | Freezed model thông tin sự kiện |
| `lib/features/home/data/models/award_category.dart` | Freezed model danh mục giải |
| `lib/features/home/data/models/kudos_info.dart` | Freezed model thông tin Kudos |
| `lib/features/home/data/models/home_state.dart` | Freezed state model cho HomeViewModel (eventInfo, awards, kudosInfo, unreadCount) |
| `lib/features/home/data/datasources/home_remote_datasource.dart` | Supabase queries cho Home |
| `lib/features/home/data/repositories/home_repository.dart` | Repository pattern |
| **App (shared scaffold)** | |
| `lib/app/main_scaffold.dart` | MainScaffold chứa BottomNavBar + IndexedStack 4 tab (shared, không thuộc feature) |
| **Presentation Layer** | |
| `lib/features/home/presentation/screens/home_screen.dart` | Màn hình chính (tab 0) — Stack: BG + ScrollView + Header overlay + FAB |
| `lib/features/home/presentation/viewmodels/home_viewmodel.dart` | AsyncNotifier quản lý state |
| `lib/features/home/presentation/widgets/home_header_widget.dart` | Header cố định, gradient, fade-on-scroll |
| `lib/features/home/presentation/widgets/hero_content_widget.dart` | Logo + countdown + event info + CTA |
| `lib/features/home/presentation/widgets/countdown_timer_widget.dart` | Bộ đếm ngược real-time |
| `lib/features/home/presentation/widgets/countdown_digit_box.dart` | Ô số đếm ngược đơn lẻ |
| `lib/features/home/presentation/widgets/event_info_row.dart` | Dòng "Thời gian:" / "Địa điểm:" |
| `lib/features/home/presentation/widgets/theme_description_widget.dart` | Đoạn mô tả chủ đề |
| `lib/features/home/presentation/widgets/awards_section_widget.dart` | Header + danh sách cuộn ngang |
| `lib/features/home/presentation/widgets/award_card_widget.dart` | Card giải thưởng đơn lẻ |
| `lib/features/home/presentation/widgets/kudos_section_widget.dart` | Header + banner + mô tả + CTA |
| `lib/features/home/presentation/widgets/kudos_fab_widget.dart` | FAB pill 2 actions |
| **Shared** | |
| `lib/shared/widgets/primary_button.dart` | Nút chính vàng (reusable) |
| `lib/shared/widgets/outline_button.dart` | Nút outline vàng (reusable) |
| `lib/shared/widgets/section_header_widget.dart` | Header section (label + title + divider, reusable) |
| `lib/shared/widgets/bottom_nav_bar.dart` | Thanh nav dưới 4 tab (reusable) |
| **Tests** | |
| `test/unit/viewmodels/home_viewmodel_test.dart` | Unit test ViewModel |
| `test/unit/repositories/home_repository_test.dart` | Unit test Repository |
| `test/widget/home/home_screen_test.dart` | Widget test màn hình |
| `test/widget/home/countdown_timer_test.dart` | Widget test đếm ngược |
| `test/widget/home/award_card_test.dart` | Widget test card giải thưởng |
| `test/widget/home/home_header_test.dart` | Widget test header (badge, search, notification) |
| `test/widget/home/bottom_nav_bar_test.dart` | Widget test bottom nav (highlight, tap) |
| `test/widget/home/kudos_fab_test.dart` | Widget test FAB (write, view, debounce) |
| `test/widget/shared/primary_button_test.dart` | Widget test PrimaryButton (label, tap, disabled, SvgPicture icon) |
| `test/helpers/home_mocks.dart` | Mock classes cho Home |

### File sửa đổi

| File | Thay đổi |
|------|----------|
| `lib/app/router.dart` | Thay placeholder `/home` → `HomeScreen`, thêm `MainScaffold` với bottom nav |
| `lib/app/theme/app_colors.dart` | Thêm màu: divider, nav-bg, countdown-border, outline-btn, notification-badge |
| `lib/i18n/strings_vi.i18n.json` | Thêm keys Home: coming_soon, days, hours, minutes, about_award, about_kudos, etc. |
| `lib/i18n/strings_en.i18n.json` | Tương tự bản EN |
| `pubspec.yaml` | Thêm `flutter_gen` + `flutter_gen_runner`, config `flutter_gen:`, font declarations, asset paths |

### Dependencies

| Package | Loại | Mục đích |
|---------|------|----------|
| `flutter_gen` | dev_dependency | Type-safe asset access — generate `Assets.images.*`, `Assets.icons.*` |
| `flutter_gen_runner` | dev_dependency | Code generator cho flutter_gen (chạy qua build_runner) |

Các packages còn lại đã có: `flutter_riverpod`, `go_router`, `supabase_flutter`, `freezed`, `google_fonts`, `flutter_svg`, `slang`.
**Lưu ý**: Cần thêm custom fonts, asset paths, và config `flutter_gen:` vào `pubspec.yaml`.

---

## Phương pháp triển khai

### Phase 0: Chuẩn bị Assets & Foundation (US không — nền tảng)

**Mục tiêu**: Assets, flutter_gen setup, theme tokens, i18n keys, data models

1. Tải assets từ Figma: Key Visual BG, Root Further logo, award images, Kudos banner, icon SVGs (search, bell, pen, kudos logo, nav icons, flag VN)
2. Thêm custom font `Digital Numbers` vào `pubspec.yaml` (nếu chưa có) + `SVN-Gotham`
3. **Thêm `flutter_gen` + `flutter_gen_runner`** vào `pubspec.yaml` và cấu hình:
   ```yaml
   flutter_gen:
     output: lib/gen/
     line_length: 80
     integrations:
       flutter_svg: true
   ```
4. **Chạy `dart run build_runner build`** để generate asset classes (`Assets.images.*`, `Assets.icons.*`)
5. Mở rộng `AppColors` với tất cả design tokens (xem design-style.md §1.1)
6. Thêm i18n keys cho Home vào cả 2 file ngôn ngữ
7. Tạo Freezed models: `EventInfo`, `AwardCategory`, `KudosInfo` → chạy `build_runner`
8. Tạo `HomeRemoteDatasource` + `HomeRepository` (interface + impl)

> **Quy tắc asset access (constitution v1.3.0)**:
> - Image: `Assets.images.home.keyVisualBg.image(fit: BoxFit.cover)`
> - SVG: `Assets.icons.icSearch.svg(width: 24, height: 24)`
> - KHÔNG hardcode string path: ~~`Image.asset('assets/images/...')`~~
> - Xem đầy đủ mapping tại `design-style.md` §6

### Phase 0.5: flutter_gen Migration (nền tảng — sau khi setup xong)

**Mục tiêu**: Migrate toàn bộ hardcoded asset string paths → flutter_gen type-safe references

> **Hiện trạng**: Tất cả widget đang dùng `Image.asset('assets/...')` và `SvgPicture.asset('assets/...')`.
> Cần migrate sang `Assets.images.*` / `Assets.icons.*` theo constitution v1.3.0.

**Files cần migrate** (theo thứ tự):
1. `lib/features/home/presentation/widgets/hero_content_widget.dart` — 3 assets (key_visual_bg, root_further_logo, ic_arrow_open)
2. `lib/features/home/presentation/widgets/home_header_widget.dart` — 3 assets (logo_saa, ic_search, ic_notification)
3. `lib/features/home/presentation/widgets/kudos_section_widget.dart` — 2 assets (kudos_banner, ic_arrow_open)
4. `lib/features/home/presentation/widgets/kudos_fab_widget.dart` — 2 assets (ic_pen, ic_kudos_logo)
5. `lib/features/home/presentation/widgets/award_card_widget.dart` — 1 asset (EnvConfig URL, giữ nguyên vì là network image)
6. `lib/shared/widgets/bottom_nav_bar.dart` — 4 assets (ic_home, ic_award, ic_kudos, ic_profile)
7. `lib/shared/widgets/language_selector.dart` — 3 assets (flags/vn, flags/en, ic_arrow_down)
8. `lib/features/auth/presentation/widgets/` — 4 assets (login BG, logo, google icon, flags)

**Pattern thay thế**:
```dart
// Image (PNG/JPG)
Image.asset('assets/images/home/key_visual_bg.png', ...) 
→ Assets.images.home.keyVisualBg.image(...)

// SVG
SvgPicture.asset('assets/icons/ic_search.svg', ...)
→ Assets.icons.icSearch.svg(...)
```

**Test**: Chạy toàn bộ `flutter test` sau migration để đảm bảo không break.

### Phase 1: Main Scaffold + Bottom Nav + Router (US11)

**Mục tiêu**: Navigation frame hoạt động

1. Tạo `MainScaffold` trong `lib/app/main_scaffold.dart` (KHÔNG trong features/ — vì shared cho 4 tab, theo constitution: shared code ngoài feature folder)
2. `MainScaffold` = Scaffold + `BottomNavBar` + `IndexedStack` cho 4 tab pages
3. Cập nhật `router.dart`: `/home` → `MainScaffold` > `HomeScreen` (tab 0)
4. Placeholder cho 3 tab còn lại (Awards, Kudos, Profile)
5. **Test**: Widget test bottom nav highlight + tap navigation

### Phase 2: Home Screen Layout + Header (US1, US9, US10)

**Mục tiêu**: Scroll layout + sticky header

1. Tạo `HomeScreen` (`ConsumerStatefulWidget` — cần StatefulWidget cho `ScrollController` dispose):
   ```
   Stack [
     // Layer 1: Background
     HeroContentWidget (Key Visual BG + gradients)
     // Layer 2: Scrollable content
     CustomScrollView [
       SliverToBoxAdapter → HeroContentWidget (logo, countdown, info, CTAs)
       SliverToBoxAdapter → ThemeDescriptionWidget
       SliverToBoxAdapter → AwardsSectionWidget
       SliverToBoxAdapter → KudosSectionWidget (conditional)
     ]
     // Layer 3: Fixed header overlay
     HomeHeaderWidget (opacity fades via ScrollController)
     // Layer 4: FAB
     Positioned → KudosFabWidget
   ]
   ```
   - `HomeScreen` là **duy nhất** gọi `ref.watch(homeViewModelProvider)`.
   - Tất cả widget con (Header, Hero, Awards, Kudos, FAB) là `StatelessWidget`,
     nhận data qua constructor — KHÔNG dùng `ConsumerWidget`.
2. Tạo `HomeHeaderWidget` (`StatelessWidget`) — gradient, logo, language selector (reuse `LanguageSelector`), search icon, notification bell + badge dot
3. Implement header opacity fade-on-scroll via `ScrollController.addListener` + `setState` (cần `StatefulWidget` để dispose controller)
4. Tạo `HomeViewModel extends AsyncNotifier<HomeState>` — 1 ViewModel duy nhất quản lý tất cả data:
   ```dart
   @freezed
   class HomeState with _$HomeState {
     const factory HomeState({
       required EventInfo eventInfo,
       @Default([]) List<AwardCategory> awards,
       @Default(KudosInfo(title: '', description: '', isEnabled: false))
           KudosInfo kudosInfo,
       @Default(0) int unreadNotificationCount,
     }) = _HomeState;
   }
   ```
   > **Lưu ý**: Chỉ `eventInfo` là required. Các field khác có default
   > để HomeScreen có thể render ngay khi có event info mà không cần đợi tất cả API.
   - `build()` gọi tất cả repository methods song song (`Future.wait`)
   - `refresh()` để pull-to-refresh
   - Locale thay đổi → invalidate provider → refetch
5. **Test**: Unit test ViewModel (loading, success, error states). Widget test header badge.

### Phase 3: Hero Content + Countdown (US1, US2)

**Mục tiêu**: Hero section pixel-perfect

1. Hero background: `Stack` với Key Visual image + gradient overlays (Shadow Left, Shadow Bottom)
2. `HeroContentWidget` — Root Further logo + countdown + event info + CTA row
3. `CountdownTimerWidget` (`StatefulWidget` với `Timer.periodic` mỗi giây) — tính days/hours/minutes từ hardcode event date. **QUAN TRỌNG**: cancel Timer trong `dispose()` để tránh memory leak. Dùng `StatefulWidget` (không phải ConsumerStatefulWidget) vì countdown là pure local logic, không cần Riverpod
4. `CountdownDigitBox` — gradient border box + Digital Numbers font
5. `EventInfoRow` — label + highlighted value
6. Tạo shared `PrimaryButton` + `OutlineButton` (theo design-style §1.6 states)
7. **Test**: Unit test countdown logic (future date, past date → 00). Widget test button states.

### Phase 4: Awards Section (US3, US5)

**Mục tiêu**: Horizontal scrollable award cards

1. Tạo shared `SectionHeaderWidget` (label + divider + title — dùng lại cho Awards + Kudos)
2. `AwardsSectionWidget` — header + `ListView.builder` horizontal
3. `AwardCardWidget` — image (160×160) + name + description (max 3 lines ellipsis) + "Chi tiết" text button
4. Wire API: `homeViewModelProvider` → `homeState.awards` (data từ `homeRepository.getAwardCategories(locale:)`)
5. Skeleton loading state: shimmer placeholder (3 card placeholder kích thước 160×298)
6. Empty state: hiển thị text "Chưa có dữ liệu giải thưởng" khi list rỗng (i18n key: `awards_empty`)
7. Navigation: "Chi tiết" → Award Detail route (stub)
8. **Test**: Widget test card content, horizontal scroll, empty state, skeleton loading.

### Phase 5: Kudos Section + FAB (US4, US6, US7)

**Mục tiêu**: Kudos promotion + quick actions

1. `KudosSectionWidget` — header + banner image + "ĐIỂM MỚI CỦA SAA 2025" + description + "Chi tiết" button
2. Conditional render: ẩn nếu `homeState.kudosInfo.isEnabled == false`
3. `KudosFabWidget` — custom pill FAB (89×48, 2 icons + divider) với debounce 300ms
4. Navigation: "Chi tiết" → Kudos detail (stub), FAB pen → Send Kudos (stub), FAB S → Kudos Feed (stub)
5. **Test**: Widget test FAB tap (2 icons), Kudos section visibility toggle.

### Phase 6: Theme Description + Pull-to-Refresh + Polish (US1, US8)

**Mục tiêu**: Hoàn thiện

1. `ThemeDescriptionWidget` — body text block
2. Implement `RefreshIndicator` cho pull-to-refresh (invalidate tất cả providers)
3. Skeleton/shimmer cho toàn màn hình khi loading
4. Error state: retry button
5. Language switcher: wire vào `localeNotifierProvider` → rebuild toàn app
6. **Test**: Integration test full flow (load → display → scroll → navigate). Widget test pull-to-refresh.

---

## Chiến lược Testing (TDD)

| Loại | Focus | Mục tiêu |
|------|-------|----------|
| Unit | `HomeViewModel`, `HomeRepository`, countdown logic | Mỗi provider: loading → success, loading → error, refresh |
| Widget | Từng widget nhỏ (button, card, countdown, header, nav) | Render đúng, tap navigation, states |
| Integration | Full HomeScreen flow | Load data → hiển thị → scroll → navigate → pull-refresh |

### Quy trình TDD mỗi phase

```
1. Viết test FAIL (Red)
2. Implement code tối thiểu để PASS (Green)
3. Refactor giữ test PASS
4. Chạy `flutter analyze` + `dart format`
```

---

## Đánh giá rủi ro

| Rủi ro | Mức độ | Giảm thiểu |
|--------|--------|-----------|
| Custom fonts (Digital Numbers, SVN-Gotham) không có sẵn | Trung bình | Kiểm tra license, fallback font nếu cần |
| Header fade-on-scroll performance | Thấp | Dùng `ScrollController.addListener` + `setState` chỉ khi delta > 0.01. Tránh rebuild không cần thiết |
| Supabase tables chưa tạo | Cao | **Chiến lược**: Phase 0-4 dùng mock data trong datasource (static JSON). Phase 5+ chạy SQL từ `database-schema.sql` lên Supabase staging rồi switch sang real data. Mock datasource implement cùng interface để swap dễ dàng |
| Nhiều navigation stubs (Awards, Kudos, Profile chưa implement) | Thấp | Dùng placeholder screens, implement sau |
| Countdown Timer leak khi dispose | Thấp | Cancel Timer trong `dispose()`, hoặc dùng Riverpod `autoDispose` |
| flutter_gen migration scope rộng | Trung bình | Migrate từng file, chạy test sau mỗi batch. Auth widgets migrate sau cùng (ít ảnh hưởng Home) |

---

## Thứ tự ưu tiên

```
Phase 0   (Foundation)         ──── 0.5 ngày
Phase 0.5 (flutter_gen migrate) ── 0.5 ngày
Phase 1   (Scaffold + Nav)     ──── 0.5 ngày
Phase 2   (Layout + Header)    ──── 1 ngày
Phase 3   (Hero + Countdown)   ──── 1 ngày
Phase 4   (Awards Section)     ──── 0.5 ngày
Phase 5   (Kudos + FAB)        ──── 0.5 ngày
Phase 6   (Polish)             ──── 0.5 ngày
```

**Tổng ước lượng: ~5 ngày** (bao gồm TDD + tests + flutter_gen migration)

---

## Phụ lục: Codebase Context

### Pattern mẫu (từ `features/auth/`)

```
lib/features/auth/
├── data/
│   ├── datasources/auth_remote_datasource.dart  → Supabase calls
│   ├── models/auth_state.dart                   → Freezed union
│   └── repositories/auth_repository.dart        → Abstract + impl
├── presentation/
│   ├── screens/login_screen.dart                → ConsumerStatefulWidget (Screen)
│   ├── viewmodels/auth_viewmodel.dart           → AsyncNotifier<AuthState>
│   └── widgets/                                 → 5 StatelessWidget nhỏ
```

Home feature sẽ follow cùng pattern: 1 ViewModel (AsyncNotifier) + 1 State (freezed).
Widget con là StatelessWidget, nhận data từ Screen qua constructor.

### Existing reusable code

| Code | Đường dẫn | Tái sử dụng |
|------|-----------|-------------|
| `LanguageSelector` | `lib/shared/widgets/language_selector.dart` | Dùng trong HomeHeader |
| `localeProvider` | `lib/shared/providers/locale_provider.dart` | Quản lý ngôn ngữ app-wide |
| `AppColors` | `lib/app/theme/app_colors.dart` | Mở rộng thêm tokens |
| `AppTheme` | `lib/app/theme/app_theme.dart` | TextTheme Montserrat sẵn |
| `routerProvider` | `lib/app/router.dart` | Cập nhật route `/home` |
| Mock helpers | `test/helpers/mocks.dart` | Extend thêm Home mocks |
