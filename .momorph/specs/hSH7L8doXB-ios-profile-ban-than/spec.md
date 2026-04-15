# Dac ta tinh nang: [iOS] Profile ban than

**Frame ID**: `hSH7L8doXB`
**Frame Name**: `[iOS] Profile ban than`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngay tao**: 2026-04-14
**Trang thai**: Draft

---

## Tong quan

Man hinh **Profile ban than** hien thi thong tin ca nhan cua nguoi dung dang dang nhap trong ung dung Sun* Annual Awards 2025. Day la man hinh chinh cua tab Profile tren bottom navigation bar, noi nguoi dung xem duoc: thong tin ca nhan (avatar, ten, team, danh hieu), bo suu tap icon/huy hieu da dat duoc, thong ke hoat dong kudos (so kudos nhan/gui, hearts, secret box), va lich su kudos cua minh (da gui / da nhan) voi bo loc dropdown.

**Doi tuong su dung**: Nhan vien Sun* (Sunner) da dang nhap vao ung dung.

**Boi canh kinh doanh**: Profile ca nhan la noi nguoi dung theo doi thanh tich va su tham gia cua minh trong chuong trinh Sun* Annual Awards 2025 — thuc day dong luc gui va nhan kudos.

---

## Kich ban nguoi dung & Kiem thu *(bat buoc)*

### User Story 1 — Xem thong tin ca nhan (Uu tien: P1)

La mot Sunner, toi muon xem thong tin profile cua minh (avatar, ten, team, danh hieu) de xac nhan tai khoan va theo doi danh hieu hien tai.

**Ly do uu tien**: Day la thong tin co ban, hien thi dau tien khi mo tab Profile. Khong co no thi man hinh mat y nghia.

**Kiem thu doc lap**: Co the test bang cach render profile header voi du lieu user mock.

**Kich ban chap nhan**:

1. **Cho biet** nguoi dung da dang nhap, **Khi** mo tab Profile, **Thi** hien thi avatar hinh tron, ten day du (vi du: Huynh Duong Xuan Nhat), ma team (vi du: CEVC3), va badge danh hieu (vi du: Legend Hero).
2. **Cho biet** nguoi dung khong co avatar, **Khi** mo Profile, **Thi** hien thi placeholder voi chu cai dau cua ten.
3. **Cho biet** du lieu profile, **Khi** hien thi, **Thi** du lieu lay tu API profile cua user dang dang nhap.

---

### User Story 2 — Xem bo suu tap icon (Uu tien: P2)

La mot Sunner, toi muon xem bo suu tap icon/huy hieu ma toi da dat duoc de theo doi thanh tich ca nhan.

**Ly do uu tien**: Tinh nang gamification tang su gan ket, nhung khong phai core flow.

**Kiem thu doc lap**: Co the test bang cach render danh sach icon voi du lieu mock.

**Kich ban chap nhan**:

1. **Cho biet** nguoi dung co icon da dat duoc, **Khi** mo Profile, **Thi** hien thi section "Bo suu tap icon cua toi" voi cac icon badge hinh tron toi mau (dark circular).
2. **Cho biet** nguoi dung chua co icon nao, **Khi** mo Profile, **Thi** hien thi section rong hoac an section.
3. **Cho biet** tap vao icon badge, **Khi** bam, **Thi** co the mo chi tiet icon hoac tooltip (hanh vi TBD).

---

### User Story 3 — Xem thong ke hoat dong kudos (Uu tien: P1)

La mot Sunner, toi muon xem thong ke ca nhan (so kudos nhan, gui, hearts, secret box) de theo doi muc do tham gia.

**Ly do uu tien**: Thong ke la dong luc chinh de nguoi dung quay lai xem Profile — tac dong truc tiep den engagement.

**Kiem thu doc lap**: Co the test bang cach render block thong ke voi du lieu mock.

**Kich ban chap nhan**:

