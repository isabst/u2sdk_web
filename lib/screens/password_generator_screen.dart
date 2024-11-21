import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart'; // 必须导入这个包
import 'package:u2stk_web/router.dart';
import 'package:provider/provider.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  int _passwordLength = 12;
  bool _includeNumbers = true;
  bool _includeSymbols = true;
  String _generatedPassword = "";

  void showCustomToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50.0,
        left: MediaQuery.of(context).size.width * 0.5 - 75,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xCC000000), // 半透明黑色
              borderRadius: BorderRadius.circular(12.0), // 苹果风格圆角
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFFE0E0E0), // 浅灰文本色
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'SF Pro Text', // 尝试苹果风格的字体 (需自定义导入或在 iOS 上生效)
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2))
        .then((value) => overlayEntry.remove());
  }

  void _generatePassword() {
    const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const numbers = "0123456789";
    const symbols = "!@#\$%^&*()-_=+{}[]|;:<>,.?/";

    String chars = letters;
    if (_includeNumbers) chars += numbers;
    if (_includeSymbols) chars += symbols;

    final rand = Random();
    String password = List.generate(
        _passwordLength, (index) => chars[rand.nextInt(chars.length)]).join();
    setState(() {
      _generatedPassword = password;
    });
  }

  void _onPageLoaded() {
    context.read<TitleProvider>().updateTitle('随机密码生成');
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onPageLoaded();
    });
    return Scaffold(
      backgroundColor: const Color(0xfffafafc),
      appBar: AppBar(
          title: const Text(
            "随机密码生成",
            style: TextStyle(fontFamily: 'SF Pro Text'),
          ),
          backgroundColor: const Color(0xfffafafc),
          elevation: 0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 545,
            height: 453,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: const Color(0xfff5f5f7),
              borderRadius: BorderRadius.circular(12.0), // 圆角半径
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12, // 阴影颜色
                  blurRadius: 1.0, // 阴影模糊半径
                  offset: Offset(0, 2), // 阴影偏移
                ),
              ],
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Adjusts column height to fit content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    "密码长度: $_passwordLength",
                    style: const TextStyle(fontFamily: 'SF Pro Text'),
                  ),
                ),

                SizedBox(
                    child: Slider(
                  value: _passwordLength.toDouble(),
                  min: 8,
                  max: 32,
                  divisions: 24,
                  label: _passwordLength.toString(),
                  inactiveColor: const Color(0xFFD1D1D6),
                  activeColor: const Color(0xFF007AFF),
                  onChanged: (value) {
                    setState(() {
                      _passwordLength = value.toInt();
                    });
                  },
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _includeNumbers,
                      activeColor:
                          const Color(0xFF007AFF), // 苹果风格的蓝色，用于选中状态的填充色
                      checkColor: Colors.white, // 选中状态下的勾选颜色
                      side: const BorderSide(
                        color: Color(0xFFD1D1D6), // 苹果风格的浅灰色，用于未选中状态的边框色
                        width: 2.0, // 边框宽度，保持简洁
                      ),
                      onChanged: (value) {
                        setState(() {
                          _includeNumbers = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 120, // 统一宽度确保左对齐
                      child: Text(
                        "包含数字",
                        style: TextStyle(fontFamily: 'SF Pro Text'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _includeSymbols,
                      activeColor:
                          const Color(0xFF007AFF), // 苹果风格的蓝色，用于选中状态的填充色
                      checkColor: Colors.white, // 选中状态下的勾选颜色
                      side: const BorderSide(
                        color: Color(0xFFD1D1D6), // 苹果风格的浅灰色，用于未选中状态的边框色
                        width: 2.0, // 边框宽度，保持简洁
                      ),
                      onChanged: (value) {
                        setState(() {
                          _includeSymbols = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 120, // 统一宽度确保左对齐
                      child: Text(
                        "包含符号",
                        style: TextStyle(fontFamily: 'SF Pro Text'),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: _generatePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007AFF),
                        foregroundColor: Colors.white, // White text color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12), // 增加按钮内边距
                        elevation: 0, // 去除阴影，保持扁平的设计
                      ),
                      child: const Text(
                        "生成密码",
                        style: TextStyle(fontFamily: 'SF Pro Text'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("生成的密码:",
                    style: TextStyle(fontFamily: 'SF Pro Text')),
                GestureDetector(
                  onTap: () {
                    // 将密码复制到剪贴板
                    Clipboard.setData(ClipboardData(text: _generatedPassword));
                    // 显示提示消息
                    showCustomToast(context, "已复制到剪贴板");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      _generatedPassword,
                      style: const TextStyle(
                        color: Color(0xFF1C1C1E), // 深灰色，符合苹果风格
                        fontSize: 16.0, // 合适的字体大小
                        fontWeight: FontWeight.w500, // 字重适中
                        fontFamily:
                            'SF Pro Text', // 尝试苹果风格的字体 (需自定义导入或在 iOS 上生效)
                      ),
                    ),
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.all(8.0),
                //   margin: const EdgeInsets.only(top: 10),
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey),
                //     borderRadius: BorderRadius.circular(8.0),
                //   ),
                //   child: SelectableText(
                //     _generatedPassword,
                //     style: const TextStyle(fontSize: 20, color: Colors.blue),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
