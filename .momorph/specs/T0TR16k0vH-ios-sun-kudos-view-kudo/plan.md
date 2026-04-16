# Kế hoạch triển khai: [iOS] Sun*Kudos — View Kudo (thường + ẩn danh)

**Frames**: `T0TR16k0vH` (View Kudo) + `5C2BL6GYXL` (View Kudo ẩn danh)
**Ngày**: 2026-04-15
**Specs**: `specs/T0TR16k0vH-ios-sun-kudos-view-kudo/spec.md`, `specs/5C2BL6GYXL-ios-sun-kudos-view-kudo-an-danh/spec.md`

---

## Tóm tắt

Triển khai màn hình chi tiết Kudos — 1 screen duy nhất phục vụ cả 2 variant (thường + ẩn danh), conditional rendering dựa trên flag `isAnonymous`. Pushed từ nút "Xem chi tiết" trên `KudosCard` (Kudos feed / All Kudos / Highlight Carousel). Hiển thị đầy đủ: sender/receiver info, tiêu đề, nội dung full text, hashtag, hình ảnh đính kèm, heart toggle, copy link. Variant ẩn danh ẩn thông tin thật của sender — thay bằng avatar mặc định + alias/text "Người gửi ẩn danh".

---

## Bối cảnh kỹ thuật

**Framework**: Flutter 3.41.3 / Dart ^3.11.1
**Phụ thuộc chính**: flutter_riverpod, go_router, supabase_flutter, freezed, google_fonts, flutter_svg, flutter_gen, slang
**Backend**: Supabase (PostgREST — direct table queries)
**Testing**: flutter_test + mocktail (TDD bắt buộc)
**State Management**: Riverpod — AsyncNotifier pattern (1 ViewModel per feature)

---

## Kiểm tra tuân thủ Constitution

| Yêu cầu | Quy tắc Constitution | Trạng thái |
|----------|----------------------|-----------|
| MVVM + Riverpod | Dùng chung `KudosViewModel` (không tạo ViewModel mới) — thêm method `getKudosById()` | ✅ Tuân thủ |
| Feature-based module | `lib/features/kudos/presentation/screens/kudo_detail_screen.dart` | ✅ Tuân thủ |
| Freezed models | Không cần model mới — reuse `Kudos`, `UserSummary` | ✅ Tuân thủ |
| Widget con = StatelessWidget | Screen dùng ConsumerWidget, widget con StatelessWidget | ✅ Tuân thủ |
| SVG icons, PNG images | Reuse icons hiện có (`ic_media`, `ic_heart`, `ic_link`, `ic_arrow_open`) + thêm `ic_back.svg` | ✅ Tuân thủ |
| flutter_gen (Assets.xxx) | Không hardcode path | ✅ Tuân thủ |
| i18n (slang) VN/EN | Thêm strings mới cho detail screen + ẩn danh | ✅ Tuân thủ |
| TDD | Viết test trước → implement → refactor | ✅ Tuân thủ |
| Repository pattern | `KudosRepository.getKudosDetail()` đã có sẵn | ✅ Tuân thủ |

**Vi phạm**: Không có.

---

## Quyết định kiến trúc

### Frontend

- **Màn hình**: `KudoDetailScreen` (ConsumerWidget) — nhận `kudosId` qua route parameter
- **Không tạo ViewModel mới**: Thêm method `getKudosById(String kudosId)` vào `KudosViewModel` để tìm kudos trong cache (`allKudos` + `highlightKudos`) hoặc fetch từ API nếu chưa có (deep link case)
- **Conditional rendering**: Dựa trên `kudos.isAnonymous` — ẩn sender info, thay avatar/tên, disable tap
- **Reuse components**:
  - `HeartButton` — toggle heart (đã có)
  - `KudosContentCard` — **KHÔNG** reuse trực tiếp vì detail screen hiển thị full text (không truncate) và ẩn nút "Xem chi tiết". Tạo variant mới hoặc thêm param `isDetailView` vào `KudosContentCard`
  - `_SenderReceiverRow` logic — extract thành public widget hoặc tạo widget mới `KudoDetailSenderReceiverWidget` cho detail layout (avatar lớn hơn, hiển thị đầy đủ hơn)
- **Copy link**: Reuse logic `Clipboard.setData` + snackbar từ `KudosContentCard`
- **Hình ảnh đính kèm**: Widget mới `KudoAttachedImagesWidget` — row thumbnails 32x32, border `#998C5F`, radius 8px
- **Navigation**: `context.push('/kudos/$kudosId')` → `KudoDetailScreen`

