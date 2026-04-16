# Kế hoạch Implementation: Profile Bản Thân

**Frame**: `hSH7L8doXB-ios-profile-ban-than`
**Ngày**: 2026-04-16
**Spec**: `specs/hSH7L8doXB-ios-profile-ban-than/spec.md`

---

## Summary

Màn hình Profile Bản Thân cho phép người dùng xem thông tin cá nhân, bộ sưu tập icon badge, thống kê cá nhân (kudos sent/received, hearts, secret boxes), và danh sách kudos với filter sent/received + infinite scroll. Tầng data/Repository/State đã hoàn chỉnh; công việc còn lại gồm: **(1) fix ViewModel bug `isLoadingMoreKudos`**, **(2) sửa visual discrepancies** trên 4 widget, **(3) thêm SVG asset `ic_chevron_down`**, **(4) fix `PrimaryButton` disabled text opacity**, và **(5) viết test coverage theo TDD**.

---

## Technical Context

**Language/Framework**: Dart / Flutter 3.41.3
**Primary Dependencies**: flutter_riverpod, freezed, go_router, google_fonts, flutter_svg, flutter_gen
**Database**: Supabase (PostgreSQL, truy vấn trực tiếp qua supabase_flutter SDK)
**Testing**: flutter_test + mockito
**State Management**: Riverpod — `AsyncNotifier<ProfileState>`
**API Style**: Supabase direct table queries (không phải REST endpoint)

---

## Constitution Compliance Check

*GATE: Phải pass trước khi bắt đầu implementation*

- [x] Tuân thủ kiến trúc MVVM (1 ViewModel `ProfileViewModel` + 1 State `ProfileState` cho feature)
- [x] Widget con là StatelessWidget, nhận data qua constructor
- [x] Asset paths dùng `flutter_gen` (`Assets.xxx`) — không hardcode string
- [x] Icons dùng SVG (`flutter_svg`), backgrounds dùng PNG
- [x] i18n qua slang (`t.profile.*`) — không hardcode text
- [ ] **[CẦN SỬA]** Widget con nhận sai data từ Figma (visual discrepancies)
- [ ] **[CẦN FIX]** `ProfileViewModel.loadMoreKudos()` không toggle `isLoadingMoreKudos` → loading spinner cuối list không bao giờ hiện
- [ ] **[CẦN FIX]** `PrimaryButton` disabled text dùng `withAlpha(128)` (~50%) thay vì `withAlpha(102)` (~40% per design)
- [ ] **[CẦN THÊM]** SVG asset `assets/icons/ic_chevron_down.svg` chưa tồn tại
- [ ] **[CẦN THÊM]** Chưa có unit test / widget test cho profile feature

**Vi phạm cần xử lý**:

