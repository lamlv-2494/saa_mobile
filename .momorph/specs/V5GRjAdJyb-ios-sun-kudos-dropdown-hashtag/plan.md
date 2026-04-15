# Kế hoạch triển khai: [iOS] Sun*Kudos — Filter Dropdowns (Hashtag + Phòng ban)

**Frame**: `V5GRjAdJyb-ios-sun-kudos-dropdown-hashtag` + `76k69LQPfj-ios-sun-kudos-dropdown-phong-ban`
**Ngày**: 2026-04-15
**Spec**: `specs/V5GRjAdJyb-ios-sun-kudos-dropdown-hashtag/spec.md` + `specs/76k69LQPfj-ios-sun-kudos-dropdown-phong-ban/spec.md`

---

## Tóm tắt

Refactor Filter Dropdowns trên Highlight Kudos section từ `showModalBottomSheet` (danh sách dọc) sang **overlay dropdown tag pills** (Wrap layout) theo đúng Figma design. Tạo generic `FilterDropdownOverlay<T>` widget tái sử dụng cho cả Hashtag và Phòng ban. Dropdown hiển thị dạng tag pill chips với "Tất cả" (i18n) ở đầu, single-select, đóng khi chọn hoặc tap ngoài. Hai dropdown loại trừ lẫn nhau — chỉ 1 mở tại 1 thời điểm. Filter kết hợp theo logic AND.

**Lưu ý**: Code hiện tại đã có `FilterDropdownButton` (trigger button) và `_FilterOptionsList` (bottom sheet). Cần **refactor** `_FilterOptionsList` thành overlay dropdown với tag pills thay vì bottom sheet với ListTile.

---

## Bối cảnh kỹ thuật

**Framework**: Flutter 3.41.3 / Dart ^3.11.1
**Phụ thuộc chính**: flutter_riverpod, freezed, google_fonts, flutter_svg, flutter_gen, slang
**Backend**: Supabase (PostgREST — đã có endpoints `GET /rest/v1/hashtags`, `GET /rest/v1/departments`)
**Testing**: flutter_test + mocktail (TDD bắt buộc)
**State Management**: Riverpod — `KudosViewModel` quản lý filter state

---

## Kiểm tra tuân thủ Constitution

| Yêu cầu | Quy tắc Constitution | Trạng thái |
|----------|----------------------|-----------|
| MVVM + Riverpod | Filter state quản lý bởi `KudosViewModel` — KHÔNG tạo ViewModel riêng | ✅ Tuân thủ |
| Feature-based module | Nằm trong `lib/features/kudos/presentation/widgets/` | ✅ Tuân thủ |
| Widget con = StatelessWidget | `FilterDropdownOverlay` là StatelessWidget, nhận data qua constructor | ✅ Tuân thủ |
| Reusable components | Generic `FilterDropdownOverlay<T>` dùng cho cả Hashtag và Phòng ban | ✅ Tuân thủ |
| flutter_gen (Assets.xxx) | Không hardcode path | ✅ Tuân thủ |
| i18n (slang) VN/EN | "Tất cả", text empty/error qua `t.kudos.*` | ✅ Tuân thủ |
| TDD | Viết test trước → implement → refactor | ✅ Tuân thủ |
| Clean code | Tách nhỏ widget, mỗi widget 1 trách nhiệm | ✅ Tuân thủ |

**Vi phạm**: Không có.

---

## Quyết định kiến trúc

### Frontend

- **Generic Widget Pattern**: `FilterDropdownOverlay<T>` nhận `List<T> items`, `T? selectedItem`, `String Function(T) getName`, `void Function(T?) onSelected` — tái sử dụng cho cả Hashtag và Phòng ban.
- **Overlay Approach**: Dùng `OverlayEntry` hoặc `CompositedTransformFollower` + `CompositedTransformTarget` để hiển thị dropdown ngay dưới `FilterDropdownButton`. KHÔNG dùng `showModalBottomSheet` như hiện tại.
- **Dropdown State Management**: Chuyển `HighlightSectionWidget` từ `StatelessWidget` → `StatefulWidget` để quản lý:
  - `_activeDropdown` enum (`none`, `hashtag`, `department`) — đảm bảo chỉ 1 dropdown mở
  - `OverlayEntry?` reference để insert/remove overlay
  - `LayerLink` cho mỗi dropdown button
