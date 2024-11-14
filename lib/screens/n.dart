import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 必须导入这个包

class QPasswordGeneratorPage extends StatelessWidget {
  final String _generatedPassword = "ExamplePassword123!";

  const QPasswordGeneratorPage({super.key}); // 示例密码

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("随机密码生成器"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // 将密码复制到剪贴板
                Clipboard.setData(ClipboardData(text: _generatedPassword));

                // 显示提示消息
                _showSnackBar(context, "已复制到剪贴板");
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  _generatedPassword,
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
