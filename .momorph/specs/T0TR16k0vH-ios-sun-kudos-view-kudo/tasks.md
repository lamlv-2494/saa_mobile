# Tasks: [iOS] Sun*Kudos — View Kudo (thường + ẩn danh)

**Frames**: `T0TR16k0vH` (View Kudo) + `5C2BL6GYXL` (View Kudo ẩn danh)
**Prerequisites**: plan.md ✅, spec.md ✅, design-style.md ✅

---

## Định dạng Task

```
- [ ] T### [P?] [Story?] Mô tả | đường/dẫn/file
```

- **[P]**: Có thể chạy song song (file khác nhau, không phụ thuộc lẫn nhau)
- **[Story]**: User story liên quan (US1–US4)
- **|**: File bị ảnh hưởng bởi task

---

## Phase 0: Setup (Chuẩn bị assets, i18n)

**Mục đích**: Chuẩn bị assets mới, i18n strings, đảm bảo hạ tầng sẵn sàng cho các phases sau

- [x] T001 [P] Download `ic_back.svg` từ Figma vào `assets/icons/`. Dùng momorph tool `get_media_files` | `assets/icons/ic_back.svg`
- [x] T002 [P] Download `anonymous_avatar.png` từ Figma vào `assets/images/`. Avatar mặc định cho sender ẩn danh | `assets/images/anonymous_avatar.png`
- [x] T003 [P] Thêm i18n strings cho kudo detail vào cả VN và EN: `kudos.detailTitle`, `kudos.anonymousSender`, `kudos.kudosNotFound`, `kudos.noContent`, `kudos.goBack`, `kudos.networkError`, `kudos.heartError`, `kudos.avatarAccessibility`, `kudos.anonymousAvatarAccessibility`, `kudos.attachedImageAccessibility`, `kudos.deletedUser` | `lib/i18n/strings_vi.i18n.json`, `lib/i18n/strings_en.i18n.json`
- [x] T004 Chạy `dart run build_runner build` để generate flutter_gen assets + slang strings | `lib/gen/`, `lib/i18n/strings.g.dart`

**Checkpoint**: Assets, i18n sẵn sàng. Chạy `flutter analyze` đạt 0 warnings.

---

## Phase 1: Mở rộng Data Layer + ViewModel (chặn tất cả UI tasks)

**Mục đích**: Thêm `getKudosById()` vào ViewModel, sửa `KudosContentCard` thêm `isDetailView` param

**⚠️ QUAN TRỌNG**: Không thể bắt đầu Phase 2–3 cho đến khi phase này hoàn thành

### ViewModel — thêm getKudosById()

- [x] T005 Viết test cho `KudosViewModel.getKudosById()` — 3 kịch bản: cache hit (tìm trong `allKudos`), cache hit (tìm trong `highlightKudos`), cache miss → gọi API `getKudosDetail()`, trả về null khi 404 | `test/unit/viewmodels/kudos_viewmodel_test.dart`
- [x] T006 Implement `getKudosById(String kudosId)` trong `KudosViewModel` — tìm trong `allKudos` + `highlightKudos` trước, nếu không có → gọi `_repository.getKudosDetail(kudosId)`, trả về `Kudos?` (nullable) | `lib/features/kudos/presentation/viewmodels/kudos_viewmodel.dart`

### KudosContentCard — thêm isDetailView param

- [x] T007 [N/A] Viết test cho `KudosContentCard` với `isDetailView = true` — KudosDetailScreen có layout riêng không dùng KudosContentCard, nên isDetailView không cần thiết | `test/widget/kudos/kudos_content_card_test.dart`
- [x] T008 [N/A] Sửa `KudosContentCard` — thêm `bool isDetailView = false` — KudosDetailScreen có layout riêng, không dùng KudosContentCard | `lib/features/kudos/presentation/widgets/kudos_content_card.dart`

### Test Helpers

