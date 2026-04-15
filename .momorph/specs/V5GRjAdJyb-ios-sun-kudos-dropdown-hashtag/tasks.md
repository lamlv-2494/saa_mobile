# Tasks: [iOS] Sun*Kudos — Filter Dropdowns (Hashtag + Phong ban)

**Frame**: `V5GRjAdJyb-ios-sun-kudos-dropdown-hashtag` + `76k69LQPfj-ios-sun-kudos-dropdown-phong-ban`
**Prerequisites**: plan.md ✅, spec.md ✅, design-style.md ✅

---

## Dinh dang Task

```
- [ ] T### [P?] [Story?] Mo ta | duong/dan/file
```

- **[P]**: Co the chay song song (file khac nhau, khong phu thuoc lan nhau)
- **[Story]**: User story lien quan (US1–US4)
- **|**: File bi anh huong boi task

---

## Phase 1: Setup (Chuan bi i18n)

**Muc dich**: Them i18n keys moi cho filter dropdown overlay

- [x] T001 [P] Them i18n keys cho filter dropdown vao strings_vi.i18n.json: `filterAll` ("Tat ca"), `filterNoHashtags` ("Chua co hashtag nao"), `filterNoDepartments` ("Chua co phong ban nao"), `filterLoadError` ("Khong the tai danh sach"), `filterRetry` ("Thu lai"), `filterHashtagAccessibility` ("Danh sach hashtag. Chon hashtag de loc"), `filterDepartmentAccessibility` ("Danh sach phong ban. Chon phong ban de loc"), `filterTagSelected` ("{name}. Dang chon") | `lib/i18n/strings_vi.i18n.json`
- [x] T002 [P] Them i18n keys cho filter dropdown vao strings_en.i18n.json: cung keys nhu T001 voi ban dich tieng Anh | `lib/i18n/strings_en.i18n.json`
- [x] T003 Chay `dart run build_runner build` de regenerate slang i18n strings | `lib/i18n/strings.g.dart`

**Checkpoint**: i18n keys san sang. Chay `flutter analyze` dat 0 warnings.

---

## Phase 2: Foundation (FilterTagPill Widget)

**Muc dich**: Tao widget tag pill co ban — building block cho dropdown overlay

**⚠️ QUAN TRONG**: TDD bat buoc — viet test TRUOC khi implement