### Backend Integration

- **API đã có**: `KudosRepository.getKudosDetail(kudosId)` → `KudosRemoteDatasource.fetchKudosDetail(kudosId)` — query PostgREST trực tiếp
- **Heart toggle**: Reuse `KudosViewModel.toggleHeart(kudosId)` — optimistic update đã implement
- **Không cần API mới**: Tất cả endpoints đã tồn tại

### Tích hợp hiện tại

- **`KudosViewModel`** (`lib/features/kudos/presentation/viewmodels/kudos_viewmodel.dart`): Đã có `toggleHeart()`. Cần thêm method `getKudosById()` để lookup hoặc fetch
- **`KudosRepository`** (`lib/features/kudos/data/repositories/kudos_repository.dart`): Đã có `getKudosDetail(kudosId)` — line 50
- **`KudosRemoteDatasource`** (`lib/features/kudos/data/datasources/kudos_remote_datasource.dart`): Đã có `fetchKudosDetail(kudosId)` — line 115
- **`Kudos` model**: Đã có `isAnonymous`, `imageUrls`, `awardTitle`, `shareUrl` — đủ data cho detail screen
- **`UserSummary` model**: Đã có `heroTierUrl`, `department`, `badgeLevel`
- **`HeartButton`** (`lib/features/kudos/presentation/widgets/heart_button.dart`): Reuse trực tiếp
- **`KudosContentCard`** (`lib/features/kudos/presentation/widgets/kudos_content_card.dart`): Cần sửa — thêm `isDetailView` param để ẩn "Xem chi tiết" button + hiển thị full text (bỏ maxLines: 3)
- **Router** (`lib/app/router.dart`): Cần thêm route `/kudos/:kudosId` → `KudoDetailScreen`
- **i18n**: Cần thêm strings mới cho detail screen + variant ẩn danh
- **`KudosCard`** (`lib/features/kudos/presentation/widgets/kudos_card.dart`): Cần truyền `onViewDetail` callback khi sử dụng — navigate tới detail screen

### Quyết định: Không tạo ViewModel riêng

**Lý do**:
1. `KudosViewModel` đã quản lý danh sách `allKudos` + `highlightKudos` — khi mở detail từ feed, data đã có trong cache
2. `toggleHeart()` đã implement optimistic update cho cả `allKudos` và `highlightKudos` — khi heart trên detail screen, state tự đồng bộ ngược về feed
3. Chỉ cần thêm 1 method `getKudosById()` để handle deep link case (kudos chưa có trong cache)
4. Tạo ViewModel riêng sẽ vi phạm nguyên tắc "1 ViewModel per feature" của constitution

---

## Cấu trúc Project

### Tài liệu

```text
.momorph/specs/T0TR16k0vH-ios-sun-kudos-view-kudo/
├── spec.md              # Đặc tả tính năng ✅
├── design-style.md      # Đặc tả thiết kế ✅
├── plan.md              # File này ✅
└── tasks.md             # Phân chia task (bước tiếp theo)
```

### Source Code (ảnh hưởng)

```text
lib/
├── app/
│   └── router.dart                        # SỬA: thêm route /kudos/:kudosId
│
├── features/
│   └── kudos/
│       ├── data/
│       │   ├── models/                    # KHÔNG SỬA — reuse Kudos, UserSummary
│       │   ├── datasources/               # KHÔNG SỬA — fetchKudosDetail đã có
│       │   └── repositories/              # KHÔNG SỬA — getKudosDetail đã có
│       │
│       └── presentation/
│           ├── viewmodels/
│           │   └── kudos_viewmodel.dart   # SỬA: thêm getKudosById() method
│           ├── screens/
│           │   └── kudo_detail_screen.dart # MỚI: màn hình chi tiết kudos
│           └── widgets/
│               ├── kudos_content_card.dart # SỬA: thêm isDetailView param
│               ├── kudos_card.dart         # SỬA: wire onViewDetail → navigate
│               ├── kudo_detail_sender_receiver_widget.dart  # MỚI: sender/receiver row cho detail
│               └── kudo_attached_images_widget.dart         # MỚI: danh sách hình ảnh đính kèm
│
├── i18n/
│   ├── strings_vi.i18n.json               # SỬA: thêm kudos detail strings
│   └── strings_en.i18n.json               # SỬA: thêm kudos detail strings
│
└── gen/                                   # Auto-generated (flutter_gen)

assets/
├── icons/
│   └── ic_back.svg                        # MỚI (nếu chưa có — kiểm tra trước)
└── images/
    └── anonymous_avatar.png               # MỚI: avatar mặc định cho ẩn danh

test/
├── unit/
│   └── viewmodels/
│       └── kudos_viewmodel_test.dart      # SỬA: thêm tests cho getKudosById()
├── widget/
│   └── kudos/
│       ├── kudo_detail_screen_test.dart                   # MỚI
│       ├── kudo_detail_sender_receiver_widget_test.dart    # MỚI
│       ├── kudo_attached_images_widget_test.dart           # MỚI
│       └── kudos_content_card_test.dart                   # SỬA: thêm tests cho isDetailView
└── helpers/
    └── kudos_test_helpers.dart             # SỬA: thêm mock data detail + anonymous
```

