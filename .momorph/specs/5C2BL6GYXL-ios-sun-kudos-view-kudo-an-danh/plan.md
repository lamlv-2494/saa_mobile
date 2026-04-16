# Kế hoạch triển khai: [iOS] Sun*Kudos — View Kudo Ẩn Danh

**Frame**: `5C2BL6GYXL-ios-sun-kudos-view-kudo-an-danh`
**Ngày**: 2026-04-15
**Spec**: `specs/5C2BL6GYXL-ios-sun-kudos-view-kudo-an-danh/spec.md`

**Màn hình parent/gốc**: `T0TR16k0vH` — View Kudo (chi tiết kudos)

---

## Tóm tắt

Triển khai **variant ẩn danh** cho màn hình View Kudo chi tiết. Khi `isAnonymous = true`, thông tin người gửi bị ẩn: avatar mặc định ẩn danh, tên hiển thị alias hoặc "Người gửi ẩn danh", phòng ban thay bằng "Người gửi ẩn danh", ẩn badge danh hiệu, và disable tap vào avatar/tên sender. Tất cả phần còn lại (recipient info, content, heart, actions) giữ nguyên.

**Triết lý**: Dùng CHUNG widget với View Kudo thường, conditional rendering qua flag `isAnonymous` trên model `Kudos`.

---

## Bối cảnh kỹ thuật

**Framework**: Flutter 3.41.3 / Dart ^3.11.1
**State Management**: Riverpod
**Backend**: Supabase — `kudos` table có cột `is_anonymous`, `sender_alias`

### Hiện trạng code

| Thành phần | Trạng thái | Ghi chú |
|-----------|-----------|---------|
| `Kudos` model | ✅ Đã có | Có `isAnonymous` field, chưa có `senderAlias` |
| View Kudo Detail Screen | ❌ Chưa có | Route `/kudos/:kudosId` tồn tại nhưng chỉ là placeholder |
| Anonymous avatar asset | ❌ Chưa có | Cần download từ Figma hoặc tạo |
| i18n "Người gửi ẩn danh" | ❌ Chưa có | Cần thêm key mới |
| `KudosRemoteDatasource.fetchKudosDetail()` | ✅ Đã có | Trả về `Kudos` model với `isAnonymous` |

---

## Kiểm tra tuân thủ Constitution

| Yêu cầu | Quy tắc Constitution | Trạng thái |
|----------|----------------------|-----------|
| MVVM + Riverpod | 1 ViewModel cho Kudos Detail | ✅ Tuân thủ |
| Feature-based module | Nằm trong `lib/features/kudos/` | ✅ Tuân thủ |
| Freezed models | Mở rộng `Kudos` model với `senderAlias` | ✅ Tuân thủ |
| Widget con = StatelessWidget | Conditional rendering trong StatelessWidget | ✅ Tuân thủ |
| SVG/PNG assets | Anonymous avatar asset qua flutter_gen | ✅ Tuân thủ |
| i18n (slang) VN/EN | "Người gửi ẩn danh" qua i18n | ✅ Tuân thủ |
| TDD | Viết test trước | ✅ Tuân thủ |

**Vi phạm**: Không có.

---

## Quyết định kiến trúc

### Shared Widget Strategy

```
KudosDetailScreen (màn chi tiết)
├── SenderInfoWidget(kudos: kudos)  ← conditional rendering
│   ├── isAnonymous = true  → anonymous avatar, alias text, no badge, no tap
│   └── isAnonymous = false → real avatar, real name, badge, tap to profile
├── ReceiverInfoWidget(receiver: receiver) ← luôn hiển thị đầy đủ
├── ContentSection(kudos: kudos) ← không thay đổi
├── HashtagSection ← không thay đổi
├── ImageSection ← không thay đổi
└── ActionsSection (heart, copy link) ← không thay đổi

KudosCard (feed/highlight — ĐÃ FIX)
├── _SenderReceiverRow
│   ├── isAnonymous = true  → _AnonymousAvatar (asset, alias, no badge, no tap)
│   └── isAnonymous = false → _UserAvatar (real avatar, name, dept, badge, tap)
└── KudosContentCard ← không thay đổi
```

### Model Updates

```dart
// Thêm vào Kudos model
@freezed
class Kudos {
  // ... existing fields ...
  String? senderAlias,  // Alias hiển thị khi ẩn danh (backend cung cấp)
}
```

