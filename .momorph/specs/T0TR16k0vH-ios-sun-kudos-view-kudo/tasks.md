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
- [ ] T002 [P] Download `anonymous_avatar.png` từ Figma vào `assets/images/`. Avatar mặc định cho sender ẩn danh | `assets/images/anonymous_avatar.png`
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

- [ ] T007 [P] Viết test cho `KudosContentCard` với `isDetailView = true` — verify: nội dung full text (maxLines = null), nút "Xem chi tiết" ẩn, heart + copy link vẫn hiển thị. Test backward-compatible: `isDetailView = false` giữ hành vi cũ (maxLines: 3, "Xem chi tiết" hiện) | `test/widget/kudos/kudos_content_card_test.dart`
- [ ] T008 [P] Sửa `KudosContentCard` — thêm `bool isDetailView = false`. Khi `true`: bỏ `maxLines: 3` + `TextOverflow.ellipsis`, ẩn nút "Xem chi tiết" trong action bar. Default `false` → backward-compatible | `lib/features/kudos/presentation/widgets/kudos_content_card.dart`

### Test Helpers

- [ ] T009 [P] Cập nhật test helpers — thêm mock factories: `createMockKudosAnonymous()` (isAnonymous = true, sender ẩn), `createMockKudosWithImages()` (có imageUrls), `createMockKudosEmpty()` (nội dung trống, tiêu đề trống, 0 ảnh) | `test/helpers/kudos_test_helpers.dart`

**Checkpoint**: `getKudosById()` tested. `KudosContentCard` `isDetailView` tested. `flutter test` pass.

---

## Phase 2: Widget mới cho Detail Screen (US1, US3)

**Mục đích**: Tạo 2 widget con mới: SenderReceiverWidget + AttachedImagesWidget

**Phụ thuộc**: Phase 0 (assets), Phase 1 (test helpers)

### KudoDetailSenderReceiverWidget (US1)

