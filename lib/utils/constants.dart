//Firestore Collection Names
import 'package:firebase_auth/firebase_auth.dart';

const USERS = "Users";
const POSTS = "Posts";
const COMMENTS = "Comments";
const PROFILE_PICS = "ProfilePics";

//Firestore FieldValues
const bioFV = "bio";
const emailFV = "email";
const followersFV = "followers";
const followingFV = "following";
const fullnameFV = "fullname";
const photoUrlFV = "photoUrl";
const uidFV = "uid";
const usernameFV = "username";

const datePublishedFV = "datePublished";
const descriptionFV = "description";
const likesFV = "likes";
const postIdFV = "postId";
const postUrlFV = "postUrl";
const profImgFV = "profImg";

const commentFV = "comment";
const commentIdFV = "commentId";
const commentedOnFV = "commentedOn";
const commentLikesFV = "likes";

//Route Names
const InitialRouteName = "/";
const LoginRouteName = "login";
const SignupRouteName = "signup";
const HomeRouteName = "home";
const ProfileRouteName = "profile";
const AddPostRouteName = "addpost";
const AppScreenRouteName = "appscreen";
const CommentsRouteName = "comments";
const SearchRouteName = "search";

//Argument Names
const PostId = "postId";
const UID = "uid";

//Connection Status
const Success = "Success";
const ErrorOccured = "Some error occured!";

//AppName
const appName = 'Instagram Clone';

//Dialog Popup Names
const createPostStr = "Create a Post";
const takeaPostStr = 'Take a Photo';
const choosegalleryStr = 'Choose from Gallery';
const cancelStr = 'Cancel';

//Auth Methods
const fillAllDetailsStr = 'Please enter all the fields';
const enterValidEmailStr = "Please enter a valid email";
const emailPasswordWrongStr =
    "Email address or Password is Wrong! Please retry with valid credentials";

//Firestore Methods
const commentEmptyStr = "comment is empty";

//Add Post Screen
const postedStr = 'Posted!';
const newPostStr = 'New Post';
const writeCaptionStr = "Write a caption...";

//Comments Screen
const commentsStr = 'Comments';
const addCommentsStr = 'Add your comments...';
const postStr = 'Post';
const noCommentsStr = 'No comments yet!';

//Home Screen
const noFeedsStr = 'No Feeds!';

//Login Screen
const emailAddressStr = 'Email Address';
const passwordStr = 'Password';
const loginStr = 'LogIn';
const haveAccountStr = 'Don\'t have account yet?';
const signUpStr = 'SignUp';

//Notification Screen
const notificationStr = 'Notifications';

//Profile Screen
const signOutStr = 'Sign out';
const postsStr = 'Posts';
const followersStr = 'Followers';
const followingStr = 'Following';

//Reels Screen
const reelsStr = 'Reels';

//Search Screen
const searchAUserStr = 'Search for a user';
const noUserFound = 'No User Found!';
const searchUserStr = 'Search users';

//Signup Screen
const userNameStr = 'User name';
const fullNameStr = 'Full name';
const bioStr = 'Bio';
const alreadyHavingAccountStr = 'Already having an account?';
const signInStr = 'SignIn';

//Comment Card
const replyStr = 'Reply';

//Follower Suggestion Card
const discoverPplStr = 'Discover people';
const seeAll = 'See all';
const followStr = 'Follow';
const followedByStr = 'followed by';

//Post Card
const deletePostStr = 'Delete Post';
const addFavStr = 'Add to Favorites';
const likesStr = 'likes';
const viewAllStr = 'View all';

//Profile Follow Button
const editProfileStr = 'Edit profile';
const unFollowStr = 'Unfollow';
const messageStr = 'Message';

//Story Card
const yourStoryStr = 'Your story';
const storyUsernameStr = 'Vijay';

//FirebaseAuthException Codes
const invalidEmail = 'invalid-email';
const userNotFound = 'user-not-found';