1. **Cho biet** nguoi dung da dang nhap, **Khi** scroll den section thong ke, **Thi** hien thi cac chi so: So Kudos ban nhan duoc, So Kudos ban da gui, So tim ban nhan duoc, So Secret Box ban da mo, So Secret Box chua mo.
2. **Cho biet** co Secret Box chua mo > 0, **Khi** hien thi, **Thi** nut "Mo Secret Box" o trang thai enabled.
3. **Cho biet** so Secret Box chua mo = 0, **Khi** hien thi, **Thi** nut "Mo Secret Box" o trang thai disabled hoac an.
4. **Cho biet** nguoi dung bam nut "Mo Secret Box", **Khi** tap, **Thi** dieu huong sang man hinh Open Secret Box (screenId: `kQk65hSYF2`).

---

### User Story 4 — Xem lich su kudos ca nhan voi bo loc (Uu tien: P1)

La mot Sunner, toi muon xem danh sach kudos ma toi da nhan hoac da gui, co the chuyen doi qua dropdown filter.

**Ly do uu tien**: Day la noi dung chinh chiem nhieu khong gian nhat tren man hinh — mang lai gia tri lien tuc cho nguoi dung.

**Kiem thu doc lap**: Co the test bang cach render list kudos cards voi filter dropdown.

**Kich ban chap nhan**:

1. **Cho biet** nguoi dung o tab Profile, **Khi** scroll den section Kudos, **Thi** hien thi header "KUDOS" voi banner "Sun* Annual Awards 2025" va dropdown filter.
2. **Cho biet** dropdown filter mac dinh la "Da gui (N)", **Khi** hien thi, **Thi** danh sach kudos chi hien thi cac kudos nguoi dung da gui, voi so luong hien thi trong label dropdown.
3. **Cho biet** nguoi dung bam dropdown filter, **Khi** mo overlay, **Thi** hien thi 2 lua chon: "Da nhan (N)" va "Da gui (N)" — N la so luong tuong ung.
4. **Cho biet** nguoi dung chon "Da nhan", **Khi** chon, **Thi** overlay dong, danh sach cap nhat chi hien kudos da nhan, label dropdown doi thanh "Da nhan (N)".
5. **Cho biet** filter khong co ket qua, **Khi** hien thi, **Thi** hien empty state phu hop.

---

### User Story 5 — Tuong tac voi kudos card (Uu tien: P2)

La mot Sunner, toi muon tuong tac voi cac kudos card (xem chi tiet, copy link, tha heart, bao cao spam) tren profile cua minh.

**Ly do uu tien**: Tuong tac co ban tang trai nghiem nhung khong phai core display.

**Kiem thu doc lap**: Co the test tung action rieng le tren 1 kudos card.

**Kich ban chap nhan**:

1. **Cho biet** kudos card hien thi, **Khi** bam "Xem chi tiet", **Thi** dieu huong sang man hinh chi tiet kudos.
2. **Cho biet** kudos card hien thi, **Khi** bam "Copy Link", **Thi** sao chep link vao clipboard va hien thi toast xac nhan.
3. **Cho biet** kudos card hien thi, **Khi** bam icon heart, **Thi** toggle trang thai heart (like/unlike) va cap nhat heart count.
4. **Cho biet** kudos card co label "Spam", **Khi** hien thi, **Thi** hien thi orange pill tag "Spam" tren card.

---

### User Story 6 — Dieu huong qua bottom navigation (Uu tien: P1)

La mot Sunner, toi muon chuyen doi giua cac tab chinh cua ung dung qua bottom navigation bar.

**Ly do uu tien**: Navigation co ban — thieu thi nguoi dung khong the di chuyen giua cac man hinh.

**Kiem thu doc lap**: Test bang cach tap tung tab va verify navigation.

**Kich ban chap nhan**:

1. **Cho biet** nguoi dung dang o tab Profile, **Khi** hien thi, **Thi** tab Profile (icon Person) o trang thai active/highlighted.
2. **Cho biet** nguoi dung bam tab khac (SAA 2025, Awards, Kudos), **Khi** tap, **Thi** dieu huong sang man hinh tuong ung.

---

### User Story 7 — Tai them kudos (Infinite Scroll) (Uu tien: P2)

La mot Sunner, toi muon tai them kudos khi cuon den cuoi danh sach de xem toan bo lich su.