- **Lưu ý Constitution**: Constitution quy định widget con PHẢI là `StatelessWidget`. Tuy nhiên, `HighlightSectionWidget` cần quản lý overlay lifecycle (`OverlayEntry` insert/remove, `dispose`) — đây là **justification hợp lệ** cho `StatefulWidget` vì overlay state là UI state thuần, không phải business logic.
- **Tag Pill Widget**: `FilterTagPill` — StatelessWidget hiển thị 1 tag với selected/unselected style.
- **Tap Outside to Close**: `GestureDetector` full-screen trong `OverlayEntry` bắt tap ngoài → đóng dropdown.
- **Filter Logic**: Giữ nguyên AND logic hiện tại trong `KudosViewModel` (`setHashtagFilter` + `setDepartmentFilter`).
- **Cache**: Danh sách hashtag/department đã được load trong `KudosViewModel.build()` và lưu trong `KudosState.availableHashtags` / `availableDepartments` — không cần cache riêng. Đáp ứng TR-001 (cache sau lần load đầu).

### Backend Integration

- **API**: Reuse endpoints đã có — `GET /rest/v1/hashtags`, `GET /rest/v1/departments`.
- **Repository/Datasource**: Không cần sửa — `getHashtags()`, `getDepartments()` đã có.
- **ViewModel**: `setHashtagFilter()` và `setDepartmentFilter()` đã có — không cần sửa logic, chỉ cần sửa UI trigger.

### Tích hợp hiện tại — Phân tích code cần refactor

- **`FilterDropdownButton`** (`filter_dropdown_button.dart`): GIỮ NGUYÊN — widget trigger button đã đúng design (label + arrow icon + border).
- **`HighlightSectionWidget`** (`highlight_section_widget.dart`): SỬA ĐÁNG KỂ — thay `_showHashtagBottomSheet()` / `_showDepartmentBottomSheet()` bằng overlay dropdown logic. Chuyển từ `StatelessWidget` → `StatefulWidget` để quản lý overlay state. Xóa `_FilterOptionsList` private class.
- **`_FilterOptionsList`** (`highlight_section_widget.dart`): XÓA — thay bằng `FilterDropdownOverlay<T>` mới.
- **`KudosViewModel`**: KHÔNG SỬA — `setHashtagFilter()`, `setDepartmentFilter()`, `clearFilters()` đã có.
- **`KudosState`**: KHÔNG SỬA — `availableHashtags`, `availableDepartments`, `selectedHashtag`, `selectedDepartment` đã có.
- **i18n**: SỬA — thêm keys mới cho dropdown overlay.

---

## Cấu trúc Project

### Tài liệu

```text
.momorph/specs/V5GRjAdJyb-ios-sun-kudos-dropdown-hashtag/
├── spec.md              # Đặc tả Dropdown Hashtag ✅
├── design-style.md      # Đặc tả thiết kế Hashtag ✅
└── plan.md              # File này ✅

.momorph/specs/76k69LQPfj-ios-sun-kudos-dropdown-phong-ban/
├── spec.md              # Đặc tả Dropdown Phòng ban ✅
└── design-style.md      # Đặc tả thiết kế Phòng ban ✅
```

### Source Code (ảnh hưởng)

