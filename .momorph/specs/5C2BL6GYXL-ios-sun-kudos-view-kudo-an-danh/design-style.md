# Design Style: [iOS] Sun*Kudos_View kudo ẩn danh

**Frame ID**: `5C2BL6GYXL`
**Frame Name**: `[iOS] Sun*Kudos_View kudo ẩn danh`
**Figma File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-14

---

## Design Tokens

> Tất cả design tokens giống hệt View Kudo thường (`T0TR16k0vH`). Chỉ liệt kê phần **khác biệt**.

### Khác biệt so với View Kudo thường

| Thành phần | View Kudo thường | View Kudo ẩn danh |
|-----------|-----------------|-------------------|
| Avatar người gửi | Ảnh thật từ profile | Avatar mặc định ẩn danh (asset riêng) |
| Tên người gửi | Tên thật (ví dụ: "Huỳnh Dương Xuân...") | Alias (ví dụ: "Anh Hùng Xạ Điêu") hoặc "Người gửi ẩn danh" |
| Phòng ban người gửi | Mã phòng ban (ví dụ: "CECV10") | "Người gửi ẩn danh" |
| Badge danh hiệu người gửi | Hiển thị (Rising Hero, Legend Hero...) | **Ẩn hoàn toàn** |
| Tương tác avatar người gửi | Bấm → Profile | **Disabled** (không có tương tác) |

---

## Chi tiết Style khác biệt

### Avatar người gửi ẩn danh

| Thuộc tính | Giá trị |
|-----------|---------|
| **Size** | 24x24px (giống thường) |
| **Shape** | Circle, border-radius 24px |
| **Border** | 1.869px solid #FFFFFF (dày hơn so với thường: 0.865px) |
| **Background** | Avatar mặc định ẩn danh (asset: `Assets.images.anonymousAvatar` hoặc tương đương) |

### Text người gửi ẩn danh

| Thuộc tính | Giá trị |
|-----------|---------|
| **Tên** | Montserrat 10px/16px, weight 400, color #00101A, text-align center |
| **Phòng ban** | Montserrat 10px/9.26px, weight 500, color #999999, text "Người gửi ẩn danh" |
| **Badge** | **Không hiển thị** |
| **Huy hiệu + Sao row** | justify-content: center (thay vì flex-start) |

---

## Layout

> Layout tổng thể giống hệt View Kudo thường. Xem design-style.md của `T0TR16k0vH` để biết chi tiết đầy đủ.

### Khác biệt layout

```
Sender Info (ẩn danh):
┌─────────────────┐
│  [Anonymous Ava] │  ← Avatar mặc định riêng
│  Anh Hùng Xạ... │  ← Alias (center aligned)
│ Người gửi ẩn danh│ ← Thay cho phòng ban + badge
└─────────────────┘

Receiver Info (không đổi):
┌─────────────────┐
│  [Real Avatar]   │
│  Dương Xuân H... │
│  CECV10 · Badge  │
└─────────────────┘
```

---

## Tham chiếu

- Design tokens đầy đủ: [View Kudo design-style.md](../T0TR16k0vH-ios-sun-kudos-view-kudo/design-style.md)
- Spec đầy đủ: [View Kudo spec.md](../T0TR16k0vH-ios-sun-kudos-view-kudo/spec.md)

---

## Ghi chú

- Đây là variant — implementation dùng chung widget, conditional rendering dựa trên `isAnonymous`.
- Avatar ẩn danh có border dày hơn (1.869px) so với avatar thường (0.865px) — theo Figma.
- Tất cả icons PHẢI dùng SVG format.
- Asset paths PHẢI dùng `flutter_gen` (`Assets.xxx`).
