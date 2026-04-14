# Tasks: Award Detail Screen

**Frame**: `award-detail-screen`
**Prerequisites**: plan.md (required), spec.md (required), design-style.md (required)

---

## Task Format

```
- [ ] T### [P?] [Story?] Description | file/path.dart
```

- **[P]**: Có thể chạy song song (khác file, không phụ thuộc nhau)
- **[Story]**: User story (US1, US2, US3, US4)
- **|**: File path bị ảnh hưởng

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Assets, i18n keys mới, theme colors, utility

- [x] T001 Download SVG icons còn thiếu từ Figma: ic_diamond.svg, ic_award_flag.svg, ic_arrow_right.svg | assets/icons/
- [x] T002 Thêm colors mới vào AppColors: kudosBannerBg (#0F0F0F), awardGlow (#FAE287) | lib/app/theme/app_colors.dart
- [x] T003 [P] Thêm i18n keys mới cho award screen (VN): award.recognitionSystem, award.awardQuantityLabel, award.awardValueLabel, award.dropdownHint | lib/i18n/strings_vi.i18n.json
- [x] T004 [P] Thêm i18n keys mới cho award screen (EN): tương ứng T003 | lib/i18n/strings_en.i18n.json
- [x] T005 Viết test cho currency format extension: VN dùng dấu chấm (7.000.000 VNĐ), EN dùng dấu phẩy (7,000,000 VND) | test/unit/extensions/currency_format_extension_test.dart
- [x] T006 Implement currency format extension (pure Dart, không dùng intl) | lib/core/extensions/currency_format_extension.dart
- [x] T007 Chạy `dart run build_runner build` để regenerate assets.gen.dart + `dart run slang` regenerate i18n

**Checkpoint**: Assets, theme, i18n, utility sẵn sàng

---

## Phase 2: Foundation (Data Layer — Blocking)

**Purpose**: Models + Datasource + Repository — TDD. PHẢI hoàn thành trước khi bắt đầu UI.

### Models

- [x] T008 Viết test cho AwardPrize model: fromJson/toJson với fields id, awardCategoryId, prizeType, valueAmount, noteVi, noteEn, sortOrder | test/unit/models/award_prize_test.dart
- [x] T009 Implement AwardPrize freezed model | lib/features/award/data/models/award_prize.dart
- [x] T010 Viết test cho AwardCategory model mở rộng: fromJson với fields mới (nameEn, descriptionEn, quantity, unit, unitEn, prizeValue, prizeNote, prizeNoteEn, slug) + nested awardPrizes list | test/unit/models/award_category_test.dart
- [x] T011 Mở rộng AwardCategory model: thêm fields mới với @Default cho backward compatibility + thêm List<AwardPrize> awardPrizes | lib/features/home/data/models/award_category.dart

### Datasource + Repository

- [x] T012 Viết test cho AwardRepository: fetchCategoriesWithPrizes (happy path, localization vi/en, error case) | test/unit/repositories/award_repository_test.dart
- [x] T013 [P] Implement AwardRemoteDatasource: query `award_categories?select=*,award_prizes(*)&order=sort_order` + localize fields theo locale | lib/features/award/data/datasources/award_remote_datasource.dart
- [x] T014 [P] Implement AwardRepository + provider | lib/features/award/data/repositories/award_repository.dart
- [x] T015 Cập nhật HomeRemoteDatasource._localizeAward: thêm swap cho unit_en, prize_note_en | lib/features/home/data/datasources/home_remote_datasource.dart

### Code Generation + Verification

- [x] T016 Chạy `dart run build_runner build` regenerate .freezed.dart + .g.dart cho models đã sửa/tạo
- [x] T017 Chạy lại Home tests: verify AwardCategory mở rộng không break Home screen (12 pre-existing failures unrelated to model changes — KudosFabWidget overflow)

**Checkpoint**: Data layer hoàn chỉnh, Home screen vẫn hoạt động

---

## Phase 3: User Story 1 — Xem thông tin chi tiết giải thưởng (Priority: P1) MVP

**Goal**: Hiển thị đầy đủ thông tin 1 giải thưởng: badge image, tên, mô tả, số lượng, giá trị

**Independent Test**: Mở tab Awards → thấy Top Talent với đầy đủ thông tin

### ViewModel + State

- [x] T018 Viết test cho AwardViewModel: build() fetch 6 categories, selectedIndex mặc định = 0, selectCategory() thay đổi index, selectBySlug() tìm đúng index, state transitions (loading/success/error) | test/unit/viewmodels/award_viewmodel_test.dart
- [x] T019 Implement AwardState freezed model: List<AwardCategory> categories, int selectedIndex, getter selectedCategory | lib/features/award/data/models/award_state.dart
- [x] T020 Implement AwardViewModel: AsyncNotifier<AwardState>, build() fetch + cache, selectCategory(int), selectBySlug(String), refresh() | lib/features/award/presentation/viewmodels/award_viewmodel.dart
- [x] T021 Chạy `dart run build_runner build` regenerate .freezed.dart cho AwardState

### UI Widgets (bottom-up)

- [x] T022 [P] [US1] Viết widget test cho AwardBadgeImage: render 160x160, border radius, glow shadow | test/widget/award/award_badge_image_test.dart
- [x] T023 [P] [US1] Implement AwardBadgeImage widget: Container 160x160, border 0.455px #FFEA9E, radius 11.429, BoxShadow glow, centered image | lib/features/award/presentation/widgets/award_badge_image_widget.dart
- [x] T024 [P] [US1] Viết widget test cho AwardStatRow: render icon + label + value + unit, test gap 4px (quantity) vs 8px (prize) | test/widget/award/award_stat_row_test.dart
- [x] T025 [P] [US1] Implement AwardStatRow widget: Column [Row(icon+label), gap 12, Row(value+unit)], nhận params icon/label/value/unit/gap | lib/features/award/presentation/widgets/award_stat_row_widget.dart
- [x] T026 [US1] Viết widget test cho AwardInfoBlock: render title row + description + divider + quantity stat + divider + prize stat(s), test Signature hiển thị 2 prize rows | test/widget/award/award_info_block_test.dart
- [x] T027 [US1] Implement AwardInfoBlock widget: compose AwardStatRow cho quantity + prize(s), handle Signature multi-prize case | lib/features/award/presentation/widgets/award_info_block_widget.dart
- [x] T028 [P] [US1] Implement KvKudosBanner widget: static "Hệ thống ghi nhận và cảm ơn" + KUDOS logo | lib/features/award/presentation/widgets/kv_kudos_banner_widget.dart
- [x] T029 [P] [US1] Implement SunKudosBlock widget: SectionHeader + banner + note text + PrimaryButton "Chi tiết" | lib/features/award/presentation/widgets/sun_kudos_block_widget.dart

**Checkpoint**: US1 widgets đã build + test, sẵn sàng assemble screen

---

## Phase 4: User Story 2 — Chuyển đổi giữa các loại giải thưởng (Priority: P1)

**Goal**: Dropdown filter cho phép chuyển đổi giữa 6 giải, nội dung thay đổi động

**Independent Test**: Nhấn dropdown → chọn "Top Project" → nội dung thay đổi → chọn "Signature" → hiển thị 2 dòng giá trị

### Dropdown Widget

- [x] T030 [US2] Viết widget test cho AwardDropdownFilter: render selected text, PopupMenu mở 6 items, highlight current selection, onChanged callback | test/widget/award/award_dropdown_filter_test.dart
- [x] T031 [US2] Implement AwardDropdownFilter: PopupMenuButton với dark theme, border #998C5F, selected item text #FFEA9E | lib/features/award/presentation/widgets/award_dropdown_filter.dart

### Screen Assembly

- [x] T032 [US2] Refactor HomeHeaderWidget sang shared/widgets/: move file + cập nhật import trong HomeScreen | lib/shared/widgets/home_header_widget.dart
- [x] T033 [US2] Viết widget test cho AwardScreen: render full layout (header + KV banner + section header + dropdown + award detail + kudos block + bottom nav), test dropdown chuyển đổi thay đổi content | test/widget/award/award_screen_test.dart
- [x] T034 [US2] Implement AwardScreen: ConsumerWidget, Stack layout (bg layers + scroll content + fixed header + fixed bottom nav), kết nối AwardViewModel, ref.listen(initialAwardSlugProvider) | lib/features/award/presentation/screens/award_screen.dart
- [x] T035 [US2] Cập nhật MainScaffold: thay _PlaceholderTab(title: 'Awards') bằng AwardScreen trong IndexedStack[1] | lib/app/main_scaffold.dart

**Checkpoint**: US1 + US2 hoàn chỉnh — màn hình Award Detail hoạt động đầy đủ

---

## Phase 5: User Story 3 — Điều hướng tới Sun* Kudos (Priority: P2)

**Goal**: Nút "Chi tiết" trong SunKudosBlock điều hướng đến tab Kudos

**Independent Test**: Cuộn xuống phần Kudos → nhấn "Chi tiết" → chuyển sang tab Kudos

- [x] T036 [US3] Implement onPressed trong SunKudosBlock: ref.read(currentTabIndexProvider.notifier).state = 2 | lib/features/award/presentation/widgets/sun_kudos_block_widget.dart

**Checkpoint**: US3 hoàn thành

---

## Phase 6: User Story 4 — Đa ngôn ngữ (Priority: P2)

**Goal**: Chuyển đổi VN/EN hiển thị đúng tất cả text (static labels + dynamic content)

**Independent Test**: Đổi ngôn ngữ sang EN → tất cả labels + mô tả giải thay đổi sang tiếng Anh

- [x] T037 [US4] Verify tất cả widgets dùng i18n keys (t.award.xxx / t.home.xxx) thay vì hardcode string — rà soát toàn bộ widgets trong features/award/presentation/widgets/
- [x] T038 [US4] Verify AwardViewModel truyền locale xuống repository để fetch data đúng ngôn ngữ — test: watch localeNotifierProvider, refetch khi locale thay đổi | lib/features/award/presentation/viewmodels/award_viewmodel.dart
- [x] T039 [US4] Verify currency formatting theo locale: VN = 7.000.000 VNĐ, EN = 7,000,000 VND | lib/features/award/presentation/widgets/award_stat_row_widget.dart

**Checkpoint**: US4 hoàn thành — đa ngôn ngữ hoạt động

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Edge cases, loading/error states, accessibility, navigation từ Home

- [x] T040 [P] Implement loading state: skeleton shimmer cho AwardScreen khi lần đầu fetch | lib/features/award/presentation/screens/award_screen.dart
- [x] T041 [P] Implement error state: hiển thị thông báo lỗi + nút retry khi fetch thất bại | lib/features/award/presentation/screens/award_screen.dart
- [x] T042 Implement scroll reset: khi chuyển giải qua dropdown, ScrollController.animateTo(0) về đầu Award Detail block | lib/features/award/presentation/screens/award_screen.dart
- [x] T043 Implement initialAwardSlugProvider: tạo StateProvider<String?> + cập nhật Home card onTap set slug trước khi switch tab | lib/app/main_scaffold.dart + lib/features/home/presentation/widgets/award_card_widget.dart
- [x] T044 [P] Thêm accessibility: semanticLabel cho dropdown ("Chọn loại giải thưởng"), badge image ("Huy hiệu giải {tên}"), nút "Chi tiết" ("Mở trang chi tiết Sun* Kudos") | lib/features/award/presentation/widgets/
- [x] T045 Final verification: chạy `flutter analyze` + `dart format` — đảm bảo 0 warnings, code formatted

**Checkpoint**: Feature hoàn chỉnh, production-ready

---

## Dependencies & Execution Order

### Phase Dependencies

```
Phase 1 (Setup) ──→ Phase 2 (Foundation/Data Layer) ──→ Phase 3 (US1: View Detail)
                                                         ↓
                                                    Phase 4 (US2: Dropdown + Screen)
                                                         ↓
                                               Phase 5 (US3: Kudos Nav) ←── có thể song song
                                               Phase 6 (US4: i18n)      ←── có thể song song
                                                         ↓
                                                    Phase 7 (Polish)
```

### Within Each Phase

- Tasks có marker [P] trong cùng phase có thể chạy song song
- Tests PHẢI viết và FAIL trước khi implement (TDD)
- Models trước services/repository
- Repository trước ViewModel
- Widgets trước Screen assembly

### Parallel Opportunities

| Song song | Tasks |
|-----------|-------|
| Phase 1 | T003 + T004 (i18n VN/EN) |
| Phase 2 | T013 + T014 (datasource + repository) |
| Phase 3 | T022+T023, T024+T025, T028, T029 (independent widgets) |
| Phase 5+6 | US3 + US4 có thể song song (không phụ thuộc nhau) |
| Phase 7 | T040 + T041 + T044 (loading/error/accessibility) |

---

## Implementation Strategy

### MVP First (Recommended)

1. Complete Phase 1 + 2
2. Complete Phase 3 (US1) + Phase 4 (US2)
3. **STOP & VALIDATE**: Test màn hình Awards hoạt động, dropdown chuyển đổi đúng
4. Continue Phase 5-7

### Summary

| Phase | Tasks | Parallel tasks |
|-------|-------|---------------|
| Phase 1: Setup | T001-T007 (7) | 2 |
| Phase 2: Foundation | T008-T017 (10) | 2 |
| Phase 3: US1 View Detail | T018-T029 (12) | 8 |
| Phase 4: US2 Dropdown | T030-T035 (6) | 0 |
| Phase 5: US3 Kudos Nav | T036 (1) | 0 |
| Phase 6: US4 i18n | T037-T039 (3) | 0 |
| Phase 7: Polish | T040-T045 (6) | 3 |
| **Total** | **45 tasks** | |

---

## Notes

- Commit sau mỗi task hoặc nhóm logic
- Chạy tests trước khi chuyển phase
- Mark tasks complete khi hoàn thành: `[x]`
- Phase 3 (US1) + Phase 4 (US2) cùng Priority P1 — nên complete cả 2 trước khi validate