**Ly do uu tien**: Pagination can thiet de hien thi du lieu lon, nhung khong phai core display.

**Kiem thu doc lap**: Co the test bang cach scroll den cuoi list va verify API call trang tiep theo.

**Kich ban chap nhan**:

1. **Cho biet** danh sach kudos con trang tiep theo (hasMoreKudos = true), **Khi** nguoi dung cuon den cuoi danh sach, **Thi** tu dong goi API load trang tiep theo va append vao danh sach hien tai.
2. **Cho biet** dang tai them kudos, **Khi** loading, **Thi** hien thi loading indicator o cuoi danh sach.
3. **Cho biet** khong con kudos de tai them (hasMoreKudos = false), **Khi** cuon den cuoi, **Thi** khong goi API nua.

---

### User Story 8 — Pull-to-refresh (Uu tien: P2)

La mot Sunner, toi muon keo xuong de lam moi toan bo du lieu profile.

**Ly do uu tien**: Thao tac co ban de cap nhat du lieu, nhung khong phai core display.

**Kiem thu doc lap**: Co the test bang cach pull-to-refresh va verify ViewModel.refresh() duoc goi.

**Kich ban chap nhan**:

1. **Cho biet** nguoi dung dang o tab Profile, **Khi** keo xuong (pull-to-refresh), **Thi** reload toan bo du lieu: thong tin ca nhan, bo suu tap icon, thong ke, va danh sach kudos.
2. **Cho biet** refresh thanh cong, **Khi** hoan tat, **Thi** hien thi du lieu moi nhat.
3. **Cho biet** refresh that bai (mat mang), **Khi** loi xay ra, **Thi** hien thi thong bao loi va giu du lieu cu.

---

### Truong hop bien (Edge Cases)

- Mat ket noi mang khi load profile -> Hien thi thong bao loi va nut retry.
- Avatar khong load duoc -> Hien thi placeholder chu cai dau.
- Nguoi dung chua co kudos nao (moi tao tai khoan) -> Hien thi empty state o section kudos list.
- Thong ke tat ca = 0 -> Hien thi section thong ke voi cac gia tri 0, nut "Mo Secret Box" disabled.
- Kudos card co noi dung qua dai -> Truncate voi "..." va nut "Xem chi tiet".
- Pull-to-refresh -> Reload toan bo du lieu profile (thong tin, thong ke, kudos list).
- Bam vao avatar tren kudos card cua nguoi khac -> Dieu huong sang Profile nguoi khac (screenId: `bEpdheM0yU`).
- Deep link vao profile (`/profile`) -> Mo tab Profile binh thuong.
- Token het han khi dang xem -> Redirect sang man hinh dang nhap.

---

## Yeu cau UI/UX *(tu Figma)*

### Thanh phan man hinh

