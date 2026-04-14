# Implementation Plan: Award Detail Screen

**Frame**: `award-detail-screen`
**Date**: 2026-04-14
**Spec**: `specs/award-detail-screen/spec.md`

---

## Summary

Implement màn hình Award Detail — 1 screen chung cho 6 loại giải thưởng SAA 2025, chuyển đổi qua dropdown filter. Dữ liệu fetch từ Supabase với nested select (award_categories + award_prizes). Screen này thay thế `_PlaceholderTab(title: 'Awards')` hiện tại trong `MainScaffold` (index=1).

---

## Technical Context

**Language/Framework**: Dart / Flutter 3.41.3
**Primary Dependencies**: Riverpod, go_router, freezed, json_serializable, flutter_svg, google_fonts, supabase_flutter, flutter_gen
**Database**: Supabase (PostgreSQL) — bảng `award_categories` (mở rộng) + `award_prizes` (mới)
**Testing**: flutter_test (unit + widget), mockito/mocktail
**State Management**: Riverpod AsyncNotifier
**API Style**: Supabase REST (PostgREST)

---

## Constitution Compliance Check

- [x] Kiến trúc MVVM — 1 AwardViewModel + 1 AwardState
- [x] Feature-based module structure (`features/award/`)
- [x] Model dùng freezed + json_serializable
- [x] Repository pattern tách biệt datasource
- [x] Widget con là StatelessWidget, nhận data qua constructor
- [x] Icons dùng SVG, key visuals dùng PNG
- [x] Asset paths dùng flutter_gen (`Assets.xxx`)
- [x] i18n qua slang
- [x] TDD: viết test trước, implement sau

**Violations**: Không có

---

## Architecture Decisions

### Frontend Approach

- **Component Structure**: Feature-based. AwardScreen là `ConsumerWidget`, tất cả widget con là `StatelessWidget`.
- **Navigation**: AwardScreen nằm trong `MainScaffold.IndexedStack[1]`, thay thế `_PlaceholderTab`.
- **Home → Award với initial selection**: Vì `IndexedStack` không hỗ trợ pass params cho children, dùng shared provider:
  ```dart
  /// Provider chứa slug giải thưởng ban đầu khi navigate từ Home.
  /// Null = mặc định Top Talent (index 0).
  /// AwardViewModel đọc giá trị này trong build(), sau đó reset về null.
  final initialAwardSlugProvider = StateProvider<String?>((ref) => null);
  ```
  **Flow**: Home card onTap → set `initialAwardSlugProvider` = slug → set `currentTabIndexProvider = 1`.
  **Consume**: AwardScreen (ConsumerWidget) `ref.listen(initialAwardSlugProvider)` — khi giá trị non-null → gọi `ref.read(awardViewModelProvider.notifier).selectBySlug(slug)` → reset provider về null.
  > **Lý do KHÔNG dùng build()**: `IndexedStack` giữ AwardScreen alive — `build()` chỉ chạy 1 lần. `ref.listen` trong widget build() đảm bảo phản ứng mỗi khi slug thay đổi, kể cả khi screen đã cached.
- **Data Fetching**: `AwardViewModel extends AsyncNotifier<AwardState>`. Fetch 1 lần khi build(), cache toàn bộ 6 giải + prizes. Chuyển giải qua dropdown chỉ thay đổi `selectedIndex` local.

### Backend Approach

- **Migration**: File `20260414000000_award_detail_updates.sql` đã tạo — thêm cột `unit_en`, `prize_note_en`, mở rộng CHECK constraint, tạo bảng `award_prizes`.
- **Seed data**: Đã cập nhật trong `seed.sql` với data đúng từ Figma.
- **API Query**: 1 Supabase select duy nhất:
  ```
  award_categories?select=*,award_prizes(*)&order=sort_order
  ```

### Integration Points

- **Shared widgets đã có**: `BottomNavBar` (index=1), `SectionHeaderWidget`, `PrimaryButton`, `LanguageDropdown`
- **Shared providers**: `localeNotifierProvider`, `currentTabIndexProvider`
- **Existing model**: `AwardCategory` — cần mở rộng fields
- **HomeHeaderWidget**: Tái sử dụng từ Home, cần refactor sang `shared/` (hoặc dùng trực tiếp)
- **i18n keys reuse**: `home.awardSectionLabel`, `home.awardSystem`, `home.details`, `home.recognitionMovement`, `home.sunKudos`, `home.newFeatureSaa`, `home.kudosDescription` — đã có sẵn

