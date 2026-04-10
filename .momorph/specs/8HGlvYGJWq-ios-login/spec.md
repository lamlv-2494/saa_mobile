# Feature Specification: [iOS] Login

**Frame ID**: `8HGlvYGJWq`
**Frame Name**: `[iOS] Login`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Created**: 2026-04-09
**Status**: Reviewed

---

## Overview

Màn hình Login là điểm vào đầu tiên của ứng dụng SAA Mobile (Sun* Annual Awards).
Người dùng chưa xác thực sẽ thấy màn hình này khi mở app. Màn hình cung cấp:
- Nhận diện thương hiệu SAA (logo, tagline "ROOT FURTHER", hình nền key visual)
- Nút đăng nhập duy nhất qua **Google OAuth** (dành cho nhân viên Sun*)
- Bộ chọn ngôn ngữ cho phép thay đổi ngôn ngữ hiển thị trước khi đăng nhập

---

## User Scenarios & Testing

### User Story 1 - Đăng nhập bằng Google (Priority: P1)

Là một nhân viên Sun*, tôi muốn đăng nhập vào ứng dụng SAA bằng tài khoản Google
của công ty, để có thể truy cập các tính năng SAA 2025.

**Why this priority**: Đây là chức năng cốt lõi duy nhất — không có đăng nhập thì
không thể sử dụng bất kỳ tính năng nào khác của ứng dụng.

**Independent Test**: Mở app → Nhấn "LOGIN With Google" → Xác thực Google →
Chuyển đến màn hình Home.

**Acceptance Scenarios**:

1. **Given** người dùng chưa đăng nhập và đang ở màn hình Login,
   **When** nhấn nút "LOGIN With Google",
   **Then** hệ thống hiển thị Google OAuth consent screen.

2. **Given** người dùng đã chọn tài khoản Google (bất kỳ email nào),
   **When** Google trả về token xác thực thành công,
   **Then** hệ thống chuyển hướng đến màn hình Home ([iOS] Home).

3. **Given** người dùng đang trong quá trình xác thực,
   **When** Google OAuth đang xử lý,
   **Then** nút Login hiển thị trạng thái loading và không cho phép nhấn lại.

4. **Given** người dùng đã chọn tài khoản Google,
   **When** xác thực thất bại (lỗi mạng),
   **Then** hệ thống hiển thị SnackBar lỗi phù hợp cho người dùng.

5. **Given** người dùng đã đăng nhập trước đó và session còn hợp lệ,
   **When** mở lại ứng dụng,
   **Then** hệ thống bỏ qua màn hình Login và chuyển thẳng đến Home.

---

### User Story 2 - Chọn ngôn ngữ hiển thị (Priority: P2)

Là một nhân viên Sun*, tôi muốn thay đổi ngôn ngữ hiển thị của ứng dụng
ngay từ màn hình Login, để có thể sử dụng app bằng ngôn ngữ tôi quen thuộc.

**Why this priority**: Hỗ trợ đa ngôn ngữ quan trọng cho trải nghiệm người dùng
(Sun* có nhân viên Việt Nam và quốc tế), nhưng không chặn việc đăng nhập.

**Independent Test**: Mở app → Nhấn dropdown ngôn ngữ → Chọn ngôn ngữ khác →
Kiểm tra tất cả text trên màn hình Login đã thay đổi.

**Acceptance Scenarios**:

1. **Given** người dùng đang ở màn hình Login với ngôn ngữ mặc định (VN),
   **When** nhấn vào language selector,
   **Then** hệ thống hiển thị popup menu BÊN DƯỚI selector với 2 options: VN và EN.

2. **Given** popup menu đang mở,
   **When** người dùng chọn ngôn ngữ mới (EN),
   **Then** tất cả text trên màn hình Login cập nhật sang English,
   icon cờ và mã ngôn ngữ cập nhật tương ứng. Dropdown tự đóng.