### Anonymous Sender Display Logic

```dart
// Trong SenderInfoSection widget:
if (kudos.isAnonymous) {
  // Avatar: Assets.images.anonymousAvatar (asset riêng)
  // Name: kudos.senderAlias ?? t.kudos.anonymousSender
  // Department: t.kudos.anonymousSender
  // Badge: hidden
  // OnTap: null (disabled)
} else {
  // Avatar: sender.avatar (NetworkImage + fallback)
  // Name: sender.name
  // Department: sender.department
  // Badge: hero tier badge
  // OnTap: navigate to profile
}
```

### Backend Integration

- Cột `is_anonymous` đã có trong bảng `kudos`
- Cần kiểm tra/thêm cột `sender_alias` (VARCHAR, nullable) cho alias ẩn danh
- `_kudosSelect` trong datasource đã select `is_anonymous`
- Cần thêm `sender_alias` vào select query

---

## Cấu trúc project

### File mới

| File | Mục đích |
|------|---------|
| `lib/features/kudos/presentation/screens/kudos_detail_screen.dart` | Màn hình chi tiết kudos (shared cho cả thường + ẩn danh) |
| `lib/features/kudos/presentation/viewmodels/kudos_detail_viewmodel.dart` | ViewModel cho chi tiết kudos |
| `lib/features/kudos/presentation/widgets/sender_info_widget.dart` | Widget hiển thị sender (conditional anonymous) |
| `lib/features/kudos/presentation/widgets/receiver_info_widget.dart` | Widget hiển thị receiver |
| `lib/features/kudos/presentation/widgets/kudos_content_detail_widget.dart` | Widget nội dung chi tiết |
| `lib/features/kudos/presentation/widgets/kudos_actions_widget.dart` | Heart + Copy Link actions |
| `assets/images/anonymous_avatar.png` | Avatar mặc định ẩn danh |
| `test/unit/viewmodels/kudos_detail_viewmodel_test.dart` | Test ViewModel |
| `test/widget/kudos/sender_info_widget_test.dart` | Test anonymous rendering |

### File cần sửa

| File | Thay đổi |
|------|---------|
| `lib/features/kudos/data/models/kudos.dart` | Thêm `senderAlias` field |
| `lib/features/kudos/data/datasources/kudos_remote_datasource.dart` | Thêm `sender_alias` vào select, map vào Kudos |
| `lib/app/router.dart` | Thay placeholder route `/kudos/:kudosId` bằng `KudosDetailScreen` |
| `lib/i18n/strings_vi.i18n.json` | Thêm keys cho anonymous sender |
| `lib/i18n/strings_en.i18n.json` | Thêm keys cho anonymous sender |
| `supabase/migrations/` | Thêm cột `sender_alias` nếu chưa có |
| `lib/features/kudos/presentation/widgets/kudos_card.dart` | Fix anonymous rendering trong `_SenderReceiverRow` (compact + full), thêm `_AnonymousAvatar` widget |
| `test/helpers/kudos_test_helpers.dart` | Thêm `senderAlias` param vào `createKudos()` |

---

## Chiến lược triển khai

### Phase 0: Setup + Assets

**Mục tiêu**: Chuẩn bị assets, i18n, model update

1. Download/tạo anonymous avatar asset → `assets/images/anonymous_avatar.png`
2. Thêm i18n keys: `kudos.anonymousSender` ("Người gửi ẩn danh" / "Anonymous sender")
3. Thêm `senderAlias` vào `Kudos` model + rebuild freezed
4. Kiểm tra/tạo migration cho cột `sender_alias` trong bảng `kudos`
5. Cập nhật `_kudosSelect` và `_mapKudos` trong datasource
6. Chạy `dart run slang` + `dart run build_runner build`

### Phase 1: Data Layer (TDD)

**Mục tiêu**: ViewModel + Repository cho Kudos Detail

1. **Test trước**: Test `KudosDetailViewModel` — load kudos, anonymous state
2. **Tạo `KudosDetailViewModel`**: `AsyncNotifier<Kudos?>` — load by kudos ID
3. **Test**: Verify `senderAlias` mapping từ API response

### Phase 2: UI — Shared Detail Screen (TDD)

**Mục tiêu**: Tạo KudosDetailScreen dùng chung cho cả thường + ẩn danh

