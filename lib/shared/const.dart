List<String> caTypes = [
  "Sole proprietorship",
  "Sole proprietorship with registered firm",
  "Partner Registered firm"
];

List<String> expertise = [
  "Certification",
  "Networth certificate",
  "Valuation certificate",
  "Financial statements",
  "Audit reports",
  "Internal audit",
  "Management consulting",
  "Legal consultancy",
  "Indirect tax consultancy",
  "Direct tax consultancy"
];

String locationMessage =
    "There is a problem in loading location, Our application needs location to find near by CA's easily!! please grant location access, ";
String iosLocationMessage =
    "Go to Settings -> Privacy And Security -> Location Services -> FindyMyCA -> Select option while using app";
String androidLocationMessage =
    "Go to Settings -> Search Manage Apps -> FindMyCA -> App permissions";
String uploadingImageMessage = "Uploading...";

String appWriteBaseURl = 'https://cloud.appwrite.io/v1';

String projectID = '64663e222959a2ffa6cd';
String databaseId = '646c64c8e54c1fd48bf0';
String profileCollectionID = '646c64f3a6d37627f1a3';
String profilePicBucketId = '6475fbe09efe8ed159af';

String registrationSuccess =
    "Registration successfull! please login to get started!";

String connectivityIssue =
    "Something went wrong, Make sure you are connected to network!";

String registrationLoading = "Please wait, we are registering you!";

String invalidCredential = "Please enter a valid email and password";

String userAlreadyRegistered =
    'A user with the same id, email, or phone already exists';

String rateLimitExceeded = 'Oops! sorry for inconvinience we will be back soon';

String loginSucess = 'Login Sucessful';

String logoutSuccess = 'Logout Successful';
