import '../config/env.dart'; 

class ApiEndpoints {
  static final String contentReadBase = "/api/content/v1/read";
  static String contentRead(String doId) =>
    "$contentReadBase/$doId?fields=artifactUrl";

  static final String academicYearsList = "/academicyears/list";
  static final String accountCreate = "/account/create";
  static String userUpdate(String userId) => "/user/update/$userId";
  static String myCohorts(String userId) => "/cohort/mycohorts/$userId";

  static final String authRefresh = "/account/auth/refresh";
  static final String authLogout = "/account/auth/logout";
  static final String userAuth = "/user/auth";
  

  static final String accountLogin = "/user/v1/account/login";
  static final String sendOtp = "/user/v1/account/registrationOtp";
  static final String userProfileRead = "/user/v1/user/read";
  static final String resetPassword = "/user/v1/account/changePassword";
  static final String formRead = "/user/v1/form/read";
  static final String forgotPassword = "/user/v1/account/resetPassword";
  static final String sendForgetOtp = "/user/v1/account/generateOtp";
  static final String deleteAccount = "/user/v1/account/delete";

  static final String roleRead =
      "/entity-management/v1/entities/entityListBasedOnEntityType?entityType=professional_role";

  static final String readHomeList = "/user/v1/organization-feature/read";

  static final String userCreate = "/interface/v1/account/create";
  static final String tenantRead = "/user/v1/public/branding";
  static String checkUser(String email) =>
      "/user/v1/public/checkUsername?username=$email";

  static String udiseSearch(String udise) =>
      "/entity-management/v1/entities/details/$udise";
  static final String fieldOptionsRead = "/fields/options/read";
  static final String cohortSearch = "/cohort/search";

  static String fieldOptionDelete(String type, String option) =>
      "/fields/options/delete/$type?option=$option";

  static String fieldUpdate(String fieldId) =>
      "/fields/update/$fieldId";
  static String cohortUpdate(String cohortId) =>
      "/cohort/update/$cohortId";

  static final String notificationSend = "/notification/send";
  static final String tenantCreate = "/tenant/create";
  static String tenantUpdate(String tenantId) =>
      "/tenant/update/$tenantId";
  static String tenantDelete(String tenantId) =>
      "/tenant/delete/$tenantId";
  static final String tenantSearch = "/tenant/search";

  static final String userList = "/user/list";
  static final String cohortMemberList = "/cohortmember/list";

  static String userRead(String userId, bool fieldValue) =>
      "/user/read/$userId?fieldvalue=$fieldValue";

  static final String suggestUsername = "/user/suggestUsername";
  static String cohortUpdateUser(String userId) =>
      "/cohort/update/$userId";

  static String formReadWithContext(String context, String contextType) =>
      "/form/read?context=$context&contextType=$contextType";

  static final String cohortCreate = "/cohort/create";
  static final String cohortMemberBulkCreate =
      "/cohortmember/bulkCreate";
  static String cohortMemberUpdate(dynamic membershipId) =>
      "/cohortmember/update/$membershipId";

  static final String notificationTemplate =
      "/notification-templates";

  static final String courseStatus =
      "/tracking/user_certificate/user_course_status";
  static final String courseWiseLernerList =
      "/tracking/user_certificate/status/search";
  static final String getCourseName =
      "/action/composite/v3/search";
  static final String issueCertificate =
      "/tracking/certificate/issue";
  static final String renderCertificate =
      "/tracking/certificate/render";
  static final String downloadCertificate =
      "/tracking/certificate/render-PDF";

  // Other APIs
  static final String coursePlannerUpload =
      "/prathamservice/v1/course-planner/upload";
}