### Dependencies mới

Không cần thêm package mới — tất cả đã có trong `pubspec.yaml`.

---

## Chiến lược triển khai

### Phase 0: Chuẩn bị Assets, i18n & Xác nhận Supabase Data

- Kiểm tra `ic_back.svg` trong `assets/icons/` — nếu chưa có, download từ Figma
- Thêm `anonymous_avatar.png` vào `assets/images/` — avatar mặc định riêng cho sender ẩn danh
- Chạy `dart run build_runner build` để generate flutter_gen assets

#### Xác nhận Supabase Mock Data

> **Quy tắc**: KHÔNG ĐƯỢC dùng `supabase db reset`. Nếu cần thêm data, chỉ APPEND vào `supabase/seed.sql` với `ON CONFLICT DO NOTHING`.
> Chạy seed: `psql -h localhost -p 54322 -U postgres -d postgres -f supabase/seed.sql`

- **Dữ liệu đã đủ** — KHÔNG cần thêm seed data mới:
  - Kudos ẩn danh đã tồn tại: ID 7 (sender 3→2), ID 28 (sender 8→3), ID 43 (sender 5→9) — cả 3 có `is_anonymous = true`
  - 48 kudos tổng cộng với đầy đủ hashtags, photos, users — đủ cho test happy path
  - Photos đã có trong `kudos_photos` table — đủ cho test `KudoAttachedImagesWidget`
- **Kiểm tra nhanh** (chạy 1 lần để verify):
  ```sql
  -- Verify kudos ẩn danh tồn tại
  SELECT id, sender_id, is_anonymous FROM kudos WHERE is_anonymous = true;
  -- Kết quả mong đợi: 3 rows (id: 7, 28, 43)
  ```

- Thêm i18n strings (VN + EN):

| Key | Tiếng Việt | English |
|-----|-----------|---------|
| `kudos.detailTitle` | `Kudo` | `Kudo` |
| `kudos.anonymousSender` | `Người gửi ẩn danh` | `Anonymous sender` |
| `kudos.kudosNotFound` | `Kudos không còn tồn tại` | `Kudo no longer exists` |
| `kudos.noContent` | `(Không có nội dung)` | `(No content)` |
| `kudos.goBack` | `Quay lại` | `Go back` |
| `kudos.networkError` | `Không thể kết nối. Vui lòng thử lại.` | `Cannot connect. Please try again.` |
| `kudos.heartError` | `Không thể thả heart. Vui lòng thử lại.` | `Cannot react. Please try again.` |
| `kudos.avatarAccessibility` | `Ảnh đại diện {name}` | `Avatar of {name}` |
| `kudos.anonymousAvatarAccessibility` | `Người gửi ẩn danh` | `Anonymous sender` |
| `kudos.attachedImageAccessibility` | `Ảnh đính kèm {index} trên {total}` | `Attached image {index} of {total}` |
| `kudos.deletedUser` | `Người dùng không tồn tại` | `User no longer exists` |

### Phase 1: Mở rộng Components hiện có (Data + ViewModel + KudosContentCard)

**Ưu tiên**: Sửa code hiện có trước khi tạo code mới.

1. **`KudosViewModel` — thêm `getKudosById()`**:
   - Tìm trong `allKudos` + `highlightKudos` trước (cache hit)
   - Nếu không tìm thấy → gọi `_repository.getKudosDetail(kudosId)` (deep link case)
   - Trả về `Kudos?` (nullable — null nếu 404)

2. **`KudosContentCard` — thêm `isDetailView` param**:
   - `isDetailView = false` (mặc định, backward-compatible)
   - Khi `isDetailView = true`:
     - Nội dung hiển thị full text (bỏ `maxLines: 3` + `TextOverflow.ellipsis`)
     - Ẩn nút "Xem chi tiết" (action bar chỉ có: Heart + Copy Link)
   - Widget test: verify `maxLines` null khi `isDetailView = true`, verify "Xem chi tiết" absent

