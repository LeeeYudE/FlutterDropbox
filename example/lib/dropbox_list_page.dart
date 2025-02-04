import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:dropbox_client/dropbox_list_model.dart';

/// 日期：2025/2/2
/// 描述：
class DropboxListPage extends StatefulWidget {
  final String path;

  const DropboxListPage({required this.path});

  @override
  State<DropboxListPage> createState() => _DropboxListPageState();
}

class _DropboxListPageState extends State<DropboxListPage> {
  List<DropboxListModel> list = [];

  @override
  void initState() {
    listFolder(widget.path);
    super.initState();
  }

  Future listFolder(path) async {
    final result = await Dropbox.listFolder(path);
    setState(() {
      list.clear();
      list.addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.path),
      ),
      body: ListView.separated(
          itemBuilder: (con, index) {
            final item = list[index];
            final filesize = item.filesize;
            final path = item.pathLower ?? '';
            bool isFile = !(item.isDir ?? false);
            var name = item.name ?? '';
            if (filesize == null) {
              name += '/';
            } else {
              isFile = true;
            }
            return ListTile(
                title: Text(name),
                onTap: () async {
                  if (isFile) {
                    final result = await Dropbox.getTemporaryLink(path);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(result ?? 'getTemporaryLink error: $path')));
                    print(result);
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DropboxListPage(path: path)));
                  }
                });
          },
          separatorBuilder: (con, inex) {
            return Divider();
          },
          itemCount: list.length),
    );
  }
}