| Thanh phan | Mo ta | Tuong tac |
|-----------|-------|-----------|
| 1. App Header / Status Bar | Thanh trang thai iOS + navigation bar voi logo SAA 2025, co VN (language), icon search, icon bell (notification) | Bam Search -> mo man hinh tim kiem; Bam Bell -> mo danh sach thong bao |
| 1.1. Profile Info Container | Container chua avatar tron, ten day du, ma team, badge danh hieu | Chi hien thi |
| A.2. User Name & Badge | Nhom label xep doc: ten + team + badge | Chi hien thi |
| 2. Icon Collection Section | Section "Bo suu tap icon cua toi" voi hang cac icon badge hinh tron toi | Bam icon badge -> co the mo chi tiet (TBD) |
| B2. Icon Badge Slot | Mot icon badge rieng le trong bo suu tap | Bam -> mo tooltip/chi tiet (TBD) |
| A.3. Icon Collection Label | Tieu de "Bo suu tap icon cua toi" | Chi hien thi |
| 3. Statistics Container | Panel toi chua thong ke: Kudos nhan, Kudos gui, Hearts, Secret Box da mo, Secret Box chua mo, nut CTA | Chi hien thi (tru nut CTA) |
| D.1.2. Kudos Received Stat Row | Dong "So Kudos ban nhan duoc" + so | Chi hien thi |
| D.1.3. Kudos Sent Stat Row | Dong "So Kudos ban da gui" + so | Chi hien thi |
| D.1.4. Hearts Received Stat Row | Dong "So tim ban nhan duoc" + so | Chi hien thi |
| D.1.5. Content Divider | Duong ke ngang phan cach Kudos/Hearts va Secret Box | Chi hien thi |
| D.1.6. Secret Box Opened Stat Row | Dong "So Secret Box ban da mo" + so | Chi hien thi |
| D.1.7. Secret Box Unopened Stat Row | Dong "So Secret Box chua mo" + so | Chi hien thi |
| 12. Button "Mo Secret Box" | Nut CTA "Mo Secret Box" emoji hop qua | Bam -> dieu huong sang man hinh Open Secret Box (screenId: `kQk65hSYF2`) |
| 4. Kudos Section Header | Banner trang tri voi text "Sun* Annual Awards 2025" va tieu de "KUDOS" vang lon | Chi hien thi |
| 4.1. Kudos Filter Dropdown Button | Dropdown "Da gui (5)" voi chevron-down | Bam -> mo overlay dropdown list |
| A. Dropdown List Overlay | Overlay voi 2 lua chon: "Da nhan (N)" va "Da gui (N)" | Chon -> dong overlay, cap nhat list |
| 5. Kudos List Container | Container chua danh sach kudos cards theo filter da chon | Scroll doc |
| 5.x. KUDO Highlight Card | The kudos voi sender/receiver/content/hashtags/actions | Bam "Xem chi tiet", Copy Link, Heart toggle |
| D.3.1. Spam Label | Orange pill label "Spam" tren card bi report | Chi hien thi |
| 6. Bottom Navigation Bar | 4 tab: SAA 2025, Awards, Kudos, Profile (active) | Bam tab -> dieu huong |

### Luong dieu huong

- **Tu**: Bottom Navigation Bar tab "Profile" (tu bat ky man hinh chinh nao)
- **Den**:
  - Man hinh Tim kiem (tu icon search tren header)
  - Danh sach thong bao (tu icon bell tren header)
  - Open Secret Box (screenId: `kQk65hSYF2`) (tu nut "Mo Secret Box")
  - Chi tiet kudos (tu "Xem chi tiet" tren card)
  - Profile nguoi khac (screenId: `bEpdheM0yU`) (tu tap avatar tren kudos card)
  - Cac tab khac qua bottom navigation (SAA 2025, Awards, Kudos)
- **Triggers**: Bam tab, bam nut, bam link

### Yeu cau hinh anh

- Ung dung chi danh cho mobile (iOS) — width: 375px
- Animations/Transitions: Dropdown overlay open/close animation

### Accessibility (VoiceOver)

| Thanh phan | Semantic Label | Trait |
|-----------|---------------|-------|
| Avatar | "Anh dai dien cua {ten}" | Image |
| Badge danh hieu | "{danh hieu}" | Static Text |
| Icon Badge Slot | "Huy hieu {ten huy hieu}" | Button |
| Stat Row | "{label}: {count}" | Static Text |
| Button "Mo Secret Box" | "Mo Secret Box. Ban co {count} hop chua mo" | Button |
| Dropdown Filter | "Loc kudos. {gia tri hien tai}" | Button |
| Heart icon | "{count} luot thich. {Da thich / Chua thich}" | Button, toggle |
| Copy Link | "Sao chep lien ket" | Button |
| "Xem chi tiet" | "Xem chi tiet kudos" | Link |
| Nav Bar tabs | "{Tab name}. Tab {index} tren 4" | Tab |

> Chi tiet visual specs xem tai [design-style.md](design-style.md)

---

## Yeu cau *(bat buoc)*

### Yeu cau chuc nang

