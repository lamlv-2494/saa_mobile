# SAA Mobile - Screen Flow

## Tổng quan

Tài liệu này mô tả luồng màn hình (screen flow) của ứng dụng Sun*Kudos trên iOS.
Figma File Key: `9ypp4enmFmdK3YAFJLIu6C`

---

## Danh sách màn hình

| # | Screen ID | Tên màn hình | Mô tả |
|---|-----------|-------------|-------|
| 1 | `8HGlvYGJWq` | [iOS] Login | Màn hình đăng nhập |
| 2 | `OuH1BUTYT0` | [iOS] Home | Trang chủ - countdown sự kiện, hệ thống giải thưởng |
| 3 | `fO0Kt19sZZ` | [iOS] Sun*Kudos | Trang chính Kudos feed |
| 4 | `_b68CBWKl5` | [iOS] Sun*Kudos (Notification) | Biến thể với popup thông báo |
| 5 | `j_a2GQWKDJ` | [iOS] Sun*Kudos_All Kudos | Xem tất cả Kudos |
| 6 | `V5GRjAdJyb` | [iOS] Sun*Kudos_dropdown hashtag | Dropdown lọc theo hashtag |
| 7 | `76k69LQPfj` | [iOS] Sun*Kudos_dropdown phòng ban | Dropdown lọc theo phòng ban |
| 8 | `hldqjHoSRH` | [iOS] Sun*Kudos_Searching | Màn hình tìm kiếm Sunner (đang gõ) |
| 9 | `3jgwke3E8O` | [iOS] Sun*Kudos_Search Sunner | Màn hình tìm kiếm Sunner (kết quả + lịch sử) |
| 10 | `7fFAb-K35a` | [iOS] Sun*Kudos_Viết Kudo_default | Form viết Kudo mới (trạng thái mặc định) |
| 11 | `PV7jBVZU1N` | [iOS] Sun*Kudos_Gửi lời chúc Kudos | Form gửi Kudo (đã điền dữ liệu) |
| 12 | `aKWA2klsnt` | [iOS] Sun*Kudos_Gửi lời chúc Kudos_dropdown hashtag | Dropdown chọn hashtag trong form gửi Kudo |
| 13 | `5MU728Tjck` | [iOS] Sun*Kudos_Gửi lời chúc Kudos_dropdown tên người nhận | Dropdown chọn người nhận trong form gửi Kudo |
| 14 | `0le8xKnFE_` | [iOS] Sun*Kudos_Lỗi chưa điền hết | Form gửi Kudo - hiển thị lỗi validation |
| 15 | `xms7csmDhD` | [iOS] Sun*Kudos_Tiêu chuẩn cộng đồng | Trang tiêu chuẩn cộng đồng |
| 16 | `T0TR16k0vH` | [iOS] Sun*Kudos_View kudo | Xem chi tiết một Kudo |
| 17 | `5C2BL6GYXL` | [iOS] Sun*Kudos_View kudo ẩn danh | Xem chi tiết Kudo ẩn danh |
| 18 | `hSH7L8doXB` | [iOS] Profile bản thân | Trang profile cá nhân |
| 19 | `bEpdheM0yU` | [iOS] Profile người khác | Trang profile người khác |
| 20 | `kQk65hSYF2` | [iOS] Open secret box | Mở hộp bí mật |
| 21 | `c-QM3_zjkG` | [iOS] Award_Top talent | Giải thưởng Top Talent |
| 22 | `zIuFaHAid4` | [iOS] Thể lệ | Trang thể lệ |
| 23 | `sn2mdavs1a` | [iOS] 404 | Trang lỗi 404 |
| 24 | `k-7zJk2B7s` | [iOS] Access denied | Trang từ chối truy cập |

---

## Chi tiết màn hình: [iOS] Sun*Kudos (fO0Kt19sZZ)

### Mô tả

Đây là màn hình chính của tính năng Kudos - hiển thị feed các lời khen/ghi nhận giữa các Sunner. Màn hình bao gồm các phần chính:

1. **Header**: Banner Sun*Kudos với tagline "Mỗi ngày hãy tìm một lý do để ghi nhận ai đó!"
2. **Highlight Kudos**: Carousel hiển thị các Kudo nổi bật, có bộ lọc dropdown (hashtag, phòng ban)
3. **Spotlight Board**: Bảng xếp hạng người nhận/gửi Kudo nhiều nhất
4. **All Kudos**: Danh sách tất cả Kudo gần đây với filter hashtag
5. **Bottom Navigation Bar**: Thanh điều hướng chính (SAA 2025, Awards, Kudos, Profile)

