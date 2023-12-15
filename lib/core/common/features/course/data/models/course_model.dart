import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/utils/typedef.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.title,
    required super.numberOfExams,
    required super.numberOfMaterials,
    required super.numberOfVideos,
    required super.groupId,
    required super.createdAt,
    required super.updatedAt,
    super.description,
    super.image,
    super.imageIsFile = false,
  });

  CourseModel.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          numberOfExams: 0,
          numberOfMaterials: 0,
          numberOfVideos: 0,
          description: '_empty.description',
          groupId: '_empty.groupId',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

  CourseModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          title: map['title'] as String,
          description: map['description'] as String?,
          groupId: map['groupId'] as String,
          numberOfExams: (map['numberOfExams'] as num).toInt(),
          numberOfMaterials: (map['numberOfMaterials'] as num).toInt(),
          numberOfVideos: (map['numberOfVideos'] as num).toInt(),
          image: map['image'] as String?,
          createdAt: (map['createdAt'] as Timestamp).toDate(),
          updatedAt: (map['updatedAt'] as Timestamp).toDate(),
        );

  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? groupId,
    int? numberOfExams,
    int? numberOfMaterials,
    int? numberOfVideos,
    bool? imageIsFile,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      groupId: groupId ?? this.groupId,
      numberOfExams: numberOfExams ?? this.numberOfExams,
      numberOfMaterials: numberOfMaterials ?? this.numberOfMaterials,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
      imageIsFile: imageIsFile ?? this.imageIsFile,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  DataMap toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'groupId': groupId,
        'numberOfExams': numberOfExams,
        'numberOfMaterials': numberOfMaterials,
        'numberOfVideos': numberOfVideos,
        'image': image,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
}