```text
lib/
├── features/
│   └── kudos/
│       └── presentation/
│           └── widgets/
│               ├── filter_dropdown_overlay.dart     # MỚI: Generic overlay dropdown với tag pills
│               ├── filter_tag_pill.dart             # MỚI: Tag pill widget (selected/unselected)
│               ├── filter_dropdown_button.dart      # CÓ SẴN: Giữ nguyên trigger button
│               └── highlight_section_widget.dart    # SỬA: Refactor từ BottomSheet → Overlay + StatefulWidget

├── i18n/
│   ├── strings_vi.i18n.json                        # SỬA: thêm keys dropdown
│   └── strings_en.i18n.json                        # SỬA: thêm keys dropdown

test/
├── widget/
│   └── kudos/
│       ├── filter_dropdown_overlay_test.dart        # MỚI: widget test overlay dropdown
│       ├── filter_tag_pill_test.dart                # MỚI: widget test tag pill states
│       └── highlight_section_filter_test.dart       # MỚI: integration test filter flow
└── helpers/
    └── kudos_test_helpers.dart                      # SỬA: thêm mock hashtags/departments
```

### Dependencies mới

Không cần thêm package mới — tất cả đã có trong `pubspec.yaml`.

---

## Chiến lược triển khai

### Phase 0: Xác nhận dữ liệu Supabase & Chuẩn bị i18n

**Kiểm tra seed data hiện có**:
- 10 hashtags (`#Dedicated`, `#Inspiring`, `#Creative`, `#TeamPlayer`, `#Leadership`, `#Innovation`, `#RootFurther`, `#Grateful`, `#BestColleague`, `#SunKudos`)
- 6 departments (`CECV1`, `CECV2`, `CECV3`, `CECV4`, `ODP`, `Infra`)
- 48 kudos với hashtags đã gán — **đủ cho filter testing**
- **Không cần thêm seed data mới** — dữ liệu hiện tại đáp ứng:
  - Hashtag filter: 10 hashtags với kudos phân bổ đa dạng
  - Department filter: 6 departments, 15 users trải đều
  - AND filter: kudos có cả hashtag lẫn sender thuộc department khác nhau
  - Empty result: có thể tạo bằng cách filter hashtag + department không có giao

**Lưu ý**: Nếu cần thêm data trong tương lai, chỉ APPEND vào `supabase/seed.sql` với `INSERT ... ON CONFLICT DO NOTHING`. KHÔNG BAO GIỜ dùng `supabase db reset`. Chạy seed qua:
```bash
psql -h localhost -p 54322 -U postgres -d postgres -f supabase/seed.sql
```

**Thêm/cập nhật i18n keys** (VN + EN):
  - `filterAll`: "Tất cả" / "All"
  - `filterNoHashtags`: "Chưa có hashtag nào" / "No hashtags available"
  - `filterNoDepartments`: "Chưa có phòng ban nào" / "No departments available"
  - `filterLoadError`: "Không thể tải danh sách" / "Cannot load list"
  - `filterRetry`: "Thử lại" / "Retry"
  - `filterHashtagAccessibility`: "Danh sách hashtag. Chọn hashtag để lọc" / "Hashtag list. Select hashtag to filter"
  - `filterDepartmentAccessibility`: "Danh sách phòng ban. Chọn phòng ban để lọc" / "Department list. Select department to filter"
  - `filterTagSelected`: "{name}. Đang chọn" / "{name}. Selected"
- Chạy `dart run slang` để regenerate i18n

### Phase 1: Filter Tag Pill Widget

**TDD**: Viết widget test trước cho selected/unselected states.

1. **Tạo `FilterTagPill`** (`lib/features/kudos/presentation/widgets/filter_tag_pill.dart`):
   - `StatelessWidget` nhận: `String label`, `bool isSelected`, `VoidCallback onTap`
   - Style theo design-style.md:
     - **Selected**: bg `#FFEA9E`, border `1px solid #FFEA9E`, text color `#00101A`
     - **Unselected**: bg `rgba(255,234,158,0.10)`, border `1px solid #998C5F`, text color `#FFFFFF`
     - **Chung**: padding `6px 12px`, borderRadius `16px`, font Montserrat 12px/500
   - Accessibility: `Semantics(button: true, selected: isSelected, label: ...)`

### Phase 2: Filter Dropdown Overlay Widget