3. **`Router` — thêm route**:
   ```dart
   GoRoute(
     path: '/kudos/:kudosId',
     builder: (context, state) => KudoDetailScreen(
       kudosId: state.pathParameters['kudosId']!,
     ),
   ),
   ```

### Phase 2: Tạo Widget mới cho Detail Screen

> **Nguyên tắc TDD**: Viết test trước cho mỗi widget.

1. **`KudoDetailSenderReceiverWidget`** (StatelessWidget):
   - Nhận `Kudos kudos` + `void Function(String userId)? onAvatarTap`
   - Layout: Row với sender (trái) → icon mũi tên → receiver (phải)
   - Avatar 24x24px, circle, border trắng
   - Hiển thị: tên, phòng ban, hero tier badge
   - **Variant ẩn danh** (`kudos.isAnonymous == true`):
     - Sender avatar: `Assets.images.anonymousAvatar` (thay cho ảnh thật)
     - Sender tên: `kudos.sender.name` (alias từ backend, hoặc fallback `t.kudos.anonymousSender`)
     - Sender phòng ban: `t.kudos.anonymousSender`
     - Sender badge: ẩn hoàn toàn (không hiển thị `heroTierUrl`)
     - Sender tap: disabled (onTap = null)
     - Sender avatar border: 1.869px (dày hơn thường: 0.865px)
   - **Variant thường**: Hiển thị thông tin thật, tap → profile
   - Receiver: Luôn hiển thị đầy đủ bất kể isAnonymous
   - Accessibility: Semantics labels theo spec

2. **`KudoAttachedImagesWidget`** (StatelessWidget):
   - Nhận `List<String> imageUrls`
   - Hiển thị row thumbnails 32x32px, border 0.447px solid `#998C5F`, radius 8px
   - Tối đa 5 ảnh
   - Nếu `imageUrls` rỗng → return `SizedBox.shrink()`
   - Bấm thumbnail → xem ảnh lớn (có thể dùng `showDialog` với `InteractiveViewer`)
   - Accessibility: "Ảnh đính kèm {index} trên {total}"

### Phase 3: Xây dựng KudoDetailScreen

1. **`KudoDetailScreen`** (ConsumerWidget):
   - Nhận `kudosId` qua constructor (từ route param)
   - Trong `build()`:
     - Gọi `ref.read(kudosViewModelProvider.notifier).getKudosById(kudosId)` trong `initState` (hoặc dùng `FutureBuilder`)
     - **Quyết định kiến trúc**: KHÔNG tạo `FutureProvider.family` riêng — thay vào đó, screen gọi trực tiếp `KudosViewModel.getKudosById()` và quản lý loading/error state local. Lý do: tránh tạo provider rời rạc vi phạm nguyên tắc "1 ViewModel per feature". Screen dùng `useState` (hooks) hoặc `StatefulWidget` local state cho loading/error/data, trong khi heart toggle vẫn đi qua `kudosViewModelProvider` để đồng bộ
   - **Layout** (dark bg `#00101A` + Key Visual bg):
     - `Scaffold` với `AppBar`:
       - Leading: nút back (`Assets.icons.icBack.svg`)
       - Title: `t.kudos.detailTitle` ("Kudo")
       - Background transparent + gradient overlay
     - `SingleChildScrollView` (scroll nếu nội dung dài):
       - Card container (bg: `#FFF8E1`, border: `#FFEA9E`, radius: 8px, width: 335px, centered)
         - `KudoDetailSenderReceiverWidget`
         - Divider (`#FFEA9E`)
         - Time text (format: "HH:mm - MM/DD/YYYY")
         - Tiêu đề (`awardTitle`) — bold, center, ẩn nếu null/empty
         - Nội dung full text trong khung (bg: `rgba(255,234,158,0.40)`, border: `#FFEA9E`, radius 5.5px)
         - `KudoAttachedImagesWidget`
         - Hashtag list (màu `#D4271D`)
         - Divider
         - Action bar: `HeartButton` + Copy Link (không có "Xem chi tiết")
   - **States**:
     - Loading: Shimmer placeholder (card shape)
     - Error (network): Message + retry button
     - Not Found (404): `t.kudos.kudosNotFound` + nút quay lại
     - Loaded: Hiển thị đầy đủ

