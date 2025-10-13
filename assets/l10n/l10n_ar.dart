import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class L10nAr extends L10n {
  L10nAr([String locale = 'ar']) : super(locale);

  @override
  String get passwordsDoNotMatch => 'كلمتا السر لا تتطبقان!';

  @override
  String get pleaseEnterValidEmail => 'رجاءً أدخل بيردًا إلكترونيًا صالحًا.';

  @override
  String get repeatPassword => 'كرّر كلمة السر';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'رجاءً اختر ما لا يقل عن $min محرف.';
  }

  @override
  String get about => 'حول';

  @override
  String get updateAvailable => 'Twake Chat update available';

  @override
  String get updateNow => 'Start update in background';

  @override
  String get accept => 'أقبل';

  @override
  String acceptedTheInvitation(Object username) {
    return '$username قبل الدعوة';
  }

  @override
  String get account => 'الحساب';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '$username فعَّل تشفير طرف لطرف';
  }

  @override
  String get addEmail => 'أضف بريدًا إلكترونيًا';

  @override
  String get confirmMatrixId => 'Please confirm your Matrix ID in order to delete your account.';

  @override
  String supposedMxid(Object mxid) {
    return 'This should be $mxid';
  }

  @override
  String get addGroupDescription => 'أضف وصف للمجموعة';

  @override
  String get addToSpace => 'أضفه لفضاء';

  @override
  String get admin => 'المدير';

  @override
  String get alias => 'اللقب';

  @override
  String get all => 'الكل';

  @override
  String get allChats => 'كل المحادثات';

  @override
  String get commandHint_googly => 'Send some googly eyes';

  @override
  String get commandHint_cuddle => 'Send a cuddle';

  @override
  String get commandHint_hug => 'Send a hug';

  @override
  String googlyEyesContent(Object senderName) {
    return '$senderName sends you googly eyes';
  }

  @override
  String cuddleContent(Object senderName) {
    return '$senderName cuddles you';
  }

  @override
  String hugContent(Object senderName) {
    return '$senderName hugs you';
  }

  @override
  String answeredTheCall(Object senderName, Object sendername) {
    return '$senderName أجاب على المكالمة';
  }

  @override
  String get anyoneCanJoin => 'يمكن لأي أحد الدخول';

  @override
  String get appLock => 'قفل التطبيق';

  @override
  String get archive => 'الأرشيف';

  @override
  String get archivedRoom => 'غرفة مؤرشفة';

  @override
  String get areGuestsAllowedToJoin => 'هل يُسمح للزوار الدخول';

  @override
  String get areYouSure => 'أمتأكد؟';

  @override
  String get areYouSureYouWantToLogout => 'أمتأكد من الخروج؟';

  @override
  String get askSSSSSign => 'لتتمكن من التأكد من الشخص الآخر، يرجى إدخال عبارة المرور أو مفتاح الاسترداد.';

  @override
  String askVerificationRequest(Object username) {
    return 'أتقبل طلب تحقق $username؟';
  }

  @override
  String get autoplayImages => 'شغِّل الملصقات والوجوه المتحركة تلقائيا';

  @override
  String badServerLoginTypesException(Object serverVersions, Object supportedVersions, Object suportedVersions) {
    return 'يدعم الخادم المستخدم أنواع تسجيل الدخول التالية:\n$serverVersions\nلكن هذا التطبيق يدعم فقط:\n$supportedVersions';
  }

  @override
  String get sendOnEnter => 'أرسل عند الدخول';

  @override
  String badServerVersionsException(Object serverVersions, Object supportedVersions, Object serverVerions, Object suportedVersions) {
    return 'يدعم الخادم الرئيسي المستخدم إصدارات المواصفات:\n$serverVersions\nلكن هذا التطبيق يدعم فقط:\n$supportedVersions';
  }

  @override
  String get banFromChat => 'حظر من المحادثة';

  @override
  String get banned => 'محظور';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username حظر $targetName';
  }

  @override
  String get blockDevice => 'أُحظر الجهاز';

  @override
  String get blocked => 'محجوب';

  @override
  String get botMessages => 'رسائل البوت';

  @override
  String get bubbleSize => 'حجم الفقاعة';

  @override
  String get cancel => 'ألغِ';

  @override
  String cantOpenUri(Object uri) {
    return 'تعذر فتح المسار $uri';
  }

  @override
  String get changeDeviceName => 'غيّر اسم الجهاز';

  @override
  String changedTheChatAvatar(Object username) {
    return 'غيَّر $username صورة المحادثة';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return 'غيَّر $username وصف المحادثة الى: \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return 'غيَّر $username اسم المحادثة الى: \'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return 'غيَّر $username أذون المحادثة';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username غير إسمه العلني إلى: \'$displayname\'';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return 'غيّر $username قواعد وصول الزوار';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return 'غيّر $username قواعد وصول الزوار الى: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return 'غيَّر $username مرئية التأريخ';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return 'غيَّر $username مرئية التأريخ الى: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return 'غيَّر $username قواعد الانضمام';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return 'غيَّر $username قواعد الانضمام الى: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return 'غيّر $username صورته الشخصية';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return 'غيّر $username ألقاب الغرف';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return 'غيّر $username رابط الدعوة';
  }

  @override
  String get changePassword => 'غيّر كلمة السر';

  @override
  String get changeTheHomeserver => 'غيّر الخادم';

  @override
  String get changeTheme => 'غيّر أسلوبك';

  @override
  String get changeTheNameOfTheGroup => 'غيِّر اسم المجموعة';

  @override
  String get changeWallpaper => 'غيِّر الخلفية';

  @override
  String get changeYourAvatar => 'غيّر الصورة الرمزية';

  @override
  String get channelCorruptedDecryptError => 'فسُد التشفير';

  @override
  String get chat => 'محادثة';

  @override
  String get yourUserId => 'معرّف المستخدم:';

  @override
  String get yourChatBackupHasBeenSetUp => 'تم إعداد النسخ الاحتياطي لمحادثاتك.';

  @override
  String get chatBackup => 'انسخ احتياطيًا المحادثة';

  @override
  String get chatBackupDescription => 'النسخ الاحتياطي لمحادثاتك مأمن بمفتاح، تأكد ألّا تفقده.';

  @override
  String get chatDetails => 'تفاصيل المحادثة';

  @override
  String get chatHasBeenAddedToThisSpace => 'أُضيفت المحادثة الى هذا الفضاء';

  @override
  String get chats => 'المحادثات';

  @override
  String get chooseAStrongPassword => 'اختر كلمة سر قوية';

  @override
  String get chooseAUsername => 'اختر اسم المستخدم';

  @override
  String get clearArchive => 'امسح الأرشيف';

  @override
  String get close => 'اغلق';

  @override
  String get commandHint_markasdm => 'Mark as direct chat';

  @override
  String get commandHint_markasgroup => 'Mark as chat';

  @override
  String get commandHint_ban => 'يحظر المستخدم المذكور من هذه الغرفة';

  @override
  String get commandHint_clearcache => 'مسح الذاكرة المؤقتة';

  @override
  String get commandHint_create => 'أنشأ محادثة جماعية فارغة\nاستخدم --لا-تشفير لتعطيل التشفير';

  @override
  String get commandHint_discardsession => 'إنهاء الجلسة';

  @override
  String get commandHint_dm => 'إبدأ محادثة مباشرة\nاستخدم --لا-تشفير لتعطيل التشفير';

  @override
  String get commandHint_html => 'أرسل نصًا بتنسيق HTML';

  @override
  String get commandHint_invite => 'يدعو المستخدم المذكور الى الغرفة';

  @override
  String get commandHint_join => 'تنضم الى الغرفة المذكورة';

  @override
  String get commandHint_kick => 'يزيل المستخدم المذكور من الغرفة';

  @override
  String get commandHint_leave => 'تغادر هذه الغرفة';

  @override
  String get commandHint_me => 'صف نفسك';

  @override
  String get commandHint_myroomavatar => 'حدد صورتك لهذه الغرفة (عن طريق mxc-uri)';

  @override
  String get commandHint_myroomnick => 'عين اسمًا لك مخصص لهذه الغرفة';

  @override
  String get commandHint_op => 'عين مستوى نفوذ المستخدم في هذه الغرفة (الافتراضي: 50)';

  @override
  String get commandHint_plain => 'أرسل نصًا غير منسق';

  @override
  String get commandHint_react => 'أرسل ردًا كتفاعل';

  @override
  String get commandHint_send => 'أرسل نصًا';

  @override
  String get commandHint_unban => 'فك الحظر عن المستخدم المذكور في هذه الغرفة';

  @override
  String get commandInvalid => 'أمر غير صالح';

  @override
  String commandMissing(Object command) {
    return '$command ليس بأمر.';
  }

  @override
  String get compareEmojiMatch => 'تأكد من أن هذه الإيموجي تطابق الموجودة على الأجهزة الأخرى:';

  @override
  String get compareNumbersMatch => 'تأكد من أن هذه الأرقام تطابق الموجودة على الأجهزة الأخرى:';

  @override
  String get configureChat => 'ضبط المحادثة';

  @override
  String get confirm => 'أكّد';

  @override
  String get connect => 'اتصل';

  @override
  String get contactHasBeenInvitedToTheGroup => 'دعيَ المراسل للمجموعة';

  @override
  String get containsDisplayName => 'يحوي الاسم العلني';

  @override
  String get containsUserName => 'يحوي اسم المستخدم';

  @override
  String get contentHasBeenReported => 'أّرسل الابلاغ الى مدير الخادم';

  @override
  String get copiedToClipboard => 'نُسخ للحافظة';

  @override
  String get copy => 'انسخ';

  @override
  String get copyToClipboard => 'انسخ الى الحافظة';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'تعذر فك تشفير الرسالة: $error';
  }

  @override
  String countMembers(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count members',
      one: '1 member',
      zero: 'no members',
    );
    return '$_temp0';
  }

  @override
  String get create => 'أنشئ';

  @override
  String createdTheChat(Object username) {
    return 'أنشأ $username المحادثة';
  }

  @override
  String get createNewGroup => 'أنشئ مجموعة جديدة';

  @override
  String get createNewSpace => 'فضاء جديد';

  @override
  String get crossSigningEnabled => 'التأكد المتبادل مفعل';

  @override
  String get currentlyActive => 'نشطٌ حاليا';

  @override
  String get darkTheme => 'داكن';

  @override
  String dateAndTimeOfDay(Object date, Object timeOfDay) {
    return '$date, $timeOfDay';
  }

  @override
  String dateWithoutYear(Object month, Object day) {
    return '$month-$day';
  }

  @override
  String dateWithYear(Object year, Object month, Object day) {
    return '$day/$month/$year';
  }

  @override
  String get deactivateAccountWarning => 'لا مجال للعودة، أتأكد تعطيل حسابك؟';

  @override
  String get defaultPermissionLevel => 'مستوى الأذونات الإفتراضي';

  @override
  String get delete => 'احذف';

  @override
  String get deleteAccount => 'احذف الحساب';

  @override
  String get deleteMessage => 'حذف الرسالة';

  @override
  String get deny => 'رفض';

  @override
  String get device => 'جهاز';

  @override
  String get deviceId => 'معرّف الجهاز';

  @override
  String get devices => 'الأجهزة';

  @override
  String get directChats => 'محادثات مباشرة';

  @override
  String get discover => 'اكتشف';

  @override
  String get displaynameHasBeenChanged => 'غُيِّر الاسم العلني';

  @override
  String get download => 'Download';

  @override
  String get edit => 'عدّل';

  @override
  String get editBlockedServers => 'عدّل الخوادم المحجوبة';

  @override
  String get editChatPermissions => 'عدّل تصاريح المحادثة';

  @override
  String get editDisplayname => 'حرر الاسم العلني';

  @override
  String get editRoomAliases => 'عدّل الاسم المميز للغرفة';

  @override
  String get editRoomAvatar => 'عدّل الصورة الرمزية للغرفة';

  @override
  String get emoteExists => 'الانفعالة موجودة مسبقا!';

  @override
  String get emoteInvalid => 'رمز الانفعالة غير صالح!';

  @override
  String get emotePacks => 'حزمة الوجوه التعبيرية للغرفة';

  @override
  String get emoteSettings => 'اعدادات الانفعالات';

  @override
  String get emoteShortcode => 'رمز الانفعالة';

  @override
  String get emoteWarnNeedToPick => 'اختر صورة ورمزا للانفعالة!';

  @override
  String get emptyChat => 'محادثة فارغة';

  @override
  String get enableEmotesGlobally => 'تفعيل حزمة التعبيرات بشكل عام';

  @override
  String get enableEncryption => 'فعّل التشفير';

  @override
  String get enableEncryptionWarning => 'لن يمكنك تعطيل التشفير أبدا، أمتأكد؟';

  @override
  String get encrypted => 'مشفر';

  @override
  String get encryption => 'التشفير';

  @override
  String get encryptionNotEnabled => 'التشفير معطل';

  @override
  String endedTheCall(Object senderName) {
    return 'أنهى $senderName المكالمة';
  }

  @override
  String get enterGroupName => 'Enter chat name';

  @override
  String get enterAnEmailAddress => 'أدخل عنوان بريد إلكتروني';

  @override
  String get enterASpacepName => 'أدخل اسم الفضاء';

  @override
  String get homeserver => 'الخادم';

  @override
  String get enterYourHomeserver => 'أدخل الخادم';

  @override
  String errorObtainingLocation(Object error) {
    return 'خطأ أثناء الحصول على الموقع: $error';
  }

  @override
  String get everythingReady => 'كل شيء جاهز!';

  @override
  String get extremeOffensive => 'مسيئة للغاية';

  @override
  String get fileName => 'اسم الملف';

  @override
  String get fluffychat => 'فلافي-شات';

  @override
  String get fontSize => 'حجم الخط';

  @override
  String get forward => 'أعد التوجيه';

  @override
  String get friday => 'الجمعة';

  @override
  String get fromJoining => 'من بعد الانضمام';

  @override
  String get fromTheInvitation => 'من بعد الدعوة';

  @override
  String get goToTheNewRoom => 'انتقل للغرفة الجديدة';

  @override
  String get group => 'المجموعة';

  @override
  String get groupDescription => 'وصف المجموعة';

  @override
  String get groupDescriptionHasBeenChanged => 'غُيِّر وصف المجموعة';

  @override
  String get groupIsPublic => 'المجموعة عامة';

  @override
  String get groups => 'المجموعات';

  @override
  String groupWith(Object displayname) {
    return 'في مجموعة مع $displayname';
  }

  @override
  String get guestsAreForbidden => 'يمنع الزوار';

  @override
  String get guestsCanJoin => 'يمكن للزوار الانضمام';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return 'سحب $username دعوة $targetName';
  }

  @override
  String get help => 'المساعدة';

  @override
  String get hideRedactedEvents => 'إخفاء الأحداث المنقحة';

  @override
  String get hideUnknownEvents => 'اخف الأحداث المجهولة';

  @override
  String get howOffensiveIsThisContent => 'ما مدى سوء هذا المحتوى؟';

  @override
  String get id => 'المعرّف';

  @override
  String get identity => 'المُعرّف';

  @override
  String get ignore => 'تجاهل';

  @override
  String get ignoredUsers => 'المستخدمون المتجاهلون';

  @override
  String get ignoreListDescription => 'يمكنك تجاهل المستخدمين المزعجين، لن يتمكنوا من مراسلتك أو دعوتك لغرفة ما داموا في قائمة التجاهل.';

  @override
  String get ignoreUsername => 'تجاهل اسم المستخدم';

  @override
  String get iHaveClickedOnLink => 'نقرت على الرابط';

  @override
  String get incorrectPassphraseOrKey => 'عبارة مرور أو مفتاح استرداد خطأ';

  @override
  String get inoffensive => 'غير مسيء';

  @override
  String get inviteContact => 'دعوة مراسل';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'أدعو مراسلا الى $groupName';
  }

  @override
  String get invited => 'دُعيَ';

  @override
  String invitedUser(Object username, Object targetName) {
    return '$username دعى $targetName';
  }

  @override
  String get invitedUsersOnly => 'المستخدمون المدعوون فقط';

  @override
  String get inviteForMe => 'دعوات لي';

  @override
  String inviteText(Object username, Object link) {
    return 'دعاك $username لاستخدام فلافي-شات. \n1. ثبت فلافي-شات: https://fluffychat.im \n2. لج أو سجل\n3. افتح رابط الدعوة: $link';
  }

  @override
  String get isTyping => 'يكتب';

  @override
  String joinedTheChat(Object username) {
    return 'انضم $username للمحادثة';
  }

  @override
  String get joinRoom => 'انضم للمحادثة';

  @override
  String get keysCached => 'المفاتيح محفوظة على ذاكرة التخزين المؤقتة';

  @override
  String kicked(Object username, Object targetName) {
    return '$username طرد $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '$username طرد وحظر $targetName';
  }

  @override
  String get kickFromChat => 'طرد من المحادثة';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'آخر نشاط: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'آخر ظهور كان منذ زمن طويل';

  @override
  String get leave => 'غادر';

  @override
  String get leftTheChat => 'غادر المحادثة';

  @override
  String get license => 'الرخصة';

  @override
  String get lightTheme => 'فاتح';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'حمِّل $count منتسبًا إضافيًا';
  }

  @override
  String get dehydrate => 'Export session and wipe device';

  @override
  String get dehydrateWarning => 'This action cannot be undone. Ensure you safely store the backup file.';

  @override
  String get dehydrateShare => 'This is your private FluffyChat export. Ensure you don\'t lose it and keep it private.';

  @override
  String get dehydrateTor => 'TOR Users: Export session';

  @override
  String get dehydrateTorLong => 'For TOR users, it is recommended to export the session before closing the window.';

  @override
  String get hydrateTor => 'TOR Users: Import session export';

  @override
  String get hydrateTorLong => 'Did you export your session last time on TOR? Quickly import it and continue chatting.';

  @override
  String get hydrate => 'Restore from backup file';

  @override
  String get loadingPleaseWait => 'يحمّل… يرجى الانتظار.';

  @override
  String get loadingStatus => 'Loading status...';

  @override
  String get loadMore => 'حمِّل المزيد…';

  @override
  String get locationDisabledNotice => 'خدمات الموقع معطلة. مكنها لتتمكن من مشاركة موقعك.';

  @override
  String get locationPermissionDeniedNotice => 'تم رفض إذن الموقع. الرجاء منح الإذن للقدرة على مشاركة موقعك.';

  @override
  String get login => 'لِج';

  @override
  String logInTo(Object homeserver) {
    return 'لِج ل $homeserver';
  }

  @override
  String get loginWithOneClick => 'تسجيل الدخول بكبسة واحدة';

  @override
  String get logout => 'اخرج';

  @override
  String get makeSureTheIdentifierIsValid => 'تأكد من صحة المعرّف';

  @override
  String get memberChanges => 'تغييرات تخص الأعضاء';

  @override
  String get mention => 'اذكر';

  @override
  String get messages => 'الرسائل';

  @override
  String get messageWillBeRemovedWarning => 'ستحذف الرسالة عند كل المنتسبين';

  @override
  String get noSearchResult => 'No matching search results.';

  @override
  String get moderator => 'مشرف';

  @override
  String get monday => 'الثلاثاء';

  @override
  String get muteChat => 'أكتم الماحدثة';

  @override
  String get needPantalaimonWarning => 'اعلم أننا نستخدم بانتاليمون للتشفير طرفا لطرف.';

  @override
  String get newChat => 'محادثة جديدة';

  @override
  String get newMessageInTwake => 'You have 1 encrypted message';

  @override
  String get newVerificationRequest => 'طلب تحقق جديد!';

  @override
  String get noMoreResult => 'No more result!';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'التالي';

  @override
  String get no => 'لا';

  @override
  String get noConnectionToTheServer => 'انقطع الاتصال بالخادم';

  @override
  String get noEmotesFound => 'لم يُعثر على انفعالة. 😕';

  @override
  String get noEncryptionForPublicRooms => 'يمكنك فقط تفعيل التشفير عندما تصبح الغرفة غير متاحة للعامة.';

  @override
  String get noGoogleServicesWarning => 'يبدو أنك لا تستخدم خدمات غوغل على هاتفك. هذا قرار جيد للحفاظ على خصوصيتك! من أجل استلام الإشعارات في FluffyChat نقترح استخدام https://microg.org أو https://unifiedpush.org.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 ليس خادم ماتريكس، بدلًا منه أتريد استخدام $server2؟';
  }

  @override
  String get shareYourInviteLink => 'شارك رابط الدعوة';

  @override
  String get typeInInviteLinkManually => 'اكتب رابط الدعوة...';

  @override
  String get scanQrCode => 'امسح رمز الاستجابة السريعة';

  @override
  String get none => 'بدون';

  @override
  String get noPasswordRecoveryDescription => 'لم تضف أي طريقة لاستعادة كلمة السر.';

  @override
  String get noPermission => 'بدون اذن';

  @override
  String get noRoomsFound => 'لم يُعثر على غرف…';

  @override
  String get notifications => 'الإشعارات';

  @override
  String numUsersTyping(Object count) {
    return '$count يكتبون';
  }

  @override
  String get obtainingLocation => 'يحصل على الموقع…';

  @override
  String get offensive => 'عدواني';

  @override
  String get offline => 'غير متصل';

  @override
  String get aWhileAgo => 'a while ago';

  @override
  String get ok => 'موافق';

  @override
  String get online => 'متصل';

  @override
  String get onlineKeyBackupEnabled => 'تم تفعيل النسخ الاحتياطي للمفاتيح عبر الإنترنت';

  @override
  String get cannotEnableKeyBackup => 'Cannot enable Chat Backup. Please Go to Settings to try it again.';

  @override
  String get cannotUploadKey => 'Cannot store Key Backup.';

  @override
  String get oopsPushError => 'عذراً! للأسف، حدث خطأ أثناء إعداد الإشعارات.';

  @override
  String get oopsSomethingWentWrong => 'عذراً، هناك خطأ ما…';

  @override
  String get openAppToReadMessages => 'افتح التطبيق لقراءة الرسائل';

  @override
  String get openCamera => 'افتح الكميرا';

  @override
  String get openVideoCamera => 'افتح الكاميرا لمقطع فيديو';

  @override
  String get oneClientLoggedOut => 'أُ خرج أحد العملاء الذي تسختدمها';

  @override
  String get addAccount => 'أضف حسابًا';

  @override
  String get editBundlesForAccount => 'عدّل حزم هذا الحساب';

  @override
  String get addToBundle => 'أضفه الى حزمة';

  @override
  String get removeFromBundle => 'أزله من الحزمة';

  @override
  String get bundleName => 'اسم الحزمة';

  @override
  String get enableMultiAccounts => '(ميزة تجربية) فعّل تعدد الحسابات';

  @override
  String get openInMaps => 'افتح في الخريطة';

  @override
  String get link => 'رابط';

  @override
  String get serverRequiresEmail => 'يتطلب هذا الخادم التحقق من بريدك الإلكتروني.';

  @override
  String get optionalGroupName => 'اسم المجموعة (اختياري)';

  @override
  String get or => 'أو';

  @override
  String get participant => 'منتسب';

  @override
  String get passphraseOrKey => 'عبارة المرور أو مفتاح الاستعادة';

  @override
  String get password => 'كلمة السر';

  @override
  String get passwordForgotten => 'نسيتَ كلمة السر';

  @override
  String get passwordHasBeenChanged => 'غُيّرت كلمة السر';

  @override
  String get passwordRecovery => 'استعادة كلمة السر';

  @override
  String get people => 'أشخاص';

  @override
  String get pickImage => 'اختر صورة';

  @override
  String get pin => 'ثبِّت';

  @override
  String play(Object fileName) {
    return 'شغّل $fileName';
  }

  @override
  String get pleaseChoose => 'اختر رجاء';

  @override
  String get pleaseChooseAPasscode => 'اختر رمز المرور';

  @override
  String get pleaseChooseAUsername => 'اختر اسم المستخدم';

  @override
  String get pleaseClickOnLink => 'يرجى النقر على الرابط الموجود في البريد الإلكتروني ثم المتابعة.';

  @override
  String get pleaseEnter4Digits => 'أدخل 4 أرقام أو أتركه فارغ لتعطيل القفل.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'أدخل معرف Matrix.';

  @override
  String get pleaseEnterRecoveryKey => 'Please enter your recovery key:';

  @override
  String get pleaseEnterYourPassword => 'أدخل كلمة السر';

  @override
  String get pleaseEnterYourPin => 'الرجاء إدخال رقم التعريف الشخصي الخاص بك';

  @override
  String get pleaseEnterYourUsername => 'أدخل اسم المستخدم';

  @override
  String get pleaseFollowInstructionsOnWeb => 'يرجى اتباع التعليمات الموجودة على الموقع والنقر على التالي.';

  @override
  String get privacy => 'الخصوصية';

  @override
  String get publicRooms => 'الغرف العامة';

  @override
  String get pushRules => 'قواعد الإشعارات';

  @override
  String get reason => 'السبب';

  @override
  String get recording => 'يسجل';

  @override
  String redactedAnEvent(Object username) {
    return 'حذف $username حدثًا';
  }

  @override
  String get redactMessage => 'احذف رسالة';

  @override
  String get register => 'سجّل';

  @override
  String get reject => 'رفض';

  @override
  String rejectedTheInvitation(Object username) {
    return 'رفض $username الدعوة';
  }

  @override
  String get rejoin => 'أعد الانضمام';

  @override
  String get remove => 'أزِل';

  @override
  String get removeAllOtherDevices => 'أزِل كل الأجهزة الأخرى';

  @override
  String removedBy(Object username) {
    return 'أزاله $username';
  }

  @override
  String get removeDevice => 'أزل جهازا';

  @override
  String get unbanFromChat => 'فك حجبه من المحادثة';

  @override
  String get removeYourAvatar => 'أزل الصورة الرمزية';

  @override
  String get renderRichContent => 'صيّر الرسائل ذات المحتوى الكبير';

  @override
  String get replaceRoomWithNewerVersion => 'استبدل الغرفة باصدار أحدث';

  @override
  String get reply => 'ردّ';

  @override
  String get reportMessage => 'أبلغ عن الرسالة';

  @override
  String get requestPermission => 'أطلب إذنا';

  @override
  String get roomHasBeenUpgraded => 'رُقيّت الغرفة';

  @override
  String get roomVersion => 'إصدار الغرفة';

  @override
  String get saturday => 'السبت';

  @override
  String get saveFile => 'احفظ الملف';

  @override
  String get searchForPeopleAndChannels => 'Search for people and channels';

  @override
  String get security => 'الأمان';

  @override
  String get recoveryKey => 'Recovery key';

  @override
  String get recoveryKeyLost => 'Recovery key lost?';

  @override
  String seenByUser(Object username) {
    return 'رآه $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'رآه $username و $count أخرون',
    );
    return '$_temp0';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'رآه $username و $username2';
  }

  @override
  String get send => 'أرسل';

  @override
  String get sendAMessage => 'أرسل رسالة';

  @override
  String get sendAsText => 'أرسل نصًا';

  @override
  String get sendAudio => 'أرسل ملفًا صوتيًا';

  @override
  String get sendFile => 'أرسل ملف';

  @override
  String get sendImage => 'أرسل صورة';

  @override
  String get sendMessages => 'إرسال رسائل';

  @override
  String get sendMessage => 'Send message';

  @override
  String get sendOriginal => 'أرسل الملف الأصلي';

  @override
  String get sendSticker => 'أرسل ملصقًا';

  @override
  String get sendVideo => 'أرسل فيديو';

  @override
  String sentAFile(Object username) {
    return 'أرسلَ $username ملفًا';
  }

  @override
  String sentAnAudio(Object username) {
    return 'أرسلَ $username ملفًا صوتيًا';
  }

  @override
  String sentAPicture(Object username) {
    return 'أرسلَ $username صورة';
  }

  @override
  String sentASticker(Object username) {
    return 'أرسلَ $username ملصقا';
  }

  @override
  String sentAVideo(Object username) {
    return 'أرسلَ $username فيديو';
  }

  @override
  String sentCallInformations(Object senderName) {
    return 'أرسل $senderName معلومات مكالمة';
  }

  @override
  String get separateChatTypes => 'Separate Direct Chats and Groups';

  @override
  String get setAsCanonicalAlias => 'تعيين كاسم مستعار رئيسي';

  @override
  String get setCustomEmotes => 'عيّن وجوهًا تعبيرية مخصصة';

  @override
  String get setGroupDescription => 'عيّن وصفا للمجموعة';

  @override
  String get setInvitationLink => 'عيّن رابط الدعوة';

  @override
  String get setPermissionsLevel => 'تعيين مستوى الأذونات';

  @override
  String get setStatus => 'عيّن الحالة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get share => 'شارك';

  @override
  String sharedTheLocation(Object username) {
    return 'شارك $username موقعه';
  }

  @override
  String get shareLocation => 'شارك الموقع';

  @override
  String get showDirectChatsInSpaces => 'Show related Direct Chats in Spaces';

  @override
  String get showPassword => 'أظهر كلمة السر';

  @override
  String get signUp => 'سجّل';

  @override
  String get singlesignon => 'تسجيل دخول أحادي';

  @override
  String get skip => 'تخط';

  @override
  String get invite => 'Invite';

  @override
  String get sourceCode => 'الشفرة المصدرية';

  @override
  String get spaceIsPublic => 'الفضاء عمومي';

  @override
  String get spaceName => 'اسم الفضاء';

  @override
  String startedACall(Object senderName) {
    return 'بدأ $senderName مكالمة';
  }

  @override
  String get startFirstChat => 'Start your first chat';

  @override
  String get status => 'الحالة';

  @override
  String get statusExampleMessage => 'ماهو وضعك؟';

  @override
  String get submit => 'أرسل';

  @override
  String get sunday => 'الأحد';

  @override
  String get synchronizingPleaseWait => 'يُزامن… يرجى الانتظار.';

  @override
  String get systemTheme => 'النظام';

  @override
  String get theyDontMatch => 'لا يتطبقان';

  @override
  String get theyMatch => 'متطبقان';

  @override
  String get thisRoomHasBeenArchived => 'أُرشِفت هته الغرفة.';

  @override
  String get thursday => 'الخميس';

  @override
  String get title => 'فلافي-شات';

  @override
  String get toggleFavorite => 'بدّل حالة التفضيل';

  @override
  String get toggleMuted => 'بدّل حالة الكتم';

  @override
  String get toggleUnread => 'علّمه كمقروء/غير مقروء';

  @override
  String get tooManyRequestsWarning => 'طابات كثيرة. حاول مجددًا لاحقًا!';

  @override
  String get transferFromAnotherDevice => 'أنقله من جهاز آخر';

  @override
  String get tryToSendAgain => 'حاول إعادة الارسال';

  @override
  String get tuesday => 'الثلاثاء';

  @override
  String get unavailable => 'غير متوفر';

  @override
  String unbannedUser(Object username, Object targetName) {
    return 'ألغى $username حظر $targetName';
  }

  @override
  String get unblockDevice => 'ألغ حظر الجهاز';

  @override
  String get unknownDevice => 'جهز مجهول';

  @override
  String get unknownEncryptionAlgorithm => 'خوارزمية تشفير مجهولة';

  @override
  String unknownEvent(Object type, Object tipo) {
    return 'حدث مجهول \'$type\'';
  }

  @override
  String get unmuteChat => 'ألغِ كتم المحادثة';

  @override
  String get unpin => 'ألغِ التثبيت';

  @override
  String unreadChats(num unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount محادثات غير مقروءة',
      one: '1 محادثة غير مقروءة',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username و $count أخرون يكتبون';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username و $username2 يكتبان';
  }

  @override
  String userIsTyping(Object username) {
    return '$username يكتب';
  }

  @override
  String userLeftTheChat(Object username) {
    return 'غادر $username المحادثة';
  }

  @override
  String get username => 'اسم المستخدم';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return 'أرسل $username حدث $type';
  }

  @override
  String get unverified => 'غير مؤكد';

  @override
  String get verified => 'موثّق';

  @override
  String get verify => 'تحقق';

  @override
  String get verifyStart => 'ابدأ التحقق';

  @override
  String get verifySuccess => 'تُحقق منك بنجاح!';

  @override
  String get verifyTitle => 'يتحقق من الحساب الآخر';

  @override
  String get videoCall => 'مكالمة فيديو';

  @override
  String get visibilityOfTheChatHistory => 'مرئية تأريخ المحادثة';

  @override
  String get visibleForAllParticipants => 'مرئي لكل المنتسبين';

  @override
  String get visibleForEveryone => 'مرئي للجميع';

  @override
  String get voiceMessage => 'رسالة صوتية';

  @override
  String get waitingPartnerAcceptRequest => 'ينتظر قبول الشريك للطلب…';

  @override
  String get waitingPartnerEmoji => 'ينتظر قبول الشريك لإيموجي…';

  @override
  String get waitingPartnerNumbers => 'ينتظر قبول الشريك للأرقام…';

  @override
  String get wallpaper => 'الخلفية';

  @override
  String get warning => 'تحذير!';

  @override
  String get wednesday => 'الأربعاء';

  @override
  String get weSentYouAnEmail => 'أرسلنا لك رسالة بالبريد الإلكتروني';

  @override
  String get whoCanPerformWhichAction => 'من يستطيع القيام بأي عمل';

  @override
  String get whoIsAllowedToJoinThisGroup => 'من يسمح له الانضمام للمجموعة';

  @override
  String get whyDoYouWantToReportThis => 'لماذا تريد الإبلاغ عنه؟';

  @override
  String get wipeChatBackup => 'أتريد حذف النسخ الاحتياطي للمحادثة لإنشاء مفتاح أمان جديد؟';

  @override
  String get withTheseAddressesRecoveryDescription => 'يمكنك استعادة كلمة السر بهذه العناوين.';

  @override
  String get writeAMessage => 'اكتب رسالة…';

  @override
  String get yes => 'نعم';

  @override
  String get you => 'انت';

  @override
  String get youAreInvitedToThisChat => 'دُعيتَ لهذه المحادثة';

  @override
  String get youAreNoLongerParticipatingInThisChat => 'لم تعد منتسبا لهذه المحادثة';

  @override
  String get youCannotInviteYourself => 'لا يمكنك دعوة نفسك';

  @override
  String get youHaveBeenBannedFromThisChat => 'حُظرت من هذه المحادثة';

  @override
  String get yourPublicKey => 'مفتاحك العمومي';

  @override
  String get messageInfo => 'معلومات الرسالة';

  @override
  String get time => 'الوقت';

  @override
  String get messageType => 'نوع الرسالة';

  @override
  String get sender => 'المرسل';

  @override
  String get openGallery => 'افتخ المعرض';

  @override
  String get removeFromSpace => 'أزل من الفضاء';

  @override
  String get addToSpaceDescription => 'إختر فضاء لإضافة هذه المحادثة إليه.';

  @override
  String get start => 'إبدأ';

  @override
  String get pleaseEnterRecoveryKeyDescription => 'To unlock your old messages, please enter your recovery key that has been generated in a previous session. Your recovery key is NOT your password.';

  @override
  String get addToStory => 'إضافة للقصة';

  @override
  String get publish => 'انشر';

  @override
  String get whoCanSeeMyStories => 'من يمكنه رؤية قصصي؟';

  @override
  String get unsubscribeStories => 'إلغاء الإشتراك بالقصص';

  @override
  String get thisUserHasNotPostedAnythingYet => 'هذا المستخدم لم ينشر أي شيء في قصته حتى الآن';

  @override
  String get yourStory => 'قصتك';

  @override
  String get replyHasBeenSent => 'تم إرسال الرد';

  @override
  String videoWithSize(Object size) {
    return 'فيديو ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return 'رسالة من $date: \n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc => 'يرجى ملاحظة أنه يمكن للأشخاص رؤية بعضهم البعض والتواصل مع بعضهم البعض في قصتك.';

  @override
  String get whatIsGoingOn => 'ما الذي يحصل؟';

  @override
  String get addDescription => 'إضافة وصف';

  @override
  String get storyPrivacyWarning => 'يرجى ملاحظة أنه يمكن للأشخاص رؤية بعضهم البعض والتواصل مع بعضهم البعض في قصتك. ستكون قصصك مرئية لمدة 24 ساعة ولكن ليس هناك ما يضمن حذفها من جميع الأجهزة والخوادم.';

  @override
  String get iUnderstand => 'أنا أتفهم';

  @override
  String get openChat => 'فتح المحادثة';

  @override
  String get markAsRead => 'حدد كمقروء';

  @override
  String get reportUser => 'التبيلغ عن المستخدم';

  @override
  String get dismiss => 'رفض';

  @override
  String get matrixWidgets => 'إضافات ماتريكس';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender تفاعل ب $reaction';
  }

  @override
  String get pinChat => 'Pin';

  @override
  String get confirmEventUnpin => 'هل أنت متأكد من إلغاء تثبيت الحدث بشكل دائم؟';

  @override
  String get emojis => 'إيموجي';

  @override
  String get placeCall => 'إجراء مكالمة';

  @override
  String get voiceCall => 'مكالمة صوتية';

  @override
  String get unsupportedAndroidVersion => 'نسخة أندرويد غير مدعومة';

  @override
  String get unsupportedAndroidVersionLong => 'تتطلب هذه الميزة إصدار Android أحدث. يرجى التحقق من وجود تحديثات أو دعم Lineage OS.';

  @override
  String get videoCallsBetaWarning => 'يرجى ملاحظة أن مكالمات الفيديو حالياً في مرحلة تجريبية. قد لا تعمل كما هو متوقع أو تعمل على الإطلاق على جميع المنصات.';

  @override
  String get experimentalVideoCalls => 'مكالمات الفيديو التجريبية';

  @override
  String get emailOrUsername => 'البريد الإلكتروني أو اسم المستخدم';

  @override
  String get indexedDbErrorTitle => 'Private mode issues';

  @override
  String get indexedDbErrorLong => 'The message storage is unfortunately not enabled in private mode by default.\nPlease visit\n - about:config\n - set dom.indexedDB.privateBrowsing.enabled to true\nOtherwise, it is not possible to run FluffyChat.';

  @override
  String switchToAccount(Object number) {
    return 'Switch to account $number';
  }

  @override
  String get nextAccount => 'Next account';

  @override
  String get previousAccount => 'Previous account';

  @override
  String get editWidgets => 'Edit widgets';

  @override
  String get addWidget => 'Add widget';

  @override
  String get widgetVideo => 'Video';

  @override
  String get widgetEtherpad => 'Text note';

  @override
  String get widgetJitsi => 'Jitsi Meet';

  @override
  String get widgetCustom => 'Custom';

  @override
  String get widgetName => 'Name';

  @override
  String get widgetUrlError => 'This is not a valid URL.';

  @override
  String get widgetNameError => 'Please provide a display name.';

  @override
  String get errorAddingWidget => 'Error adding the widget.';

  @override
  String get youRejectedTheInvitation => 'You rejected the invitation';

  @override
  String get youJoinedTheChat => 'You joined the chat';

  @override
  String get youAcceptedTheInvitation => '👍 You accepted the invitation';

  @override
  String youBannedUser(Object user) {
    return 'You banned $user';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return 'You have withdrawn the invitation for $user';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩 You have been invited by $user';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩 You invited $user';
  }

  @override
  String youKicked(Object user) {
    return '👞 You kicked $user';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅 You kicked and banned $user';
  }

  @override
  String youUnbannedUser(Object user) {
    return 'You unbanned $user';
  }

  @override
  String get noEmailWarning => 'Please enter a valid email address. Otherwise you won\'t be able to reset your password. If you don\'t want to, tap again on the button to continue.';

  @override
  String get stories => 'Stories';

  @override
  String get users => 'Users';

  @override
  String get enableAutoBackups => 'Enable auto backups';

  @override
  String get unlockOldMessages => 'Unlock old messages';

  @override
  String get cannotUnlockBackupKey => 'Cannot unlock Key backup.';

  @override
  String get storeInSecureStorageDescription => 'Store the recovery key in the secure storage of this device.';

  @override
  String get saveKeyManuallyDescription => 'Save this key manually by triggering the system share dialog or clipboard.';

  @override
  String get storeInAndroidKeystore => 'Store in Android KeyStore';

  @override
  String get storeInAppleKeyChain => 'Store in Apple KeyChain';

  @override
  String get storeSecurlyOnThisDevice => 'Store securely on this device';

  @override
  String countFiles(Object count) {
    return '$count files';
  }

  @override
  String get user => 'User';

  @override
  String get custom => 'Custom';

  @override
  String get foregroundServiceRunning => 'This notification appears when the foreground service is running.';

  @override
  String get screenSharingTitle => 'screen sharing';

  @override
  String get screenSharingDetail => 'You are sharing your screen in FuffyChat';

  @override
  String get callingPermissions => 'Calling permissions';

  @override
  String get callingAccount => 'Calling account';

  @override
  String get callingAccountDetails => 'Allows FluffyChat to use the native android dialer app.';

  @override
  String get appearOnTop => 'Appear on top';

  @override
  String get appearOnTopDetails => 'Allows the app to appear on top (not needed if you already have Fluffychat setup as a calling account)';

  @override
  String get otherCallingPermissions => 'Microphone, camera and other FluffyChat permissions';

  @override
  String get whyIsThisMessageEncrypted => 'Why is this message unreadable?';

  @override
  String get noKeyForThisMessage => 'This can happen if the message was sent before you have signed in to your account at this device.\n\nIt is also possible that the sender has blocked your device or something went wrong with the internet connection.\n\nAre you able to read the message on another session? Then you can transfer the message from it! Go to Settings > Devices and make sure that your devices have verified each other. When you open the room the next time and both sessions are in the foreground, the keys will be transmitted automatically.\n\nDo you not want to loose the keys when logging out or switching devices? Make sure that you have enabled the chat backup in the settings.';

  @override
  String get newGroup => 'New chat';

  @override
  String get newSpace => 'New space';

  @override
  String get enterSpace => 'Enter space';

  @override
  String get enterRoom => 'Enter room';

  @override
  String get allSpaces => 'All spaces';

  @override
  String numChats(Object number) {
    return '$number chats';
  }

  @override
  String get hideUnimportantStateEvents => 'Hide unimportant state events';

  @override
  String get doNotShowAgain => 'Do not show again';

  @override
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return 'Empty chat (was $oldDisplayName)';
  }

  @override
  String get newSpaceDescription => 'Spaces allows you to consolidate your chats and build private or public communities.';

  @override
  String get encryptThisChat => 'Encrypt this chat';

  @override
  String get endToEndEncryption => 'End to end encryption';

  @override
  String get disableEncryptionWarning => 'For security reasons you can not disable encryption in a chat, where it has been enabled before.';

  @override
  String get sorryThatsNotPossible => 'Sorry... that is not possible';

  @override
  String get deviceKeys => 'Device keys:';

  @override
  String get letsStart => 'Let\'s start';

  @override
  String get enterInviteLinkOrMatrixId => 'Enter invite link or Matrix ID...';

  @override
  String get reopenChat => 'Reopen chat';

  @override
  String get noBackupWarning => 'Warning! Without enabling chat backup, you will lose access to your encrypted messages. It is highly recommended to enable the chat backup first before logging out.';

  @override
  String get noOtherDevicesFound => 'No other devices found';

  @override
  String get fileIsTooBigForServer => 'The server reports that the file is too large to be sent.';

  @override
  String get onlineStatus => 'online';

  @override
  String onlineMinAgo(Object min) {
    return 'online ${min}m ago';
  }

  @override
  String onlineHourAgo(Object hour) {
    return 'online ${hour}h ago';
  }

  @override
  String onlineDayAgo(Object day) {
    return 'online ${day}d ago';
  }

  @override
  String get noMessageHereYet => 'No message here yet...';

  @override
  String get sendMessageGuide => 'Send a message or tap on the greeting below.';

  @override
  String get youCreatedGroupChat => 'You created a Group chat';

  @override
  String get chatCanHave => 'Chat can have:';

  @override
  String get upTo100000Members => 'Up to 100.000 members';

  @override
  String get persistentChatHistory => 'Persistent Chat history';

  @override
  String get addMember => 'Add members';

  @override
  String get profile => 'Profile';

  @override
  String get channels => 'Channels';

  @override
  String get chatMessage => 'New message';

  @override
  String welcomeToTwake(Object user) {
    return 'Welcome to Twake, $user';
  }

  @override
  String get startNewChatMessage => 'It\'s nice having a chat with your friends and collaborating with your teams.\nLet\'s start a chat, create a group chat, or join an existing one.';

  @override
  String get statusDot => '⬤';

  @override
  String get active => 'Activated';

  @override
  String get inactive => 'Not-activated';

  @override
  String get newGroupChat => 'New Group Chat';

  @override
  String get twakeUsers => 'Twake users';

  @override
  String get expand => 'Expand';

  @override
  String get shrink => 'Shrink';

  @override
  String noResultForKeyword(Object keyword) {
    return 'No results for \"$keyword\"';
  }

  @override
  String get searchResultNotFound1 => '• Make sure there are no typos in your search.\n';

  @override
  String get searchResultNotFound2 => '• You might not have the user in your address book.\n';

  @override
  String get searchResultNotFound3 => '• Check the contact access permission, the user might be in your contact list.\n';

  @override
  String get searchResultNotFound4 => '• If the reason is not listed above, ';

  @override
  String get searchResultNotFound5 => 'seek helps.';

  @override
  String get more => 'More';

  @override
  String get whoWouldYouLikeToAdd => 'Who would you like to add?';

  @override
  String get addAPhoto => 'Add a photo';

  @override
  String maxImageSize(Object max) {
    return 'Maximum file size: ${max}MB';
  }

  @override
  String get owner => 'Owner';

  @override
  String participantsCount(Object count) {
    return 'Participants ($count)';
  }

  @override
  String get back => 'Back';

  @override
  String get wrongServerName => 'Wrong server name';

  @override
  String get serverNameWrongExplain => 'Server address was sent to you by company admin. Check the invitation email.';

  @override
  String get contacts => 'Contacts';

  @override
  String get searchForContacts => 'Search for contacts';

  @override
  String get soonThereHaveContacts => 'Soon there will be contacts';

  @override
  String get searchSuggestion => 'For now, search by typing a person’s name or public server address';

  @override
  String get loadingContacts => 'Loading contacts...';

  @override
  String get recentChat => 'RECENT CHAT';

  @override
  String get selectChat => 'Select chat';

  @override
  String get search => 'ابحث';

  @override
  String get forwardTo => 'Forward to...';

  @override
  String get noConnection => 'No connection';

  @override
  String photoSelectedCounter(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count photos',
      one: '1 photo',
    );
    return '$_temp0 selected';
  }

  @override
  String get addACaption => 'Add a caption...';

  @override
  String get noImagesFound => 'No Images found';

  @override
  String get captionForImagesIsNotSupportYet => 'Caption for images is not support yet.';

  @override
  String get tapToAllowAccessToYourGallery => 'Tap to allow gallery access';

  @override
  String get tapToAllowAccessToYourCamera => 'You can enable camera access in the Settings app to make video calls in';

  @override
  String get twake => 'Twake Chat';

  @override
  String get permissionAccess => 'Permission access';

  @override
  String get allow => 'Allow';

  @override
  String get explainStoragePermission => 'Twake need access to your storage to preview file';

  @override
  String get explainGoToStorageSetting => 'Twake need access to your storage to preview file, go to settings to allow this permission';

  @override
  String get gallery => 'Gallery';

  @override
  String get documents => 'Documents';

  @override
  String get location => 'Location';

  @override
  String get contact => 'Contact';

  @override
  String get file => 'File';

  @override
  String get recent => 'Recent';

  @override
  String get chatsAndContacts => 'Chats and Contacts';

  @override
  String get externalContactTitle => 'Invite new users';

  @override
  String get externalContactMessage => 'Some of the users you want to add are not in your contacts. Do you want to invite them?';

  @override
  String get clear => 'Clear';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get changeChatAvatar => 'Change the Chat avatar';

  @override
  String get roomAvatarMaxFileSize => 'The avatar size is too large';

  @override
  String roomAvatarMaxFileSizeLong(Object max) {
    return 'The avatar size must be less than $max';
  }

  @override
  String get continueProcess => 'Continue';

  @override
  String get youAreUploadingPhotosDoYouWantToCancelOrContinue => 'Image upload error! Do you still want to continue creating group chat?';

  @override
  String hasCreatedAGroupChat(Object groupName) {
    return 'created a group chat “$groupName”';
  }

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get adminPanel => 'Admin Panel';

  @override
  String get acceptInvite => 'Yes please, join';

  @override
  String get askToInvite => ' wants you to join this chat. What do you say?';

  @override
  String get select => 'Select';

  @override
  String get copyMessageText => 'Copy';

  @override
  String get pinThisChat => 'Pin this chat';

  @override
  String get unpinThisChat => 'Unpin this chat';

  @override
  String get add => 'Add';

  @override
  String get addMembers => 'Add members';

  @override
  String get chatInfo => 'Chat info';

  @override
  String get mute => 'Mute';

  @override
  String membersInfo(Object count) {
    return 'Members ($count)';
  }

  @override
  String get members => 'Members';

  @override
  String get media => 'Media';

  @override
  String get files => 'Files';

  @override
  String get links => 'Links';

  @override
  String get downloads => 'Downloads';

  @override
  String get downloadImageSuccess => 'Image saved to Pictures';

  @override
  String get downloadImageError => 'Error saving image';

  @override
  String downloadFileInWeb(Object directory) {
    return 'File saved to $directory';
  }

  @override
  String get notInAChatYet => 'You\'re not in a chat yet';

  @override
  String get blankChatTitle => 'Choose a chat or hit #EditIcon# to make one.';

  @override
  String get errorPageTitle => 'Something\'s not right';

  @override
  String get errorPageDescription => 'That page doesn\'t exist.';

  @override
  String get errorPageButton => 'Back to chat';

  @override
  String get playVideo => 'Play';

  @override
  String get done => 'Done';

  @override
  String get markThisChatAsRead => 'Mark this chat as read';

  @override
  String get markThisChatAsUnRead => 'Mark this chat as unread';

  @override
  String get muteThisChat => 'Mute this chat';

  @override
  String get unmuteThisChat => 'Unmute this chat';

  @override
  String get read => 'Read';

  @override
  String get unread => 'Unread';

  @override
  String get unmute => 'Unmute';

  @override
  String get privacyAndSecurity => 'Privacy & Security';

  @override
  String get notificationAndSounds => 'Notification & Sounds';

  @override
  String get appLanguage => 'App Language';

  @override
  String get chatFolders => 'Chat Folders';

  @override
  String get displayName => 'Display Name';

  @override
  String get bio => 'Bio (optional)';

  @override
  String get matrixId => 'Matrix ID';

  @override
  String get email => 'Email';

  @override
  String get company => 'Company';

  @override
  String get basicInfo => 'BASIC INFO';

  @override
  String get editProfileDescriptions => 'Update your profile with a new name, picture and a short introduction.';

  @override
  String get workIdentitiesInfo => 'WORK IDENTITIES INFO';

  @override
  String get editWorkIdentitiesDescriptions => 'Edit your work identity settings such as Matrix ID, email or company name.';

  @override
  String get copiedMatrixIdToClipboard => 'Copied Matrix ID to clipboard.';

  @override
  String get changeProfileAvatar => 'Change profile avatar';

  @override
  String countPinChat(Object countPinChat) {
    return 'PINNED CHATS ($countPinChat)';
  }

  @override
  String countAllChat(Object countAllChat) {
    return 'ALL CHATS ($countAllChat)';
  }

  @override
  String get thisMessageHasBeenEncrypted => 'This message has been encrypted';

  @override
  String get roomCreationFailed => 'Room creation failed';

  @override
  String get errorGettingPdf => 'Error getting PDF';

  @override
  String get errorPreviewingFile => 'Error previewing file';

  @override
  String get paste => 'Paste';

  @override
  String get cut => 'Cut';

  @override
  String get pasteImageFailed => 'Paste image failed';

  @override
  String get copyImageFailed => 'Copy image failed';

  @override
  String get fileFormatNotSupported => 'File format not supported';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get encryptionMessage => 'This feature protects your messages from being read by others, but also prevents them from being backed up on our servers. You can\'t disable this later.';

  @override
  String get encryptionWarning => 'You might lose your messages if you access Twake app on the another device.';

  @override
  String get selectedUsers => 'Selected users';

  @override
  String get clearAllSelected => 'Clear all selected';

  @override
  String get newDirectMessage => 'New direct message';

  @override
  String get contactInfo => 'Contact info';

  @override
  String countPinnedMessage(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pinned Message #$count',
      zero: 'Pinned Message',
    );
    return '$_temp0';
  }

  @override
  String pinnedMessages(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pinned Messages',
      one: '1 Pinned Message',
    );
    return '$_temp0';
  }

  @override
  String get copyImageSuccess => 'Image copied to clipboard';

  @override
  String get youNeedToAcceptTheInvitation => 'You need to accept the invitation to start chatting';

  @override
  String get hasInvitedYouToAChat => ' has invited you to a chat. Accept or reject and delete the conversation?';

  @override
  String get declineTheInvitation => 'Decline the invitation?';

  @override
  String get doYouReallyWantToDeclineThisInvitation => 'Do you really want to decline this invitation and remove the chat? You won\'t be able to undo this action.';

  @override
  String get declineAndRemove => 'Decline and remove';

  @override
  String get notNow => 'Not now';

  @override
  String get contactsWarningBannerTitle => 'To ensure you can connect with all your friends, please allow Twake to access your device’s contacts. We appreciate your understanding.';

  @override
  String contactsCount(Object count) {
    return 'Contacts ($count)';
  }

  @override
  String linagoraContactsCount(Object count) {
    return 'Linagora contacts ($count)';
  }

  @override
  String fetchingPhonebookContacts(Object progress) {
    return 'Fetching contacts from device...($progress% completed)';
  }

  @override
  String get languageEnglish => 'English';

  @override
  String get languageVietnamese => 'Vietnamese';

  @override
  String get languageFrench => 'French';

  @override
  String get languageRussian => 'Russian';

  @override
  String get settingsLanguageDescription => 'Set the language you use on Twake Chat';

  @override
  String sendImages(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Send $count images',
      one: 'Send 1 image',
    );
    return '$_temp0';
  }

  @override
  String get enterCaption => 'Add a caption...';

  @override
  String get failToSend => 'Failed to send, please try again';

  @override
  String get showLess => 'Show Less';

  @override
  String get showMore => 'Show More';

  @override
  String get unreadMessages => 'Unread messages';

  @override
  String get groupInformation => 'Group information';

  @override
  String get linkInvite => 'Link invite';

  @override
  String get noDescription => 'No description';

  @override
  String get description => 'Description';

  @override
  String get groupName => 'Group name';

  @override
  String get descriptionHelper => 'You can provide an optional description for your group.';

  @override
  String get groupNameCannotBeEmpty => 'Group name cannot be empty';

  @override
  String get unpinAllMessages => 'Unpin all messages';

  @override
  String get pinnedMessagesTooltip => 'Pinned messages';

  @override
  String get jumpToMessage => 'Jump to message';

  @override
  String get failedToUnpin => 'Failed to unpin message';

  @override
  String get welcomeTo => 'Welcome to';

  @override
  String get descriptionWelcomeTo => 'an open source messenger based on\nthe matrix protocol, which allows you to\nencrypt your data';

  @override
  String get startMessaging => 'Start messaging';

  @override
  String get signIn => 'Sign in';

  @override
  String get createTwakeId => 'Create Twake ID';

  @override
  String get useYourCompanyServer => 'Use your company server';

  @override
  String get descriptionTwakeId => 'An open source messenger encrypt\nyour data with matrix protocol';

  @override
  String countFilesSendPerDialog(Object count) {
    return 'The maximum files when sending is $count.';
  }

  @override
  String sendFiles(Object count) {
    return 'Send $count files';
  }

  @override
  String get addAnotherAccount => 'Add another account';

  @override
  String get accountSettings => 'Account settings';

  @override
  String get failedToSendFiles => 'Failed to send files';

  @override
  String get noResults => 'No Results';

  @override
  String get isSingleAccountOnHomeserver => 'We do not yet support multiple accounts on a single homeserver';

  @override
  String messageSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Messages',
      one: '1 Message',
      zero: 'No Messages',
    );
    return '$_temp0 selected';
  }

  @override
  String draftChatHookPhrase(String user) {
    return 'Hi $user! I would like to chat with you.';
  }

  @override
  String get twakeChatUser => 'Twake Chat User';

  @override
  String get sharedMediaAndLinks => 'Shared media and links';

  @override
  String get errorSendingFiles => 'Some files aren’t sendable due to size, format restrictions, or unexpected errors. They’ll be omitted.';

  @override
  String get removeFileBeforeSend => 'Remove error files before send';

  @override
  String get unselect => 'Unselect';

  @override
  String get searchContacts => 'Search contacts';

  @override
  String get tapToAllowAccessToYourMicrophone => 'You can enable microphone access in the Settings app to make voice in';

  @override
  String get showInChat => 'Show in chat';

  @override
  String get phone => 'Phone';

  @override
  String get viewProfile => 'View profile';

  @override
  String get profileInfo => 'Profile informations';

  @override
  String get saveToDownloads => 'Save to Downloads';

  @override
  String get saveToGallery => 'Save to Gallery';

  @override
  String get fileSavedToDownloads => 'File saved to Downloads';

  @override
  String get saveFileToDownloadsError => 'Failed to save file to Downloads';

  @override
  String explainPermissionToDownloadFiles(String appName) {
    return 'To continue, please allow $appName to access storage permission. This permission is essential for saving file to Downloads folder.';
  }

  @override
  String get explainPermissionToAccessContacts => 'Twake Chat DOES NOT collect your contacts. Twake Chat sends only contact hashes to the Twake Chat servers to understand who from your friends already joined Twake Chat, enabling connection with them. Your contacts ARE NOT synchronized with our server.';

  @override
  String get explainPermissionToAccessMedias => 'Twake Chat does not synchronize data between your device and our servers. We only store media that you have sent to the chat room. All media files sent to chat are encrypted and stored securely. Go to Settings > Permissions and activate the Storage: Photos and Videos permission. You can also deny access to your media library at any time.';

  @override
  String get explainPermissionToAccessPhotos => 'Twake Chat does not synchronize data between your device and our servers. We only store media that you have sent to the chat room. All media files sent to chat are encrypted and stored securely. Go to Settings > Permissions and activate the Storage: Photos permission. You can also deny access to your media library at any time.';

  @override
  String get explainPermissionToAccessVideos => 'Twake Chat does not synchronize data between your device and our servers. We only store media that you have sent to the chat room. All media files sent to chat are encrypted and stored securely. Go to Settings > Permissions and activate the Storage: Videos permission. You can also deny access to your media library at any time.';

  @override
  String get downloading => 'Downloading';

  @override
  String get settingUpYourTwake => 'Setting up your Twake\nIt could take a while';

  @override
  String get performingAutomaticalLogin => 'Performing automatical login  via SSO';

  @override
  String get backingUpYourMessage => 'Preparing server environment for backing up your messages';

  @override
  String get recoveringYourEncryptedChats => 'Recovering your encrypted chats';

  @override
  String get configureDataEncryption => 'Configure data encryption';

  @override
  String get configurationNotFound => 'The configuration data not found';

  @override
  String get fileSavedToGallery => 'File saved to Gallery';

  @override
  String get saveFileToGalleryError => 'Failed to save file to Gallery';

  @override
  String explainPermissionToGallery(String appName) {
    return 'To continue, please allow $appName to access photo permission. This permission is essential for saving file to gallery.';
  }

  @override
  String get tokenNotFound => 'The login token not found';

  @override
  String get dangerZone => 'Danger zone';

  @override
  String get leaveGroupSubtitle => 'This group will still remain after you left';

  @override
  String get leaveChatFailed => 'Failed to leave the chat';

  @override
  String get invalidLoginToken => 'Invalid login token';

  @override
  String get copiedPublicKeyToClipboard => 'Copied public key to clipboard.';

  @override
  String get removeFromGroup => 'Remove from group';

  @override
  String get removeUser => 'Remove User';

  @override
  String removeReason(Object user) {
    return 'Remove $user from the group';
  }

  @override
  String get switchAccounts => 'Switch accounts';

  @override
  String get selectAccount => 'Select account';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get byContinuingYourAgreeingToOur => 'By continuing, you\'re agreeing to our';

  @override
  String get youDontHaveAnyContactsYet => 'You dont have any contacts yet.';

  @override
  String get loading => 'Loading...';

  @override
  String get errorDialogTitle => 'Oops, something went wrong';

  @override
  String get shootingTips => 'Tap to take photo.';

  @override
  String get shootingWithRecordingTips => 'Tap to take photo. Long press to record video.';

  @override
  String get shootingOnlyRecordingTips => 'Long press to record video.';

  @override
  String get shootingTapRecordingTips => 'Tap to record video.';

  @override
  String get loadFailed => 'Load failed';

  @override
  String get saving => 'Saving...';

  @override
  String get sActionManuallyFocusHint => 'Manually focus';

  @override
  String get sActionPreviewHint => 'Preview';

  @override
  String get sActionRecordHint => 'Record';

  @override
  String get sActionShootHint => 'Take picture';

  @override
  String get sActionShootingButtonTooltip => 'Shooting button';

  @override
  String get sActionStopRecordingHint => 'Stop recording';

  @override
  String sCameraLensDirectionLabel(Object value) {
    return 'Camera lens direction: $value';
  }

  @override
  String sCameraPreviewLabel(Object value) {
    return 'Camera preview: $value';
  }

  @override
  String sFlashModeLabel(Object mode) {
    return 'Flash mode: $mode';
  }

  @override
  String sSwitchCameraLensDirectionLabel(Object value) {
    return 'Switch to the $value camera';
  }

  @override
  String get photo => 'Photo';

  @override
  String get video => 'Video';

  @override
  String get message => 'Message';

  @override
  String fileTooBig(int maxSize) {
    return 'The selected file is too large. Please choose a file smaller than $maxSize MB.';
  }

  @override
  String get enable_notifications => 'Enable notifications';

  @override
  String get disable_notifications => 'Disable notifications';

  @override
  String get logoutDialogWarning => 'You will lose access to encrypted messages. We recommend that you enable chat backups before logging out';

  @override
  String get copyNumber => 'Copy number';

  @override
  String get callViaCarrier => 'Call via Carrier';

  @override
  String get scanQrCodeToJoin => 'Installation of the mobile application will allow you to contact people from your phone\'s address book, your chats will be synchronised between devices';

  @override
  String get thisFieldCannotBeBlank => 'This field cannot be blank';

  @override
  String get phoneNumberCopiedToClipboard => 'Phone number copied to clipboard';

  @override
  String get deleteAccountMessage => 'Groups chats that you have created will remain unadministered unless you have given another user administrator rights. Users will still have a history of messages with you. Deleting the account won\'t help.';

  @override
  String get deleteLater => 'Delete later';

  @override
  String get areYouSureYouWantToDeleteAccount => 'Are you sure you want to delete account?';

  @override
  String get textCopiedToClipboard => 'Text copied to clipboard';

  @override
  String get selectAnEmailOrPhoneYouWantSendTheInvitationTo => 'Select an email or phone you want send the invitation to';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get sendInvitation => 'Send invitation';

  @override
  String get verifyWithAnotherDevice => 'Verify with another device';

  @override
  String get contactLookupFailed => 'Contact lookup failed.';

  @override
  String get invitationHasBeenSuccessfullySent => 'Invitation has been successfully sent!';

  @override
  String get failedToSendInvitation => 'Failed to send invitation.';

  @override
  String get invalidPhoneNumber => 'Invalid phone number';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get shareInvitationLink => 'Share invitation link';

  @override
  String get failedToGenerateInvitationLink => 'Failed to generate invitation link.';

  @override
  String get youAlreadySentAnInvitationToThisContact => 'You already sent an invitation to this contact';

  @override
  String get selectedEmailWillReceiveAnInvitationLinkAndInstructions => 'Selected email will receive an invitation link and instructions.';

  @override
  String get selectedNumberWillGetAnSMSWithAnInvitationLinkAndInstructions => 'Selected number will get an SMS with an invitation link and instructions.';

  @override
  String get reaction => 'Reaction';

  @override
  String get noChatPermissionMessage => 'You do not have permission to send messages in this chat.';

  @override
  String get administration => 'Administration';

  @override
  String get yourDataIsEncryptedForSecurity => 'Your data is encrypted for security';

  @override
  String get failedToDeleteMessage => 'Failed to delete message.';

  @override
  String get noDeletePermissionMessage => 'You don\'t have permission to delete this message.';

  @override
  String get edited => 'edited';

  @override
  String get editMessage => 'Edit message';

  @override
  String get assignRoles => 'Assign roles';

  @override
  String get permissions => 'Permissions';

  @override
  String adminsOfTheGroup(Object number) {
    return 'ADMINS OF THE GROUP ($number)';
  }

  @override
  String get addAdminsOrModerators => 'Add Admins/moderators';

  @override
  String get member => 'Member';

  @override
  String get guest => 'Guest';

  @override
  String get exceptions => 'Exceptions';

  @override
  String get readOnly => 'Read only';

  @override
  String readOnlyCount(Object number) {
    return 'READ ONLY ($number)';
  }

  @override
  String get removedUsers => 'Removed Users';

  @override
  String bannedUsersCount(Object number) {
    return 'BANNED USERS ($number)';
  }

  @override
  String get downgradeToReadOnly => 'Downgrade to read only';

  @override
  String memberOfTheGroup(Object number) {
    return 'MEMBERS OF THE GROUP ($number)';
  }

  @override
  String get selectRole => 'Select role';

  @override
  String get canReadMessages => 'Can read messages';

  @override
  String get canWriteMessagesSendReacts => 'Can write messages, send reacts...';

  @override
  String get canRemoveUsersDeleteMessages => 'Can remove users, delete messages...';

  @override
  String get canAccessAllFeaturesAndSettings => 'Can access all features and settings';

  @override
  String get invitePeopleToTheRoom => 'Invite people to the room';

  @override
  String get sendReactions => 'Send reactions';

  @override
  String get deleteMessagesSentByMe => 'Delete messages sent by me';

  @override
  String get notifyEveryoneUsingRoom => 'Notify everyone using @room';

  @override
  String get joinCall => 'Join Call';

  @override
  String get removeMembers => 'Remove a members';

  @override
  String get deleteMessagesSentByOthers => 'Delete messages sent by others';

  @override
  String get pinMessageForEveryone => 'Pin a message (for everyone)';

  @override
  String get startCall => 'Start Call';

  @override
  String get changeGroupName => 'Change group name';

  @override
  String get changeGroupDescription => 'Change group description';

  @override
  String get changeGroupAvatar => 'Change group avatar';

  @override
  String get changeGroupHistoryVisibility => 'Change group history visibility';

  @override
  String get searchGroupMembers => 'Search group members';

  @override
  String get permissionErrorChangeRole => 'You don’t have the rights to change roles. Please reach out to your admin for help';

  @override
  String get demoteAdminsModerators => 'Demote Admins/Moderators';

  @override
  String get deleteMessageConfirmationTitle => 'Are you sure you want to delete this message?';

  @override
  String get permissionErrorBanUser => 'You don’t have the rights to ban users. Please reach out to your admin for help';

  @override
  String get removeMember => 'Remove member';

  @override
  String get removeMemberSelectionError => 'You cannot delete a member with a role equal to or greater than yours.';

  @override
  String get downgrade => 'Downgrade';

  @override
  String get deletedMessage => 'Deleted message';

  @override
  String get unban => 'Unban';

  @override
  String get permissionErrorUnbanUser => 'You don’t have the rights to unban users. Please reach out to your admin for help';

  @override
  String get transferOwnership => 'Transfer ownership';

  @override
  String confirmTransferOwnership(Object name) {
    return 'Are you sure you want to transfer ownership of this group to $name?';
  }

  @override
  String get transferOwnershipDescription => 'This user will gain full control over the group and you will no longer have total management rights. This action is irreversible.';

  @override
  String get confirmTransfer => 'Confirm Transfer';

  @override
  String get unblockUser => 'Unblock User';

  @override
  String get blockUser => 'Block User';

  @override
  String get permissionErrorUnblockUser => 'You don’t have the rights to unblock user.';

  @override
  String get permissionErrorBlockUser => 'You don’t have the rights to block user.';

  @override
  String userIsNotAValidMxid(Object mxid) {
    return '$mxid is not a valid Matrix ID';
  }

  @override
  String userNotFoundInIgnoreList(Object mxid) {
    return '$mxid is not found in your ignore list';
  }

  @override
  String get blockedUsers => 'Blocked Users';

  @override
  String unblockUsername(Object name) {
    return 'Unblock $name';
  }

  @override
  String get unblock => 'Unblock';

  @override
  String get unblockDescriptionDialog => 'This person will be able to message you and see when you\'re online. They won\'t be notified that you unblocked them.';

  @override
  String get report => 'Report';

  @override
  String get reportDesc => 'What’s the issue with this message?';

  @override
  String get sendReport => 'Send Report';

  @override
  String get addComment => 'Add comment';

  @override
  String get spam => 'Spam';

  @override
  String get violence => 'Violence';

  @override
  String get childAbuse => 'Child abuse';

  @override
  String get pornography => 'Pornography';

  @override
  String get copyrightInfringement => 'Copyright infringement';

  @override
  String get terrorism => 'Terrorism';

  @override
  String get other => 'Other';

  @override
  String get enableRightAndLeftMessageAlignment => 'Enable right/left message alignment';

  @override
  String get holdToRecordAudio => 'Hold to record audio.';

  @override
  String get explainPermissionToAccessMicrophone => 'To send voice messages, allow Twake Chat to access the microphone.';

  @override
  String get allowMicrophoneAccess => 'Allow microphone access';

  @override
  String get later => 'Later';

  @override
  String get couldNotPlayAudioFile => 'Could not play audio file';

  @override
  String get slideToCancel => 'Slide to cancel';

  @override
  String get recordingInProgress => 'Recording in progress';

  @override
  String get pleaseFinishOrStopTheRecording => 'Please finish or stop the recording before performing other actions.';

  @override
  String get audioMessageFailedToSend => 'Audio message failed to send.';

  @override
  String get dediMainTitle => 'DNA Algorithm';

  @override
  String get dediMainDescription => 'Dedi uses an encryption system that belongs only to Dedi, messages cannot be read outside of Dedi';

  @override
  String get phoneAuthTitle => 'Phone Verification';

  @override
  String get phoneAuthDescription => 'Enter your phone number, we will send you a verification code';

  @override
  String get otpVerificationTitle => 'Verification Code';

  @override
  String get otpVerificationDescription => 'Enter the 6-digit code sent to your phone';

  @override
  String get splashTagline => 'Turkey\'s messaging platform';

  @override
  String get loginTitle => 'Sign In';

  @override
  String get welcomeMessage => 'Welcome!';

  @override
  String get loginDescription => 'Just a few steps left for secure and unlimited messaging';

  @override
  String get phoneNumberLabel => 'Phone Number *';

  @override
  String get getVerificationCode => 'Get Verification Code';

  @override
  String get enterVerificationCode => 'Enter Verification Code';

  @override
  String otpSentMessage(Object phone) {
    return 'We sent a verification code to $phone.';
  }

  @override
  String get otpProblemQuestion => 'Having trouble receiving the code?';

  @override
  String get resendCode => 'Resend';

  @override
  String get pleaseEnterValidPhone => 'Please enter a valid phone number';

  @override
  String get otpRequestFailed => 'Failed to send code. Please try again.';

  @override
  String get pleaseEnterCompleteCode => 'Please enter the complete 6-digit code';

  @override
  String get invalidOtp => 'Verification code is incorrect. Please check.';

  @override
  String get connectionError => 'Connection error. Please check your internet connection.';

  @override
  String get expiredOtp => 'Verification code has expired. Request a new code.';

  @override
  String get verificationFailed => 'Connection error. Please try again.';

  @override
  String get codeSentAgain => 'Verification code sent again';

  @override
  String get codeSendFailed => 'Failed to send code. Please try again.';

  @override
  String get loginSuccess => '✅ Login successful!';

  @override
  String get seconds => 's';
}