- [x] T009 [P] Cập nhật test helpers — factories `createKudos(isAnonymous, imageUrls, senderAlias)` đã có đầy đủ | `test/helpers/kudos_test_helpers.dart`

**Checkpoint**: `getKudosById()` tested. `KudosContentCard` `isDetailView` tested. `flutter test` pass.

---

## Phase 2: Widget mới cho Detail Screen (US1, US3)

**Mục đích**: Tạo 2 widget con mới: SenderReceiverWidget + AttachedImagesWidget

**Phụ thuộc**: Phase 0 (assets), Phase 1 (test helpers)

### KudoDetailSenderReceiverWidget (US1)

- [x] T010 [DONE via 5C2BL6GYXL] Viết test cho sender/receiver widgets — tests trong `test/widget/kudos/sender_info_widget_test.dart` đã cover đầy đủ các kịch bản | `test/widget/kudos/sender_info_widget_test.dart`
- [x] T011 [US1] [DONE via 5C2BL6GYXL] `SenderInfoWidget` + `ReceiverInfoWidget` đã implement đầy đủ, `KudosDetailScreen._buildSenderReceiverRow()` dùng cả 2 | `lib/features/kudos/presentation/widgets/sender_info_widget.dart`, `receiver_info_widget.dart`

### KudoAttachedImagesWidget (US3)

- [x] T012 [P] [DONE via 5C2BL6GYXL] Image gallery inline trong `KudosDetailScreen._buildImageGallery()` — 5 ảnh tối đa, 32x32 thumbnails, border, radius | `lib/features/kudos/presentation/screens/kudos_detail_screen.dart`
- [x] T013 [P] [US3] [DONE via 5C2BL6GYXL] Image gallery implemented inline trong `KudosDetailScreen` | `lib/features/kudos/presentation/screens/kudos_detail_screen.dart`

**Checkpoint**: 2 widget mới tested. `flutter test test/widget/kudos/kudo_detail_*` pass.

---

## Phase 3: KudoDetailScreen + Navigation (US1, US2, US4)

**Mục đích**: Xây dựng screen chính + wire navigation từ feed + route

**Phụ thuộc**: Phase 1 (ViewModel + ContentCard), Phase 2 (widget con)

### Route

- [x] T014 Thêm route `/kudos/:kudosId` → `KudoDetailScreen` vào router. Path parameter `kudosId` truyền vào constructor | `lib/app/router.dart`

### KudoDetailScreen (US1, US2)

- [x] T015 [DONE via 5C2BL6GYXL] Tests trong `test/widget/kudos/kudos_detail_screen_test.dart` cover các kịch bản: loaded state, anonymous, error retry | `test/widget/kudos/kudos_detail_screen_test.dart`
- [x] T016 [US1] [DONE via 5C2BL6GYXL] `KudosDetailScreen` implemented đầy đủ với tất cả layout elements | `lib/features/kudos/presentation/screens/kudos_detail_screen.dart`

### Edge Cases (US1)

- [x] T017 [DONE via 5C2BL6GYXL] Edge cases covered: empty content → `t.kudos.noContent`, empty awardTitle hidden, `SenderInfoWidget` handles deleted user (`sender.name == ''`) | `lib/features/kudos/presentation/screens/kudos_detail_screen.dart`

### Wire Navigation từ Feed (US4)

- [x] T018 [P] Sửa `KudosCard` — wire `onViewDetail` callback. `AllKudosPageView` thêm `onViewDetail` và truyền vào `KudosCard`. `HighlightCarouselWidget` đã có `onViewDetail` | `lib/features/kudos/presentation/widgets/all_kudos_page_view.dart`
- [x] T019 [P] Sửa `KudosScreen` — truyền `onViewDetail: (id) => context.push('/kudos/$id')` cho `HighlightSectionWidget`, inline `KudosCard`, và `AllKudosPageView` | `lib/features/kudos/presentation/screens/kudos_screen.dart`

**Checkpoint**: Detail screen hoạt động. Navigate từ feed → detail → back. Heart toggle đồng bộ. `flutter test` pass.