---

## Project Structure

### Documentation

```text
.momorph/specs/award-detail-screen/
├── spec.md              # Feature specification ✅
├── design-style.md      # Design specifications ✅
├── plan.md              # This file ✅
└── tasks.md             # Task breakdown (next step)
```

### Source Code (affected areas)

```text
lib/
├── app/
│   ├── main_scaffold.dart                    # MODIFY — replace placeholder with AwardScreen
│   └── theme/
│       └── app_colors.dart                   # MODIFY — thêm: kudosBannerBg (#0F0F0F), awardGlow (#FAE287)
│
├── features/
│   ├── home/
│   │   └── data/
│   │       ├── models/
│   │       │   └── award_category.dart       # MODIFY — mở rộng fields
│   │       └── datasources/
│   │           └── home_remote_datasource.dart # MODIFY — cập nhật _localizeAward
│   │
│   └── award/                                # NEW — entire feature module
│       ├── data/
│       │   ├── models/
│       │   │   ├── award_prize.dart          # NEW — freezed model
│       │   │   └── award_state.dart          # NEW — freezed state (categories + selectedIndex)
│       │   ├── datasources/
│       │   │   └── award_remote_datasource.dart  # NEW
│       │   └── repositories/
│       │       └── award_repository.dart     # NEW
│       └── presentation/
│           ├── screens/
│           │   └── award_screen.dart         # NEW — main screen
│           ├── viewmodels/
│           │   └── award_viewmodel.dart      # NEW — AsyncNotifier
│           └── widgets/
│               ├── kv_kudos_banner_widget.dart    # NEW
│               ├── award_dropdown_filter.dart      # NEW
│               ├── award_badge_image_widget.dart   # NEW
│               ├── award_info_block_widget.dart    # NEW
│               ├── award_stat_row_widget.dart      # NEW
│               └── sun_kudos_block_widget.dart     # NEW
│
├── i18n/
│   ├── strings_vi.i18n.json                  # MODIFY — thêm keys cho award screen
│   └── strings_en.i18n.json                  # MODIFY — thêm keys cho award screen
│
├── core/
│   └── extensions/
│       └── currency_format_extension.dart     # NEW — int.formatCurrency(locale)
│
└── shared/
    ├── providers/
    │   └── locale_provider.dart               # EXISTING — reuse
    └── widgets/
        └── home_header_widget.dart            # NEW — refactor từ features/home/

test/
├── unit/
│   ├── viewmodels/
│   │   └── award_viewmodel_test.dart          # NEW
│   ├── repositories/
│   │   └── award_repository_test.dart         # NEW
│   └── models/
│       ├── award_category_test.dart           # NEW (mở rộng)
│       └── award_prize_test.dart              # NEW
└── widget/
    └── award/
        ├── award_screen_test.dart             # NEW
        ├── award_dropdown_filter_test.dart     # NEW
        ├── award_info_block_test.dart          # NEW
        └── award_stat_row_test.dart            # NEW

supabase/
├── migrations/
│   └── 20260414000000_award_detail_updates.sql  # ✅ Đã tạo
└── seed.sql                                      # ✅ Đã cập nhật
```

### Dependencies

Không cần thêm package mới — tất cả đã có trong project.

---

## Implementation Strategy

### Phase 0: Asset Preparation

**Mục tiêu**: Đảm bảo SVG icons sẵn sàng cho UI

> **Lưu ý**: Badge images (PNG) đã có sẵn. DB đã có migration + seed — không cần reset.

1. Download SVG icons còn thiếu từ Figma: `ic_diamond.svg`, `ic_award_flag.svg`, `ic_arrow_right.svg`
2. Chạy `dart run build_runner build` để regenerate `assets.gen.dart`
3. Regenerate i18n: `dart run slang`

### Phase 1: Data Layer (Models + Repository + Datasource)

**Mục tiêu**: Foundation — TDD cho toàn bộ data layer

