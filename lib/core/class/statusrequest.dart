enum StatusRequest {
  none,
  loading,
  success,
  failure, //وصل لصفحة الباك بس صار فشل مالو علافة بالسيرفر
  serverfailure, //فشل الاتصال بالسيرفر
  serverException,
  offlinefailure //فشل بسبب  فشل الاتصال بالانترنت
}
