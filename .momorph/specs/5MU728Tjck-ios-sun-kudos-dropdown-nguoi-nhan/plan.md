# Kế hoạch triển khai: [iOS] Sun*Kudos — Dropdown Tên Người Nhận

**Frame**: `5MU728Tjck-ios-sun-kudos-dropdown-nguoi-nhan`
**Ngày**: 2026-04-15
**Spec**: `specs/5MU728Tjck-ios-sun-kudos-dropdown-nguoi-nhan/spec.md`

**Màn hình parent**: `PV7jBVZU1N` — Gửi lời chúc Kudos

---

## Tóm tắt

Cải thiện **dropdown tìm kiếm người nhận** trong form gửi kudos. Widget `RecipientDropdownWidget` đã tồn tại (dùng `showModalBottomSheet`), cần nâng cấp theo design spec: shimmer loading state, icon clear (X) cho search input, avatar fallback với initials, error/retry state, debounce chính xác 300ms (hiện tại 400ms), và divider giữa items.

**Phạm vi**: Cải thiện file hiện có + thêm shimmer loading widget.

---

## Bối cảnh kỹ thuật

**Framework**: Flutter 3.41.3 / Dart ^3.11.1
**State Management**: Riverpod — search state nằm trong `SendKudosViewModel`
**Backend**: Supabase PostgREST — `searchUsers(query)` đã có

### Hiện trạng code

| Thành phần | Trạng thái | Ghi chú |
|-----------|-----------|---------|
| `RecipientDropdownWidget` | ✅ Đã có | Bottom sheet modal, search + debounce 400ms |
| `RecipientSearchItem` | ✅ Đã có | Avatar + tên + department, nhưng thiếu fallback initials |
| `SendKudosViewModel.searchRecipients()` | ✅ Đã có | Search API call |
| `UserSummary` model | ✅ Đã có | id, name, avatar, department, badgeLevel, heroTierUrl |
| Shimmer loading | ❌ Chưa có | Cần thêm shimmer placeholder 3 items |
| Clear (X) button | ❌ Chưa có | Cần thêm vào search input |
| Avatar fallback initials | ❌ Chưa có | Hiện tại chỉ có CircleAvatar basic |
| Error/retry state | ❌ Chưa có | Hiện tại catch error silently |
| Divider giữa items | ❌ Chưa có | Cần thêm |

---

## Kiểm tra tuân thủ Constitution

| Yêu cầu | Quy tắc Constitution | Trạng thái |
|----------|----------------------|-----------|
| MVVM + Riverpod | Search logic trong ViewModel | ✅ Tuân thủ |
| Widget con = StatelessWidget | RecipientSearchItem là StatelessWidget | ✅ Tuân thủ |
| i18n (slang) VN/EN | Tất cả text qua i18n | ✅ Tuân thủ |
| TDD | Viết test trước | ✅ Tuân thủ |
| flutter_gen | Icons qua `Assets.icons.icXxx.svg()` | ✅ Tuân thủ |

**Vi phạm**: Không có.

---

## Quyết định kiến trúc

### Bottom Sheet vs Overlay

**Quyết định**: Giữ `showModalBottomSheet` (đã implement + hoạt động tốt).

**Lý do**:
- Spec gợi ý overlay nhưng cũng cho phép bottom sheet (`TR-002: widget overlay, không phải screen mới`)
- Bottom sheet đã hoạt động, keyboard handling tốt, scroll content tự nhiên
- Convert sang OverlayEntry tốn effort cao, rủi ro keyboard/focus issues
- Bottom sheet pattern nhất quán với `HashtagDropdownWidget`

### Search Flow (cải thiện)

```
User bấm "Người nhận" input
    → showModalBottomSheet mở
    → Search input auto-focus, keyboard hiện
    → Gõ < 2 ký tự → hint "Nhập ít nhất 2 ký tự"
    → Gõ >= 2 ký tự → debounce 300ms → API call
    → Loading: shimmer 3 items
    → Results: ListView + RecipientSearchItem + dividers
    → Empty: "Không tìm thấy kết quả"
    → Error: "Đã xảy ra lỗi" + retry button
    → Bấm item → đóng sheet + set recipient
    → Bấm ngoài → đóng sheet, giữ selection cũ
```

### Avatar Fallback Strategy

```dart
// Trong RecipientSearchItem:
Widget _buildAvatar(UserSummary user) {
  if (user.avatar.isNotEmpty) {
    return CircleAvatar(
      radius: 18,
      backgroundImage: NetworkImage(user.avatar),
      onBackgroundImageError: (_, __) {}, // fallback below
    );
  }
  // Fallback: initials trên nền vàng nhạt
  return CircleAvatar(
    radius: 18,
    backgroundColor: Color(0x33FFEA9E), // rgba(255,234,158,0.20)
    child: Text(
      _getInitials(user.name),
      style: montserrat(fontSize: 14, fontWeight: w600, color: Color(0xFFFFEA9E)),
    ),
  );
}
```

### Error State trong ViewModel

- Thêm `searchError` field vào `SendKudosState` (String?, nullable)
- Khi API fail → set `searchError` = error message
- UI hiển thị error text + retry button
- Retry: gọi lại `searchRecipients(lastQuery)`

---

## Cấu trúc project