1. **Test trước**: Test `SenderInfoWidget` — anonymous vs normal rendering
2. **Tạo `SenderInfoWidget`**: Conditional rendering based on `isAnonymous`
   - Anonymous: asset avatar, alias text, "Người gửi ẩn danh", no badge, no tap
   - Normal: network avatar + fallback, real name, department, badge, tap → profile
3. **Tạo `KudosDetailScreen`**: Layout các sections (sender, receiver, content, actions)
4. **Wire route**: Thay placeholder `/kudos/:kudosId` bằng `KudosDetailScreen`

### Phase 3: Heart + Copy Link Actions

**Mục tiêu**: Tương tác heart/copy link (giống nhau cho cả 2 variant)

1. **Tạo `KudosActionsWidget`**: Heart toggle + Copy Link
2. **Wire**: `KudosDetailViewModel.toggleHeart()`, clipboard copy + toast

### Phase 4: Polish + Verify

1. Verify anonymous avatar border dày hơn (1.869px vs 0.865px)
2. Verify tap vào sender anonymous → không navigate
3. Chạy `flutter analyze` + `flutter test`
4. Test trên device: mở kudos thường → đầy đủ info; mở kudos ẩn danh → sender ẩn

---

## Chiến lược testing (TDD)

| Loại | Focus | Coverage |
|------|-------|---------|
| Unit | KudosDetailViewModel: load, anonymous state, heart toggle | 90% |
| Unit | Kudos model: senderAlias mapping, default values | 90% |
| Widget | SenderInfoWidget: anonymous avatar, hidden badge, disabled tap | 80% |
| Widget | KudosDetailScreen: render cả 2 variant | 70% |

---

## Đánh giá rủi ro

| Rủi ro | Ảnh hưởng | Giảm thiểu | Trạng thái |
|--------|----------|-----------|-----------|
| View Kudo thường chưa implement (T0TR16k0vH) | Cao | Implement cả 2 variant cùng lúc trong shared screen | ✅ Đã xử lý |
| Cột `sender_alias` chưa có trong DB | Trung bình | Tạo migration, seed data với alias mẫu | ✅ Đã xử lý |
| Anonymous avatar asset chưa có trên Figma | **Cao** | File hiện tại 1x1px placeholder → crash `Codec failed to produce an image`. Cần tạo ảnh ≥96x96px | ⚠️ **ĐANG BLOCK** |
| Backend chưa trả `sender_alias` | Trung bình | Fallback: dùng i18n "Người gửi ẩn danh" khi `senderAlias == null` | ✅ Đã xử lý |
| KudosCard feed/highlight không ẩn sender | Cao | Fix `_SenderReceiverRow` + thêm `_AnonymousAvatar` | ✅ Đã fix |

---

## Bảng so sánh rendering

| Thành phần | `isAnonymous = false` | `isAnonymous = true` |
|-----------|----------------------|---------------------|
| Avatar sender | `NetworkImage(sender.avatar)` + fallback initials | `Assets.images.anonymousAvatar` (border 1.869px white) |
| Tên sender | `sender.name` | `kudos.senderAlias ?? t.kudos.anonymousSender` |
| Department sender | `sender.department` | `t.kudos.anonymousSender` |
| Badge sender | Hiển thị theo `heroTierUrl` | **Ẩn hoàn toàn** |
| Tap sender | Navigate → Profile | **No-op (disabled)** |
| Receiver info | Đầy đủ | Đầy đủ (không thay đổi) |
| Heart, Copy Link | Hoạt động | Hoạt động (không thay đổi) |

---

## Ghi chú

- TR-001: PHẢI dùng chung 1 widget/screen, KHÔNG tạo screen riêng cho ẩn danh
- TR-003: Logic ẩn sender nằm ở 2 nơi (đúng pattern): `SenderInfoWidget` (detail screen) và `_AnonymousAvatar` trong `KudosCard` (feed/highlight). KHÔNG scatter thêm
- Avatar ẩn danh có border dày hơn (1.869px) vs thường (0.865px) — theo Figma
- Text "Anh Hùng Xạ Điêu" trong Figma là VÍ DỤ alias — backend sẽ cung cấp qua `senderAlias`
- ⚠️ `anonymous_avatar.png` hiện là 1x1px placeholder → crash runtime. PHẢI thay bằng ảnh hợp lệ ≥96x96px trước khi test/release
