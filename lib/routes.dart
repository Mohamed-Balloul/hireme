import 'package:hireme/core/constant/routes.dart';
import 'package:hireme/core/middleware/mymiddlewate.dart';
// import 'package:hireme/core/middleware/mymiddlewate.dart';
import 'package:hireme/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:hireme/view/screen/auth/login.dart';
import 'package:hireme/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:hireme/view/screen/auth/signup.dart';
import 'package:hireme/view/screen/auth/forgetpassword/successresetpassword.dart';
import 'package:hireme/view/screen/auth/successsignup.dart';
import 'package:hireme/view/screen/auth/forgetpassword/verfiycode.dart';
import 'package:hireme/view/screen/auth/verfiycodesignup.dart';
// import 'package:hireme/view/screen/bottomnavigationbar/bottomnavigationbar.dart';
import 'package:hireme/view/screen/checkout/checkout.dart';
import 'package:hireme/view/screen/company/addcompanypost.dart';
import 'package:hireme/view/screen/company/comingrequestsoncompanypost.dart';
import 'package:hireme/view/screen/company/companybottomnavigationbar/companybottomnavigationbar.dart';
import 'package:hireme/view/screen/company/companycomingrequests.dart';
import 'package:hireme/view/screen/company/companyhome.dart';
import 'package:hireme/view/screen/company/companypostdetails.dart';
import 'package:hireme/view/screen/company/editcompanypost.dart';
import 'package:hireme/view/screen/company/incoming_applications_screen.dart';
// import 'package:hireme/view/screen/company/companyposts.dart';
import 'package:hireme/view/screen/completeyourprofile/completeyourfile.dart';
import 'package:hireme/view/screen/customer/addcustomerpost.dart';
import 'package:hireme/view/screen/customer/comingrequestsoncustomerpost.dart';
import 'package:hireme/view/screen/customer/customerbottomnavigationbar/customerbottomnavigationbar.dart';
import 'package:hireme/view/screen/customer/customercomingrequests.dart';
import 'package:hireme/view/screen/customer/customerhome.dart';
import 'package:hireme/view/screen/customer/customerpostsdetails.dart';
import 'package:hireme/view/screen/customer/editcustomerpost.dart';
import 'package:hireme/view/screen/customer/incomingapplicationstocustomerscreen.dart';
import 'package:hireme/view/screen/home/homepage.dart';
// import 'package:hireme/view/screen/language.dart';
import 'package:hireme/view/screen/letsgetstarted.dart';
import 'package:hireme/view/screen/mycart/mycart.dart';
// import 'package:hireme/view/screen/myorders/myorders.dart';
import 'package:hireme/view/screen/mywishlist/mywishlist.dart';
import 'package:hireme/view/screen/onboarding.dart';
import 'package:hireme/view/screen/paymentmethods/paymentmethods.dart';
import 'package:hireme/view/screen/paymentsuccessfuly/paymentsuccessfuly.dart';
// import 'package:hireme/view/screen/profile/profile.dart';
// import 'package:hireme/view/screen/productdetails.dart/productdetails.dart';
import 'package:get/get.dart';
import 'package:hireme/view/screen/splash/splash.dart';
import 'package:hireme/view/screen/student/companiesposts.dart';
import 'package:hireme/view/screen/student/coverpreviewpage.dart';
// import 'package:hireme/view/screen/student/companypostdetails.dart';
import 'package:hireme/view/screen/student/freelancerposts.dart';
// import 'package:hireme/view/screen/student/companypostdetails.dart';
import 'package:hireme/view/screen/student/myorders.dart';
import 'package:hireme/view/screen/student/sendrequesttocustomer.dart';
// import 'package:hireme/view/screen/student/sendrequesttocompany.dart';
import 'package:hireme/view/screen/student/studenthome.dart';
import 'package:hireme/view/screen/student/studentnotifications.dart';
import 'package:hireme/view/screen/student/studentprofile.dart';
import 'package:hireme/view/screen/student/studentbottomnavigationbar/studentbottomnavigationbar.dart';

