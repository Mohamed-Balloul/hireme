import 'package:hireme/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final String title;
  final String content;
  final String initialValue;
  final bool isNumber;
  final IconData icon1;
  final IconData icon2;
  final void Function()? onTap;

  const CustomRow({
    super.key,
    required this.title,
    required this.content,
    required this.initialValue,
    required this.isNumber,
    required this.icon1,
    required this.icon2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: Icon(
                icon1,
                color: AppColor.primaryColor,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.greenblack,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                right: 5,
              ),
              child: Text(content),
            ),
            InkWell(
              onTap: () {
                //

// // دالة لإظهار مربع حوار التعديل
// void showEditDialog({
//   required BuildContext context,
//   required String title,       // عنوان الـ Dialog (مثلاً: تعديل الإيميل)
//   required String initialValue, // القيمة القديمة لتظهر داخل الحقل
//   required Function(String) onSave, // دالة التنفيذ عند الضغط على حفظ
//   bool isNumber = false,       // خيار إضافي لتحديد نوع الكيبورد
// }) {
//   // ننشئ كونترولر ونعطيه القيمة الابتدائية
                final TextEditingController textController =
                    TextEditingController(text: initialValue);

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        mainAxisSize:
                            MainAxisSize.min, // لجعل الحجم يناسب المحتوى فقط
                        children: [
                          TextField(
                            controller: textController,
                            keyboardType: isNumber
                                ? TextInputType.phone
                                : TextInputType.text,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: "أدخل القيمة الجديدة",
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        // زر الإلغاء
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("إلغاء",
                              style: TextStyle(color: Colors.grey)),
                        ),
                        // زر الحفظ
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // نفس لون تطبيقك
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            // هنا نمرر القيمة الجديدة للدالة onSave
                            // onSave(textController.text);
                            Navigator.pop(context); // إغلاق الـ Dialog
                          },
                          child: const Text("حفظ",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    );
                  },
                );
// }
                //
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        width: 2,
                        color: AppColor.primaryColor,
                      )),
                  child: const Padding(
                    padding: EdgeInsets.all(3.5),
                    child: Icon(
                      Icons.edit,
                      color: AppColor.greenblack,
                      size: 11,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Divider(
          // color: AppColor.greenblack,
          color: AppColor.grey,
          thickness: 2,
        )
      ],
    );
  }
}
