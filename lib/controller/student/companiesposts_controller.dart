// import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/controller/student/studenthome_controller.dart';
import 'package:hireme/data/datasource/static/static.dart';
import 'package:get/get.dart';
import 'package:hireme/data/model/companiespostmodel.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/view/screen/company/companyprofile.dart';
import 'package:hireme/view/screen/student/sendrequesttocompany.dart';

abstract class CompaniesPostsController extends GetxController {
  // goToPostDetails(CompanyPostModel companyPostModel);
  goToSendRequestToCompany(CompaniesPostModel companiesPostModel);
  goToCompanyProfile(String companyName);
  action(int index);
  change(int index);
  //--
  getAllCompaniesPosts();
}

class CompaniesPostsControllerImp extends CompaniesPostsController {
  StudentHomeControllerImp homeController =
      Get.find<StudentHomeControllerImp>();
  int currentIndex = 0;
  //--
  List<CompaniesPostModel> allCompaniesPosts = [];
  //--
  // متغير للتحكم في حالة الفتح والإغلاق

  List<bool>? isExpanded = [];
  @override
  void onInit() {
    getAllCompaniesPosts(); // استدعاء البيانات فوراً عند فتح الصفحة
    super.onInit();
    // for (int i = 0; i < allcompaniesPosts.length; i++) {
    //   isExpanded!.add(false);
    // }
  }

  @override
  getAllCompaniesPosts() {
    // جلب البيانات الحقيقية من الهوم كنترولر
    allCompaniesPosts = homeController.allCompaniesAds;

    // تهيئة قائمة "عرض المزيد" بناءً على عدد البيانات الحقيقية المجلوبة
    isExpanded = List.generate(allCompaniesPosts.length, (index) => false);

    update(); // تحديث الواجهة
  }

  @override
  action(index) {
    isExpanded![index] = !isExpanded![index];
    update();
  }

  @override
  change(index) {
    currentIndex = index;
    update();
  }

  @override
  goToSendRequestToCompany(companiesPostModel) {
    Get.to(() => SendRequestToCompany(companiesPostModel: companiesPostModel));
  }

  @override
  goToCompanyProfile(companyName) {
    // البحث في قائمة بروفايلات الشركات عن الشركة التي تملك نفس الاسم
    CompanyProfileModel? companyData = companyProfileList.firstWhere(
      (element) => element.name == companyName,
      orElse: () => companyProfileList[0], // قيمة افتراضية في حال عدم الوجود
    );

    Get.to(() => CompanyProfile(
          company: companyData,
          isMine: false, // لأن الزائر طالب وليس صاحب الشركة
        ));
  }
}
