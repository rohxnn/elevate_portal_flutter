import '../config/env.dart'; 

class ApiEndpoints {
  static final String contentReadBase = "${Env.publicBaseUrl}/api/content/v1/read";
  static String contentRead(String doId) =>
    "$contentReadBase/$doId?fields=artifactUrl";

  static final String academicYearsList = "${Env.publicBaseUrl}/academicyears/list";
  static final String accountCreate = "${Env.publicBaseUrl}/account/create";
  static String userUpdate(String userId) => "${Env.publicBaseUrl}/user/update/$userId";
  static String myCohorts(String userId) => "${Env.publicBaseUrl}/cohort/mycohorts/$userId";

  static final String authRefresh = "${Env.publicBaseUrl}/account/auth/refresh";
  static final String authLogout = "${Env.publicBaseUrl}/account/auth/logout";
  static final String userAuth = "${Env.publicBaseUrl}/user/auth";

  static final String accountLogin = "${Env.publicBaseUrl}/user/v1/account/login";
  static final String sendOtp = "${Env.publicBaseUrl}/user/v1/account/registrationOtp";
  static final String userProfileRead = "${Env.publicBaseUrl}/user/v1/user/read";
  static final String resetPassword = "${Env.publicBaseUrl}/user/v1/account/changePassword";
  static final String formRead = "${Env.publicBaseUrl}/user/v1/form/read";
  static final String forgotPassword = "${Env.publicBaseUrl}/user/v1/account/resetPassword";
  static final String sendForgetOtp = "${Env.publicBaseUrl}/user/v1/account/generateOtp";
  static final String deleteAccount = "${Env.publicBaseUrl}/user/v1/account/delete";

  static final String roleRead =
      "${Env.publicBaseUrl}/entity-management/v1/entities/entityListBasedOnEntityType?entityType=professional_role";
  static final String userCreate = "${Env.publicBaseUrl}/interface/v1/account/create";
  static final String tenantRead = "${Env.publicBaseUrl}/user/v1/public/branding";
  static String checkUser(String email) =>
      "${Env.publicBaseUrl}/user/v1/public/checkUsername?username=$email";

  static String udiseSearch(String udise) =>
      "${Env.publicBaseUrl}/entity-management/v1/entities/details/$udise";
  static final String fieldOptionsRead = "${Env.publicBaseUrl}/fields/options/read";
  static final String cohortSearch = "${Env.publicBaseUrl}/cohort/search";

  static String fieldOptionDelete(String type, String option) =>
      "${Env.publicBaseUrl}/fields/options/delete/$type?option=$option";

  static String fieldUpdate(String fieldId) =>
      "${Env.publicBaseUrl}/fields/update/$fieldId";
  static String cohortUpdate(String cohortId) =>
      "${Env.publicBaseUrl}/cohort/update/$cohortId";

  static final String notificationSend = "${Env.publicBaseUrl}/notification/send";
  static final String tenantCreate = "${Env.publicBaseUrl}/tenant/create";
  static String tenantUpdate(String tenantId) =>
      "${Env.publicBaseUrl}/tenant/update/$tenantId";
  static String tenantDelete(String tenantId) =>
      "${Env.publicBaseUrl}/tenant/delete/$tenantId";
  static final String tenantSearch = "${Env.publicBaseUrl}/tenant/search";

  static final String userList = "${Env.publicBaseUrl}/user/list";
  static final String cohortMemberList = "${Env.publicBaseUrl}/cohortmember/list";

  static String userRead(String userId, bool fieldValue) =>
      "${Env.publicBaseUrl}/user/read/$userId?fieldvalue=$fieldValue";

  static final String suggestUsername = "${Env.publicBaseUrl}/user/suggestUsername";
  static String cohortUpdateUser(String userId) =>
      "${Env.publicBaseUrl}/cohort/update/$userId";

  static String formReadWithContext(String context, String contextType) =>
      "${Env.publicBaseUrl}/form/read?context=$context&contextType=$contextType";

  static final String cohortCreate = "${Env.publicBaseUrl}/cohort/create";
  static final String cohortMemberBulkCreate =
      "${Env.publicBaseUrl}/cohortmember/bulkCreate";
  static String cohortMemberUpdate(dynamic membershipId) =>
      "${Env.publicBaseUrl}/cohortmember/update/$membershipId";

  static final String notificationTemplate =
      "${Env.publicBaseUrl}/notification-templates";

  static final String courseStatus =
      "${Env.publicBaseUrl}/tracking/user_certificate/user_course_status";
  static final String courseWiseLernerList =
      "${Env.publicBaseUrl}/tracking/user_certificate/status/search";
  static final String getCourseName =
      "${Env.publicBaseUrl}/action/composite/v3/search";
  static final String issueCertificate =
      "${Env.publicBaseUrl}/tracking/certificate/issue";
  static final String renderCertificate =
      "${Env.publicBaseUrl}/tracking/certificate/render";
  static final String downloadCertificate =
      "${Env.publicBaseUrl}/tracking/certificate/render-PDF";

  // Other APIs
  static final String coursePlannerUpload =
      "${Env.publicBaseUrl}/prathamservice/v1/course-planner/upload";
}