- [ ] T004 Viet widget test cho `FilterTagPill`: verify render dung style selected (bg #FFEA9E, text #00101A) va unselected (bg rgba(255,234,158,0.10), text #FFFFFF). Verify tap trigger onTap callback. Verify accessibility Semantics(button: true, selected: isSelected) | `test/widget/kudos/filter_tag_pill_test.dart`
- [ ] T005 [US1] Tao `FilterTagPill` widget (StatelessWidget). Nhan params: `String label`, `bool isSelected`, `VoidCallback onTap`. Style: padding 6px 12px, borderRadius 16px, font Montserrat 12px/500. Selected: bg #FFEA9E, border 1px #FFEA9E, text #00101A. Unselected: bg rgba(255,234,158,0.10), border 1px #998C5F, text #FFFFFF. Wrap trong Semantics(button: true, selected: isSelected, label: label) | `lib/features/kudos/presentation/widgets/filter_tag_pill.dart`

**Checkpoint**: FilterTagPill widget hoan chinh. Widget test pass.

---

## Phase 3: US1 — FilterDropdownOverlay Widget (P1)

**Muc dich**: Tao generic overlay dropdown hien thi danh sach tag pills voi "Tat ca" o dau

**Kiem thu doc lap**: Render danh sach tags, chon tag → callback, "Tat ca" selected khi khong co filter, empty state, loading state.

- [ ] T006 Viet widget test cho `FilterDropdownOverlay<T>`: verify render "Tat ca" tag + danh sach items. Verify "Tat ca" selected khi `selectedItem == null`. Verify chon tag → goi `onSelected(item)`. Verify chon "Tat ca" → goi `onSelected(null)`. Verify chon lai tag dang active → goi `onSelected(null)` (toggle behavior). Verify empty state khi `items.isEmpty`. Verify loading state khi `isLoading == true`. Verify max-height scroll khi nhieu items | `test/widget/kudos/filter_dropdown_overlay_test.dart`
- [ ] T007 [US1] [US2] Tao `FilterDropdownOverlay<T>` widget (StatelessWidget). Generic nhan: `List<T> items`, `T? selectedItem`, `String Function(T) getName`, `void Function(T?) onSelected`, `VoidCallback onDismiss`, `String? emptyText`, `bool isLoading` (default: false). Layout: Container(constraints: maxWidth 335, maxHeight 200, padding 12, decoration: bg rgba(0,16,26,0.95), border 1px #998C5F, borderRadius 8) → SingleChildScrollView → Wrap(spacing: 8, runSpacing: 8) chua "Tat ca" FilterTagPill (selected khi selectedItem == null) + items.map FilterTagPill. Toggle logic: neu item == selectedItem → onSelected(null). Empty state: text center khi items rong. Loading state: CircularProgressIndicator khi isLoading | `lib/features/kudos/presentation/widgets/filter_dropdown_overlay.dart`

**Checkpoint**: FilterDropdownOverlay generic widget hoan chinh. Widget tests pass. Dung cho ca Hashtag va Phong ban.

---

## Phase 4: US1+US2+US3+US4 — Refactor HighlightSectionWidget (P1)

**Muc dich**: Thay bottom sheet hien tai bang overlay dropdown, mutual exclusion, tap outside to close

**Kiem thu doc lap**: Tap hashtag button → mo overlay dropdown voi tag pills. Tap department button khi hashtag dang mo → dong hashtag, mo department. Tap ngoai → dong. Chon filter → dong dropdown + apply filter.

### Widget Tests

- [ ] T008 Viet widget test cho HighlightSectionWidget refactor: verify tap hashtag button → mo hashtag dropdown overlay. Verify tap department button khi hashtag dropdown dang mo → dong hashtag, mo department (mutual exclusion). Verify tap ngoai dropdown → dong. Verify chon filter → dropdown dong, callback triggered. Verify chon "Tat ca" → clear filter. Verify dispose → overlay removed | `test/widget/kudos/highlight_section_filter_test.dart`

### Refactor Implementation

- [ ] T009 [US3] [US4] Chuyen `HighlightSectionWidget` tu StatelessWidget → StatefulWidget. Them state: `_ActiveDropdown _activeDropdown` (enum: none, hashtag, department), `OverlayEntry? _overlayEntry`, `LayerLink _hashtagLayerLink`, `LayerLink _departmentLayerLink`. Them methods: `_toggleDropdown(ActiveDropdown type)`, `_showDropdown(ActiveDropdown type)`, `_closeDropdown()`. Dispose: dong overlay neu con mo | `lib/features/kudos/presentation/widgets/highlight_section_widget.dart`
- [ ] T010 [US1] [US2] Wrap `FilterDropdownButton` hashtag voi `CompositedTransformTarget(link: _hashtagLayerLink)`. Thay `_showHashtagBottomSheet()` bang `_toggleDropdown(ActiveDropdown.hashtag)`. OverlayEntry structure: Stack → GestureDetector full-screen (tap → close) + CompositedTransformFollower(link: _hashtagLayerLink, targetAnchor: bottomLeft, followerAnchor: topLeft, offset: Offset(0, 4)) chua `FilterDropdownOverlay<Hashtag>(items: hashtags, selectedItem: selectedHashtag, getName: (h) => h.name, onSelected: callback)` | `lib/features/kudos/presentation/widgets/highlight_section_widget.dart`
- [ ] T011 [US1] [US2] Wrap `FilterDropdownButton` department voi `CompositedTransformTarget(link: _departmentLayerLink)`. Thay `_showDepartmentBottomSheet()` bang `_toggleDropdown(ActiveDropdown.department)`. Tuong tu T010 nhung dung `FilterDropdownOverlay<Department>` voi `getName: (d) => d.name` | `lib/features/kudos/presentation/widgets/highlight_section_widget.dart`
- [ ] T012 [US4] Implement mutual exclusion logic trong `_toggleDropdown()`: neu cung type dang mo → dong (toggle off). Neu khac type dang mo → dong cai cu, mo cai moi. Neu khong co gi mo → mo | `lib/features/kudos/presentation/widgets/highlight_section_widget.dart`
- [ ] T013 Xoa `_FilterOptionsList` private class va `_showHashtagBottomSheet()` / `_showDepartmentBottomSheet()` methods — khong con can bottom sheet | `lib/features/kudos/presentation/widgets/highlight_section_widget.dart`
- [ ] T014 [US2] Verify FilterDropdownButton hien thi ten hashtag/department da chon thay placeholder khi filter active — `selectedValue` param cua FilterDropdownButton da ho tro, dam bao hoat dong dung voi refactor | `lib/features/kudos/presentation/widgets/highlight_section_widget.dart`

**Checkpoint**: Filter dropdown refactor hoan chinh. Bottom sheet da thay bang overlay tag pills. Mutual exclusion hoat dong. Tap outside dong. Filter apply dung.

---

## Phase 5: Polish & Cross-cutting Concerns

**Muc dich**: Animation, accessibility, scroll interaction, performance

- [ ] T015 [P] Dropdown animation: wrap `FilterDropdownOverlay` trong `FadeTransition` hoac `AnimatedOpacity` (150ms ease-out) khi mo/dong | `lib/features/kudos/presentation/widgets/highlight_section_widget.dart`
- [ ] T016 [P] Tag selection animation: dung `AnimatedContainer` (100ms ease-in-out) cho bg color + text color transition trong FilterTagPill | `lib/features/kudos/presentation/widgets/filter_tag_pill.dart`
- [ ] T017 [P] Accessibility: them `Semantics(label: t.kudos.filterHashtagAccessibility)` tren hashtag dropdown container. `Semantics(label: t.kudos.filterDepartmentAccessibility)` tren department dropdown. `Semantics(button: true, selected: isSelected, label: getName(item))` tren moi tag — verify VoiceOver labels dung theo spec | `lib/features/kudos/presentation/widgets/filter_dropdown_overlay.dart`, `lib/features/kudos/presentation/widgets/highlight_section_widget.dart`
- [ ] T018 [P] Edge case: dropdown mo khi scroll Kudos feed → dong dropdown. Listen `NotificationListener<ScrollNotification>` trong HighlightSectionWidget hoac parent, goi `_closeDropdown()` khi scroll bat dau | `lib/features/kudos/presentation/widgets/highlight_section_widget.dart`
- [ ] T019 Cap nhat test helpers: them mock hashtag list va department list cho filter dropdown tests | `test/helpers/kudos_test_helpers.dart`
- [ ] T020 Chay `flutter analyze` + `dart format` — dam bao 0 warnings, 0 lint errors | Toan bo project
- [ ] T021 Chay toan bo test suite: `flutter test` — dam bao tat ca tests pass. Coverage >= 90% cho FilterTagPill, >= 90% cho FilterDropdownOverlay, >= 80% cho HighlightSectionWidget overlay logic | `test/`

**Checkpoint**: Feature Filter Dropdowns hoan chinh. Tat ca tests pass. Lint clean. Animation muot. Accessibility dung.

---

## Phu thuoc & Thu tu thuc thi

### Phu thuoc giua Phases

```
Phase 1 (Setup: i18n) ───────────────────────────────────┐
    │                                                      │
    v                                                      │
Phase 2 (Foundation: FilterTagPill) ──────────────────────┤
    │                                                      │
    v                                                      │
Phase 3 (US1: FilterDropdownOverlay) ─────────────────────┤
    │                                                      │
    v                                                      │
Phase 4 (US1-4: Refactor HighlightSectionWidget) ────────┤
    │                                                      │
    v                                                      │
Phase 5 (Polish) ─────────────────────────────────────────┘
```

### Song song trong moi Phase

- **Phase 1**: T001, T002 song song (files khac nhau)
- **Phase 2**: T004 (test) truoc T005 (implement)
- **Phase 3**: T006 (test) truoc T007 (implement)
- **Phase 4**: T008 (test) truoc T009–T014 (implement). T009–T013 tuan tu (cung file, refactor lon)
- **Phase 5**: T015, T016, T017, T018 song song (files khac nhau hoac khac logic)

### Trong moi task

1. Test PHAI viet truoc va FAIL (TDD)
2. Implement chi du de pass test
3. Khong overengineering

---

## Ghi chu

- Day la **refactor UI** — behavior filter khong thay doi (cung ViewModel methods), chi thay doi cach hien thi dropdown
- `_FilterOptionsList` (bottom sheet voi ListTile) se bi xoa — thay bang `FilterDropdownOverlay` (overlay voi tag pills)
- `FilterDropdownButton` giu nguyen — chi wrap them `CompositedTransformTarget`
- `KudosViewModel` KHONG can sua — `setHashtagFilter()`, `setDepartmentFilter()`, `clearFilters()` da co
- `KudosState` KHONG can sua — `availableHashtags`, `availableDepartments`, `selectedHashtag`, `selectedDepartment` da co
- Dropdown Hashtag va Dropdown Phong ban implement cung luc vi dung chung generic widget `FilterDropdownOverlay<T>`
- Khong can them seed data moi — 10 hashtags + 6 departments da du cho testing
- Tat ca text moi PHAI ho tro da ngon ngu (VN/EN) qua i18n slang
- Commit sau moi task hoac nhom logic
- Chay `flutter test` truoc khi chuyen phase
- TDD bat buoc: Viet test → Test FAIL (Red) → Implement → Test PASS (Green) → Refactor
- Justification cho StatefulWidget o HighlightSectionWidget: can quan ly OverlayEntry lifecycle (insert/remove/dispose) — day la UI state thuan, khong phai business logic
