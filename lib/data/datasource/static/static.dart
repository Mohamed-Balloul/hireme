//The Original Static Data
//
import 'package:hireme/core/constant/imageassets.dart';
import 'package:hireme/data/model/IncomingRequestsToCustomerModel.dart';
import 'package:hireme/data/model/MyWishListGridmodel.dart';
import 'package:hireme/data/model/beststudentsmodel.dart';
import 'package:hireme/data/model/comingrequestoncompanypostmodel.dart';
import 'package:hireme/data/model/companiespostmodel.dart';
import 'package:hireme/data/model/companypostincompanyhomemodel.dart';
import 'package:hireme/data/model/companypostmodel.dart';
// import 'package:hireme/data/model/companypostmodel.dart';
import 'package:hireme/data/model/companyprofilemodel.dart';
import 'package:hireme/data/model/customernotificationmodel.dart';
import 'package:hireme/data/model/customerpostincustomerhomemodel.dart';
import 'package:hireme/data/model/customerpostmodel.dart';
import 'package:hireme/data/model/customerprofilemodel.dart';
import 'package:hireme/data/model/freelancerpostmodel.dart';
import 'package:hireme/data/model/homecategorieswithlabelmodel.dart';
import 'package:hireme/data/model/homegridflashsalesmodel.dart';
import 'package:hireme/data/model/homeslidermodel.dart';
import 'package:hireme/data/model/incomingrequeststocompanymodel.dart';
import 'package:hireme/data/model/letsgetstartedmodel.dart';
import 'package:hireme/data/model/mypostascompany.dart';
import 'package:hireme/data/model/mypostascustomer.dart';
import 'package:hireme/data/model/myrequesttocompanymodel.dart';
import 'package:hireme/data/model/myrequesttocustomermodel.dart';
import 'package:hireme/data/model/newestcompanyjobs.dart';
import 'package:hireme/data/model/newestfreelancermodel.dart';
import 'package:hireme/data/model/onboardingmodel.dart';
import 'package:flutter/material.dart';
import 'package:hireme/data/model/studentnotificationmodel.dart';
import 'package:hireme/data/model/studentprofilemodel.dart';

//In This Case We Have Multiple Pages, Each element belongs to page
//
List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    title: "Seamless Shopping \n Experience",
    image: AppImageAssets.onBoardingImageOne,
    body: "hireMe " +
        "يعمل على توفير فرص العمل لطلاب \nوخريجي الهندسة المعلوماتية",
  ),
  OnBoardingModel(
    title: "Wishlist: Where Fashion \n Dreams Begin",
    image: AppImageAssets.onBoardingImageTwo,
    // image: AppImageAssets.onBoardingImageOne,
    body: "hireMe " +
        "يعمل على رفد الشركات بأفضل \nالطلاب والخريجين الباحثين عن فرصة عمل",
  ),
  OnBoardingModel(
    title: "Swift and Reliable \n Delivery",
    image: AppImageAssets.onBoardingImageThree,
    // image: AppImageAssets.onBoardingImageOne,
    body: "hireMe " + "يمكن العملاء من إنجاز مشاريعهم\n من خلال أمهر الطلاب",
  ),
];
//--------- Let's Get Started
List<LetsGetStartedModel> letsGetStartedList = [
  LetsGetStartedModel(
    imageone: AppImageAssets.imOne,
    imagetwo: AppImageAssets.imTwo,
    imagethree: AppImageAssets.imThree,
    // imageone: AppImageAssets.onBoardingImageOne,
    // imagetwo: AppImageAssets.onBoardingImageOne,
    // imagethree: AppImageAssets.onBoardingImageOne,
    title: "The Fashion App That",
    body:
        "Lorem ipsum dolor sit amet, consectetur \n adipiscing elit, sed do eiusmod tempor incididunt",
    lastline: "هل لديك حساب بالفعل؟",
  )
];
// ------- Home Slider
List<HomeSliderModel> homeSliderList = [
  HomeSliderModel(
    title: "New Collection",
    subTitle: "Discount 50% for the first transaction",
    image: AppImageAssets.homeSliderImageOne,
  ),
  HomeSliderModel(
    title: "Summer Sale",
    subTitle: "Hot styles up to 70% off!",
    image: AppImageAssets.homeSliderImageTwo,
  ),
  HomeSliderModel(
    title: "Trendy pieces just for you",
    subTitle: "Discount 50% for the first transaction",
    image: AppImageAssets.homeSliderImageThree,
  ),
  HomeSliderModel(
    title: "Trendy pieces just for you",
    subTitle: "Discount 50% for the first transaction",
    image: AppImageAssets.homeSliderImageThree,
  ),
  HomeSliderModel(
    title: "Trendy pieces just for you",
    subTitle: "Discount 50% for the first transaction",
    image: AppImageAssets.homeSliderImageThree,
  ),
];

//-- home categories with label
List<HomeCategoriesWithLabelModel> homeCategoriesWithLableList = [
  HomeCategoriesWithLabelModel(
    icon: Icons.card_giftcard_rounded,
    label: "T-Shirt",
  ),
  HomeCategoriesWithLabelModel(
    icon: Icons.card_giftcard_rounded,
    label: "Jacket",
  ),
  HomeCategoriesWithLabelModel(
    icon: Icons.card_giftcard_rounded,
    label: "Pants",
  ),
  HomeCategoriesWithLabelModel(
    icon: Icons.card_giftcard_rounded,
    label: "Dress",
  ),
];
//-- flash sale categories in home page
List<String> flashSaleCategory = [
  "All",
  "Newest",
  "Popular",
  "Man",
  "Women",
  "Popular",
  "Man",
  "Women",
];
List<String> myWishListCategory = [
  "All",
  "Jacket",
  "Pants",
  "T-Shit",
  "Women",
  "Popular",
  "Man",
  "Women",
];
//-- flash sale categories in home page
List<String> selectSizeList = [
  "S",
  "M",
  "L",
  "XL",
  "XXL",
  "XXXL",
];
// ------- Home Grid Flash sales
List<HomeGridFlashSalesModel> homeGridFlashSalesList = [
  HomeGridFlashSalesModel(
    styleType: "Female's Style",
    fullLabel: "Light Brown T-Shirt",
    productDetalils:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    image: AppImageAssets.homeSliderImageOne,
    price: "\$220",
    label: "Brown Jacket",
    quantity: 1,
    size: "S",
  ),
  HomeGridFlashSalesModel(
    styleType: "Female's Style",
    fullLabel: "Light Brown T-Shirt",
    productDetalils:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    image: AppImageAssets.homeSliderImageOne,
    price: "\$220",
    label: "Blue Jacket",
    quantity: 1,
    size: "S",
  ),
  HomeGridFlashSalesModel(
    styleType: "Female's Style",
    fullLabel: "Light Brown T-Shirt",
    productDetalils:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    image: AppImageAssets.homeSliderImageOne,
    price: "\$220",
    label: "Yellow Jacket",
    quantity: 1,
    size: "S",
  ),
  HomeGridFlashSalesModel(
    styleType: "Female's Style",
    fullLabel: "Light Brown T-Shirt",
    productDetalils:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    image: AppImageAssets.homeSliderImageOne,
    price: "\$220",
    label: "Red Jacket",
    quantity: 1,
    size: "S",
  ),
  HomeGridFlashSalesModel(
    styleType: "Female's Style",
    fullLabel: "Light Brown T-Shirt",
    productDetalils:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    image: AppImageAssets.homeSliderImageOne,
    price: "\$220",
    label: "White Jacket",
    quantity: 1,
    size: "S",
  ),
  HomeGridFlashSalesModel(
    styleType: "Female's Style",
    fullLabel: "Light Brown T-Shirt",
    productDetalils:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    image: AppImageAssets.homeSliderImageOne,
    price: "\$220",
    label: "Black Jacket",
    quantity: 1,
    size: "S",
  ),
];
// ------- My Wish List Grid
List<MyWishListGridModel> myWishListGridList = [
  MyWishListGridModel(
    styleType: "Female's Style",
    fullLabel: "Light Brown T-Shirt",
    productDetalils:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    image: AppImageAssets.homeSliderImageOne,
    price: "\$220",
    label: "Brown Jacket",
  ),
  MyWishListGridModel(
    styleType: "Female's Style",
    fullLabel: "Light Brown Jacket",
    productDetalils:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    image: AppImageAssets.homeSliderImageOne,
    price: "\$220",
    label: "Brown Jacket",
  ),
  MyWishListGridModel(
    styleType: "Female's Style",
    fullLabel: "Light Brown Jacket",
    productDetalils:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    image: AppImageAssets.homeSliderImageOne,
    price: "\$220",
    label: "Brown Jacket",
  ),
  MyWishListGridModel(
    styleType: "Female's Style",
    fullLabel: "Light Brown Jacket",
    productDetalils:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    image: AppImageAssets.homeSliderImageOne,
    price: "\$220",
    label: "Brown Jacket",
  ),
  MyWishListGridModel(
    styleType: "Female's Style",
    fullLabel: "Light Brown Jacket",
    productDetalils:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    image: AppImageAssets.homeSliderImageOne,
    price: "\$220",
    label: "Brown Jacket",
  ),
  MyWishListGridModel(
    styleType: "Female's Style",
    fullLabel: "Light Brown Jacket",
    productDetalils:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    image: AppImageAssets.homeSliderImageOne,
    price: "\$220",
    label: "Brown Jacket",
  ),
];
//----------------
// ---------------------------------------- Student Data ----------------
//----------------