**Thứ tự TDD**:
1. **Test**: `award_prize_test.dart` — test fromJson/toJson cho AwardPrize model
2. **Implement**: `award_prize.dart` — freezed model
3. **Test**: `award_category_test.dart` — test fromJson với fields mới + nested prizes
4. **Implement**: Mở rộng `award_category.dart` — thêm fields mới
5. **Test**: `award_repository_test.dart` — test fetch categories with prizes, localization
6. **Implement**: `award_remote_datasource.dart` + `award_repository.dart`
7. **Cập nhật**: `home_remote_datasource.dart` — cập nhật `_localizeAward` cho fields mới (unit_en, prize_note_en)
8. **Chạy**: `dart run build_runner build` — regenerate `.freezed.dart` + `.g.dart` cho models đã sửa/tạo
9. **Verify**: Chạy lại Home tests — đảm bảo model mở rộng không break Home

### Phase 2: ViewModel + State (US1 — Xem chi tiết giải)

**Mục tiêu**: State management hoàn chỉnh

**Thứ tự TDD**:
1. **Test**: `award_viewmodel_test.dart` — test build() fetch, selectedIndex, state transitions
2. **Implement**: `award_state.dart` — freezed state: `categories`, `selectedIndex`
3. **Implement**: `award_viewmodel.dart` — AsyncNotifier, selectCategory method

### Phase 3: UI Widgets (US1 — Core display)

**Mục tiêu**: Tất cả widget con, pixel-perfect

**Thứ tự** (bottom-up, widgets nhỏ trước):
1. **Test + Impl**: `award_badge_image_widget.dart` — 160x160 badge với glow shadow
2. **Test + Impl**: `award_stat_row_widget.dart` — icon + label + value row (reusable cho cả quantity + prize)
3. **Test + Impl**: `award_info_block_widget.dart` — title row + description + divider + stats
4. **Test + Impl**: `kv_kudos_banner_widget.dart` — static banner
5. **Test + Impl**: `sun_kudos_block_widget.dart` — section header + kudos banner + note + button

### Phase 4: Dropdown + Screen Assembly (US2 — Chuyển đổi giải)

**Mục tiêu**: Tương tác dropdown + screen hoàn chỉnh

1. **Test + Impl**: `award_dropdown_filter.dart` — PopupMenuButton, highlight selected
2. **Test + Impl**: `award_screen.dart` — assemble tất cả widgets, kết nối ViewModel
3. **Integrate**: Cập nhật `main_scaffold.dart` — thay `_PlaceholderTab` bằng `AwardScreen`
4. **Test**: Navigation từ Home card → AwardScreen với initial slug

### Phase 5: Polish + Edge Cases (US3, US4)

**Mục tiêu**: Edge cases, loading/error states, accessibility

> **Lưu ý i18n**: Phần lớn labels đã tồn tại trong namespace `home` (reuse). Các keys MỚI cần thêm trước Phase 3:
> - `award.recognitionSystem` = "Hệ thống ghi nhận và cảm ơn" (KV banner subtitle)
> - `award.awardQuantityLabel` = "Số lượng giải thưởng"
> - `award.awardValueLabel` = "Giá trị giải thưởng"
> - `award.dropdownHint` = "Chọn loại giải thưởng" (accessibility)
>
> Các keys trên nên được thêm ở **đầu Phase 3** (trước khi build widgets), regenerate slang ngay.

1. Implement loading state (skeleton shimmer) cho lần đầu fetch
2. Implement error state (retry button) khi fetch thất bại
3. Implement scroll reset khi chuyển giải (ScrollController.animateTo)
4. Implement `initialAwardSlugProvider` flow: Home card → set slug → switch tab
5. Accessibility: semantic labels cho dropdown, badge image, button
6. Nút "Chi tiết" trong SunKudosBlock → navigate đến Kudos tab (`currentTabIndexProvider = 2`)

---

## Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| AwardCategory model mở rộng break Home screen | Trung bình | Cao | Thêm `@Default` cho tất cả fields mới, đảm bảo backward compatible. Chạy Home tests sau khi sửa. |
| Badge images từ Figma quá nặng (> 500KB) | Thấp | Trung bình | Optimize PNG trước khi add vào assets. Dùng cached_network_image nếu load từ Supabase Storage. |
| PopupMenu không style được đúng design (dark theme) | Trung bình | Thấp | Fallback: custom OverlayEntry nếu PopupMenuButton không đủ customize. |
| mix-blend-mode: screen cho badge image | Thấp | Thấp | Flutter hỗ trợ BlendMode.screen qua ColorFiltered/ShaderMask. Nếu phức tạp, bỏ qua (visual difference nhỏ). |

