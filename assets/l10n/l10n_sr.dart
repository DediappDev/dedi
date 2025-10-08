// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class L10nSr extends L10n {
  L10nSr([String locale = 'sr']) : super(locale);

  @override
  String get passwordsDoNotMatch => 'Passwords do not match!';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email address.';

  @override
  String get repeatPassword => 'Repeat password';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Please choose at least $min characters.';
  }

  @override
  String get about => 'О програму';

  @override
  String get updateAvailable => 'Twake Chat update available';

  @override
  String get updateNow => 'Start update in background';

  @override
  String get accept => 'Прихвати';

  @override
  String acceptedTheInvitation(Object username) {
    return '$username прихвата позивницу';
  }

  @override
  String get account => 'Налог';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '$username укључи шифровање с краја на крај';
  }

  @override
  String get addEmail => 'Додај е-адресу';

  @override
  String get confirmMatrixId =>
      'Please confirm your Matrix ID in order to delete your account.';

  @override
  String supposedMxid(Object mxid) {
    return 'This should be $mxid';
  }

  @override
  String get addGroupDescription => 'Додај опис групе';

  @override
  String get addToSpace => 'Add to space';

  @override
  String get admin => 'Админ';

  @override
  String get alias => 'алијас';

  @override
  String get all => 'Сви';

  @override
  String get allChats => 'All chats';

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
    return '$senderName одговори на позив';
  }

  @override
  String get anyoneCanJoin => 'свако може да се придружи';

  @override
  String get appLock => 'Закључавање апликације';

  @override
  String get archive => 'Архива';

  @override
  String get archivedRoom => 'Архивирана соба';

  @override
  String get areGuestsAllowedToJoin => 'Да ли је гостима дозвољен приступ';

  @override
  String get areYouSure => 'Сигурни сте?';

  @override
  String get areYouSureYouWantToLogout => 'Заиста желите да се одјавите?';

  @override
  String get askSSSSSign =>
      'Да бисте могли да пријавите другу особу, унесите своју безбедносну фразу или кључ опоравка.';

  @override
  String askVerificationRequest(Object username) {
    return 'Прихватате ли захтев за верификацију од корисника $username?';
  }

  @override
  String get autoplayImages =>
      'Automatically play animated stickers and emotes';

  @override
  String badServerLoginTypesException(Object serverVersions,
      Object supportedVersions, Object suportedVersions) {
    return 'Домаћи сервер подржава начине пријаве:\n$serverVersions\nали ова апликација подржава само:\n$supportedVersions';
  }

  @override
  String get sendOnEnter => 'Send on enter';

  @override
  String badServerVersionsException(Object serverVersions,
      Object supportedVersions, Object serverVerions, Object suportedVersions) {
    return 'Домаћи сервер подржава верзије:\n$serverVersions\nали ова апликација подржава само $supportedVersions';
  }

  @override
  String get banFromChat => 'Забрани у ћаскању';

  @override
  String get banned => 'Забрањен';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username забрани корисника $targetName';
  }

  @override
  String get blockDevice => 'Блокирај уређај';

  @override
  String get blocked => 'Блокиран';

  @override
  String get botMessages => 'Поруке Бота';

  @override
  String get bubbleSize => 'Bubble size';

  @override
  String get cancel => 'Откажи';

  @override
  String cantOpenUri(Object uri) {
    return 'Can\'t open the URI $uri';
  }

  @override
  String get changeDeviceName => 'Промени назив уређаја';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username промени аватар ћаскања';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username промени опис ћаскања у: „$description“';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username промени назив ћаскања у: „$chatname“';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username измени дозволе ћаскања';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username промени приказно име на: „$displayname“';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username измени правила за приступ гостију';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username измени правила за приступ гостију на: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username измени видљивост историје';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username измени видљивост историје на: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username измени правила приступања';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username измени правила приступања на: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username измени свој аватар';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username измени алијас собе';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username измени везу позивнице';
  }

  @override
  String get changePassword => 'Измени лозинку';

  @override
  String get changeTheHomeserver => 'Промени домаћи сервер';

  @override
  String get changeTheme => 'Измените изглед';

  @override
  String get changeTheNameOfTheGroup => 'Измени назив групе';

  @override
  String get changeWallpaper => 'Измени тапет';

  @override
  String get changeYourAvatar => 'Измените свој аватар';

  @override
  String get channelCorruptedDecryptError => 'Шифровање је покварено';

  @override
  String get chat => 'Ћаскање';

  @override
  String get yourUserId => 'Your user ID:';

  @override
  String get yourChatBackupHasBeenSetUp => 'Your chat backup has been set up.';

  @override
  String get chatBackup => 'Копија ћаскања';

  @override
  String get chatBackupDescription =>
      'Ваша резервна копија ћаскања је обезбеђена кључем. Немојте да га изгубите.';

  @override
  String get chatDetails => 'Детаљи ћаскања';

  @override
  String get chatHasBeenAddedToThisSpace => 'Chat has been added to this space';

  @override
  String get chats => 'Ћаскања';

  @override
  String get chooseAStrongPassword => 'Изаберите јаку лозинку';

  @override
  String get chooseAUsername => 'Изаберите корисничко име';

  @override
  String get clearArchive => 'Очисти архиву';

  @override
  String get close => 'Затвори';

  @override
  String get commandHint_markasdm => 'Mark as direct chat';

  @override
  String get commandHint_markasgroup => 'Mark as chat';

  @override
  String get commandHint_ban => 'Блокирај задатог корисника за ову собу';

  @override
  String get commandHint_clearcache => 'Clear cache';

  @override
  String get commandHint_create =>
      'Create an empty chat\nUse --no-encryption to disable encryption';

  @override
  String get commandHint_discardsession => 'Discard session';

  @override
  String get commandHint_dm =>
      'Start a direct chat\nUse --no-encryption to disable encryption';

  @override
  String get commandHint_html => 'Шаљи ХТМЛ обликован текст';

  @override
  String get commandHint_invite => 'Позови задатог корисника у собу';

  @override
  String get commandHint_join => 'Придружи се наведеној соби';

  @override
  String get commandHint_kick => 'Уклони задатог корисника из собе';

  @override
  String get commandHint_leave => 'Напусти ову собу';

  @override
  String get commandHint_me => 'Опишите себе';

  @override
  String get commandHint_myroomavatar =>
      'Set your picture for this chat (by mxc-uri)';

  @override
  String get commandHint_myroomnick => 'Поставља ваш надимак за ову собу';

  @override
  String get commandHint_op =>
      'Подеси ниво задатог корисника (подразумевано: 50)';

  @override
  String get commandHint_plain => 'Шаљи неформатиран текст';

  @override
  String get commandHint_react => 'Шаљи одговор као реакцију';

  @override
  String get commandHint_send => 'Пошаљи текст';

  @override
  String get commandHint_unban => 'Скини забрану задатом кориснику за ову собу';

  @override
  String get commandInvalid => 'Command invalid';

  @override
  String commandMissing(Object command) {
    return '$command is not a command.';
  }

  @override
  String get compareEmojiMatch =>
      'Упоредите и проверите да су емоџији идентични као на другом уређају:';

  @override
  String get compareNumbersMatch =>
      'Упоредите и проверите да су следећи бројеви идентични као на другом уређају:';

  @override
  String get configureChat => 'Подешавање ћаскања';

  @override
  String get confirm => 'Потврди';

  @override
  String get connect => 'Повежи се';

  @override
  String get contactHasBeenInvitedToTheGroup => 'Особа је позвана у групу';

  @override
  String get containsDisplayName => 'Садржи приказно име';

  @override
  String get containsUserName => 'Садржи корисничко име';

  @override
  String get contentHasBeenReported =>
      'Садржај је пријављен администраторима сервера';

  @override
  String get copiedToClipboard => 'Копирано у клипборд';

  @override
  String get copy => 'Копирај';

  @override
  String get copyToClipboard => 'Копирај у клипборд';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Не могу да дешифрујем поруку: $error';
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
  String get create => 'Направи';

  @override
  String createdTheChat(Object username) {
    return '$username направи ћаскање';
  }

  @override
  String get createNewGroup => 'Направи нову групу';

  @override
  String get createNewSpace => 'New space';

  @override
  String get crossSigningEnabled => 'Међу-потписивање укључено';

  @override
  String get currentlyActive => 'Тренутно активно';

  @override
  String get darkTheme => 'тамни';

  @override
  String dateAndTimeOfDay(Object date, Object timeOfDay) {
    return '$date, $timeOfDay';
  }

  @override
  String dateWithoutYear(Object month, Object day) {
    return '$day $month';
  }

  @override
  String dateWithYear(Object year, Object month, Object day) {
    return '$day $month $year';
  }

  @override
  String get deactivateAccountWarning =>
      'Ово ће деактивирати ваш кориснички налог. Не може се повратити! Сигурни сте?';

  @override
  String get defaultPermissionLevel => 'Подразумевани ниво приступа';

  @override
  String get delete => 'Обриши';

  @override
  String get deleteAccount => 'Обриши налог';

  @override
  String get deleteMessage => 'Брисање поруке';

  @override
  String get deny => 'Одбиј';

  @override
  String get device => 'Уређај';

  @override
  String get deviceId => 'ИД уређаја';

  @override
  String get devices => 'Уређаји';

  @override
  String get directChats => 'Директна ћаскања';

  @override
  String get discover => 'Истражи';

  @override
  String get displaynameHasBeenChanged => 'Име за приказ је измењено';

  @override
  String get download => 'Download';

  @override
  String get edit => 'Уреди';

  @override
  String get editBlockedServers => 'Уреди блокиране сервере';

  @override
  String get editChatPermissions => 'Уредите дозволе ћаскања';

  @override
  String get editDisplayname => 'Уреди име за приказ';

  @override
  String get editRoomAliases => 'Уреди алијасе собе';

  @override
  String get editRoomAvatar => 'Уређује аватар собе';

  @override
  String get emoteExists => 'Емоти већ постоји!';

  @override
  String get emoteInvalid => 'Неисправна скраћеница за емоти!';

  @override
  String get emotePacks => 'Пакети емотија за собу';

  @override
  String get emoteSettings => 'Поставке емотија';

  @override
  String get emoteShortcode => 'скраћеница';

  @override
  String get emoteWarnNeedToPick =>
      'Морате да изаберете скраћеницу и слику за емоти!';

  @override
  String get emptyChat => 'празно ћаскање';

  @override
  String get enableEmotesGlobally => 'Глобално укључи пакет емотија';

  @override
  String get enableEncryption => 'Укључује шифровање';

  @override
  String get enableEncryptionWarning =>
      'Шифровање више нећете моћи да искључите. Сигурни сте?';

  @override
  String get encrypted => 'Шифровано';

  @override
  String get encryption => 'Шифровање';

  @override
  String get encryptionNotEnabled => 'Шифровање није укључено';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName заврши позив';
  }

  @override
  String get enterGroupName => 'Enter chat name';

  @override
  String get enterAnEmailAddress => 'Унесите адресу е-поште';

  @override
  String get enterASpacepName => 'Enter a space name';

  @override
  String get homeserver => 'Homeserver';

  @override
  String get enterYourHomeserver => 'Унесите свој домаћи сервер';

  @override
  String errorObtainingLocation(Object error) {
    return 'Error obtaining location: $error';
  }

  @override
  String get everythingReady => 'Све је спремно!';

  @override
  String get extremeOffensive => 'Екстремно увредљив';

  @override
  String get fileName => 'Назив фајла';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Величина фонта';

  @override
  String get forward => 'Напред';

  @override
  String get friday => 'петак';

  @override
  String get fromJoining => 'од приступања';

  @override
  String get fromTheInvitation => 'од позивања';

  @override
  String get goToTheNewRoom => 'Иди у нову собу';

  @override
  String get group => 'Група';

  @override
  String get groupDescription => 'Опис групе';

  @override
  String get groupDescriptionHasBeenChanged => 'Опис групе измењен';

  @override
  String get groupIsPublic => 'Група је јавна';

  @override
  String get groups => 'Групе';

  @override
  String groupWith(Object displayname) {
    return 'Група са корисником $displayname';
  }

  @override
  String get guestsAreForbidden => 'гости су забрањени';

  @override
  String get guestsCanJoin => 'гости могу приступити';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username поништи позивницу за корисника $targetName';
  }

  @override
  String get help => 'Помоћ';

  @override
  String get hideRedactedEvents => 'Сакриј редиговане догађаје';

  @override
  String get hideUnknownEvents => 'Сакриј непознате догађаје';

  @override
  String get howOffensiveIsThisContent => 'Колико је увредљив овај садржај?';

  @override
  String get id => 'ИД';

  @override
  String get identity => 'Идентитет';

  @override
  String get ignore => 'Игнориши';

  @override
  String get ignoredUsers => 'Игнорисани корисници';

  @override
  String get ignoreListDescription =>
      'Можете игнорисати кориснике који вас нервирају. Нећете примати никакве поруке нити позивнице од корисника са ваше листе за игнорисање.';

  @override
  String get ignoreUsername => 'Игнориши корисника';

  @override
  String get iHaveClickedOnLink => 'Кликнуо сам на везу';

  @override
  String get incorrectPassphraseOrKey => 'Неисправна фраза или кључ опоравка';

  @override
  String get inoffensive => 'Није увредљив';

  @override
  String get inviteContact => 'Позивање особа';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Позови особу у групу $groupName';
  }

  @override
  String get invited => 'Позван';

  @override
  String invitedUser(Object username, Object targetName) {
    return '$username позва корисника $targetName';
  }

  @override
  String get invitedUsersOnly => 'само позвани корисници';

  @override
  String get inviteForMe => 'Позивнице за мене';

  @override
  String inviteText(Object username, Object link) {
    return '$username вас позива у FluffyChat. \n1. Инсталирајте FluffyChat: https://fluffychat.im \n2. Региструјте се или пријавите \n3. Отворите везу позивнице: $link';
  }

  @override
  String get isTyping => 'куца';

  @override
  String joinedTheChat(Object username) {
    return '$username се придружи ћаскању';
  }

  @override
  String get joinRoom => 'Придружи се соби';

  @override
  String get keysCached => 'Кључеви су кеширани';

  @override
  String kicked(Object username, Object targetName) {
    return '$username избаци корисника $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '$username избаци и забрани корисника $targetName';
  }

  @override
  String get kickFromChat => 'Избаци из ћаскања';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Последња активност: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'одавно није на мрежи';

  @override
  String get leave => 'Напусти';

  @override
  String get leftTheChat => 'Напусти ћаскање';

  @override
  String get license => 'Лиценца';

  @override
  String get lightTheme => 'светли';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Учитај још $count учесника';
  }

  @override
  String get dehydrate => 'Export session and wipe device';

  @override
  String get dehydrateWarning =>
      'This action cannot be undone. Ensure you safely store the backup file.';

  @override
  String get dehydrateShare =>
      'This is your private FluffyChat export. Ensure you don\'t lose it and keep it private.';

  @override
  String get dehydrateTor => 'TOR Users: Export session';

  @override
  String get dehydrateTorLong =>
      'For TOR users, it is recommended to export the session before closing the window.';

  @override
  String get hydrateTor => 'TOR Users: Import session export';

  @override
  String get hydrateTorLong =>
      'Did you export your session last time on TOR? Quickly import it and continue chatting.';

  @override
  String get hydrate => 'Restore from backup file';

  @override
  String get loadingPleaseWait => 'Учитавам… Сачекајте.';

  @override
  String get loadingStatus => 'Loading status...';

  @override
  String get loadMore => 'Учитај још…';

  @override
  String get locationDisabledNotice =>
      'Location services are disabled. Please enable them to be able to share your location.';

  @override
  String get locationPermissionDeniedNotice =>
      'Location permission denied. Please grant them to be able to share your location.';

  @override
  String get login => 'Пријава';

  @override
  String logInTo(Object homeserver) {
    return 'Пријава на $homeserver';
  }

  @override
  String get loginWithOneClick => 'Sign in with one click';

  @override
  String get logout => 'Одјава';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Проверите да је идентификатор исправан';

  @override
  String get memberChanges => 'Измене чланова';

  @override
  String get mention => 'Спомени';

  @override
  String get messages => 'Поруке';

  @override
  String get messageWillBeRemovedWarning =>
      'Поруке ће бити уклоњене за све учеснике';

  @override
  String get noSearchResult => 'No matching search results.';

  @override
  String get moderator => 'Модератор';

  @override
  String get monday => 'понедељак';

  @override
  String get muteChat => 'Ућуткај ћаскање';

  @override
  String get needPantalaimonWarning =>
      'За сада, потребан је Пантелејмон (Pantalaimon) да бисте користили шифровање с краја на крај.';

  @override
  String get newChat => 'Ново ћаскање';

  @override
  String get newMessageInTwake => 'You have 1 encrypted message';

  @override
  String get newVerificationRequest => 'Нови захтев за верификацију!';

  @override
  String get noMoreResult => 'No more result!';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Следеће';

  @override
  String get no => 'Не';

  @override
  String get noConnectionToTheServer => 'Нема везе са сервером';

  @override
  String get noEmotesFound => 'Нема емотија. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Шифровање се може активирати након што соба престане да буде јавно доступна.';

  @override
  String get noGoogleServicesWarning =>
      'Чини се да немате Гугл услуге на телефону. То је добра одлука за вашу приватност! Да би се протурале нотификације у FluffyChat, препоручујемо коришћење https://microg.org/ или https://unifiedpush.org/';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 is no matrix server, use $server2 instead?';
  }

  @override
  String get shareYourInviteLink => 'Share your invite link';

  @override
  String get typeInInviteLinkManually => 'Type in invite link manually...';

  @override
  String get scanQrCode => 'Scan QR code';

  @override
  String get none => 'Ништа';

  @override
  String get noPasswordRecoveryDescription =>
      'Још нисте одредили начин за опоравак лозинке.';

  @override
  String get noPermission => 'Нема дозвола';

  @override
  String get noRoomsFound => 'Нисам нашао собе…';

  @override
  String get notifications => 'Обавештења';

  @override
  String numUsersTyping(Object count) {
    return '$count корисника куца';
  }

  @override
  String get obtainingLocation => 'Obtaining location…';

  @override
  String get offensive => 'Увредљив';

  @override
  String get offline => 'Ван везе';

  @override
  String get aWhileAgo => 'a while ago';

  @override
  String get ok => 'у реду';

  @override
  String get online => 'На вези';

  @override
  String get onlineKeyBackupEnabled => 'Резерва кључева на мрежи је укључена';

  @override
  String get cannotEnableKeyBackup =>
      'Cannot enable Chat Backup. Please Go to Settings to try it again.';

  @override
  String get cannotUploadKey => 'Cannot store Key Backup.';

  @override
  String get oopsPushError =>
      'Нажалост, дошло је до грешке при подешавању дотурања обавештења.';

  @override
  String get oopsSomethingWentWrong => 'Нешто је пошло наопако…';

  @override
  String get openAppToReadMessages => 'Отворите апликацију да прочитате поруке';

  @override
  String get openCamera => 'Отвори камеру';

  @override
  String get openVideoCamera => 'Open camera for a video';

  @override
  String get oneClientLoggedOut => 'One of your clients has been logged out';

  @override
  String get addAccount => 'Add account';

  @override
  String get editBundlesForAccount => 'Edit bundles for this account';

  @override
  String get addToBundle => 'Add to bundle';

  @override
  String get removeFromBundle => 'Remove from this bundle';

  @override
  String get bundleName => 'Bundle name';

  @override
  String get enableMultiAccounts =>
      '(BETA) Enable multi accounts on this device';

  @override
  String get openInMaps => 'Open in maps';

  @override
  String get link => 'Link';

  @override
  String get serverRequiresEmail =>
      'This server needs to validate your email address for registration.';

  @override
  String get optionalGroupName => '(опционо) назив групе';

  @override
  String get or => 'или';

  @override
  String get participant => 'Учесник';

  @override
  String get passphraseOrKey => 'фраза или кључ опоравка';

  @override
  String get password => 'Лозинка';

  @override
  String get passwordForgotten => 'Заборављена лозинка';

  @override
  String get passwordHasBeenChanged => 'Лозинка је промењена';

  @override
  String get passwordRecovery => 'Опоравак лозинке';

  @override
  String get people => 'Људи';

  @override
  String get pickImage => 'Избор слике';

  @override
  String get pin => 'Закачи';

  @override
  String play(Object fileName) {
    return 'Пусти $fileName';
  }

  @override
  String get pleaseChoose => 'Изаберите';

  @override
  String get pleaseChooseAPasscode => 'Изаберите код за пролаз';

  @override
  String get pleaseChooseAUsername => 'Изаберите корисничко име';

  @override
  String get pleaseClickOnLink =>
      'Кликните на везу у примљеној е-пошти па наставите.';

  @override
  String get pleaseEnter4Digits =>
      'Унесите 4 цифре или оставите празно да не закључавате апликацију.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'Унесите ИД са Матрикса.';

  @override
  String get pleaseEnterRecoveryKey => 'Please enter your recovery key:';

  @override
  String get pleaseEnterYourPassword => 'Унесите своју лозинку';

  @override
  String get pleaseEnterYourPin => 'Унесите свој пин';

  @override
  String get pleaseEnterYourUsername => 'Унесите своје корисничко име';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Испратите упутства на веб сајту и тапните на „Следеће“.';

  @override
  String get privacy => 'Приватност';

  @override
  String get publicRooms => 'Јавне собе';

  @override
  String get pushRules => 'Правила протурања';

  @override
  String get reason => 'Разлог';

  @override
  String get recording => 'Снимам';

  @override
  String redactedAnEvent(Object username) {
    return '$username редигова догађај';
  }

  @override
  String get redactMessage => 'Редигуј поруку';

  @override
  String get register => 'Регистрација';

  @override
  String get reject => 'Одбиј';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username одби позивницу';
  }

  @override
  String get rejoin => 'Поново се придружи';

  @override
  String get remove => 'Уклони';

  @override
  String get removeAllOtherDevices => 'Уклони све остале уређаје';

  @override
  String removedBy(Object username) {
    return 'Уклонио корисник $username';
  }

  @override
  String get removeDevice => 'Уклони уређај';

  @override
  String get unbanFromChat => 'Уклони изгнанство';

  @override
  String get removeYourAvatar => 'Уклоните свој аватар';

  @override
  String get renderRichContent => 'Приказуј обогаћен садржај поруке';

  @override
  String get replaceRoomWithNewerVersion => 'Замени собу новијом верзијом';

  @override
  String get reply => 'Одговори';

  @override
  String get reportMessage => 'Пријави поруку';

  @override
  String get requestPermission => 'Затражи дозволу';

  @override
  String get roomHasBeenUpgraded => 'Соба је надограђена';

  @override
  String get roomVersion => 'Верзија собе';

  @override
  String get saturday => 'субота';

  @override
  String get saveFile => 'Save file';

  @override
  String get searchForPeopleAndChannels => 'Search for people and channels';

  @override
  String get security => 'Безбедност';

  @override
  String get recoveryKey => 'Recovery key';

  @override
  String get recoveryKeyLost => 'Recovery key lost?';

  @override
  String seenByUser(Object username) {
    return '$username прегледа';
  }

  @override
  String seenByUserAndCountOthers(Object username, num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$username прегледа и $count осталих',
    );
    return '$_temp0';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Прегледали $username и $username2';
  }

  @override
  String get send => 'Пошаљи';

  @override
  String get sendAMessage => 'Пошаљи поруку';

  @override
  String get sendAsText => 'Send as text';

  @override
  String get sendAudio => 'Пошаљи аудио';

  @override
  String get sendFile => 'Пошаљи фајл';

  @override
  String get sendImage => 'Пошаљи слику';

  @override
  String get sendMessages => 'Слање порука';

  @override
  String get sendMessage => 'Send message';

  @override
  String get sendOriginal => 'Пошаљи оригинал';

  @override
  String get sendSticker => 'Send sticker';

  @override
  String get sendVideo => 'Пошаљи видео';

  @override
  String sentAFile(Object username) {
    return '$username посла фајл';
  }

  @override
  String sentAnAudio(Object username) {
    return '$username посла аудио';
  }

  @override
  String sentAPicture(Object username) {
    return '$username посла слику';
  }

  @override
  String sentASticker(Object username) {
    return '$username посла налепницу';
  }

  @override
  String sentAVideo(Object username) {
    return '$username посла видео';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName посла податке о позиву';
  }

  @override
  String get separateChatTypes => 'Separate Direct Chats and Groups';

  @override
  String get setAsCanonicalAlias => 'Постави као главни алијас';

  @override
  String get setCustomEmotes => 'постави посебне емотије';

  @override
  String get setGroupDescription => 'Постави опис групе';

  @override
  String get setInvitationLink => 'Поставља везу позивнице';

  @override
  String get setPermissionsLevel => 'Одреди ниво дозволе';

  @override
  String get setStatus => 'Постави статус';

  @override
  String get settings => 'Поставке';

  @override
  String get share => 'Подели';

  @override
  String sharedTheLocation(Object username) {
    return '$username подели локацију';
  }

  @override
  String get shareLocation => 'Share location';

  @override
  String get showDirectChatsInSpaces => 'Show related Direct Chats in Spaces';

  @override
  String get showPassword => 'Прикажи лозинку';

  @override
  String get signUp => 'Регистрација';

  @override
  String get singlesignon => 'Јединствена пријава';

  @override
  String get skip => 'Прескочи';

  @override
  String get invite => 'Invite';

  @override
  String get sourceCode => 'Изворни код';

  @override
  String get spaceIsPublic => 'Space is public';

  @override
  String get spaceName => 'Space name';

  @override
  String startedACall(Object senderName) {
    return '$senderName започе позив';
  }

  @override
  String get startFirstChat => 'Start your first chat';

  @override
  String get status => 'Стање';

  @override
  String get statusExampleMessage => 'Како сте данас?';

  @override
  String get submit => 'Пошаљи';

  @override
  String get sunday => 'недеља';

  @override
  String get synchronizingPleaseWait => 'Synchronizing… Please wait.';

  @override
  String get systemTheme => 'системски';

  @override
  String get theyDontMatch => 'Не поклапају се';

  @override
  String get theyMatch => 'Поклапају се';

  @override
  String get thisRoomHasBeenArchived => 'Ова соба је архивирана.';

  @override
  String get thursday => 'четвртак';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Мењај омиљеност';

  @override
  String get toggleMuted => 'Мењај ућутканост';

  @override
  String get toggleUnread => 'Означи не/прочитано';

  @override
  String get tooManyRequestsWarning => 'Превише упита. Покушајте касније!';

  @override
  String get transferFromAnotherDevice => 'Пренос са другог уређаја';

  @override
  String get tryToSendAgain => 'Покушај слање поново';

  @override
  String get tuesday => 'уторак';

  @override
  String get unavailable => 'Недоступно';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username одблокира корисника $targetName';
  }

  @override
  String get unblockDevice => 'Одблокирај уређај';

  @override
  String get unknownDevice => 'Непознат уређај';

  @override
  String get unknownEncryptionAlgorithm => 'Непознат алгоритам шифровања';

  @override
  String unknownEvent(Object type, Object tipo) {
    return 'Непознат догађај „$type“';
  }

  @override
  String get unmuteChat => 'Врати обавештења';

  @override
  String get unpin => 'Откачи';

  @override
  String unreadChats(num unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: 'непрочитаних ћаскања: $unreadCount',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username и $count корисника куцају';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username и $username2 куцају';
  }

  @override
  String userIsTyping(Object username) {
    return '$username куца';
  }

  @override
  String userLeftTheChat(Object username) {
    return '$username напусти ћаскање';
  }

  @override
  String get username => 'Корисничко име';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username посла $type догађај';
  }

  @override
  String get unverified => 'Unverified';

  @override
  String get verified => 'Оверен';

  @override
  String get verify => 'Верификуј';

  @override
  String get verifyStart => 'Покрени верификацију';

  @override
  String get verifySuccess => 'Успешно сте верификовали!';

  @override
  String get verifyTitle => 'Верификујем други налог';

  @override
  String get videoCall => 'Видео позив';

  @override
  String get visibilityOfTheChatHistory => 'Одреди видљивост историје';

  @override
  String get visibleForAllParticipants => 'видљиво свим учесницима';

  @override
  String get visibleForEveryone => 'видљиво свима';

  @override
  String get voiceMessage => 'Гласовна порука';

  @override
  String get waitingPartnerAcceptRequest =>
      'Чекам да саговорник прихвати захтев…';

  @override
  String get waitingPartnerEmoji => 'Чекам да саговорник прихвати емоџије…';

  @override
  String get waitingPartnerNumbers => 'Чекам да саговорник прихвати бројеве…';

  @override
  String get wallpaper => 'Тапета';

  @override
  String get warning => 'Упозорење!';

  @override
  String get wednesday => 'среда';

  @override
  String get weSentYouAnEmail => 'Послали смо вам е-пошту';

  @override
  String get whoCanPerformWhichAction => 'ко може шта да ради';

  @override
  String get whoIsAllowedToJoinThisGroup => 'Ко може да се придружи групи';

  @override
  String get whyDoYouWantToReportThis => 'Зашто желите ово да пријавите?';

  @override
  String get wipeChatBackup =>
      'Да обришем резервну копију како би направио нови сигурносни кључ?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Са овим адресама можете опоравити своју лозинку.';

  @override
  String get writeAMessage => 'напишите поруку…';

  @override
  String get yes => 'Да';

  @override
  String get you => 'Ви';

  @override
  String get youAreInvitedToThisChat => 'Позвани сте у ово ћаскање';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Више не учествујете у овом ћаскању';

  @override
  String get youCannotInviteYourself => 'Не можете позвати себе';

  @override
  String get youHaveBeenBannedFromThisChat => 'Забрањено вам је ово ћаскање';

  @override
  String get yourPublicKey => 'Ваш јавни кључ';

  @override
  String get messageInfo => 'Message info';

  @override
  String get time => 'Time';

  @override
  String get messageType => 'Message Type';

  @override
  String get sender => 'Sender';

  @override
  String get openGallery => 'Open gallery';

  @override
  String get removeFromSpace => 'Remove from space';

  @override
  String get addToSpaceDescription => 'Select a space to add this chat to it.';

  @override
  String get start => 'Start';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'To unlock your old messages, please enter your recovery key that has been generated in a previous session. Your recovery key is NOT your password.';

  @override
  String get addToStory => 'Add to story';

  @override
  String get publish => 'Publish';

  @override
  String get whoCanSeeMyStories => 'Who can see my stories?';

  @override
  String get unsubscribeStories => 'Unsubscribe stories';

  @override
  String get thisUserHasNotPostedAnythingYet =>
      'This user has not posted anything in their story yet';

  @override
  String get yourStory => 'Your story';

  @override
  String get replyHasBeenSent => 'Reply has been sent';

  @override
  String videoWithSize(Object size) {
    return 'Video ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return 'Story from $date: \n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'Please note that people can see and contact each other in your story.';

  @override
  String get whatIsGoingOn => 'What is going on?';

  @override
  String get addDescription => 'Add description';

  @override
  String get storyPrivacyWarning =>
      'Please note that people can see and contact each other in your story. Your stories will be visible for 24 hours but there is no guarantee that they will be deleted from all devices and servers.';

  @override
  String get iUnderstand => 'I understand';

  @override
  String get openChat => 'Open Chat';

  @override
  String get markAsRead => 'Mark as read';

  @override
  String get reportUser => 'Report user';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get matrixWidgets => 'Matrix Widgets';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender reacted with $reaction';
  }

  @override
  String get pinChat => 'Pin';

  @override
  String get confirmEventUnpin =>
      'Are you sure to permanently unpin the message?';

  @override
  String get emojis => 'Emojis';

  @override
  String get placeCall => 'Place call';

  @override
  String get voiceCall => 'Voice call';

  @override
  String get unsupportedAndroidVersion => 'Unsupported Android version';

  @override
  String get unsupportedAndroidVersionLong =>
      'This feature requires a newer Android version. Please check for updates or Lineage OS support.';

  @override
  String get videoCallsBetaWarning =>
      'Please note that video calls are currently in beta. They might not work as expected or work at all on all platforms.';

  @override
  String get experimentalVideoCalls => 'Experimental video calls';

  @override
  String get emailOrUsername => 'Email or username';

  @override
  String get indexedDbErrorTitle => 'Private mode issues';

  @override
  String get indexedDbErrorLong =>
      'The message storage is unfortunately not enabled in private mode by default.\nPlease visit\n - about:config\n - set dom.indexedDB.privateBrowsing.enabled to true\nOtherwise, it is not possible to run FluffyChat.';

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
  String get noEmailWarning =>
      'Please enter a valid email address. Otherwise you won\'t be able to reset your password. If you don\'t want to, tap again on the button to continue.';

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
  String get storeInSecureStorageDescription =>
      'Store the recovery key in the secure storage of this device.';

  @override
  String get saveKeyManuallyDescription =>
      'Save this key manually by triggering the system share dialog or clipboard.';

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
  String get foregroundServiceRunning =>
      'This notification appears when the foreground service is running.';

  @override
  String get screenSharingTitle => 'screen sharing';

  @override
  String get screenSharingDetail => 'You are sharing your screen in FuffyChat';

  @override
  String get callingPermissions => 'Calling permissions';

  @override
  String get callingAccount => 'Calling account';

  @override
  String get callingAccountDetails =>
      'Allows FluffyChat to use the native android dialer app.';

  @override
  String get appearOnTop => 'Appear on top';

  @override
  String get appearOnTopDetails =>
      'Allows the app to appear on top (not needed if you already have Fluffychat setup as a calling account)';

  @override
  String get otherCallingPermissions =>
      'Microphone, camera and other FluffyChat permissions';

  @override
  String get whyIsThisMessageEncrypted => 'Why is this message unreadable?';

  @override
  String get noKeyForThisMessage =>
      'This can happen if the message was sent before you have signed in to your account at this device.\n\nIt is also possible that the sender has blocked your device or something went wrong with the internet connection.\n\nAre you able to read the message on another session? Then you can transfer the message from it! Go to Settings > Devices and make sure that your devices have verified each other. When you open the room the next time and both sessions are in the foreground, the keys will be transmitted automatically.\n\nDo you not want to loose the keys when logging out or switching devices? Make sure that you have enabled the chat backup in the settings.';

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
  String get newSpaceDescription =>
      'Spaces allows you to consolidate your chats and build private or public communities.';

  @override
  String get encryptThisChat => 'Encrypt this chat';

  @override
  String get endToEndEncryption => 'End to end encryption';

  @override
  String get disableEncryptionWarning =>
      'For security reasons you can not disable encryption in a chat, where it has been enabled before.';

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
  String get noBackupWarning =>
      'Warning! Without enabling chat backup, you will lose access to your encrypted messages. It is highly recommended to enable the chat backup first before logging out.';

  @override
  String get noOtherDevicesFound => 'No other devices found';

  @override
  String get fileIsTooBigForServer =>
      'The server reports that the file is too large to be sent.';

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
  String get startNewChatMessage =>
      'It\'s nice having a chat with your friends and collaborating with your teams.\nLet\'s start a chat, create a group chat, or join an existing one.';

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
  String get searchResultNotFound1 =>
      '• Make sure there are no typos in your search.\n';

  @override
  String get searchResultNotFound2 =>
      '• You might not have the user in your address book.\n';

  @override
  String get searchResultNotFound3 =>
      '• Check the contact access permission, the user might be in your contact list.\n';

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
  String get serverNameWrongExplain =>
      'Server address was sent to you by company admin. Check the invitation email.';

  @override
  String get contacts => 'Contacts';

  @override
  String get searchForContacts => 'Search for contacts';

  @override
  String get soonThereHaveContacts => 'Soon there will be contacts';

  @override
  String get searchSuggestion =>
      'For now, search by typing a person’s name or public server address';

  @override
  String get loadingContacts => 'Loading contacts...';

  @override
  String get recentChat => 'RECENT CHAT';

  @override
  String get selectChat => 'Select chat';

  @override
  String get search => 'Претражи';

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
  String get captionForImagesIsNotSupportYet =>
      'Caption for images is not support yet.';

  @override
  String get tapToAllowAccessToYourGallery => 'Tap to allow gallery access';

  @override
  String get tapToAllowAccessToYourCamera =>
      'You can enable camera access in the Settings app to make video calls in';

  @override
  String get twake => 'Twake Chat';

  @override
  String get permissionAccess => 'Permission access';

  @override
  String get allow => 'Allow';

  @override
  String get explainStoragePermission =>
      'Twake need access to your storage to preview file';

  @override
  String get explainGoToStorageSetting =>
      'Twake need access to your storage to preview file, go to settings to allow this permission';

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
  String get externalContactMessage =>
      'Some of the users you want to add are not in your contacts. Do you want to invite them?';

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
  String get youAreUploadingPhotosDoYouWantToCancelOrContinue =>
      'Image upload error! Do you still want to continue creating group chat?';

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
  String get editProfileDescriptions =>
      'Update your profile with a new name, picture and a short introduction.';

  @override
  String get workIdentitiesInfo => 'WORK IDENTITIES INFO';

  @override
  String get editWorkIdentitiesDescriptions =>
      'Edit your work identity settings such as Matrix ID, email or company name.';

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
  String get encryptionMessage =>
      'This feature protects your messages from being read by others, but also prevents them from being backed up on our servers. You can\'t disable this later.';

  @override
  String get encryptionWarning =>
      'You might lose your messages if you access Twake app on the another device.';

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
  String get youNeedToAcceptTheInvitation =>
      'You need to accept the invitation to start chatting';

  @override
  String get hasInvitedYouToAChat =>
      ' has invited you to a chat. Accept or reject and delete the conversation?';

  @override
  String get declineTheInvitation => 'Decline the invitation?';

  @override
  String get doYouReallyWantToDeclineThisInvitation =>
      'Do you really want to decline this invitation and remove the chat? You won\'t be able to undo this action.';

  @override
  String get declineAndRemove => 'Decline and remove';

  @override
  String get notNow => 'Not now';

  @override
  String get contactsWarningBannerTitle =>
      'To ensure you can connect with all your friends, please allow Twake to access your device’s contacts. We appreciate your understanding.';

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
  String get settingsLanguageDescription =>
      'Set the language you use on Twake Chat';

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
  String get descriptionHelper =>
      'You can provide an optional description for your group.';

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
  String get descriptionWelcomeTo =>
      'an open source messenger based on\nthe matrix protocol, which allows you to\nencrypt your data';

  @override
  String get startMessaging => 'Start messaging';

  @override
  String get signIn => 'Sign in';

  @override
  String get createTwakeId => 'Create Twake ID';

  @override
  String get useYourCompanyServer => 'Use your company server';

  @override
  String get descriptionTwakeId =>
      'An open source messenger encrypt\nyour data with matrix protocol';

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
  String get isSingleAccountOnHomeserver =>
      'We do not yet support multiple accounts on a single homeserver';

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
  String get errorSendingFiles =>
      'Some files aren’t sendable due to size, format restrictions, or unexpected errors. They’ll be omitted.';

  @override
  String get removeFileBeforeSend => 'Remove error files before send';

  @override
  String get unselect => 'Unselect';

  @override
  String get searchContacts => 'Search contacts';

  @override
  String get tapToAllowAccessToYourMicrophone =>
      'You can enable microphone access in the Settings app to make voice in';

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
  String get explainPermissionToAccessContacts =>
      'Twake Chat DOES NOT collect your contacts. Twake Chat sends only contact hashes to the Twake Chat servers to understand who from your friends already joined Twake Chat, enabling connection with them. Your contacts ARE NOT synchronized with our server.';

  @override
  String get explainPermissionToAccessMedias =>
      'Twake Chat does not synchronize data between your device and our servers. We only store media that you have sent to the chat room. All media files sent to chat are encrypted and stored securely. Go to Settings > Permissions and activate the Storage: Photos and Videos permission. You can also deny access to your media library at any time.';

  @override
  String get explainPermissionToAccessPhotos =>
      'Twake Chat does not synchronize data between your device and our servers. We only store media that you have sent to the chat room. All media files sent to chat are encrypted and stored securely. Go to Settings > Permissions and activate the Storage: Photos permission. You can also deny access to your media library at any time.';

  @override
  String get explainPermissionToAccessVideos =>
      'Twake Chat does not synchronize data between your device and our servers. We only store media that you have sent to the chat room. All media files sent to chat are encrypted and stored securely. Go to Settings > Permissions and activate the Storage: Videos permission. You can also deny access to your media library at any time.';

  @override
  String get downloading => 'Downloading';

  @override
  String get settingUpYourTwake =>
      'Setting up your Twake\nIt could take a while';

  @override
  String get performingAutomaticalLogin =>
      'Performing automatical login  via SSO';

  @override
  String get backingUpYourMessage =>
      'Preparing server environment for backing up your messages';

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
  String get leaveGroupSubtitle =>
      'This group will still remain after you left';

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
  String get byContinuingYourAgreeingToOur =>
      'By continuing, you\'re agreeing to our';

  @override
  String get youDontHaveAnyContactsYet => 'You dont have any contacts yet.';

  @override
  String get loading => 'Loading...';

  @override
  String get errorDialogTitle => 'Oops, something went wrong';

  @override
  String get shootingTips => 'Tap to take photo.';

  @override
  String get shootingWithRecordingTips =>
      'Tap to take photo. Long press to record video.';

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
  String get logoutDialogWarning =>
      'You will lose access to encrypted messages. We recommend that you enable chat backups before logging out';

  @override
  String get copyNumber => 'Copy number';

  @override
  String get callViaCarrier => 'Call via Carrier';

  @override
  String get scanQrCodeToJoin =>
      'Installation of the mobile application will allow you to contact people from your phone\'s address book, your chats will be synchronised between devices';

  @override
  String get thisFieldCannotBeBlank => 'This field cannot be blank';

  @override
  String get phoneNumberCopiedToClipboard => 'Phone number copied to clipboard';

  @override
  String get deleteAccountMessage =>
      'Groups chats that you have created will remain unadministered unless you have given another user administrator rights. Users will still have a history of messages with you. Deleting the account won\'t help.';

  @override
  String get deleteLater => 'Delete later';

  @override
  String get areYouSureYouWantToDeleteAccount =>
      'Are you sure you want to delete account?';

  @override
  String get textCopiedToClipboard => 'Text copied to clipboard';

  @override
  String get selectAnEmailOrPhoneYouWantSendTheInvitationTo =>
      'Select an email or phone you want send the invitation to';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get sendInvitation => 'Send invitation';

  @override
  String get verifyWithAnotherDevice => 'Verify with another device';

  @override
  String get contactLookupFailed => 'Contact lookup failed.';

  @override
  String get invitationHasBeenSuccessfullySent =>
      'Invitation has been successfully sent!';

  @override
  String get failedToSendInvitation => 'Failed to send invitation.';

  @override
  String get invalidPhoneNumber => 'Invalid phone number';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get shareInvitationLink => 'Share invitation link';

  @override
  String get failedToGenerateInvitationLink =>
      'Failed to generate invitation link.';

  @override
  String get youAlreadySentAnInvitationToThisContact =>
      'You already sent an invitation to this contact';

  @override
  String get selectedEmailWillReceiveAnInvitationLinkAndInstructions =>
      'Selected email will receive an invitation link and instructions.';

  @override
  String get selectedNumberWillGetAnSMSWithAnInvitationLinkAndInstructions =>
      'Selected number will get an SMS with an invitation link and instructions.';

  @override
  String get reaction => 'Reaction';

  @override
  String get noChatPermissionMessage =>
      'You do not have permission to send messages in this chat.';

  @override
  String get administration => 'Administration';

  @override
  String get yourDataIsEncryptedForSecurity =>
      'Your data is encrypted for security';

  @override
  String get failedToDeleteMessage => 'Failed to delete message.';

  @override
  String get noDeletePermissionMessage =>
      'You don\'t have permission to delete this message.';

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
  String get canRemoveUsersDeleteMessages =>
      'Can remove users, delete messages...';

  @override
  String get canAccessAllFeaturesAndSettings =>
      'Can access all features and settings';

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
  String get permissionErrorChangeRole =>
      'You don’t have the rights to change roles. Please reach out to your admin for help';

  @override
  String get demoteAdminsModerators => 'Demote Admins/Moderators';

  @override
  String get deleteMessageConfirmationTitle =>
      'Are you sure you want to delete this message?';

  @override
  String get permissionErrorBanUser =>
      'You don’t have the rights to ban users. Please reach out to your admin for help';

  @override
  String get removeMember => 'Remove member';

  @override
  String get removeMemberSelectionError =>
      'You cannot delete a member with a role equal to or greater than yours.';

  @override
  String get downgrade => 'Downgrade';

  @override
  String get deletedMessage => 'Deleted message';

  @override
  String get unban => 'Unban';

  @override
  String get permissionErrorUnbanUser =>
      'You don’t have the rights to unban users. Please reach out to your admin for help';

  @override
  String get transferOwnership => 'Transfer ownership';

  @override
  String confirmTransferOwnership(Object name) {
    return 'Are you sure you want to transfer ownership of this group to $name?';
  }

  @override
  String get transferOwnershipDescription =>
      'This user will gain full control over the group and you will no longer have total management rights. This action is irreversible.';

  @override
  String get confirmTransfer => 'Confirm Transfer';

  @override
  String get unblockUser => 'Unblock User';

  @override
  String get blockUser => 'Block User';

  @override
  String get permissionErrorUnblockUser =>
      'You don’t have the rights to unblock user.';

  @override
  String get permissionErrorBlockUser =>
      'You don’t have the rights to block user.';

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
  String get unblockDescriptionDialog =>
      'This person will be able to message you and see when you\'re online. They won\'t be notified that you unblocked them.';

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
  String get enableRightAndLeftMessageAlignment =>
      'Enable right/left message alignment';

  @override
  String get holdToRecordAudio => 'Hold to record audio.';

  @override
  String get explainPermissionToAccessMicrophone =>
      'To send voice messages, allow Twake Chat to access the microphone.';

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
  String get pleaseFinishOrStopTheRecording =>
      'Please finish or stop the recording before performing other actions.';

  @override
  String get audioMessageFailedToSend => 'Audio message failed to send.';
}
