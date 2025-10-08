// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Irish (`ga`).
class L10nGa extends L10n {
  L10nGa([String locale = 'ga']) : super(locale);

  @override
  String get passwordsDoNotMatch => 'Níl na pasfhocail chéanna!';

  @override
  String get pleaseEnterValidEmail => 'Iontráil ríomhphost bailí le do thoil.';

  @override
  String get repeatPassword => 'Scríobh an pasfhocal arís';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Roghnaigh $min carachtar ar a laghad.';
  }

  @override
  String get about => 'Faoi';

  @override
  String get updateAvailable => 'Nuashonrú comhrá Twake ar fáil';

  @override
  String get updateNow => 'Tosaigh nuashonrú sa chúlra';

  @override
  String get accept => 'Glac';

  @override
  String acceptedTheInvitation(Object username) {
    return 'Ghlac $username leis an cuireadh';
  }

  @override
  String get account => 'Cuntas';

  @override
  String activatedEndToEndEncryption(Object username) {
    return 'Thosaigh $username an criptiú ó dheireadh go deireadh';
  }

  @override
  String get addEmail => 'Cuir ríomhphost leis';

  @override
  String get confirmMatrixId =>
      'Deimhnigh d\'aitheantas Maitríse chun do chuntas a scriosadh.';

  @override
  String supposedMxid(Object mxid) {
    return 'Ba chóir go mbeadh sé seo $mxid';
  }

  @override
  String get addGroupDescription => 'Cuir tuairisc grúpa';

  @override
  String get addToSpace => 'Cuir go spás';

  @override
  String get admin => 'Riarthóir';

  @override
  String get alias => 'ailias';

  @override
  String get all => 'Gach';

  @override
  String get allChats => 'Gach comhrá';

  @override
  String get commandHint_googly => 'Seol roinnt súile googly';

  @override
  String get commandHint_cuddle => 'Seol cuddle';

  @override
  String get commandHint_hug => 'Seol barróg';

  @override
  String googlyEyesContent(Object senderName) {
    return 'Seolann $senderName súile googly chugat';
  }

  @override
  String cuddleContent(Object senderName) {
    return '$senderName cuddles tú';
  }

  @override
  String hugContent(Object senderName) {
    return 'Tugann $senderName barróg duit';
  }

  @override
  String answeredTheCall(Object senderName, Object sendername) {
    return 'D\'fhreagair $senderName an glao';
  }

  @override
  String get anyoneCanJoin => 'Is féidir le aon duine dul isteach';

  @override
  String get appLock => 'Bac aip';

  @override
  String get archive => 'Cartlann';

  @override
  String get archivedRoom => 'Seomra cartlainne';

  @override
  String get areGuestsAllowedToJoin =>
      'An bhfuil cead ag aoi-úsáideoirí a bheith páirteach';

  @override
  String get areYouSure => 'An bhfuil tú cinnte?';

  @override
  String get areYouSureYouWantToLogout =>
      'An bhfuil tú cinnte gur mhaith leat logáil amach?';

  @override
  String get askSSSSSign =>
      'Chun a bheith in ann an duine eile a shíniú, cuir isteach do phasfhrása stóir sábháilte nó d\'eochair téarnaimh.';

  @override
  String askVerificationRequest(Object username) {
    return 'Glac leis an iarratas fíoraithe seo ó $username?';
  }

  @override
  String get autoplayImages =>
      'Seinn greamáin agus straoiseog beoite go huathoibríoch';

  @override
  String badServerLoginTypesException(Object serverVersions,
      Object supportedVersions, Object suportedVersions) {
    return 'Tá na cineálacha logála isteach seo ar fáil faoin freastalaí baile:\n$serverVersions\nAch níl ach na ceann seo ar fáil faoin aip seo:\n$supportedVersions';
  }

  @override
  String get sendOnEnter => 'Seol ar iontráil';

  @override
  String badServerVersionsException(Object serverVersions,
      Object supportedVersions, Object serverVerions, Object suportedVersions) {
    return 'Tá na leaganacha sonraíochta seo ar fáil faoin freastalaí baile:\n$serverVersions\nAch níl ach na ceann seo ar fáil faoin aip seo $supportedVersions';
  }

  @override
  String get banFromChat => 'Toirmisc ón gcomhrá';

  @override
  String get banned => 'Coiscthe';

  @override
  String bannedUser(Object username, Object targetName) {
    return 'Chuir $username cosc ar $targetName';
  }

  @override
  String get blockDevice => 'Bac Gléas';

  @override
  String get blocked => 'Bactha';

  @override
  String get botMessages => 'Teachtaireachtaí bota';

  @override
  String get bubbleSize => 'Méid na mbolgán cainte';

  @override
  String get cancel => 'Cuir ar ceal';

  @override
  String cantOpenUri(Object uri) {
    return 'Ní féidir an URI $uri a oscailt';
  }

  @override
  String get changeDeviceName => 'Athraigh ainm an ghléis';

  @override
  String changedTheChatAvatar(Object username) {
    return 'D\'athraigh $username abhatár an chomhrá';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return 'D\'athraigh $username an cur síos comhrá go: \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return 'D\'athraigh $username an t-ainm comhrá go: \'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return 'D\'athraigh $username na ceadanna comhrá';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return 'D\'athraigh $username a n-ainm taispeána go: \'$displayname\'';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return 'D\'athraigh $username na rialacha rochtana aoi';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return 'D\'athraigh $username na rialacha maidir le rochtain aoi chuig: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return 'D\'athraigh $username infheictheacht na staire';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return 'D\'athraigh $username infheictheacht na staire go: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return 'D\'athraigh $username na rialacha ceangail';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return 'D\'athraigh $username na rialacha ceangail go: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return 'D\'athraigh $username a n-abhatár';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return 'D\'athraigh $username ailiasanna an tseomra';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return 'D\'athraigh $username nasc an chuiridh';
  }

  @override
  String get changePassword => 'Athraigh an pasfhocal';

  @override
  String get changeTheHomeserver => 'Athraigh an freastalaí baile';

  @override
  String get changeTheme => 'Athraigh do stíl';

  @override
  String get changeTheNameOfTheGroup => 'Athraigh ainm an chomhrá';

  @override
  String get changeWallpaper => 'Athraigh cúlbhrat';

  @override
  String get changeYourAvatar => 'Athraigh do abhatár';

  @override
  String get channelCorruptedDecryptError => 'Truaillíodh an criptiú';

  @override
  String get chat => 'Comhrá';

  @override
  String get yourUserId => 'D\'aitheantas úsáideora:';

  @override
  String get yourChatBackupHasBeenSetUp => 'Bunaíodh do chúltaca comhrá.';

  @override
  String get chatBackup => 'Cúltaca comhrá';

  @override
  String get chatBackupDescription =>
      'Tá do chúltaca comhrá daingnithe le heochair slándála. Déan cinnte nach gcaillfidh tú é.';

  @override
  String get chatDetails => 'Sonraí comhrá';

  @override
  String get chatHasBeenAddedToThisSpace => 'Cuireadh comhrá leis an spás seo';

  @override
  String get chats => 'Cait';

  @override
  String get chooseAStrongPassword => 'Roghnaigh pasfhocal láidir';

  @override
  String get chooseAUsername => 'Roghnaigh ainm úsáideora';

  @override
  String get clearArchive => 'Glan an cartlann';

  @override
  String get close => 'Dún';

  @override
  String get commandHint_markasdm => 'Marcáil mar chomhrá díreach';

  @override
  String get commandHint_markasgroup => 'Marcáil mar chomhrá';

  @override
  String get commandHint_ban =>
      'Cuir cosc ar an úsáideoir áirithe ón seomra seo';

  @override
  String get commandHint_clearcache => 'Glan an taisce';

  @override
  String get commandHint_create =>
      'Cruthaigh comhrá grúpa folamh\nÚsáid --no-encryption chun criptiúchán a dhíchumasú';

  @override
  String get commandHint_discardsession => 'Ná sábháil an seisiún';

  @override
  String get commandHint_dm =>
      'Tosaigh comhrá díreach\nÚsáid -- gan chriptiú chun criptiú a dhíchumasú';

  @override
  String get commandHint_html => 'Seol téacs HTML-formáidithe';

  @override
  String get commandHint_invite =>
      'Cuir cosc ar an úsáideoir áirithe ón seomra seo';

  @override
  String get commandHint_join => 'Téigh isteach sa seomra áirithe';

  @override
  String get commandHint_kick => 'Bain an t-úsáideoir áirithe den seomra seo';

  @override
  String get commandHint_leave => 'Fág an seomra seo';

  @override
  String get commandHint_me => 'Déan cur síos ort féin';

  @override
  String get commandHint_myroomavatar =>
      'Cuir do phictiúr don seomra seo (le mxc-uri)';

  @override
  String get commandHint_myroomnick =>
      'Socraigh d\'ainm taispeána don seomra seo';

  @override
  String get commandHint_op =>
      'Socraigh leibhéal cumhachta an úsáideora áirithe (réamhshocrú: 50)';

  @override
  String get commandHint_plain => 'Seol téacs neamhfhoirmithe';

  @override
  String get commandHint_react => 'Seol freagra mar fhreagairt';

  @override
  String get commandHint_send => 'Seol téacs';

  @override
  String get commandHint_unban =>
      'Cuir deireadh an cosc den úsáideoir áirithe ón seomra seo';

  @override
  String get commandInvalid => 'Ordú neamhbhailí';

  @override
  String commandMissing(Object command) {
    return 'Ní ordú é $command.';
  }

  @override
  String get compareEmojiMatch => 'Cuir na emojis i gcomparáid le do thoil';

  @override
  String get compareNumbersMatch =>
      'Cuir na huimhreacha i gcomparáid le do thoil';

  @override
  String get configureChat => 'Cumraigh comhrá';

  @override
  String get confirm => 'Deimhnigh';

  @override
  String get connect => 'Ceangail';

  @override
  String get contactHasBeenInvitedToTheGroup =>
      'Tugadh cuireadh don theagmháil a thar isteach sa grúpa';

  @override
  String get containsDisplayName => 'Coinníonn sé ainm taispeána';

  @override
  String get containsUserName => 'Coinníonn sé ainm úsáideora';

  @override
  String get contentHasBeenReported =>
      'Tuairiscíodh an t-ábhar do lucht riaracháin an fhreastalaí';

  @override
  String get copiedToClipboard => 'Cóipeáilte ar an ghearrthaisce';

  @override
  String get copy => 'Cóipeáil';

  @override
  String get copyToClipboard => 'Cóipeáil ar an ghearrthaisce';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Níorbh fhéidir teachtaireacht a dhíchriptiú: $error';
  }

  @override
  String countMembers(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count members',
      one: '1 ball',
      zero: 'no members',
    );
    return '$_temp0';
  }

  @override
  String get create => 'Cruthaigh';

  @override
  String createdTheChat(Object username) {
    return 'Rinne $username an comhrá';
  }

  @override
  String get createNewGroup => 'Déan grúpa nua';

  @override
  String get createNewSpace => 'Spás nua';

  @override
  String get crossSigningEnabled => 'Tá cros-shíniú tosaithe';

  @override
  String get currentlyActive => 'Gníomhach faoi láthair';

  @override
  String get darkTheme => 'Dorcha';

  @override
  String dateAndTimeOfDay(Object date, Object timeOfDay) {
    return '$date, $timeOfDay';
  }

  @override
  String dateWithoutYear(Object month, Object day) {
    return '$day/$month';
  }

  @override
  String dateWithYear(Object year, Object month, Object day) {
    return '$day/$month/$year';
  }

  @override
  String get deactivateAccountWarning =>
      'Díghníomhachtaeoidh sé seo do chuntas úsáideora. Ní féidir é seo a chealú! An bhfuil tú cinnte?';

  @override
  String get defaultPermissionLevel => 'Leibhéal ceada réamhshocraithe';

  @override
  String get delete => 'Scrios';

  @override
  String get deleteAccount => 'Scrios cuntas';

  @override
  String get deleteMessage => 'Scrios an teachtaireacht';

  @override
  String get deny => 'Diúltaigh';

  @override
  String get device => 'Gléas';

  @override
  String get deviceId => 'ID gléis';

  @override
  String get devices => 'Gléasanna';

  @override
  String get directChats => 'Comhráite Díreacha';

  @override
  String get discover => 'Tar ar';

  @override
  String get displaynameHasBeenChanged => 'Athraíodh an t-ainm taispeána';

  @override
  String get download => 'Íoslódáil';

  @override
  String get edit => 'Cuir in eagar';

  @override
  String get editBlockedServers => 'Cuir freastalaí blocáilte in eagar';

  @override
  String get editChatPermissions => 'Cuir ceadanna an chomhrá in eagar';

  @override
  String get editDisplayname => 'Cuir ainm taispeána in eagar';

  @override
  String get editRoomAliases => 'Cuir ailiasanna an tseomra in eagar';

  @override
  String get editRoomAvatar => 'Cuir in eagar abhatár an tseomra';

  @override
  String get emoteExists => 'Tá iomaite ann cheana féin!';

  @override
  String get emoteInvalid => 'Gearrchód emote neamhbhailí!';

  @override
  String get emotePacks => 'Pacáistí straoiseoige don seomra';

  @override
  String get emoteSettings => 'Socruithe straoiseoige';

  @override
  String get emoteShortcode => 'Gearrchód straoiseoige';

  @override
  String get emoteWarnNeedToPick =>
      'Caithfidh tú gearrchód straoiseoige agus íomhá a roghnú!';

  @override
  String get emptyChat => 'Comhrá folamh';

  @override
  String get enableEmotesGlobally =>
      'Cumasaigh pacáiste straoiseoige go huilíoch';

  @override
  String get enableEncryption => 'Cumasaigh criptiú ó cheann go ceann';

  @override
  String get enableEncryptionWarning =>
      'Ní bheidh in ann an criptiú a dhíchumasú níos mó. An bhfuil tú cinnte?';

  @override
  String get encrypted => 'Criptithe';

  @override
  String get encryption => 'Criptiúchán';

  @override
  String get encryptionNotEnabled => 'Ní chumasaítear criptiú';

  @override
  String endedTheCall(Object senderName) {
    return 'Chuir $senderName deireadh leis an nglao';
  }

  @override
  String get enterGroupName => 'Iontráil ainm comhrá';

  @override
  String get enterAnEmailAddress => 'Cuir isteach seoladh ríomhphoist';

  @override
  String get enterASpacepName => 'Cuir isteach ainm spáis';

  @override
  String get homeserver => 'Freastalaí baile';

  @override
  String get enterYourHomeserver => 'Cuir isteach do fhreastalaí baile';

  @override
  String errorObtainingLocation(Object error) {
    return 'Earráid maidir le suíomh a fháil: $error';
  }

  @override
  String get everythingReady => 'Gach rud réidh!';

  @override
  String get extremeOffensive => 'Fíor-maslach';

  @override
  String get fileName => 'Ainm an chomhaid';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Méid cló';

  @override
  String get forward => 'Seol ar aghaidh';

  @override
  String get friday => 'Aoine';

  @override
  String get fromJoining => 'Ó tar isteach';

  @override
  String get fromTheInvitation => 'Ón gcuireadh';

  @override
  String get goToTheNewRoom => 'Téigh go dtí an seomra nua';

  @override
  String get group => 'Grúpa';

  @override
  String get groupDescription => 'Cur síos ar chomhrá grúpa';

  @override
  String get groupDescriptionHasBeenChanged =>
      'Athraíodh cur síos ar an gcomhrá grúpa';

  @override
  String get groupIsPublic => 'Tá comhrá grúpa poiblí';

  @override
  String get groups => 'Comhráite grúpa';

  @override
  String groupWith(Object displayname) {
    return 'Comhrá grúpa le $displayname';
  }

  @override
  String get guestsAreForbidden => 'Tá cosc ar aíonna';

  @override
  String get guestsCanJoin => 'Is féidir le haíonna páirt a ghlacadh';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return 'Tharraing $username an cuireadh do $targetName siar';
  }

  @override
  String get help => 'Cabhair';

  @override
  String get hideRedactedEvents => 'Folaigh teachtaireachtaí scriosta';

  @override
  String get hideUnknownEvents => 'Folaigh imeachtaí anaithnide';

  @override
  String get howOffensiveIsThisContent =>
      'Cé chomh maslach atá an t-ábhar seo?';

  @override
  String get id => 'ID';

  @override
  String get identity => 'Aitheantas';

  @override
  String get ignore => 'Tabhair neamhaird ar';

  @override
  String get ignoredUsers => 'Úsáideoirí a dtugann tú neamhaird orthu';

  @override
  String get ignoreListDescription =>
      'Is féidir leat neamhaird a dhéanamh d\'úsáideoirí atá ag cur isteach ort. Ní bheidh tú in ann aon teachtaireachtaí nó cuireadh seomra a fháil ó na húsáideoirí ar do liosta neamhaird phearsanta.';

  @override
  String get ignoreUsername => 'Tabhair neamhaird ar ainm úsáideora';

  @override
  String get iHaveClickedOnLink => 'Chliceáil mé ar an nasc';

  @override
  String get incorrectPassphraseOrKey =>
      'Pasfhrása nó eochair téarnaimh mícheart';

  @override
  String get inoffensive => 'Neamhurchóideach';

  @override
  String get inviteContact => 'Tabhair cuireadh do theagmháil';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Tabhair cuireadh do theagmháil chuig $groupName';
  }

  @override
  String get invited => 'Le cuireadh';

  @override
  String invitedUser(Object username, Object targetName) {
    return 'Thug $username cuireadh do $targetName';
  }

  @override
  String get invitedUsersOnly => 'Úsáideoirí le cuireadh amháin';

  @override
  String get inviteForMe => 'Tabhair cuireadh dom';

  @override
  String inviteText(Object username, Object link) {
    return 'Thug $username cuireadh duit chuig FluffyChat.\n1. Suiteáil FluffyChat: https://fluffychat.im\n2. Cláraigh nó sínigh isteach\n3. Oscail an nasc cuiridh: $link';
  }

  @override
  String get isTyping => 'ag clóscríobh';

  @override
  String joinedTheChat(Object username) {
    return 'Tháinig $username isteach sa chomhrá';
  }

  @override
  String get joinRoom => 'Téigh isteach sa seomra';

  @override
  String get keysCached => 'Cuirtear eochracha i dtaisce';

  @override
  String kicked(Object username, Object targetName) {
    return 'Chaith $username $targetName amach';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return 'Chaith $username amach agus chuir cosc ar $targetName freisin';
  }

  @override
  String get kickFromChat => 'Caith é amach as an comhrá';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Gníomhach deireanach: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Le feiceáil i bhfad ó shin';

  @override
  String get leave => 'Fág';

  @override
  String get leftTheChat => 'Fágadh an comhrá';

  @override
  String get license => 'Ceadúnas';

  @override
  String get lightTheme => 'Solas';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Lódáil $count níos mó rannpháirtithe';
  }

  @override
  String get dehydrate => 'Easpórtáil seisiún agus gléas wipe';

  @override
  String get dehydrateWarning =>
      'Ní féidir an gníomh seo a chealú. Cinntigh go stórálann tú an comhad cúltaca go sábháilte.';

  @override
  String get dehydrateShare =>
      'Is é seo do onnmhairiú príobháideach FluffyChat. Cinntigh nach gcailleann tú é agus coinnigh príobháideach é.';

  @override
  String get dehydrateTor => 'Úsáideoirí TOR: Seisiún easpórtála';

  @override
  String get dehydrateTorLong =>
      'I gcás úsáideoirí TOR, moltar an seisiún a easpórtáil sula ndúnann tú an fhuinneog.';

  @override
  String get hydrateTor => 'Úsáideoirí TOR: Easpórtáil seisiúin iompórtála';

  @override
  String get hydrateTorLong =>
      'Ar easpórtáil tú do sheisiún an uair dheireanach ar TOR? Iompórtáil go tapa é agus leanúint ar aghaidh ag comhrá.';

  @override
  String get hydrate => 'Athchóirigh ó chomhad cúltaca';

  @override
  String get loadingPleaseWait => 'Ag lódáil… Fan, le do thoil.';

  @override
  String get loadingStatus => 'Stádas á luchtú...';

  @override
  String get loadMore => 'Lódáil níos mó…';

  @override
  String get locationDisabledNotice =>
      'Tá seirbhísí suímh díchumasaithe. Cuir ar a gcumas le do thoil a bheith in ann do shuíomh a roinnt.';

  @override
  String get locationPermissionDeniedNotice =>
      'Diúltaíodh cead suímh. Deonaigh dóibh le do thoil go mbeidh tú in ann do shuíomh a roinnt.';

  @override
  String get login => 'Logáil isteach';

  @override
  String logInTo(Object homeserver) {
    return 'Logáil isteach chuig $homeserver';
  }

  @override
  String get loginWithOneClick => 'Sínigh isteach le cliceáil amháin';

  @override
  String get logout => 'Logáil amach';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Cinntigh go bhfuil an t-aitheantóir bailí';

  @override
  String get memberChanges => 'Athruithe ball';

  @override
  String get mention => 'Luaigh';

  @override
  String get messages => 'Teachtaireachtaí';

  @override
  String get messageWillBeRemovedWarning =>
      'Bainfear an teachtaireacht do na rannpháirtithe go léir';

  @override
  String get noSearchResult => 'Níl aon torthaí cuardaigh meaitseála ann.';

  @override
  String get moderator => 'Modhnóir';

  @override
  String get monday => 'Tá mo';

  @override
  String get muteChat => 'Ciúnaigh comhrá';

  @override
  String get needPantalaimonWarning =>
      'Bí ar an eolas go dteastaíonn Pantalaimon uait chun criptiú ó cheann go ceann a úsáid anois.';

  @override
  String get newChat => 'Comhrá nua';

  @override
  String get newMessageInTwake => 'Tá teachtaireacht chriptithe 1 agat';

  @override
  String get newVerificationRequest => 'Iarratas fíoraithe nua!';

  @override
  String get noMoreResult => 'Níl aon toradh níos mó!';

  @override
  String get previous => 'Roimhe Seo';

  @override
  String get next => 'Ar Aghaidh';

  @override
  String get no => 'Ní hea';

  @override
  String get noConnectionToTheServer => 'Gan aon nasc leis an bhfreastalaí';

  @override
  String get noEmotesFound => 'Níor aimsíodh aon straoiseoga. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Ní féidir leat criptiú a ghníomhachtú ach a luaithe nach bhfuil an seomra inrochtana go poiblí a thuilleadh.';

  @override
  String get noGoogleServicesWarning =>
      'Dealraíonn sé nach bhfuil aon seirbhísí google agat ar do ghuthán. Sin cinneadh maith le do phríobháideacht! Chun fógraí brú a fháil i FluffyChat molaimid https://microg.org/ nó https://unifiedpush.org/ a úsáid.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return 'Níl $server1 freastalaí Matrix. Úsáid $server2 ina áit sin?';
  }

  @override
  String get shareYourInviteLink => 'Roinn do nasc cuiridh';

  @override
  String get typeInInviteLinkManually =>
      'Clóscríobh an nasc cuiridh de láimh...';

  @override
  String get scanQrCode => 'Scan cód QR';

  @override
  String get none => 'Aon cheann';

  @override
  String get noPasswordRecoveryDescription =>
      'Níor chuir tú bealach leis do phasfhocal a aisghabháil fós.';

  @override
  String get noPermission => 'Gan cead';

  @override
  String get noRoomsFound => 'Níor aimsíodh aon seomraí…';

  @override
  String get notifications => 'Fógraí';

  @override
  String numUsersTyping(Object count) {
    return 'Tá $count úsáideoirí ag clóscríobh';
  }

  @override
  String get obtainingLocation => 'ag Aimsiú an suíomh…';

  @override
  String get offensive => 'Maslach';

  @override
  String get offline => 'As líne';

  @override
  String get aWhileAgo => 'tamall ó shin';

  @override
  String get ok => 'togha';

  @override
  String get online => 'Ar líne';

  @override
  String get onlineKeyBackupEnabled => 'Tá Cúltaca Eochair Ar Líne cumasaithe';

  @override
  String get cannotEnableKeyBackup =>
      'Ní féidir cúltaca comhrá a chumasú. Téigh chuig Socruithe chun triail eile a bhaint as.';

  @override
  String get cannotUploadKey => 'Ní féidir Cúltaca Eochrach a stóráil.';

  @override
  String get oopsPushError =>
      'Hoips! Ar an drochuair, tharla earráid nuair a bhí na fógraí brú á mbunú.';

  @override
  String get oopsSomethingWentWrong => 'Úps, chuaigh rud éigin mícheart …';

  @override
  String get openAppToReadMessages =>
      'Oscail an aip chun teachtaireachtaí a léamh';

  @override
  String get openCamera => 'Oscail ceamara';

  @override
  String get openVideoCamera => 'Oscail físcheamara';

  @override
  String get oneClientLoggedOut => 'Tá ceann de do chliaint logáilte amach';

  @override
  String get addAccount => 'Breisigh cuntas';

  @override
  String get editBundlesForAccount => 'Cuir burlaí in eagar don chuntas seo';

  @override
  String get addToBundle => 'Cuir leis an mbeart';

  @override
  String get removeFromBundle => 'Bain as an mbeart seo';

  @override
  String get bundleName => 'Ainm an chuachta';

  @override
  String get enableMultiAccounts =>
      '(BÉITE) Cumasaigh cuntais iomadúla ar an gléas seo';

  @override
  String get openInMaps => 'Oscail i léarscáileanna';

  @override
  String get link => 'Nasc';

  @override
  String get serverRequiresEmail =>
      'Ní mór don fhreastalaí seo do sheoladh ríomhphoist a bhailíochtú le haghaidh clárúcháin.';

  @override
  String get optionalGroupName => '(Optional) Ainm an ghrúpa';

  @override
  String get or => 'Nó';

  @override
  String get participant => 'Rannpháirtí';

  @override
  String get passphraseOrKey => 'pasfhrása nó eochair téarnaimh';

  @override
  String get password => 'Pasfhocal';

  @override
  String get passwordForgotten => 'Pasfhocal dearmadta';

  @override
  String get passwordHasBeenChanged => 'Athraíodh an pasfhocal';

  @override
  String get passwordRecovery => 'Aisfháil pasfhocail';

  @override
  String get people => 'Daoine';

  @override
  String get pickImage => 'Roghnaigh íomhá';

  @override
  String get pin => 'Biorán';

  @override
  String play(Object fileName) {
    return 'Seinn $fileName';
  }

  @override
  String get pleaseChoose => 'Roghnaigh le do thoil';

  @override
  String get pleaseChooseAPasscode => 'Roghnaigh paschód le do thoil';

  @override
  String get pleaseChooseAUsername => 'Roghnaigh ainm úsáideora le do thoil';

  @override
  String get pleaseClickOnLink =>
      'Cliceáil ar an nasc sa ríomhphost agus ansin lean ar aghaidh.';

  @override
  String get pleaseEnter4Digits =>
      'Iontráil 4 dhigit le do thoil nó fág folamh chun glas aipe a dhíchumasú.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'Iontráil ID Matrix le do thoil.';

  @override
  String get pleaseEnterRecoveryKey =>
      'Cuir isteach d\'eochair aisghabhála le do thoil:';

  @override
  String get pleaseEnterYourPassword => 'Iontráil do phasfhocal le do thoil';

  @override
  String get pleaseEnterYourPin => 'Cuir isteach d\'uimhir PIN le do thoil';

  @override
  String get pleaseEnterYourUsername =>
      'Cuir isteach d\'ainm úsáideora le do thoil';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Lean na treoracha ar an suíomh gréasáin agus tapáil \"ar aghaidh\".';

  @override
  String get privacy => 'Príobháideacht';

  @override
  String get publicRooms => 'Seomraí Poiblí';

  @override
  String get pushRules => 'Rialacha na bhfógraí';

  @override
  String get reason => 'Fáth';

  @override
  String get recording => 'Ag Taifeadadh';

  @override
  String redactedAnEvent(Object username) {
    return 'Scrios $username teachtaireacht';
  }

  @override
  String get redactMessage => 'Bain teachtaireacht amach';

  @override
  String get register => 'Cláraigh';

  @override
  String get reject => 'Diúltaigh';

  @override
  String rejectedTheInvitation(Object username) {
    return 'Dhiúltaigh $username don chuireadh';
  }

  @override
  String get rejoin => 'Téigh ar ais isteach';

  @override
  String get remove => 'Bain';

  @override
  String get removeAllOtherDevices => 'Bain gach gléas eile';

  @override
  String removedBy(Object username) {
    return 'Bainte de ag $username';
  }

  @override
  String get removeDevice => 'Bain gléas';

  @override
  String get unbanFromChat => 'Cuir deireadh an cosc ón gcomhrá';

  @override
  String get removeYourAvatar => 'Bain d\'abhatár';

  @override
  String get renderRichContent => 'Taispeáin ábhar teachtaireachta saibhir';

  @override
  String get replaceRoomWithNewerVersion =>
      'Cuir leagan seomra níos nuaí in ionad an tseomra';

  @override
  String get reply => 'Freagair';

  @override
  String get reportMessage => 'Tuairiscigh teachtaireacht';

  @override
  String get requestPermission => 'Iarr cead';

  @override
  String get roomHasBeenUpgraded => 'Uasghrádaíodh an seomra';

  @override
  String get roomVersion => 'Leagan seomra';

  @override
  String get saturday => 'Satharn';

  @override
  String get saveFile => 'Sábháil comhad';

  @override
  String get searchForPeopleAndChannels => 'Cuardaigh daoine agus cainéil';

  @override
  String get security => 'Slándáil';

  @override
  String get recoveryKey => 'Eochair téarnaimh';

  @override
  String get recoveryKeyLost => 'Eochair Téarnaimh caillte?';

  @override
  String seenByUser(Object username) {
    return 'Le feiceáil ag $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Le feiceáil ag $username agus $count daoine eile',
    );
    return '$_temp0';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Le feiceáil ag $username agus $username2';
  }

  @override
  String get send => 'Seol';

  @override
  String get sendAMessage => 'Seol teachtaireacht';

  @override
  String get sendAsText => 'Seol mar théacs';

  @override
  String get sendAudio => 'Seol fuaim';

  @override
  String get sendFile => 'Seol comhad';

  @override
  String get sendImage => 'Seol íomhá';

  @override
  String get sendMessages => 'Seol teachtaireachtaí';

  @override
  String get sendMessage => 'Seol teachtaireacht';

  @override
  String get sendOriginal => 'Seol an bunchóip';

  @override
  String get sendSticker => 'Seol greamán';

  @override
  String get sendVideo => 'Seol físeán';

  @override
  String sentAFile(Object username) {
    return 'Sheol $username comhad';
  }

  @override
  String sentAnAudio(Object username) {
    return 'Sheol $username fuaim';
  }

  @override
  String sentAPicture(Object username) {
    return 'Sheol $username pictiúr';
  }

  @override
  String sentASticker(Object username) {
    return 'Sheol $username greamán';
  }

  @override
  String sentAVideo(Object username) {
    return 'Sheol $username físeán';
  }

  @override
  String sentCallInformations(Object senderName) {
    return 'Sheol $senderName faisnéis maidir le glaonna';
  }

  @override
  String get separateChatTypes => 'Comhráite agus Grúpaí Díreacha ar Leithligh';

  @override
  String get setAsCanonicalAlias => 'Socraigh mar phríomh-ailias';

  @override
  String get setCustomEmotes => 'Socraigh straoiseoga saincheaptha';

  @override
  String get setGroupDescription => 'Socraigh cur síos ar an ngrúpa';

  @override
  String get setInvitationLink => 'Socraigh nasc cuiridh';

  @override
  String get setPermissionsLevel => 'Socraigh leibhéal ceadanna';

  @override
  String get setStatus => 'Cuir stádas';

  @override
  String get settings => 'Socruithe';

  @override
  String get share => 'Roinn';

  @override
  String sharedTheLocation(Object username) {
    return 'Roinn $username an suíomh';
  }

  @override
  String get shareLocation => 'Roinn suíomh';

  @override
  String get showDirectChatsInSpaces =>
      'Taispeáin Comhráite Díreacha gaolmhara i Spásanna';

  @override
  String get showPassword => 'Taispeáin pasfhocal';

  @override
  String get signUp => 'Cláraigh Cuntas';

  @override
  String get singlesignon => 'Sínigh Aonair ar';

  @override
  String get skip => 'Léim';

  @override
  String get invite => 'Tabhair cuireadh';

  @override
  String get sourceCode => 'Cód foinseach';

  @override
  String get spaceIsPublic => 'Tá an spás poiblí';

  @override
  String get spaceName => 'Ainm an spáis';

  @override
  String startedACall(Object senderName) {
    return 'Thosaigh $senderName glao';
  }

  @override
  String get startFirstChat => 'Tosaigh do chéad chomhrá';

  @override
  String get status => 'Staid';

  @override
  String get statusExampleMessage => 'Conas atá tú inniu?';

  @override
  String get submit => 'Cuir isteach';

  @override
  String get sunday => 'An Ghrian';

  @override
  String get synchronizingPleaseWait => 'Ag sioncrónú... Fan, le do thoil.';

  @override
  String get systemTheme => 'Córas';

  @override
  String get theyDontMatch => 'Níl siad céanna';

  @override
  String get theyMatch => 'Tá siad céanna';

  @override
  String get thisRoomHasBeenArchived => 'Tá an seomra seo curtha i gcartlann.';

  @override
  String get thursday => 'An Fómhar';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Scoránaigh mar ceann is fearr leat';

  @override
  String get toggleMuted => 'Scoránaigh mar ciúnaithe';

  @override
  String get toggleUnread => 'Marcáil Léite/Neamhléite';

  @override
  String get tooManyRequestsWarning =>
      'An iomarca iarratas. Bain triail eile as níos déanaí!';

  @override
  String get transferFromAnotherDevice => 'Aistriú ó ghléas eile';

  @override
  String get tryToSendAgain => 'Déan iarracht a sheoladh arís';

  @override
  String get tuesday => 'Máirt';

  @override
  String get unavailable => 'Níl ar fáil';

  @override
  String unbannedUser(Object username, Object targetName) {
    return 'Chuir $username deireadh an cosc $targetName';
  }

  @override
  String get unblockDevice => 'Díbhlocáil Gléas';

  @override
  String get unknownDevice => 'Gléas anaithnid';

  @override
  String get unknownEncryptionAlgorithm => 'Algartam criptithe anaithnid';

  @override
  String unknownEvent(Object type, Object tipo) {
    return 'Imeacht anaithnid \'$type\'';
  }

  @override
  String get unmuteChat => 'Neamhciúnaigh comhrá';

  @override
  String get unpin => 'Bain biorán';

  @override
  String unreadChats(num unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount comhráite neamhléite',
      one: '1 comhrá neamhléite',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return 'tá $username agus $count daoine eile ag clóscríobh';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return 'Tá $username agus $username2 ag clóscríobh';
  }

  @override
  String userIsTyping(Object username) {
    return 'Tá $username ag clóscríobh';
  }

  @override
  String userLeftTheChat(Object username) {
    return 'D\'fhág $username an comhrá';
  }

  @override
  String get username => 'Ainm Úsáideora';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return 'Sheol $username imeacht $type';
  }

  @override
  String get unverified => 'Gan deimhniú';

  @override
  String get verified => 'Deimhnithe';

  @override
  String get verify => 'Deimhnigh';

  @override
  String get verifyStart => 'Tosaigh Fíorú';

  @override
  String get verifySuccess => 'D\'fhíoraigh tú go rathúil!';

  @override
  String get verifyTitle => 'Ag fíorú cuntas eile';

  @override
  String get videoCall => 'Físghlao';

  @override
  String get visibilityOfTheChatHistory => 'Infheictheacht stair na comhrá';

  @override
  String get visibleForAllParticipants =>
      'Infheicthe do na rannpháirtithe go léir';

  @override
  String get visibleForEveryone => 'Infheicthe do gach duine';

  @override
  String get voiceMessage => 'Glórphost';

  @override
  String get waitingPartnerAcceptRequest =>
      'Ag fanacht le comhpháirtí glacadh leis an iarratas…';

  @override
  String get waitingPartnerEmoji =>
      'Ag fanacht le comhpháirtí glacadh leis na straoiseoga…';

  @override
  String get waitingPartnerNumbers =>
      'Ag fanacht le comhpháirtí glacadh leis na huimhreacha …';

  @override
  String get wallpaper => 'Cúlbhrat';

  @override
  String get warning => 'Rabhadh!';

  @override
  String get wednesday => 'Céad';

  @override
  String get weSentYouAnEmail => 'Sheolamar ríomhphost chugat';

  @override
  String get whoCanPerformWhichAction => 'Cé atá in ann an gníomh a dhéanamh';

  @override
  String get whoIsAllowedToJoinThisGroup =>
      'Cé a bhfuil cead aige/aici dul isteach sa ghrúpa seo';

  @override
  String get whyDoYouWantToReportThis =>
      'Cén fáth ar mhaith leat é seo a thuairisciú?';

  @override
  String get wipeChatBackup =>
      'Glan do cúltaca comhrá a chruthú eochair slándála nua?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Leis na seoltaí seo is féidir leat do phasfhocal a athshlánú.';

  @override
  String get writeAMessage => 'Scríobh teachtaireacht…';

  @override
  String get yes => 'Tá';

  @override
  String get you => 'Tú';

  @override
  String get youAreInvitedToThisChat =>
      'Tugtar cuireadh duit chuig an gcomhrá seo';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Níl tú ag glacadh páirte sa chomhrá seo a thuilleadh';

  @override
  String get youCannotInviteYourself =>
      'Ní féidir leat cuireadh a thabhairt duit féin';

  @override
  String get youHaveBeenBannedFromThisChat =>
      'Cuireadh cosc ort ón gcomhrá seo';

  @override
  String get yourPublicKey => 'D\'eochair phoiblí';

  @override
  String get messageInfo => 'Eolas faoin teachtaireacht';

  @override
  String get time => 'Am';

  @override
  String get messageType => 'Cineál Teachtaireachta';

  @override
  String get sender => 'Tarchuradóir';

  @override
  String get openGallery => 'Oscail gailearaí';

  @override
  String get removeFromSpace => 'Bain ón spás';

  @override
  String get addToSpaceDescription =>
      'Roghnaigh spás chun an comhrá seo a chur leis.';

  @override
  String get start => 'Tosaigh';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'Chun do sheanteachtaireachtaí a dhíghlasáil, cuir isteach d\'eochair aisghabhála a gineadh i seisiún roimhe seo. NACH bhfuil do eochair a ghnóthú do phasfhocal.';

  @override
  String get addToStory => 'Cuir leis an scéal';

  @override
  String get publish => 'Foilsigh';

  @override
  String get whoCanSeeMyStories =>
      'Cé atá in ann mo chuid scéalta a fheiceáil?';

  @override
  String get unsubscribeStories => 'Díliostáil scéalta';

  @override
  String get thisUserHasNotPostedAnythingYet =>
      'Níor phostáil an t-úsáideoir seo aon rud ina scéal go fóill';

  @override
  String get yourStory => 'Do scéal';

  @override
  String get replyHasBeenSent => 'Seoladh freagra';

  @override
  String videoWithSize(Object size) {
    return 'Físeán ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return 'Scéal ó $date: \n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'Tabhair faoi deara gur féidir le daoine a chéile a fheiceáil agus teagmháil a dhéanamh lena chéile i do scéal.';

  @override
  String get whatIsGoingOn => 'Céard atá ag dul ar aghaidh?';

  @override
  String get addDescription => 'Cuir cur síos leis';

  @override
  String get storyPrivacyWarning =>
      'Tabhair faoi deara gur féidir le daoine a chéile a fheiceáil agus teagmháil a dhéanamh lena chéile i do scéal. Beidh do scéalta le feiceáil ar feadh 24 uair an chloig ach níl aon ráthaíocht ann go scriosfar iad ó gach feiste agus freastalaithe.';

  @override
  String get iUnderstand => 'Tuigim';

  @override
  String get openChat => 'Oscail Comhrá';

  @override
  String get markAsRead => 'Marcáil mar léite';

  @override
  String get reportUser => 'Tuairiscigh úsáideoir';

  @override
  String get dismiss => 'Ruaig';

  @override
  String get matrixWidgets => 'Giuirléidí Maitríse';

  @override
  String reactedWith(Object sender, Object reaction) {
    return 'D\'fhreagair $sender le $reaction';
  }

  @override
  String get pinChat => 'Biorán';

  @override
  String get confirmEventUnpin =>
      'An bhfuil tú cinnte an teachtaireacht a dhíphionáil go buan?';

  @override
  String get emojis => 'Emojis';

  @override
  String get placeCall => 'Glao ar áit';

  @override
  String get voiceCall => 'Glao gutha';

  @override
  String get unsupportedAndroidVersion => 'Leagan Android gan tacaíocht';

  @override
  String get unsupportedAndroidVersionLong =>
      'Éilíonn an ghné seo leagan Android níos nuaí. Seiceáil le do thoil le haghaidh nuashonruithe nó tacaíocht Lineage OS.';

  @override
  String get videoCallsBetaWarning =>
      'Tabhair faoi deara go bhfuil físglaonna i béite. B\'fhéidir nach bhfeidhmíonn siad ar gach ardán chomh atá súil aige ná ar bith.';

  @override
  String get experimentalVideoCalls => 'Glaonna físe turgnamhacha';

  @override
  String get emailOrUsername => 'Ríomhphost nó ainm úsáideora';

  @override
  String get indexedDbErrorTitle => 'Saincheisteanna mód príobháideach';

  @override
  String get indexedDbErrorLong =>
      'Ar an drochuair, níl stóráil na dteachtaireachtaí cumasaithe i mód príobháideach de réir réamhshocraithe.\nTabhair cuairt, le do thoil,\n - faoi:config\n - socraigh dom.indexedDB.privateBrowsing.enabled go fíor\nSeachas sin, ní féidir FluffyChat a reáchtáil.';

  @override
  String switchToAccount(Object number) {
    return 'Athraigh go cuntas $number';
  }

  @override
  String get nextAccount => 'An chéad chuntas eile';

  @override
  String get previousAccount => 'An cuntas roimhe seo';

  @override
  String get editWidgets => 'Cuir giuirléidí in eagar';

  @override
  String get addWidget => 'Cuir giuirléid leis';

  @override
  String get widgetVideo => 'Físeán';

  @override
  String get widgetEtherpad => 'Nóta téacs';

  @override
  String get widgetJitsi => 'Jitsi Buail le chéile';

  @override
  String get widgetCustom => 'Saincheaptha';

  @override
  String get widgetName => 'Ainm';

  @override
  String get widgetUrlError => 'Ní URL bailí é seo.';

  @override
  String get widgetNameError => 'Tabhair ainm taispeána, le do thoil.';

  @override
  String get errorAddingWidget => 'Earráid agus an ghiuirléid á cur leis.';

  @override
  String get youRejectedTheInvitation => 'Dhiúltaigh tú don chuireadh';

  @override
  String get youJoinedTheChat => 'Chuaigh tú isteach sa chomhrá';

  @override
  String get youAcceptedTheInvitation => '👍 Ghlac tú leis an gcuireadh';

  @override
  String youBannedUser(Object user) {
    return 'Chuir tú cosc ar $user';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return 'Tharraing tú siar an cuireadh do $user';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩 Thug $user cuireadh duit';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩 Thug tú cuireadh do $user';
  }

  @override
  String youKicked(Object user) {
    return '👞 Chiceáil tú $user';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅 Chiceáil tú agus chuir tú cosc ar $user';
  }

  @override
  String youUnbannedUser(Object user) {
    return 'Unbanned tú $user';
  }

  @override
  String get noEmailWarning =>
      'Iontráil seoladh ríomhphoist bailí. Seachas sin ní bheidh tú in ann do phasfhocal a athshocrú. Mura bhfuil tú ag iarraidh, tapáil arís ar an gcnaipe chun leanúint ar aghaidh.';

  @override
  String get stories => 'Scéalta';

  @override
  String get users => 'Úsáideoirí';

  @override
  String get enableAutoBackups => 'Cumasaigh cúltacaí uathoibríocha';

  @override
  String get unlockOldMessages => 'Díghlasáil seanteachtaireachtaí';

  @override
  String get cannotUnlockBackupKey =>
      'Ní féidir cúltaca Eochrach a dhíghlasáil.';

  @override
  String get storeInSecureStorageDescription =>
      'Stóráil an eochair aisghabhála i stóráil slán an ghléis seo.';

  @override
  String get saveKeyManuallyDescription =>
      'Sábháil an eochair seo de láimh trí dialóg nó gearrthaisce comhroinnte an chórais a spreagadh.';

  @override
  String get storeInAndroidKeystore => 'Stóráil i Android KeyStore';

  @override
  String get storeInAppleKeyChain => 'Stóráil i Apple KeyChain';

  @override
  String get storeSecurlyOnThisDevice => 'Stóráil go daingean ar an ngléas seo';

  @override
  String countFiles(Object count) {
    return 'Comhaid $count';
  }

  @override
  String get user => 'Úsáideoir';

  @override
  String get custom => 'Saincheaptha';

  @override
  String get foregroundServiceRunning =>
      'Tá an fógra seo le feiceáil nuair atá an tseirbhís tulra ag rith.';

  @override
  String get screenSharingTitle => 'comhroinnt scáileáin';

  @override
  String get screenSharingDetail => 'Tá do scáileán á roinnt agat i FuffyChat';

  @override
  String get callingPermissions => 'Ceadanna a ghlaoch';

  @override
  String get callingAccount => 'Cuntas ag glaoch';

  @override
  String get callingAccountDetails =>
      'Ceadaíonn FluffyChat an aip dhiailiú android dúchais a úsáid.';

  @override
  String get appearOnTop => 'Le feiceáil ar an mbarr';

  @override
  String get appearOnTopDetails =>
      'Ceadaíonn sé don aip a bheith ar bharr (ní gá má tá socrú Fluffychat agat cheana féin mar chuntas glao)';

  @override
  String get otherCallingPermissions =>
      'Micreafón, ceamara agus ceadanna FluffyChat eile';

  @override
  String get whyIsThisMessageEncrypted =>
      'Cén fáth nach féidir an teachtaireacht seo a léamh?';

  @override
  String get noKeyForThisMessage =>
      'Féadfaidh sé seo tarlú má seoladh an teachtaireacht sular shínigh tú isteach ar do chuntas ag an ngléas seo.\n\nIs féidir freisin gur chuir an seoltóir bac ar do ghléas nó go ndeachaigh rud éigin mícheart leis an nasc idirlín.\n\nAn bhfuil tú in ann an teachtaireacht a léamh ar sheisiún eile? Ansin is féidir leat an teachtaireacht a aistriú uaidh! Téigh go Socruithe > Gléasanna agus cinntigh go bhfuil do ghléasanna fíoraithe a chéile. Nuair a osclaíonn tú an seomra an chéad uair eile agus an dá sheisiún sa tulra, déanfar na heochracha a tharchur go huathoibríoch.\n\nNár mhaith leat na heochracha a scaoileadh agus tú ag logáil amach nó ag aistriú gléasanna? Déan cinnte go bhfuil an cúltaca comhrá cumasaithe agat sna socruithe.';

  @override
  String get newGroup => 'Comhrá nua';

  @override
  String get newSpace => 'Spás nua';

  @override
  String get enterSpace => 'Iontráil spás';

  @override
  String get enterRoom => 'Iontráil seomra';

  @override
  String get allSpaces => 'Gach spás';

  @override
  String numChats(Object number) {
    return 'Comhráite $number';
  }

  @override
  String get hideUnimportantStateEvents =>
      'Folaigh imeachtaí stáit gan tábhacht';

  @override
  String get doNotShowAgain => 'Ná taispeáin arís';

  @override
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return 'Comhrá folamh (bhí $oldDisplayName)';
  }

  @override
  String get newSpaceDescription =>
      'Ligeann spásanna duit do chomhráite a chomhdhlúthú agus pobail phríobháideacha nó phoiblí a thógáil.';

  @override
  String get encryptThisChat => 'Criptigh an comhrá seo';

  @override
  String get endToEndEncryption => 'Criptiú ó dheireadh go deireadh';

  @override
  String get disableEncryptionWarning =>
      'Ar chúiseanna slándála ní féidir leat criptiú a dhíchumasú i gcomhrá, áit ar cumasaíodh é roimhe seo.';

  @override
  String get sorryThatsNotPossible => 'Tá brón orm... nach féidir a dhéanamh';

  @override
  String get deviceKeys => 'Eochracha gléis:';

  @override
  String get letsStart => 'Tosaímis';

  @override
  String get enterInviteLinkOrMatrixId =>
      'Iontráil an nasc cuireadh nó Aitheantas Maitríse...';

  @override
  String get reopenChat => 'Comhrá a athoscailt';

  @override
  String get noBackupWarning =>
      'Rabhadh! Gan cúltaca comhrá a chumasú, caillfidh tú rochtain ar do theachtaireachtaí criptithe. Moltar go mór an cúltaca comhrá a chumasú ar dtús sula logálann tú amach.';

  @override
  String get noOtherDevicesFound => 'Níor aimsíodh aon ghléas eile';

  @override
  String get fileIsTooBigForServer =>
      'Tuairiscíonn an freastalaí go bhfuil an comhad ró-mhór le seoladh.';

  @override
  String get onlineStatus => 'ar líne';

  @override
  String onlineMinAgo(Object min) {
    return 'ar líne ${min}m ó shin';
  }

  @override
  String onlineHourAgo(Object hour) {
    return 'ar líne ${hour}h ó shin';
  }

  @override
  String onlineDayAgo(Object day) {
    return 'ar líne ${day}d ó shin';
  }

  @override
  String get noMessageHereYet => 'Níl teachtaireacht ar bith anseo go fóill...';

  @override
  String get sendMessageGuide =>
      'Seol teachtaireacht nó tapáil ar an mbeannacht thíos.';

  @override
  String get youCreatedGroupChat => 'Chruthaigh tú comhrá Grúpa';

  @override
  String get chatCanHave => 'Is féidir le comhrá a bheith:';

  @override
  String get upTo100000Members => 'Suas le 100.000 ball';

  @override
  String get persistentChatHistory => 'Stair Comhrá Leanúnach';

  @override
  String get addMember => 'Cuir baill leis';

  @override
  String get profile => 'Próifíl';

  @override
  String get channels => 'Cainéil';

  @override
  String get chatMessage => 'Teachtaireacht nua';

  @override
  String welcomeToTwake(Object user) {
    return 'Fáilte go Twake, $user';
  }

  @override
  String get startNewChatMessage =>
      'Is deas comhrá a bheith agat le do chairde agus comhoibriú le d\'fhoirne.\nTosaímis comhrá, cruthaímis comhrá grúpa, nó glac páirt i gceann atá ann cheana féin.';

  @override
  String get statusDot => '⬤';

  @override
  String get active => 'Gníomhachtaithe';

  @override
  String get inactive => 'Gan a bheith gníomhachtaithe';

  @override
  String get newGroupChat => 'Comhrá Grúpa Nua';

  @override
  String get twakeUsers => 'Úsáideoirí Twake';

  @override
  String get expand => 'Leathnaigh';

  @override
  String get shrink => 'Laghdaigh';

  @override
  String noResultForKeyword(Object keyword) {
    return 'Níl aon torthaí le haghaidh \"$keyword\"';
  }

  @override
  String get searchResultNotFound1 =>
      '• Déan cinnte nach bhfuil aon typos i do chuardach.\n';

  @override
  String get searchResultNotFound2 =>
      '• B\'fhéidir nach bhfuil an t-úsáideoir agat i do leabhar seoltaí.\n';

  @override
  String get searchResultNotFound3 =>
      '• Seiceáil an cead rochtana teagmhála, d\'fhéadfadh an t-úsáideoir a bheith ar do liosta teagmhála.\n';

  @override
  String get searchResultNotFound4 =>
      '• Mura bhfuil an chúis liostaithe thuas, ';

  @override
  String get searchResultNotFound5 => 'cabhair a lorg.';

  @override
  String get more => 'Níos mó';

  @override
  String get whoWouldYouLikeToAdd => 'Cé ba mhaith leat a chur leis?';

  @override
  String get addAPhoto => 'Cuir grianghraf leis';

  @override
  String maxImageSize(Object max) {
    return 'Uasmhéid comhaid: ${max}MB';
  }

  @override
  String get owner => 'Úinéir';

  @override
  String participantsCount(Object count) {
    return 'Rannpháirtithe ($count)';
  }

  @override
  String get back => 'Ar ais';

  @override
  String get wrongServerName => 'Ainm freastalaí mícheart';

  @override
  String get serverNameWrongExplain =>
      'Sheol riarthóir na cuideachta seoladh an fhreastalaí chugat. Seiceáil an ríomhphost cuiridh.';

  @override
  String get contacts => 'Teagmhálacha';

  @override
  String get searchForContacts => 'Cuardaigh teagmhálacha';

  @override
  String get soonThereHaveContacts => 'Is gearr go mbeidh teagmhálacha ann';

  @override
  String get searchSuggestion =>
      'Chun anois, cuardach a dhéanamh trí ainm duine nó seoladh freastalaí poiblí a chlóscríobh';

  @override
  String get loadingContacts => 'Teagmhálacha á luchtú...';

  @override
  String get recentChat => 'COMHRÁ LE DÉANAÍ';

  @override
  String get selectChat => 'Roghnaigh comhrá';

  @override
  String get search => 'Cuardaigh';

  @override
  String get forwardTo => 'Ar aghaidh chuig...';

  @override
  String get noConnection => 'Gan ceangal';

  @override
  String photoSelectedCounter(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count grianghraif',
      one: '1 grianghraf',
    );
    return '$_temp0 roghnaithe';
  }

  @override
  String get addACaption => 'Cuir fotheideal leis...';

  @override
  String get noImagesFound => 'Níor aimsíodh aon íomhánna';

  @override
  String get captionForImagesIsNotSupportYet =>
      'Ní thacaítear le fotheideal d\'íomhánna go fóill.';

  @override
  String get tapToAllowAccessToYourGallery =>
      'Tapáil chun rochtain ar an ngailearaí a cheadú';

  @override
  String get tapToAllowAccessToYourCamera =>
      'Is féidir leat rochtain cheamara a chumasú san aip Socruithe chun físghlaonna a dhéanamh';

  @override
  String get twake => 'Comhrá Twake';

  @override
  String get permissionAccess => 'Rochtain ceada';

  @override
  String get allow => 'Ceadaigh';

  @override
  String get explainStoragePermission =>
      'Twake gá rochtain ar do stóráil chun réamhamharc comhad';

  @override
  String get explainGoToStorageSetting =>
      'Twake gá rochtain ar do stóráil chun réamhamharc comhad, téigh go dtí socruithe chun an cead seo a cheadú';

  @override
  String get gallery => 'Gailearaí';

  @override
  String get documents => 'Doiciméid';

  @override
  String get location => 'Suíomh';

  @override
  String get contact => 'Teagmháil';

  @override
  String get file => 'Comhad';

  @override
  String get recent => 'Le déanaí';

  @override
  String get chatsAndContacts => 'Comhráite agus Teagmhálacha';

  @override
  String get externalContactTitle => 'Tabhair cuireadh d\'úsáideoirí nua';

  @override
  String get externalContactMessage =>
      'Níl cuid de na húsáideoirí is mian leat a chur leis i do theagmhálaithe. An bhfuil fonn ort cuireadh a thabhairt dóibh?';

  @override
  String get clear => 'Glan';

  @override
  String get keyboard => 'Méarchlár';

  @override
  String get changeChatAvatar => 'Athraigh an avatar Comhrá';

  @override
  String get roomAvatarMaxFileSize => 'Tá méid an avatar ró-mhór';

  @override
  String roomAvatarMaxFileSizeLong(Object max) {
    return 'Caithfidh méid an avatar a bheith níos lú ná $max';
  }

  @override
  String get continueProcess => 'Lean ar aghaidh';

  @override
  String get youAreUploadingPhotosDoYouWantToCancelOrContinue =>
      'Earráid uaslódála íomhá! An bhfuil fonn ort fós leanúint ar aghaidh ag cruthú comhrá grúpa?';

  @override
  String hasCreatedAGroupChat(Object groupName) {
    return 'chruthaigh sé comhrá grúpa \"$groupName\"';
  }

  @override
  String get today => 'Inniu';

  @override
  String get yesterday => 'Inné';

  @override
  String get adminPanel => 'Painéal Riaracháin';

  @override
  String get acceptInvite => 'Tá, le do thoil, páirt a ghlacadh';

  @override
  String get askToInvite =>
      ' ba mhaith leat a bheith páirteach sa chomhrá seo. Céard a deir tú?';

  @override
  String get select => 'Roghnaigh';

  @override
  String get copyMessageText => 'Cóipeáil';

  @override
  String get pinThisChat => 'Pionnáil an comhrá seo';

  @override
  String get unpinThisChat => 'Díphionnáil an comhrá seo';

  @override
  String get add => 'Cuir Leis';

  @override
  String get addMembers => 'Cuir baill leis';

  @override
  String get chatInfo => 'Eolas comhrá';

  @override
  String get mute => 'MuteName';

  @override
  String membersInfo(Object count) {
    return 'Baill ($count)';
  }

  @override
  String get members => 'Baill';

  @override
  String get media => 'Na Meáin';

  @override
  String get files => 'Comhaid';

  @override
  String get links => 'Naisc';

  @override
  String get downloads => 'Íoslódálacha';

  @override
  String get downloadImageSuccess => 'Íomhá sábháilte i bPictiúir';

  @override
  String get downloadImageError => 'Earráid agus íomhá á sábháil';

  @override
  String downloadFileInWeb(Object directory) {
    return 'Comhad sábháilte go $directory';
  }

  @override
  String get notInAChatYet => 'Níl tú i gcomhrá go fóill';

  @override
  String get blankChatTitle =>
      'Roghnaigh comhrá nó buail #EditIcon# chun ceann a dhéanamh.';

  @override
  String get errorPageTitle => 'Níl rud éigin ceart';

  @override
  String get errorPageDescription => 'Níl an leathanach sin ann.';

  @override
  String get errorPageButton => 'Ar ais chun comhrá a dhéanamh';

  @override
  String get playVideo => 'Seinn';

  @override
  String get done => 'Déanta';

  @override
  String get markThisChatAsRead => 'Marcáil an comhrá seo mar léamh';

  @override
  String get markThisChatAsUnRead => 'Marcáil an comhrá seo gan léamh';

  @override
  String get muteThisChat => 'Mute an comhrá seo';

  @override
  String get unmuteThisChat => 'Unmute an comhrá seo';

  @override
  String get read => 'Léigh';

  @override
  String get unread => 'Gan léamh';

  @override
  String get unmute => 'UnmuteGenericName';

  @override
  String get privacyAndSecurity => 'Príobháideacht & Slándáil';

  @override
  String get notificationAndSounds => 'Fógra & Fuaimeanna';

  @override
  String get appLanguage => 'Teanga na hAipe';

  @override
  String get chatFolders => 'Fillteáin Chomhrá';

  @override
  String get displayName => 'Taispeáin Ainm';

  @override
  String get bio => 'Bith (roghnach)';

  @override
  String get matrixId => 'Aitheantas maitríse';

  @override
  String get email => 'Ríomhphost';

  @override
  String get company => 'Cuideachta';

  @override
  String get basicInfo => 'EOLAS BUNÚSACH';

  @override
  String get editProfileDescriptions =>
      'Nuashonraigh do phróifíl le hainm nua, pictiúr agus réamhrá gearr.';

  @override
  String get workIdentitiesInfo => 'EOLAS FAOI CHÉANNACHTAÍ OIBRE';

  @override
  String get editWorkIdentitiesDescriptions =>
      'Cuir do shocruithe aitheantais oibre in eagar, mar shampla Matrix ID, ríomhphost nó ainm cuideachta.';

  @override
  String get copiedMatrixIdToClipboard =>
      'Cóipeáladh Aitheantas Maitríse go dtí an ghearrthaisce.';

  @override
  String get changeProfileAvatar => 'Athraigh avatar próifíle';

  @override
  String countPinChat(Object countPinChat) {
    return 'COMHRÁITE PINNED ($countPinChat)';
  }

  @override
  String countAllChat(Object countAllChat) {
    return 'GACH COMHRÁ ($countAllChat)';
  }

  @override
  String get thisMessageHasBeenEncrypted =>
      'Tá an teachtaireacht seo criptithe';

  @override
  String get roomCreationFailed => 'Theip ar chruthú an tseomra';

  @override
  String get errorGettingPdf => 'Earráid agus PDF á fháil';

  @override
  String get errorPreviewingFile =>
      'Earráid agus comhad réamhamhairc á réamhamharc';

  @override
  String get paste => 'Greamaigh';

  @override
  String get cut => 'Gearr';

  @override
  String get pasteImageFailed => 'Theip ar ghreamú na híomhá';

  @override
  String get copyImageFailed => 'Theip ar chóip na híomhá';

  @override
  String get fileFormatNotSupported => 'Ní thacaítear le formáid comhaid';

  @override
  String get noResultsFound => 'Níor aimsíodh aon torthaí';

  @override
  String get encryptionMessage =>
      'Cosnaíonn an ghné seo do theachtaireachtaí ó bheith á léamh ag daoine eile, ach cuireann sé cosc orthu tacaíocht a fháil ar ár bhfreastalaithe. Ní féidir leat é seo a dhíchumasú níos déanaí.';

  @override
  String get encryptionWarning =>
      'D\'fhéadfá do theachtaireachtaí a chailleadh má fhaigheann tú rochtain ar aip Twake ar an ngléas eile.';

  @override
  String get selectedUsers => 'Úsáideoirí roghnaithe';

  @override
  String get clearAllSelected => 'Glan gach rud roghnaithe';

  @override
  String get newDirectMessage => 'Teachtaireacht dhíreach nua';

  @override
  String get contactInfo => 'Sonraí teagmhála';

  @override
  String countPinnedMessage(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Teachtaireacht Phionnáilte #$count',
      zero: 'Teachtaireacht Pionnáilte',
    );
    return '$_temp0';
  }

  @override
  String pinnedMessages(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Teachtaireachtaí Pionáilte',
      one: '1 Teachtaireacht Pionáilte',
    );
    return '$_temp0';
  }

  @override
  String get copyImageSuccess => 'Cóipeáladh an íomhá go dtí an ghearrthaisce';

  @override
  String get youNeedToAcceptTheInvitation =>
      'Ní mór duit glacadh leis an gcuireadh chun tús a chur le comhrá';

  @override
  String get hasInvitedYouToAChat =>
      ' thug sé cuireadh duit comhrá a dhéanamh. Glac leis an gcomhrá nó diúltaigh dó agus scrios é?';

  @override
  String get declineTheInvitation => 'Diúltaigh don chuireadh?';

  @override
  String get doYouReallyWantToDeclineThisInvitation =>
      'An bhfuil tú cinnte gur mian leat an cuireadh seo a dhiúltú agus an comhrá a bhaint? Ní bheidh tú in ann an gníomh seo a chealú.';

  @override
  String get declineAndRemove => 'Meath agus bain';

  @override
  String get notNow => 'Ní anois';

  @override
  String get contactsWarningBannerTitle =>
      'Chun a chinntiú gur féidir leat teagmháil a dhéanamh le do chairde go léir, lig do Twake rochtain a fháil ar theagmhálacha do ghléis. Is mór againn do thuiscint.';

  @override
  String contactsCount(Object count) {
    return 'Teagmhálacha ($count)';
  }

  @override
  String linagoraContactsCount(Object count) {
    return 'Teagmhálacha Linagora ($count)';
  }

  @override
  String fetchingPhonebookContacts(Object progress) {
    return 'Teagmhálacha á bhfáil ón ngléas... ($progress% críochnaithe)';
  }

  @override
  String get languageEnglish => 'Béarla';

  @override
  String get languageVietnamese => 'Vítneaimis';

  @override
  String get languageFrench => 'Fraincis';

  @override
  String get languageRussian => 'Rúisis';

  @override
  String get settingsLanguageDescription =>
      'Socraigh an teanga a úsáideann tú ar Twake Chat';

  @override
  String sendImages(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Send $count images',
      one: 'Seol 1 image',
    );
    return '$_temp0';
  }

  @override
  String get enterCaption => 'Cuir fotheideal leis...';

  @override
  String get failToSend => 'Theip ar sheoladh, bain triail eile as';

  @override
  String get showLess => 'Taispeáin Níos Lú';

  @override
  String get showMore => 'Taispeáin Níos Mó';

  @override
  String get unreadMessages => 'Teachtaireachtaí gan léamh';

  @override
  String get groupInformation => 'Faisnéis ghrúpa';

  @override
  String get linkInvite => 'Cuireadh nasc';

  @override
  String get noDescription => 'Gan tuairisc';

  @override
  String get description => 'Cur síos';

  @override
  String get groupName => 'Ainm an ghrúpa';

  @override
  String get descriptionHelper =>
      'Is féidir leat cur síos roghnach a sholáthar le do ghrúpa.';

  @override
  String get groupNameCannotBeEmpty =>
      'Ní féidir ainm an ghrúpa a bheith folamh';

  @override
  String get unpinAllMessages => 'Díphionnáil gach teachtaireacht';

  @override
  String get pinnedMessagesTooltip => 'Teachtaireachtaí pinned';

  @override
  String get jumpToMessage => 'Léim go teachtaireacht';

  @override
  String get failedToUnpin => 'Níorbh fhéidir teachtaireacht a dhíphionnáil';

  @override
  String get welcomeTo => 'Fáilte go dtí';

  @override
  String get descriptionWelcomeTo =>
      'teachtaire foinse oscailte bunaithe ar\nprótacal maitríse, a ligeann duit\ncriptigh do shonraí';

  @override
  String get startMessaging => 'Tosaigh teachtaireachtaí';

  @override
  String get signIn => 'Sínigh isteach';

  @override
  String get createTwakeId => 'Cruthaigh Aitheantas Twake';

  @override
  String get useYourCompanyServer => 'Bain úsáid as do fhreastalaí cuideachta';

  @override
  String get descriptionTwakeId =>
      'Criptigh teachtaire foinse oscailte\ndo shonraí le prótacal maitrís';

  @override
  String countFilesSendPerDialog(Object count) {
    return 'Is é $count na comhaid uasta agus iad á seoladh.';
  }

  @override
  String sendFiles(Object count) {
    return 'Seol comhaid $count';
  }

  @override
  String get addAnotherAccount => 'Cuir cuntas eile leis';

  @override
  String get accountSettings => 'Socruithe cuntais';

  @override
  String get failedToSendFiles => 'Theip ar chomhaid a sheoladh';

  @override
  String get noResults => 'Gan Torthaí';

  @override
  String get isSingleAccountOnHomeserver =>
      'Ní thacaímid go fóill le cuntais iolracha ar fhreastalaí baile amháin';

  @override
  String messageSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Teachtaireachtaí',
      one: '1 Teachtaireacht',
      zero: 'No Messages',
    );
    return '$_temp0 roghnaithe';
  }

  @override
  String draftChatHookPhrase(String user) {
    return 'Dia duit $user! Ba mhaith liom comhrá a dhéanamh leat.';
  }

  @override
  String get twakeChatUser => 'Úsáideoir Comhrá Twake';

  @override
  String get sharedMediaAndLinks => 'Meáin chomhroinnte agus naisc';

  @override
  String get errorSendingFiles =>
      'Ní féidir roinnt comhad a sheoladh mar gheall ar mhéid, srianta formáide, nó earráidí gan choinne. Fágfar ar lár iad.';

  @override
  String get removeFileBeforeSend => 'Bain comhaid earráide roimh sheoladh';

  @override
  String get unselect => 'Díroghnaigh';

  @override
  String get searchContacts => 'Cuardaigh teagmhálacha';

  @override
  String get tapToAllowAccessToYourMicrophone =>
      'Is féidir leat rochtain micreafóin a chumasú san aip Socruithe chun guth a dhéanamh i';

  @override
  String get showInChat => 'Taispeáin i gcomhrá';

  @override
  String get phone => 'Fón';

  @override
  String get viewProfile => 'Amharc ar an bpróifíl';

  @override
  String get profileInfo => 'Faisnéis phróifíle';

  @override
  String get saveToDownloads => 'Sábháil go hÍosluchtuithe';

  @override
  String get saveToGallery => 'Sábháil go Gailearaí';

  @override
  String get fileSavedToDownloads => 'Sábháladh an comhad le hÍosluchtuithe';

  @override
  String get saveFileToDownloadsError =>
      'Theip ar shábháil an chomhaid le hÍosluchtuithe';

  @override
  String explainPermissionToDownloadFiles(String appName) {
    return 'Chun leanúint ar aghaidh, lig do $appName rochtain a fháil ar chead stórála. Tá an cead seo riachtanach chun comhad a shábháil ar an bhfillteán Íoslódálacha.';
  }

  @override
  String get explainPermissionToAccessContacts =>
      'NÍ Twake Comhrá a bhailiú do teagmhálacha. Ní sheolann Twake Chat ach hashes teagmhála chuig freastalaithe Comhrá Twake chun tuiscint a fháil ar cé ó do chairde a chuaigh isteach i Twake Chat cheana féin, rud a chumasaíonn nasc leo. NÍL do theagmhálaithe sioncronaithe lenár bhfreastalaí.';

  @override
  String get explainPermissionToAccessMedias =>
      'Ní dhéanann Twake Chat sonraí a shioncronú idir do ghléas agus ár bhfreastalaithe. Ní stórálaimid ach na meáin a sheol tú chuig an seomra comhrá. Déantar gach comhad meán a sheoltar chuig comhrá a chriptiú agus a stóráil go slán. Téigh go Socruithe > Ceadanna agus gníomhachtaigh an cead Stóráil: Grianghraif agus Físeáin. Is féidir leat rochtain ar do leabharlann meán a dhiúltú am ar bith freisin.';

  @override
  String get explainPermissionToAccessPhotos =>
      'Ní dhéanann Twake Chat sonraí a shioncronú idir do ghléas agus ár bhfreastalaithe. Ní stórálaimid ach na meáin a sheol tú chuig an seomra comhrá. Déantar gach comhad meán a sheoltar chuig comhrá a chriptiú agus a stóráil go slán. Téigh go Socruithe > Ceadanna agus gníomhachtaigh an cead Stóráil: Grianghraif. Is féidir leat rochtain ar do leabharlann meán a dhiúltú am ar bith freisin.';

  @override
  String get explainPermissionToAccessVideos =>
      'Ní dhéanann Twake Chat sonraí a shioncronú idir do ghléas agus ár bhfreastalaithe. Ní stórálaimid ach na meáin a sheol tú chuig an seomra comhrá. Déantar gach comhad meán a sheoltar chuig comhrá a chriptiú agus a stóráil go slán. Téigh go Socruithe > Ceadanna agus gníomhachtaigh an cead Stóráil: Físeáin. Is féidir leat rochtain ar do leabharlann meán a dhiúltú am ar bith freisin.';

  @override
  String get downloading => 'Á Íosluchtú';

  @override
  String get settingUpYourTwake =>
      'Do Twake a bhunú\nD\'fhéadfadh sé tamall a thógáil';

  @override
  String get performingAutomaticalLogin =>
      'Logáil isteach uathoibríoch a dhéanamh trí SSO';

  @override
  String get backingUpYourMessage =>
      'Timpeallacht freastalaí a ullmhú chun tacú le do theachtaireachtaí';

  @override
  String get recoveringYourEncryptedChats =>
      'Do chomhráite criptithe a aisghabháil';

  @override
  String get configureDataEncryption => 'Cumraigh criptiú sonraí';

  @override
  String get configurationNotFound => 'Níor aimsíodh na sonraí cumraíochta';

  @override
  String get fileSavedToGallery => 'Sábháladh an comhad sa Ghailearaí';

  @override
  String get saveFileToGalleryError =>
      'Theip ar shábháil an chomhaid sa Ghailearaí';

  @override
  String explainPermissionToGallery(String appName) {
    return 'Chun leanúint ar aghaidh, ceadaigh $appName chun cead grianghraf a rochtain. Tá an cead seo riachtanach chun comhad a shábháil chuig an ngailearaí.';
  }

  @override
  String get tokenNotFound => 'Níor aimsíodh an comhartha logála isteach';

  @override
  String get dangerZone => 'Crios contúirte';

  @override
  String get leaveGroupSubtitle =>
      'Fanfaidh an grúpa seo fós tar éis duit imeacht';

  @override
  String get leaveChatFailed => 'Theip ar an gcomhrá a fhágáil';

  @override
  String get invalidLoginToken => 'Comhartha logála isteach neamhbhailí';

  @override
  String get copiedPublicKeyToClipboard =>
      'Cóipeáladh eochair phoiblí go dtí an ghearrthaisce.';

  @override
  String get removeFromGroup => 'Bain ó ghrúpa';

  @override
  String get removeUser => 'Bain Úsáideoir';

  @override
  String removeReason(Object user) {
    return 'Bain $user ón ngrúpa';
  }

  @override
  String get switchAccounts => 'Athraigh cuntais';

  @override
  String get selectAccount => 'Roghnaigh cuntas';

  @override
  String get privacyPolicy => 'Polasaí Príobháideachais';

  @override
  String get byContinuingYourAgreeingToOur =>
      'Trí leanúint ar aghaidh, tá tú ag aontú lenár';

  @override
  String get youDontHaveAnyContactsYet => 'Níl aon teagmháil agat go fóill.';

  @override
  String get loading => 'Á Luchtú...';

  @override
  String get errorDialogTitle => 'Oops, chuaigh rud éigin mícheart';

  @override
  String get shootingTips => 'Tapáil chun grianghraf a ghlacadh.';

  @override
  String get shootingWithRecordingTips =>
      'Tapáil chun grianghraf a ghlacadh. Preas fada chun físeán a thaifeadadh.';

  @override
  String get shootingOnlyRecordingTips =>
      'Preas fada chun físeán a thaifeadadh.';

  @override
  String get shootingTapRecordingTips => 'Tapáil chun físeán a thaifeadadh.';

  @override
  String get loadFailed => 'Theip ar luchtú';

  @override
  String get saving => 'Ag sábháil...';

  @override
  String get sActionManuallyFocusHint => 'Fócas de láimh';

  @override
  String get sActionPreviewHint => 'Réamhamharc';

  @override
  String get sActionRecordHint => 'Taifead';

  @override
  String get sActionShootHint => 'Tóg pictiúr';

  @override
  String get sActionShootingButtonTooltip => 'Cnaipe lámhach';

  @override
  String get sActionStopRecordingHint => 'Stop an taifeadadh';

  @override
  String sCameraLensDirectionLabel(Object value) {
    return 'Treo lionsa an cheamara: $value';
  }

  @override
  String sCameraPreviewLabel(Object value) {
    return 'Réamhamharc ceamara: $value';
  }

  @override
  String sFlashModeLabel(Object mode) {
    return 'Mód flash: $mode';
  }

  @override
  String sSwitchCameraLensDirectionLabel(Object value) {
    return 'Athraigh go dtí an ceamara $value';
  }

  @override
  String get photo => 'Grianghraf';

  @override
  String get video => 'Físeán';

  @override
  String get message => 'Teachtaireacht';

  @override
  String fileTooBig(int maxSize) {
    return 'Tá an comhad roghnaithe rómhór. Roghnaigh comhad níos lú ná $maxSize MB.';
  }

  @override
  String get enable_notifications => 'Cumasaigh fógraí';

  @override
  String get disable_notifications => 'Díchumasaigh fógraí';

  @override
  String get logoutDialogWarning =>
      'Caillfidh tú rochtain ar theachtaireachtaí criptithe. Molaimid duit cúltacaí comhrá a chumasú sula logálann tú amach';

  @override
  String get copyNumber => 'Cóipeáil uimhir';

  @override
  String get callViaCarrier => 'Glaoigh trí Iompróir';

  @override
  String get scanQrCodeToJoin =>
      'Má shuiteáiltear an feidhmchlár móibíleach, beidh tú in ann teagmháil a dhéanamh le daoine ó leabhar seoltaí d\'fhóin, déanfar do chomhráite a shioncrónú idir gléasanna';

  @override
  String get thisFieldCannotBeBlank =>
      'Ní féidir leis an réimse seo a bheith bán';

  @override
  String get phoneNumberCopiedToClipboard =>
      'Cóipeáladh an uimhir theileafóin chuig an ngearrthaisce';

  @override
  String get deleteAccountMessage =>
      'Fanfaidh comhráite grúpaí a chruthaigh tú gan riar ach amháin má thug tú cearta úsáideora eile do riarthóir. Beidh stair teachtaireachtaí fós ag úsáideoirí leat. Ní chuideoidh scriosadh an chuntais.';

  @override
  String get deleteLater => 'Scrios níos déanaí';

  @override
  String get areYouSureYouWantToDeleteAccount =>
      'An bhfuil tú cinnte gur mhaith leat an cuntas a scriosadh?';

  @override
  String get textCopiedToClipboard =>
      'Cóipeáladh an téacs chuig an ngearrthaisce';

  @override
  String get selectAnEmailOrPhoneYouWantSendTheInvitationTo =>
      'Roghnaigh ríomhphost nó guthán ar mhaith leat an cuireadh a sheoladh chuige';

  @override
  String get phoneNumber => 'Uimhir theileafóin';

  @override
  String get sendInvitation => 'Seol cuireadh';

  @override
  String get verifyWithAnotherDevice => 'Fíoraigh le gléas eile';

  @override
  String get contactLookupFailed => 'Theip ar chuardach teagmhála.';

  @override
  String get invitationHasBeenSuccessfullySent =>
      'Tá an cuireadh seolta go rathúil!';

  @override
  String get failedToSendInvitation => 'Theip ar an gcuireadh a sheoladh.';

  @override
  String get invalidPhoneNumber => 'Uimhir theileafóin neamhbhailí';

  @override
  String get invalidEmail => 'Ríomhphost neamhbhailí';

  @override
  String get shareInvitationLink => 'Roinn nasc an chuireadh';

  @override
  String get failedToGenerateInvitationLink =>
      'Theip ar nasc cuireadh a ghiniúint.';

  @override
  String get youAlreadySentAnInvitationToThisContact =>
      'Chuir tú cuireadh chuig an teagmhálaí seo cheana féin';

  @override
  String get selectedEmailWillReceiveAnInvitationLinkAndInstructions =>
      'Gheobhaidh an ríomhphost roghnaithe nasc cuireadh agus treoracha.';

  @override
  String get selectedNumberWillGetAnSMSWithAnInvitationLinkAndInstructions =>
      'Gheobhaidh an uimhir roghnaithe SMS le nasc cuireadh agus treoracha.';

  @override
  String get reaction => 'Imoibriú';

  @override
  String get noChatPermissionMessage =>
      'Níl cead agat teachtaireachtaí a sheoladh sa chomhrá seo.';

  @override
  String get administration => 'Riarachán';

  @override
  String get yourDataIsEncryptedForSecurity =>
      'Tá do shonraí criptithe ar mhaithe le slándáil';

  @override
  String get failedToDeleteMessage => 'Theip ar an teachtaireacht a scriosadh.';

  @override
  String get noDeletePermissionMessage =>
      'Níl cead agat an teachtaireacht seo a scriosadh.';

  @override
  String get edited => 'curtha in eagar';

  @override
  String get editMessage => 'Cuir teachtaireacht in eagar';

  @override
  String get assignRoles => 'Sannadh róil';

  @override
  String get permissions => 'Ceadanna';

  @override
  String adminsOfTheGroup(Object number) {
    return 'RIARTHÓIRÍ AN GHRÚPA ($number)';
  }

  @override
  String get addAdminsOrModerators => 'Cuir Riarthóirí/Modhnóirí leis';

  @override
  String get member => 'Ball';

  @override
  String get guest => 'Aoi';

  @override
  String get exceptions => 'Eisceachtaí';

  @override
  String get readOnly => 'Léamh amháin';

  @override
  String readOnlyCount(Object number) {
    return 'LÉIGH AMHÁIN ($number)';
  }

  @override
  String get removedUsers => 'Úsáideoirí Bainte';

  @override
  String bannedUsersCount(Object number) {
    return 'ÚSÁIDEOIRÍ COSCTHA ($number)';
  }

  @override
  String get downgradeToReadOnly => 'Íosghrádú go léamh amháin';

  @override
  String memberOfTheGroup(Object number) {
    return 'COMHALTAÍ AN GHRÚPA ($number)';
  }

  @override
  String get selectRole => 'Roghnaigh ról';

  @override
  String get canReadMessages => 'Is féidir teachtaireachtaí a léamh';

  @override
  String get canWriteMessagesSendReacts =>
      'Is féidir teachtaireachtaí a scríobh, imoibrithe a sheoladh...';

  @override
  String get canRemoveUsersDeleteMessages =>
      'Is féidir úsáideoirí a bhaint, teachtaireachtaí a scriosadh...';

  @override
  String get canAccessAllFeaturesAndSettings =>
      'Is féidir rochtain a fháil ar gach gné agus socrú';

  @override
  String get invitePeopleToTheRoom =>
      'Tabhair cuireadh do dhaoine chuig an seomra';

  @override
  String get sendReactions => 'Seol imoibrithe';

  @override
  String get deleteMessagesSentByMe => 'Scrios teachtaireachtaí a sheol mé';

  @override
  String get notifyEveryoneUsingRoom =>
      'Cuir gach duine ar an eolas ag baint úsáide as @room';

  @override
  String get joinCall => 'Glac páirt sa Ghlao';

  @override
  String get removeMembers => 'Bain baill';

  @override
  String get deleteMessagesSentByOthers =>
      'Scrios teachtaireachtaí a sheol daoine eile';

  @override
  String get pinMessageForEveryone =>
      'Teachtaireacht a phionáil (do gach duine)';

  @override
  String get startCall => 'Tosaigh Glao';

  @override
  String get changeGroupName => 'Athrú ainm grúpa';

  @override
  String get changeGroupDescription => 'Athraigh cur síos an ghrúpa';

  @override
  String get changeGroupAvatar => 'Athraigh avatar an ghrúpa';

  @override
  String get changeGroupHistoryVisibility =>
      'Athraigh infheictheacht stair an ghrúpa';

  @override
  String get searchGroupMembers => 'Cuardaigh baill an ghrúpa';

  @override
  String get permissionErrorChangeRole =>
      'Níl na cearta agat róil a athrú. Téigh i dteagmháil le do riarthóir le haghaidh cabhrach';

  @override
  String get demoteAdminsModerators => 'Ísligh Riarthóirí/Modhnóirí';

  @override
  String get deleteMessageConfirmationTitle =>
      'An bhfuil tú cinnte gur mian leat an teachtaireacht seo a scriosadh?';

  @override
  String get permissionErrorBanUser =>
      'Níl na cearta agat úsáideoirí a thoirmeasc. Téigh i dteagmháil le do riarthóir le haghaidh cabhrach';

  @override
  String get removeMember => 'Bain ball';

  @override
  String get removeMemberSelectionError =>
      'Ní féidir leat ball a scriosadh a bhfuil ról aige atá cothrom le do ról féin nó níos mó ná do ról féin.';

  @override
  String get downgrade => 'Íosghrádú';

  @override
  String get deletedMessage => 'Teachtaireacht scriosta';

  @override
  String get unban => 'Díchosc';

  @override
  String get permissionErrorUnbanUser =>
      'Níl na cearta agat cosc a chur ar úsáideoirí. Téigh i dteagmháil le do riarthóir le haghaidh cabhrach';

  @override
  String get transferOwnership => 'Aistrigh úinéireacht';

  @override
  String confirmTransferOwnership(Object name) {
    return 'An bhfuil tú cinnte gur mian leat úinéireacht an ghrúpa seo a aistriú chuig $name?';
  }

  @override
  String get transferOwnershipDescription =>
      'Gheobhaidh an t-úsáideoir seo smacht iomlán ar an ngrúpa agus ní bheidh cearta bainistíochta iomlána agat a thuilleadh. Ní féidir an gníomh seo a aisiompú.';

  @override
  String get confirmTransfer => 'Deimhnigh an tAistriú';

  @override
  String get unblockUser => 'Díbhlocáil Úsáideora';

  @override
  String get blockUser => 'Úsáideoir Blocáilte';

  @override
  String get permissionErrorUnblockUser =>
      'Níl na cearta agat an t-úsáideoir a dhíbhlocáil.';

  @override
  String get permissionErrorBlockUser =>
      'Níl na cearta agat an t-úsáideoir a bhlocáil.';

  @override
  String userIsNotAValidMxid(Object mxid) {
    return 'Ní ID Maitrís bailí é $mxid';
  }

  @override
  String userNotFoundInIgnoreList(Object mxid) {
    return 'Ní bhfuarthas $mxid i do liosta neamhaird';
  }

  @override
  String get blockedUsers => 'Úsáideoirí Blocáilte';

  @override
  String unblockUsername(Object name) {
    return 'Díbhlocáil $name';
  }

  @override
  String get unblock => 'Díbhlocáil';

  @override
  String get unblockDescriptionDialog =>
      'Beidh an duine seo in ann teachtaireachtaí a sheoladh chugat agus a fheiceáil cathain a bheidh tú ar líne. Ní chuirfear ar an eolas iad gur dhíbhlocáil tú iad.';

  @override
  String get report => 'Tuairisc';

  @override
  String get reportDesc => 'Cad é an fhadhb leis an teachtaireacht seo?';

  @override
  String get sendReport => 'Seol Tuarascáil';

  @override
  String get addComment => 'Cuir trácht leis';

  @override
  String get spam => 'Turscar';

  @override
  String get violence => 'Foréigean';

  @override
  String get childAbuse => 'Mí-úsáid leanaí';

  @override
  String get pornography => 'Pornagrafaíocht';

  @override
  String get copyrightInfringement => 'Sárú cóipchirt';

  @override
  String get terrorism => 'Sceimhlitheoireacht';

  @override
  String get other => 'Eile';

  @override
  String get enableRightAndLeftMessageAlignment =>
      'Cumasaigh ailíniú teachtaireachta ar dheis/ar chlé';

  @override
  String get holdToRecordAudio => 'Coinnigh síos chun fuaim a thaifeadadh.';

  @override
  String get explainPermissionToAccessMicrophone =>
      'Chun teachtaireachtaí gutha a sheoladh, lig do Twake Chat rochtain a fháil ar an micreafón.';

  @override
  String get allowMicrophoneAccess => 'Ceadaigh rochtain micreafóin';

  @override
  String get later => 'Níos déanaí';

  @override
  String get couldNotPlayAudioFile =>
      'Níorbh fhéidir an comhad fuaime a sheinm';

  @override
  String get slideToCancel => 'Sleamhnaigh chun cealú';

  @override
  String get recordingInProgress => 'Taifeadadh ar siúl';

  @override
  String get pleaseFinishOrStopTheRecording =>
      'Críochnaigh nó stop an taifeadadh sula ndéanann tú gníomhartha eile.';

  @override
  String get audioMessageFailedToSend =>
      'Theip ar an teachtaireacht fuaime a sheoladh.';
}
