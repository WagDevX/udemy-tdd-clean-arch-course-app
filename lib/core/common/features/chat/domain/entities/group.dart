import 'package:equatable/equatable.dart';

class Group extends Equatable {
  const Group({
    required this.id,
    required this.name,
    required this.courseId,
    required this.members,
    this.lastMessage,
    this.groupImageUrl,
    this.lastMessageTimeStamp,
    this.lastMessageSenderName,
  });

  Group.empty()
      : this(
          id: '_empty.id',
          name: '_empty.name',
          courseId: '_empty.courseId',
          members: [],
          lastMessage: null,
          groupImageUrl: null,
          lastMessageTimeStamp: null,
          lastMessageSenderName: null,
        );

  final String id;
  final String name;
  final String courseId;
  final List<String> members;
  final String? lastMessage;
  final String? groupImageUrl;
  final DateTime? lastMessageTimeStamp;
  final String? lastMessageSenderName;

  @override
  List<Object> get props => [id, name, courseId];
}
