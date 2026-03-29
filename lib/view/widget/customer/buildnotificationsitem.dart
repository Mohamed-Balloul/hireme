import 'package:flutter/material.dart';
import 'package:hireme/controller/customer/customernotifications_controller.dart';
import 'package:hireme/data/model/studentnotificationmodel.dart';
import 'package:hireme/view/widget/student/profile_dialogs.dart';

class BuildNotificationsItem extends StatelessWidget {
  final StudentNotificationModel notification;
  final CustomerNotificationsControllerImp controller;
  const BuildNotificationsItem(
      {super.key, required this.notification, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const Divider(height: 1, thickness: 0.5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. صورة المرسل (يمين في RTL)
              InkWell(
                onTap: () {
                  controller.goToStudentProfile(notification.senderName!);
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade100,
                  backgroundImage: NetworkImage(notification.senderImage!),
                ),
              ),

              const SizedBox(width: 12),

              // 2. منطقة المحتوى (الاسم + النص + الحذف)
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // السطر الأول: الاسم والتوقيت
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.goToStudentProfile(
                                    notification.senderName!);
                              },
                              child: Text(
                                notification.senderName!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            if (notification.isVerified!)
                              const Padding(
                                padding: EdgeInsets.only(right: 4),
                                child: Icon(Icons.verified,
                                    color: Colors.blue, size: 14),
                              ),
                            const Spacer(),
                            Text(
                              notification.time!,
                              style: TextStyle(
                                  color: Colors.grey.shade400, fontSize: 11),
                            ),
                            if (!notification.isRead!)
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // السطر الثاني: نص الإشعار
                        // أضفنا Padding من اليسار لترك مساحة للسلة وللهامش الجمالي
                        Padding(
                          padding: const EdgeInsets.only(left: 25, bottom: 2),
                          child: Text(
                            notification.content!,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 3. أيقونة الحذف في الزاوية اليسرى السفلى (بمستوى آخر سطر)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: InkWell(
                        onTap: () {
                          ProfileDialogs.showConfirmDialog(
                            title: "هل أنت متأكد أنك تريد حذف هذا الإشعار؟",
                            onConfirm: () =>
                                controller.deleteNotification(notification.id!),
                          );
                        },
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.grey.shade300,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 0.5),
      ],
    );
  }
}
