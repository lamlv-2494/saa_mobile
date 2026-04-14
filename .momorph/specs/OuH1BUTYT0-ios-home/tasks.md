# Tasks — Màn hình chính SAA 2025

**Feature**: `OuH1BUTYT0-ios-home`
**Plan**: `plan.md` | **Spec**: `spec.md`
**Created**: 2026-04-10

---

## Phase 1: Setup — Chuẩn bị Assets & Foundation

> Mục tiêu: Assets, fonts, theme tokens, i18n keys sẵn sàng

- [x] T001 Tải assets từ Figma (Key Visual BG, Root Further logo, award images, Kudos banner) vào `assets/images/` — directories created, actual images pending manual Figma export
- [x] T002 [P] Tải SVG icons từ Figma (search, bell, pen, kudos logo, nav icons, flag VN/EN) vào `assets/icons/` — directories exist, pending manual export
- [x] T003 [P] Thêm custom fonts `Digital Numbers` và `SVN-Gotham` vào `assets/fonts/` và khai báo trong `pubspec.yaml` — directory created, pending font files
- [x] T004 Mở rộng theme tokens trong `lib/app/theme/app_colors.dart` — thêm: divider, navBg, countdownBorder, outlineBtnBg, outlineBtnBorder, notificationBadge, kudosBannerText (theo design-style.md §1.1)
- [x] T005 [P] Thêm i18n keys cho Home vào `lib/i18n/strings_vi.i18n.json` — keys: coming_soon, days, hours, minutes, about_award, about_kudos, award_system, recognition_movement, new_feature_saa, details, event_time, event_venue, livestream_note
- [x] T006 [P] Thêm i18n keys cho Home vào `lib/i18n/strings_en.i18n.json` — tương tự bản EN
- [x] T007 Chạy `dart run slang` để generate i18n code

---

## Phase 2: Foundational — Data Layer & Mocks

> Mục tiêu: Models, datasource, repository, mocks sẵn sàng cho TDD

- [x] T008 [P] Tạo Freezed model `EventInfo` trong `lib/features/home/data/models/event_info.dart`
- [x] T009 [P] Tạo Freezed model `AwardCategory` trong `lib/features/home/data/models/award_category.dart`
- [x] T010 [P] Tạo Freezed model `KudosInfo` trong `lib/features/home/data/models/kudos_info.dart`
- [x] T011 Chạy `dart run build_runner build` để generate Freezed code
- [x] T012 Tạo `HomeRemoteDatasource` (abstract + impl) trong `lib/features/home/data/datasources/home_remote_datasource.dart`
- [x] T013 Tạo `HomeRepository` (abstract + impl) trong `lib/features/home/data/repositories/home_repository.dart`
- [x] T014 [P] Tạo mock classes trong `test/helpers/home_mocks.dart`
- [x] T015 Viết unit test `HomeRepository` trong `test/unit/repositories/home_repository_test.dart` — 10/10 passed: success, error, empty cho mỗi method

---

## Phase 3: US11 — Điều hướng tab dưới [P1]

> Mục tiêu: Navigation frame hoạt động — bottom nav 4 tab + router
> Test criteria: Tap mỗi tab → highlight đúng, router chuyển màn hình đúng

- [x] T016 Tạo `BottomNavBar` widget trong `lib/shared/widgets/bottom_nav_bar.dart`
- [x] T017 [US11] Tạo `MainScaffold` trong `lib/app/main_scaffold.dart`
- [x] T018 [US11] Cập nhật `lib/app/router.dart` — `/home` → `MainScaffold`
- [x] T019 [US11] Viết widget test bottom nav — 4/4 tests passed

---

## Phase 4: US1 + US9 + US10 — Layout + Header + ViewModel [P1]

> Mục tiêu: Home scroll layout + sticky header fade-on-scroll + data loading
> Test criteria: Header hiện đúng, opacity thay đổi khi cuộn, badge dot hiện/ẩn, ViewModel load data

- [x] T020 [US1] Refactor `HomeViewModel` — chuyển từ 4 FutureProvider rời rạc sang 1 `AsyncNotifier<HomeState>` với freezed state model (constitution v1.2.0). Tạo `HomeState` freezed: eventInfo, awards, kudosInfo, unreadCount. `build()` gọi tất cả repo methods. `refresh()` cho pull-to-refresh. Widget con nhận data qua constructor (StatelessWidget)
- [x] T021 [US1] Unit test HomeViewModel — 5/5 passed: success (all data), error propagation, empty awards, refresh, zero unread
- [x] T022 [US1] Refactor `HomeScreen` — `ref.watch(homeViewModelProvider)` duy nhất, truyền data xuống widget con qua constructor. Widget con KHÔNG dùng ConsumerWidget
- [x] T023 [P] [US10] Refactor `HomeHeaderWidget` → `StatelessWidget` — nhận hasUnread, locale, callbacks qua constructor. Không gọi ref.watch
- [x] T024 [US10] Widget test header — 4/4 passed (badge show/hide, search tap, bell tap)