- [ ] T010 Viết test cho `KudoDetailSenderReceiverWidget` — 5 kịch bản: (1) variant thường hiển thị sender + receiver đầy đủ (avatar, tên, phòng ban, hero tier badge), (2) variant ẩn danh (isAnonymous=true) → sender avatar = anonymous_avatar, tên fallback `t.kudos.anonymousSender`, ẩn badge, tap disabled, (3) avatar border dày hơn khi ẩn danh (1.869px vs 0.865px), (4) receiver luôn hiển thị đầy đủ bất kể isAnonymous, (5) onAvatarTap callback được gọi khi tap sender/receiver (variant thường) | `test/widget/kudos/kudo_detail_sender_receiver_widget_test.dart`
- [ ] T011 [US1] Tạo `KudoDetailSenderReceiverWidget` (StatelessWidget) — nhận `Kudos kudos` + `void Function(String userId)? onAvatarTap`. Layout: Row sender (trái) → icon mũi tên 16x16 (`Assets.icons.icSent`) → receiver (phải). Avatar 24x24 circle, border trắng. Hiển thị: tên, phòng ban (#999999), hero tier badge. Variant ẩn danh: sender avatar → `Assets.images.anonymousAvatar`, tên → `t.kudos.anonymousSender`, ẩn badge, onTap = null, border 1.869px. Semantics labels theo spec | `lib/features/kudos/presentation/widgets/kudo_detail_sender_receiver_widget.dart`

### KudoAttachedImagesWidget (US3)

- [ ] T012 [P] Viết test cho `KudoAttachedImagesWidget` — 4 kịch bản: (1) imageUrls rỗng → SizedBox.shrink(), (2) 3 ảnh → hiển thị 3 thumbnails 32x32, (3) >5 ảnh → giới hạn tối đa 5, (4) accessibility labels đúng "Ảnh đính kèm {index} trên {total}" | `test/widget/kudos/kudo_attached_images_widget_test.dart`
- [ ] T013 [P] [US3] Tạo `KudoAttachedImagesWidget` (StatelessWidget) — nhận `List<String> imageUrls`. Row thumbnails 32x32px, gap 4px, border 0.447px solid #998C5F, radius 8.043px, bg #FFF, image fit cover. Tối đa 5 ảnh. Rỗng → `SizedBox.shrink()`. Tap thumbnail → `showDialog` với `InteractiveViewer`. Semantics: `t.kudos.attachedImageAccessibility(index, total)` | `lib/features/kudos/presentation/widgets/kudo_attached_images_widget.dart`

**Checkpoint**: 2 widget mới tested. `flutter test test/widget/kudos/kudo_detail_*` pass.

---

## Phase 3: KudoDetailScreen + Navigation (US1, US2, US4)

**Mục đích**: Xây dựng screen chính + wire navigation từ feed + route

**Phụ thuộc**: Phase 1 (ViewModel + ContentCard), Phase 2 (widget con)

### Route

- [x] T014 Thêm route `/kudos/:kudosId` → `KudoDetailScreen` vào router. Path parameter `kudosId` truyền vào constructor | `lib/app/router.dart`

### KudoDetailScreen (US1, US2)

- [ ] T015 Viết test cho `KudoDetailScreen` — 6 kịch bản: (1) loading state → shimmer placeholder, (2) loaded state → hiển thị đầy đủ: SenderReceiverWidget, divider, time "HH:mm - MM/DD/YYYY", awardTitle bold center, nội dung full text trong khung (bg rgba(255,234,158,0.40), border #FFEA9E, radius 5.554px), AttachedImagesWidget, hashtags #D4271D, HeartButton + Copy Link, (3) error state → thông báo lỗi + nút retry, (4) 404 state → `t.kudos.kudosNotFound` + nút quay lại, (5) variant ẩn danh → sender info ẩn (verify SenderReceiverWidget nhận isAnonymous=true), (6) nút back → pop navigation | `test/widget/kudos/kudo_detail_screen_test.dart`
- [ ] T016 [US1] Tạo `KudoDetailScreen` (ConsumerStatefulWidget) — nhận `kudosId` qua constructor. initState gọi `getKudosById(kudosId)`. Layout: Scaffold(bg: #00101A) + AppBar(leading: back icon `Assets.icons.icBack`, title: `t.kudos.detailTitle` "Kudo", bg transparent + gradient overlay). Body: SingleChildScrollView → Center → Card 335px (bg: #FFF8E1, border 1px #FFEA9E, radius 8px, padding 8px 12px): KudoDetailSenderReceiverWidget + Divider(#FFEA9E) + time text (#999999, Montserrat 10px/500) + awardTitle (Montserrat 10px/700, center, ẩn nếu null/empty) + nội dung frame (bg rgba(255,234,158,0.40), border 0.463px #FFEA9E, radius 5.554px, padding 4px) + KudoAttachedImagesWidget + hashtags (#D4271D) + Divider + action bar (HeartButton + Copy Link, KHÔNG có "Xem chi tiết"). States: loading (shimmer 335x400), error (message + retry), 404 (kudosNotFound + goBack), loaded | `lib/features/kudos/presentation/screens/kudo_detail_screen.dart`

### Edge Cases (US1)

- [ ] T017 Viết test cho edge cases trong `KudoDetailScreen` — 5 kịch bản: (1) nội dung trống → placeholder `t.kudos.noContent`, (2) tiêu đề trống → ẩn widget tiêu đề, (3) 0 hình ảnh → ẩn AttachedImagesWidget, (4) shareUrl rỗng → copy link disabled, (5) isAnonymous=false + sender.name rỗng → fallback `t.kudos.deletedUser` | `test/widget/kudos/kudo_detail_screen_test.dart`

### Wire Navigation từ Feed (US4)

- [ ] T018 [P] Sửa `KudosCard` — wire `onViewDetail` callback khi bấm "Xem chi tiết" → `context.push('/kudos/${kudos.id}')`. Đảm bảo callback truyền từ `KudosScreen`, `AllKudosSectionWidget`, `HighlightCarouselWidget` | `lib/features/kudos/presentation/widgets/kudos_card.dart`, `lib/features/kudos/presentation/widgets/all_kudos_section_widget.dart`, `lib/features/kudos/presentation/widgets/highlight_carousel_widget.dart`
- [ ] T019 [P] Sửa `KudosScreen` — truyền `onViewDetail: (kudosId) => context.push('/kudos/$kudosId')` cho tất cả `KudosCard` instances trong highlight carousel + all kudos feed | `lib/features/kudos/presentation/screens/kudos_screen.dart`

**Checkpoint**: Detail screen hoạt động. Navigate từ feed → detail → back. Heart toggle đồng bộ. `flutter test` pass.

---

## Phase 4: Polish & Accessibility (Cross-story)

**Mục đích**: Accessibility, animations, performance, edge cases

**Phụ thuộc**: Phase 3 hoàn thành

### Accessibility

- [ ] T020 [P] Thêm `Semantics` widgets cho tất cả elements trong `KudoDetailScreen` + widget con theo bảng VoiceOver: nút Back ("Quay lại"), avatar sender/receiver ("Ảnh đại diện {tên}"), avatar ẩn danh ("Người gửi ẩn danh" — trait Image, không Button), tiêu đề (Header trait), nội dung (StaticText), heart ("{count} lượt thích. {Đã thích / Chưa thích}" toggle trait), copy link ("Sao chép liên kết" Button), hình ảnh ("Ảnh đính kèm {index} trên {total}") | `lib/features/kudos/presentation/screens/kudo_detail_screen.dart`, `lib/features/kudos/presentation/widgets/kudo_detail_sender_receiver_widget.dart`, `lib/features/kudos/presentation/widgets/kudo_attached_images_widget.dart`

### Heart State Sync

- [ ] T021 [P] Viết test verify heart state sync giữa detail và feed — toggle heart trên detail screen → `KudosViewModel` state thay đổi → pop back → feed hiển thị heart count mới. Dùng chung `kudosViewModelProvider` | `test/widget/kudos/kudo_detail_screen_test.dart`

### Final Checks

- [ ] T022 Chạy `flutter analyze` + `dart format` — đảm bảo 0 warnings, 0 lint errors | Toàn bộ project
- [ ] T023 Chạy toàn bộ test suite: `flutter test` — đảm bảo tất cả tests pass, coverage ≥ 80% cho `getKudosById()` + `KudoDetailScreen` + widget con | `test/`

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
