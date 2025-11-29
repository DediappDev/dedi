import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class L10nHr extends L10n {
  L10nHr([String locale = 'hr']) : super(locale);

  @override
  String get passwordsDoNotMatch => 'Lozinke se ne poklapaju!';

  @override
  String get pleaseEnterValidEmail => 'Upiši valjanu e-mail adresu.';

  @override
  String get repeatPassword => 'Ponovi lozinku';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Odaberi barem $min znakova.';
  }

  @override
  String get about => 'Informacije';

  @override
  String get updateAvailable => 'Dostupna je nova FluffyChat verzija';

  @override
  String get updateNow => 'Pokreni aktuliziranje u pozadini';

  @override
  String get accept => 'Prihvati';

  @override
  String acceptedTheInvitation(Object username) {
    return '$username je prihvatio/la poziv';
  }

  @override
  String get account => 'Račun';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '$username je aktivirao/la obostrano šifriranje';
  }

  @override
  String get addEmail => 'Dodaj e-mail';

  @override
  String get confirmMatrixId =>
      'Please confirm your Matrix ID in order to delete your account.';

  @override
  String supposedMxid(Object mxid) {
    return 'This should be $mxid';
  }

  @override
  String get addGroupDescription => 'Dodaj opis grupe';

  @override
  String get addToSpace => 'Dodaj u prostor';

  @override
  String get admin => 'Administrator';

  @override
  String get alias => 'pseudonim';

  @override
  String get all => 'Svi';

  @override
  String get allChats => 'Svi chatovi';

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
    return '$senderName je odgovorio/la na poziv';
  }

  @override
  String get anyoneCanJoin => 'Svatko se može pridružiti';

  @override
  String get appLock => 'Zaključavanje programa';

  @override
  String get archive => 'Arhiv';

  @override
  String get archivedRoom => 'Arhivirana soba';

  @override
  String get areGuestsAllowedToJoin => 'Smiju li se gosti pridružiti';

  @override
  String get areYouSure => 'Stvarno to želiš?';

  @override
  String get areYouSureYouWantToLogout => 'Stvarno se želiš odjaviti?';

  @override
  String get askSSSSSign =>
      'Za potpisivanje druge osobe, upiši svoju sigurnosnu lozinku ili ključ za oporavak.';

  @override
  String askVerificationRequest(Object username) {
    return 'Prihvatiti ovaj zahtjev za potvrđivanje od $username?';
  }

  @override
  String get autoplayImages =>
      'Automatski pokreni animirane naljepnice i emotikone';

  @override
  String badServerLoginTypesException(Object serverVersions,
      Object supportedVersions, Object suportedVersions) {
    return 'Domaći poslužitelj podržava vrste prijave:\n$serverVersions\nMeđutim ovaj program podržava samo:\n$supportedVersions';
  }

  @override
  String get sendOnEnter => 'Pošalji pritiskom tipke enter';

  @override
  String badServerVersionsException(Object serverVersions,
      Object supportedVersions, Object serverVerions, Object suportedVersions) {
    return 'Domaći poslužitelj podržava verzije specifikacije:\n$serverVersions\nMeđutim ovaj program podržava samo $supportedVersions';
  }

  @override
  String get banFromChat => 'Isključi iz chata';

  @override
  String get banned => 'Isključen';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username je isključio/la $targetName';
  }

  @override
  String get blockDevice => 'Blokiraj uređaj';

  @override
  String get blocked => 'Blokirano';

  @override
  String get botMessages => 'Poruke bota';

  @override
  String get bubbleSize => 'Veličina mjehurića';

  @override
  String get cancel => 'Odustani';

  @override
  String cantOpenUri(Object uri) {
    return 'URI adresa $uri se ne može otvoriti';
  }

  @override
  String get changeDeviceName => 'Promijeni ime uređaja';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username je promijenio/la avatar chata';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username je promijenio/la opis razgovora u: „$description”';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username je promijenio/la ime razgovora u: „$chatname”';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username je promijenio/la dozvole chata';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username je promijenio/la ime u: „$displayname”';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username je promijenio/la pravila pristupa za goste';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username je promijenio/la pravila pristupa za goste u: $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username je promijenio/la vidljivost kronologije';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username je promijenio/la vidljivost kronologije u: $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username je promijenio/la pravila pridruživanja';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username je promijenio/la pravila pridruživanja u: $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username je promijenio/la svoj avatar';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username je promijenio/la pseudonime soba';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username je promijenio/la poveznicu poziva';
  }

  @override
  String get changePassword => 'Promijeni lozinku';

  @override
  String get changeTheHomeserver => 'Promijeni domaćeg poslužitelja';

  @override
  String get changeTheme => 'Promijeni tvoj stil';

  @override
  String get changeTheNameOfTheGroup => 'Promijeni ime grupe';

  @override
  String get changeWallpaper => 'Promijeni sliku pozadine';

  @override
  String get changeYourAvatar => 'Promijeni svoj avatar';

  @override
  String get channelCorruptedDecryptError => 'Šifriranje je oštećeno';

  @override
  String get chat => 'Chat';

  @override
  String get yourUserId => 'Tvoj korisnički ID:';

  @override
  String get yourChatBackupHasBeenSetUp =>
      'Sigurnosna kopija tvog chata je postavljena.';

  @override
  String get chatBackup => 'Sigurnosna kopija chata';

  @override
  String get chatBackupDescription =>
      'Sigurnosna kopija chata osigurana je ključem za obnavljanje. Pazi da ga ne izgubiš.';

  @override
  String get chatDetails => 'Detalji chata';

  @override
  String get chatHasBeenAddedToThisSpace => 'Chat je dodan u ovaj prostor';

  @override
  String get chats => 'Chatovi';

  @override
  String get chooseAStrongPassword => 'Odaberi snažnu lozinku';

  @override
  String get chooseAUsername => 'Odaberi korisničko ime';

  @override
  String get clearArchive => 'Isprazni arhiv';

  @override
  String get close => 'Zatvori';

  @override
  String get commandHint_markasdm => 'Mark as direct chat';

  @override
  String get commandHint_markasgroup => 'Mark as chat';

  @override
  String get commandHint_ban => 'Isključi korisnika iz ove sobe';

  @override
  String get commandHint_clearcache => 'Isprazni predmemoriju';

  @override
  String get commandHint_create =>
      'Stvori prazan grupni chat\nKoristi --no-encryption za deaktiviranje šifriranja';

  @override
  String get commandHint_discardsession => 'Odbaci sesiju';

  @override
  String get commandHint_dm =>
      'Započni izravni chat\nKoristi --no-encryption za deaktiviranje šifriranja';

  @override
  String get commandHint_html => 'Pošalji HTML formatirani tekst';

  @override
  String get commandHint_invite => 'Pozovi korisnika u ovu sobu';

  @override
  String get commandHint_join => 'Pridruži se zadanoj sobi';

  @override
  String get commandHint_kick => 'Ukloni korisnika iz ove sobe';

  @override
  String get commandHint_leave => 'Napusti ovu sobu';

  @override
  String get commandHint_me => 'Opiši se';

  @override
  String get commandHint_myroomavatar => 'Postavi svoju sliku za ovu sobu';

  @override
  String get commandHint_myroomnick => 'Postavi svoje ime za ovu sobu';

  @override
  String get commandHint_op =>
      'Postavi razinu prava zadanog korisnika (standardno: 50)';

  @override
  String get commandHint_plain => 'Pošalji neformatirani tekst';

  @override
  String get commandHint_react => 'Pošalji odgovor kao reakciju';

  @override
  String get commandHint_send => 'Pošalji tekst';

  @override
  String get commandHint_unban => 'Ponovo uključi korisnika u ovu sobu';

  @override
  String get commandInvalid => 'Naredba nevaljana';

  @override
  String commandMissing(Object command) {
    return '$command nije naredba.';
  }

  @override
  String get compareEmojiMatch =>
      'Usporedi i provjeri, poklapaju li se sljedeći emojiji s onima drugog uređaja:';

  @override
  String get compareNumbersMatch =>
      'Usporedi i provjeri, poklapaju li se sljedeći brojevi s onima drugog uređaja:';

  @override
  String get configureChat => 'Konfiguriraj chat';

  @override
  String get confirm => 'Potvrdi';

  @override
  String get connect => 'Spoji';

  @override
  String get contactHasBeenInvitedToTheGroup => 'Kontakt je pozvan u grupu';

  @override
  String get containsDisplayName => 'Sadržava prikazano ime';

  @override
  String get containsUserName => 'Sadrži korisničko ime';

  @override
  String get contentHasBeenReported =>
      'Sadržaj je prijavljen administratorima poslužitelja';

  @override
  String get copiedToClipboard => 'Kopirano u međuspremnik';

  @override
  String get copy => 'Kopiraj';

  @override
  String get copyToClipboard => 'Kopiraj u međuspremnik';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Neuspjelo dešifriranje poruke: $error';
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
  String get create => 'Stvori';

  @override
  String createdTheChat(Object username) {
    return '$username je stvorio/la chat';
  }

  @override
  String get createNewGroup => 'Stvori novu grupu';

  @override
  String get createNewSpace => 'Novi prostor';

  @override
  String get crossSigningEnabled => 'Unakrsno potpisivanje uključeno';

  @override
  String get currentlyActive => 'Trenutačno aktivni';

  @override
  String get darkTheme => 'Tamna';

  @override
  String dateAndTimeOfDay(Object date, Object timeOfDay) {
    return '$date, $timeOfDay';
  }

  @override
  String dateWithoutYear(Object month, Object day) {
    return '$day. $month.';
  }

  @override
  String dateWithYear(Object year, Object month, Object day) {
    return '$day. $month. $year.';
  }

  @override
  String get deactivateAccountWarning =>
      'Ovo će nepovratno deaktivirati tvoj korisnički račun. Stvarno to želiš?';

  @override
  String get defaultPermissionLevel => 'Standardna razina dozvole';

  @override
  String get delete => 'Izbriši';

  @override
  String get deleteAccount => 'Izbriši račun';

  @override
  String get deleteMessage => 'Izbriši poruku';

  @override
  String get deny => 'Odbij';

  @override
  String get device => 'Uređaj';

  @override
  String get deviceId => 'ID oznaka uređaja';

  @override
  String get devices => 'Uređaji';

  @override
  String get directChats => 'Izravni chatovi';

  @override
  String get discover => 'Otkrij';

  @override
  String get displaynameHasBeenChanged => 'Prikazno ime je promijenjeno';

  @override
  String get download => 'Download';

  @override
  String get edit => 'Uredi';

  @override
  String get editBlockedServers => 'Uredi blokirane poslužitelje';

  @override
  String get editChatPermissions => 'Uredi dozvole za chat';

  @override
  String get editDisplayname => 'Uredi prikazano ime';

  @override
  String get editRoomAliases => 'Uredi pseudonime sobe';

  @override
  String get editRoomAvatar => 'Uredi avatar sobe';

  @override
  String get emoteExists => 'Emotikon već postoji!';

  @override
  String get emoteInvalid => 'Neispravna kratica emotikona!';

  @override
  String get emotePacks => 'Paketi emotikona za sobu';

  @override
  String get emoteSettings => 'Postavke emotikona';

  @override
  String get emoteShortcode => 'Kratica emotikona';

  @override
  String get emoteWarnNeedToPick =>
      'Moraš odabrati jednu kraticu emotikona i sliku!';

  @override
  String get emptyChat => 'Prazan chat';

  @override
  String get enableEmotesGlobally => 'Aktiviraj paket emotikona globalno';

  @override
  String get enableEncryption => 'Aktiviraj šifriranje';

  @override
  String get enableEncryptionWarning =>
      'Više nećeš moći deaktivirati šifriranje. Stvarno to želiš?';

  @override
  String get encrypted => 'Šifrirano';

  @override
  String get encryption => 'Šifriranje';

  @override
  String get encryptionNotEnabled => 'Šifriranje nije aktivirano';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName je završio/la poziv';
  }

  @override
  String get enterGroupName => 'Enter chat name';

  @override
  String get enterAnEmailAddress => 'Upiši e-adressu';

  @override
  String get enterASpacepName => 'Upiši ime prostora';

  @override
  String get homeserver => 'Domaći poslužitelj';

  @override
  String get enterYourHomeserver => 'Upiši svoj domaći poslužitelj';

  @override
  String errorObtainingLocation(Object error) {
    return 'Greška u dohvaćanju lokacije: $error';
  }

  @override
  String get everythingReady => 'Sve je spremno!';

  @override
  String get extremeOffensive => 'Izrazito uvredljiv';

  @override
  String get fileName => 'Ime datoteke';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Veličina fonta';

  @override
  String get forward => 'Proslijedi';

  @override
  String get friday => 'Petak';

  @override
  String get fromJoining => 'Od pridruživanja';

  @override
  String get fromTheInvitation => 'Od poziva';

  @override
  String get goToTheNewRoom => 'Idi u novu sobu';

  @override
  String get group => 'Grupiraj';

  @override
  String get groupDescription => 'Opis grupe';

  @override
  String get groupDescriptionHasBeenChanged => 'Opis grupe promijenjen';

  @override
  String get groupIsPublic => 'Grupa je javna';

  @override
  String get groups => 'Grupe';

  @override
  String groupWith(Object displayname) {
    return 'Grupa s $displayname';
  }

  @override
  String get guestsAreForbidden => 'Gosti su zabranjeni';

  @override
  String get guestsCanJoin => 'Gosti se mogu pridružiti';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username je povukao/la poziv za $targetName';
  }

  @override
  String get help => 'Pomoć';

  @override
  String get hideRedactedEvents => 'Sakrij promijenjene događaje';

  @override
  String get hideUnknownEvents => 'Sakrij nepoznate događaje';

  @override
  String get howOffensiveIsThisContent => 'Koliko je ovaj sadržaj uvredljiv?';

  @override
  String get id => 'ID';

  @override
  String get identity => 'Identitet';

  @override
  String get ignore => 'Zanemari';

  @override
  String get ignoredUsers => 'Zanemareni korisnici';

  @override
  String get ignoreListDescription =>
      'Možeš zanemariti korisnike koji te smetaju. Nećeš moći primati poruke niti pozive u sobe od korisnika koji se nalaze u tvom osobnom popisu zanemarivanja.';

  @override
  String get ignoreUsername => 'Zanemari korisničko ime';

  @override
  String get iHaveClickedOnLink => 'Pritisnuo/la sam poveznicu';

  @override
  String get incorrectPassphraseOrKey =>
      'Neispravna lozinka ili ključ za obnavljanje';

  @override
  String get inoffensive => 'Neuvredljiv';

  @override
  String get inviteContact => 'Pozovi kontakt';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Pozovi kontakt u $groupName';
  }

  @override
  String get invited => 'Pozvan/a';

  @override
  String invitedUser(Object username, Object targetName) {
    return '$username je pozvao/la $targetName';
  }

  @override
  String get invitedUsersOnly => 'Samo pozvani korisnici';

  @override
  String get inviteForMe => 'Poziv za mene';

  @override
  String inviteText(Object username, Object link) {
    return '$username te je pozvao/la u FluffyChat. \n1. Instaliraj FluffyChat: https://fluffychat.im \n2. Registriraj ili prijavi se \n3. Otvori poveznicu poziva: $link';
  }

  @override
  String get isTyping => 'piše';

  @override
  String joinedTheChat(Object username) {
    return '$username se pridružio/la chatu';
  }

  @override
  String get joinRoom => 'Pridruži se sobi';

  @override
  String get keysCached => 'Ključevi su spremljeni u predmemoriji';

  @override
  String kicked(Object username, Object targetName) {
    return '$username je izbacio/la $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '$username je izbacio/la i isključio/la $targetName';
  }

  @override
  String get kickFromChat => 'Izbaci iz chata';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Zadnja aktivnost: $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Viđeno prije dugo vremena';

  @override
  String get leave => 'Napusti';

  @override
  String get leftTheChat => 'Napustio/la je chat';

  @override
  String get license => 'Licenca';

  @override
  String get lightTheme => 'Svjetla';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Učitaj još $count sudionika';
  }

  @override
  String get dehydrate => 'Izvezi sesiju i izbriši uređaj';

  @override
  String get dehydrateWarning =>
      'Ovo je nepovratna radnja. Spremi datoteku sigurnosne kopije na sigurno mjeto.';

  @override
  String get dehydrateShare =>
      'Ovo je tvoj privatni FluffyChat izvoz. Osiguraj da ga ne izgubiš i zadrži ga privatnim.';

  @override
  String get dehydrateTor => 'Korisnici TOR-a: izvezite sesiju';

  @override
  String get dehydrateTorLong =>
      'Korisnicima TOR-a preporučuje se izvoz sesije prije zatvaranja prozora.';

  @override
  String get hydrateTor => 'Korisnici TOR-a: Uzvezite izvoz sesije';

  @override
  String get hydrateTorLong =>
      'Je li zadnji izvoz sesije bio na TOR-u? Brzo ga uvezi i nastavi čavrljati.';

  @override
  String get hydrate => 'Obnovi pomoću sigurnosne kopije';

  @override
  String get loadingPleaseWait => 'Učitava se … Pričekaj.';

  @override
  String get loadingStatus => 'Loading status...';

  @override
  String get loadMore => 'Učitaj još …';

  @override
  String get locationDisabledNotice =>
      'Lokacijske usluge su deaktivirane. Za dijeljenje tvoje lokacije aktiviraj ih.';

  @override
  String get locationPermissionDeniedNotice =>
      'Lokacijske dozvole su odbijene. Za dijeljenje tvoje lokacije dozvoli ih.';

  @override
  String get login => 'Prijava';

  @override
  String logInTo(Object homeserver) {
    return 'Prijavi se na $homeserver';
  }

  @override
  String get loginWithOneClick => 'Prijavi se samo s jednim pritiskom';

  @override
  String get logout => 'Odjava';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Provjeri ispravnost identifikator';

  @override
  String get memberChanges => 'Promjene člana';

  @override
  String get mention => 'Spominjanje';

  @override
  String get messages => 'Poruke';

  @override
  String get messageWillBeRemovedWarning =>
      'Poruke će se ukloniti za sve sudionike';

  @override
  String get noSearchResult => 'No matching search results.';

  @override
  String get moderator => 'Voditelj';

  @override
  String get monday => 'Ponedjeljak';

  @override
  String get muteChat => 'Isključi zvuk chata';

  @override
  String get needPantalaimonWarning =>
      'Za trenutačno korištenje obostranog šifriranja trebaš Pantalaimon.';

  @override
  String get newChat => 'Novi chat';

  @override
  String get newMessageInDedi => 'You have 1 encrypted message';

  @override
  String get newVerificationRequest => 'Novi zahtjev za potvrđivanje!';

  @override
  String get noMoreResult => 'No more result!';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Dalje';

  @override
  String get no => 'Ne';

  @override
  String get noConnectionToTheServer => 'Ne postoji veza s poslužiteljem';

  @override
  String get noEmotesFound => 'Nema emotikona. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Šifriranje možeš aktivirati samo nakon što soba više nije javno dostupna.';

  @override
  String get noGoogleServicesWarning =>
      'Čini se da na mobitelu nemaš google usluge. To je dobra odluka za tvoju privatnost! Za automatsko primanje obavijesti u FluffyChatu preporučujemo koristiti https://microg.org/ or https://unifiedpush.org/.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 nije matrix poslužitelj. Da li umjesto njega koristiti $server2?';
  }

  @override
  String get shareYourInviteLink => 'Dijeli svoju poveznicu za pozivnicu';

  @override
  String get typeInInviteLinkManually => 'Upiši poveznicu za pozivnicu …';

  @override
  String get scanQrCode => 'Snimi QR kod';

  @override
  String get none => 'Ništa';

  @override
  String get noPasswordRecoveryDescription =>
      'Još nisi dodao/la način za obnavljanje lozinke.';

  @override
  String get noPermission => 'Bez dozvole';

  @override
  String get noRoomsFound => 'Nema soba …';

  @override
  String get notifications => 'Obavijesti';

  @override
  String numUsersTyping(Object count) {
    return '$count korisnika pišu';
  }

  @override
  String get obtainingLocation => 'Dohvaćanje lokacije …';

  @override
  String get offensive => 'Uvredljiv';

  @override
  String get offline => 'Nepovezano s internetom';

  @override
  String get aWhileAgo => 'a while ago';

  @override
  String get ok => 'U redu';

  @override
  String get online => 'Povezano s internetom';

  @override
  String get onlineKeyBackupEnabled =>
      'Internetski ključ sigurnosnih kopija je aktiviran';

  @override
  String get cannotEnableKeyBackup =>
      'Cannot enable Chat Backup. Please Go to Settings to try it again.';

  @override
  String get cannotUploadKey => 'Cannot store Key Backup.';

  @override
  String get oopsPushError =>
      'Ups! Nažalost se dogodila greška prilikom postavljanja automatskog primanja obavijesti.';

  @override
  String get oopsSomethingWentWrong => 'Ups, dogodila se greška …';

  @override
  String get openAppToReadMessages => 'Za čitanje poruka, otvori program';

  @override
  String get openCamera => 'Otvori kameru';

  @override
  String get openVideoCamera => 'Otvori kameru za video';

  @override
  String get oneClientLoggedOut => 'Jedan od tvojih klijenata je odjavljen';

  @override
  String get addAccount => 'Dodaj račun';

  @override
  String get editBundlesForAccount => 'Uredi pakete za ovaj račun';

  @override
  String get addToBundle => 'Dodaj u paket';

  @override
  String get removeFromBundle => 'Ukloni iz ovog paketa';

  @override
  String get bundleName => 'Ime paketa';

  @override
  String get enableMultiAccounts =>
      '(BETA) Omogući korištenje više računa na ovom uređaju';

  @override
  String get openInMaps => 'Otvori u kartama';

  @override
  String get link => 'Poveznica';

  @override
  String get serverRequiresEmail =>
      'Za registraciju ovaj poslužitelj mora potvrditi tvoju e-mail adresu.';

  @override
  String get optionalGroupName => '(Opcionalno) Ime grupe';

  @override
  String get or => 'Ili';

  @override
  String get participant => 'Sudionik';

  @override
  String get passphraseOrKey => 'tajni izraz ili ključ za obnavljanje';

  @override
  String get password => 'Lozinka';

  @override
  String get passwordForgotten => 'Zaboravljena lozinka';

  @override
  String get passwordHasBeenChanged => 'Lozinka je promijenjena';

  @override
  String get passwordRecovery => 'Obnavljanje lozinke';

  @override
  String get people => 'Ljudi';

  @override
  String get pickImage => 'Odaberi sliku';

  @override
  String get pin => 'Prikvači';

  @override
  String play(Object fileName) {
    return 'Sviraj $fileName';
  }

  @override
  String get pleaseChoose => 'Odaberi';

  @override
  String get pleaseChooseAPasscode => 'Odaberi lozinku';

  @override
  String get pleaseChooseAUsername => 'Odaberi korisničko ime';

  @override
  String get pleaseClickOnLink =>
      'Pritisni poveznicu u e-poruci, zatim nastavi.';

  @override
  String get pleaseEnter4Digits =>
      'Upiši 4 znamenke ili ostavi prazno, za deaktiviranje zaključavanja programa.';

  @override
  String get pleaseEnterAMatrixIdentifier => 'Upiši Matrix-ID.';

  @override
  String get pleaseEnterRecoveryKey => 'Upiši svoj ključ za obnavljanje:';

  @override
  String get pleaseEnterYourPassword => 'Upiši svoju lozinku';

  @override
  String get pleaseEnterYourPin => 'Upiši svoj pin';

  @override
  String get pleaseEnterYourUsername => 'Upiši svoje korisničko ime';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Slijedi upute na web-stranici i dodirni „Dalje”.';

  @override
  String get privacy => 'Privatnost';

  @override
  String get publicRooms => 'Javne sobe';

  @override
  String get pushRules => 'Pravila slanja';

  @override
  String get reason => 'Razlog';

  @override
  String get recording => 'Snimanje';

  @override
  String redactedAnEvent(Object username) {
    return '$username je preuredio/la događaj';
  }

  @override
  String get redactMessage => 'Ispravi poruku';

  @override
  String get register => 'Registracija';

  @override
  String get reject => 'Odbij';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username je odbio/la poziv';
  }

  @override
  String get rejoin => 'Ponovo se pridruži';

  @override
  String get remove => 'Ukloni';

  @override
  String get removeAllOtherDevices => 'Ukloni sve druge uređaje';

  @override
  String removedBy(Object username) {
    return 'Uklonjeno od $username';
  }

  @override
  String get removeDevice => 'Ukloni uređaj';

  @override
  String get unbanFromChat => 'Ponovo uključi u chat';

  @override
  String get removeYourAvatar => 'Ukloni svoj avatar';

  @override
  String get renderRichContent => 'Prikaži formatirani sadržaj poruke';

  @override
  String get replaceRoomWithNewerVersion => 'Zamijeni sobu s novom verzijom';

  @override
  String get reply => 'Odgovori';

  @override
  String get reportMessage => 'Prijavi poruku';

  @override
  String get requestPermission => 'Zatraži dozvolu';

  @override
  String get roomHasBeenUpgraded => 'Soba je nadograđena';

  @override
  String get roomVersion => 'Verzija sobe';

  @override
  String get saturday => 'Subota';

  @override
  String get saveFile => 'Spremi datoteku';

  @override
  String get searchForPeopleAndChannels => 'Search for people and channels';

  @override
  String get security => 'Sigurnost';

  @override
  String get recoveryKey => 'Ključ za obnavljanje';

  @override
  String get recoveryKeyLost => 'Izgubio/la si ključ za obnavljanje?';

  @override
  String seenByUser(Object username) {
    return 'Viđeno od $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Viđeno od $username i još $count korisnika',
    );
    return '$_temp0';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Viđeno od $username i $username2';
  }

  @override
  String get send => 'Pošalji';

  @override
  String get sendAMessage => 'Pošalji poruku';

  @override
  String get sendAsText => 'Pošalji kao tekst';

  @override
  String get sendAudio => 'Pošalji audio datoteku';

  @override
  String get sendFile => 'Pošalji datoteku';

  @override
  String get sendImage => 'Pošalji sliku';

  @override
  String get sendMessages => 'Šalji poruke';

  @override
  String get sendMessage => 'Send message';

  @override
  String get sendOriginal => 'Pošalji original';

  @override
  String get sendSticker => 'Pošalji naljepnicu';

  @override
  String get sendVideo => 'Pošalji video datoteku';

  @override
  String sentAFile(Object username) {
    return '$username ja poslao/la datoteku';
  }

  @override
  String sentAnAudio(Object username) {
    return '$username ja poslao/la audio datoteku';
  }

  @override
  String sentAPicture(Object username) {
    return '$username ja poslao/la sliku';
  }

  @override
  String sentASticker(Object username) {
    return '$username je poslao/la naljepnicu';
  }

  @override
  String sentAVideo(Object username) {
    return '$username ja poslao/la video';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName je poslao/la podatke poziva';
  }

  @override
  String get separateChatTypes => 'Odvojeni izravni chatovi, grupe i prostori';

  @override
  String get setAsCanonicalAlias => 'Postavi kao glavni pseudonim';

  @override
  String get setCustomEmotes => 'Postavi prilagođene emotikone';

  @override
  String get setGroupDescription => 'Postavi opis grupe';

  @override
  String get setInvitationLink => 'Pošalji poveznicu za pozivnicu';

  @override
  String get setPermissionsLevel => 'Postavi razinu dozvola';

  @override
  String get setStatus => 'Postavi stanje';

  @override
  String get settings => 'Postavke';

  @override
  String get share => 'Dijeli';

  @override
  String sharedTheLocation(Object username) {
    return '$username je dijelio/la svoje mjesto';
  }

  @override
  String get shareLocation => 'Dijeli lokaciju';

  @override
  String get showDirectChatsInSpaces =>
      'Pokaži povezane izravne chatove u prostorima';

  @override
  String get showPassword => 'Pokaži lozinku';

  @override
  String get signUp => 'Prijavi se';

  @override
  String get singlesignon => 'Jednokratna prijava';

  @override
  String get skip => 'Preskoči';

  @override
  String get invite => 'Invite';

  @override
  String get sourceCode => 'Izvorni kȏd';

  @override
  String get spaceIsPublic => 'Prostor je javan';

  @override
  String get spaceName => 'Ime prostora';

  @override
  String startedACall(Object senderName) {
    return '$senderName ja započeo/la poziv';
  }

  @override
  String get startFirstChat => 'Start your first chat';

  @override
  String get status => 'Stanje';

  @override
  String get statusExampleMessage => 'Kako si danas?';

  @override
  String get submit => 'Pošalji';

  @override
  String get sunday => 'Nedjelja';

  @override
  String get synchronizingPleaseWait => 'Sinkronizira se … Pričekaj.';

  @override
  String get systemTheme => 'Sustav';

  @override
  String get theyDontMatch => 'Ne poklapaju se';

  @override
  String get theyMatch => 'Poklapaju se';

  @override
  String get thisRoomHasBeenArchived => 'Ova soba je arhivirana.';

  @override
  String get thursday => 'Četvrtak';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Uklj/Isklj favorite';

  @override
  String get toggleMuted => 'Uklj/Isklj isključene';

  @override
  String get toggleUnread => 'Označi kao pročitano/nepročitano';

  @override
  String get tooManyRequestsWarning =>
      'Previše zahtjeva. Pokušaj ponovo kasnije!';

  @override
  String get transferFromAnotherDevice => 'Prenesi s jednog drugog uređaja';

  @override
  String get tryToSendAgain => 'Pokušaj ponovo poslati';

  @override
  String get tuesday => 'Utorak';

  @override
  String get unavailable => 'Nedostupno';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username je ponovo uključio/la $targetName';
  }

  @override
  String get unblockDevice => 'Deblokiraj uređaj';

  @override
  String get unknownDevice => 'Nepoznat uređaj';

  @override
  String get unknownEncryptionAlgorithm => 'Nepoznat algoritam šifriranja';

  @override
  String unknownEvent(Object type, Object tipo) {
    return 'Nepoznat događaj „$type”';
  }

  @override
  String get unmuteChat => 'Uključi zvuk chata';

  @override
  String get unpin => 'Otkvači';

  @override
  String unreadChats(num unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount nepročitana chata',
      one: '1 nepročitan chat',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username i još $count korisnika pišu';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username i $username2 pišu';
  }

  @override
  String userIsTyping(Object username) {
    return '$username piše';
  }

  @override
  String userLeftTheChat(Object username) {
    return '$username je napustio/la chat';
  }

  @override
  String get username => 'Korisničko ime';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username ja poslao/la $type događaj';
  }

  @override
  String get unverified => 'Nepotvrđeno';

  @override
  String get verified => 'Potvrđeno';

  @override
  String get verify => 'Potvrdi';

  @override
  String get verifyStart => 'Pokreni potvrđivanje';

  @override
  String get verifySuccess => 'Uspješno si potvrdio/la!';

  @override
  String get verifyTitle => 'Potvrđivanje drugog računa';

  @override
  String get videoCall => 'Video poziv';

  @override
  String get visibilityOfTheChatHistory => 'Vidljivost kronologije chata';

  @override
  String get visibleForAllParticipants => 'Vidljivo za sve sudionike';

  @override
  String get visibleForEveryone => 'Vidljivo za sve';

  @override
  String get voiceMessage => 'Glasovna poruka';

  @override
  String get waitingPartnerAcceptRequest =>
      'Čeka se na sugovornika da prihvati zahtjev …';

  @override
  String get waitingPartnerEmoji =>
      'Čeka se na sugovornika da prihvati emoji …';

  @override
  String get waitingPartnerNumbers =>
      'Čeka se na sugovornika da prihvati brojeve …';

  @override
  String get wallpaper => 'Slika pozadine';

  @override
  String get warning => 'Upozorenje!';

  @override
  String get wednesday => 'Srijeda';

  @override
  String get weSentYouAnEmail => 'Poslali smo ti e-poruku';

  @override
  String get whoCanPerformWhichAction => 'Tko može izvršiti koju radnju';

  @override
  String get whoIsAllowedToJoinThisGroup => 'Tko se smije pridružiti grupi';

  @override
  String get whyDoYouWantToReportThis => 'Zašto želiš ovo prijaviti?';

  @override
  String get wipeChatBackup =>
      'Izbrisati sigurnosnu kopiju chata za stvaranje novog sigurnosnog ključa za obnavljanje?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Lozinku možeš obnoviti pomoću ovih adresa.';

  @override
  String get writeAMessage => 'Napiši poruku …';

  @override
  String get yes => 'Da';

  @override
  String get you => 'Ti';

  @override
  String get youAreInvitedToThisChat => 'Pozvan/a si u ovaj chat';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Više ne sudjeluješ u ovom chatu';

  @override
  String get youCannotInviteYourself => 'Sebe ne možeš pozvati';

  @override
  String get youHaveBeenBannedFromThisChat => 'Isključen/a si iz ovog chata';

  @override
  String get yourPublicKey => 'Tvoj javni ključ';

  @override
  String get messageInfo => 'Informacija poruke';

  @override
  String get time => 'Vrijeme';

  @override
  String get messageType => 'Vrsta poruke';

  @override
  String get sender => 'Pošiljatelj';

  @override
  String get openGallery => 'Otvori galeriju';

  @override
  String get removeFromSpace => 'Ukloni iz prostora';

  @override
  String get addToSpaceDescription =>
      'Odaberi prostor za dodavanje ovog chata.';

  @override
  String get start => 'Početak';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'Za otključavanje starih poruka upiši ključ za obnavljanje koji je generiran u prethodnoj sesiji. Tvoj ključ za obnavljanje NIJE tvoja lozinka.';

  @override
  String get addToStory => 'Dodaj priči';

  @override
  String get publish => 'Objavi';

  @override
  String get whoCanSeeMyStories => 'Tko može vidjeti moje priče?';

  @override
  String get unsubscribeStories => 'Otkaži pretplatu na priče';

  @override
  String get thisUserHasNotPostedAnythingYet =>
      'Ovaj korisnik još nije objavio ništa u svojoj priči';

  @override
  String get yourStory => 'Tvoja priča';

  @override
  String get replyHasBeenSent => 'Odgovor je poslan';

  @override
  String videoWithSize(Object size) {
    return 'Video ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return 'Priča od $date: \n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'Imaj na umu da ljudi mogu vidjeti i međusobno se kontaktirati u tvojoj priči.';

  @override
  String get whatIsGoingOn => 'Što se događa?';

  @override
  String get addDescription => 'Dodaj opis';

  @override
  String get storyPrivacyWarning =>
      'Imaj na umu da ljudi mogu vidjeti i međusobno se kontaktirati u tvojoj priči. Tvoje priče će biti vidljive 24 sata, ali nema jamstva da će se izbrisati sa svih uređaja i poslužitelja.';

  @override
  String get iUnderstand => 'Razumijem';

  @override
  String get openChat => 'Otvori chat';

  @override
  String get markAsRead => 'Označi kao pročitano';

  @override
  String get reportUser => 'Prijavi korisnika';

  @override
  String get dismiss => 'Odbaci';

  @override
  String get matrixWidgets => 'Matrix widgeti';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender je reagirao/la sa $reaction';
  }

  @override
  String get pinChat => 'Pin';

  @override
  String get confirmEventUnpin => 'Stvarno želiš trajno otkvačiti događaj?';

  @override
  String get emojis => 'Emojiji';

  @override
  String get placeCall => 'Nazovi';

  @override
  String get voiceCall => 'Glasovni poziv';

  @override
  String get unsupportedAndroidVersion => 'Nepodržana Android verzija';

  @override
  String get unsupportedAndroidVersionLong =>
      'Ova funkcija zahtijeva noviju verziju Androida. Provjeri, postoje li nove verzije ili podrška za Lineage OS.';

  @override
  String get videoCallsBetaWarning =>
      'Napominjemo da se funkcija videopoziva trenutačno nalazi u beta stanju. Možda neće raditi ispravno ili uopće neće raditi na svim platformama.';

  @override
  String get experimentalVideoCalls => 'Eksperimentalni videopozivi';

  @override
  String get emailOrUsername => 'E-mail ili korisničko ime';

  @override
  String get indexedDbErrorTitle => 'Problemi u privatnom modusu';

  @override
  String get indexedDbErrorLong =>
      'Spremište poruka nažalost nije standarno uključena u privatnom modusu.\nOtvori stranicu\n - about:config\n - postavi dom.indexedDB.privateBrowsing.enabled na true\nFluffyChat se inače neće moći pokrenuti.';

  @override
  String switchToAccount(Object number) {
    return 'Prijeđi na račun $number';
  }

  @override
  String get nextAccount => 'Sljedeći račun';

  @override
  String get previousAccount => 'Prethodni račun';

  @override
  String get editWidgets => 'Uredi widgete';

  @override
  String get addWidget => 'Dodaj widget';

  @override
  String get widgetVideo => 'Video';

  @override
  String get widgetEtherpad => 'Tekstna bilješka';

  @override
  String get widgetJitsi => 'Jitsi Meet';

  @override
  String get widgetCustom => 'Prilagođeno';

  @override
  String get widgetName => 'Ime';

  @override
  String get widgetUrlError => 'Ovo nije valjan URL.';

  @override
  String get widgetNameError => 'Zadaj prikazno ime.';

  @override
  String get errorAddingWidget => 'Greška prilikom dodavanja widgeta.';

  @override
  String get youRejectedTheInvitation => 'Odbio/la si pozivnicu';

  @override
  String get youJoinedTheChat => 'Pridružio/la si se chatu';

  @override
  String get youAcceptedTheInvitation => 'Prihvatio/la si pozivnicu';

  @override
  String youBannedUser(Object user) {
    return 'Isključio/la si korisnika $user';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return 'Povukao/la si pozivniu za korisnika $user';
  }

  @override
  String youInvitedBy(Object user) {
    return '$user te je pozvao/la';
  }

  @override
  String youInvitedUser(Object user) {
    return 'Pozvao/la si korisnika $user';
  }

  @override
  String youKicked(Object user) {
    return 'Izbacio/la si korisnika $user';
  }

  @override
  String youKickedAndBanned(Object user) {
    return 'Izbacio/la si i isključio/la korisnika $user';
  }

  @override
  String youUnbannedUser(Object user) {
    return 'Ponovo si uključio/la si korisnika $user';
  }

  @override
  String get noEmailWarning =>
      'Upiši valjanu e-mail adresu. U suprotnom nećeš moći ponovo postaviti lozinku. Ako to ne želiš, ponovo dodirni gumb i nastavi.';

  @override
  String get stories => 'Priče';

  @override
  String get users => 'Korisnici';

  @override
  String get enableAutoBackups =>
      'Uključi automatsko spremanje sigurnosnih kopija';

  @override
  String get unlockOldMessages => 'Otključaj stare poruke';

  @override
  String get cannotUnlockBackupKey => 'Cannot unlock Key backup.';

  @override
  String get storeInSecureStorageDescription =>
      'Ključ za obnavljanje spremi u sigurno spremište na ovom uređaju.';

  @override
  String get saveKeyManuallyDescription =>
      'Spremi ovaj ključ ručno pokretanjem dijaloga za dijeljenje sustava ili međuspremnika.';

  @override
  String get storeInAndroidKeystore => 'Spremi u Android KeyStore';

  @override
  String get storeInAppleKeyChain => 'Spremi u Apple KeyChain';

  @override
  String get storeSecurlyOnThisDevice => 'Spremi sigurno na ovom uređaju';

  @override
  String countFiles(Object count) {
    return 'Broj datoteka: $count';
  }

  @override
  String get user => 'Korisnik';

  @override
  String get custom => 'Prilagođeno';

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
  String welcomeToDedi(Object user) {
    return 'Welcome to Dedi, $user';
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
  String get dediUsers => 'Dedi users';

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
  String get search => 'Traži';

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
  String get dedi => 'Dedi';

  @override
  String get permissionAccess => 'Permission access';

  @override
  String get allow => 'Allow';

  @override
  String get explainStoragePermission =>
      'Dedi need access to your storage to preview file';

  @override
  String get explainGoToStorageSetting =>
      'Dedi need access to your storage to preview file, go to settings to allow this permission';

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
      'You might lose your messages if you access Dedi app on the another device.';

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
      'To ensure you can connect with all your friends, please allow Dedi to access your device’s contacts. We appreciate your understanding.';

  @override
  String contactsCount(Object count) {
    return 'Contacts ($count)';
  }

  @override
  String dediContactsCount(Object count) {
    return 'Dedi contacts ($count)';
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
  String get settingsLanguageDescription => 'Set the language you use on Dedi';

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
  String get createDediId => 'Create Dedi ID';

  @override
  String get useYourCompanyServer => 'Use your company server';

  @override
  String get descriptionDediId =>
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
  String get dediChatUser => 'Dedi User';

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
      'Dedi DOES NOT collect your contacts. Dedi sends only contact hashes to the Dedi servers to understand who from your friends already joined Dedi, enabling connection with them. Your contacts ARE NOT synchronized with our server.';

  @override
  String get explainPermissionToAccessMedias =>
      'Dedi does not synchronize data between your device and our servers. We only store media that you have sent to the chat room. All media files sent to chat are encrypted and stored securely. Go to Settings > Permissions and activate the Storage: Photos and Videos permission. You can also deny access to your media library at any time.';

  @override
  String get explainPermissionToAccessPhotos =>
      'Dedi does not synchronize data between your device and our servers. We only store media that you have sent to the chat room. All media files sent to chat are encrypted and stored securely. Go to Settings > Permissions and activate the Storage: Photos permission. You can also deny access to your media library at any time.';

  @override
  String get explainPermissionToAccessVideos =>
      'Dedi does not synchronize data between your device and our servers. We only store media that you have sent to the chat room. All media files sent to chat are encrypted and stored securely. Go to Settings > Permissions and activate the Storage: Videos permission. You can also deny access to your media library at any time.';

  @override
  String get downloading => 'Downloading';

  @override
  String get settingUpYourDedi => 'Setting up your Dedi\nIt could take a while';

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
      'To send voice messages, allow Dedi to access the microphone.';

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

  @override
  String get dediMainTitle => 'DNA Algorithm';

  @override
  String get dediMainDescription =>
      'Dedi uses an encryption system that belongs only to Dedi, messages cannot be read outside of Dedi';

  @override
  String get phoneAuthTitle => 'Phone Verification';

  @override
  String get phoneAuthDescription =>
      'Enter your phone number, we will send you a verification code';

  @override
  String get otpVerificationTitle => 'Verification Code';

  @override
  String get otpVerificationDescription =>
      'Enter the 6-digit code sent to your phone';

  @override
  String get splashTagline => 'Turkey\'s messaging platform';

  @override
  String get loginTitle => 'Sign In';

  @override
  String get welcomeMessage => 'Welcome!';

  @override
  String get loginDescription =>
      'Just a few steps left for secure and unlimited messaging';

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
  String get pleaseEnterCompleteCode =>
      'Please enter the complete 6-digit code';

  @override
  String get invalidOtp => 'Verification code is incorrect. Please check.';

  @override
  String get connectionError =>
      'Connection error. Please check your internet connection.';

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