---

## Phase 5: US2 — Bộ đếm ngược [P1]

> Mục tiêu: Hero section với countdown real-time
> Test criteria: Countdown tính đúng days/hours/minutes, hiện 00 khi quá hạn, Timer dispose đúng

- [x] T025 [P] [US2] Tạo `CountdownDigitBox` — 32×56, gradient border, Digital Numbers font
- [x] T026 [US2] Tạo `CountdownTimerWidget` — Timer.periodic, dispose, 00 khi quá hạn
- [x] T027 [US2] Widget test countdown — 4/4 passed (future, past→00, tick, dispose)
- [x] T028 [P] [US1] Tạo `EventInfoRow` — label + highlighted value
- [x] T029 [US1] Tạo shared `PrimaryButton` — gold filled, disabled state
- [x] T030 [P] [US1] Tạo shared `OutlineButton` — gold outline, disabled state
- [x] T031 [US1] Tạo `HeroContentWidget` — BG gradients + logo + countdown + info + CTAs, wired into HomeScreen

---

## Phase 6: US3 + US5 — Phần Giải thưởng [P1]

> Mục tiêu: Section header + horizontal scrollable award cards
> Test criteria: 6 cards hiển thị đúng, cuộn ngang mượt, tap "Chi tiết" điều hướng đúng

- [x] T032 Tạo shared `SectionHeaderWidget`
- [x] T033 [US5] Tạo `AwardCardWidget` — image + name + description (3 lines ellipsis) + "Chi tiết"
- [x] T034 [US5] Widget test award card — 3/3 passed
- [x] T035 [US5] Refactor `AwardsSectionWidget` → `StatelessWidget` — nhận List<AwardCategory> qua constructor, không dùng ConsumerWidget/ref.watch
- [x] T036 [US3] Wire navigation stubs (TODO comments for routes)

---

## Phase 7: US4 + US6 + US7 — Phần Kudos + FAB [P1/P2]

> Mục tiêu: Kudos section conditional + FAB pill debounce
> Test criteria: Section ẩn khi isEnabled=false, FAB 2 actions hoạt động, debounce chặn double-tap

- [x] T037 [US6] Tạo `KudosSectionWidget` — header + banner + description + CTA
- [x] T038 [US6] Conditional render: ẩn khi isEnabled == false — wired in HomeScreen
- [x] T039 [US7] Tạo `KudosFabWidget` — pill 89×48, debounce 300ms
- [x] T040 [US7] Wire FAB navigation stubs (TODO comments)
- [x] T041 [US4] Wire Kudos navigation stubs (TODO comments)
- [x] T042 [US7] Widget test FAB — 4/4 passed (render, tap write, tap view, debounce)

---

## Phase 8: US8 — Ngôn ngữ + Pull-to-Refresh + Polish

> Mục tiêu: Hoàn thiện UX, loading/error states
> Test criteria: Pull-to-refresh reload data, language switch update text, shimmer khi loading, error retry

- [x] T043 [US1] Tạo `ThemeDescriptionWidget` — 14px/300 Montserrat, hide khi empty
- [x] T044 [US1] Pull-to-refresh — RefreshIndicator + refreshAllHomeProviders()
- [x] T045 [US1] Shimmer loading — awards section shimmer placeholders
- [x] T046 [US1] Error state — _ErrorRetryWidget với retry button
- [x] T047 [US8] Language switcher — bottom sheet VN/EN trong HomeHeaderWidget
- [x] T048 `flutter analyze` — 0 issues
- [x] T049 `dart format` — 30 files formatted
- [x] T050 Widget test HomeScreen — 5/5 passed (hero, awards, badge, FAB, kudos toggle)

---

## Phase 9: flutter_gen Setup & Migration (constitution v1.3.0)

> Mục tiêu: Type-safe asset access — loại bỏ toàn bộ hardcoded asset string paths
> Test criteria: Tất cả asset references dùng `Assets.xxx`, `flutter test` pass, `flutter analyze` 0 errors

### 9.1 Setup flutter_gen

- [x] T051 Thêm `flutter_gen_runner` vào `dev_dependencies` trong `pubspec.yaml`
- [x] T052 Thêm config `flutter_gen:` vào `pubspec.yaml` — output: `lib/gen/`, integrations: flutter_svg: true
- [x] T053 Chạy `dart run build_runner build` để generate `lib/gen/assets.gen.dart` + `lib/gen/fonts.gen.dart`
- [x] T054 Verify generated file: `Assets.images.*`, `Assets.icons.*` tồn tại và đúng