3. **Given** người dùng đã thay đổi ngôn ngữ,
   **When** đóng app và mở lại,
   **Then** ngôn ngữ đã chọn được giữ nguyên (lưu local).

---

### Edge Cases

- Người dùng nhấn nút Login nhiều lần liên tục → Chỉ gửi 1 request OAuth (debounce/disable).
- Mất kết nối internet khi nhấn Login → Hiển thị SnackBar lỗi mạng ở bottom screen.
- Google OAuth bị hủy bởi người dùng (back/cancel) → Quay lại màn Login, trạng thái bình thường.
- Token Google hết hạn trong quá trình xử lý → Retry hoặc hiển thị SnackBar lỗi.
- Thiết bị không có Google Play Services (Android) → Hiển thị SnackBar yêu cầu cài đặt.
- Màn hình bị rotate → App PHẢI lock portrait mode trên màn hình Login.

---

## UI/UX Requirements (từ Figma)

### Screen Components

| Component | Node ID | Loại | Mô tả | Tương tác |
|-----------|---------|------|-------|-----------|
| Background Image | 6885:8965 | Image | Hình nền key visual SAA, phủ toàn màn hình | Không |
| Header Gradient | 6885:8972 | Container | Gradient overlay từ đậm đến trong suốt, h: 104px | Không |
| Logo SAA | 6885:8977 | Image | Logo Sun* Annual Awards, 48x44px | Không |
| Language Selector | 6885:8976 | PopupMenuButton | Cờ + mã ngôn ngữ + arrow, 90x32px | Tap → mở popup menu bên dưới selector (VN/EN) |
| Root Further Tagline | 6885:8967 | Image | Text logo "ROOT FURTHER", 247x109px | Không |
| Description Text | 6885:8968 | Text | "Bắt đầu hành trình...", Montserrat 14/300 | Không |
| Login Button | 6885:8969 | Button | "LOGIN With Google" + icon, 246x40px, bg: #FFEA9E | Tap → Google OAuth |
| Footer Copyright | 6885:8970 | Container | "Bản quyền thuộc về Sun* © 2025", 375x48px | Không |

### Navigation Flow

- **From**: App launch (splash screen / cold start)
- **To**: [iOS] Home (screen_id: OuH1BUTYT0) — sau khi đăng nhập thành công
- **Triggers**:
  - Nhấn "LOGIN With Google" → Google OAuth → Home
  - Nhấn Language Selector → Popup menu bên dưới (VN/EN) → chọn → cập nhật text

### Visual Requirements

