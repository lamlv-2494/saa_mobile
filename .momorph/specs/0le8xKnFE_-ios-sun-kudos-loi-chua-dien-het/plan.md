# Kế hoạch triển khai: [iOS] Sun*Kudos — Lỗi Chưa Điền Hết (Validation Error State)

**Frame**: `0le8xKnFE_-ios-sun-kudos-loi-chua-dien-het`
**Ngày**: 2026-04-15
**Spec**: `specs/0le8xKnFE_-ios-sun-kudos-loi-chua-dien-het/spec.md`

**Màn hình parent**: `PV7jBVZU1N` — Gửi lời chúc Kudos

---

## Tóm tắt

Triển khai **trạng thái validation error** cho form gửi kudos. Đây KHÔNG phải màn hình mới mà là error state của `SendKudosScreen` đã có. Bao gồm: error banner tổng quát (đỏ, đầu form), border đỏ trên các trường thiếu, auto-scroll đến lỗi đầu tiên, shake animation khi submit lỗi nhiều lần, và tự ẩn error banner khi user bắt đầu sửa form.

**Phạm vi**: Chỉnh sửa file hiện có — không tạo screen/widget mới (trừ cải thiện ErrorBannerWidget).

---

## Bối cảnh kỹ thuật

**Framework**: Flutter 3.41.3 / Dart ^3.11.1
**State Management**: Riverpod — `SendKudosViewModel extends AsyncNotifier<SendKudosState>`
**Testing**: flutter_test + mocktail (TDD bắt buộc)

### Hiện trạng code

| Thành phần | Trạng thái | Ghi chú |
|-----------|-----------|---------|
| `SendKudosViewModel.validate()` | ✅ Đã có | Validate 4 trường, set `validationErrors` + `showErrorBanner` |
| `SendKudosState.validationErrors` | ✅ Đã có | `Map<String, String>` lưu lỗi theo field |
| `ErrorBannerWidget` | ✅ Đã có | AnimatedSwitcher cơ bản, cần thêm shake animation |
| `_StyledTextField` (border error) | ✅ Đã có | Đổi border sang `AppColors.errorRed` khi `hasError=true` |
| `clearFieldError()` | ✅ Đã có | Xóa lỗi field khi user sửa |
| Auto-scroll đến error | ❌ Chưa có | Cần implement `Scrollable.ensureVisible` |
| Shake animation banner | ❌ Chưa có | Cần thêm vào `ErrorBannerWidget` |
| Self-send validation | ❌ Chưa có | `recipientId != currentUserId` |
| Error banner auto-dismiss khi sửa | ⚠️ Có nhưng chưa wired đúng | `dismissErrorBanner()` tồn tại, cần gọi đúng timing |

---

## Kiểm tra tuân thủ Constitution

| Yêu cầu | Quy tắc Constitution | Trạng thái |
|----------|----------------------|-----------|
| MVVM + Riverpod | Validation logic trong ViewModel, không ở UI | ✅ Tuân thủ |
| Freezed models | `SendKudosState` đã dùng freezed | ✅ Tuân thủ |
| i18n (slang) VN/EN | Text lỗi qua `t.sendKudos.validationXxx` | ✅ Tuân thủ |
| TDD | Viết test trước → implement | ✅ Tuân thủ |
| flutter_gen | Không dùng asset mới (trừ `ic_warning` nếu cần) | ✅ Tuân thủ |

**Vi phạm**: Không có.

---

## Quyết định kiến trúc

### Validation Flow

```
User bấm "Gửi đi"
    → ViewModel.submit()
    → ViewModel.validate()
    → Set validationErrors + showErrorBanner = true
    → UI rebuild: ErrorBannerWidget hiện + border đỏ trên trường lỗi
    → Auto-scroll đến error banner (300ms)

User sửa trường lỗi
    → ViewModel.updateTitle() / selectRecipient() / toggleHashtag()
    → clearFieldError(field) → border trường quay lại #998C5F
    → dismissErrorBanner() → banner ẩn đi

User bấm "Gửi đi" lại (vẫn lỗi)
    → validate() lại → showErrorBanner vẫn true
    → ErrorBannerWidget detect "đã hiển thị" → trigger shake animation
```

### Shake Animation Strategy

- Thêm `shakeKey` (ValueKey hoặc int counter) vào `SendKudosState` — tăng mỗi lần validate fail
- `ErrorBannerWidget` listen `shakeKey` thay đổi → trigger `AnimationController` shake
- Shake: `translateX: 0 → -5 → 5 → 0`, duration 300ms, ease-in-out

### Auto-Scroll Strategy