//---------------- Static Data :Newest Companies Posts -----------------
//----------
List<NewestCompanyJobModel> newestCompaniesPostsList = [
  NewestCompanyJobModel(
    title: "Flutter Developer",
    company: "Google Inc",
    image:
        'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?q=80&w=1000&auto=format&fit=crop',
  ),
  NewestCompanyJobModel(
    title: "UI/UX Designer",
    company: "Amazon",
    image:
        'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?q=80&w=1000&auto=format&fit=crop',
  ),
  NewestCompanyJobModel(
    title: "Backend Engineer",
    company: "Microsoft",
    image:
        'https://images.unsplash.com/photo-1600880292203-757bb62b4baf?q=80&w=1000&auto=format&fit=crop',
  ),
];
//---------------- Static Data :Newest Freelancer Posts -----------------
List<NewestFreelancerJobModel> newestFreelancerPostsList = [
  NewestFreelancerJobModel(
    title: "بناء متجر إلكتروني",
    publisher: "أحمد علي",
    image:
        'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?q=80&w=1000&auto=format&fit=crop',
  ),
  NewestFreelancerJobModel(
    title: "تطبيق مطعم",
    publisher: "سارة محمد",
    image:
        'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=1000&auto=format&fit=crop',
  ),
  NewestFreelancerJobModel(
    title: "تصميم شعار",
    publisher: "خالد",
    image:
        'https://images.unsplash.com/photo-1551288049-bebda4e38f71?q=80&w=1000&auto=format&fit=crop',
  ),
];
//---------------- Static Data : Companies Posts -----------------
List<CompanyPostModel> companiesPostsList = [
  CompanyPostModel(
    publisher: "Google",
    jobTitle: "Flutter Developer",
    mainResponsibilities: [
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات"
    ],
    requirements: [
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات"
    ],
    benefits: ["بيئة عمل مريحة", "تأمين اللوازم التقنية "],
    additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
    isCvRequired: true,
    isGitHubOrPortfolioRequired: true,
    isSalaryRequired: true,
  ),
  CompanyPostModel(
    publisher: "Amazon",
    jobTitle: "Flutter Developer",
    mainResponsibilities: [
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات",
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات",
    ],
    requirements: [
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات",
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات",
    ],
    benefits: [
      "بيئة عمل مريحة",
      "تأمين اللوازم التقنية ",
      "بيئة عمل مريحة",
      "تأمين اللوازم التقنية ",
    ],
    additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
    isCvRequired: false,
    isGitHubOrPortfolioRequired: true,
    isSalaryRequired: false,
  ),
];
//---------------- Static Data : freelancer Posts -----------------
// List<FreelancerPostModel> freelancerPostsList = [
//   FreelancerPostModel(
//     publisher: "محمد المحمود",
//     logo:
//         "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
//     time: "منذ يومين",
//     image:
//         'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?q=80&w=1000&auto=format&fit=crop',
//     applicants: 9,
//     serviceTitle: "بناء تطبيق موبايل",
//     tools: ["VSC", "Flutter"],
//     date: "اخر موعد للتقدم هو 20/11/2025",
//     description: "مرحبا أريد تطبيق للطقس",
//     files: "هنا تظهر الملفات المرفقة ",
//     additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
//   ),
//   FreelancerPostModel(
//     publisher: "محمد المحمود",
//     logo:
//         "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
//     time: "منذ يومين",
//     image:
//         'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?q=80&w=1000&auto=format&fit=crop',
//     applicants: 9,
//     serviceTitle: "بناء تطبيق موبايل",
//     tools: ["VSC", "Flutter"],
//     date: "اخر موعد للتقدم هو 20/11/2025",
//     description: "مرحبا أريد تطبيق للطقس",
//     files: "هنا تظهر الملفات المرفقة ",
//     additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
//   ),
//   FreelancerPostModel(
//     publisher: "محمد المحمود",
//     logo:
//         "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
//     time: "منذ يومين",
//     image:
//         'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?q=80&w=1000&auto=format&fit=crop',
//     applicants: 9,
//     serviceTitle: "بناء تطبيق موبايل",
//     tools: ["VSC", "Flutter"],
//     date: "اخر موعد للتقدم هو 20/11/2025",
//     description: "مرحبا أريد تطبيق للطقس",
//     files: "هنا تظهر الملفات المرفقة ",
//     additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
//   ),
// ];
List<FreelancerPostModel> freelancerPostsList = [
  // + + //
  // 1. مشروع متجر إلكتروني (تم تغيير صورة البوست + صورة الناشر)
  FreelancerPostModel(
    publisher: "أحمد العلي",
    // صورة شاب مبتسم (جديدة)
    logo:
        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",
    time: "منذ 3 ساعات",
    // صورة متجر ملابس أنيقة (جديدة ومجربة)
    image:
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000&auto=format&fit=crop',
    applicants: 15,
    serviceTitle: "إنشاء متجر إلكتروني للملابس",
    tools: ["Flutter", "Firebase", "Stripe API"],
    date: "20/12/2025",
    description:
        "أبحث عن مطور فلاتر محترف لبناء متجر لبيع الملابس الرجالية. التطبيق يجب أن يدعم الدفع الإلكتروني وتتبع الطلبات.",
    files: "التصميم المبدئي.pdf",
    additionalDetails: "الميزانية المتوقعة 800 - 1000 دولار",
  ),

  // 2. مشروع تصميم شعار (تم تغيير صورة البوست + صورة الناشرة)
  FreelancerPostModel(
    publisher: "سارة محمد",
    // صورة فتاة (جديدة)
    logo:
        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=200&auto=format&fit=crop",
    time: "منذ يوم واحد",
    // صورة أدوات رسم وتصميم (جديدة ومجربة)
    image:
        'https://images.unsplash.com/photo-1558655146-d09347e92766?q=80&w=1000&auto=format&fit=crop',
    applicants: 8,
    serviceTitle: "تصميم شعار لشركة ناشئة",
    tools: ["Adobe Illustrator", "Photoshop"],
    date: "15/11/2025",
    description:
        "نريد تصميم شعار عصري وبسيط لشركة تقنية جديدة متخصصة في الذكاء الاصطناعي. نحتاج 3 نماذج أولية.",
    files: "نبذة عن الشركة.docx",
    additionalDetails: "يفضل إرفاق معرض أعمال سابق",
  ),

  // 3. مشروع لوحة تحكم (تم تحديث صورة الناشر)
  FreelancerPostModel(
    publisher: "مازن خليل",
    // صورة رجل أعمال (جديدة)
    logo:
        "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=200&auto=format&fit=crop",
    time: "منذ 5 أيام",
    // صورة لابتوب وتحليل بيانات
    image:
        'https://images.unsplash.com/photo-1551288049-bebda4e38f71?q=80&w=1000&auto=format&fit=crop',
    applicants: 22,
    serviceTitle: "تطوير لوحة تحكم (Dashboard)",
    tools: ["React.js", "Node.js", "MongoDB"],
    date: "01/01/2026",
    description:
        "مطلوب مطور Full Stack لبناء لوحة تحكم لإدارة العقارات والمستأجرين. يجب أن تكون لوحة التحكم سريعة وتدعم تعدد اللغات.",
    files: "متطلبات النظام.pdf",
    additionalDetails: "المدة المتوقعة للتسليم شهرين",
  ),

  // 4. مشروع تطبيق توصيل (تم تحديث صورة الناشر)
  FreelancerPostModel(
    publisher: "كريم يوسف",
    // صورة شاب (جديدة)
    logo:
        "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=200&auto=format&fit=crop",
    time: "منذ أسبوع",
    // صورة خريطة وموبايل
    image:
        'https://images.unsplash.com/photo-1569383746724-6f1b882b8f46?q=80&w=1000&auto=format&fit=crop',
    applicants: 30,
    serviceTitle: "تطبيق توصيل طلبات",
    tools: ["Flutter", "Google Maps API", "Laravel"],
    date: "10/02/2026",
    description:
        "فكرة التطبيق مشابهة لتطبيقات التوصيل المعروفة. نحتاج نسخة للعميل ونسخة للمندوب ولوحة تحكم للإدارة.",
    files: "Wireframes.xd",
    additionalDetails: "نبحث عن فريق عمل وليس فرد واحد",
  ),
];
//---------------- Static Data : student profile -----------------
List<StudentProfileModel> studentProfileList = [
  StudentProfileModel(
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://i.pinimg.com/1200x/bd/d3/bc/bdd3bc41294ea5a7d04f70c36893d3eb.jpg",
    name: "يوسف حمدان",
    jobLabel: "Senior Flutter Developer",
    email: "Mohamedballoul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Homs",
    hourlySalary: 15,
    experienceYears: 5,
    skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    linkedIn: "https://github.com/Mohamed-Balloul",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    workExperiences: [
      {
        "companyName": "شركة أمازون",
        "jobTitle": "Flutter Developer",
        "startDate": "Jan 2024",
        "endDate": "حتى الآن",
        "logo":
            "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
        "isFreelancer": false,
      },
      {
        "companyName": "Freelance",
        "jobTitle": "UI/UX Designer",
        "startDate": "Mar 2022",
        "endDate": "Dec 2023",
        "logo": "",
        "isFreelancer": true,
      },
    ],
    rating: 4.5,
  ),
  StudentProfileModel(
    rating: 4.1,
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://i.pinimg.com/736x/dd/fc/ac/ddfcac65a67bc5ed50019958e99acfdd.jpg",
    name: "آلاء ناصيف",
    jobLabel: "Junior Flutter Developer",
    email: "Mohamedballoul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Homs",
    hourlySalary: 15,
    experienceYears: 5,
    skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    linkedIn: "https://github.com/Mohamed-Balloul",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    workExperiences: [
      {
        "companyName": "شركة أمازون",
        "jobTitle": "Flutter Developer",
        "startDate": "Jan 2024",
        "endDate": "حتى الآن",
        "logo":
            "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
        "isFreelancer": false,
      },
      {
        "companyName": "Freelance",
        "jobTitle": "UI/UX Designer",
        "startDate": "Mar 2022",
        "endDate": "Dec 2023",
        "logo": "",
        "isFreelancer": true,
      },
    ],
  ),
  StudentProfileModel(
    rating: 4.2,

    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://i.pinimg.com/736x/dd/fc/ac/ddfcac65a67bc5ed50019958e99acfdd.jpg",
    name: "سارة حسن",
    jobLabel: "Full-Stack Developer",
    email: "Mohamedballoul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Homs",
    hourlySalary: 15,
    experienceYears: 5,
    skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    linkedIn: "https://github.com/Mohamed-Balloul",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    workExperiences: [
      {
        "companyName": "شركة أمازون",
        "jobTitle": "Flutter Developer",
        "startDate": "Jan 2024",
        "endDate": "حتى الآن",
        "logo":
            "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
        "isFreelancer": false,
      },
      {
        "companyName": "Freelance",
        "jobTitle": "UI/UX Designer",
        "startDate": "Mar 2022",
        "endDate": "Dec 2023",
        "logo": "",
        "isFreelancer": true,
      },
    ],
  ),
  StudentProfileModel(
    rating: 4.1,
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://i.pinimg.com/736x/4a/8a/a5/4a8aa5548056ccb19ff8c39acb365276.jpg",
    name: "أحمد يوسف",
    jobLabel: "Game Developer",
    email: "Mohamedballoul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Homs",
    hourlySalary: 15,
    experienceYears: 5,
    skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    linkedIn: "https://github.com/Mohamed-Balloul",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    workExperiences: [
      {
        "companyName": "شركة أمازون",
        "jobTitle": "Flutter Developer",
        "startDate": "Jan 2024",
        "endDate": "حتى الآن",
        "logo":
            "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
        "isFreelancer": false,
      },
      {
        "companyName": "Freelance",
        "jobTitle": "UI/UX Designer",
        "startDate": "Mar 2022",
        "endDate": "Dec 2023",
        "logo": "",
        "isFreelancer": true,
      },
    ],
  ),
  StudentProfileModel(
    rating: 4.0,
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://i.pinimg.com/736x/97/00/39/970039811e175ebcdc498513345b5df2.jpg",
    name: "سارة الأحمد",
    jobLabel: "Data Analyst",
    email: "Mohamedballoul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Homs",
    hourlySalary: 15,
    experienceYears: 5,
    skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    linkedIn: "https://github.com/Mohamed-Balloul",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    workExperiences: [
      {
        "companyName": "شركة أمازون",
        "jobTitle": "Flutter Developer",
        "startDate": "Jan 2024",
        "endDate": "حتى الآن",
        "logo":
            "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
        "isFreelancer": false,
      },
      {
        "companyName": "Freelance",
        "jobTitle": "UI/UX Designer",
        "startDate": "Mar 2022",
        "endDate": "Dec 2023",
        "logo": "",
        "isFreelancer": true,
      },
    ],
  ),
  StudentProfileModel(
    rating: 4.1,
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://i.pinimg.com/736x/5f/c2/d6/5fc2d66dfa2edaf1302341b3aebaaa98.jpg",
    name: "كريم محمود",
    jobLabel: "Cloud Architect",
    email: "Mohamedballoul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Homs",
    hourlySalary: 15,
    experienceYears: 5,
    skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    linkedIn: "https://github.com/Mohamed-Balloul",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    workExperiences: [
      {
        "companyName": "شركة أمازون",
        "jobTitle": "Flutter Developer",
        "startDate": "Jan 2024",
        "endDate": "حتى الآن",
        "logo":
            "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
        "isFreelancer": false,
      },
      {
        "companyName": "Freelance",
        "jobTitle": "UI/UX Designer",
        "startDate": "Mar 2022",
        "endDate": "Dec 2023",
        "logo": "",
        "isFreelancer": true,
      },
    ],
  ),
  StudentProfileModel(
    rating: 4.1,
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://i.pinimg.com/736x/6b/71/02/6b7102468440d77f4ff0fce04ffc4604.jpg",
    name: "أحمد العلي",
    jobLabel: "Junior Flutter Developer",
    email: "Mohamedballoul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Homs",
    hourlySalary: 15,
    experienceYears: 5,
    skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    linkedIn: "https://github.com/Mohamed-Balloul",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    workExperiences: [
      {
        "companyName": "شركة أمازون",
        "jobTitle": "Flutter Developer",
        "startDate": "Jan 2024",
        "endDate": "حتى الآن",
        "logo":
            "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
        "isFreelancer": false,
      },
      {
        "companyName": "Freelance",
        "jobTitle": "UI/UX Designer",
        "startDate": "Mar 2022",
        "endDate": "Dec 2023",
        "logo": "",
        "isFreelancer": true,
      },
    ],
  ),
  StudentProfileModel(
    rating: 4.1,
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://i.pinimg.com/1200x/bd/d3/bc/bdd3bc41294ea5a7d04f70c36893d3eb.jpg",
    name: "فيصل زاهر",
    jobLabel: "Mid-Level Flutter Developer",
    email: "Mohamedballoul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Homs",
    hourlySalary: 15,
    experienceYears: 5,
    skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    linkedIn: "https://github.com/Mohamed-Balloul",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    workExperiences: [
      {
        "companyName": "شركة أمازون",
        "jobTitle": "Flutter Developer",
        "startDate": "Jan 2024",
        "endDate": "حتى الآن",
        "logo":
            "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
        "isFreelancer": false,
      },
      {
        "companyName": "Freelance",
        "jobTitle": "UI/UX Designer",
        "startDate": "Mar 2022",
        "endDate": "Dec 2023",
        "logo": "",
        "isFreelancer": true,
      },
    ],
  ),
];
//---------------- Static Data : student requsts to companies-----------------
List<MyRequestToCompanyModel> myRequestsToCompaniesList = [
  MyRequestToCompanyModel(
    publisher: "Amazon",
    logo: "https://cdn-icons-png.flaticon.com/512/732/732221.png",
    jobTitle: "Flutter Developer",
    orderState: 1,
  ),
  MyRequestToCompanyModel(
    publisher: "Amazon",
    logo: "https://cdn-icons-png.flaticon.com/512/732/732221.png",
    jobTitle: "Flutter Developer",
    orderState: 0,
  ),
  MyRequestToCompanyModel(
    publisher: "Amazon",
    logo: "https://cdn-icons-png.flaticon.com/512/732/732221.png",
    jobTitle: "Flutter Developer",
    orderState: -1,
  ),
];
//---------------- Static Data : student requsts to customers-----------------
List<MyRequestToCustomerModel> myRequestsToCustomersList = [
  MyRequestToCustomerModel(
    publisher: "محمود المحمود",
    image:
        'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=1000&auto=format&fit=crop',
    serviceTitle: "موقع الكتروني لمتجر",
    requestState: 1,
  ),
  MyRequestToCustomerModel(
    publisher: "sara issa",
    image:
        'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?q=80&w=1000&auto=format&fit=crop',
    serviceTitle: "تطبيق موبايل لمتجر",
    requestState: 0,
  ),
  MyRequestToCustomerModel(
    publisher: "sara issa",
    image:
        'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?q=80&w=1000&auto=format&fit=crop',
    serviceTitle: "تطبيق موبايل لمتجر",
    requestState: -1,
  ),
];
//---------------- Static Data : student notifications -----------------
// بيانات وهمية (Mock Data)
List<StudentNotificationModel> allNotifications = [
  StudentNotificationModel(
    id: 1,
    senderName: "hireMe(Admin)",
    senderImage:
        "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1000&auto=format&fit=crop",
    isVerified: true,
    type: "أدمن",
    content:
        "تهانينا ! يمكنك البدء ببناء خدمة \"تطبيق المطعم\" المطلوبة من العميل \"أحمد العلي\". يرجى إرسال المشروع الي حال الاكتمال من أجل إتمام عملية الاستلام والتسليم علماً أن آخر موعد للتسليم هو April 6, 2026 في حال التأخر عن التسليم تفقد حقك في استلام المبلغ المتفق عليه.",
    time: "11:19 AM",
    isRead: false,
  ),
  StudentNotificationModel(
    id: 2,
    senderName: "أحمد العلي",
    senderImage:
        "https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=1000&auto=format&fit=crop",
    isVerified: false,
    type: "عملاء",
    content:
        "تهانينا ! لقد وافق أحمد العلي على طلبك للقيام بخدمة \"تطبيق المطعم\" وفق سعرك المحدد، يمكنك البدء في بناء الخدمة حال تلقيك تأكيد من الأدمن.",
    time: "10:19 AM",
    isRead: false,
  ),
  StudentNotificationModel(
    id: 3,
    senderName: "Google",
    senderImage:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_\"G\"_Logo.svg/1200px-Google_\"G\"_Logo.svg.png",
    isVerified: true,
    type: "شركات",
    content:
        "Congratulations ! Google has accepted your application for an interview for the \"Digital Marketing\" position. Stay tuned; we will email you shortly to schedule your interview.",
    time: "May 6, 2025",
    isRead: true,
  ),
];
// List<StudentNotificationModel> studentNotificationsList = [
//   StudentNotificationModel(
//     type: "إشعار من شركة",
//     details: "مرحباً! لقد تم الموافقة على طلبك المقدم، يرجى مراجعة التفاصيل.",
//   ),
//   StudentNotificationModel(
//     type: "إشعار من عميل",
//     details: "مرحباً! لقد تم الموافقة على طلبك المقدم، يرجى مراجعة التفاصيل.",
//   ),
//   StudentNotificationModel(
//     type: "إشعار من شركة",
//     details: "مرحباً! لقد تم الموافقة على طلبك المقدم، يرجى مراجعة التفاصيل.",
//   ),
// ];
//---------------- Static Data : All Companies Posts Information In Student view -----------------