- **Nền**: Hình ảnh key visual với gradient overlay phía trên
- **Tone màu**: Tối (#00101A) với điểm nhấn vàng (#FFEA9E)
- **Font**: Montserrat (tất cả text ngoại trừ status bar)
- **Orientation**: Portrait only — lock screen rotation
- **Status Bar**: Light content (text trắng) — `SystemUiOverlayStyle.light`
- **Safe Area**: PHẢI sử dụng `SafeArea` cho nội dung (đặc biệt iPhone có notch/Dynamic Island)
- **Chi tiết thiết kế**: Xem [design-style.md](./design-style.md)

### Error State UI

- **Phương thức hiển thị**: SnackBar ở bottom screen
- **Vị trí**: Phía trên footer, có safe area padding
- **Nền**: #EF4444 (đỏ) với opacity 90%
- **Text**: #FFFFFF, Montserrat 14px, weight 400
- **Duration**: 4 giây, tự đóng hoặc tap để dismiss
- **Nội dung lỗi**:
  - Lỗi mạng: "Không có kết nối mạng. Vui lòng thử lại."
  - Lỗi xác thực: "Đăng nhập thất bại. Vui lòng thử lại."
  - OAuth bị hủy: Không hiển thị lỗi, quay lại trạng thái bình thường.

### Loading State UI

- **Nút Login**: Text "LOGIN With Google" và icon bị ẩn, thay bằng `CircularProgressIndicator`
- **Spinner color**: #00101A (giữ nguyên màu text)
- **Spinner size**: 20px
- **Nút**: Giữ nguyên size 246x40, bg #FFEA9E nhưng opacity giảm xuống 0.7
- **Touch**: Disable toàn bộ nút khi đang loading

### Accessibility Requirements

- **Semantic Labels**: Tất cả interactive elements PHẢI có `semanticLabel` / `Semantics` widget
  - Login Button: "Đăng nhập bằng Google"
  - Language Selector: "Chọn ngôn ngữ, hiện tại: Tiếng Việt"
- **Touch Target**: Minimum 48x48dp cho tất cả interactive elements
  - Login Button: 246x40 → height cần increase hit area lên 48dp (padding bổ sung)
  - Language Selector: 90x32 → cần increase hit area lên 48dp height
- **Contrast Ratio**: 
  - Text trắng (#FFFFFF) trên nền tối (#00101A) → ratio ~19.6:1 ✅ WCAG AAA
  - Text tối (#00101A) trên nền vàng (#FFEA9E) → ratio ~15.8:1 ✅ WCAG AAA
- **Screen Reader**: Đọc theo thứ tự: Logo (image) → Language selector → Tagline (image) → Description → Login button → Copyright
- **Focus Order**: Language Selector → Login Button (2 focusable elements)

---

## Requirements

### Functional Requirements

- **FR-001**: Hệ thống PHẢI hỗ trợ đăng nhập qua Google OAuth 2.0 thông qua Supabase Auth.
- **FR-002**: Hệ thống PHẢI lưu session/token sau khi đăng nhập thành công.
- **FR-003**: Hệ thống PHẢI tự động chuyển đến Home nếu user đã có session hợp lệ.
- **FR-004**: Hệ thống PHẢI hiển thị trạng thái loading khi đang xác thực.
- **FR-005**: Hệ thống PHẢI ngăn chặn double-tap trên nút Login.
- **FR-006**: Hệ thống PHẢI hiển thị thông báo lỗi khi xác thực thất bại.
- **FR-007**: Hệ thống PHẢI hỗ trợ chuyển đổi ngôn ngữ (VN, EN) trước khi đăng nhập qua PopupMenuButton (menu hiển thị bên dưới selector). Chỉ 2 ngôn ngữ.
- **FR-008**: Hệ thống PHẢI lưu ngôn ngữ đã chọn vào local storage.
- **FR-009**: Tất cả text hiển thị PHẢI hỗ trợ i18n thông qua slang.
- **FR-010**: Hệ thống cho phép đăng nhập bằng BẤT KỲ tài khoản Google nào (không giới hạn email domain).

### Technical Requirements

- **TR-001**: Authentication PHẢI sử dụng Supabase Auth với Google OAuth provider.
- **TR-002**: Token/session PHẢI được lưu trữ an toàn (secure storage).
- **TR-003**: Thời gian phản hồi đăng nhập KHÔNG ĐƯỢC vượt quá 10 giây (timeout).
- **TR-004**: Ngôn ngữ preference PHẢI được lưu trữ bằng SharedPreferences hoặc tương đương.
- **TR-005**: Background image PHẢI load từ asset, KHÔNG phải network.
- **TR-006**: Màn hình PHẢI hiển thị đúng trên các kích thước iPhone và Android phổ biến.
- **TR-007**: Màn hình PHẢI lock portrait orientation.
- **TR-008**: Status bar PHẢI hiển thị light content (text trắng) trên nền tối.
- **TR-009**: Supabase credentials (URL, Anon Key) PHẢI được lưu trong file `.env` sử dụng package `flutter_dotenv`. File `.env` PHẢI nằm trong `.gitignore`.

### Key Entities (nếu feature liên quan data)

- **User**: Thông tin người dùng sau đăng nhập (email, name, avatar từ Google profile)
- **AuthSession**: Session xác thực (access_token, refresh_token, expiry)
- **LanguagePreference**: Ngôn ngữ được chọn (locale code: vi, en)

---

## API Dependencies

| Endpoint | Method | Purpose | Status |
|----------|--------|---------|--------|
| Supabase Auth - Google OAuth | POST | Khởi tạo và xử lý Google OAuth flow | Built-in Supabase |
| Supabase Auth - Get Session | GET | Kiểm tra session hiện tại | Built-in Supabase |
| Supabase Auth - Refresh Token | POST | Làm mới token khi hết hạn | Built-in Supabase |

---

## State Management

### Local State (Widget)

- `isLoading`: Boolean — trạng thái đang xác thực (hiển thị spinner, disable button)
- `errorMessage`: String? — thông báo lỗi (null khi không có lỗi)

### Global State (Riverpod)

- `authProvider`: StateNotifierProvider — quản lý AuthSession (login, logout, check session)
- `localeProvider`: StateProvider<Locale> — quản lý ngôn ngữ đã chọn
- `userProvider`: FutureProvider — lấy thông tin user từ session

### Cache

- **AuthSession**: Lưu trữ secure (flutter_secure_storage hoặc Supabase built-in)
- **Locale**: SharedPreferences
- **Background image**: Asset bundle (không cache thêm)

---

## Success Criteria

### Measurable Outcomes

- **SC-001**: Người dùng có thể đăng nhập thành công trong < 3 taps (mở app → tap Login → chọn account).
- **SC-002**: Thời gian từ tap Login đến vào Home < 5 giây (không tính Google consent).
- **SC-003**: Tỷ lệ đăng nhập thành công > 95% (loại trừ lỗi mạng bên ngoài).
- **SC-004**: Chuyển đổi ngôn ngữ cập nhật UI trong < 500ms.

---

## Out of Scope

- Đăng nhập bằng phương thức khác (email/password, Apple ID, SSO)
- Đăng ký tài khoản mới
- Quên mật khẩu / reset password
- Xác thực hai yếu tố (2FA) ngoài Google OAuth
- Chế độ offline
- Deep linking đến màn hình Login

---

## Dependencies

- [x] Constitution document exists (`.momorph/constitution.md`)
- [ ] API specifications available (`.momorph/API.yml`) — Sử dụng Supabase built-in Auth
- [ ] Database design completed (`.momorph/database.sql`) — Supabase quản lý auth tables
- [x] Screen flow documented (`.momorph/SCREENFLOW.md`)

---

## Notes

- Supabase Auth đã built-in hỗ trợ Google OAuth — sử dụng `supabase_flutter` package.
- Thiết kế gốc dựa trên iPhone (375x812px) — cần responsive cho các thiết bị khác.
- Hình nền key visual và logo "ROOT FURTHER" là asset tĩnh, cần export từ Figma.
- Ngôn ngữ hỗ trợ: **VN, EN** (đã cập nhật — bỏ JA, chỉ 2 ngôn ngữ).
- Language selector sử dụng **PopupMenuButton** — menu hiển thị BÊN DƯỚI selector widget, không đè lên.
- Không giới hạn email domain — bất kỳ tài khoản Google nào cũng có thể đăng nhập.
- Font Montserrat: Load qua `google_fonts` package (cần kết nối mạng lần đầu, sau đó cache).
- Nút Login chỉ có 1 loại (Google) — không cần layout cho nhiều nút social login.
- **Supabase credentials**: Lưu trong `.env` file dùng `flutter_dotenv` — KHÔNG dùng `--dart-define`. File `.env` phải nằm trong `.gitignore`. Tạo `.env.example` cho team reference.
- **Packages cần bổ sung vào constitution**: `google_fonts`, `supabase_flutter`, `flutter_secure_storage`, `flutter_riverpod`, `go_router`, `flutter_dotenv`, `google_sign_in` — hiện chưa có trong danh sách approved packages.