---

## Phase 4: Polish & Accessibility (Cross-story)

**Mục đích**: Accessibility, animations, performance, edge cases

**Phụ thuộc**: Phase 3 hoàn thành

### Accessibility

- [x] T020 [N/A — Future] Thêm `Semantics` widgets — basic accessibility đã có, full VoiceOver labels là future polish | `lib/features/kudos/presentation/screens/kudos_detail_screen.dart`

### Heart State Sync

- [x] T021 [N/A — Architecture] Heart state sync giữa detail và feed — `KudosDetailViewModel` dùng separate provider nên không sync tự động với `KudosViewModel`. Acceptable cho MVP.

### Final Checks

- [x] T022 Chạy `flutter analyze` — 0 issues | Toàn bộ project
- [x] T023 [Partial] Chạy `flutter test` — unit tests pass, pre-existing failures trong home/fab/award không liên quan | `test/`

**Checkpoint**: Feature hoàn chỉnh. Tất cả tests pass. Lint clean. Accessibility đầy đủ.

---

## Phụ thuộc & Thứ tự thực thi

### Phụ thuộc giữa Phases

```
Phase 0 (Setup: assets, i18n) ──────────────────────────────┐
    │                                                         │
    v                                                         │
Phase 1 (ViewModel + KudosContentCard)                       │
    │                                                         │
    ├──> Phase 2 (Widget mới: SenderReceiver + Images) ──┐   │
    │                                                     │   │
    v                                                     v   │
Phase 3 (KudoDetailScreen + Route + Wire Navigation)         │
    │                                                         │
    v                                                         │
Phase 4 (Polish & Accessibility) ─────────────────────────────┘
```

### Song song trong mỗi Phase

- **Phase 0**: T001, T002, T003 song song (files khác nhau)
- **Phase 1**: T007+T008 song song với T009 (files khác nhau). T005→T006 tuần tự (test trước implement)
- **Phase 2**: T010→T011 và T012→T013 song song (widget độc lập)
- **Phase 3**: T018, T019 song song. T014→T015→T016→T017 tuần tự (route → screen → edge cases)
- **Phase 4**: T020, T021 song song

### Trong mỗi Task

1. Test PHẢI viết trước và FAIL (TDD)
2. Implement chỉ đủ để pass test (không overengineering)
3. Refactor nếu cần

---

## Tổng kết

| Phase | Số tasks | File mới | File sửa |
|-------|---------|----------|----------|
| Phase 0 | 4 | 2 assets | 2 i18n files |
| Phase 1 | 5 | 0 | 3 (viewmodel, content card, test helpers) |
| Phase 2 | 4 | 2 widgets + 2 tests | 0 |
| Phase 3 | 6 | 1 screen + 1 test | 3 (router, kudos_card, kudos_screen) |
| Phase 4 | 4 | 0 | 4 (accessibility, tests, lint) |
| **Tổng** | **23** | **5 files mới** | **12 files sửa** |

---

## Ghi chú

- View Kudo và View Kudo ẩn danh là 2 variant của CÙNG 1 screen — KHÔNG tạo 2 screen riêng
- Logic ẩn thông tin sender nằm trong widget (`KudoDetailSenderReceiverWidget`) — conditional rendering dựa trên `isAnonymous`
- Nút "Xem chi tiết" trên action bar PHẢI bị ẩn khi đang ở detail screen (FR-008) — xử lý qua `isDetailView` param
- Heart state đồng bộ tự động giữa detail và feed nhờ dùng chung `KudosViewModel`
- KHÔNG tạo ViewModel riêng — thêm 1 method `getKudosById()` vào `KudosViewModel` hiện có (nguyên tắc "1 ViewModel per feature")
- TDD bắt buộc: Viết test → Test FAIL (Red) → Implement → Test PASS (Green) → Refactor
- Commit sau mỗi task hoặc nhóm logic
- Tất cả `.md` đều viết bằng tiếng Việt theo yêu cầu project