**TDD**: Viết widget test cho hiển thị, chọn, đóng.

1. **Tạo `FilterDropdownOverlay<T>`** (`lib/features/kudos/presentation/widgets/filter_dropdown_overlay.dart`):
   - Generic `StatelessWidget` nhận:
     - `List<T> items`
     - `T? selectedItem`
     - `String Function(T) getName`
     - `void Function(T?) onSelected` (null = chọn "Tất cả" / clear filter)
     - `VoidCallback onDismiss`
     - `String? emptyText` (khi `items.isEmpty`)
   - Layout:
     ```
     Container(
       constraints: BoxConstraints(maxWidth: 335, maxHeight: 200),
       padding: EdgeInsets.all(12),
       decoration: BoxDecoration(
         color: Color(0xF200101A),  // rgba(0,16,26,0.95)
         border: Border.all(color: AppColors.outlineBtnBorder),  // #998C5F
         borderRadius: BorderRadius.circular(8),
       ),
       child: SingleChildScrollView(
         child: Wrap(
           spacing: 8,
           runSpacing: 8,
           children: [
             // "Tất cả" tag — selected khi selectedItem == null
             FilterTagPill(label: t.kudos.filterAll, isSelected: selectedItem == null, onTap: () => onSelected(null)),
             // Items
             ...items.map((item) => FilterTagPill(
               label: getName(item),
               isSelected: item == selectedItem,
               onTap: () => onSelected(item),
             )),
           ],
         ),
       ),
     )
     ```
   - **Empty state**: Khi `items.isEmpty` → hiển thị text `emptyText` (center, Montserrat 12px/400, color `#999999`)
   - **Loading state**: Khi danh sách đang tải → hiển thị loading indicator (spinner) trong dropdown container. Cần thêm param `bool isLoading` (default: false).
   - **BackdropFilter**: `BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10))` trên container (tùy performance — có thể bỏ nếu laggy)

### Phase 3: Refactor HighlightSectionWidget

**TDD**: Viết test cho mutual exclusion, filter apply, đóng khi scroll.

1. **Chuyển `HighlightSectionWidget` từ `StatelessWidget` → `StatefulWidget`**:
   - **Justification cho StatefulWidget**: Cần quản lý `OverlayEntry` lifecycle (insert/remove/dispose) — đây là UI state thuần, không vi phạm nguyên tắc ViewModel.
   - State quản lý:
     - `_ActiveDropdown _activeDropdown` (enum: `none`, `hashtag`, `department`)
     - `OverlayEntry? _overlayEntry`
     - `LayerLink _hashtagLayerLink`, `LayerLink _departmentLayerLink`
   - Methods:
     - `_toggleDropdown(ActiveDropdown type)` — nếu cùng type đang mở → đóng; nếu khác type → đóng cái cũ, mở cái mới
     - `_showDropdown(ActiveDropdown type)` — tạo `OverlayEntry` với `CompositedTransformFollower` + `FilterDropdownOverlay<T>`
     - `_closeDropdown()` — remove overlay, set `_activeDropdown = none`
   - `dispose()` — đóng overlay nếu còn mở

2. **Wrap `FilterDropdownButton` với `CompositedTransformTarget`**:
   ```dart
   CompositedTransformTarget(
     link: _hashtagLayerLink,
     child: FilterDropdownButton(
       label: t.kudos.filterHashtag,
       selectedValue: selectedHashtag?.name,
       width: 129,
       onTap: () => _toggleDropdown(ActiveDropdown.hashtag),
     ),
   )
   ```

3. **OverlayEntry structure**:
   ```dart
   OverlayEntry(
     builder: (_) => Stack(
       children: [
         // Tap outside → close
         GestureDetector(onTap: _closeDropdown, child: Container(color: Colors.transparent)),
         // Dropdown positioned below button
         CompositedTransformFollower(
           link: layerLink,
           targetAnchor: Alignment.bottomLeft,
           followerAnchor: Alignment.topLeft,
           offset: Offset(0, 4),
           child: FilterDropdownOverlay<T>(
             items: items,
             selectedItem: selectedItem,
             getName: getName,
             onSelected: (item) {
               _closeDropdown();
               onItemSelected(item);
             },
             onDismiss: _closeDropdown,
           ),
         ),
       ],
     ),
   )
   ```

