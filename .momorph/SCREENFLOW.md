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
