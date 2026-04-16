# Kế hoạch triển khai: [iOS] Sun*Kudos — Viết Kudo (Trạng thái mặc định)

**Frame**: `7fFAb-K35a-ios-sun-kudos-viet-kudo-default`
**Ngày**: 2026-04-15
**Spec**: `specs/7fFAb-K35a-ios-sun-kudos-viet-kudo-default/spec.md`

**Màn hình parent**: `PV7jBVZU1N` — Gửi lời chúc Kudos

---

## Tóm tắt

Đảm bảo **trạng thái mặc định** (initial empty state) của form gửi kudos hiển thị chính xác: tất cả trường rỗng với placeholder hướng dẫn, toolbar formatting tất cả inactive, nút "Gửi đi" disabled (opacity giảm), checkbox ẩn danh unchecked, không có chips/thumbnails. Đây KHÔNG phải screen mới — là initial state của `SendKudosScreen` đã implement.

**Phạm vi**: Chủ yếu verify + sửa nhỏ. Hầu hết đã implement trong `PV7jBVZU1N`.

---

## Bối cảnh kỹ thuật

**Framework**: Flutter 3.41.3 / Dart ^3.11.1
**State Management**: Riverpod — `SendKudosViewModel extends AsyncNotifier<SendKudosState>`

### Hiện trạng code

| Thành phần | Trạng thái | Ghi chú |
|-----------|-----------|---------|
| `SendKudosState` initial (empty) | ✅ Đã có | Tất cả fields rỗng/false/null by default |
| `isFormValid` getter | ✅ Đã có | `recipientId != null && title.trim().isNotEmpty && message.trim().isNotEmpty && hashtags.isNotEmpty` |
| Nút "Gửi đi" disabled state | ✅ Đã có | `_SendButton` widget với `isEnabled` param, bg/text opacity giảm |
| Placeholder texts (i18n) | ✅ Đã có | `recipientPlaceholder`, `titlePlaceholder`, `messagePlaceholder` |
| Toolbar all inactive | ✅ Đã có | Icon color `Color(0x99FFFFFF)` khi inactive |
| Checkbox ẩn danh unchecked | ✅ Đã có | `isAnonymous: false` default |
| Focus border animation | ⚠️ Có nhưng cần verify | `_StyledTextField` có focus detection, nhưng `RecipientDropdownWidget` chưa có focus state |
| Hashtag section empty state | ✅ Đã có | `HashtagChipGroupWidget` hiển thị nút "+" khi `selectedHashtags` rỗng |
| Image section empty state | ✅ Đã có | `ImageAttachmentWidget` hiển thị nút "+" khi `imagePreviews` rỗng |
| Header subtitle | ✅ Đã sửa | `t.sendKudos.headerSubtitle` — "Gửi lời cám ơn và ghi nhận đến đồng đội" |
| Title hint text | ✅ Đã sửa | `t.sendKudos.titleHint` — description dưới input Danh hiệu |
| @mention hint | ✅ Đã sửa | `t.sendKudos.mentionHint` — i18n thay vì hardcode |

---

## Kiểm tra tuân thủ Constitution

| Yêu cầu | Quy tắc Constitution | Trạng thái |
|----------|----------------------|-----------|
| MVVM + Riverpod | Initial state trong ViewModel.build() | ✅ Tuân thủ |
| Freezed models | `SendKudosState` default values | ✅ Tuân thủ |
| i18n (slang) VN/EN | Tất cả placeholder/label qua i18n | ✅ Tuân thủ |
| flutter_gen | Icons qua `Assets.icons.icXxx.svg()` | ✅ Tuân thủ |
| TDD | Tests cho initial state đã có | ✅ Tuân thủ |

**Vi phạm**: Không có.

---

## Quyết định kiến trúc

### Initial State = Default `SendKudosState()`

Không cần logic đặc biệt — initial state chính là giá trị mặc định của freezed model:

```dart
const factory SendKudosState({
  String? recipientId,        // null → Recipient trống
  String? recipientName,      // null → Placeholder hiện
  @Default('') String title,  // '' → Placeholder hiện
  @Default('') String message, // '' → Placeholder hiện
  @Default([]) List<Hashtag> hashtags, // [] → Chỉ nút "+"
  @Default([]) List<String> imagePreviews, // [] → Chỉ nút "+"
  @Default(false) bool isAnonymous, // false → Unchecked
  @Default(false) bool isDirty, // false → "Hủy" đóng ngay
  @Default(false) bool showErrorBanner, // false → Không error
  // ...
})
```

### Send Button Enablement

```
isFormValid = recipientId != null
           && title.trim().isNotEmpty
           && message.trim().isNotEmpty
           && hashtags.isNotEmpty

UI: isEnabled = isFormValid && !isSubmitting
```