### Estimated Complexity

- **Frontend**: Medium (nhiều widgets nhưng logic đơn giản)
- **Backend**: Low (migration đã tạo, chỉ cần seed)
- **Testing**: Medium (nhiều widget tests + model tests)

---

## Integration Testing Strategy

### Test Categories

| Category | Applicable? | Key Scenarios |
|----------|-------------|---------------|
| UI ↔ Logic | Yes | ViewModel fetch → screen render, dropdown select → content change |
| App ↔ Data Layer | Yes | Supabase query → AwardCategory parsing, nested award_prizes |
| Cross-platform | No | Mobile-only |

### Mocking Strategy

| Dependency | Strategy | Rationale |
|------------|----------|-----------|
| SupabaseClient | Mock | Test isolation, không cần DB thật cho unit tests |
| AwardRepository | Mock | Widget tests chỉ cần data, không cần real repo |
| localeNotifierProvider | Override | Test i18n switching |

### Test Scenarios

1. **Happy Path**
   - [x] Screen load → fetch 6 categories → display Top Talent by default
   - [x] Select dropdown "Top Project" → content updates with correct data
   - [x] Select "Signature 2025 - Creator" → displays 2 prize rows
   - [x] Navigate from Home card "MVP" → screen shows MVP initially

2. **Error Handling**
   - [x] Network error on load → error state with retry button
   - [x] Retry button → refetch successfully

3. **Edge Cases**
   - [x] Dropdown highlight current selection
   - [x] Scroll reset on award switch
   - [x] Language switch VN↔EN → labels + dynamic content both change

### Coverage Goals

| Area | Target | Priority |
|------|--------|----------|
| Models (fromJson) | 100% | Cao |
| ViewModel (state transitions) | 90%+ | Cao |
| Widgets (render + interaction) | 80%+ | Trung bình |
| Repository/Datasource | 85%+ | Trung bình |

---

## Dependencies & Prerequisites

### Required Before Start

- [x] `constitution.md` reviewed
- [x] `spec.md` completed + reviewed
- [x] `design-style.md` completed + reviewed
- [x] Database migration created (`20260414000000_award_detail_updates.sql`)
- [x] Seed data updated (`seed.sql`)
- [ ] Download SVG icons từ Figma (ic_diamond, ic_award_flag, ic_arrow_right)
- [ ] Download 6 badge PNG images từ Figma

### External Dependencies

- Supabase local instance (đã có, chỉ cần reset)
- Figma access cho asset download (qua MoMorph MCP tools)

---

## Next Steps

After plan approval:

1. **Run** `/momorph.tasks` to generate task breakdown
2. **Download** assets từ Figma
3. **Begin** Phase 0 → Phase 5 theo TDD workflow

---

## Notes

- **i18n reuse**: Nhiều keys đã tồn tại trong namespace `home` — tái sử dụng trực tiếp. Tạo namespace `award` chỉ cho keys mới (xem Phase 5 note).
- **Header refactor**: Move `HomeHeaderWidget` sang `shared/widgets/` trong Phase 3 (trước khi build AwardScreen). Import path cũ của HomeScreen cũng cần cập nhật.
- **Signature prize logic**: `prize_value = NULL` trong `award_categories` → ViewModel check: nếu `category.prizeValue != null` → hiển thị 1 `AwardStatRow`, nếu `null` → lặp `category.awardPrizes` hiển thị nhiều `AwardStatRow`.
- **"Chi tiết" button**: Navigate đến Kudos tab bằng `ref.read(currentTabIndexProvider.notifier).state = 2` (vì Sun*Kudos cũng là tab trong IndexedStack).
- **Currency formatting**: Tạo extension `int.formatCurrency(String locale)` trong `core/extensions/` — VN: `7.000.000 VNĐ` (dấu chấm), EN: `7,000,000 VND` (dấu phẩy). Dùng `NumberFormat` từ package `intl` (đã có qua `supabase_flutter` transitive dependency).