### 9.2 Migrate Home widgets

- [x] T055 [P] Migrate `lib/features/home/presentation/widgets/hero_content_widget.dart` — 3 assets → `Assets.images.*` / `Assets.icons.*`
- [x] T056 [P] Migrate `lib/features/home/presentation/widgets/home_header_widget.dart` — 3 assets → `Assets.images.*` / `Assets.icons.*`
- [x] T057 [P] Migrate `lib/features/home/presentation/widgets/kudos_section_widget.dart` — 2 assets → `Assets.images.*` / `Assets.icons.*`
- [x] T058 [P] Migrate `lib/features/home/presentation/widgets/kudos_fab_widget.dart` — 2 assets → `Assets.icons.*`

### 9.3 Migrate Shared widgets

- [x] T059 [P] Migrate `lib/shared/widgets/bottom_nav_bar.dart` — 4 assets → `Assets.icons.*`
- [x] T060 [P] Migrate `lib/shared/widgets/language_selector.dart` — 3 assets → `Assets.icons.flags.*` / `Assets.icons.*`

### 9.4 Migrate Auth widgets

- [x] T061 [P] Migrate `lib/features/auth/presentation/widgets/login_background.dart` — 1 asset → `Assets.images.*`
- [x] T062 [P] Migrate `lib/features/auth/presentation/widgets/login_header.dart` — 3 assets → `Assets.images.*` / `Assets.icons.*`
- [x] T063 [P] Migrate `lib/features/auth/presentation/widgets/google_login_button.dart` — 1 asset → `Assets.icons.*`

### 9.5 Validation

- [x] T064 Chạy `flutter test` — 77/77 passed sau migration
- [x] T065 Chạy `flutter analyze` — 0 errors liên quan asset
- [x] T066 Verify: grep `lib/` (trừ assets.gen.dart) — 0 hardcoded `'assets/` string paths

---

## Dependencies

```
Phase 1 (Setup)           → không phụ thuộc
Phase 2 (Data Layer)      → Phase 1 (cần models, assets)
Phase 3 (US11 - Nav)      → Phase 1 (cần icons, theme)
Phase 4 (US1/9/10)        → Phase 2 + 3 (cần data layer + scaffold)
Phase 5 (US2 - Countdown) → Phase 4 (cần HomeScreen layout)
Phase 6 (US3/5 - Awards)  → Phase 4 (cần HomeScreen + ViewModel)
Phase 7 (US4/6/7 - Kudos) → Phase 4 (cần HomeScreen + ViewModel)
Phase 8 (Polish)          → Phase 5 + 6 + 7 (tất cả features)
Phase 9 (flutter_gen)     → Phase 8 (tất cả widgets đã implement)
```

### Song song hóa

```
Phase 1: T001 || T002 || T003, T005 || T006
Phase 2: T008 || T009 || T010, T014 song song với T012-T013
Phase 5: T025 || T028 || T030 (3 widgets nhỏ song song)
Phase 6 || Phase 7: Có thể chạy song song (không phụ thuộc nhau)
Phase 9: T055 || T056 || T057 || T058 (home widgets song song)
         T059 || T060 (shared widgets song song)
         T061 || T062 || T063 (auth widgets song song)
```

---

## Chiến lược triển khai

### MVP (Minimum Viable Product)
- Phase 1 + 2 + 3 + 4 + 5 = **Scaffold + Header + Hero + Countdown + Awards**
- Đủ để demo flow chính: Login → Home → xem thông tin → duyệt giải thưởng

### Incremental Delivery
1. **Sprint 1** (2 ngày): Phase 1-4 → Skeleton Home hoạt động ✅
2. **Sprint 2** (1.5 ngày): Phase 5-7 → Full features ✅
3. **Sprint 3** (1 ngày): Phase 8 → Polish + tests hoàn chỉnh ✅
4. **Sprint 4** (0.5 ngày): Phase 9 → flutter_gen migration (constitution v1.3.0)

---

## Tổng kết

| Metric | Giá trị |
|--------|---------|
| Tổng tasks | 66 |
| Phase 1 (Setup) | 7 tasks |
| Phase 2 (Foundation) | 8 tasks |
| Phase 3 (US11) | 4 tasks |
| Phase 4 (US1/9/10) | 5 tasks |
| Phase 5 (US2) | 7 tasks |
| Phase 6 (US3/5) | 5 tasks |
| Phase 7 (US4/6/7) | 6 tasks |
| Phase 8 (Polish) | 8 tasks |
| Phase 9 (flutter_gen) | 16 tasks |
| Tasks song song được | 25 tasks [P] |
| User stories covered | US1-US11 |
| Tasks hoàn thành | 66/66 ✅ |
| Tasks còn lại | 0 |
