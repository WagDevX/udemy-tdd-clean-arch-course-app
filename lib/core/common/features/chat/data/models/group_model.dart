import 'package:education_app/core/common/features/chat/domain/entities/group.dart';
import 'package:education_app/core/utils/typedef.dart';

class GroupModel extends Group {
  const GroupModel({
    required super.id,
    required super.name,
    required super.courseId,
    required super.members,
    super.lastMessage,
    super.groupImageUrl,
    super.lastMessageTimeStamp,
    super.lastMessageSenderName,
  });

  GroupModel.empty()
      : this(
          id: '_empty.id',
          name: '_empty.name',
          courseId: '_empty.courseId',
          members: const [],
          lastMessage: '',
          groupImageUrl: '',
          lastMessageTimeStamp: DateTime.now(),
          lastMessageSenderName: '',
        );

  GroupModel.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          courseId: map['courseId'] as String,
          members: List<String>.from(map['members'] as List<dynamic>),
          lastMessage: map['lastMessage'] as String?,
          groupImageUrl: map['groupImageUrl'] as String?,
          lastMessageTimeStamp: map['lastMessageTimeStamp'] as DateTime?,
          lastMessageSenderName: map['lastMessageSenderName'] as String?,
        );

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'courseId': courseId,
      'members': members,
      'lastMessage': lastMessage,
      'groupImageUrl': groupImageUrl,
      'lastMessageTimeStamp': lastMessageTimeStamp,
      'lastMessageSenderName': lastMessageSenderName,
    };
  }

  GroupModel copyWith({
    String? id,
    String? name,
    String? courseId,
    List<String>? members,
    String? lastMessage,
    String? groupImageUrl,
    DateTime? lastMessageTimeStamp,
    String? lastMessageSenderName,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? super.name,
      courseId: courseId ?? super.courseId,
      members: members ?? super.members,
      lastMessage: lastMessage ?? super.lastMessage,
      groupImageUrl: groupImageUrl ?? super.groupImageUrl,
      lastMessageTimeStamp: lastMessageTimeStamp ?? super.lastMessageTimeStamp,
      lastMessageSenderName:
          lastMessageSenderName ?? super.lastMessageSenderName,
    );
  }
}