### Các thành phần tương tác

| Thành phần | Hành động | Điều hướng đến |
|-----------|----------|---------------|
| Nút tìm kiếm (icon search) | Tap | [iOS] Sun*Kudos_Search Sunner (`3jgwke3E8O`) |
| Nút thông báo (icon bell) | Tap | Popup notification (`_b68CBWKl5`) |
| Dropdown hashtag (Highlight) | Tap | Dropdown hashtag (`V5GRjAdJyb`) |
| Dropdown phòng ban (Highlight) | Tap | Dropdown phòng ban (`76k69LQPfj`) |
| Kudo card (Highlight/All Kudos) | Tap | View Kudo (`T0TR16k0vH`) hoặc View Kudo ẩn danh (`5C2BL6GYXL`) |
| "Xem tất cả" (All Kudos) | Tap | All Kudos (`j_a2GQWKDJ`) - animate PageView sang page 1 |
| Nút viết Kudo (FAB / action) | Tap | Viết Kudo default (`7fFAb-K35a`) |
| Avatar người dùng | Tap | Profile người khác (`bEpdheM0yU`) |
| Tab "SAA 2025" | Tap | Home (`OuH1BUTYT0`) |
| Tab "Awards" | Tap | Award_Top talent (`c-QM3_zjkG`) |
| Tab "Kudos" | Tap | Trang hiện tại (active) |
| Tab "Profile" | Tap | Profile bản thân (`hSH7L8doXB`) |

---

## Luồng điều hướng chính

### 1. Luồng đăng nhập

```
[Login] ──(Google OAuth)──> [Home]
  8HGlvYGJWq                OuH1BUTYT0
```

### 2. Điều hướng Bottom Tab

```
┌─────────────┬─────────────┬─────────────┬─────────────┐
│  SAA 2025   │   Awards    │   Kudos     │   Profile   │
│ OuH1BUTYT0  │ c-QM3_zjkG  │ fO0Kt19sZZ  │ hSH7L8doXB  │
└─────────────┴─────────────┴─────────────┴─────────────┘
```

### 3. Luồng chính từ màn hình Sun*Kudos

```
                        ┌──────────────────────┐
                        │   [iOS] Sun*Kudos    │
                        │     fO0Kt19sZZ       │
                        └──────────┬───────────┘
                                   │
          ┌────────────┬───────────┼───────────┬────────────┐
          │            │           │           │            │
          v            v           v           v            v
   ┌─────────────┐ ┌────────┐ ┌────────┐ ┌─────────┐ ┌──────────┐
   │ Search      │ │Dropdown│ │Dropdown│ │View Kudo│ │ Viết     │
   │ Sunner      │ │Hashtag │ │Phòng   │ │         │ │ Kudo     │
   │ 3jgwke3E8O  │ │V5GRjAd │ │ban     │ │T0TR16k0 │ │ 7fFAb-K  │
   └──────┬──────┘ └────────┘ │76k69LQ │ │hoặc     │ └─────┬────┘
          │                   └────────┘ │5C2BL6G  │       │
          v                              └─────────┘       v
   ┌─────────────┐                               ┌──────────────┐
   │ Searching   │                               │ Gửi Kudo     │
   │ hldqjHoSRH  │                               │ (đã điền)    │
   └──────┬──────┘                               │ PV7jBVZU1N   │
          │                                      └──────┬───────┘
          v                                             │
   ┌─────────────┐                    ┌─────────┬───────┼────────┐
   │ Profile     │                    │         │       │        │
   │ người khác  │                    v         v       v        v
   │ bEpdheM0yU  │            ┌──────────┐┌────────┐┌──────┐┌───────┐
   └─────────────┘            │DD hashtag││DD tên  ││Lỗi   ││Tiêu   │
                              │aKWA2klsnt││người   ││valid. ││chuẩn  │
                              └──────────┘│nhận    ││0le8xK ││cộng   │
                                          │5MU728T ││       ││đồng   │
                                          └────────┘└──────┘│xms7cs │
                                                            └───────┘
```

### 4. Luồng tìm kiếm Sunner

