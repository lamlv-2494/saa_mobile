import 'package:saa_mobile/features/kudos/data/models/department.dart';
import 'package:saa_mobile/features/kudos/data/models/gift_recipient_ranking.dart';
import 'package:saa_mobile/features/kudos/data/models/hashtag.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos.dart';
import 'package:saa_mobile/features/kudos/data/models/kudos_state.dart';
import 'package:saa_mobile/features/kudos/data/models/personal_stats.dart';
import 'package:saa_mobile/features/kudos/data/models/spotlight_network.dart';
import 'package:saa_mobile/features/kudos/data/models/user_summary.dart';

UserSummary createUserSummary({
  String id = 'user-1',
  String name = 'Nguyễn Văn A',
  String avatar = 'https://example.com/avatar.png',
  String department = 'CECV1',
  int badgeLevel = 1,
}) =>
    UserSummary(
      id: id,
      name: name,
      avatar: avatar,
      department: department,
      badgeLevel: badgeLevel,
    );

Hashtag createHashtag({int id = 1, String name = '#teamwork'}) =>
    Hashtag(id: id, name: name);

Department createDepartment({int id = 1, String name = 'CECV1'}) =>
    Department(id: id, name: name);

Kudos createKudos({
  String id = 'kudos-1',
  UserSummary? sender,
  UserSummary? receiver,
  String content = 'Cảm ơn bạn đã hỗ trợ project!',
  List<Hashtag>? hashtags,
  int heartCount = 10,
  DateTime? createdAt,
  bool isHighlight = false,
  bool isAnonymous = false,
  bool isLikedByMe = false,
  bool canLike = true,
  String shareUrl = 'https://kudos.sun-asterisk.com/k/kudos-1',
}) =>
    Kudos(
      id: id,
      sender: sender ?? createUserSummary(id: 'sender-1', name: 'Người gửi'),
      receiver:
          receiver ?? createUserSummary(id: 'receiver-1', name: 'Người nhận'),
      content: content,
      hashtags: hashtags ?? [createHashtag()],
      heartCount: heartCount,
      createdAt: createdAt ?? DateTime(2025, 11, 15),
      isHighlight: isHighlight,
      isAnonymous: isAnonymous,
      isLikedByMe: isLikedByMe,
      canLike: canLike,
      shareUrl: shareUrl,
    );

PersonalStats createPersonalStats({
  int kudosReceived = 25,
  int kudosSent = 25,
  int heartsReceived = 30,
  int secretBoxesOpened = 3,
  int secretBoxesUnopened = 2,
  int starBadgeLevel = 1,
  bool isBonusActive = false,
}) =>
    PersonalStats(
      kudosReceived: kudosReceived,
      kudosSent: kudosSent,
      heartsReceived: heartsReceived,
      secretBoxesOpened: secretBoxesOpened,
      secretBoxesUnopened: secretBoxesUnopened,
      starBadgeLevel: starBadgeLevel,
      isBonusActive: isBonusActive,
    );

SpotlightNetwork createSpotlightNetwork({
  List<SpotlightNode>? nodes,
  List<SpotlightEdge>? edges,
  int totalKudos = 388,
}) =>
    SpotlightNetwork(
      nodes: nodes ??
          [
            const SpotlightNode(
                userId: 'u1', name: 'User A', x: 100, y: 100),
            const SpotlightNode(
                userId: 'u2', name: 'User B', x: 200, y: 150),
          ],
      edges: edges ??
          [const SpotlightEdge(fromUserId: 'u1', toUserId: 'u2', weight: 3)],
      totalKudos: totalKudos,
    );

GiftRecipientRanking createGiftRecipientRanking({
  int rank = 1,
  UserSummary? user,
  int giftCount = 15,
}) =>
    GiftRecipientRanking(
      rank: rank,
      user: user ?? createUserSummary(id: 'top-$rank', name: 'Top $rank'),
      giftCount: giftCount,
    );

List<Kudos> createHighlightKudosList({int count = 5}) => List.generate(
      count,
      (i) => createKudos(
        id: 'highlight-$i',
        heartCount: 50 - i * 5,
        isHighlight: true,
      ),
    );

List<Kudos> createKudosFeedList({int count = 10}) => List.generate(
      count,
      (i) => createKudos(id: 'feed-$i', heartCount: 20 - i),
    );

List<GiftRecipientRanking> createTop10List() => List.generate(
      10,
      (i) => createGiftRecipientRanking(
        rank: i + 1,
        giftCount: 20 - i * 2,
      ),
    );

KudosState createKudosState({
  List<Kudos>? highlightKudos,
  List<Kudos>? allKudos,
  PersonalStats? personalStats,
  List<GiftRecipientRanking>? topGiftRecipients,
  SpotlightNetwork? spotlightData,
  Hashtag? selectedHashtag,
  Department? selectedDepartment,
  int currentHighlightPage = 0,
  bool hasMoreKudos = true,
  List<Hashtag>? availableHashtags,
  List<Department>? availableDepartments,
}) =>
    KudosState(
      highlightKudos: highlightKudos ?? createHighlightKudosList(),
      allKudos: allKudos ?? createKudosFeedList(),
      personalStats: personalStats ?? createPersonalStats(),
      topGiftRecipients: topGiftRecipients ?? createTop10List(),
      spotlightData: spotlightData ?? createSpotlightNetwork(),
      selectedHashtag: selectedHashtag,
      selectedDepartment: selectedDepartment,
      currentHighlightPage: currentHighlightPage,
      hasMoreKudos: hasMoreKudos,
      availableHashtags: availableHashtags ??
          [createHashtag(id: 1, name: '#teamwork'), createHashtag(id: 2, name: '#dedicated')],
      availableDepartments: availableDepartments ??
          [createDepartment(id: 1, name: 'CECV1'), createDepartment(id: 2, name: 'Division A')],
    );