List<CompaniesPostModel> allcompaniesPosts = [
  //+ +//
  CompaniesPostModel(
    companyName: "Tech Solutions",
    logo:
        "https://cdn-icons-png.flaticon.com/512/732/732221.png", // مثال لوجو مايكروسوفت
    jobTitle: "Senior Flutter Developer",
    time: "منذ يومين",
    content:
        "نبحث عن مطور فلاتر خبير للانضمام لفريقنا. يجب أن يكون لديه خبرة في التعامل مع الخرائط و REST APIs...",
    image:
        "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
    applicants: 12,
    // --- البيانات التفصيلية الجديدة ---
    mainResponsibilities: [
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات وتحسين الأداء",
      "التعامل مع الـ State Management بكفاءة"
    ],
    requirements: [
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات",
      "خبرة في التعامل مع Git و GitHub"
    ],
    benefits: [
      "بيئة عمل مريحة",
      "تأمين اللوازم التقنية (MacBook Pro)",
      "تأمين صحي شامل",
      "تأمين صحي شامل"
    ],
    additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
    isCvRequired: true,
    isGitHubOrPortfolioRequired: true,
    isSalaryRequired: true,
  ),
  CompaniesPostModel(
    companyName: "Tech Solutions",
    logo:
        "https://cdn-icons-png.flaticon.com/512/732/732221.png", // مثال لوجو مايكروسوفت
    jobTitle: "Backend Node.js",
    time: "منذ أسبوع",
    content: "مطلوب مطور Backend خبرة سنتين على الأقل...",
    image:
        "https://images.unsplash.com/photo-1555099962-4199c345e5dd?q=80&w=1000&auto=format&fit=crop",
    applicants: 28,
    // --- البيانات التفصيلية الجديدة ---
    mainResponsibilities: [
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات وتحسين الأداء",
      "التعامل مع الـ State Management بكفاءة"
    ],
    requirements: [
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات",
      "خبرة في التعامل مع Git و GitHub"
    ],
    benefits: [
      "عمل عن بعد",
      "راتب مجزي",
    ],
    additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
    isCvRequired: true,
    isGitHubOrPortfolioRequired: true,
    isSalaryRequired: true,
  ),
];
//----------------
// ---------------------------------------- Company Data ----------------
//----------------
//---------------- Static Data : Company Posts -----------------
List<CompanyPostModel> companyPostsList = [
  CompanyPostModel(
    publisher: "Google",
    jobTitle: "مطور فلاتر - Flutter Developer",
    mainResponsibilities: [
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات"
    ],
    requirements: [
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات"
    ],
    benefits: ["بيئة عمل مريحة", "تأمين اللوازم التقنية "],
    additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
    isCvRequired: true,
    isGitHubOrPortfolioRequired: true,
    isSalaryRequired: true,
  ),
  CompanyPostModel(
    publisher: "Amazon",
    jobTitle: "Flutter Developer",
    mainResponsibilities: [
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات",
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات",
    ],
    requirements: [
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات",
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات",
    ],
    benefits: [
      "بيئة عمل مريحة",
      "تأمين اللوازم التقنية ",
      "بيئة عمل مريحة",
      "تأمين اللوازم التقنية ",
    ],
    additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
    isCvRequired: true,
    isGitHubOrPortfolioRequired: true,
    isSalaryRequired: true,
  ),
];
//---------------- Static Data : Company Posts -----------------