```
[Sun*Kudos] ──(tap icon search)──> [Search Sunner]
fO0Kt19sZZ                         3jgwke3E8O
                                       │
                                       ├──(gõ tên)──> [Searching]
                                       │               hldqjHoSRH
                                       │                  │
                                       │                  └──(chọn kết quả)──> [Profile người khác]
                                       │                                        bEpdheM0yU
                                       │
                                       └──(chọn từ lịch sử)──> [Profile người khác]
                                                                 bEpdheM0yU
```

### 5. Luồng viết/gửi Kudo

```
[Sun*Kudos] ──(tap viết Kudo)──> [Viết Kudo default]
fO0Kt19sZZ                       7fFAb-K35a
                                      │
                                      ├──(tap Người nhận)──> [DD tên người nhận]
                                      │                       5MU728Tjck
                                      │
                                      ├──(tap Hashtag)──> [DD hashtag]
                                      │                    aKWA2klsnt
                                      │
                                      ├──(tap "Tiêu chuẩn cộng đồng")──> [Tiêu chuẩn cộng đồng]
                                      │                                    xms7csmDhD
                                      │
                                      ├──(điền đủ thông tin)──> [Gửi Kudo đã điền]
                                      │                          PV7jBVZU1N
                                      │                             │
                                      │                             ├──(tap "Gửi đi")──> Gửi thành công
                                      │                             │                    ──> [Sun*Kudos]
                                      │                             │                        fO0Kt19sZZ
                                      │                             │
                                      │                             └──(tap "Hủy")──> [Sun*Kudos]
                                      │                                                fO0Kt19sZZ
                                      │
                                      └──(tap "Gửi đi" thiếu thông tin)──> [Lỗi chưa điền hết]
                                                                            0le8xKnFE_
```

### 6. Luồng xem Kudo

```
[Sun*Kudos] ──(tap Kudo card)──> [View Kudo]        (người gửi công khai)
fO0Kt19sZZ                       T0TR16k0vH
                                      │
                                      ├──(tap Copy Link)──> Copy vào clipboard
                                      ├──(tap "Xem chi tiết")──> Mở rộng nội dung
                                      └──(tap avatar)──> [Profile người khác]
                                                          bEpdheM0yU

[Sun*Kudos] ──(tap Kudo ẩn danh)──> [View Kudo ẩn danh]
fO0Kt19sZZ                          5C2BL6GYXL
                                      │
                                      └──(người gửi hiển thị "Người gửi ẩn danh")
```

### 7. Luồng lọc/filter Kudos

```
[Sun*Kudos] ──(tap dropdown hashtag)──> [Dropdown hashtag]
fO0Kt19sZZ                              V5GRjAdJyb
                                            │
                                            └──(chọn hashtag)──> [Sun*Kudos] (đã lọc)
                                                                  fO0Kt19sZZ

[Sun*Kudos] ──(tap dropdown phòng ban)──> [Dropdown phòng ban]
fO0Kt19sZZ                                76k69LQPfj
                                              │
                                              └──(chọn phòng ban)──> [Sun*Kudos] (đã lọc)
                                                                      fO0Kt19sZZ
```

---

## Điểm vào (Entry Points)

| Điểm vào | Từ màn hình | Điều kiện |
|----------|------------|-----------|
| Bottom Tab "Kudos" | Bất kỳ màn hình nào có bottom nav | Đã đăng nhập |
| Từ Home | [iOS] Home (`OuH1BUTYT0`) - section Sun*Kudos | Tap vào khu vực Kudos |
| Deep link | Ngoài ứng dụng | Link trực tiếp đến Kudos feed |

## Điểm ra (Exit Points)

| Điểm ra | Đến màn hình | Hành động |
|---------|-------------|----------|
| Tab "SAA 2025" | [iOS] Home (`OuH1BUTYT0`) | Tap bottom tab |
| Tab "Awards" | [iOS] Award_Top talent (`c-QM3_zjkG`) | Tap bottom tab |
| Tab "Profile" | [iOS] Profile bản thân (`hSH7L8doXB`) | Tap bottom tab |
| Search Sunner | [iOS] Search Sunner (`3jgwke3E8O`) | Tap icon search |
| Viết Kudo | [iOS] Viết Kudo (`7fFAb-K35a`) | Tap nút viết Kudo |
| View Kudo | [iOS] View Kudo (`T0TR16k0vH`) | Tap Kudo card |
| Profile người khác | [iOS] Profile người khác (`bEpdheM0yU`) | Tap avatar |

