# Tasks: [iOS] Sun*Kudos — View Kudo Ẩn Danh

**Frame**: `5C2BL6GYXL-ios-sun-kudos-view-kudo-an-danh`
**Prerequisites**: plan.md, spec.md, design-style.md
**Parent/gốc**: `T0TR16k0vH` — View Kudo (chi tiết kudos)

---

## Định dạng Task

```
- [ ] T### [P?] [Story?] Mô tả | đường/dẫn/file
```

- **[P]**: Có thể chạy song song
- **[Story]**: User story liên quan (US1–US2)
- **|**: File bị ảnh hưởng bởi task

---

## Phase 1: Setup (Assets, Model, i18n, DB)

**Mục đích**: Chuẩn bị asset ẩn danh, cập nhật model, i18n, migration

- [ ] T001 [P] Tạo anonymous avatar asset hợp lệ (PNG, ≥96x96px, nền tối, icon person outline) → `assets/images/anonymous_avatar.png`. File hiện tại chỉ 1x1 pixel placeholder → gây lỗi `Codec failed to produce an image`. Cần tạo ảnh thật hoặc download từ Figma | `assets/images/`
- [x] T002 [P] Thêm field `senderAlias` (String?, nullable) vào `Kudos` model freezed | `lib/features/kudos/data/models/kudos.dart`
- [x] T003 [P] Thêm i18n keys cho VN/EN: `kudos.anonymousSender` ("Người gửi ẩn danh" / "Anonymous sender"), `kudos.anonymousDepartment` ("Người gửi ẩn danh" / "Anonymous sender"), `kudos.kudosNotFound` ("Kudos không còn tồn tại" / "Kudos no longer exists"), `kudos.userNotFound` ("Người dùng không tồn tại" / "User does not exist") | `lib/i18n/strings_vi.i18n.json`, `lib/i18n/strings_en.i18n.json`
- [x] T004 [P] Tạo migration thêm cột `sender_alias VARCHAR` (nullable) vào bảng `kudos`. Chạy migration bằng `psql` | `supabase/migrations/20260415000300_add_sender_alias.sql`
- [x] T005 Cập nhật `_kudosSelect` trong `KudosRemoteDatasource`: thêm `sender_alias` vào select query. Cập nhật `_mapKudos`: map `sender_alias` → `Kudos.senderAlias` | `lib/features/kudos/data/datasources/kudos_remote_datasource.dart`
- [x] T006 Chạy `dart run build_runner build` + `dart run slang` để generate freezed + i18n + flutter_gen | `lib/gen/`, `lib/i18n/strings.g.dart`

**Checkpoint**: Asset sẵn sàng, model có `senderAlias`, i18n có keys, migration applied, datasource updated.

---

## Phase 2: Foundation (Data Layer — TDD)

**Mục đích**: ViewModel cho Kudos Detail screen

**QUAN TRỌNG**: TDD bắt buộc — viết test TRƯỚC

- [x] T007 Viết test cho `KudosDetailViewModel`: build() load kudos by ID, trả về `Kudos?`. Test case: kudos thường → sender info đầy đủ. Test case: kudos ẩn danh (`isAnonymous=true`) → `senderAlias` có giá trị. Test case: kudos không tồn tại → state = null | `test/unit/viewmodels/kudos_detail_viewmodel_test.dart`
- [x] T008 Tạo `KudosDetailViewModel extends AsyncNotifier<Kudos?>` — `build()` nhận `kudosId` từ family param, gọi `_repository.fetchKudosDetail(kudosId)`, trả về `Kudos?` | `lib/features/kudos/presentation/viewmodels/kudos_detail_viewmodel.dart`
- [x] T009 Viết test cho heart toggle trong `KudosDetailViewModel`: `toggleHeart()` → gọi `likeKudos`/`unlikeKudos`, cập nhật `heartCount` và `isLikedByMe` | `test/unit/viewmodels/kudos_detail_viewmodel_test.dart`
- [x] T010 Implement `toggleHeart()` và `copyShareLink()` trong `KudosDetailViewModel` | `lib/features/kudos/presentation/viewmodels/kudos_detail_viewmodel.dart`

**Checkpoint**: ViewModel load kudos detail, heart toggle, copy link. Tests pass.

---

## Phase 3: US1 — Xem chi tiết Kudos ẩn danh

**Mục tiêu**: Shared detail screen, conditional rendering cho anonymous sender

**Kiểm thử độc lập**: Mở kudos `isAnonymous=true` → sender hiển thị anonymous avatar + alias, badge ẩn, tap disabled. Mở kudos thường → sender hiển thị đầy đủ.