2. **Wire navigation từ feed**:
   - Trong `KudosScreen` / `AllKudosSectionWidget` — truyền `onViewDetail: () => context.push('/kudos/${kudos.id}')` cho `KudosCard`
   - Trong `HighlightCarouselWidget` — tương tự

3. **Bottom Navigation Bar**: Spec đề cập Nav Bar (bottom tab) hiển thị trên detail screen với Kudos tab active. Route `/kudos/:kudosId` PHẢI nằm trong `ShellRoute` của bottom navigation (nếu có) để giữ tab bar visible. Nếu hiện tại dùng `context.push` (full-screen push), cần xác nhận thiết kế: tab bar ẩn hay hiện trên detail screen → quyết định dùng `push` vs nested navigation.

### Phase 4: Polish & Accessibility

1. **Accessibility**: Thêm `Semantics` widgets theo bảng VoiceOver trong spec:
   - Nút Back: "Quay lại"
   - Avatar sender/receiver: "Ảnh đại diện {tên}"
   - Avatar ẩn danh: "Người gửi ẩn danh" (trait: Image, không phải Button)
   - Tiêu đề: Header trait
   - Nội dung: StaticText
   - Heart: "{count} lượt thích. {Đã thích / Chưa thích}", toggle trait
   - Copy Link: "Sao chép liên kết", Button
   - Hình ảnh: "Ảnh đính kèm {index} trên {total}"

2. **Animation**:
   - Slide-in từ phải khi push (go_router default)
   - Heart toggle animation reuse từ `HeartButton` (scale spring)

3. **Edge cases**:
   - Nội dung trống → placeholder `t.kudos.noContent`
   - Tiêu đề trống → ẩn widget tiêu đề
   - Avatar không có → CircleAvatar với chữ cái đầu (logic đã có trong `_UserAvatar`)
   - 0 hình ảnh → ẩn `KudoAttachedImagesWidget`
   - Heart fail → rollback + snackbar lỗi (logic đã có trong `toggleHeart()`)
   - Copy link khi `shareUrl` rỗng → disabled
   - Sender tài khoản bị xóa (không phải ẩn danh) → avatar mặc định + "Người dùng không tồn tại" (khác với avatar ẩn danh) — logic check: `isAnonymous == false && sender.name == null/empty`

4. **Heart state sync**: Khi toggle heart trên detail screen → state thay đổi trong `KudosViewModel` → khi pop back, feed tự cập nhật vì cùng watch `kudosViewModelProvider`

---

## Đánh giá rủi ro

| Rủi ro | Xác suất | Ảnh hưởng | Giảm thiểu |
|--------|----------|-----------|-----------|
| Deep link kudos chưa có trong cache | Thấp | Thấp | `getKudosById()` fallback fetch API |
| Sửa `KudosContentCard` ảnh hưởng feed hiện tại | Trung bình | Trung bình | `isDetailView` default `false` → backward-compatible. Widget test verify cả 2 mode |
| Avatar ẩn danh chưa có asset | Thấp | Thấp | Phase 0 download trước. Fallback: CircleAvatar với icon |
| Heart state desync giữa detail và feed | Thấp | Trung bình | Dùng chung `KudosViewModel` → state tự đồng bộ |
| Bottom nav bar hiện/ẩn trên detail screen | Trung bình | Thấp | Xác nhận với thiết kế trước Phase 3. Nếu hiện → dùng nested route trong ShellRoute; nếu ẩn → dùng `context.push` (default) |

### Độ phức tạp ước tính

- **Frontend**: **Trung bình** (1 screen mới + 2 widgets mới + sửa 3 files hiện có)
- **Backend**: **Không có** (tất cả API đã tồn tại)
- **Testing**: **Trung bình** (ViewModel method mới + Screen + 2 Widget tests)

---

## Chiến lược kiểm thử tích hợp

### Phạm vi kiểm thử

- [x] **Tương tác component/module**: ViewModel `getKudosById()` → Repository → Datasource
- [x] **Luồng người dùng**: Feed → "Xem chi tiết" → Detail screen → Heart → Pop back → Feed updated
- [x] **Conditional rendering**: `isAnonymous = true` → sender info ẩn
- [x] **Edge cases**: 404, network error, empty content, empty images

### Phân loại kiểm thử

