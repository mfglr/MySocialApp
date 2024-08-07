import 'package:my_social_app/state/account_state/middlewares.dart';
import 'package:my_social_app/state/create_comment_state/create_comment_state.dart';
import 'package:my_social_app/state/create_comment_state/middlewares.dart';
import 'package:my_social_app/state/create_message_state/create_message_state.dart';
import 'package:my_social_app/state/create_message_state/middlewares.dart';
import 'package:my_social_app/state/create_question_state/create_question_state.dart';
import 'package:my_social_app/state/create_question_state/middleware.dart';
import 'package:my_social_app/state/create_solution_state/create_solution_state.dart';
import 'package:my_social_app/state/create_solution_state/middlewares.dart';
import 'package:my_social_app/state/exam_entity_state/exam_entity_state.dart';
import 'package:my_social_app/state/exam_entity_state/middlewares.dart';
import 'package:my_social_app/state/home_page_state/home_page_state.dart';
import 'package:my_social_app/state/home_page_state/middlewares.dart';
import 'package:my_social_app/state/ids.dart';
import 'package:my_social_app/state/message_entity_state/message_entity_state.dart';
import 'package:my_social_app/state/message_entity_state/middlewares.dart';
import 'package:my_social_app/state/message_home_page_state/message_home_page_state.dart';
import 'package:my_social_app/state/message_home_page_state/middlewares.dart';
import 'package:my_social_app/state/middlewares.dart';
import 'package:my_social_app/state/comment_entity_state/middlewares.dart';
import 'package:my_social_app/state/comment_entity_state/comment_entity_state.dart';
import 'package:my_social_app/state/notification_entity_state.dart/middlewares.dart';
import 'package:my_social_app/state/notification_entity_state.dart/notification_entity_state.dart';
import 'package:my_social_app/state/question_entity_state/middlewares.dart';
import 'package:my_social_app/state/question_entity_state/question_entity_state.dart';
import 'package:my_social_app/state/question_image_entity_state/middlewares.dart';
import 'package:my_social_app/state/question_image_entity_state/question_image_entity_state.dart';
import 'package:my_social_app/state/reducer.dart';
import 'package:my_social_app/state/search_state/middlewares.dart';
import 'package:my_social_app/state/search_state/search_state.dart';
import 'package:my_social_app/state/solution_entity_state/middlewares.dart';
import 'package:my_social_app/state/solution_entity_state/solution_entity_state.dart';
import 'package:my_social_app/state/solution_image_entity_state/middlewares.dart';
import 'package:my_social_app/state/solution_image_entity_state/solution_image_entity_state.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/state/subject_entity_state/middlewares.dart';
import 'package:my_social_app/state/subject_entity_state/subject_entity_state.dart';
import 'package:my_social_app/state/topic_entity_state/middlewares.dart';
import 'package:my_social_app/state/topic_entity_state/topic_entity_state.dart';
import 'package:my_social_app/state/user_entity_state/middlewares.dart';
import 'package:my_social_app/state/user_entity_state/user_entity_state.dart';
import 'package:my_social_app/state/user_image_entity_state/middlewares.dart';
import 'package:my_social_app/state/user_image_entity_state/user_image_entity_state.dart';
import 'package:redux/redux.dart';

