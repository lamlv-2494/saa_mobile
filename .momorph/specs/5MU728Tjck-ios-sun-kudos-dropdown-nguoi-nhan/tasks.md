# Tasks: [iOS] Sun*Kudos — Dropdown Tên Người Nhận

> **⚠️ OBSOLETE**: Spec này đã bị thay thế. Người nhận giờ dùng `PopupMenuButton` (load tất cả users) thay vì search dropdown.
> Xem Phase 4 trong `PV7jBVZU1N` tasks.md cho implementation mới.
> Code đã implement (`RecipientDropdownWidget`, `RecipientShimmerWidget`) vẫn giữ lại nhưng không còn dùng cho flow chính.

**Frame**: `5MU728Tjck-ios-sun-kudos-dropdown-nguoi-nhan`
**Prerequisites**: plan.md, spec.md, design-style.md
**Parent screen**: `PV7jBVZU1N` — Gửi lời chúc Kudos

---

## Định dạng Task

```
- [ ] T### [P?] [Story?] Mô tả | đường/dẫn/file
```

- **[P]**: Có thể chạy song song
- **[Story]**: User story liên quan (US1–US2)
- **|**: File bị ảnh hưởng bởi task

---

## Phase 1: Setup (Model, i18n)

**Mục đích**: Cập nhật state model cho search error, thêm i18n keys

- [x] T001 [P] Thêm field `searchError` (String?, nullable, default null) vào `SendKudosState` để lưu lỗi search | `lib/features/kudos/data/models/send_kudos_state.dart`
- [x] T002 [P] Thêm i18n keys cho VN/EN: `sendKudos.searchError` ("Đã xảy ra lỗi. Vui lòng thử lại." / "An error occurred. Please try again."), `sendKudos.searchNetworkError` ("Không thể tìm kiếm. Kiểm tra kết nối mạng." / "Cannot search. Check your network connection."), `sendKudos.retryButton` ("Thử lại" / "Retry") | `lib/i18n/strings_vi.i18n.json`, `lib/i18n/strings_en.i18n.json`
- [x] T003 Chạy `dart run build_runner build` + `dart run slang` để generate freezed + i18n | `lib/features/kudos/data/models/`, `lib/i18n/strings.g.dart`

**Checkpoint**: Model có `searchError`, i18n strings sẵn sàng.

---

## Phase 2: Foundation (ViewModel Error Handling — TDD)

**Mục đích**: Error handling cho search recipients

**QUAN TRỌNG**: TDD bắt buộc — viết test TRƯỚC

- [x] T004 Viết test cho `searchRecipients()` error case: API throw → set `searchError` với message, `isSearching = false`. Test clear error khi search lại thành công | `test/unit/viewmodels/send_kudos_viewmodel_test.dart`
- [x] T005 Sửa `searchRecipients()` trong ViewModel: catch error → `_update((s) => s.copyWith(searchError: error.toString(), isSearching: false))`. Search thành công → `searchError = null` | `lib/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart`
- [x] T006 Chạy `flutter test test/unit/viewmodels/send_kudos_viewmodel_test.dart` — verify tests pass | `test/unit/`

**Checkpoint**: Search error handling hoàn chỉnh trong ViewModel. Tests pass.

---

## Phase 3: US1 — Tìm kiếm và chọn người nhận

**Mục tiêu**: Cải thiện dropdown: shimmer loading, clear button, error/retry, dividers, debounce 300ms

**Kiểm thử độc lập**: Bấm "Người nhận" → sheet mở → gõ tên → shimmer → kết quả → chọn → đóng + hiện tên

### RecipientSearchItem Improvements

- [ ] T007 Viết test cho `RecipientSearchItem`: hiển thị avatar thật khi URL valid, hiển thị initials fallback khi avatar rỗng/null. Text name `14px/600`, department `12px/400/#999` | `test/widget/kudos/recipient_search_item_test.dart`
- [x] T008 [US1] Sửa `RecipientSearchItem` — Avatar fallback: khi `user.avatar` rỗng → `CircleAvatar(radius: 18, backgroundColor: Color(0x33FFEA9E), child: Text(initials, style: montserrat(14px/600, #FFEA9E)))`. Sửa text: name `fontWeight: w600`, department `12px/400/#999`. Thêm press highlight: `InkWell` với `splashColor: Color(0x14FFEA9E)` | `lib/features/kudos/presentation/widgets/recipient_search_item.dart`

### Shimmer Loading Widget

- [x] T009 [P] [US1] Tạo `RecipientShimmerWidget` (StatelessWidget) — 3 shimmer items giả lập: mỗi item gồm circle (36px) + 2 lines (tên + department). Dùng `Container` + `LinearGradient` animation (shimmer effect). Height mỗi item: 56px, gap: divider 1px | `lib/features/kudos/presentation/widgets/recipient_shimmer_widget.dart`

### Dropdown Sheet Improvements

