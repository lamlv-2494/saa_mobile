# SCREENFLOW - SAA Mobile

> Auto-generated screen flow mapping from Figma designs.
> Last updated: 2026-04-10

## Project Info

| Key        | Value                          |
| ---------- | ------------------------------ |
| File Key   | 9ypp4enmFmdK3YAFJLIu6C        |
| Platform   | iOS (Mobile)                   |
| Total Frames | 139                          |
| iOS Screens  | 30                           |

## Discovery Progress

| Metric       | Count |
| ------------ | ----- |
| Total iOS    | 30    |
| Discovered   | 1     |
| Pending      | 29    |
| Progress     | 3%    |

## Screens

| # | Screen Name | Screen ID | Status | Key APIs | Navigations |
|---|-------------|-----------|--------|----------|-------------|
| 1 | [iOS] Home | OuH1BUTYT0 | discovered | GET /awards, GET /kudos, GET /event-countdown | Login, Awards, Kudos, Profile, Search, Notifications, Send Kudos, Award Detail, Kudos Detail, Language Selection |
| 2 | [iOS] Login | 8HGlvYGJWq | pending | | |
| 3 | [iOS] 404 | sn2mdavs1a | pending | | |
| 4 | [iOS] Access denied | k-7zJk2B7s | pending | | |
| 5 | [iOS] Award_Best Manager | 7y195PPTxQ | pending | | |
| 6 | [iOS] Award_MVP | b2BuS8HYIt | pending | | |
| 7 | [iOS] Award_Signature 2025 - Creator | O98TwiHaJe | pending | | |
| 8 | [iOS] Award_Top project | FQoJZLkG_d | pending | | |
| 9 | [iOS] Award_Top project leader | QQvsfK3yaK | pending | | |
| 10 | [iOS] Award_Top talent | c-QM3_zjkG | pending | | |
| 11 | [iOS] Language dropdown | uUvW6Qm1ve | pending | | |
| 12 | [iOS] Open secret box | kQk65hSYF2 | pending | | |
| 13 | [iOS] Open secret box- action | KUmv414uC9 | pending | | |
| 14 | [iOS] Open secret box- Standby 1 | -LIblaeusT | pending | | |
| 15 | [iOS] Open secret box- Standby 2 | IXpGakYRm5 | pending | | |
| 16 | [iOS] Open secret box- Standby 3 | _cWAEarZPi | pending | | |
| 17 | [iOS] Open secret box- Standby 4 | scvV-OQCAJ | pending | | |
| 18 | [iOS] Open secret box- Standby 5 | wsI6gaO_yc | pending | | |
| 19 | [iOS] Open secret box- Standby 6 | xptNUunBS_ | pending | | |
| 20 | [iOS] Open secret box- Standby 7 | FvTOS7oCPU | pending | | |
| 21 | [iOS] Profile bản thân | hSH7L8doXB | pending | | |
| 22 | [iOS] Profile người khác | bEpdheM0yU | pending | | |
| 23 | [iOS] Sun*Kudos | _b68CBWKl5 | pending | | |
| 24 | [iOS] Sun*Kudos_All Kudos | j_a2GQWKDJ | pending | | |
| 25 | [iOS] Sun*Kudos_Gửi lời chúc Kudos | PV7jBVZU1N | pending | | |
| 26 | [iOS] Sun*Kudos_Searching | hldqjHoSRH | pending | | |
| 27 | [iOS] Sun*Kudos_Search Sunner | 3jgwke3E8O | pending | | |
| 28 | [iOS] Sun*Kudos_View kudo | T0TR16k0vH | pending | | |
| 29 | [iOS] Sun*Kudos_View kudo ẩn danh | 5C2BL6GYXL | pending | | |
| 30 | [iOS] Thể lệ | zIuFaHAid4 | pending | | |

## Navigation Graph

```mermaid
graph TD
    Home["[iOS] Home"]
    Login["[iOS] Login"]
    Awards_TopTalent["[iOS] Award_Top talent"]
    Awards_TopProject["[iOS] Award_Top project"]
    Awards_TopProjectLeader["[iOS] Award_Top project leader"]
    Awards_MVP["[iOS] Award_MVP"]
    Awards_BestManager["[iOS] Award_Best Manager"]
    Awards_Signature["[iOS] Award_Signature 2025 - Creator"]
    Kudos["[iOS] Sun*Kudos"]
    KudosAllKudos["[iOS] Sun*Kudos_All Kudos"]
    SendKudos["[iOS] Sun*Kudos_Gửi lời chúc Kudos"]
    Profile["[iOS] Profile bản thân"]
    Search["[iOS] Sun*Kudos_Searching"]
    LanguageDropdown["[iOS] Language dropdown"]
    TheLe["[iOS] Thể lệ"]

    Login -->|after login| Home
    Home -->|Bottom Nav: Awards| Awards_TopTalent
    Home -->|Bottom Nav: Kudos| Kudos
    Home -->|Bottom Nav: Profile| Profile
    Home -->|Header: Search| Search
    Home -->|Header: Language| LanguageDropdown
    Home -->|ABOUT AWARD button| TheLe
    Home -->|ABOUT KUDOS button| Kudos
    Home -->|Award card: Chi tiết| Awards_TopTalent
    Home -->|FAB: Pencil| SendKudos
    Home -->|FAB: Kudos icon| KudosAllKudos
```

## API Endpoints Summary

| Method | Endpoint | Screen(s) | Purpose |
|--------|----------|-----------|---------|
| GET | /api/awards | [iOS] Home | Load award categories list |
| GET | /api/kudos/info | [iOS] Home | Load Kudos section info |
| GET | /api/event/countdown | [iOS] Home | Get countdown timer data |

## Screen Groups

| Group | Screens |
|-------|---------|
| Auth | Login |
| Home | Home |
| Awards | Award_Best Manager, Award_MVP, Award_Signature 2025 - Creator, Award_Top project, Award_Top project leader, Award_Top talent |
| Kudos | Sun*Kudos, Sun*Kudos_All Kudos, Sun*Kudos_Gửi lời chúc Kudos, Sun*Kudos_Searching, Sun*Kudos_Search Sunner, Sun*Kudos_View kudo, Sun*Kudos_View kudo ẩn danh |
| Profile | Profile bản thân, Profile người khác |
| Secret Box | Open secret box (x8 variants) |
| Error | 404, Access denied |
| Utility | Language dropdown, Thể lệ |

## Discovery Log

| Date | Screen | Action | Notes |
|------|--------|--------|-------|
| 2026-04-10 | [iOS] Home | discovered | Hero screen with countdown, awards section, kudos section, FAB, bottom nav |