List<GetPage<dynamic>>? routes = [
  // First page
  // GetPage(name: "/", page: () => const Language(), middlewares: [
  //   MyMiddleware(),
  // ]),
  // GetPage(name: "/", page: () => const Splash()),
  // داخل قائمة الـ getPages في ملف main.dart أو ملف المسارات الخاص بك:

  GetPage(
    name: "/", // المسار الافتراضي لبداية تشغيل التطبيق (Splash أو Onboarding)
    page: () => const Splash(), // أو اسم صفحة السبلاتش لديك
    middlewares: [
      AuthMiddleware(), // ربط الوسيط هنا ليفحص البيانات قبل رندر أي شاشة
    ],
  ),
  // OnBoarding
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),
  // Auth
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.signUp, page: () => const SignUp()),
  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoute.verfiyCode, page: () => const VerfiyCode()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(
      name: AppRoute.successResetPassword,
      page: () => const SuccessResetPassword()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
  GetPage(
      name: AppRoute.verfiyCodeSignUp, page: () => const VerfiyCodeSignUp()),
  // Let's Get Started
  GetPage(name: AppRoute.letsGetStarted, page: () => const LetsGetStarted()),
  // Complete Your Profile
  GetPage(
      name: AppRoute.completeYourProfile,
      page: () => const CompleteYourProfile()),
  // Home
  GetPage(name: AppRoute.homePage, page: () => const HomePage()),
  // Home
  GetPage(name: AppRoute.myWishList, page: () => const MyWishList()),
  // My Cart
  GetPage(name: AppRoute.myCart, page: () => const MyCart()),
  // Bottom Navigation Bar Page
  // GetPage(
  //     name: AppRoute.bottomNavigationBarPage,
  //     page: () => const BottomNavigationBarr()),
  // Checkout Page
  GetPage(name: AppRoute.checkout, page: () => const Checkout()),
  // Payment Methods
  GetPage(name: AppRoute.paymentMethonds, page: () => const PaymentMethods()),
  // Payment Successfuly
  GetPage(
      name: AppRoute.paymentSuccessfuly,
      page: () => const PaymentSuccessfuly()),
  // My Orders
  // GetPage(name: AppRoute.myOrders, page: () => const MyOrders()),
  // // Profile
  // GetPage(name: AppRoute.profile, page: () => const Profile()),
  // Splash
  GetPage(name: AppRoute.splash, page: () => const Splash()),
  // -----------------------------------------------------------Student
  // Student Home
  GetPage(name: AppRoute.studentHome, page: () => const StudentHome()),
  // Companies Posts
  GetPage(name: AppRoute.companiesPosts, page: () => const CompaniesPosts()),
  // Freelancer Posts
  GetPage(name: AppRoute.freelancerPosts, page: () => const FreelancerPosts()),
  // Student Profile
  // GetPage(name: AppRoute.studentProfile, page: () => const StudentProfile()),
  // Student Bottom Navigation Bar
  GetPage(
      name: AppRoute.studentBottomNavigationBarPage,
      page: () => const StudentBottomNavigationBarr()),
  // Student Orders
  GetPage(name: AppRoute.myOrders, page: () => const MyOrders()),
  // Student Notifications
  GetPage(
      name: AppRoute.studentNotifications,
      page: () => const StudentNotifications()),
  // Send Request To Company
  // GetPage(
  //     name: AppRoute.sendRequestToCompany,
  //     page: () => const SendRequestToCompany()),
  //Send Request To Company
  // GetPage(
  //     name: AppRoute.sendRequestToCustomer,
  //     page: () => const SendRequestToCustomer()),
  //Cover preview page
  // GetPage(
  //     name: AppRoute.coverPreviewPage, page: () => const CoverPreviewPage()),
  // Post Details
  // GetPage(name: AppRoute.postDetails, page: () => const PostDetails()),
  // Product Details
  // GetPage(name: AppRoute.productDetails, page: () => const ProductDetails()),
  //-------------------------------------------------------------- Company
  // Company Bottom Navigation Bar
  GetPage(
      name: AppRoute.companyBottomNavigationBarPage,
      page: () => const CompanyBottomNavigationBarr()),
  // Company Home
  GetPage(name: AppRoute.companyHome, page: () => const CompanyHome()),
  // Company Posts
  // GetPage(name: AppRoute.companyPosts, page: () => const CompanyPosts()),
  // Company Posts Details
  GetPage(
      name: AppRoute.companyPostsDetails,
      page: () => const CompanyPostsDetails()),
  // Add CompanyPost
  GetPage(name: AppRoute.addCompanyPost, page: () => const AddCompanyPost()),
  // Edit CompanyPost
  GetPage(name: AppRoute.editCompanyPost, page: () => const EditCompanyPost()),
  // Coming Company Requests
  GetPage(
      name: AppRoute.companyComingRequests,
      page: () => const CompanyComingRequests()),
  // Coming Requests On Company Post
  GetPage(
      name: AppRoute.comingRequestsOnCompanyPost,
      page: () => const ComingRequestsOnCompanyPost()),
//Incoming Applications Screen
  GetPage(
      name: AppRoute.incomingApplicationsScreen,
      page: () => const IncomingApplicationsScreen()),
  //-------------------------------------------------------------- Customer
  // Customer Bottom Navigation Bar
  GetPage(
      name: AppRoute.customerBottomNavigationBarPage,
      page: () => const CustomerBottomNavigationBarr()),
  // Customer Home
  GetPage(name: AppRoute.customerHome, page: () => const CustomerHome()),
  // Customer Posts Details
  GetPage(
      name: AppRoute.customerPostsDetails,
      page: () => const CustomerPostsDetails()),
  // Add customer Post
  GetPage(name: AppRoute.addCustomerPost, page: () => const AddCustomerPost()),
  // Edit customer Post
  GetPage(
      name: AppRoute.editCustomerPost, page: () => const EditCustomerPost()),
  // Coming Customer Requests
  GetPage(
      name: AppRoute.customerComingRequests,
      page: () => const CustomerComingRequests()),
  // Coming Requests On Customer Post
  GetPage(
      name: AppRoute.comingRequestsOnCustomerPost,
      page: () => const ComingRequestsOnCustomerPost()),
  // Coming Requests On Customer Post
  GetPage(
      name: AppRoute.incomingApplicationsToCustomerScreen,
      page: () => const IncomingApplicationsToCustomerScreen()),
];