4. **Xóa `_FilterOptionsList`** và `_showHashtagBottomSheet()` / `_showDepartmentBottomSheet()` — không còn cần.

5. **Filter callback giữ nguyên**: `onHashtagSelected?.call(hashtag)` → gọi ViewModel `setHashtagFilter()` / `setDepartmentFilter()` như hiện tại.

6. **Chọn lại hashtag đang active**: Spec US-2 yêu cầu chọn lại cùng hashtag đang active → xóa filter (toggle behavior). Cần thêm logic: nếu `item == selectedItem` → gọi `onSelected(null)` thay vì `onSelected(item)`.

### Phase 4: Animation & Polish

1. **Dropdown animation**: Wrap `FilterDropdownOverlay` trong `AnimatedOpacity` hoặc `FadeTransition` (150ms ease-out) khi mở/đóng
2. **Tag selection animation**: `AnimatedContainer` (100ms ease-in-out) cho bg color + text color transition
3. **Accessibility**:
   - `Semantics(label: t.kudos.filterHashtagAccessibility)` trên dropdown container
   - `Semantics(button: true, selected: isSelected, label: getName(item))` trên mỗi tag
4. **Edge cases**:
   - Dropdown mở khi scroll Kudos feed → đóng dropdown (listen scroll notification)
   - Route change → đóng dropdown (dispose)
   - Hashtag chọn nhưng không còn kudos match → carousel hiển thị empty state (đã xử lý trong ViewModel)
   - Danh sách hashtag quá nhiều → Wrap layout tự xuống dòng, `SingleChildScrollView` với max-height 200px
5. **FilterDropdownButton display**: Spec US-2 yêu cầu khi đã chọn hashtag, button hiển thị tên hashtag thay placeholder — `selectedValue` param của `FilterDropdownButton` đã hỗ trợ, verify hoạt động đúng.

### Phase 5: Testing & Verification

1. **Widget tests** — `FilterTagPill`:
   - Render đúng style selected/unselected
   - Tap → trigger callback
   - Accessibility labels đúng

2. **Widget tests** — `FilterDropdownOverlay`:
   - Render danh sách tags + "Tất cả"
   - "Tất cả" selected khi `selectedItem == null`
   - Chọn tag → callback với item
   - Chọn "Tất cả" → callback với `null`
   - Chọn lại tag đang active → callback với `null` (toggle behavior)
   - Empty state khi `items.isEmpty`
   - Loading state khi `isLoading == true`
   - Max-height scroll khi nhiều items

3. **Widget tests** — `HighlightSectionWidget`:
   - Tap hashtag button → mở hashtag dropdown
   - Tap department button khi hashtag dropdown đang mở → đóng hashtag, mở department (mutual exclusion)
   - Tap hashtag button khi department dropdown đang mở → đóng department, mở hashtag (mutual exclusion ngược)
   - Tap ngoài → đóng dropdown
   - Chọn filter → dropdown đóng, callback triggered
   - Chọn "Tất cả" → clear filter
   - Dispose → overlay được remove

4. **Integration tests**:
   - Filter hashtag → carousel chỉ hiển thị kudos matching
   - Filter department → carousel reload
   - Filter cả hai (AND logic) → carousel hiển thị intersection
   - Clear filter → hiển thị tất cả
   - Filter không có kết quả → carousel empty state

---

## Mapping User Stories → Phases

### Dropdown Hashtag (V5GRjAdJyb)

