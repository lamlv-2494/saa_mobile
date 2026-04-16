# Đặc tả tính năng: [iOS] Profile bản thân

**Frame ID**: `hSH7L8doXB`
**Frame Name**: `[iOS] Profile bản thân`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-16
**Trạng thái**: Draft

---

## Tổng quan

Màn hình **Profile bản thân** là tab Profile (tab 4) trong bottom navigation của ứng dụng Sun* Annual Awards 2025. Đây là nơi người dùng đã đăng nhập xem toàn bộ thông tin cá nhân: avatar, tên, mã team, danh hiệu hero tier, bộ sưu tập icon, thống kê hoạt động Kudos (số đã nhận, đã gửi, hearts, secret box), và danh sách lịch sử Kudos với bộ lọc dropdown.

Điểm khác biệt chính so với **Profile người khác** (`bEpdheM0yU`):
- **Có** Statistics Container (panel tối với 5 chỉ số)
- **Có** nút "Mở Secret Box" (disabled nếu chưa có secret box nào)
- **Không có** nút "Gửi lời cảm ơn" — người dùng không tự gửi kudos cho mình
- Bottom nav: tab Profile đang **active** (khác với Profile người khác không có tab active)
- Route: điều hướng qua **tab navigation**, không phải push

**Đối tượng sử dụng**: Sunner (nhân viên Sun*) đã đăng nhập — xem thông tin cá nhân của chính mình.

**Bối cảnh kinh doanh**: Cho phép người dùng theo dõi thành tích cá nhân (kudos nhận/gửi, hearts, icon collection) và mở Secret Box — cơ chế gamification thúc đẩy tương tác trong sự kiện SAA 2025.

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 — Xem thông tin profile cá nhân (Ưu tiên: P1)

Là một Sunner, tôi muốn xem thông tin cá nhân (avatar, tên, mã team, danh hiệu) để biết thông tin của mình được hiển thị như thế nào.

**Lý do ưu tiên**: Đây là nội dung cốt lõi đầu tiên hiển thị khi mở tab Profile.

