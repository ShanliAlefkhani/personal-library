// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FolderAdapter extends TypeAdapter<Folder> {
  @override
  Folder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Folder(
      fields[0] as String,
    )..currentWallPaper = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Folder obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.currentWallPaper);
  }

  //inja hive
  @override
  // TODO: implement typeId
  int get typeId => throw UnimplementedError();
}
