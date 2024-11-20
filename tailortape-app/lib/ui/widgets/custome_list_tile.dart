import 'package:flutter/material.dart';

class MyListTile extends StatefulWidget {
  final String title;
  final IconData? leading;
  final IconData trailing;
  final String? subtitle;
  final VoidCallback? onTap;

  const MyListTile(
      {super.key,
      required this.title,
      this.leading,
      required this.trailing,
      this.subtitle,
      this.onTap});

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.leading != null ? Icon(widget.leading) : null,
      title: Text(widget.title),
      trailing: widget.onTap == null
          ? Icon(widget.trailing)
          : TextButton(onPressed: widget.onTap!, child: Icon(widget.trailing)),
      subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
    );
  }
}