List<ComingRequestOnCompanyPostModel> comingRequestsOnCompanyPostList = [
  ComingRequestOnCompanyPostModel(
    name: "مضر مضر",
    isCvRequired: true,
    isGitHubOrPortfolioRequired: true,
    isSalaryRequired: true,
  ),
  ComingRequestOnCompanyPostModel(
    name: "مضر مضر",
    isCvRequired: true,
    isGitHubOrPortfolioRequired: true,
    isSalaryRequired: true,
  ),
];
// ---------------------------- incoming requests on company post -------------
List<IncomingRequestsToCompanyModel> incomingRequestsOnCompanyPostList = [
  IncomingRequestsToCompanyModel(
    image:
        'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=1000&auto=format&fit=crop',
    applicantName: "سارة الأحمد",
    expectedSalary: 500,
    joblabel: "Flutter Developer",
  ),
  IncomingRequestsToCompanyModel(
    image:
        'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?q=80&w=1000&auto=format&fit=crop',
    applicantName: "كريم محمود",
    expectedSalary: 300,
    joblabel: "UI/UX Developer",
  ),
];

//---------------- Static Data : company profile -----------------
List<CompanyProfileModel> companyProfileList = [
  // + + //
  CompanyProfileModel(
    // images
    logoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png",
    coverUrl:
        "https://images.unsplash.com/photo-1523240795612-9a054b0db644?q=80&w=1000&auto=format&fit=crop", // صورة لمكاتب حديثة
    officeGallery: [
      "https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=1000&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=1000&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1604328698692-f76ea9498e76?q=80&w=1000&auto=format&fit=crop"
    ],
    // General Infrormations
    name: "Amazon",
    description:
        "Amazon is a global leader in e-commerce and cloud computing. We are guided by four principles: customer obsession rather than competitor focus, passion for invention, commitment to operational excellence, and long-term thinking.",
    email: "recruitment@amazon.com",
    phone: "+1 206-266-1000",
    industry: "Technology & E-commerce",
    website: "https://www.amazon.jobs",

    // Statistical informations
    headquarters: "Seattle, Washington, USA (France Branch)",
    companySize: "10,000+",
    foundedYear: 1994,
    rating: 4.8,
    techStack: ["AWS", "Flutter", "Java", "React", "Python", "Docker"],
    socialMediaLinks: [
      "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
      "https://github.com/Mohamed-Balloul",
    ],
  ),
  CompanyProfileModel(
    // images
    logoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png",
    coverUrl:
        "https://images.unsplash.com/photo-1523240795612-9a054b0db644?q=80&w=1000&auto=format&fit=crop", // صورة لمكاتب حديثة
    officeGallery: [
      "https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=1000&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=1000&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1604328698692-f76ea9498e76?q=80&w=1000&auto=format&fit=crop"
    ],
    // General Infrormations
    name: "Google",
    description:
        "Amazon is a global leader in e-commerce and cloud computing. We are guided by four principles: customer obsession rather than competitor focus, passion for invention, commitment to operational excellence, and long-term thinking.",
    email: "recruitment@amazon.com",
    phone: "+1 206-266-1000",
    industry: "Technology & E-commerce",
    website: "https://www.amazon.jobs",

    // Statistical informations
    headquarters: "Seattle, Washington, USA (France Branch)",
    companySize: "10,000+",
    foundedYear: 1994,
    rating: 4.8,
    techStack: ["AWS", "Flutter", "Java", "React", "Python", "Docker"],
    socialMediaLinks: [
      "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
      "https://github.com/Mohamed-Balloul",
    ],
  ),
  CompanyProfileModel(
    // images
    logoUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png",
    coverUrl:
        "https://images.unsplash.com/photo-1523240795612-9a054b0db644?q=80&w=1000&auto=format&fit=crop", // صورة لمكاتب حديثة
    officeGallery: [
      "https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=1000&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=1000&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1604328698692-f76ea9498e76?q=80&w=1000&auto=format&fit=crop"
    ],
    // General Infrormations
    name: "Tech Solutions",
    description:
        "Tech Solutions is a global leader in e-commerce and cloud computing. We are guided by four principles: customer obsession rather than competitor focus, passion for invention, commitment to operational excellence, and long-term thinking.",
    email: "recruitment@amazon.com",
    phone: "+1 206-266-1000",
    industry: "Technology & E-commerce",
    website: "https://www.amazon.jobs",

    // Statistical informations
    headquarters: "Seattle, Washington, USA (France Branch)",
    companySize: "10,000+",
    foundedYear: 1994,
    rating: 4.8,
    techStack: ["AWS", "Flutter", "Java", "React", "Python", "Docker"],
    socialMediaLinks: [
      "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
      "https://github.com/Mohamed-Balloul",
    ],
  )
];
//---------------- Static Data : company Notifications -----------------
// بيانات وهمية (Mock Data)
List<StudentNotificationModel> allCompanyNotifications = [
  StudentNotificationModel(
    id: 1,
    senderName: "hireMe(Admin)",
    senderImage:
        "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1000&auto=format&fit=crop",
    isVerified: true,
    type: "أدمن",
    content:
        "تهانينا ! بعد مراجعة طلب الإعلان الخاص بالمسمى الوظيفي \"UI/UX Designer\" المقدم من قبلكم، جرى التحقق من كل بيانات الإعلان وتم النشر بنجاح على التطبيق يمكن الآن لجميع الطلاب رؤيته.",
    time: "11:19 AM",
    isRead: false,
  ),
  StudentNotificationModel(
    id: 2,
    senderName: "أحمد العلي",
    senderImage:
        "https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=1000&auto=format&fit=crop",
    isVerified: false,
    type: "طلاب",
    content:
        "لقد أرسل اليك أحمد العلي طلب إجراء مقابلة عمل يخص المسمى الوظيفي \"UI/UX Designer\" الذي أعلنت عنه، يمكنك الموافقة أو الرفض من قسم الطلبات الواردة الخاص بالإعلان.",
    time: "10:19 AM",
    isRead: false,
  ),
];
//---------------- Static Data : Company's Posts Information In Her Home Page -----------------
List<CompanyPostInCompanyHomeModel> companyPosts = [
  CompanyPostInCompanyHomeModel(
    companyName: "Tech Solutions",
    logo:
        "https://cdn-icons-png.flaticon.com/512/732/732221.png", // مثال لوجو مايكروسوفت
    jobTitle: "Senior Flutter Developer",
    time: "منذ يومين",
    content:
        "نبحث عن مطور فلاتر خبير للانضمام لفريقنا. يجب أن يكون لديه خبرة في التعامل مع الخرائط و REST APIs...",
    image:
        "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
    applicants: 12,
    // --- البيانات التفصيلية الجديدة ---
    mainResponsibilities: [
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات وتحسين الأداء",
      "التعامل مع الـ State Management بكفاءة"
    ],
    requirements: [
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات",
      "خبرة في التعامل مع Git و GitHub"
    ],
    benefits: [
      "بيئة عمل مريحة",
      "تأمين اللوازم التقنية (MacBook Pro)",
      "تأمين صحي شامل",
      "تأمين صحي شامل"
    ],
    additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
    // --------------------------------
  ),
  CompanyPostInCompanyHomeModel(
    companyName: "Tech Solutions",
    logo:
        "https://cdn-icons-png.flaticon.com/512/732/732221.png", // مثال لوجو مايكروسوفت
    jobTitle: "UI/UX Designer",
    time: "منذ 5 ساعات",
    content:
        "مطلوب مصمم واجهات مبدع للعمل على مشروع جديد. يفضل من لديه معرض أعمال قوي على Behance.",
    image: null,
    applicants: 5,
    mainResponsibilities: [
      "تصميم واجهات المستخدم للتطبيقات والمواقع",
      "إنشاء Wireframes و Prototypes"
    ],
    requirements: [
      "خبرة في Figma و Adobe XD",
      "حس فني عالي وفهم لمبادئ تجربة المستخدم"
    ],
    benefits: [
      "عمل عن بعد",
      "راتب مجزي",
    ],
    additionalDetails: null,
  ),
  CompanyPostInCompanyHomeModel(
    companyName: "Tech Solutions",
    logo:
        "https://cdn-icons-png.flaticon.com/512/732/732221.png", // مثال لوجو مايكروسوفت
    jobTitle: "Backend Node.js",
    time: "منذ أسبوع",
    content: "مطلوب مطور Backend خبرة سنتين على الأقل...",
    image:
        "https://images.unsplash.com/photo-1555099962-4199c345e5dd?q=80&w=1000&auto=format&fit=crop",
    applicants: 28,
    // --- البيانات التفصيلية الجديدة ---
    mainResponsibilities: [
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات وتحسين الأداء",
      "التعامل مع الـ State Management بكفاءة"
    ],
    requirements: [
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات",
      "خبرة في التعامل مع Git و GitHub"
    ],
    benefits: [
      "عمل عن بعد",
      "راتب مجزي",
    ],
    additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
    // --------------------------------
  ),
];
//---------------- Static Data : Companies Posts Information In Her Student view -----------------
// List<CompanyPostInCompanyHomeModel> allCompaniesPosts = [
//   CompanyPostInCompanyHomeModel(
//     companyName: "Tech Solutions",
//     logo:
//         "https://cdn-icons-png.flaticon.com/512/732/732221.png", // مثال لوجو مايكروسوفت
//     jobTitle: "Senior Flutter Developer",
//     time: "منذ يومين",
//     content:
//         "نبحث عن مطور فلاتر خبير للانضمام لفريقنا. يجب أن يكون لديه خبرة في التعامل مع الخرائط و REST APIs...",
//     image:
//         "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
//     applicants: 12,
//     // --- البيانات التفصيلية الجديدة ---
//     mainResponsibilities: [
//       "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
//       "صيانة وتطوير التطبيقات وتحسين الأداء",
//       "التعامل مع الـ State Management بكفاءة"
//     ],
//     requirements: [
//       "شهادة في علوم الحاسوب او ما يعادلها",
//       "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات",
//       "خبرة في التعامل مع Git و GitHub"
//     ],
//     benefits: [
//       "بيئة عمل مريحة",
//       "تأمين اللوازم التقنية (MacBook Pro)",
//       "تأمين صحي شامل",
//       "تأمين صحي شامل"
//     ],
//     additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
//     // --------------------------------
//   ),
//   CompanyPostInCompanyHomeModel(
//     companyName: "Tech Solutions",
//     logo:
//         "https://cdn-icons-png.flaticon.com/512/732/732221.png", // مثال لوجو مايكروسوفت
//     jobTitle: "UI/UX Designer",
//     time: "منذ 5 ساعات",
//     content:
//         "مطلوب مصمم واجهات مبدع للعمل على مشروع جديد. يفضل من لديه معرض أعمال قوي على Behance.",
//     image: null,
//     applicants: 5,
//     mainResponsibilities: [
//       "تصميم واجهات المستخدم للتطبيقات والمواقع",
//       "إنشاء Wireframes و Prototypes"
//     ],
//     requirements: [
//       "خبرة في Figma و Adobe XD",
//       "حس فني عالي وفهم لمبادئ تجربة المستخدم"
//     ],
//     benefits: [
//       "عمل عن بعد",
//       "راتب مجزي",
//     ],
//     additionalDetails: null,
//   ),
//   CompanyPostInCompanyHomeModel(
//     companyName: "Tech Solutions",
//     logo:
//         "https://cdn-icons-png.flaticon.com/512/732/732221.png", // مثال لوجو مايكروسوفت
//     jobTitle: "Backend Node.js",
//     time: "منذ أسبوع",
//     content: "مطلوب مطور Backend خبرة سنتين على الأقل...",
//     image:
//         "https://images.unsplash.com/photo-1555099962-4199c345e5dd?q=80&w=1000&auto=format&fit=crop",
//     applicants: 28,
//     // --- البيانات التفصيلية الجديدة ---
//     mainResponsibilities: [
//       "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
//       "صيانة وتطوير التطبيقات وتحسين الأداء",
//       "التعامل مع الـ State Management بكفاءة"
//     ],
//     requirements: [
//       "شهادة في علوم الحاسوب او ما يعادلها",
//       "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات",
//       "خبرة في التعامل مع Git و GitHub"
//     ],
//     benefits: [
//       "عمل عن بعد",
//       "راتب مجزي",
//     ],
//     additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
//     // --------------------------------
//   ),
// ];
//---------------- Static Data : Best Students Informations -----------------
List<StudentProfileModel> bestStudents = [
  //+ + //
  StudentProfileModel(
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",

    email: "Mohamedballoul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    github: "",
    linkedIn: "",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    workExperiences: [
      {
        "companyName": "شركة أمازون",
        "jobTitle": "Flutter Developer",
        "startDate": "Jan 2024",
        "endDate": "حتى الآن",
        "logo":
            "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
        "isFreelancer": false,
      },
      {
        "companyName": "Freelance",
        "jobTitle": "UI/UX Designer",
        "startDate": "Mar 2022",
        "endDate": "Dec 2023",
        "logo": "",
        "isFreelancer": true,
      },
    ],
    name: "سارة الأحمد",
    jobLabel: "Flutter Developer",
    image:
        'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?q=80&w=1000&auto=format&fit=crop',
    experienceYears: 3,
    city: "دمشق",
    hourlySalary: 15,
    rating: 4.9,
    skils: ["Dart", "Clean Arch", "Bloc", "Git"],
  ),
  StudentProfileModel(
    name: "عمر خالد",
    jobLabel: "UI/UX Designer",
    image:
        'https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=1000&auto=format&fit=crop',
    experienceYears: 2,
    city: "حلب",
    hourlySalary: 12,
    rating: 4.8,
    skils: ["Figma", "Adobe XD", "Prototyping"],
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",

    email: "Mohamedballoul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    github: "",
    linkedIn: "",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    workExperiences: [
      {
        "companyName": "شركة أمازون",
        "jobTitle": "Flutter Developer",
        "startDate": "Jan 2024",
        "endDate": "حتى الآن",
        "logo":
            "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
        "isFreelancer": false,
      },
      {
        "companyName": "Freelance",
        "jobTitle": "UI/UX Designer",
        "startDate": "Mar 2022",
        "endDate": "Dec 2023",
        "logo": "",
        "isFreelancer": true,
      },
    ],
  ),
  StudentProfileModel(
    name: "كريم محمود",
    jobLabel: "DevOps Engineer",
    image:
        'https://i.pinimg.com/1200x/c8/5f/fa/c85ffafb77301926b5fde07854a1df6c.jpg',
    experienceYears: 4,
    city: "عن بعد",
    hourlySalary: 20,
    rating: 4.5,
    skils: ["Linux", "CI/CD", "AWS", "Docker"],
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",

    email: "Mohamedballoul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    github: "",
    linkedIn: "",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    workExperiences: [
      {
        "companyName": "شركة أمازون",
        "jobTitle": "Flutter Developer",
        "startDate": "Jan 2024",
        "endDate": "حتى الآن",
        "logo":
            "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
        "isFreelancer": false,
      },
      {
        "companyName": "Freelance",
        "jobTitle": "UI/UX Designer",
        "startDate": "Mar 2022",
        "endDate": "Dec 2023",
        "logo": "",
        "isFreelancer": true,
      },
    ],
  ),
];
//----------------------------The Posts That display to company as her posts before send notification to student
List<MyPostAsCompany> myPostsAsCompany = [
  MyPostAsCompany(
    id: "1",
    company: "Microsoft",
    logo: "https://cdn-icons-png.flaticon.com/512/732/732221.png",
    image:
        "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
    title: "Flutter Developer",
    time: "منذ يومين",
  ),
  MyPostAsCompany(
    id: "2",
    company: "Google",
    logo: "https://cdn-icons-png.flaticon.com/512/732/732221.png",
    image:
        "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
    title: "Laravel Developer",
    time: "منذ يومين",
  ),
  MyPostAsCompany(
    id: "3",
    company: "Microsoft",
    logo: "https://cdn-icons-png.flaticon.com/512/732/732221.png",
    image:
        "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
    title: "UI/UX Designer",
    time: "منذ يومين",
  ),
  MyPostAsCompany(
    id: "4",
    company: "Microsoft",
    logo: "https://cdn-icons-png.flaticon.com/512/732/732221.png",
    image:
        "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
    title: "Senior Laravel Developer",
    time: "منذ يومين",
  ),
];