| User Story | Mô tả | Phase triển khai |
|-----------|-------|-----------------|
| US-1: Xem danh sách Hashtag (P1) | Hiển thị tag pills + "Tất cả" | Phase 1 (TagPill) + Phase 2 (Overlay) + Phase 3 (Integration) |
| US-2: Chọn Hashtag để lọc (P1) | Single-select, đóng dropdown, áp dụng filter, toggle behavior | Phase 3 (Filter callback + toggle logic) |
| US-3: Đóng Dropdown (P2) | Tap ngoài → đóng | Phase 3 (GestureDetector full-screen) |
| US-4: Loại trừ lẫn nhau (P2) | Mở 1 → đóng cái kia | Phase 3 (_ActiveDropdown enum) |

### Dropdown Phòng ban (76k69LQPfj)

| User Story | Mô tả | Phase triển khai |
|-----------|-------|-----------------|
| US-1: Xem danh sách Phòng ban (P1) | Reuse `FilterDropdownOverlay<Department>` | Phase 2 + Phase 3 |
| US-2: Chọn Phòng ban để lọc (P1) | Reuse cùng logic, `getName: (d) => d.name` | Phase 3 |
| US-3: Đóng Dropdown (P2) | Cùng mechanism với Hashtag | Phase 3 |
| US-4: Loại trừ lẫn nhau (P2) | Cùng `_ActiveDropdown` enum | Phase 3 |

### Edge Cases → Phase mapping

| Edge Case | Phase xử lý |
|-----------|-------------|
| Không có hashtag/phòng ban | Phase 2 (emptyText param) |
| Mất kết nối khi load | Phase 2 (loading/error state trong overlay) |
| Đang tải danh sách | Phase 2 (isLoading param + spinner) |
| Hashtag chọn nhưng không match kudos | Phase 3 (ViewModel đã xử lý — carousel empty state) |
| Danh sách quá nhiều | Phase 2 (SingleChildScrollView + maxHeight 200px) |
| Dropdown mở khi scroll feed | Phase 4 (scroll notification → close) |

---

## Đánh giá rủi ro

| Rủi ro | Xác suất | Ảnh hưởng | Giảm thiểu |
|--------|----------|-----------|-----------|
| OverlayEntry positioning phức tạp | Trung bình | Trung bình | Dùng `CompositedTransformFollower` — Flutter built-in, proven pattern. Fallback: dùng `showMenu` hoặc `PopupMenuButton` nếu overlay quá phức tạp |
| HighlightSectionWidget refactor lớn (StatelessWidget → StatefulWidget) | Trung bình | Trung bình | Tách overlay logic thành mixin hoặc helper class. Test kỹ trước/sau refactor. Justification cho StatefulWidget: overlay lifecycle management |
| HighlightSectionWidget nằm trong SliverToBoxAdapter — overlay position có thể bị ảnh hưởng bởi scroll offset | Trung bình | Trung bình | `CompositedTransformFollower` tự động theo dõi target position. Test trên device thật với scroll ở nhiều vị trí |
| BackdropFilter(blur) performance | Thấp | Thấp | Optional — có thể dùng solid color `rgba(0,16,26,0.95)` thay cho blur. Test trên device thật |
| Dropdown overflow khi ở cuối màn hình | Thấp | Thấp | `CompositedTransformFollower` cho phép adjust follower anchor. Max-height 200px + scroll đảm bảo không vượt quá viewport |
| Mutual exclusion state bug | Thấp | Thấp | Enum `_ActiveDropdown` đơn giản, dễ reason. Unit test cho toggle logic |
| Overlay không tự đóng khi widget bị dispose (navigate away) | Thấp | Trung bình | `dispose()` method gọi `_closeDropdown()`. Test verify overlay removed on dispose |

### Độ phức tạp ước tính

- **Frontend**: **Trung bình** (2 widget mới + 1 refactor lớn + overlay positioning)
- **Backend**: **Thấp** (không cần sửa — reuse hoàn toàn)
- **Testing**: **Trung bình** (widget tests cho 3 components + overlay interaction tests)

---

## Chiến lược kiểm thử tích hợp

### Phạm vi kiểm thử