| Vi phạm | Mô tả | Hành động |
|---------|-------|-----------|
| `ProfileViewModel` bug | `loadMoreKudos()` không bao giờ set `isLoadingMoreKudos = true/false` — loading indicator cuối list không hoạt động | Fix trong Phase 1 (trước TDD) |
| `ProfileInfoWidget` visual | Avatar 64px (cần 72px), border 0.865 (cần 1.911px), **username fontSize 16 (cần 18px)**, username white (cần #FFEA9E), teamCode 12/500/grey (cần 14/400/white), gap avatar→nameGroup 8px (cần 24px) | Sửa trong Phase 2 |
| `IconCollectionWidget` visual | Icon slot 44×44px (cần 32×32px), gap 8px (cần 14px), section label 14/500/gold (cần 12/400/white) | Sửa trong Phase 2 |
| `ProfileKudosFilterDropdown` visual | Overlay bg `AppColors.bgDark` (#00101A) (cần `AppColors.surfaceDark` = #00070C), selected item bg transparent (cần `const Color(0x1AFFEA9E)`), **option text gold (cần white #FFFFFF)**, **icon Material (cần SVG `icChevronDown`)** | Sửa trong Phase 2 |
| `ProfileKudosListWidget` visual | Gap giữa cards `bottom: 8` (cần `bottom: 24` theo design-style "KudosList gap: 24px") | Sửa trong Phase 2 |
| `PrimaryButton` disabled text | `withAlpha(128)` ≈ 50% opacity (cần `withAlpha(102)` = 40% per design) | Sửa trong Phase 2 |
| `assets/icons/ic_chevron_down.svg` | Chỉ có `ic_chevron_left.svg`; `ic_chevron_down` chưa có — cần tạo | Thêm trong Phase 2 |
| Không có tests | Chưa có test file nào cho profile feature | Viết trước khi fix (TDD) |

---

## Architecture Decisions

### Frontend Approach

- **Component Structure**: Feature-based — toàn bộ UI nằm trong `lib/features/profile/presentation/`
- **Styling Strategy**: `AppColors` constants + `GoogleFonts.montserrat` — không hardcode
- **Data Fetching**: Đã hoàn chỉnh — `ProfileViewModel.build()` gọi 4 Supabase queries song song (profile, stats, badges, kudos)
- **Infinite Scroll**: `ScrollController` trên `ProfileScreen` — trigger `loadMoreKudos()` khi còn 200px cuối. **Bug cần fix**: `loadMoreKudos()` không set `isLoadingMoreKudos = true` trước khi call và `false` sau khi xong.

### Backend Approach

- **Data Access**: Repository pattern hoàn chỉnh — `ProfileRepository` → `ProfileRemoteDatasource` → Supabase
- **Không cần thêm endpoint** — tất cả API calls đã được implement:
  - `fetchMyProfile()` — table `users`
  - `fetchMyStats()` — table `user_stats`
  - `fetchMyIconBadges()` — table `user_icon_badges` JOIN `icon_badges`
  - `fetchKudosHistory(userId, filter, page, limit)` — table `kudos` filter by `sender_id` hoặc `recipient_id`

### Integration Points

- **Shared Components sử dụng**:
  - `PersonalStatsCard` (`shared/widgets/`) — đã có, cần verify button state
  - `HomeHeaderWidget` (`shared/widgets/`) — header fixed overlay đã dùng
  - `PrimaryButton` (`shared/widgets/`) — dùng trong PersonalStatsCard
- **Navigation**:
  - Từ Tab "Profile" → `ProfileScreen` (đã route)
  - `onAvatarTap(userId)` → `/profile/:userId` (other profile)
  - `onViewDetail(kudosId)` → `/kudos/:kudosId` (kudos detail)
  - `onOpenSecretBox` → `/secret-box`
  - **FR-014 (self-redirect) ✅ ĐÃ IMPLEMENT**: `OtherProfileScreen` (line 99-108) đã kiểm tra `currentUserId == widget.userId` và redirect sang tab Profile (`currentTabIndexProvider.state = 3` + `context.pop()`)
- **State deps**: `PersonalStats` từ `lib/features/kudos/data/models/personal_stats.dart`

---

## Project Structure

### Documentation (feature này)

```text
.momorph/specs/hSH7L8doXB-ios-profile-ban-than/
├── spec.md              # Feature specification ✅
├── design-style.md      # Design tokens & component specs ✅
├── plan.md              # File này ✅
└── tasks.md             # Task breakdown (bước tiếp theo)
```

### Source Code — Trạng thái hiện tại

```text
lib/features/profile/
├── data/
│   ├── models/
│   │   ├── profile_state.dart          ✅ Hoàn chỉnh (freezed)
│   │   ├── profile_state.freezed.dart  ✅ Generated
│   │   ├── user_profile.dart           ✅ Hoàn chỉnh
│   │   ├── icon_badge.dart             ✅ Hoàn chỉnh
│   │   ├── kudos_filter_type.dart      ✅ Hoàn chỉnh
│   │   └── badge.dart                  ✅ Hoàn chỉnh
│   ├── repositories/
│   │   └── profile_repository.dart     ✅ Hoàn chỉnh
│   └── datasources/
│       └── profile_remote_datasource.dart ✅ Hoàn chỉnh
└── presentation/
    ├── screens/
    │   ├── profile_screen.dart         ✅ Hoàn chỉnh (logic)
    │   └── other_profile_screen.dart   ✅ FR-014 (self-redirect) đã implement
    ├── viewmodels/
    │   ├── profile_viewmodel.dart      ⚠️ Bug: loadMoreKudos() không toggle isLoadingMoreKudos
    │   └── other_profile_viewmodel.dart ⚠️ Bug tương tự: loadMoreKudos() không toggle isLoadingMoreKudos
    └── widgets/
        ├── profile_info_widget.dart     ⚠️ Cần sửa visual (5 discrepancies incl. fontSize)
        ├── icon_collection_widget.dart  ⚠️ Cần sửa visual (3 discrepancies)
        ├── profile_kudos_filter_dropdown.dart ⚠️ Cần sửa visual (4 discrepancies)
        ├── profile_kudos_list_widget.dart  ⚠️ Cần sửa gap (bottom: 8 → 24)
        ├── kudos_section_header_widget.dart ✅ Hoàn chỉnh
        ├── stat_row_widget.dart             ✅ Hoàn chỉnh
        ├── send_kudos_button_widget.dart    ✅ Hoàn chỉnh
        └── badge_collection_widget.dart     ✅ Hoàn chỉnh

lib/shared/widgets/
└── personal_stats_card.dart            ⚠️ PrimaryButton text disabled alpha 128→102

assets/icons/
└── ic_chevron_down.svg                 ❌ Chưa tồn tại — cần tạo mới
```

### Files Cần Tạo Mới

```text
assets/icons/
└── ic_chevron_down.svg                   # SVG mới — dùng cho dropdown indicator

test/
├── unit/
│   └── viewmodels/
│       └── profile_viewmodel_test.dart   # Unit test ProfileViewModel
├── widget/
│   └── profile/
│       ├── profile_info_widget_test.dart
│       ├── icon_collection_widget_test.dart
│       ├── profile_kudos_filter_dropdown_test.dart
│       └── profile_screen_test.dart
└── helpers/
    └── profile_test_helpers.dart         # Mocks, fakes, test data factories
```

### Files Cần Sửa

| File | Thay đổi cụ thể | Priority |
|------|----------------|----------|
| `lib/features/profile/presentation/viewmodels/profile_viewmodel.dart` | `loadMoreKudos()`: set `isLoadingMoreKudos: true` trước khi await, `false` sau khi xong (cả success và catch) | **P0** |
| `lib/features/profile/presentation/viewmodels/other_profile_viewmodel.dart` | Tương tự bug `isLoadingMoreKudos` — fix cùng lúc | **P0** |
| `lib/features/profile/presentation/widgets/profile_info_widget.dart` | (1) Avatar container: `64`→`72px`, border `0.865`→`1.911px`; (2) Username: `fontSize: 16`→`18`, color `textWhite`→`textAccent`; (3) TeamCode: `fontSize: 12, w500, textSecondary`→`14, w400, textWhite`; (4) Gap avatar→NameGroup: `SizedBox(height: 8)`→`SizedBox(height: 24)` | P1 |
| `lib/features/profile/presentation/widgets/icon_collection_widget.dart` | (1) Section label: `fontSize: 14, w500, textAccent`→`12, w400, textWhite`; (2) Icon slot: `44×44`→`32×32`; (3) Slot gap: `padding right: 8`→`14` | P1 |
| `lib/features/profile/presentation/widgets/profile_kudos_filter_dropdown.dart` | (1) Overlay bg: `AppColors.bgDark`→`AppColors.surfaceDark` (= #00070C, đã tồn tại); (2) Selected item bg: `AppColors.outlineBtnBg`→`const Color(0x1AFFEA9E)`; (3) Option text: `AppColors.textAccent`→`AppColors.textWhite`; (4) Chevron icon: `Icons.keyboard_arrow_up/down`→`Assets.icons.icChevronDown.svg(size: 16, color: textAccent)` | P1 |
| `lib/features/profile/presentation/widgets/profile_kudos_list_widget.dart` | Card gap: `Padding(padding: EdgeInsets.only(bottom: 8))`→`EdgeInsets.only(bottom: 24)` | P1 |
| `lib/shared/widgets/primary_button.dart` | Disabled text: `AppColors.buttonText.withAlpha(128)`→`AppColors.buttonText.withAlpha(102)` (~40% opacity per design spec) | P2 |

---

## Implementation Strategy

### Tổng quan

Tầng data (Model/Repository/Datasource/State) đã hoàn chỉnh. Công việc còn lại:
1. **Fix ViewModel bug** (`isLoadingMoreKudos`) — P0, cần fix trước khi viết test
2. Viết tests theo TDD (bắt buộc per constitution)
3. Sửa visual discrepancies trên 4 widget + 1 shared widget
4. Thêm SVG asset `ic_chevron_down.svg` + regenerate flutter_gen

### Phase Breakdown

#### Phase 0: Fix ViewModel Bug (P0 — trước TDD)

**`lib/features/profile/presentation/viewmodels/profile_viewmodel.dart`** — sửa `loadMoreKudos()`:

```dart
Future<void> loadMoreKudos() async {
  final currentState = state.valueOrNull;
  if (currentState == null || !currentState.hasMoreKudos || currentState.isLoadingMoreKudos) return;

  // Set loading = true trước khi gọi API
  state = AsyncValue.data(currentState.copyWith(isLoadingMoreKudos: true));

  final filterStr = currentState.kudosFilter == KudosFilterType.sent ? 'sent' : 'received';
  _currentPage++;
  try {
    final newKudos = await _profileRepo.getKudosHistory(...);
    state = AsyncValue.data(
      currentState.copyWith(
        kudosList: [...currentState.kudosList, ...newKudos],
        hasMoreKudos: newKudos.length >= _pageLimit,
        isLoadingMoreKudos: false,  // Reset sau khi xong
      ),
    );
  } catch (_) {
    _currentPage--;
    state = AsyncValue.data(currentState.copyWith(isLoadingMoreKudos: false));  // Reset khi lỗi
  }
}
```

Áp dụng tương tự cho `other_profile_viewmodel.dart`.

> **Lý do P0**: `ProfileKudosListWidget` đã có `if (isLoadingMore) CircularProgressIndicator(...)` nhưng `isLoadingMoreKudos` không bao giờ được set `true` → loading spinner cuối list không bao giờ hiện (US7 acceptance criterion bị broken).

#### Phase 0b: Chuẩn bị test infrastructure

- Tạo `test/helpers/profile_test_helpers.dart`
  - Mock `ProfileRepository` (mockito)
  - Mock `KudosRepository`
  - Factory functions tạo `UserProfile`, `PersonalStats`, `IconBadge`, `Kudos` test data
  - `ProviderContainer` helper cho ViewModel tests

#### Phase 1: Unit Tests — ProfileViewModel (TDD trước)

Viết test cho `ProfileViewModel` trước khi sửa bất kỳ widget nào:

| Test case | Mô tả |
|-----------|-------|
| `build() loads initial state` | Verify state có profile, stats, badges, kudos sau build |
| `build() sets kudosFilter = sent` | Default filter là KudosFilterType.sent |
| `changeFilter() switches to received` | Gọi repo với filter='received', reset page=1 |
| `loadMoreKudos() sets isLoadingMoreKudos=true then false` | `isLoadingMoreKudos` = true ngay khi gọi, false khi done |
| `loadMoreKudos() increments page` | Append kudos mới vào list, page tăng |
| `loadMoreKudos() stops when hasMoreKudos=false` | Không gọi repo nếu hasMoreKudos=false |
| `loadMoreKudos() resets isLoadingMoreKudos on error` | `isLoadingMoreKudos` = false khi repo throw |
| `toggleHeart() optimistic update` | isLikedByMe flip ngay, heartCount +/-1 |
| `toggleHeart() rollback on error` | Revert về state cũ khi repo throw |
| `refresh() resets and reloads` | state = loading → data |

#### Phase 2: Visual Fixes — Widget Sửa

Sau khi tests viết xong, sửa từng widget theo TDD:

**2a. Thêm SVG asset `ic_chevron_down.svg`**:
- Tạo file `assets/icons/ic_chevron_down.svg` (thiết kế mũi tên chỉ xuống, 16×16, color inherit)
- Chạy `dart run build_runner build` để regenerate `lib/gen/assets.gen.dart`

**2b. `profile_info_widget.dart`** — 5 visual fixes:
- Avatar container: `width/height: 64` → `width/height: 72`; `Border.all(width: 0.865)` → `Border.all(width: 1.911)`
- Username text: `fontSize: 16, color: AppColors.textWhite` → `fontSize: 18, color: AppColors.textAccent`
- TeamCode text: `fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary` → `fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textWhite`
- Gap avatar→NameGroup: chỉ SizedBox duy nhất giữa `_buildAvatar()` và khối Text name — đổi `height: 8` → `height: 24`. Các gap nội bộ trong name group (height: 2, height: 4) giữ nguyên.

**2c. `icon_collection_widget.dart`** — 3 visual fixes:
- Section label: `fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textAccent` → `fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textWhite`
- Icon slot container: `width: 44, height: 44` → `width: 32, height: 32`
- Gap giữa slots: `padding: EdgeInsets.only(right: 8)` → `padding: EdgeInsets.only(right: 14)`

**2d. `profile_kudos_filter_dropdown.dart`** — 4 visual fixes:
- Overlay container bg: `color: AppColors.bgDark` → `color: AppColors.surfaceDark` (đã tồn tại = `Color(0xFF00070C)`)
- Selected item bg: `color: isSelected ? AppColors.outlineBtnBg : Colors.transparent` → `color: isSelected ? const Color(0x1AFFEA9E) : Colors.transparent`
- Option text color: `color: AppColors.textAccent` → `color: AppColors.textWhite`
- Chevron icon: `Icon(Icons.keyboard_arrow_up/down, size: 16, color: AppColors.textAccent)` → `Assets.icons.icChevronDown.svg(width: 16, height: 16, colorFilter: const ColorFilter.mode(AppColors.textAccent, BlendMode.srcIn))`

**2e. `profile_kudos_list_widget.dart`** — 1 visual fix:
- Card gap: `Padding(padding: const EdgeInsets.only(bottom: 8))` → `Padding(padding: const EdgeInsets.only(bottom: 24))`

**2f. `primary_button.dart`** — 1 fix:
- Disabled text opacity: `AppColors.buttonText.withAlpha(128)` → `AppColors.buttonText.withAlpha(102)` (40% opacity per design-style)

#### Phase 3: Widget Tests

Sau khi sửa xong, viết widget tests xác nhận visual:

| Test | Widget | Assertions |
|------|--------|-----------|
| `renders avatar with correct size` | ProfileInfoWidget | Container 72×72, border 1.911px |
| `username displays in gold color at 18px` | ProfileInfoWidget | Text color = AppColors.textAccent, fontSize = 18 |
| `teamCode displays in white 14px` | ProfileInfoWidget | Text color = AppColors.textWhite, fontSize=14 |
| `gap between avatar and name is 24px` | ProfileInfoWidget | SizedBox.height = 24 |
| `icon slot renders at 32px` | IconCollectionWidget | Container 32×32 |
| `icon slot gap is 14px` | IconCollectionWidget | Padding right = 14 |
| `section label is white 12px` | IconCollectionWidget | Text color=white, fontSize=12 |
| `overlay background is surfaceDark` | ProfileKudosFilterDropdown | Container color = AppColors.surfaceDark |
| `selected option has gold bg` | ProfileKudosFilterDropdown | Container color = Color(0x1AFFEA9E) |
| `option text is white` | ProfileKudosFilterDropdown | Text color = AppColors.textWhite |
| `filter change calls onChanged` | ProfileKudosFilterDropdown | onChanged callback fired |
| `card gap is 24px` | ProfileKudosListWidget | Padding bottom = 24 |
| `loading more indicator shows` | ProfileKudosListWidget | CircularProgressIndicator visible khi isLoadingMore=true |
| `empty state shows message` | ProfileKudosListWidget | Text "Chưa có Kudos nào." khi list rỗng |
| `loading state shows indicator` | ProfileScreen | CircularProgressIndicator visible |
| `error state shows retry text` | ProfileScreen | Error text visible |
| `scroll triggers loadMoreKudos` | ProfileScreen | ViewModel method called at threshold |

#### Phase 4: Integration & Polish

- Kiểm tra `flutter analyze` 0 warnings
- Kiểm tra `dart format` pass toàn bộ files đã sửa
- Verify i18n keys (`t.profile.*`) đủ cho mọi text hiển thị
- Test trên simulator iOS để confirm visual match Figma

### Risk Assessment

| Risk | Xác suất | Tác động | Mitigation |
|------|----------|---------|------------|
| `ic_chevron_down.svg` cần thiết kế mới | High | Medium | Tạo SVG đơn giản 16×16 (chevron down) trong `assets/icons/`; chạy `build_runner build` sau đó |
| `primary_button.dart` là shared widget — fix alpha ảnh hưởng toàn app | Medium | Medium | Kiểm tra tất cả nơi dùng `PrimaryButton` với `enabled: false` trước khi đổi — chỉ có `PersonalStatsCard` và `send_kudos` |
| `loadMoreKudos` double-trigger khi scroll nhanh | Low | Low | Đã thêm guard `if (currentState.isLoadingMoreKudos) return` vào Phase 0 fix |
| Hero tier PNG path đổi tên sau build_runner | Low | Medium | Dùng `Assets.images.*` qua flutter_gen, không hardcode |
| Gap avatar→nameGroup: 24px có thể đổi toàn bộ spacing | Low | Low | Chỉ đổi SizedBox đầu tiên sau `_buildAvatar()`, các SizedBox nội bộ giữ nguyên |

### Estimated Complexity

- **Data layer**: Không cần thay đổi (đã hoàn chỉnh)
- **Presentation visual fixes**: Low
- **Testing**: Medium (cần mock Supabase/Repository)

---

## Integration Testing Strategy

### Test Scope

- [x] **UI ↔ ViewModel**: ProfileScreen watch ProfileViewModel, render đúng state
- [x] **ViewModel ↔ Repository**: Repository calls đúng datasource methods
- [ ] **App ↔ Supabase**: Scope nằm ngoài unit tests — cần manual/e2e test
- [x] **User workflows**: Load profile → filter kudos → toggle heart → scroll load more

### Test Categories

| Category | Applicable? | Scenarios chính |
|----------|-------------|----------------|
| UI ↔ Logic | Yes | Filter change, heart toggle, refresh, scroll threshold |
| Service ↔ Service | No | (Repository đã tách biệt) |
| App ↔ External API | No | (Mock Supabase trong unit tests) |
| App ↔ Data Layer | Yes | ViewModel gọi đúng Repository methods |
| Cross-platform | No | (iOS only) |

### Mocking Strategy

| Dependency | Strategy | Lý do |
|------------|----------|-------|
| `ProfileRepository` | Mock (mockito) | Tránh gọi Supabase trong test, fast & isolated |
| `KudosRepository` | Mock (mockito) | Tương tự |
| `ProfileRemoteDatasource` | Không mock trực tiếp | Test qua Repository layer |
| `GoRouter` / navigation | Stub | Widget test chỉ cần kiểm tra callback, không test navigation |

### Test Scenarios Outline

1. **Happy Path**
   - [x] Build ProfileViewModel với mock data → state có đầy đủ profile/stats/badges/kudos
   - [x] ChangeFilter('received') → kudosList thay thế, page reset về 1
   - [x] LoadMoreKudos → kudosList append, page tăng
   - [x] ToggleHeart (unlike) → optimistic: heartCount -1, isLikedByMe=false

2. **Error Handling**
   - [x] Build fails → AsyncError, ProfileScreen hiện retry tap
   - [x] ToggleHeart throws → rollback về state cũ
   - [x] LoadMoreKudos throws → page decrement, list không đổi

3. **Edge Cases**
   - [x] kudosList rỗng → `hasMoreKudos=false`, không trigger load more
   - [x] hasMoreKudos=false → `loadMoreKudos()` exit sớm, không gọi repo
   - [x] `isLoadingMoreKudos=true` → `loadMoreKudos()` exit sớm, tránh double-trigger
   - [x] iconBadges rỗng → `IconCollectionWidget` không render (conditional check)
   - [x] personalStats null → `PersonalStatsCard` không render
   - [x] avatarUrl null → fallback initial letter

### Coverage Goals

| Area | Target | Priority |
|------|--------|----------|
| ProfileViewModel methods | 100% | High |
| Widget render states | 80%+ | High |
| Error/edge cases | 90%+ | High |
| Navigation callbacks | 70%+ | Medium |

---

## Dependencies & Prerequisites

### Required Before Start

- [x] `constitution.md` đã review
- [x] `spec.md` đã hoàn chỉnh (sau review round)
- [x] `design-style.md` đã fix xong (14+ discrepancies)
- [x] Tầng data đã implement (Repository, Datasource, ViewModel, State)
- [x] `PrimaryButton` source đã đọc: disabled bg = `withAlpha(102)` ✅; disabled text = `withAlpha(128)` ❌ (cần sửa → `withAlpha(102)`)

### External Dependencies

- Supabase project running (cho manual test / e2e)
- Figma assets đã có trong `assets/images/` (kudosKeyVisualBg.png, hero tier PNGs)

---

## Next Steps

Sau khi plan approved:

1. **Chạy** `/momorph.tasks` để generate task breakdown chi tiết
2. **Review** `tasks.md` để phân công parallel tasks
3. **Bắt đầu** theo thứ tự TDD: Phase 0 → Phase 1 → Phase 2 → Phase 3 → Phase 4

---

## Notes

- **ViewModel bug là P0** — `loadMoreKudos()` không bao giờ set `isLoadingMoreKudos = true`, phải fix trước khi viết test
- **FR-014 đã hoàn chỉnh** — `OtherProfileScreen` (line 99-108) đã xử lý self-redirect, không cần implement thêm
- **`AppColors.surfaceDark`** (= `Color(0xFF00070C)`) đã tồn tại — dùng trực tiếp, không cần thêm constant mới
- **`ic_chevron_down.svg` chưa có** — cần tạo file SVG mới và chạy `build_runner build` để regenerate `Assets.icons`
- **Gap ProfileInfoWidget**: `itemSpacing=24` trong Figma là gap giữa avatar container và nhóm text name — chỉ đổi SizedBox đầu tiên sau `_buildAvatar()`. Các gap nội bộ giữa name/teamCode/heroTier (2px, 4px) không thay đổi.
- `KudosSectionHeaderWidget` đã dùng `Assets.images.kudosKeyVisualBg` ✅ — không cần sửa
- Dropdown overlay: Column layout (không dùng OverlayEntry) — đúng với Figma, không đổi
- `PrimaryButton` disabled bg đã đúng (`withAlpha(102)` = 40%); chỉ fix text alpha (`128` → `102`)
