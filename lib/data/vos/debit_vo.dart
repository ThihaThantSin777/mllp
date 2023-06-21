import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mllp/constant/hive_constant.dart';

part 'debit_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeForDebitVo)
class DebitVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;

  @JsonKey(name: 'image_url')
  @HiveField(1)
  String? imageURL;

  @JsonKey(name: 'remark')
  @HiveField(2)
  String? remark;

  @JsonKey(name: 'save_data')
  @HiveField(3)
  DateTime? saveDate;

  DebitVO({this.id, this.imageURL, this.remark, this.saveDate});

  factory DebitVO.fromJson(Map<String, dynamic> json) =>
      _$DebitVOFromJson(json);

  Map<String, dynamic> toJson() => _$DebitVOToJson(this);
}