---

## Các trạng thái màn hình (States)

### Sun*Kudos - Trạng thái mặc định (`fO0Kt19sZZ`)
- Hiển thị Highlight Kudos carousel
- Spotlight Board với tab "Người gửi" / "Người nhận"
- All Kudos feed với danh sách Kudo gần đây
- Filter mặc định: tất cả hashtag, tất cả phòng ban

### Sun*Kudos - Dropdown hashtag (`V5GRjAdJyb`)
- Overlay dropdown hiển thị danh sách hashtag (#Dedicated, #Inspiring, v.v.)
- Cho phép chọn một hashtag để lọc Highlight Kudos

### Sun*Kudos - Dropdown phòng ban (`76k69LQPfj`)
- Overlay dropdown hiển thị danh sách phòng ban
- Cho phép chọn phòng ban để lọc Highlight Kudos

### Sun*Kudos - Notification (`_b68CBWKl5`)
- Overlay popup thông báo
- Hiển thị danh sách thông báo mới (gửi Kudo, nhận Kudo, v.v.)

---

## Chi tiết màn hình: [iOS] Sun*Kudos_All Kudos (j_a2GQWKDJ)

### Mô tả

Đây là màn hình hiển thị tất cả Kudos, được triển khai dưới dạng **page view** trong màn hình Kudos chính (`fO0Kt19sZZ`). Page view **không hỗ trợ swipe thủ công** - chỉ animate chuyển trang khi người dùng tap "Xem tất cả" từ section All Kudos trên màn hình Kudos chính.

### Cấu trúc màn hình

1. **TopNavigation**: Thanh điều hướng phía trên
   - StatusBar (thời gian, pin, v.v.)
   - Nút Back (quay lại trang Kudos chính)
   - Tiêu đề màn hình
2. **Background**: Hình nền key visual SAA 2025
3. **Header**: Banner "Sun* annual awards 2025" + "Hệ thống giải thưởng"
4. **Danh sách Kudo**: Danh sách cuộn dọc chứa nhiều Kudo card (B.3)
5. **Bottom Navigation Bar**: Thanh điều hướng chính (SAA 2025, Awards, Kudos, Profile)

### Cấu trúc Kudo Card (B.3: KUDO - Highlight)

Mỗi card bao gồm:

| Mã | Thành phần | Loại | Mô tả |
|----|-----------|------|-------|
| B.3.1 | Avatar người gửi | ELLIPSE | Ảnh đại diện người gửi Kudo |
| B.3.2 | Thông tin người gửi | FRAME | Tên + huy hiệu (mã đơn vị, danh hiệu: Rising Hero/Legend Hero) |
| B.3.4 | Icon mũi tên | FRAME | Mũi tên chỉ hướng từ người gửi đến người nhận |
| B.3.5 | Avatar người nhận | ELLIPSE | Ảnh đại diện người nhận Kudo |
| B.4 | Nội dung lời cảm ơn | FRAME | Khung chứa nội dung chi tiết |
| B.4.1 | Thời gian đăng | TEXT | Thời gian Kudo được đăng |
| B.4.2 | Nội dung | FRAME | Lời cảm ơn/ghi nhận (có thể bị cắt ngắn) |
| B.4.3 | Hashtag | FRAME | Danh sách hashtag (#Dedicated, #Inspiring, v.v.) |
| B.4.4 | Action | FRAME | Khu vực hành động: Hearts (số lượt thích + icon), Buttons (chia sẻ, xem thêm) |

### Các thành phần tương tác

| Thành phần | Hành động | Điều hướng đến |
|-----------|----------|---------------|
| Nút Back (TopNavigation) | Tap | Quay lại [iOS] Sun*Kudos (`fO0Kt19sZZ`) - animate page view ngược |
| Kudo card (B.3) | Tap | [iOS] Sun*Kudos_View kudo (`T0TR16k0vH`) hoặc View Kudo ẩn danh (`5C2BL6GYXL`) |
| Avatar người gửi (B.3.1) | Tap | [iOS] Profile người khác (`bEpdheM0yU`) |
| Avatar người nhận (B.3.5) | Tap | [iOS] Profile người khác (`bEpdheM0yU`) |
| Hearts (B.4.4) | Tap | Thả tim / bỏ thả tim Kudo |
| Button chia sẻ (B.4.4) | Tap | Copy link / chia sẻ Kudo |
| Button xem thêm (B.4.4) | Tap | [iOS] Sun*Kudos_View kudo (`T0TR16k0vH`) |
| Tab "SAA 2025" | Tap | [iOS] Home (`OuH1BUTYT0`) |
| Tab "Awards" | Tap | [iOS] Award_Top talent (`c-QM3_zjkG`) |
| Tab "Kudos" | Tap | [iOS] Sun*Kudos (`fO0Kt19sZZ`) (active) |
| Tab "Profile" | Tap | [iOS] Profile bản thân (`hSH7L8doXB`) |

### Điểm vào (Entry Points)

| Điểm vào | Từ màn hình | Hành động |
|----------|------------|-----------|
| "Xem tất cả" All Kudos | [iOS] Sun*Kudos (`fO0Kt19sZZ`) | Tap nút "Xem tất cả" - page view animate sang |

### Điểm ra (Exit Points)

| Điểm ra | Đến màn hình | Hành động |
|---------|-------------|----------|
| Nút Back | [iOS] Sun*Kudos (`fO0Kt19sZZ`) | Tap nút back - page view animate ngược |
| Kudo card | [iOS] View Kudo (`T0TR16k0vH`) | Tap vào Kudo card |
| Avatar | [iOS] Profile người khác (`bEpdheM0yU`) | Tap avatar người gửi/nhận |
| Bottom tab | Các màn hình chính | Tap bottom navigation tab |

### Ghi chú kỹ thuật (All Kudos)

- Màn hình này là **page 2** trong PageView của Kudos feature (page 1 = Kudos feed chính `fO0Kt19sZZ`)
- PageView **không cho phép swipe thủ công** (`physics: NeverScrollableScrollPhysics()`)
- Chỉ chuyển trang qua `PageController.animateToPage()` khi tap "Xem tất cả"
- Nút Back trên TopNavigation sẽ animate page view quay lại page 1
- Danh sách Kudo card dạng **scrollable list** (cuộn dọc)
- Mỗi Kudo card tái sử dụng component B.3 (KUDO - Highlight) giống section Highlight trên trang Kudos chính
- Figma hiển thị 4 Kudo card mẫu, thực tế sẽ load từ API với phân trang (pagination)

---

## Chi tiết màn hình: [iOS] Profile bản thân (hSH7L8doXB)

### Mô tả

Đây là màn hình tab Profile (tab 4) trong bottom navigation — nơi người dùng đã đăng nhập xem thông tin cá nhân, bộ sưu tập icon, thống kê hoạt động Kudos, và lịch sử Kudos của mình với bộ lọc dropdown (Đã gửi / Đã nhận).

Cấu trúc màn hình gồm các phần chính:

1. **App Header** (`mms_1_header`): Logo SAA 2025, cờ VN (ngôn ngữ), icon Search, icon Bell
2. **Profile Info Container** (`mms_1.1_member`): Avatar tròn 64px, tên đầy đủ, mã team, hình ảnh danh hiệu (hero tier PNG via AssetMapper)
3. **Icon Collection Section** (`mms_2_icon collection`): Nhãn "Bộ sưu tập icon của tôi" + hàng ngang các icon badge 44×44px (ẩn nếu rỗng)
4. **Statistics Container** (`mms_D.1_Thống kê tổng quát`): Panel tối với 5 chỉ số (Kudos nhận, Kudos gửi, Hearts, Secret Box đã mở, Secret Box chưa mở) + nút "Mở Secret Box"
5. **Kudos Section Header** (`mms_4_header`): Banner trang trí với "Sun\* Annual Awards 2025" và tiêu đề "KUDOS" vàng lớn + ảnh nền kudosKeyVisualBg
6. **Kudos Filter Dropdown** (`mms_dropdown`): Dropdown "Đã gửi (N)" / "Đã nhận (N)" — mặc định "Đã gửi"
7. **Kudos List** (`mms_5_kudos list`): Danh sách KudosCard cuộn vô hạn (infinite scroll) theo filter đã chọn
8. **Bottom Navigation Bar** (`mms_6_nav bar`): 4 tab — SAA 2025, Awards, Kudos, Profile (active)

### Cấu trúc màn hình (Scroll Architecture)

```
ProfileScreen (ConsumerStatefulWidget)
└── RefreshIndicator
    └── CustomScrollView
        ├── SliverAppBar (transparent, ẩn, chỉ để padding đầu)
        └── SliverToBoxAdapter
            ├── ProfileInfoWidget          ← mms_1.1_member
            ├── BadgeCollectionWidget      ← mms_2_icon collection (conditional — ẩn nếu rỗng)
            ├── PersonalStatsCard          ← mms_D.1_Thống kê tổng quát
            ├── KudosSectionHeaderWidget   ← mms_4_header (Stack + background image)
            ├── ProfileKudosFilterDropdown ← mms_dropdown
            └── ProfileKudosListWidget     ← mms_5_kudos list (+ CircularProgressIndicator cuối list)
```

### Bảng design items (Figma)

| Mã Figma | Số thứ tự | Tên thành phần | Loại | Trạng thái |
|----------|-----------|----------------|------|-----------|
| `6885:10338` | 1 | App Header / Status Bar (`mms_1_header`) | navigation | completed |
| `6885:10339` | 1.1 | Profile Info Container (`mms_1.1_member`) | info_block | completed |
| `6885:10341` | A.2 | User Name & Badge (`mms_A.2_Name`) | label | completed |
| `6885:10349` | 2 | Icon Collection Section (`mms_2_icon collection`) | info_block | completed |
| `6885:10351` | B2 | Icon Badge Slot (`mms_B2_Huy hiệu`) | list_item | completed |
| `6885:10357` | A.3 | Icon Collection Label (`mms_A.3_Title`) | label | completed |
| `6885:10358` | 3 | Statistics Container (`mms_D.1_Thống kê tổng quát`) | info_block | draft |
| `6885:10360` | D.1.2 | Kudos Received Stat Row | label | completed |
| `6885:10365` | D.1.3 | Kudos Sent Stat Row | label | completed |
| `6885:10370` | D.1.4 | Hearts Received Stat Row | label | completed |
| `6885:10375` | D.1.5 | Content Divider | info_block | completed |
| `6885:10376` | D.1.6 | Secret Box Opened Stat Row | label | completed |
| `6885:10381` | D.1.7 | Secret Box Unopened Stat Row | label | completed |
| `6885:10386` | 12 | Nút "Mở Secret Box" (Button) | button | draft |
| `6885:10387` | 4 | Kudos Section Header (`mms_4_header`) | others | draft |
| `6885:10388` | 4.1 | Kudos Filter Dropdown (`mms_dropdown`) | dropdown | draft |
| `6885:10389` | 5 | Kudos List Container (`mms_5_kudos list`) | list_item | completed |
| `6885:10390` | 5.1 | Kudos Card 1 (`mms_5.1_KUDO - Highlight`) | others | draft |
| `6885:10391` | 5.2 | Kudos Card 2 (`mms_5.2_KUDO - Highlight`) | others | draft |
| `6885:10392` | 5.3 | Kudos Card 3 (`mms_5.3_KUDO - Highlight`) | others | draft |
| `6885:10394` | 6 | Bottom Navigation Bar (`mms_6_nav bar`) | navigation | completed |
| `6891:17101` | A | Kudos Filter Dropdown Overlay (`mms_A_Dropdown-List`) | popup_dialog | completed |
| `6891:17102` | A.1 | Dropdown Option "Đã nhận" | button | draft |
| `6891:17103` | A.2 | Dropdown Option "Đã gửi" | button | draft |

### Cấu trúc Kudos Card (mms_5.x_KUDO - Highlight)

Mỗi KudosCard trong danh sách Profile bao gồm:

| Mã | Thành phần | Loại | Mô tả |
|----|-----------|------|-------|
| B.3.1 | Avatar người gửi (`mms_B.3.1_Avatar người gửi`) | ELLIPSE | Ảnh đại diện người gửi Kudo — tap → Profile người khác |
| B.3.2 | Thông tin người gửi (`mms_B.3.2_Thông tin người gửi`) | FRAME | Tên + huy hiệu (mã đơn vị, danh hiệu) |
| B.3.4 | Icon mũi tên (`mms_B.3.4_Icon mũi tên`) | FRAME | Mũi tên chỉ hướng từ người gửi đến người nhận |
| B.3.5 | Avatar người nhận (`mms_B.3.5_Avatar người nhận`) | ELLIPSE | Ảnh đại diện người nhận Kudo — tap → Profile người khác |
| B.4 | Nội dung lời cảm ơn (`mms_B.4_Nội dung lời cảm ơn`) | FRAME | Khung chứa nội dung chi tiết |
| B.4.1 | Thời gian đăng (`mms_B.4.1_Thời gian đăng`) | TEXT | Thời gian Kudo được đăng |
| B.4.2 | Nội dung (`mms_B.4.2_Nội dung`) | FRAME | Lời cảm ơn/ghi nhận (có thể bị cắt ngắn) |
| B.4.3 | Hashtag (`mms_B.4.3_Hashtag`) | FRAME | Danh sách hashtag (#Dedicated, #Inspiring, v.v.) |
| B.4.4 | Action (`mms_B.4.4_Action`) | FRAME | Khu vực hành động: Hearts (số lượt thích + icon), Buttons (copy link, xem chi tiết) |

### Các thành phần tương tác

| Thành phần | Hành động | Kết quả |
|-----------|----------|---------|
| Icon Search (App Header) | Tap | Mở màn hình tìm kiếm Sunner (`hldqjHoSRH` / `3jgwke3E8O`) |
| Icon Bell (App Header) | Tap | Mở popup thông báo (`_b68CBWKl5`) |
| Avatar trên KudosCard (B.3.1 / B.3.5) | Tap | Push `/profile/:senderId` → Profile người khác (`bEpdheM0yU`) |
| Nút "Mở Secret Box" | Tap | Push `/secret-box` → Open Secret Box (`kQk65hSYF2`) — disabled nếu unopened=0 |
| Dropdown filter (mms_dropdown) | Tap | Mở overlay (`mms_A_Dropdown-List`), hiển thị 2 lựa chọn: "Đã nhận (N)" / "Đã gửi (N)" |
| Chọn "Đã nhận" trong dropdown | Tap | Đóng overlay, reset về trang 1, tải lại danh sách Kudos nhận |
| Chọn "Đã gửi" trong dropdown | Tap | Đóng overlay, reset về trang 1, tải lại danh sách Kudos gửi |
| Tap ngoài dropdown overlay | Tap | Đóng overlay, giữ nguyên filter hiện tại |
| "Xem chi tiết" trên KudosCard (B.4.4) | Tap | Push `/kudos/:kudosId` → View Kudo (`T0TR16k0vH` / `5C2BL6GYXL`) |
| "Copy Link" trên KudosCard (B.4.4) | Tap | Copy link vào clipboard, hiển thị toast xác nhận |
| Icon heart trên KudosCard (B.4.4) | Tap | Toggle like/unlike, cập nhật heart count (optimistic update) |
| Pull-to-refresh | Kéo xuống | Reload toàn bộ: profile, badges, stats, kudos list |
| Scroll đến cuối list | Auto | Tải thêm trang tiếp theo (append), hiện loading indicator |
| Tab "SAA 2025" | Tap | Chuyển sang [iOS] Home (`OuH1BUTYT0`) |
| Tab "Awards" | Tap | Chuyển sang [iOS] Award_Top talent (`c-QM3_zjkG`) |
| Tab "Kudos" | Tap | Chuyển sang [iOS] Sun\*Kudos (`fO0Kt19sZZ`) |
| Tab "Profile" | Tap | Trang hiện tại (active — không điều hướng) |

### Điểm vào (Entry Points)

| Điểm vào | Từ màn hình | Điều kiện |
|----------|------------|-----------|
| Tab "Profile" trong bottom nav | Bất kỳ màn hình chính nào | Đã đăng nhập |
| Self-redirect từ Profile người khác | `bEpdheM0yU` khi `userId == currentUserId` | ViewModel phát hiện self-view |
| Deep link `/profile` | Ngoài ứng dụng | Đã đăng nhập |

### Điểm ra (Exit Points)

| Điểm ra | Đến màn hình | Hành động |
|---------|-------------|----------|
| Icon Search | Tìm kiếm Sunner (`3jgwke3E8O`) | Tap icon search |
| Icon Bell | Thông báo (`_b68CBWKl5`) | Tap icon bell |
| "Mở Secret Box" | Open Secret Box (`kQk65hSYF2`) | Tap nút CTA |
| "Xem chi tiết" Kudos | View Kudo (`T0TR16k0vH` / `5C2BL6GYXL`) | Tap action trên card |
| Avatar trên KudosCard | Profile người khác (`bEpdheM0yU`) | Tap avatar sender/receiver |
| Tab "SAA 2025" | Home (`OuH1BUTYT0`) | Tap bottom tab |
| Tab "Awards" | Award_Top talent (`c-QM3_zjkG`) | Tap bottom tab |
| Tab "Kudos" | Sun\*Kudos (`fO0Kt19sZZ`) | Tap bottom tab |

### Trạng thái màn hình (States)

| Trạng thái | Mô tả | UI |
|-----------|-------|-----|
| Loading | Đang tải dữ liệu lần đầu | `CircularProgressIndicator` toàn màn hình |
| Error | Tải thất bại (mất mạng, API lỗi) | Text lỗi + nút Retry |
| Data (normal) | Đã có đủ dữ liệu | Hiển thị đầy đủ các section |
| Empty kudos | Không có kudos trong filter hiện tại | Empty state widget trong kudos list |
| Filter: Đã gửi | Filter mặc định khi mở màn hình | Dropdown hiển thị "Đã gửi (N)" |
| Filter: Đã nhận | Sau khi chọn filter nhận | Dropdown hiển thị "Đã nhận (N)" |
| Loading more | Đang tải thêm kudos (infinite scroll) | `CircularProgressIndicator` cuối list |
| Secret Box disabled | Tất cả secret box đã mở | Nút "Mở Secret Box" disabled / ẩn |

### Ghi chú kỹ thuật (Profile bản thân)

- **ViewModel**: `ProfileViewModel extends AsyncNotifier<ProfileState>` — không nhận tham số (khác với OtherProfileViewModel)
- **Hero Tier**: `UserProfile.heroTier` là slug string (`'legend_hero'`, `'rising_hero'`, `'none'`) — **KHÔNG phải URL**. Render qua `AssetMapper.heroTierImage(heroTier)` → PNG asset local
- **Filter mặc định**: `KudosFilterType.sent` (Đã gửi) khi mở màn hình
- **Self-redirect logic**: `OtherProfileScreen` check `userId == authProvider.currentUser.id` → set `currentTabIndexProvider = 3` + `context.pop()`
- **Statistics**: Lấy từ `ProfileRepository.getUserStats()` — trả về `kudosSentCount`, `kudosReceivedCount`, `heartsCount`, `secretBoxOpened`, `secretBoxUnopened`
- **Pagination**: Mỗi trang 20 kudos, append khi scroll đến 80% cuối list
- **KudosSectionHeaderWidget**: Dùng `Stack + Positioned.fill` với `Assets.images.kudosKeyVisualBg` làm background
- **BadgeCollectionWidget** (tên nội bộ `IconCollectionSection`): Ẩn hoàn toàn nếu `badges.isEmpty`

---

## Luồng Page View trong Kudos

```
┌─────────────────────────────────────────────────────┐
│                    PageView                         │
│         (NeverScrollableScrollPhysics)              │
│                                                     │
│  ┌──────────────────┐    ┌──────────────────┐      │
│  │  Page 0           │    │  Page 1           │      │
│  │  Sun*Kudos Feed   │───>│  All Kudos        │      │
│  │  fO0Kt19sZZ       │tap │  j_a2GQWKDJ       │      │
│  │                   │"Xem│                   │      │
│  │  - Header Banner  │tất │  - TopNavigation  │      │
│  │  - Highlight Kudos│cả" │    (+ nút Back)   │      │
│  │  - Spotlight Board│    │  - Header         │      │
│  │  - All Kudos      │<───│  - Danh sách Kudo │      │
│  │    (preview)      │tap │    (full list)    │      │
│  │                   │back│                   │      │
│  └──────────────────┘    └──────────────────┘      │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

## Ghi chú kỹ thuật

- Bottom Navigation Bar luôn hiển thị trên các màn hình chính (Home, Awards, Kudos, Profile)
- Các dropdown (hashtag, phòng ban, tên người nhận) hiển thị dạng overlay/bottom sheet
- Form viết Kudo hỗ trợ: chọn người nhận, danh hiệu, nội dung (rich text), hashtag, hình ảnh, gửi ẩn danh
- Tiêu chuẩn cộng đồng có thể truy cập từ form viết Kudo qua link "Tiêu chuẩn cộng đồng"
- Kudo card hiển thị: avatar, tên người gửi/nhận, nội dung, hashtag, thời gian
- View Kudo chi tiết có nút "Copy Link" và "Xem chi tiết"