| Loại | Áp dụng? | Kịch bản chính |
|------|----------|----------------|
| Unit (ViewModel) | Có | `getKudosById()` — cache hit, cache miss + API call, 404 |
| Unit (Widget) | Có | `KudoDetailSenderReceiverWidget` — thường vs ẩn danh |
| Unit (Widget) | Có | `KudoAttachedImagesWidget` — có ảnh, không ảnh, max 5 |
| Unit (Widget) | Có | `KudosContentCard` — `isDetailView` true vs false |
| Widget (Screen) | Có | `KudoDetailScreen` — loading, loaded, error, 404, anonymous variant |
| Integration | Có | Navigate feed → detail → heart → pop back |

### Chiến lược Mock

| Loại dependency | Chiến lược | Lý do |
|-----------------|-----------|-------|
| KudosViewModel | Riverpod override | Widget test screen không cần real API |
| KudosRepository | Mock (mocktail) | Unit test ViewModel `getKudosById()` |
| Clipboard | Mock | Widget test copy link |
| go_router | Mock | Widget test navigation (back, push) |

### Kịch bản kiểm thử

1. **Happy Path**
   - [x] Mở detail từ feed (cache hit) → hiển thị đầy đủ thông tin
   - [x] Mở detail kudos ẩn danh → sender info ẩn, avatar mặc định, tap disabled
   - [x] Bấm heart → count thay đổi, icon thay đổi
   - [x] Bấm copy link → clipboard + snackbar 2 giây
   - [x] Bấm back → quay lại feed, heart state đồng bộ
   - [x] Nội dung dài → scroll trong content frame

2. **Error Handling**
   - [x] KudosId không tồn tại (404) → "Kudos không còn tồn tại" + nút quay lại
   - [x] Network error khi load → thông báo lỗi + retry
   - [x] Heart fail → rollback + snackbar lỗi

3. **Edge Cases**
   - [x] Nội dung trống → placeholder "(Không có nội dung)"
   - [x] Tiêu đề trống → ẩn widget tiêu đề
   - [x] 0 hình ảnh → ẩn danh sách ảnh
   - [x] `shareUrl` rỗng → copy link disabled
   - [x] `isAnonymous = true` + `sender.name` rỗng → fallback "Người gửi ẩn danh"
   - [x] `isAnonymous = false` + sender tài khoản bị xóa → "Người dùng không tồn tại" (avatar mặc định khác ẩn danh)
   - [x] Avatar không có → fallback chữ cái đầu

### Mục tiêu Coverage

| Khu vực | Mục tiêu | Ưu tiên |
|---------|---------|---------|
| ViewModel (`getKudosById`) | 90%+ | Cao |
| KudoDetailScreen | 80%+ | Cao |
| KudoDetailSenderReceiverWidget | 90%+ | Cao (logic ẩn danh) |
| KudoAttachedImagesWidget | 85%+ | Trung bình |
| KudosContentCard (isDetailView) | 85%+ | Trung bình |

---

## Phụ thuộc & Điều kiện tiên quyết

### Yêu cầu trước khi bắt đầu

- [x] `constitution.md` đã review
- [x] `spec.md` View Kudo đã review
- [x] `spec.md` View Kudo ẩn danh đã review
- [x] `design-style.md` đã review
- [x] Kudos feature đã triển khai (feed, highlight, cards, ViewModel, Repository, Datasource)
- [x] `KudosRepository.getKudosDetail()` đã implement
- [x] `KudosRemoteDatasource.fetchKudosDetail()` đã implement
- [ ] Asset `anonymous_avatar.png` cần download từ Figma
- [ ] Asset `ic_back.svg` cần kiểm tra/download

### Phụ thuộc bên ngoài

- Không có phụ thuộc bên ngoài mới — tất cả API và data layer đã sẵn sàng

---

## Ghi chú

- View Kudo và View Kudo ẩn danh là 2 variant của CÙNG 1 screen — KHÔNG tạo 2 screen riêng
- Logic ẩn thông tin sender PHẢI nằm trong widget (conditional rendering dựa trên `isAnonymous`) — không cần xử lý ở ViewModel vì data đã có flag
- Nút "Xem chi tiết" trên action bar PHẢI bị ẩn khi đang ở detail screen (FR-008) — xử lý qua `isDetailView` param
- Heart state đồng bộ tự động giữa detail và feed nhờ dùng chung `KudosViewModel`
- Field `senderAlias` chưa có trong model `Kudos` hiện tại — backend cung cấp alias qua `sender.name` khi `isAnonymous = true`. Nếu `sender.name` rỗng → fallback `t.kudos.anonymousSender`
- Tất cả `.md` đều viết bằng tiếng Việt theo yêu cầu project