- **FR-001**: He thong PHAI hien thi thong tin profile nguoi dung hien tai: avatar, ten day du, ma team, badge danh hieu.
- **FR-002**: He thong PHAI hien thi section bo suu tap icon voi cac icon badge ma nguoi dung da dat duoc.
- **FR-003**: He thong PHAI hien thi thong ke ca nhan: kudos nhan, kudos gui, hearts nhan, secret box da mo, secret box chua mo.
- **FR-004**: He thong PHAI ho tro dropdown filter de chuyen doi giua "Da nhan" va "Da gui" cho danh sach kudos.
- **FR-005**: He thong PHAI hien thi danh sach kudos cards voi day du thong tin: sender, receiver, noi dung, hashtag, thoi gian, heart count, actions.
- **FR-006**: Nguoi dung PHAI co the bam nut "Mo Secret Box" de dieu huong sang man hinh Open Secret Box.
- **FR-007**: Nguoi dung PHAI co the tuong tac voi kudos cards: heart toggle, copy link, xem chi tiet.
- **FR-008**: He thong PHAI ho tro da ngon ngu (VN/EN) cho tat ca text hien thi.
- **FR-009**: Bottom Navigation Bar PHAI hien thi co dinh o day man hinh voi tab Profile active.
- **FR-010**: Dropdown filter PHAI cap nhat so luong tuong ung (N) trong label khi du lieu thay doi.
- **FR-011**: He thong PHAI ho tro pull-to-refresh de reload toan bo du lieu profile.
- **FR-012**: He thong PHAI ho tro infinite scroll (pagination) cho danh sach kudos.

### Yeu cau ky thuat

- **TR-001**: Kien truc PHAI tuan theo MVVM pattern voi 1 ViewModel (`ProfileViewModel extends AsyncNotifier<ProfileState>`).
- **TR-002**: Asset paths PHAI su dung `flutter_gen` (`Assets.xxx`), khong hardcode string.
- **TR-003**: Icons PHAI su dung format SVG va render qua `flutter_svg`.
- **TR-004**: Text PHAI su dung i18n (slang), khong hardcode string.
- **TR-005**: Model PHAI su dung freezed cho immutability.
- **TR-006**: Du lieu PHAI duoc cache trong ViewModel state (Riverpod tu quan ly lifecycle).
- **TR-007**: Pull-to-refresh PHAI goi `refresh()` tren ViewModel -> re-fetch toan bo du lieu.

### So sanh Profile ban than vs Profile nguoi khac

| Thuoc tinh | Profile ban than (`hSH7L8doXB`) | Profile nguoi khac (`bEpdheM0yU`) |
|-----------|--------------------------------|-----------------------------------|
| Header | App header (logo, search, bell) | Header voi nut back |
| Statistics Container | Co (dark panel voi thong ke) | Khong co |
| Button "Mo Secret Box" | Co | Khong co |
| Button "Gui loi cam on" | Khong co | Co (CTA chinh) |
| Badge/Icon Collection | Icon collection (chi icon, khong ten) | Badge collection (icon + ten) |
| Bottom Nav | Profile tab active | Tat ca tab inactive |
| Route | Tab navigation (tab 4) | Push navigation (voi userId param) |
| ViewModel | `ProfileViewModel extends AsyncNotifier<ProfileState>` | `OtherProfileViewModel extends FamilyAsyncNotifier<OtherProfileState, String>` |
| Entry point | Bottom tab / deep link `/profile` | Tap avatar tren kudos card |

### Thuc the chinh

- **UserProfile**: id, name, avatar, team, badge/title, iconCollection
- **IconBadge**: id, name, imageUrl, earnedAt
- **PersonalStats**: kudosReceived, kudosSent, heartsReceived, openedSecretBoxes, unopenedSecretBoxes
- **Kudos**: id, senderId, receiverId, content, hashtags, heartCount, createdAt, isSpam, awardCategory
- **User (Sunner)**: id, name, avatar, team, badge/title

---

## Quan ly trang thai (State Management)

### State Model (ProfileState — freezed)

```
ProfileState:
  - userProfile: UserProfile              # Thong tin nguoi dung
  - iconCollection: List<IconBadge>       # Bo suu tap icon/huy hieu
  - personalStats: PersonalStats          # Thong ke hoat dong
  - kudosList: List<Kudos>                # Danh sach kudos (theo filter)
  - kudosFilter: KudosFilterType          # Enum: received | sent
  - kudosReceivedCount: int               # So luong kudos da nhan
  - kudosSentCount: int                   # So luong kudos da gui
  - hasMoreKudos: bool                    # Con kudos de load them (pagination)
```