- `SendKudosScreen` giữ `ScrollController` + `GlobalKey` cho error banner
- Sau validate fail, gọi `Scrollable.ensureVisible(errorBannerKey.currentContext, duration: 300ms)`

### Self-Send Validation

- Lấy `currentUserId` từ Supabase auth trong `ViewModel.build()`
- So sánh `recipientId == currentUserId` trong `validate()`
- Error key: `'recipient_self_send'` → i18n: `t.sendKudos.validationSelfSend`

---

## Cấu trúc project

### File cần sửa

| File | Thay đổi |
|------|---------|
| `lib/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart` | Thêm self-send validation, `shakeKey` counter, lưu `currentUserId` |
| `lib/features/kudos/data/models/send_kudos_state.dart` | Thêm field `shakeKey` (int) |
| `lib/features/kudos/presentation/widgets/error_banner_widget.dart` | Thêm shake animation, nhận `shakeKey` param |
| `lib/features/kudos/presentation/screens/send_kudos_screen.dart` | Thêm ScrollController, auto-scroll logic, wire error banner auto-dismiss |
| `test/unit/viewmodels/send_kudos_viewmodel_test.dart` | Thêm test cases cho self-send, shakeKey increment |
| `test/unit/models/send_kudos_state_test.dart` | Thêm test cho shakeKey default |

### File mới (nếu cần)

Không cần file mới — tất cả sửa trong file hiện có.

---

## Chiến lược triển khai

### Phase 1: ViewModel Logic (TDD)

**Mục tiêu**: Hoàn thiện validation logic trong ViewModel

1. **Test trước**: Thêm test cases cho self-send validation, shakeKey increment
2. **Sửa SendKudosState**: Thêm `shakeKey` field (int, default 0)
3. **Sửa validate()**: Thêm self-send check (`recipientId != currentUserId`)
4. **Sửa validate()**: Tăng `shakeKey` mỗi lần validate fail (dùng để trigger shake)
5. **Build runner**: Regenerate freezed

### Phase 2: Error Banner Animation

**Mục tiêu**: Shake animation trên error banner

1. **Sửa ErrorBannerWidget**: Convert sang `StatefulWidget` (cần `AnimationController`)
2. **Thêm shake animation**: `Transform.translate(offset: Offset(shakeOffset, 0))`
3. **Trigger**: Listen `shakeKey` thay đổi → run shake sequence

### Phase 3: Auto-Scroll + Wiring

**Mục tiêu**: Auto-scroll đến error và wiring đúng error dismiss

1. **Thêm ScrollController** vào `SendKudosScreen`
2. **Thêm GlobalKey** cho error banner widget
3. **Wire auto-scroll**: Sau validate fail → `Scrollable.ensureVisible()`
4. **Wire error banner auto-dismiss**: Khi `updateTitle()`, `updateMessage()`, `selectRecipient()`, `toggleHashtag()` → gọi `dismissErrorBanner()` nếu `showErrorBanner == true`

### Phase 4: Polish + Verify

1. Chạy `flutter analyze` — 0 warnings
2. Chạy `flutter test` — tất cả tests pass
3. Verify trên device/simulator: form rỗng → bấm "Gửi đi" → error state hiển thị đúng

---

## Chiến lược testing (TDD)

| Loại | Focus | Coverage |
|------|-------|---------|
| Unit | ViewModel: self-send validation, shakeKey, error dismiss timing | 90% |
| Unit | SendKudosState: shakeKey default, copyWith | 90% |
| Widget | ErrorBannerWidget: shake animation trigger, hiển thị/ẩn | 70% |
| Widget | SendKudosScreen: border đỏ hiển thị đúng trường | 70% |

---

## Đánh giá rủi ro

| Rủi ro | Ảnh hưởng | Giảm thiểu |
|--------|----------|-----------|
| `Scrollable.ensureVisible` không hoạt động với `SingleChildScrollView` | Trung bình | Fallback: dùng `ScrollController.animateTo` với offset cố định |
| Shake animation jank trên device cũ | Thấp | Dùng `Transform.translate` (không trigger layout rebuild) |
| `currentUserId` chưa có sẵn trong ViewModel | Trung bình | Lấy từ `_client.auth.currentUser` trong `build()`, lưu vào local var |

---

## Ghi chú

- Đây là error state của màn hình `PV7jBVZU1N`, KHÔNG phải màn hình riêng
- Hầu hết logic đã implement — chủ yếu là polish animation và wire đúng timing
- Self-send validation cần `currentUserId` — phụ thuộc Supabase auth đã setup
- Nút "Gửi đi" vẫn ENABLED ở error state (FR-006) — đã đúng trong code hiện tại