final store = Store(
  appReducer,
  initialState: const AppState(
    accessToken: null,
    accountState: null,
    activeLoginPage: ActiveLoginPage.loginPage,
    isInitialized: false,
    userEntityState: UserEntityState(entities: {}),
    userImageEntityState: UserImageEntityState(entities: {}),
    searchState: SearchState(key: "", users: Ids(recordsPerPage: 20, ids: [], isLast: false, lastValue: null)),
    createQuestionState: CreateQuestionState(images: [],examId: null, subjectId: null, topicIds: [], content: null),
    createSolutionState: CreateSolutionState(questionId: null, content: "", images: []),
    examEntityState: ExamEntityState(entities: {}, isLoaded: false),
    subjectEntityState: SubjectEntityState(entities: {}),
    topicEntityState: TopicEntityState(entities: {}),
    questionEntityState: QuestionEntityState(entities: {}),
    questionImageEntityState: QuestionImageEntityState(entities: {}),
    solutionEntityState: SolutionEntityState(entities: {}),
    solutionImageEntityState: SolutionImageEntityState(entities: {}),
    homePageState: HomePageState(questions: Ids(recordsPerPage: 20, ids: [], isLast: false, lastValue: null)),
    commentEntityState: CommentEntityState(entities: {}),
    createCommentState: CreateCommentState(question: null, solution: null, comment: null, isRoot: false, content: "", hintText: ""),
    notificationEntityState: NotificationEntityState(entities: {},isUnviewedNotificationsLoaded: false,isLast: false,lastId: null),
    messageEntityState: MessageEntityState(entities: {}),
    messageHomePageState: MessageHomePageState(isLastConversations: false, isSynchronized: false),
    createMessageState: CreateMessageState(content: null, images: [], receiverId: null)
  ),
  middleware: [
    //account start
    initAppMiddleware,
    confirmEmailMiddleware,
    loginByPasword,
    createAccountMiddleware,
    logOutMiddleware,
    //account end

    //user start
    loadUserMiddleware,
    loadUserByUserNameMiddleware,
    loadFollowersIfNoUsersMiddleware,
    loadFollowedsIfNoUsersMiddleware,
    loadFollowersMiddleware,
    loadFollowedsMiddleware,
    makeFollowRequestMiddleware,
    cancelFollowRequestMiddleware,
    nextPageOfUserQuestionsMiddleware,
    nextPageOfUserQuestionsIfNoQuestionsMiddleware,
    nextPageUserMessagesMiddleware,
    nextPageUserMessageIfNoUsersMiddleware,
    //user end

    //user image start
    loadUserImageMiddleware,
    //user imgage end

    //search start
    searchMiddleware,
    nextPageSearchingMiddleware,
    //search end
    
    //Exam Start
    loadAllExamsMiddleware,
    loadSubjectsOfSelectedExamMiddleware,
    nextPageOfExamQeuestionsMiddleware,
    nextPageOfExamQuestionsIfNoQuestionsMiddleware,
    //Exam end

    //subject start
    nextPageOfSubjectQuestionsIfNoQuestionsMiddleware,
    nextPageOfSubjectQuestionsMiddleware,
    loadSubjectTopicsMiddleware,
    //end

    //Topic start
    nextPageOfTopicQuestionsMiddleware,
    nextPageOfTopicQuestionsIfNoQuestionsMiddleware,
    //Topic end

    // Question start
    loadQuestionMiddleware,
    createQuestionMiddleware,
    likeQuestionMiddleware,
    dislikeQuestionMiddleware,
    nextPageQuestionSolutionsMiddleware,
    nextPageQuestionSolutionIfNoSolutionsMiddleware,
    // Question end
    
    // Question image start
    loadQuestionImageMiddleware,
    nextPageOfHomeQuestionsMiddleware,
    nextPageOfHomeQuestionsIfNoQuestionsMiddleware,
    // Question image end

    //solution start
    createSolutionMiddleware,
    makeUpvoteMiddleware,
    makeDownvoteMiddleware,
    removeUpvoteMiddleware,
    removeDownvoteMiddleware,
    nextPageSolutionCommentsMiddleware,
    nextPageSolutionCommentsIfNoCommentsMiddleware,
    //solution end

    //Solution image start
    loadSolutionImageMiddleware,
    //Solution image end

    //comments start
    createCommentMiddleware,
    nextPageQuestionCommentsMiddleware,
    nextPageQuestionCommentIfNoQuestionCommentsMiddleware,
    likeCommentMiddleware,
    dislikeCommentMiddleware,
    nextPageCommentRepliesMiddleware,
    nextPageCommentRepliesIfNoRepliesMiddleware,
    loadCommentMiddleware,

    //notifications start
    markNotificationsAsViewedMiddleware,
    loadUnviewedNotificationMiddleware,
    nextPageNotificationsMiddleware,
    nextPageNotificationsIfNoNoficationsMiddleware,
    //notifications end

    //conversations start
    nextPageConversationsMiddleware,
    nextPageConversationsIfNoConversationsMiddleware,
    //conversations end

    //message
    markComingMessageAsReceivedMiddleware,
    markComingMessageAsViewedMiddleware,
    markComingMessagesAsReceivedMiddleware,
    markComingMessagesAsViewedMiddleware,
    loadMessageImageMiddleware,
    
    createMessageWithImagesMiddleware,
    createMessageMiddleware,
    
    getComingMessagesMiddleware,

  ]
);