//----------------
// ---------------------------------------- Customer Data ----------------
//----------------
//---------------- Static Data : Customer Posts -----------------
List<CustomerPostModel> customerPostsList = [
  CustomerPostModel(
    publisher: "Google",
    jobTitle: "Flutter Developer",
    mainResponsibilities: [
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات"
    ],
    requirements: [
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات"
    ],
    benefits: ["بيئة عمل مريحة", "تأمين اللوازم التقنية "],
    additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
  ),
  CustomerPostModel(
    publisher: "Amazon",
    jobTitle: "Flutter Developer",
    mainResponsibilities: [
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات",
      "بناء تطبيقات موبايل احترافية لكل من أنظمة android و ios",
      "صيانة وتطوير التطبيقات",
    ],
    requirements: [
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات",
      "شهادة في علوم الحاسوب او ما يعادلها",
      "خبرة لا تقل عن ثلاث سنوات في تطوير وبناء التطبيقات",
    ],
    benefits: [
      "بيئة عمل مريحة",
      "تأمين اللوازم التقنية ",
      "بيئة عمل مريحة",
      "تأمين اللوازم التقنية ",
    ],
    additionalDetails: "اخر موعد للتقدم هو 20/11/2025",
  ),
];
//---------------- Static Data : Customer's Posts Information In His Home Page -----------------
List<CustomerPostInCustomerHomeModel> customerPosts = [
  CustomerPostInCustomerHomeModel(
    publisher: "أحمد العلي",
    // صورة شاب مبتسم (جديدة)
    logo:
        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",
    time: "منذ 3 ساعات",
    // صورة متجر ملابس أنيقة (جديدة ومجربة)
    image:
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000&auto=format&fit=crop',
    applicants: 15,
    serviceTitle: "إنشاء متجر إلكتروني للملابس",
    tools: ["Flutter", "Firebase", "Stripe API"],
    date: "20/12/2025",
    description:
        "أبحث عن مطور فلاتر محترف لبناء متجر لبيع الملابس الرجالية. التطبيق يجب أن يدعم الدفع الإلكتروني وتتبع الطلبات.",
    files: "التصميم المبدئي.pdf",
    additionalDetails: "الميزانية المتوقعة 800 - 1000 دولار",
  ),
  CustomerPostInCustomerHomeModel(
    publisher: "أحمد العلي",
    // صورة شاب (جديدة)
    logo:
        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",
    time: "منذ أسبوع",
    // صورة خريطة وموبايل
    image:
        'https://images.unsplash.com/photo-1569383746724-6f1b882b8f46?q=80&w=1000&auto=format&fit=crop',
    applicants: 30,
    serviceTitle: "تطبيق توصيل طلبات",
    tools: ["Flutter", "Google Maps API", "Laravel"],
    date: "10/02/2026",
    description:
        "فكرة التطبيق مشابهة لتطبيقات التوصيل المعروفة. نحتاج نسخة للعميل ونسخة للمندوب ولوحة تحكم للإدارة.",
    files: "Wireframes.xd",
    additionalDetails: "نبحث عن فريق عمل وليس فرد واحد",
  ),
  CustomerPostInCustomerHomeModel(
    publisher: "أحمد العلي",
    // صورة رجل أعمال (جديدة)
    logo:
        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",
    time: "منذ 5 أيام",
    // صورة لابتوب وتحليل بيانات
    image:
        'https://images.unsplash.com/photo-1551288049-bebda4e38f71?q=80&w=1000&auto=format&fit=crop',
    applicants: 22,
    serviceTitle: "تطوير لوحة تحكم (Dashboard)",
    tools: ["React.js", "Node.js", "MongoDB"],
    date: "01/01/2026",
    description:
        "مطلوب مطور Full Stack لبناء لوحة تحكم لإدارة العقارات والمستأجرين. يجب أن تكون لوحة التحكم سريعة وتدعم تعدد اللغات.",
    files: "متطلبات النظام.pdf",
    additionalDetails: "المدة المتوقعة للتسليم شهرين",
  ),
  CustomerPostInCustomerHomeModel(
    publisher: "أحمد العلي",
    // صورة فتاة (جديدة)
    logo:
        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",
    time: "منذ يوم واحد",
    // صورة أدوات رسم وتصميم (جديدة ومجربة)
    image:
        'https://images.unsplash.com/photo-1558655146-d09347e92766?q=80&w=1000&auto=format&fit=crop',
    applicants: 8,
    serviceTitle: "تصميم شعار لشركة ناشئة",
    tools: ["Adobe Illustrator", "Photoshop"],
    date: "15/11/2025",
    description:
        "نريد تصميم شعار عصري وبسيط لشركة تقنية جديدة متخصصة في الذكاء الاصطناعي. نحتاج 3 نماذج أولية.",
    files: "نبذة عن الشركة.docx",
    additionalDetails: "يفضل إرفاق معرض أعمال سابق",
  )
];
//---------------- Static Data : Requests Coming To Customer -----------------
List<ComingRequestOnCompanyPostModel> comingRequestsOnCustomerPostList = [
  ComingRequestOnCompanyPostModel(
    name: "مضر مضر",
    isCvRequired: true,
    isGitHubOrPortfolioRequired: true,
    isSalaryRequired: true,
  ),
  ComingRequestOnCompanyPostModel(
    name: "مضر مضر",
    isCvRequired: true,
    isGitHubOrPortfolioRequired: true,
    isSalaryRequired: true,
  ),
];
//---------------- Static Data : customer profile -----------------
List<CustomerProfileModel> customerProfileList = [
  // + + //
  CustomerProfileModel(
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1000&auto=format&fit=crop",
    name: "سارة عباس",
    jobLabel: "Photographer",
    email: "sara_balloul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Latakia",

    github: "https://github.com/Mohamed-Balloul",
    linkedIn: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
  ),
  CustomerProfileModel(
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1000&auto=format&fit=crop",
    name: "sara issa",
    jobLabel: "Photographer",
    email: "sara_balloul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Latakia",
    // hourlySalary: 15,
    // experienceYears: 5,
    // skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://github.com/Mohamed-Balloul",
    linkedIn: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    // workExperiences: [
    //   {
    //     "companyName": "شركة أمازون",
    //     "jobTitle": "Flutter Developer",
    //     "startDate": "Jan 2024",
    //     "endDate": "حتى الآن",
    //     "logo":
    //         "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
    //     "isFreelancer": false,
    //   },
    //   {
    //     "companyName": "Freelance",
    //     "jobTitle": "UI/UX Designer",
    //     "startDate": "Mar 2022",
    //     "endDate": "Dec 2023",
    //     "logo": "",
    //     "isFreelancer": true,
    //   },
    // ],
  ),
  CustomerProfileModel(
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1000&auto=format&fit=crop",
    name: "محمود المحمود",
    jobLabel: "Photographer",
    email: "sara_balloul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Latakia",
    // hourlySalary: 15,
    // experienceYears: 5,
    // skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://github.com/Mohamed-Balloul",
    linkedIn: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    // workExperiences: [
    //   {
    //     "companyName": "شركة أمازون",
    //     "jobTitle": "Flutter Developer",
    //     "startDate": "Jan 2024",
    //     "endDate": "حتى الآن",
    //     "logo":
    //         "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
    //     "isFreelancer": false,
    //   },
    //   {
    //     "companyName": "Freelance",
    //     "jobTitle": "UI/UX Designer",
    //     "startDate": "Mar 2022",
    //     "endDate": "Dec 2023",
    //     "logo": "",
    //     "isFreelancer": true,
    //   },
    // ],
  ),
  CustomerProfileModel(
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1000&auto=format&fit=crop",
    name: "سارة محمد",
    jobLabel: "Photographer",
    email: "sara_balloul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Latakia",
    // hourlySalary: 15,
    // experienceYears: 5,
    // skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://github.com/Mohamed-Balloul",
    linkedIn: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    // workExperiences: [
    //   {
    //     "companyName": "شركة أمازون",
    //     "jobTitle": "Flutter Developer",
    //     "startDate": "Jan 2024",
    //     "endDate": "حتى الآن",
    //     "logo":
    //         "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
    //     "isFreelancer": false,
    //   },
    //   {
    //     "companyName": "Freelance",
    //     "jobTitle": "UI/UX Designer",
    //     "startDate": "Mar 2022",
    //     "endDate": "Dec 2023",
    //     "logo": "",
    //     "isFreelancer": true,
    //   },
    // ],
  ),
  CustomerProfileModel(
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1000&auto=format&fit=crop",
    name: "مازن خليل",
    jobLabel: "Photographer",
    email: "sara_balloul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Latakia",
    // hourlySalary: 15,
    // experienceYears: 5,
    // skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://github.com/Mohamed-Balloul",
    linkedIn: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    // workExperiences: [
    //   {
    //     "companyName": "شركة أمازون",
    //     "jobTitle": "Flutter Developer",
    //     "startDate": "Jan 2024",
    //     "endDate": "حتى الآن",
    //     "logo":
    //         "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
    //     "isFreelancer": false,
    //   },
    //   {
    //     "companyName": "Freelance",
    //     "jobTitle": "UI/UX Designer",
    //     "startDate": "Mar 2022",
    //     "endDate": "Dec 2023",
    //     "logo": "",
    //     "isFreelancer": true,
    //   },
    // ],
  ),
  CustomerProfileModel(
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1000&auto=format&fit=crop",
    name: "كريم يوسف",
    jobLabel: "Photographer",
    email: "sara_balloul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Latakia",
    // hourlySalary: 15,
    // experienceYears: 5,
    // skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://github.com/Mohamed-Balloul",
    linkedIn: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    // workExperiences: [
    //   {
    //     "companyName": "شركة أمازون",
    //     "jobTitle": "Flutter Developer",
    //     "startDate": "Jan 2024",
    //     "endDate": "حتى الآن",
    //     "logo":
    //         "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
    //     "isFreelancer": false,
    //   },
    //   {
    //     "companyName": "Freelance",
    //     "jobTitle": "UI/UX Designer",
    //     "startDate": "Mar 2022",
    //     "endDate": "Dec 2023",
    //     "logo": "",
    //     "isFreelancer": true,
    //   },
    // ],
  ),
  CustomerProfileModel(
    // 1 General Informations
    cover:
        "https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=1000&auto=format&fit=crop",
    image:
        "https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1000&auto=format&fit=crop",
    name: "أحمد العلي",
    jobLabel: "Photographer",
    email: "sara_balloul659@gmail.com",
    phone: "0931499508",
    bio:
        "مطور تطبيقات موبايل شغوف باستخدام Flutter. لدي خبرة قوية في بناء تطبيقات متجاوبة وعالية الأداء. ",
    // 2 Statistical Info
    city: "Latakia",
    // hourlySalary: 15,
    // experienceYears: 5,
    // skils: ["Dart", "Clean Arch", "Bloc", "Git"],
    github: "https://github.com/Mohamed-Balloul",
    linkedIn: "https://www.linkedin.com/in/mohamed-balloul-13b4173b3",
    // 3 Education Info
    educationInfo: {
      "isGraduated": false, // false تعني يدرس، true تعني تخرج
      "specialization": "الهندسة المعلوماتية",
      "college": "كلية الهندسة المعلوماتية",
      "university": "جامعة حمص",
    },
    // 4 Work Experiences || الخبرة المهنية
    // workExperiences: [
    //   {
    //     "companyName": "شركة أمازون",
    //     "jobTitle": "Flutter Developer",
    //     "startDate": "Jan 2024",
    //     "endDate": "حتى الآن",
    //     "logo":
    //         "https://assets.aboutamazon.com/2e/d7/ac71f1f344c39f8949f48fc89e71/amazon-logo-squid-ink-smile-orange.png",
    //     "isFreelancer": false,
    //   },
    //   {
    //     "companyName": "Freelance",
    //     "jobTitle": "UI/UX Designer",
    //     "startDate": "Mar 2022",
    //     "endDate": "Dec 2023",
    //     "logo": "",
    //     "isFreelancer": true,
    //   },
    // ],
  ),
];
//---------------- Static Data : customer Notifications -----------------
// بيانات وهمية (Mock Data)
List<StudentNotificationModel> allCustomerNotifications = [
  StudentNotificationModel(
    id: 1,
    senderName: "hireMe(Admin)",
    senderImage:
        "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1000&auto=format&fit=crop",
    isVerified: true,
    type: "أدمن",
    content:
        "تهانينا ! بعد مراجعة طلب الإعلان الخاص بالخدمة المطلوبة \"إنشاء متجر إلكتروني للملابس\" المقدم من قبلك، جرى التحقق من كل بيانات الإعلان وتم النشر بنجاح على التطبيق يمكن الآن لجميع الطلاب رؤيته.",
    time: "11:19 AM",
    isRead: false,
  ),
  StudentNotificationModel(
    id: 2,
    senderName: "أحمد العلي",
    senderImage:
        "https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=1000&auto=format&fit=crop",
    isVerified: false,
    type: "طلاب",
    content:
        "لقد أرسل اليك أحمد العلي طلب للقيام بخدمة \"إنشاء متجر إلكتروني للملابس\" التي أعلنت عنها، يمكنك الموافقة أو الرفض من قسم الطلبات الواردة الخاص بالإعلان.",
    time: "10:19 AM",
    isRead: false,
  ),
];
// ---------------------------- incoming requests on customer post -------------
List<IncomingRequestsToCustomerModel> incomingRequestsOnCustomerPostList = [
  IncomingRequestsToCustomerModel(
    image:
        'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=1000&auto=format&fit=crop',
    applicantName: "أحمد يوسف",
    expectedSalary: 500,
    joblabel: "Flutter Developer",
  ),
  IncomingRequestsToCustomerModel(
    image:
        'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?q=80&w=1000&auto=format&fit=crop',
    applicantName: "سارة حسن",
    expectedSalary: 300,
    joblabel: "UI/UX Developer",
  ),
];
//----------------------------The Posts That display to customer as her posts before send notification to student
// قائمة الإعلانات الوهمية الخاصة بهذه الشركة
// ملاحظة: في الواقع سنقوم بفلترة allcompaniesPosts بناءً على اسم الشركة الحالية
// قائمة الـ IDs للإعلانات المختارة
List<MyPostAsCustomer> myPostsAsCustomer = [
  MyPostAsCustomer(
    id: "1",
    company: "Microsoft",
    logo: "https://cdn-icons-png.flaticon.com/512/732/732221.png",
    image:
        "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
    title: "Flutter Developer",
    time: "منذ يومين",
  ),
  MyPostAsCustomer(
    id: "2",
    company: "Google",
    logo: "https://cdn-icons-png.flaticon.com/512/732/732221.png",
    image:
        "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
    title: "Laravel Developer",
    time: "منذ يومين",
  ),
  MyPostAsCustomer(
    id: "3",
    company: "Microsoft",
    logo: "https://cdn-icons-png.flaticon.com/512/732/732221.png",
    image:
        "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
    title: "UI/UX Designer",
    time: "منذ يومين",
  ),
  MyPostAsCustomer(
    id: "4",
    company: "Microsoft",
    logo: "https://cdn-icons-png.flaticon.com/512/732/732221.png",
    image:
        "https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000&auto=format&fit=crop",
    title: "Senior Laravel Developer",
    time: "منذ يومين",
  ),
];
//-----------
//--------------suggestions for student
// دمج القائمتين في قائمة واحدة للمقترحات
// في الواقع، يمكنك ترتيبهم حسب التاريخ أو اختيار عشوائي
List<dynamic> suggestedItems = [
  allcompaniesPosts[0], // إعلان شركة
  freelancerPostsList[0], // مشروع عمل حر
  allcompaniesPosts[1], // إعلان شركة آخر
];