- [x] **Component isolation**: FilterTagPill states, FilterDropdownOverlay render
- [x] **Mutual exclusion**: Chỉ 1 dropdown mở tại 1 thời điểm
- [x] **Filter logic**: Chọn filter → ViewModel state update → carousel reload
- [x] **AND logic**: Hashtag + Department filter kết hợp
- [x] **Toggle behavior**: Chọn lại item đang active → clear filter

### Phân loại kiểm thử

| Loại | Áp dụng? | Kịch bản chính |
|------|----------|----------------|
| Widget test | Có | Tag pill states, dropdown render, empty state, loading state, selection |
| Interaction test | Có | Mutual exclusion, tap outside close, scroll close, toggle deselect |
| UI ↔ Logic | Có | Filter select → ViewModel → carousel reload |
| Accessibility | Có | VoiceOver labels cho dropdown + tags |

### Chiến lược Mock

| Loại dependency | Chiến lược | Lý do |
|-----------------|-----------|-------|
| KudosViewModel | Mock callbacks | Widget test không cần real ViewModel |
| Hashtag/Department data | Mock lists | Kiểm soát test data |
| OverlayEntry | Flutter test framework | Widget test overlay behavior |

### Mục tiêu Coverage

| Khu vực | Mục tiêu | Ưu tiên |
|---------|---------|---------|
| FilterTagPill | 95%+ | Cao |
| FilterDropdownOverlay | 90%+ | Cao |
| HighlightSectionWidget (overlay logic) | 80%+ | Cao |
| Mutual exclusion logic | 100% | Cao |
| Toggle deselect behavior | 100% | Cao |

---

## Phụ thuộc & Điều kiện tiên quyết

### Yêu cầu trước khi bắt đầu

- [x] `constitution.md` đã review
- [x] `spec.md` Hashtag dropdown đã review
- [x] `spec.md` Phòng ban dropdown đã review
- [x] `design-style.md` cả hai đã review
- [x] `FilterDropdownButton` widget đã có
- [x] `HighlightSectionWidget` đã có (cần refactor)
- [x] `KudosViewModel` filter methods đã có (`setHashtagFilter`, `setDepartmentFilter`, `clearFilters`)
- [x] `KudosState` filter fields đã có (`availableHashtags`, `availableDepartments`, `selectedHashtag`, `selectedDepartment`)
- [x] API endpoints hashtags/departments đã có
- [x] Seed data đủ cho testing (10 hashtags, 6 departments, 48 kudos)

### Phụ thuộc bên ngoài

- Không có — toàn bộ refactor UI layer, backend giữ nguyên.

---

## Tham chiếu chéo

- **Dropdown Phòng ban** (`76k69LQPfj`): Cùng plan này — dùng chung `FilterDropdownOverlay<Department>` với `getName: (d) => d.name`. Không cần plan riêng vì design tokens giống hệt, chỉ khác dữ liệu.
- **Kudos Feed** (`fO0Kt19sZZ`): Filter dropdown nằm trong `HighlightSectionWidget` trên Kudos Feed — ảnh hưởng trực tiếp.
- **All Kudos** (`j_a2GQWKDJ`): Không có filter trên All Kudos page — ngoài phạm vi.

---

## Ghi chú

- Đây là **refactor UI** — behavior filter không thay đổi (cùng ViewModel methods), chỉ thay đổi cách hiển thị dropdown.
- `_FilterOptionsList` (bottom sheet với ListTile) sẽ bị xóa — thay bằng `FilterDropdownOverlay` (overlay với tag pills).
- `FilterDropdownButton` giữ nguyên — chỉ wrap thêm `CompositedTransformTarget`.
- Dropdown Hashtag và Dropdown Phòng ban NÊN implement cùng lúc vì dùng chung widget.
- Tất cả text PHẢI hỗ trợ đa ngôn ngữ (VN/EN) qua i18n slang.
- **Không cần thêm seed data** — 10 hashtags + 6 departments + 48 kudos đã đủ cho testing.
