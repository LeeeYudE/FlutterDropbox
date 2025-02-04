/// 日期：2025/2/2
/// 描述：
class DropboxListModel {

  final String? pathDisplay;
  final String? pathLower;
  final String? name;
  final String? clientModified;
  final String? serverModified;
  final int? filesize;
  final bool? isDir;

  DropboxListModel({
    this.pathDisplay,
    this.pathLower,
    this.name,
    this.clientModified,
    this.serverModified,
    this.filesize,
    this.isDir,
  });

  factory DropboxListModel.fromJson(Map<dynamic, dynamic> json) {
    return DropboxListModel(
      pathDisplay: json['path_display'],
      pathLower: json['path_lower'],
      name: json['name'],
      clientModified: json['client_modified'],
      serverModified: json['server_modified'],
      filesize: json['filesize'],
      isDir: json['id_dir'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path_display': pathDisplay,
      'path_lower': pathLower,
      'name': name,
      'client_modified': clientModified,
      'server_modified': serverModified,
      'filesize': filesize,
      'id_dir': isDir,
    };
  }

}