**Kiểm thử độc lập**: Render `ProfileInfoWidget` với dữ liệu mock — verify avatar, tên, team, hero tier image hiển thị đúng.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng tap tab "Profile", **Khi** màn hình load xong, **Thì** hiển thị avatar tròn 72px, tên đầy đủ (Montserrat 18px Bold, màu vàng #FFEA9E), mã team (Montserrat 14px Regular, trắng), và hình ảnh danh hiệu hero tier (PNG local).
2. **Cho biết** người dùng chưa có avatar, **Khi** hiển thị, **Thì** hiển thị placeholder với chữ cái đầu của tên trên nền gradient.
3. **Cho biết** `heroTier = 'none'` hoặc asset không tìm thấy, **Khi** hiển thị, **Thì** ẩn hoàn toàn hình danh hiệu (`SizedBox.shrink()`).

---

### User Story 2 — Xem bộ sưu tập icon (Ưu tiên: P2)

Là một Sunner, tôi muốn xem bộ sưu tập icon/badge mà mình đã nhận được để theo dõi thành tích gamification.

**Lý do ưu tiên**: Tính năng gamification bổ sung — quan trọng nhưng không phải core flow.

**Kiểm thử độc lập**: Render `BadgeCollectionWidget` (hay `IconCollectionSection`) với danh sách badges mock — verify hiển thị/ẩn.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng có ít nhất 1 icon badge, **Khi** hiển thị, **Thì** section "Bộ sưu tập icon của tôi" xuất hiện với hàng ngang các icon badge tròn 32×32px, gap 14px giữa các badges.
2. **Cho biết** `badges.isEmpty`, **Khi** hiển thị, **Thì** toàn bộ section icon collection bị **ẩn hoàn toàn** (không hiển thị placeholder hay empty state).
3. **Cho biết** có nhiều hơn 6 badges, **Khi** hiển thị, **Thì** hàng icon có thể scroll ngang hoặc xuống dòng theo thiết kế.

---

### User Story 3 — Xem thống kê hoạt động cá nhân (Ưu tiên: P1)

Là một Sunner, tôi muốn xem thống kê Kudos và Secret Box của mình để theo dõi mức độ tham gia trong sự kiện.

**Lý do ưu tiên**: Statistics Container là phần độc quyền của Profile bản thân — không có trên Profile người khác.

**Kiểm thử độc lập**: Render `PersonalStatsCard` với dữ liệu mock — verify 5 stat rows và nút CTA hiển thị đúng.

**Kịch bản chấp nhận**:

1. **Cho biết** dữ liệu thống kê đã load, **Khi** hiển thị, **Thì** Statistics Container hiển thị đủ 5 chỉ số: Kudos nhận, Kudos gửi, Hearts nhận, Secret Box đã mở, Secret Box chưa mở — với giá trị màu `#FFEA9E` (vàng).
2. **Cho biết** có đường kẻ phân cách, **Khi** hiển thị, **Thì** divider `#2E3940` xuất hiện giữa nhóm Kudos/Hearts và nhóm Secret Box.
3. **Cho biết** `secretBoxUnopened > 0`, **Khi** hiển thị nút "Mở Secret Box", **Thì** nút ở trạng thái **enabled**, có thể tap.
4. **Cho biết** `secretBoxUnopened == 0`, **Khi** hiển thị nút "Mở Secret Box", **Thì** nút ở trạng thái **disabled** (mờ, không tương tác được).

---

### User Story 4 — Mở Secret Box (Ưu tiên: P2)

Là một Sunner, tôi muốn mở Secret Box mình chưa mở để nhận phần thưởng bí ẩn.

**Lý do ưu tiên**: Tính năng quan trọng thúc đẩy engagement nhưng phụ thuộc vào US3.

**Kiểm thử độc lập**: Tap nút CTA với `secretBoxUnopened > 0` — verify điều hướng đến Open Secret Box screen.

**Kịch bản chấp nhận**:

1. **Cho biết** `secretBoxUnopened > 0`, **Khi** người dùng tap nút "Mở Secret Box", **Thì** điều hướng sang màn hình Open Secret Box (`kQk65hSYF2`).
2. **Cho biết** `secretBoxUnopened == 0`, **Khi** người dùng tap nút (disabled), **Thì** không có phản ứng / không điều hướng.
3. **Cho biết** sau khi mở xong secret box, **Khi** quay lại Profile, **Thì** dữ liệu thống kê **không tự động cập nhật** — chỉ cập nhật khi pull-to-refresh hoặc lần load tiếp theo.

---

### User Story 5 — Xem danh sách Kudos theo filter (Ưu tiên: P1)

Là một Sunner, tôi muốn xem danh sách Kudos mình đã gửi hoặc đã nhận, có thể chuyển đổi qua dropdown filter.

**Lý do ưu tiên**: Danh sách Kudos là nội dung chính chiếm phần lớn màn hình.

**Kiểm thử độc lập**: Render Kudos section với filter dropdown và danh sách mock cards.

**Kịch bản chấp nhận**:

1. **Cho biết** màn hình mở lần đầu, **Khi** load xong, **Thì** dropdown filter mặc định là "Đã gửi (N)", danh sách hiển thị Kudos mình đã gửi.
2. **Cho biết** dropdown filter, **Khi** tap, **Thì** overlay xuất hiện phía dưới filter button (vị trí khớp Figma) với 2 lựa chọn: "Đã nhận (N)" và "Đã gửi (N)" — N là số lượng tương ứng. Option **đang được chọn** hiển thị nền `rgba(255,234,158,0.10)`, option còn lại không có nền đặc biệt.
3. **Cho biết** chọn filter "Đã nhận", **Khi** chọn, **Thì** overlay đóng lại, danh sách cập nhật hiển thị Kudos mình đã nhận, label dropdown đổi thành "Đã nhận (N)".
4. **Cho biết** filter không có kết quả, **Khi** hiển thị, **Thì** hiện empty state phù hợp (text "Chưa có Kudos nào.").

---

### User Story 6 — Tương tác với Kudos card (Ưu tiên: P2)

Là một Sunner, tôi muốn tương tác với các Kudos card trên profile (xem chi tiết, copy link, thả heart).

**Lý do ưu tiên**: Tương tác bổ sung tăng trải nghiệm, không phải chức năng cốt lõi của Profile.

**Kiểm thử độc lập**: Test từng action riêng lẻ trên KudosCard mock.

**Kịch bản chấp nhận**:

1. **Cho biết** Kudos card hiển thị, **Khi** tap "Xem chi tiết", **Thì** điều hướng sang màn hình View Kudo (`T0TR16k0vH` hoặc `5C2BL6GYXL`).
2. **Cho biết** Kudos card hiển thị, **Khi** tap "Copy Link", **Thì** sao chép link vào clipboard và hiển thị toast xác nhận.
3. **Cho biết** Kudos card hiển thị, **Khi** tap icon heart, **Thì** toggle trạng thái heart (like/unlike) và cập nhật heart count (optimistic update).
4. **Cho biết** Kudos card hiển thị, **Khi** tap avatar người gửi/nhận, **Thì** điều hướng push sang Profile người khác (`bEpdheM0yU`).

---

### User Story 7 — Tải thêm Kudos (Infinite Scroll) (Ưu tiên: P2)

Là một Sunner, tôi muốn tải thêm Kudos khi cuộn đến cuối danh sách để xem toàn bộ lịch sử.

**Lý do ưu tiên**: Pagination cần thiết cho danh sách lớn, không phải core display.

**Kiểm thử độc lập**: Scroll đến cuối list và verify API call trang tiếp theo.

**Kịch bản chấp nhận**:

1. **Cho biết** `hasMoreKudos = true`, **Khi** người dùng cuộn đến 80% cuối danh sách, **Thì** tự động gọi API load trang tiếp theo và append vào danh sách hiện tại.
2. **Cho biết** đang tải thêm, **Khi** loading, **Thì** hiển thị `CircularProgressIndicator` ở cuối danh sách.
3. **Cho biết** `hasMoreKudos = false`, **Khi** cuộn đến cuối, **Thì** không gọi API thêm, ẩn loading indicator.

---

### User Story 8 — Pull-to-refresh (Ưu tiên: P2)

Là một Sunner, tôi muốn kéo xuống để làm mới toàn bộ dữ liệu profile.

**Lý do ưu tiên**: Thao tác cơ bản để cập nhật dữ liệu.

**Kiểm thử độc lập**: Pull-to-refresh và verify `ProfileViewModel.refresh()` được gọi.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng đang ở màn hình Profile bản thân, **Khi** kéo xuống (pull-to-refresh), **Thì** reload toàn bộ: thông tin cá nhân, badge collection, thống kê, và danh sách Kudos.
2. **Cho biết** refresh thành công, **Khi** hoàn tất, **Thì** hiển thị dữ liệu mới nhất.
3. **Cho biết** refresh thất bại (mất mạng), **Khi** lỗi xảy ra, **Thì** hiển thị thông báo lỗi và giữ dữ liệu cũ.

---

### Trường hợp biên (Edge Cases)

- Mất kết nối mạng khi load profile → Hiển thị thông báo lỗi và nút retry.
- Avatar không load được → Hiển thị placeholder chữ cái đầu tên.
- `badges.isEmpty` → Ẩn hoàn toàn section "Bộ sưu tập icon của tôi".
- `secretBoxUnopened == 0` → Nút "Mở Secret Box" disabled.
- Danh sách Kudos rỗng theo filter hiện tại → Hiển thị empty state.
- Kudos card có nội dung quá dài → Truncate với "..." và nút "Xem chi tiết".
- Tap vào avatar trên Kudos card → Điều hướng push sang Profile người khác, không phải Profile bản thân.
- Deep link `/profile` khi chưa đăng nhập → Redirect sang màn hình Login (`8HGlvYGJWq`).
- `OtherProfileScreen` phát hiện `userId == currentUserId` → Set `currentTabIndexProvider = 3` + `context.pop()` để tự redirect về Profile bản thân.
- Heart action thất bại (API lỗi) → Rollback optimistic update, hiển thị thông báo lỗi.
- Sau khi mở Secret Box và quay lại Profile → thống kê **không tự cập nhật**; cần pull-to-refresh để thấy số mới.

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

| Thành phần | Mô tả | Tương tác |
|-----------|-------|-----------|
| 1. App Header (`6885:10338`) | Logo SAA 2025 + cờ VN + icon Search + icon Bell | Tap Search → màn hình tìm kiếm; Tap Bell → popup thông báo |
| 1.1. Profile Info Container (`6885:10339`) | Avatar tròn 72px, tên đầy đủ, mã team, hình danh hiệu hero tier PNG; column với gap 24px | Chỉ hiển thị |
| A.2. User Name & Badge (`6885:10341`) | Nhóm xếp dọc: tên (Montserrat 18px Bold, #FFEA9E) + row[team code 14px/400/trắng · dot · hero tier image PNG] | Chỉ hiển thị |
| 2. Icon Collection Section (`6885:10349`) | Nhãn "Bộ sưu tập icon của tôi" (12px Regular, trắng) + hàng icon badge 32×32px tròn; ẩn nếu rỗng | Chỉ hiển thị |
| B2. Icon Badge Slot (`6885:10351`) | Icon badge đơn lẻ (32×32px, tròn, nền tối `#1A1A2E`, gap 14px giữa badges) | **Không có tương tác** — display only |
| A.3. Icon Collection Label (`6885:10357`) | Label "Bộ sưu tập icon của tôi" (Montserrat 12px Regular, trắng) | Chỉ hiển thị |
| 3. Statistics Container (`6885:10358`) | Panel tối `#00070C`, 5 stat rows + divider + nút "Mở Secret Box" | Chỉ hiển thị stats; nút CTA có thể tap |
| D.1.2. Kudos Received (`6885:10360`) | "Số Kudos bạn nhận được" + giá trị vàng | Chỉ hiển thị |
| D.1.3. Kudos Sent (`6885:10365`) | "Số Kudos bạn đã gửi" + giá trị vàng | Chỉ hiển thị |
| D.1.4. Hearts Received (`6885:10370`) | "Số tim bạn nhận được" + giá trị vàng | Chỉ hiển thị |
| D.1.5. Content Divider (`6885:10375`) | Đường kẻ phân cách ngang `#2E3940` giữa 2 nhóm thống kê | Chỉ hiển thị |
| D.1.6. Secret Box Opened (`6885:10376`) | "Số Secret Box bạn đã mở" + giá trị vàng | Chỉ hiển thị |
| D.1.7. Secret Box Unopened (`6885:10381`) | "Số Secret Box chưa mở" + giá trị vàng | Chỉ hiển thị; điều khiển trạng thái nút CTA |
| Button "Mở Secret Box" (`6885:10386`) | Nút CTA PRIMARY (bg: solid `#FFEA9E`, text tối `#00101A`); disabled khi unopened=0 (opacity 0.4) | Tap → `/secret-box`; disabled nếu unopened=0 |
| 4. Kudos Section Header (`6885:10387`) | Banner với subtitle "Sun* Annual Awards 2025" (12px) + title "KUDOS" (22px vàng) | Chỉ hiển thị |
| Dropdown Filter (`6885:10388`) | "Đã gửi (N)" / "Đã nhận (N)" — bg primary-10, border vàng | Tap → overlay dropdown |
| A. Dropdown Overlay (`6891:17101`) | Overlay 2 lựa chọn (pill buttons) | Tap option → đóng overlay, cập nhật filter |
| 5. Kudos List (`6885:10389`) | Danh sách KudosCard cuộn vô hạn theo filter | Scroll dọc, infinite scroll |
| 5.x. KUDO - Highlight (`6885:10390-10392`) | Kudos card highlight (bg `#FFF8E1`, border vàng) — reusable component | Xem chi tiết, Copy Link, Heart toggle, Tap avatar |
| D.3.1. Status Label (`6885:10393`) | Nhãn trạng thái màu cam (pill) — ví dụ: "spam" | Chỉ hiển thị |
| 6. Bottom Navigation Bar (`6885:10394`) | 4 tab: SAA 2025, Awards, Kudos, Profile (active = vàng) | Tap tab → điều hướng |

### Luồng điều hướng

- **Từ**: Bottom tab "Profile" từ bất kỳ màn hình nào có bottom nav
- **Từ**: Self-redirect từ `OtherProfileScreen` khi `userId == currentUserId`
- **Từ**: Deep link `/profile`
- **Đến**:
  - Màn hình tìm kiếm (`3jgwke3E8O`) — tap icon Search
  - Popup thông báo (`_b68CBWKl5`) — tap icon Bell
  - Open Secret Box (`kQk65hSYF2`) — tap nút "Mở Secret Box"
  - View Kudo (`T0TR16k0vH` / `5C2BL6GYXL`) — tap "Xem chi tiết" trên card
  - Profile người khác (`bEpdheM0yU`) — tap avatar trên KudosCard
  - Home (`OuH1BUTYT0`) — tap tab SAA 2025
  - Award_Top talent (`c-QM3_zjkG`) — tap tab Awards
  - Sun*Kudos (`fO0Kt19sZZ`) — tap tab Kudos

### Cấu trúc màn hình (Scroll Architecture)

```
ProfileScreen (ConsumerStatefulWidget)
└── RefreshIndicator
    └── CustomScrollView
        ├── SliverAppBar (transparent, padding đầu)
        └── SliverToBoxAdapter
            ├── ProfileInfoWidget
            ├── BadgeCollectionWidget (conditional — ẩn nếu rỗng)
            ├── PersonalStatsCard
            ├── KudosSectionHeaderWidget (Stack + background image)
            ├── ProfileKudosFilterDropdown
            └── ProfileKudosListWidget (+ CircularProgressIndicator cuối list)
```

### Yêu cầu hình ảnh

- Ứng dụng chỉ dành cho mobile (iOS) — width: 375px
- Animations/Transitions: Dropdown overlay open/close (200ms ease-out), heart toggle (150ms ease-in-out), pull-to-refresh (system default)

### Accessibility (VoiceOver)

| Thành phần | Semantic Label | Trait |
|-----------|---------------|-------|
| Avatar | "Ảnh đại diện của {tên}" | Image |
| Badge danh hiệu | "{danh hiệu}" | Image |
| Icon badge slot | "Icon {tên icon}" | Image |
| Nút "Mở Secret Box" | "Mở Secret Box. {N} hộp chưa mở." | Button |
| Nút "Mở Secret Box" (disabled) | "Mở Secret Box. Tất cả đã mở." | Button, disabled |
| Dropdown Filter | "Lọc Kudos. {giá trị hiện tại}" | Button |
| Heart icon | "{count} lượt thích. {Đã thích / Chưa thích}" | Button, toggle |
| Copy Link | "Sao chép liên kết" | Button |
| "Xem chi tiết" | "Xem chi tiết Kudos" | Link |
| Nav Bar tabs | "{Tab name}. Tab {index} trên 4" | Tab |
| Icon Search | "Tìm kiếm" | Button |
| Icon Bell | "Thông báo" | Button |

> Chi tiết visual specs xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Hệ thống PHẢI hiển thị thông tin profile người dùng hiện tại: avatar, tên đầy đủ, mã team, hình danh hiệu hero tier.
- **FR-002**: Hệ thống PHẢI hiển thị section "Bộ sưu tập icon" nếu `badges.isNotEmpty`; ẩn hoàn toàn nếu rỗng. Icon badge **không có tương tác** — display only.
- **FR-003**: Hệ thống PHẢI hiển thị Statistics Container với 5 chỉ số: Kudos nhận, Kudos gửi, Hearts nhận, Secret Box đã mở, Secret Box chưa mở.
- **FR-004**: Nút "Mở Secret Box" PHẢI ở trạng thái enabled (bg solid `#FFEA9E`, text `#00101A`) khi `secretBoxUnopened > 0` và disabled (opacity 0.4, không tương tác) khi `secretBoxUnopened == 0`.
- **FR-005**: Tap nút "Mở Secret Box" (enabled) PHẢI điều hướng đến màn hình Open Secret Box (`kQk65hSYF2`).
- **FR-006**: Hệ thống PHẢI hiển thị Kudos Section Header với banner trang trí và tiêu đề "KUDOS".
- **FR-007**: Hệ thống PHẢI hỗ trợ dropdown filter để chuyển đổi giữa "Đã gửi" và "Đã nhận" — cập nhật số lượng (N) trong label.
- **FR-008**: Filter mặc định khi mở màn hình là `KudosFilterType.sent` (Đã gửi).
- **FR-009**: Hệ thống PHẢI hiển thị danh sách KudosCard với đầy đủ thông tin: sender, receiver, nội dung, hashtag, thời gian, heart count, actions.
- **FR-010**: Người dùng PHẢI có thể tương tác với KudosCard: heart toggle, copy link, xem chi tiết.
- **FR-011**: Hệ thống PHẢI hỗ trợ infinite scroll (pagination) — load thêm khi scroll đến 80% cuối danh sách.
- **FR-012**: Hệ thống PHẢI hỗ trợ pull-to-refresh để reload toàn bộ dữ liệu profile.
- **FR-013**: Hệ thống PHẢI hỗ trợ đa ngôn ngữ (VN/EN) cho tất cả text hiển thị qua i18n (slang).
- **FR-014**: `OtherProfileScreen` phát hiện `userId == currentUserId` PHẢI redirect sang Profile bản thân (set tab index = 3 + pop).
- **FR-015**: Hệ thống PHẢI ẩn/hiện hình danh hiệu hero tier đúng theo giá trị `heroTier` slug — ẩn nếu `'none'` hoặc asset không tồn tại.

### Yêu cầu kỹ thuật

- **TR-001**: Kiến trúc PHẢI tuân theo MVVM pattern với 1 ViewModel: `ProfileViewModel extends AsyncNotifier<ProfileState>` — không nhận tham số.
- **TR-002**: Asset paths PHẢI sử dụng `flutter_gen` (`Assets.xxx`), không hardcode string.
- **TR-003**: Icons PHẢI sử dụng format SVG và render qua `flutter_svg`.
- **TR-004**: Text PHẢI sử dụng i18n (slang), không hardcode string.
- **TR-005**: Model PHẢI sử dụng freezed cho immutability và json_serializable cho serialization.
- **TR-006**: Widget con PHẢI là `StatelessWidget`, nhận data qua constructor — không dùng `ConsumerWidget` trừ trường hợp đặc biệt có justification rõ ràng.
- **TR-007**: Mỗi widget không được vượt quá ~80 dòng trong `build()` — phải tách widget con nếu vượt quá.
- **TR-008**: Hero tier image PHẢI render qua `AssetMapper.heroTierImage(heroTier)` — `heroTier` là slug string, không phải URL.
- **TR-009**: Heart action PHẢI dùng optimistic update — cập nhật UI ngay lập tức, rollback nếu API thất bại.
- **TR-010**: Dữ liệu PHẢI được cache trong ViewModel state (Riverpod tự quản lý lifecycle).
- **TR-011**: `flutter analyze` PHẢI pass với 0 warnings trước khi commit.

### Thực thể chính

- **UserProfile**: `id`, `name`, `avatar`, `team`, `heroTier` (slug string: `'legend_hero'`, `'rising_hero'`, `'super_hero'`, `'new_hero'`, `'none'`)
- **Badge**: `id`, `name`, `imageUrl`, `type`
- **Kudos**: `id`, `senderId`, `senderName`, `senderAvatar`, `receiverId`, `receiverName`, `receiverAvatar`, `content`, `hashtags`, `heartCount`, `isHearted`, `createdAt`, `awardCategory`, `isAnonymous`
- **UserStats**: `kudosSentCount`, `kudosReceivedCount`, `heartsCount`, `secretBoxOpened`, `secretBoxUnopened`

---

## Quản lý trạng thái (State Management)

### State Model (ProfileState — freezed)

```
ProfileState:
  - userProfile: UserProfile              # Thông tin người dùng
  - badgeCollection: List<Badge>          # Bộ sưu tập icon/badge
  - userStats: UserStats                  # Thống kê cá nhân (gồm kudosSentCount, kudosReceivedCount, heartsCount, secretBoxOpened, secretBoxUnopened)
  - kudosList: List<Kudos>                # Danh sách Kudos (theo filter)
  - kudosFilter: KudosFilterType          # Enum: received | sent
  - hasMoreKudos: bool                    # Còn Kudos để load thêm
  - currentPage: int                      # Trang hiện tại (pagination)
```

> **Ghi chú**: Label dropdown "Đã gửi (N)" / "Đã nhận (N)" lấy N trực tiếp từ `userStats.kudosSentCount` và `userStats.kudosReceivedCount` — không cần field riêng ở top-level `ProfileState`.

### ViewModel

```
ProfileViewModel extends AsyncNotifier<ProfileState>
  - build() → load profile, badges, stats, kudos list (filter: sent, page 1)
  - changeFilter(KudosFilterType) → reset page 1, reload kudos list
  - loadMoreKudos() → load trang tiếp theo, append vào list
  - toggleHeart(String kudosId) → optimistic update heart count
  - refresh() → re-fetch toàn bộ dữ liệu
```

### Local State (không thuộc ViewModel)

- **Dropdown open state**: Quản lý trạng thái đóng/mở của dropdown overlay.
- **Scroll controller**: `ScrollController` — quản lý infinite scroll cho Kudos list.

### Trạng thái Loading/Error

| Section | Loading | Error | Empty |
|---------|---------|-------|-------|
| Toàn màn hình | `CircularProgressIndicator` toàn màn | Text lỗi + nút Retry | N/A |
| Kudos List | Shimmer placeholder (3 cards) | Text lỗi + nút Retry | "Chưa có Kudos nào." |
| Load more (infinite scroll) | `CircularProgressIndicator` cuối list | Ẩn indicator | N/A |

### Cache

- Dữ liệu PHẢI được cache trong ViewModel state (Riverpod tự quản lý lifecycle).
- Pull-to-refresh gọi `refresh()` → re-fetch toàn bộ.
- Heart action dùng optimistic update → rollback nếu API thất bại.

---

## Phụ thuộc API

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|----------|------------|
| `/api/v1/users/me/profile` | GET | Lấy thông tin profile người dùng hiện tại | Dự đoán |
| `/api/v1/users/me/badges` | GET | Lấy bộ sưu tập icon/badge | Dự đoán |
| `/api/v1/users/me/stats` | GET | Lấy thống kê cá nhân (kudos, hearts, secret box) | Dự đoán |
| `/api/v1/users/me/kudos?filter={sent\|received}&page={N}` | GET | Lấy danh sách Kudos theo filter và pagination | Dự đoán |
| `/api/v1/kudos/{id}/heart` | POST | Thả/bỏ heart cho Kudos | Dự đoán |

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: Profile bản thân load trong vòng 2 giây (từ lúc tap tab đến khi hiển thị data).
- **SC-002**: Tỷ lệ người dùng tap "Mở Secret Box" >= 30% khi `secretBoxUnopened > 0`.
- **SC-003**: Hỗ trợ hiển thị đúng cả 2 ngôn ngữ VN và EN.
- **SC-004**: Tất cả icons sử dụng SVG format, asset paths sử dụng flutter_gen.
- **SC-005**: `flutter analyze` pass với 0 warnings.
- **SC-006**: Unit test cover `ProfileViewModel` và `ProfileRepository` đạt ≥ 80% coverage.

---

## Ngoài phạm vi

- Chỉnh sửa thông tin profile (tên, avatar, team) — chức năng edit profile riêng.
- Xem thống kê cá nhân của người khác — chỉ hiển thị trên Profile bản thân.
- Block/report người dùng.
- Nhắn tin/chat trực tiếp.
- Xem danh sách followers/following.
- Gửi Kudos cho chính mình — không có nút CTA "Gửi lời cảm ơn" trên Profile bản thân.

---

## Phụ thuộc

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [ ] API specifications (`.momorph/contexts/api-docs.yaml`)
- [ ] Database design (`.momorph/database.sql`)
- [x] Screen flow documented (`.momorph/SCREENFLOW.md`)

---

## So sánh Profile bản thân vs Profile người khác

| Thuộc tính | Profile bản thân (`hSH7L8doXB`) | Profile người khác (`bEpdheM0yU`) |
|-----------|--------------------------------|-----------------------------------|
| Header | App header (logo, search, bell) | Header với nút back |
| Statistics Container | **Có** (dark panel với thống kê) | **Không có** |
| Nút "Mở Secret Box" | **Có** | **Không có** |
| Nút "Gửi lời cảm ơn" | **Không có** | **Có** (CTA chính) |
| Badge/Icon Collection | Icon collection (chỉ icon, không tên) | Badge collection (icon + tên) |
| Bottom Nav | Profile tab **active** | Tất cả tab inactive |
| Route | Tab navigation (tab 4) | Push navigation (với userId param) |
| ViewModel | `ProfileViewModel extends AsyncNotifier<ProfileState>` | `OtherProfileViewModel extends FamilyAsyncNotifier<OtherProfileState, String>` |
| Entry point | Bottom tab / deep link `/profile` | Tap avatar trên Kudos card |

---

## Ghi chú

- Tất cả text PHẢI hỗ trợ đa ngôn ngữ VN/EN thông qua hệ thống i18n (slang).
- Kudos card là **reusable component** — cùng widget class cho Profile bản thân, Kudos feed, và All Kudos.
- `heroTier` là slug string (`'legend_hero'`, `'rising_hero'`, `'super_hero'`, `'new_hero'`, `'none'`) — **KHÔNG phải URL**. Render qua `AssetMapper.heroTierImage(heroTier)` → PNG asset local.
- `BadgeCollectionWidget` (tên nội bộ `IconCollectionSection`) ẩn hoàn toàn nếu `badges.isEmpty`.
- `KudosSectionHeaderWidget` dùng `Stack + Positioned.fill` với `Assets.images.kudosKeyVisualBg` làm background.
- Pagination: mỗi trang 20 Kudos, load thêm khi scroll đến 80% cuối danh sách.
- **Filter mặc định**: `KudosFilterType.sent` (Đã gửi) khi mở màn hình.
- **Icon badge**: display only — không có tương tác khi tap.
- **Stats sau Secret Box**: không tự cập nhật sau khi quay lại từ màn hình Open Secret Box — cần pull-to-refresh.
- **Dropdown selected state**: option đang được chọn có nền `rgba(255,234,158,0.10)`; option còn lại transparent.
- **Dropdown position**: overlay hiển thị phía dưới filter button, căn chỉnh theo Figma.
