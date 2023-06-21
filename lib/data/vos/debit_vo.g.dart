// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debit_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebitVOAdapter extends TypeAdapter<DebitVO> {
  @override
  final int typeId = 1;

  @override
  DebitVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DebitVO(
      id: fields[0] as int?,
      imageURL: fields[1] as String?,
      remark: fields[2] as String?,
      saveDate: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, DebitVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageURL)
      ..writeByte(2)
      ..write(obj.remark)
      ..writeByte(3)
      ..write(obj.saveDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebitVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebitVO _$DebitVOFromJson(Map<String, dynamic> json) => DebitVO(
      id: json['id'] as int?,
      imageURL: json['image_url'] as String?,
      remark: json['remark'] as String?,
      saveDate: json['save_data'] == null
          ? null
          : DateTime.parse(json['save_data'] as String),
    );

Map<String, dynamic> _$DebitVOToJson(DebitVO instance) => <String, dynamic>{
      'id': instance.id,
      'image_url': instance.imageURL,
      'remark': instance.remark,
      'save_data': instance.saveDate?.toIso8601String(),
    };