### ViewModel

```
ProfileViewModel extends AsyncNotifier<ProfileState>
  - build() → load profile data (thong tin, icons, thong ke, kudos list)
  - changeFilter(KudosFilterType) → switch filter, reload kudos list
  - loadMoreKudos() → pagination — load trang tiep theo
  - toggleHeart(String kudosId) → heart toggle (optimistic update)
  - refresh() → re-fetch toan bo du lieu
```

### Local State (khong thuoc ViewModel)

- **Dropdown open state**: Quan ly trang thai dong/mo cua dropdown overlay.
- **Scroll controller**: `ScrollController` — quan ly infinite scroll cho kudos list.

### Trang thai Loading/Error

| Section | Loading | Error | Empty |
|---------|---------|-------|-------|
| Profile Info | Shimmer placeholder | Thong bao loi + nut retry | N/A (luon co) |
| Icon Collection | Shimmer placeholder | An section | "Chua co huy hieu nao." |
| Statistics | Shimmer placeholder (cac dong) | An section | Hien thi tat ca gia tri = 0 |
| Kudos List | Shimmer placeholder (3 cards) | Thong bao loi + nut retry | "Chua co Kudos nao." |

### Cache

- Du lieu PHAI duoc cache trong ViewModel state (Riverpod tu quan ly lifecycle).
- Pull-to-refresh goi `refresh()` tren ViewModel -> re-fetch toan bo du lieu.
- Heart action cap nhat state local ngay lap tuc (optimistic update) roi sync voi server.

---

## Phu thuoc API

| Endpoint | Method | Muc dich | Trang thai |
|----------|--------|----------|------------|
| `/api/v1/users/me/profile` | GET | Lay thong tin profile nguoi dung hien tai | Du doan |
| `/api/v1/users/me/icons` | GET | Lay bo suu tap icon/huy hieu | Du doan |
| `/api/v1/users/me/stats` | GET | Lay thong ke ca nhan | Du doan |
| `/api/v1/users/me/kudos?filter={sent\|received}&page={N}` | GET | Lay danh sach kudos ca nhan (co filter va pagination) | Du doan |
| `/api/v1/kudos/{id}/heart` | POST | Tha/bo heart cho kudos | Du doan |

---

## Tieu chi thanh cong *(bat buoc)*

### Ket qua do luong

- **SC-001**: Profile screen load trong vong 2 giay (cold start).
- **SC-002**: Chuyen doi filter (Da nhan / Da gui) cap nhat danh sach trong vong 1 giay.
- **SC-003**: Ho tro hien thi dung ca 2 ngon ngu VN va EN.
- **SC-004**: Tat ca icons su dung SVG format, asset paths su dung flutter_gen.

---

## Ngoai pham vi

- Chinh sua thong tin profile (ten, avatar) — thuoc man hinh Edit Profile rieng.
- Cai dat ung dung (Settings) — man hinh rieng.
- Push notification khi nhan kudos moi.
- Chuc nang bao cao/spam kudos (thuoc flow khac).
- Chi tiet icon badge khi bam (hanh vi TBD — chua co thiet ke).

---

## Phu thuoc

- [x] Constitution document ton tai (`.momorph/constitution.md`)
- [ ] API specifications (`.momorph/contexts/api-docs.yaml`)
- [ ] Database design (`.momorph/database.sql`)
- [x] Screen flow documented (`.momorph/SCREENFLOW.md`)

---

## Ghi chu

- Tat ca text PHAI ho tro da ngon ngu VN/EN thong qua he thong i18n (slang).
- Man hinh nay chi danh cho profile ban than (nguoi dung dang dang nhap). Profile nguoi khac la man hinh rieng (screenId: `bEpdheM0yU`).
- Kudos cards tren profile su dung cung component voi Kudos feed (reusable widget).
- Bottom Navigation Bar tab Profile o trang thai active (highlighted).
- Statistics Container su dung nen toi (dark panel) voi border vang (#998C5F).
- Dropdown filter overlay hien thi 2 options dang pill button tren nen toi.