### Sender Info Widget

- [x] T011 Viết test cho `SenderInfoWidget`: khi `isAnonymous=false` → hiển thị avatar thật + tên + department + badge, tap enabled. Khi `isAnonymous=true` → hiển thị anonymous avatar + alias/"Người gửi ẩn danh" + "Người gửi ẩn danh" thay department, badge ẩn, tap disabled | `test/widget/kudos/sender_info_widget_test.dart`
- [x] T012 [US1] Tạo `SenderInfoWidget` (StatelessWidget) — nhận `Kudos` param. Conditional rendering:
  - `isAnonymous=false`: CircleAvatar (24x24, border 0.865px white) + `sender.name` (10px/400, #00101A) + `sender.department` (10px/500, #999) + badge icon nếu có `heroTierUrl` + GestureDetector → navigate profile
  - `isAnonymous=true`: `Assets.images.anonymousAvatar` (24x24, border 1.869px white) + `kudos.senderAlias ?? t.kudos.anonymousSender` (10px/400, center) + "Người gửi ẩn danh" (10px/500, #999) + NO badge + NO GestureDetector | `lib/features/kudos/presentation/widgets/sender_info_widget.dart`

### Receiver Info Widget

- [x] T013 [P] [US1] Tạo `ReceiverInfoWidget` (StatelessWidget) — luôn hiển thị đầy đủ: avatar thật + tên + department + badge. Giống sender thường nhưng cho receiver | `lib/features/kudos/presentation/widgets/receiver_info_widget.dart`

### Detail Screen

- [ ] T014 Viết test cho `KudosDetailScreen`: render sender info, receiver info, content, hashtags, images, actions. Test với kudos thường + ẩn danh | `test/widget/kudos/kudos_detail_screen_test.dart`
- [x] T015 [US1] Tạo `KudosDetailScreen` (ConsumerWidget) — Scaffold dark theme, layout:
  - AppBar: back button + title
  - Sender → Receiver flow (arrow between)
  - Award title (nếu có)
  - Content text
  - Hashtag chips
  - Image gallery (nếu có)
  - Heart count + heart button
  - Copy link button
  - Timestamp | `lib/features/kudos/presentation/screens/kudos_detail_screen.dart`
- [x] T016 [US1] Wire route `/kudos/:kudosId` → `KudosDetailScreen` trong router.dart (thay placeholder hiện tại) | `lib/app/router.dart`

**Checkpoint**: Detail screen hiển thị đúng cho cả kudos thường và ẩn danh. Route hoạt động.

---

## Phase 3.5: Bugfix — KudosCard anonymous trên Feed/Highlight

**Mục tiêu**: KudosCard (dùng ở Kudos feed + All Kudos + Highlight) phải ẩn sender khi `isAnonymous=true`

**Bug phát hiện**: `_SenderReceiverRow._buildCompact()` và `_buildFull()` truyền thẳng `kudos.sender.*` vào `_UserAvatar` mà không check `isAnonymous` → hiện tên/avatar/department/badge thật

- [x] T026 Fix `_SenderReceiverRow._buildCompact()`: thêm check `isAnonymous` → dùng `_AnonymousAvatar` (avatar mặc định, alias, "Người gửi ẩn danh", no badge, no tap) thay vì `_UserAvatar` cho sender | `lib/features/kudos/presentation/widgets/kudos_card.dart`
- [x] T027 Fix `_SenderReceiverRow._buildFull()`: thêm check `isAnonymous` → dùng `_AnonymousAvatar` + alias/fallback cho avatar và tên | `lib/features/kudos/presentation/widgets/kudos_card.dart`
- [x] T028 Tạo `_AnonymousAvatar` widget trong kudos_card.dart: `Assets.images.anonymousAvatar` (border 1.869px), alias name, "Người gửi ẩn danh" department, KHÔNG badge, KHÔNG tap | `lib/features/kudos/presentation/widgets/kudos_card.dart`

**Checkpoint**: KudosCard trên feed/highlight ẩn sender đúng khi `isAnonymous=true`.

---

## Phase 4: US2 — Tương tác với Kudos ẩn danh

**Mục tiêu**: Heart toggle và copy link hoạt động giống kudos thường

**Kiểm thử độc lập**: Mở kudos ẩn danh → bấm heart → count thay đổi → bấm copy link → toast hiện

- [x] T017 [US2] Tạo `KudosActionsWidget` (ConsumerWidget) — Row: heart button (toggle, count hiển thị) + copy link button. Wire: `KudosDetailViewModel.toggleHeart()`, clipboard + toast 2s | `lib/features/kudos/presentation/widgets/kudos_actions_widget.dart`
- [x] T018 [US2] Tích hợp `KudosActionsWidget` vào `KudosDetailScreen` | `lib/features/kudos/presentation/screens/kudos_detail_screen.dart`

**Checkpoint**: Heart toggle + copy link hoạt động cho cả kudos thường và ẩn danh.

---

## Phase Final: Polish & Verify

- [x] T019 [P] Verify anonymous avatar border dày 1.869px (thay vì 0.865px cho thường) theo design-style.md | `lib/features/kudos/presentation/widgets/sender_info_widget.dart`
- [x] T020 [P] Verify tap vào sender anonymous → KHÔNG navigate. Verify tap sender thường → navigate profile | `lib/features/kudos/presentation/widgets/sender_info_widget.dart`
- [x] T021 [P] Verify edge case: `isAnonymous=true` nhưng `senderAlias=null` → hiển thị i18n fallback | `lib/features/kudos/presentation/widgets/sender_info_widget.dart`
- [ ] T022 [P] Verify edge case: sender bị xóa tài khoản → hiển thị "Người dùng không tồn tại", KHÔNG nhầm với ẩn danh | `lib/features/kudos/presentation/widgets/sender_info_widget.dart`
- [x] T023 Chạy `flutter analyze` — 0 errors/warnings | Toàn bộ project
- [x] T024 Chạy `flutter test` — tất cả tests pass | `test/`
- [ ] T025 Verify trên simulator: mở kudos thường → đầy đủ info; mở kudos ẩn danh → sender ẩn + badge ẩn + tap disabled; heart/copy link hoạt động cả 2 | Device testing (⚠️ blocked bởi T001 — cần asset avatar hợp lệ)

**Checkpoint**: Feature hoàn chỉnh. Anonymous variant hiển thị đúng.

### Blockers

- **T001**: `anonymous_avatar.png` hiện chỉ 1x1 pixel placeholder → `Codec failed to produce an image`. Cần tạo ảnh PNG hợp lệ ≥96x96px (nền tối + person outline). T025 bị block bởi issue này.

---

## Phụ thuộc & Thứ tự thực thi

### Phụ thuộc giữa Phases

```
Phase 1 (Setup) ──────────────────────┐
    │                                   │
    v                                   │
Phase 2 (Foundation — ViewModel)       │
    │                                   │
    v                                   │
Phase 3 (US1: Detail Screen + Sender)  │
    │                                   │
    v                                   │
Phase 4 (US2: Heart + Copy Link)       │
    │                                   │
    v                                   │
Phase Final (Polish) ──────────────────┘
```

### Song song trong mỗi Phase

- **Phase 1**: T001–T004 song song. T005 sau T002 (cần model update). T006 cuối
- **Phase 2**: T007 trước T008. T009 trước T010
- **Phase 3**: T011 trước T012. T013 song song với T012. T014 trước T015. T016 sau T015
- **Phase 3.5**: T026–T028 song song (cùng file kudos_card.dart)
- **Phase 4**: T017 trước T018
- **Phase Final**: T019–T022 song song. T023–T024 song song. T025 sau T001 (cần asset hợp lệ)

---

## Chiến lược triển khai

### MVP First (Khuyến nghị)

1. Phase 1 (Setup) — assets, model, i18n
2. Phase 2 (ViewModel) — load kudos detail
3. Phase 3 (US1: Detail Screen) — **TEST**: mở kudos ẩn danh → sender ẩn đúng
4. Phase 4 (US2: Actions) — heart + copy link
5. Phase Final (Polish)

**Ước lượng**: ~3 ngày

---

## Ghi chú

- TR-001: PHẢI dùng chung 1 widget/screen cho cả thường + ẩn danh
- TR-003: Logic ẩn sender nằm trong `SenderInfoWidget` (detail) VÀ `_AnonymousAvatar` trong `KudosCard` (feed/highlight), KHÔNG scatter ở nơi khác
- Avatar ẩn danh border dày hơn (1.869px) vs thường (0.865px)
- TDD bắt buộc: Test → FAIL → Implement → PASS → Refactor
- Commit sau mỗi phase hoặc nhóm logic
- Tái sử dụng `HeartButton` widget hiện có nếu phù hợp
- ⚠️ `anonymous_avatar.png` hiện là placeholder 1x1px → crash runtime. Cần thay bằng ảnh thật ≥96x96px trước khi test trên device