- [ ] T010 Viết test cho `RecipientDropdownWidget`: debounce 300ms, clear button hiển thị khi có text, tap clear → xóa text + ẩn results, error state hiển thị message + retry button, shimmer khi loading | `test/widget/kudos/recipient_dropdown_widget_test.dart`
- [x] T011 [US1] Sửa debounce từ 400ms → 300ms trong `_RecipientDropdownSheet._onChanged()` | `lib/features/kudos/presentation/widgets/recipient_dropdown_widget.dart`
- [x] T012 [US1] Thêm clear (X) button vào search input: `suffixIcon` hiển thị `IconButton(icon: Assets.icons.icClose.svg(width: 16, color: #999))` khi `_ctrl.text.isNotEmpty`. Tap → clear text + reset search results | `lib/features/kudos/presentation/widgets/recipient_dropdown_widget.dart`
- [x] T013 [US1] Thêm minimum 2 ký tự check: khi `query.length < 2` → không gọi API, hiển thị hint `t.sendKudos.recipientMinChars` | `lib/features/kudos/presentation/widgets/recipient_dropdown_widget.dart`
- [x] T014 [US1] Thay loading indicator (CircularProgressIndicator) bằng `RecipientShimmerWidget` khi `isSearching == true` | `lib/features/kudos/presentation/widgets/recipient_dropdown_widget.dart`
- [x] T015 [US1] Thêm error state: khi `searchError != null` → hiển thị error text + retry button. Retry: gọi lại `searchRecipients(lastQuery)` | `lib/features/kudos/presentation/widgets/recipient_dropdown_widget.dart`
- [x] T016 [US1] Thêm dividers giữa items trong ListView: `Divider(color: Color(0xFF2E3940), height: 1, indent: 12, endIndent: 12)` bằng `ListView.separated` | `lib/features/kudos/presentation/widgets/recipient_dropdown_widget.dart`

**Checkpoint**: Dropdown hoạt động: shimmer loading, clear button, error/retry, dividers, debounce 300ms.

---

## Phase 4: US2 — Xem thông tin người nhận

**Mục tiêu**: Mỗi item hiển thị đủ avatar + tên (bold) + đơn vị

**Kiểm thử độc lập**: Search → results hiển thị avatar + tên w600 + department → phân biệt người cùng tên

- [ ] T017 [US2] Verify layout `RecipientSearchItem`: Row(avatar 36x36, SizedBox(12), Column(name 14px/600 white, SizedBox(2), department 12px/400 #999)). Item height 56px, padding horizontal 12px | `lib/features/kudos/presentation/widgets/recipient_search_item.dart`
- [ ] T018 [US2] Verify avatar fallback khi NetworkImage error: dùng `onBackgroundImageError` callback hoặc check URL trống trước khi render NetworkImage | `lib/features/kudos/presentation/widgets/recipient_search_item.dart`

**Checkpoint**: Mỗi item hiển thị đầy đủ, dễ phân biệt người cùng tên khác đơn vị.

---

## Phase Final: Polish & Verify

- [ ] T019 [P] Verify debounce chính xác 300ms — không trigger sớm hơn | `lib/features/kudos/presentation/widgets/recipient_dropdown_widget.dart`
- [ ] T020 [P] Verify bấm overlay (vùng tối) → đóng sheet, giữ selection cũ | `lib/features/kudos/presentation/widgets/recipient_dropdown_widget.dart`
- [ ] T021 [P] Verify mở dropdown khi đã có recipient → input hiển thị tên đã chọn | `lib/features/kudos/presentation/widgets/recipient_dropdown_widget.dart`
- [ ] T022 Chạy `flutter analyze` — 0 errors/warnings | Toàn bộ project
- [ ] T023 Chạy `flutter test` — tất cả tests pass | `test/`
- [ ] T024 Verify trên simulator: mở dropdown → gõ tên → shimmer → results với avatar + dividers → chọn → đóng + hiện tên. Test: avatar null → initials. Test: API error → retry. Test: clear button | Device testing

**Checkpoint**: Dropdown hoàn chỉnh theo spec `5MU728Tjck`.

---

## Phụ thuộc & Thứ tự thực thi

### Phụ thuộc giữa Phases

```
Phase 1 (Setup) ──────────────────────────┐
    │                                      │
    v                                      │
Phase 2 (Foundation — Error Handling)      │
    │                                      │
    v                                      │
Phase 3 (US1: Dropdown Improvements)       │
    │                                      │
    ├──> Phase 4 (US2: Item Display)       │
    │    (song song với cuối Phase 3)      │
    │                                      │
    v                                      │
Phase Final (Polish) ──────────────────────┘
```

### Song song trong mỗi Phase

- **Phase 1**: T001, T002 song song. T003 cuối
- **Phase 2**: T004 trước T005. T006 cuối
- **Phase 3**: T007 trước T008. T009 song song với T007–T008 (file khác). T010 trước T011–T016. T011–T016 tuần tự (cùng file)
- **Phase 4**: T017, T018 song song
- **Phase Final**: T019–T021 song song. T022, T023 song song. T024 cuối

---

## Chiến lược triển khai

### MVP First (Khuyến nghị)

1. Phase 1 + 2 (Setup + Error Handling)
2. Phase 3 (Dropdown Improvements) — **TEST**: search → shimmer → results → chọn → đóng
3. Phase 4 (Item Display) — verify styling
4. Phase Final (Polish)

**Ước lượng**: ~1.5 ngày

---

## Ghi chú

- Giữ bottom sheet approach — nhất quán với HashtagDropdownWidget
- Debounce PHẢI đúng 300ms (hiện tại 400ms — T011 sửa)
- KHÔNG chặn self-send ở dropdown — chặn ở validate khi submit
- TDD bắt buộc: Test → FAIL → Implement → PASS → Refactor
- Commit sau mỗi phase hoặc nhóm logic
- Search query là local state, KHÔNG lưu vào ViewModel