### File mới

| File | Mục đích |
|------|---------|
| `lib/features/kudos/presentation/widgets/recipient_shimmer_widget.dart` | Shimmer loading placeholder (3 items) |
| `test/widget/kudos/recipient_dropdown_widget_test.dart` | Widget test cho dropdown |

### File cần sửa

| File | Thay đổi |
|------|---------|
| `lib/features/kudos/presentation/widgets/recipient_dropdown_widget.dart` | Clear button, dividers, shimmer, error/retry, debounce 300ms |
| `lib/features/kudos/presentation/widgets/recipient_search_item.dart` | Avatar fallback initials, text weight 600, department style |
| `lib/features/kudos/data/models/send_kudos_state.dart` | Thêm `searchError` field |
| `lib/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart` | Error handling trong `searchRecipients()`, set `searchError` |
| `test/unit/viewmodels/send_kudos_viewmodel_test.dart` | Thêm test cho search error state |
| `lib/i18n/strings_vi.i18n.json` | Thêm keys cho error/retry |
| `lib/i18n/strings_en.i18n.json` | Thêm keys cho error/retry |

---

## Chiến lược triển khai

### Phase 1: Data Layer Improvements (TDD)

**Mục tiêu**: Error handling cho search + state update

1. **Test trước**: Test `searchRecipients()` error case → set `searchError`
2. **Sửa `SendKudosState`**: Thêm `searchError` (String?)
3. **Sửa `searchRecipients()`**: Catch error → set `searchError` thay vì silent fail
4. **Rebuild freezed**

### Phase 2: UI — RecipientSearchItem Improvements

**Mục tiêu**: Avatar fallback + text styling

1. **Test trước**: Test RecipientSearchItem với avatar null → hiển thị initials
2. **Sửa `RecipientSearchItem`**: Avatar fallback với initials
3. **Sửa text styling**: Tên `fontWeight: w600`, department `12px/400/#999`
4. **Thêm press highlight**: `InkWell` với `splashColor: Color(0x14FFEA9E)`

### Phase 3: UI — Dropdown Sheet Improvements

**Mục tiêu**: Clear button, shimmer, dividers, error/retry

1. **Tạo `RecipientShimmerWidget`**: 3 shimmer items (circle + 2 lines)
2. **Sửa `_RecipientDropdownSheet`**:
   - Clear (X) button trong search input (`suffixIcon` khi có text)
   - Debounce 300ms (thay vì 400ms hiện tại)
   - Loading state → `RecipientShimmerWidget`
   - Error state → error text + retry button
   - Dividers giữa items (`Divider(color: Color(0xFF2E3940), height: 1, indent: 12, endIndent: 12)`)
3. **Minimum 2 ký tự**: Kiểm tra length trước khi trigger search

### Phase 4: Polish + Verify

1. Verify debounce 300ms (không trigger quá sớm/muộn)
2. Verify clear button xóa text + ẩn results
3. Verify avatar fallback khi URL invalid
4. Verify error state + retry hoạt động
5. Chạy `flutter analyze` + `flutter test`

---

## Chiến lược testing (TDD)

| Loại | Focus | Coverage |
|------|-------|---------|
| Unit | ViewModel: search error handling, searchError state | 90% |
| Unit | SendKudosState: searchError field | 90% |
| Widget | RecipientSearchItem: avatar fallback, text styling | 80% |
| Widget | RecipientDropdownWidget: clear button, states (loading/empty/error/results) | 70% |

---

## Đánh giá rủi ro

| Rủi ro | Ảnh hưởng | Giảm thiểu |
|--------|----------|-----------|
| Shimmer package chưa có | Thấp | Dùng `Container` + `LinearGradient` animation tự build (đơn giản, không cần package) |
| Debounce race condition | Trung bình | Cancel timer cũ trước khi tạo mới (đã xử lý) |
| Keyboard đẩy bottom sheet lên | Thấp | Đã xử lý bằng `MediaQuery.of(context).viewInsets.bottom` |
| NetworkImage error không trigger fallback | Trung bình | Dùng `CachedNetworkImage` hoặc check URL validity trước |

---

## Design Tokens Reference

### Dropdown Container
- Background: `#0A1A24`
- Border: `1px solid #998C5F`
- Border-radius: `4px`
- Max-height: `280px`

### Result Item
- Height: `56px`
- Padding: `0 12px`
- Avatar: `36x36`, circle
- Avatar fallback: bg `rgba(255,234,158,0.20)`, text `#FFEA9E`
- Name: `14px/600`, white
- Department: `12px/400`, `#999999`
- Divider: `1px #2E3940`, indent `12px`
- Press: bg `rgba(255,234,158,0.08)`

### Search Input (focus state)
- Border: `1px solid #FFEA9E`
- Clear icon: `ic_close 16x16 #999`

---

## Ghi chú

- Giữ bottom sheet approach — nhất quán với HashtagDropdownWidget
- Debounce PHẢI đúng 300ms (hiện tại 400ms — cần sửa)
- Avatar fallback dùng initials (chữ cái đầu) trên nền vàng nhạt
- KHÔNG chặn self-send ở dropdown — chặn ở validate khi submit (FR-006)
- Search query là local state (TextEditingController), KHÔNG lưu vào ViewModel