Initial state → `isFormValid = false` → nút disabled ✅

### Disabled vs Enabled Visual

| Property | Disabled (default) | Enabled (đã điền đủ) |
|----------|-------------------|---------------------|
| Background | `rgba(255,234,158,0.40)` = `AppColors.sendButtonDisabledBg` | `#FFEA9E` = `AppColors.buttonBg` |
| Text color | `rgba(0,16,26,0.50)` = `AppColors.sendButtonDisabledText` | `#00101A` = `AppColors.buttonText` |
| Icon color | `AppColors.sendButtonDisabledText` | `AppColors.buttonText` |
| onTap | `null` | `_submit` |

---

## Cấu trúc project

### File cần sửa (nhỏ)

| File | Thay đổi |
|------|---------|
| `lib/features/kudos/presentation/screens/send_kudos_screen.dart` | Verify Send button animation opacity 200ms khi transition disabled→enabled |
| `test/unit/models/send_kudos_state_test.dart` | Thêm test verify initial state defaults |

### File không cần sửa (đã đúng)

- `send_kudos_viewmodel.dart` — `build()` trả về `SendKudosState(availableHashtags: hashtags)` ✅
- `send_kudos_state.dart` — Default values đúng ✅
- `error_banner_widget.dart` — Ẩn khi `showErrorBanner = false` ✅
- `hashtag_chip_group_widget.dart` — Empty state hiển thị nút "+" ✅
- `image_attachment_widget.dart` — Empty state hiển thị nút "+" ✅
- `formatting_toolbar_widget.dart` — Tất cả nút inactive ✅
- `recipient_dropdown_widget.dart` — Placeholder hiện khi `recipientId = null` ✅

---

## Chiến lược triển khai

### Phase 1: Verify + Test Initial State (TDD)

**Mục tiêu**: Đảm bảo initial state chính xác qua tests

1. **Thêm test** verify `SendKudosState()` default values:
   - `recipientId == null`, `title == ''`, `message == ''`
   - `hashtags == []`, `imagePreviews == []`
   - `isAnonymous == false`, `isDirty == false`
   - `isFormValid == false`, `showErrorBanner == false`
2. **Thêm test** verify `isFormValid` returns `false` khi bất kỳ trường nào thiếu
3. **Verify test** `SendKudosViewModel.build()` trả về state rỗng

### Phase 2: Send Button Animation

**Mục tiêu**: Transition opacity 200ms khi disabled↔enabled

1. **Sửa `_SendButton`**: Wrap trong `AnimatedOpacity` hoặc `AnimatedContainer` 200ms
2. **Verify**: Điền đủ 4 trường → nút chuyển enabled với animation mượt

### Phase 3: Visual Verification

**Mục tiêu**: So sánh UI với Figma design frame `7fFAb-K35a`

1. Chạy app trên simulator
2. Mở SendKudosScreen → verify trạng thái mặc định:
   - Header subtitle đúng text
   - Tất cả placeholders hiển thị đúng
   - Toolbar tất cả inactive (màu `rgba(255,255,255,0.6)`)
   - Nút "Gửi đi" disabled (opacity giảm)
   - Checkbox unchecked
   - Chỉ có nút "+" cho Hashtag và Image
3. Focus vào input → verify border chuyển `#FFEA9E`
4. Điền đủ 4 trường → verify nút "Gửi đi" chuyển enabled

---

## Chiến lược testing (TDD)

| Loại | Focus | Coverage |
|------|-------|---------|
| Unit | SendKudosState default values, isFormValid=false khi empty | 95% |
| Unit | ViewModel.build() trả initial state đúng | 95% |
| Widget | SendKudosScreen render default state (placeholders, disabled button) | 70% |

---

## Đánh giá rủi ro

| Rủi ro | Ảnh hưởng | Giảm thiểu |
|--------|----------|-----------|
| Đã implement hầu hết, có thể miss edge case nhỏ | Thấp | Verify kỹ bằng test + visual comparison |
| Send button animation không smooth | Thấp | Dùng `AnimatedContainer` thay `setState` |

---

## Ghi chú

- Đây là trạng thái RỖNG của form `PV7jBVZU1N` — KHÔNG phải screen riêng
- Hầu hết đã implement đúng — plan này chủ yếu là **verify + polish**
- Initial state = default `SendKudosState()` constructor → zero custom logic cần
- Spec xác nhận height 812px (vừa 1 màn hình) khi rỗng, không cần scroll
- "Hủy" khi `isDirty = false` → đóng ngay, không hiển thị dialog (đã implement đúng)
- Ước lượng effort: ~0.5 ngày (chủ yếu test + verify + send button animation)
