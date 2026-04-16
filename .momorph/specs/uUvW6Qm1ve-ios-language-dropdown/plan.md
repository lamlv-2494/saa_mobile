# Kế hoạch triển khai: [iOS] Language Dropdown

**Frame**: `uUvW6Qm1ve-ios-language-dropdown`
**Ngày**: 2026-04-15
**Spec**: `specs/uUvW6Qm1ve-ios-language-dropdown/spec.md`

---

## Tóm tắt

Dropdown chọn ngôn ngữ (VN/EN) với cờ quốc gia, sử dụng trên nhiều màn hình (Login, Home, Kudos). Lưu lựa chọn qua SharedPreferences, trigger rebuild toàn app khi thay đổi.

**Trạng thái: ĐÃ TRIỂN KHAI HOÀN CHỈNH** — Feature này đã được implement đầy đủ trong codebase hiện tại.

---

## Bối cảnh kỹ thuật

**Framework**: Flutter 3.41.3 / Dart ^3.11.1
**Phụ thuộc chính**: flutter_riverpod, slang, shared_preferences, flutter_svg, flutter_gen
**Testing**: flutter_test + mocktail

---

## Kiểm tra tuân thủ Constitution

| Yêu cầu | Quy tắc Constitution | Trạng thái |
|----------|----------------------|-----------|
| StateNotifier cho locale | Cho phép `StateNotifier` cho state đơn giản không async | ✅ Tuân thủ |
| Widget con = StatelessWidget | `LanguageDropdown` là StatelessWidget | ✅ Tuân thủ |
| SVG icons | Flags dùng SVG (`vn.svg`, `en.svg`) | ✅ Tuân thủ |
| flutter_gen | `Assets.icons.flags.vn.svg()` | ✅ Tuân thủ |
| i18n (slang) | Tích hợp `LocaleSettings` + `TranslationProvider` | ✅ Tuân thủ |
| Không hardcode | Constants trong `AppConstants` | ✅ Tuân thủ |

---

## Code hiện có (đã implement)

### Source Files

| File | Mục đích | Trạng thái |
|------|---------|-----------|
| `lib/shared/widgets/language_dropdown.dart` | `LanguageDropdown` StatelessWidget, dùng `PopupMenuButton` | ✅ Có |
| `lib/shared/providers/locale_provider.dart` | `LocaleNotifier` (StateNotifier) + `localeNotifierProvider` + SharedPreferences | ✅ Có |
| `lib/app/app.dart` | App root watch `localeNotifierProvider`, sync slang i18n | ✅ Có |
| `lib/core/constants/app_constants.dart` | `supportedLocaleCodes: ['vi', 'en']`, `defaultLocaleCode: 'vi'` | ✅ Có |
| `assets/icons/flags/vn.svg` | Cờ Việt Nam SVG | ✅ Có |
| `assets/icons/flags/en.svg` | Cờ Anh SVG | ✅ Có |
| `test/widget/shared/language_dropdown_test.dart` | 6 widget test cases | ✅ Có |
| `test/unit/providers/locale_provider_test.dart` | Unit test cho `LocaleNotifier` (StateNotifier) | ✅ Có |

### Tái sử dụng

Widget `LanguageDropdown` được reuse tại 3 màn hình:
- Login screen
- Home screen
- Kudos screen

---

## Quyết định kiến trúc

### Frontend
- **Component**: `LanguageDropdown` — `StatelessWidget` nhận `localeNotifierProvider` qua `ref.watch`
- **State**: `LocaleNotifier extends StateNotifier<String>` — state đơn giản (locale code string)
- **Persistence**: `SharedPreferences` — lưu key `locale_code`
- **App rebuild**: `app.dart` watch provider → `LocaleSettings.setLocaleRaw(locale)` → widget tree rebuild

### Luồng hoạt động
```
User tap dropdown → Chọn ngôn ngữ → LocaleNotifier.setLocale(code)
→ SharedPreferences.setString('locale_code', code)
→ state = code → App root rebuild → slang LocaleSettings update
→ Toàn bộ UI hiển thị ngôn ngữ mới
```

---

## Chiến lược triển khai

**Không cần triển khai thêm** — feature đã hoàn chỉnh.

### Nếu cần mở rộng trong tương lai:
- Thêm ngôn ngữ mới: thêm vào `AppConstants.supportedLocaleCodes` + thêm flag SVG + thêm file i18n
- Thay đổi UI dropdown: sửa `LanguageDropdown` widget

---

## Đánh giá rủi ro

| Rủi ro | Xác suất | Ảnh hưởng | Giảm thiểu |
|--------|----------|-----------|-----------|
| Không có rủi ro | — | — | Feature đã hoàn chỉnh và có test coverage |

---

## Kiểm tra coverage User Stories vs Implementation

| User Story (spec) | Mô tả | Trạng thái |
|-------------------|-------|-----------|
| US1 — Mở/đóng dropdown | Tap trigger -> popup hiển thị 2 options VN/EN; tap ngoài -> đóng | ✅ Đã implement (`PopupMenuButton` tự xử lý open/close) |
| US2 — Chọn ngôn ngữ | Chọn option -> app rebuild ngay, trigger cập nhật cờ + mã | ✅ Đã implement (`LocaleNotifier.setLocale` -> `LocaleSettings`) |
| US3 — Lưu trạng thái | SharedPreferences persist locale, khôi phục khi mở lại app | ✅ Đã implement (`SharedPreferences` key `locale_code`) |

### Edge Cases (spec) vs Implementation

| Edge Case | Trạng thái |
|-----------|-----------|
| Không có ngôn ngữ đã lưu -> mặc định VN | ✅ `AppConstants.defaultLocaleCode = 'vi'` |
| Ngôn ngữ lưu không hợp lệ -> fallback VN | ✅ `LocaleNotifier` fallback logic |
| Thay đổi giữa phiên -> widget tree rebuild | ✅ App root watch `localeNotifierProvider` |
| SharedPreferences ghi thất bại -> UI vẫn đổi, lần sau fallback VN | ✅ Async write, state update trước |

---

## Ghi chú

- Feature hoàn toàn đã implement — plan này chỉ để ghi nhận trạng thái và kiến trúc
- Nếu design trong Figma có khác biệt visual so với implementation hiện tại (ví dụ: style dropdown, vị trí, animation), cần tạo task riêng để điều chỉnh UI
- Spec ghi dropdown hiển thị trên màn hình Login, nhưng implementation mở rộng ra Home và Kudos — đây là cải tiến hợp lý, không vi phạm spec
- Tất cả 3 User Stories và edge cases trong spec đều đã được cover bởi implementation hiện tại
