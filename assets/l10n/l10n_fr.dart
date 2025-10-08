// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class L10nFr extends L10n {
  L10nFr([String locale = 'fr']) : super(locale);

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas !';

  @override
  String get pleaseEnterValidEmail =>
      'Veuillez saisir une adresse e-mail valide.';

  @override
  String get repeatPassword => 'Répétez le mot de passe';

  @override
  String pleaseChooseAtLeastChars(Object min) {
    return 'Veuillez renseigner au moins $min caractères.';
  }

  @override
  String get about => 'À propos';

  @override
  String get updateAvailable => 'Mise à jour de Twake Chat disponible';

  @override
  String get updateNow => 'Lancer la mise à jour en arrière-plan';

  @override
  String get accept => 'Accepter';

  @override
  String acceptedTheInvitation(Object username) {
    return '👍 $username a accepté l\'invitation';
  }

  @override
  String get account => 'Compte';

  @override
  String activatedEndToEndEncryption(Object username) {
    return '🔐 $username a activé le chiffrement de bout en bout';
  }

  @override
  String get addEmail => 'Ajouter une adresse e-mail';

  @override
  String get confirmMatrixId =>
      'Veuillez confirmer votre identifiant Matrix afin de supprimer votre compte.';

  @override
  String supposedMxid(Object mxid) {
    return 'Cela devrait être $mxid';
  }

  @override
  String get addGroupDescription => 'Ajouter une description au groupe';

  @override
  String get addToSpace => 'Ajouter à l\'espace';

  @override
  String get admin => 'Administrateur';

  @override
  String get alias => 'adresse';

  @override
  String get all => 'Tout';

  @override
  String get allChats => 'Toutes les discussions';

  @override
  String get commandHint_googly => 'Envoyer des yeux écarquillés';

  @override
  String get commandHint_cuddle => 'Envoyer un câlin';

  @override
  String get commandHint_hug => 'Envoyer une accolade';

  @override
  String googlyEyesContent(Object senderName) {
    return '$senderName vous envoie des yeux écarquillés';
  }

  @override
  String cuddleContent(Object senderName) {
    return '$senderName vous fait un câlin';
  }

  @override
  String hugContent(Object senderName) {
    return '$senderName vous fait une accolade';
  }

  @override
  String answeredTheCall(Object senderName, Object sendername) {
    return '$senderName a répondu à l\'appel';
  }

  @override
  String get anyoneCanJoin => 'Tout le monde peut rejoindre';

  @override
  String get appLock => 'Verrouillage de l’application';

  @override
  String get archive => 'Archiver';

  @override
  String get archivedRoom => 'Salon archivé';

  @override
  String get areGuestsAllowedToJoin =>
      'Les utilisateurs invités sont-ils autorisés à se joindre';

  @override
  String get areYouSure => 'Êtes-vous sûr·e ?';

  @override
  String get areYouSureYouWantToLogout =>
      'Voulez-vous vraiment vous déconnecter ?';

  @override
  String get askSSSSSign =>
      'Pour finaliser la vérification, veuillez saisir la phrase secrète ou la clé de récupération de votre trousseau.';

  @override
  String askVerificationRequest(Object username) {
    return 'Accepter cette demande de vérification de la part de $username ?';
  }

  @override
  String get autoplayImages =>
      'Jouer les autocollants et les émojis animés automatiquement';

  @override
  String badServerLoginTypesException(Object serverVersions,
      Object supportedVersions, Object suportedVersions) {
    return 'Le serveur accepte les types de connexion :\n$serverVersions\nMais cette application ne prend en charge que :\n$supportedVersions';
  }

  @override
  String get sendOnEnter => 'Envoyer avec la touche \"Entrée\"';

  @override
  String badServerVersionsException(Object serverVersions,
      Object supportedVersions, Object serverVerions, Object suportedVersions) {
    return 'Le serveur supporte les spécifications en version :\n$serverVersions\nMais cette application n\'est compatible qu\'avec le·s version·s : $supportedVersions';
  }

  @override
  String get banFromChat => 'Bannir de la discussion';

  @override
  String get banned => 'Banni';

  @override
  String bannedUser(Object username, Object targetName) {
    return '$username a banni $targetName';
  }

  @override
  String get blockDevice => 'Bloquer l\'appareil';

  @override
  String get blocked => 'Bloqué';

  @override
  String get botMessages => 'Messages d\'un bot';

  @override
  String get bubbleSize => 'Taille de la bulle';

  @override
  String get cancel => 'Annuler';

  @override
  String cantOpenUri(Object uri) {
    return 'Impossible d\'ouvrir l\'URI $uri';
  }

  @override
  String get changeDeviceName => 'Modifier le nom de l\'appareil';

  @override
  String changedTheChatAvatar(Object username) {
    return '$username a changé l\'image de la discussion';
  }

  @override
  String changedTheChatDescriptionTo(Object username, Object description) {
    return '$username a changé la description de la discussion : \'$description\'';
  }

  @override
  String changedTheChatNameTo(Object username, Object chatname) {
    return '$username a renommé la discussion : \'$chatname\'';
  }

  @override
  String changedTheChatPermissions(Object username) {
    return '$username a changé les permissions de la discussion';
  }

  @override
  String changedTheDisplaynameTo(Object username, Object displayname) {
    return '$username s\'appelle maintenant : \'$displayname\'';
  }

  @override
  String changedTheGuestAccessRules(Object username) {
    return '$username a changé les règles d\'accès à la discussion pour les invités';
  }

  @override
  String changedTheGuestAccessRulesTo(Object username, Object rules) {
    return '$username a changé les règles d\'accès à la discussion pour les invités en : $rules';
  }

  @override
  String changedTheHistoryVisibility(Object username) {
    return '$username a changé la visibilité de l\'historique de la discussion';
  }

  @override
  String changedTheHistoryVisibilityTo(Object username, Object rules) {
    return '$username a changé la visibilité de l\'historique de la discussion en : $rules';
  }

  @override
  String changedTheJoinRules(Object username) {
    return '$username a changé les règles d\'accès à la discussion';
  }

  @override
  String changedTheJoinRulesTo(Object username, Object joinRules) {
    return '$username a changé les règles d\'accès à la discussion en : $joinRules';
  }

  @override
  String changedTheProfileAvatar(Object username) {
    return '$username a changé son avatar';
  }

  @override
  String changedTheRoomAliases(Object username) {
    return '$username a changé les adresses du salon';
  }

  @override
  String changedTheRoomInvitationLink(Object username) {
    return '$username a changé le lien d\'invitation';
  }

  @override
  String get changePassword => 'Changer de mot de passe';

  @override
  String get changeTheHomeserver => 'Changer l\'adresse du serveur';

  @override
  String get changeTheme => 'Changer de thème visuel';

  @override
  String get changeTheNameOfTheGroup => 'Changer le nom du groupe';

  @override
  String get changeWallpaper => 'Changer l\'image de fond';

  @override
  String get changeYourAvatar => 'Changer votre avatar';

  @override
  String get channelCorruptedDecryptError => 'Le chiffrement a été corrompu';

  @override
  String get chat => 'Discussion';

  @override
  String get yourUserId => 'Votre identifiant utilisateur :';

  @override
  String get yourChatBackupHasBeenSetUp =>
      'La sauvegarde de vos discussions a été configurée.';

  @override
  String get chatBackup => 'Sauvegarde des discussions';

  @override
  String get chatBackupDescription =>
      'Vos anciens messages sont sécurisés par une clé de récupération. Veillez à ne pas la perdre.';

  @override
  String get chatDetails => 'Détails de la discussion';

  @override
  String get chatHasBeenAddedToThisSpace =>
      'La discussion a été ajoutée à cet espace';

  @override
  String get chats => 'Discussions';

  @override
  String get chooseAStrongPassword => 'Choisissez un mot de passe fort';

  @override
  String get chooseAUsername => 'Choisissez un nom d\'utilisateur/trice';

  @override
  String get clearArchive => 'Effacer les archives';

  @override
  String get close => 'Fermer';

  @override
  String get commandHint_markasdm =>
      'Marquer comme salon de messagerie directe';

  @override
  String get commandHint_markasgroup => 'Marquer comme salon';

  @override
  String get commandHint_ban => 'Bannir l\'utilisateur/trice de ce salon';

  @override
  String get commandHint_clearcache => 'Vider le cache';

  @override
  String get commandHint_create =>
      'Créer un salon de discussion vide\nUtilisez --no-encryption pour désactiver le chiffrement';

  @override
  String get commandHint_discardsession => 'Abandonner la session';

  @override
  String get commandHint_dm =>
      'Commencer un salon de messagerie directe\nUtilisez --no-encryption pour désactiver le chiffrement';

  @override
  String get commandHint_html => 'Envoyer du texte au format HTML';

  @override
  String get commandHint_invite => 'Inviter l\'utilisateur/trice dans ce salon';

  @override
  String get commandHint_join => 'Rejoindre le salon';

  @override
  String get commandHint_kick => 'Supprimer l\'utilisateur/trice de ce salon';

  @override
  String get commandHint_leave => 'Quitter ce salon';

  @override
  String get commandHint_me => 'À propos de vous';

  @override
  String get commandHint_myroomavatar =>
      'Définir votre image pour ce salon (par mxc-uri)';

  @override
  String get commandHint_myroomnick =>
      'Définir votre nom d\'affichage pour ce salon';

  @override
  String get commandHint_op =>
      'Définir le niveau de privilèges de l\'utilisateur/trice (par défaut : 50)';

  @override
  String get commandHint_plain => 'Envoyer du texte brut';

  @override
  String get commandHint_react => 'Envoyer une réponse en tant que réaction';

  @override
  String get commandHint_send => 'Envoyer du texte';

  @override
  String get commandHint_unban => 'Débannir l\'utilisateur/trice de ce salon';

  @override
  String get commandInvalid => 'Commande invalide';

  @override
  String commandMissing(Object command) {
    return '$command n\'est pas une commande.';
  }

  @override
  String get compareEmojiMatch =>
      'Comparez les emojis suivants avec ceux de l\'autre appareil et assurez-vous qu\'ils correspondent :';

  @override
  String get compareNumbersMatch =>
      'Comparez les chiffres suivants avec ceux de l\'autre appareil et assurez-vous qu\'ils correspondent :';

  @override
  String get configureChat => 'Configurer ce salon';

  @override
  String get confirm => 'Confirmer';

  @override
  String get connect => 'Se connecter';

  @override
  String get contactHasBeenInvitedToTheGroup =>
      'Le contact a été invité dans ce groupe';

  @override
  String get containsDisplayName => 'Contient le nom d\'affichage';

  @override
  String get containsUserName => 'Contient le nom d\'utilisateur/trice';

  @override
  String get contentHasBeenReported =>
      'Le contenu a été signalé aux administrateurs du serveur';

  @override
  String get copiedToClipboard => 'Copié dans le presse-papier';

  @override
  String get copy => 'Copier';

  @override
  String get copyToClipboard => 'Copier dans le presse-papiers';

  @override
  String couldNotDecryptMessage(Object error) {
    return 'Impossible de déchiffrer le message : $error';
  }

  @override
  String countMembers(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count membres',
      one: '1 membre',
      zero: 'Pas de membre',
    );
    return '$_temp0';
  }

  @override
  String get create => 'Créer';

  @override
  String createdTheChat(Object username) {
    return '💬 $username a créé la discussion';
  }

  @override
  String get createNewGroup => 'Créer un nouveau groupe de discussion';

  @override
  String get createNewSpace => 'Nouvel espace';

  @override
  String get crossSigningEnabled => 'La signature croisée est activée';

  @override
  String get currentlyActive => 'Actif en ce moment';

  @override
  String get darkTheme => 'Sombre';

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
      'Cette opération va désactiver votre compte. Une fois cette action effectuée, aucun retour en arrière n\'est possible ! Voulez-vous continuer ?';

  @override
  String get defaultPermissionLevel => 'Niveau d\'autorisation par défaut';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get deleteMessage => 'Supprimer le message';

  @override
  String get deny => 'Refuser';

  @override
  String get device => 'Appareil';

  @override
  String get deviceId => 'Identifiant de l\'appareil';

  @override
  String get devices => 'Appareils';

  @override
  String get directChats => 'Discussions directes';

  @override
  String get discover => 'Découvrir';

  @override
  String get displaynameHasBeenChanged =>
      'Le nom d\'affichage a bien été modifié';

  @override
  String get download => 'Télécharger';

  @override
  String get edit => 'Modifier';

  @override
  String get editBlockedServers => 'Modifier les serveurs bloqués';

  @override
  String get editChatPermissions => 'Modifier les permissions de la discussion';

  @override
  String get editDisplayname => 'Changer de nom d\'affichage';

  @override
  String get editRoomAliases => 'Modifier les adresses du salon';

  @override
  String get editRoomAvatar => 'Modifier l\'avatar du salon';

  @override
  String get emoteExists => 'Cette émoticône existe déjà !';

  @override
  String get emoteInvalid => 'Raccourci d\'émoticône invalide !';

  @override
  String get emotePacks => 'Packs d\'émoticônes pour le salon';

  @override
  String get emoteSettings => 'Réglage des émoticônes';

  @override
  String get emoteShortcode => 'Raccourci de l\'émoticône';

  @override
  String get emoteWarnNeedToPick =>
      'Vous devez sélectionner un raccourci d\'émoticône et une image !';

  @override
  String get emptyChat => 'Discussion vide';

  @override
  String get enableEmotesGlobally =>
      'Activer le pack d\'émoticônes globalement';

  @override
  String get enableEncryption => 'Activer le chiffrement de bout-en-bout';

  @override
  String get enableEncryptionWarning =>
      'Vous ne pourrez plus désactiver le chiffrement. Voulez-vous continuer ?';

  @override
  String get encrypted => 'Chiffré';

  @override
  String get encryption => 'Chiffrement';

  @override
  String get encryptionNotEnabled => 'Le chiffrement n\'est pas activé';

  @override
  String endedTheCall(Object senderName) {
    return '$senderName a mis fin à l\'appel';
  }

  @override
  String get enterGroupName => 'Entrer le nom du salon';

  @override
  String get enterAnEmailAddress => 'Saisissez une adresse e-mail';

  @override
  String get enterASpacepName => 'Entrer un nom d\'espace';

  @override
  String get homeserver => 'Serveur';

  @override
  String get enterYourHomeserver => 'Renseignez l\'adresse de votre serveur';

  @override
  String errorObtainingLocation(Object error) {
    return 'Erreur lors de l\'obtention de la localisation : $error';
  }

  @override
  String get everythingReady => 'Tout est prêt !';

  @override
  String get extremeOffensive => 'Extrêmement offensant';

  @override
  String get fileName => 'Nom de fichier';

  @override
  String get fluffychat => 'FluffyChat';

  @override
  String get fontSize => 'Taille de la police';

  @override
  String get forward => 'Transférer';

  @override
  String get friday => 'Ven';

  @override
  String get fromJoining => 'À partir de la date d\'arrivée dans le salon';

  @override
  String get fromTheInvitation => 'À partir de la date de l\'invitation';

  @override
  String get goToTheNewRoom => 'Aller dans le nouveau salon';

  @override
  String get group => 'Salon';

  @override
  String get groupDescription => 'Description du salon';

  @override
  String get groupDescriptionHasBeenChanged =>
      'La description du salon a été modifiée';

  @override
  String get groupIsPublic => 'Ce salon est public';

  @override
  String get groups => 'Salons';

  @override
  String groupWith(Object displayname) {
    return 'Salon avec $displayname';
  }

  @override
  String get guestsAreForbidden => 'Aucun invités';

  @override
  String get guestsCanJoin => 'Les invités peuvent rejoindre';

  @override
  String hasWithdrawnTheInvitationFor(Object username, Object targetName) {
    return '$username a annulé l\'invitation de $targetName';
  }

  @override
  String get help => 'Aide';

  @override
  String get hideRedactedEvents => 'Masquer les messages supprimés';

  @override
  String get hideUnknownEvents => 'Masquer les événements inconnus';

  @override
  String get howOffensiveIsThisContent =>
      'À quel point ce contenu est-il offensant ?';

  @override
  String get id => 'Identifiant';

  @override
  String get identity => 'Identité';

  @override
  String get ignore => 'Ignorer';

  @override
  String get ignoredUsers => 'Utilisateur/trices ignoré·es';

  @override
  String get ignoreListDescription =>
      'Vous pouvez ignorer les utilisateurs/trices qui vous perturbent. Vous ne pourrez pas recevoir de messages ou d\'invitations de la part des utilisateurs/trices figurant sur votre liste personnelle des utilisateurs/trices ignoré·es.';

  @override
  String get ignoreUsername => 'Ignorer l\'utilisateur/trice';

  @override
  String get iHaveClickedOnLink => 'J\'ai cliqué sur le lien';

  @override
  String get incorrectPassphraseOrKey =>
      'Phrase secrète ou clé de récupération incorrecte';

  @override
  String get inoffensive => 'Non offensant';

  @override
  String get inviteContact => 'Inviter un contact';

  @override
  String inviteContactToGroup(Object groupName) {
    return 'Inviter un contact à $groupName';
  }

  @override
  String get invited => 'Invité·e';

  @override
  String invitedUser(Object username, Object targetName) {
    return '📩 $username a invité $targetName';
  }

  @override
  String get invitedUsersOnly => 'Uniquement les utilisateur/trices invité·es';

  @override
  String get inviteForMe => 'Inviter pour moi';

  @override
  String inviteText(Object username, Object link) {
    return '$username vous a invité·e sur FluffyChat.\n1. Installez FluffyChat : https://fluffychat.im\n2. Inscrivez-vous ou connectez-vous\n3. Ouvrez le lien d\'invitation : $link';
  }

  @override
  String get isTyping => 'écrit';

  @override
  String joinedTheChat(Object username) {
    return '👋 $username a rejoint le salon';
  }

  @override
  String get joinRoom => 'Rejoindre le salon';

  @override
  String get keysCached => 'Les clés sont mises en cache';

  @override
  String kicked(Object username, Object targetName) {
    return '👞 $username a expulsé $targetName';
  }

  @override
  String kickedAndBanned(Object username, Object targetName) {
    return '🙅 $username a expulsé et banni $targetName';
  }

  @override
  String get kickFromChat => 'Expulser de la discussion';

  @override
  String lastActiveAgo(Object localizedTimeShort) {
    return 'Vu·e pour la dernière fois : $localizedTimeShort';
  }

  @override
  String get lastSeenLongTimeAgo => 'Vu pour la dernière fois il y a longtemps';

  @override
  String get leave => 'Quitter';

  @override
  String get leftTheChat => 'A quitté la discussion';

  @override
  String get license => 'Licence';

  @override
  String get lightTheme => 'Clair';

  @override
  String loadCountMoreParticipants(Object count) {
    return 'Afficher $count utilisateurs de plus';
  }

  @override
  String get dehydrate => 'Exporter la session et effacer l\'appareil';

  @override
  String get dehydrateWarning =>
      'Cette action ne peut pas être annulée. Vérifiez que vous avez bien enregistrer le fichier de sauvegarde.';

  @override
  String get dehydrateShare =>
      'Ceci est votre export privé de FluffyChat. Ne le perdez pas et gardez le privé.';

  @override
  String get dehydrateTor => 'Utilisateurs/trices de TOR : Exporter la session';

  @override
  String get dehydrateTorLong =>
      'Pour les utilisateurs/trices de TOR, il est recommandé d\'exporter la session avant de fermer la fenêtre.';

  @override
  String get hydrateTor =>
      'Utilisateurs/trices de TOR : Importer une session exportée';

  @override
  String get hydrateTorLong =>
      'Vous avez exporté votre session la dernière fois sur TOR ? Importez-la rapidement et continuez à discuter.';

  @override
  String get hydrate => 'Restaurer à partir du fichier de sauvegarde';

  @override
  String get loadingPleaseWait => 'Chargement… Veuillez patienter.';

  @override
  String get loadingStatus => 'Chargement du statut...';

  @override
  String get loadMore => 'Charger plus…';

  @override
  String get locationDisabledNotice =>
      'Les services de localisation sont désactivés. Activez les avant de pouvoir partager votre localisation.';

  @override
  String get locationPermissionDeniedNotice =>
      'L\'application n\'a pas la permission d\'accéder à votre localisation. Merci de l\'accorder afin de pouvoir partager votre localisation.';

  @override
  String get login => 'Se connecter';

  @override
  String logInTo(Object homeserver) {
    return 'Se connecter à $homeserver';
  }

  @override
  String get loginWithOneClick => 'Se connecter en un clic';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get makeSureTheIdentifierIsValid =>
      'Vérifiez que l\'identifiant est valide';

  @override
  String get memberChanges => 'Changements de membres';

  @override
  String get mention => 'Mentionner';

  @override
  String get messages => 'Messages';

  @override
  String get messageWillBeRemovedWarning =>
      'Le message sera supprimé pour tous les membres';

  @override
  String get noSearchResult => 'Aucun résultat de recherche correspondant.';

  @override
  String get moderator => 'Modérateur·rice';

  @override
  String get monday => 'Lun';

  @override
  String get muteChat => 'Mettre la discussion en sourdine';

  @override
  String get needPantalaimonWarning =>
      'Pour l\'instant, vous avez besoin de Pantalaimon pour utiliser le chiffrement de bout en bout.';

  @override
  String get newChat => 'Nouvelle discussion';

  @override
  String get newMessageInTwake => 'Vous avez un message chiffré';

  @override
  String get newVerificationRequest => 'Nouvelle demande de vérification !';

  @override
  String get noMoreResult => 'Plus de résultat !';

  @override
  String get previous => 'Précédent';

  @override
  String get next => 'Suivant';

  @override
  String get no => 'Non';

  @override
  String get noConnectionToTheServer => 'Aucune connexion au serveur';

  @override
  String get noEmotesFound => 'Aucune émoticône trouvée. 😕';

  @override
  String get noEncryptionForPublicRooms =>
      'Vous pouvez activer le chiffrement seulement quand le salon n\'est plus accessible au public.';

  @override
  String get noGoogleServicesWarning =>
      'Il semble que vous n\'ayez aucun service Google sur votre téléphone. C\'est une bonne décision pour votre vie privée ! Pour recevoir des notifications dans FluffyChat, nous vous recommandons d\'utiliser https://microg.org/ ou https://unifiedpush.org/.';

  @override
  String noMatrixServer(Object server1, Object server2) {
    return '$server1 n\'est pas un serveur Matrix, souhaitez-vous utiliser $server2 à la place ?';
  }

  @override
  String get shareYourInviteLink => 'Partager votre lien d\'invitation';

  @override
  String get typeInInviteLinkManually =>
      'Entrer le lien d\'invitation manuellement...';

  @override
  String get scanQrCode => 'Scanner un code QR';

  @override
  String get none => 'Aucun';

  @override
  String get noPasswordRecoveryDescription =>
      'Vous n\'avez pas encore ajouté de moyen pour récupérer votre mot de passe.';

  @override
  String get noPermission => 'Aucune permission';

  @override
  String get noRoomsFound => 'Aucun salon trouvé…';

  @override
  String get notifications => 'Notifications';

  @override
  String numUsersTyping(Object count) {
    return '$count utilisateur·ices écrivent';
  }

  @override
  String get obtainingLocation => 'Obtention de la localisation…';

  @override
  String get offensive => 'Offensant';

  @override
  String get offline => 'Hors ligne';

  @override
  String get aWhileAgo => 'il y a un moment';

  @override
  String get ok => 'Valider';

  @override
  String get online => 'En ligne';

  @override
  String get onlineKeyBackupEnabled =>
      'La sauvegarde en ligne des clés est activée';

  @override
  String get cannotEnableKeyBackup =>
      'Impossible d\'activer la sauvegarde du Salon. Veuillez vous rendre dans les Réglages pour réessayer.';

  @override
  String get cannotUploadKey => 'Impossible de stocker la clé de récupération.';

  @override
  String get oopsPushError =>
      'Oups ! Une erreur s\'est malheureusement produite lors du réglage des notifications.';

  @override
  String get oopsSomethingWentWrong => 'Oups, un problème est survenu…';

  @override
  String get openAppToReadMessages =>
      'Ouvrez l\'application pour lire le message';

  @override
  String get openCamera => 'Ouvrir l\'appareil photo';

  @override
  String get openVideoCamera => 'Ouvrir la caméra pour une vidéo';

  @override
  String get oneClientLoggedOut => 'Un de vos clients a été déconnecté';

  @override
  String get addAccount => 'Ajouter un compte';

  @override
  String get editBundlesForAccount => 'Modifier les groupes pour ce compte';

  @override
  String get addToBundle => 'Ajouter au groupe';

  @override
  String get removeFromBundle => 'Retirer de ce groupe';

  @override
  String get bundleName => 'Nom du groupe';

  @override
  String get enableMultiAccounts =>
      '(BETA) Activer les comptes multiples sur cet appareil';

  @override
  String get openInMaps => 'Ouvrir dans maps';

  @override
  String get link => 'Lien';

  @override
  String get serverRequiresEmail =>
      'Ce serveur doit valider votre adresse e-mail pour l\'inscription.';

  @override
  String get optionalGroupName => '(Optionnel) Nom du salon';

  @override
  String get or => 'Ou';

  @override
  String get participant => 'Membre';

  @override
  String get passphraseOrKey => 'Phrase de passe ou clé de récupération';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordForgotten => 'Mot de passe oublié';

  @override
  String get passwordHasBeenChanged => 'Le mot de passe a été modifié';

  @override
  String get passwordRecovery => 'Récupération du mot de passe';

  @override
  String get people => 'Personnes';

  @override
  String get pickImage => 'Choisir une image';

  @override
  String get pin => 'Épingler';

  @override
  String play(Object fileName) {
    return 'Lire $fileName';
  }

  @override
  String get pleaseChoose => 'Veuillez choisir';

  @override
  String get pleaseChooseAPasscode => 'Veuillez choisir un code d’accès';

  @override
  String get pleaseChooseAUsername => 'Choisissez un nom d\'utilisateur·ice';

  @override
  String get pleaseClickOnLink =>
      'Veuillez cliquer sur le lien contenu dans le message puis continuez.';

  @override
  String get pleaseEnter4Digits =>
      'Veuillez saisir 4 chiffres ou laisser vide pour désactiver le verrouillage de l’application.';

  @override
  String get pleaseEnterAMatrixIdentifier =>
      'Renseignez un identifiant Matrix.';

  @override
  String get pleaseEnterRecoveryKey =>
      'Veuillez saisir votre clé de récupération :';

  @override
  String get pleaseEnterYourPassword => 'Renseignez votre mot de passe';

  @override
  String get pleaseEnterYourPin => 'Veuillez saisir votre code PIN';

  @override
  String get pleaseEnterYourUsername =>
      'Renseignez votre nom d\'utilisateur·ice';

  @override
  String get pleaseFollowInstructionsOnWeb =>
      'Veuillez suivre les instructions sur le site et appuyer sur Suivant.';

  @override
  String get privacy => 'Vie privée';

  @override
  String get publicRooms => 'Salons publics';

  @override
  String get pushRules => 'Règles de notifications';

  @override
  String get reason => 'Motif';

  @override
  String get recording => 'Enregistrement';

  @override
  String redactedAnEvent(Object username) {
    return '$username a supprimé un message';
  }

  @override
  String get redactMessage => 'Supprimer un message';

  @override
  String get register => 'S\'inscrire';

  @override
  String get reject => 'Refuser';

  @override
  String rejectedTheInvitation(Object username) {
    return '$username a refusé l\'invitation';
  }

  @override
  String get rejoin => 'Rejoindre de nouveau';

  @override
  String get remove => 'Supprimer';

  @override
  String get removeAllOtherDevices => 'Déconnecter tous les autres appareils';

  @override
  String removedBy(Object username) {
    return 'Supprimé par $username';
  }

  @override
  String get removeDevice => 'Supprimer l\'appareil';

  @override
  String get unbanFromChat => 'Débannissement de la discussion';

  @override
  String get removeYourAvatar => 'Supprimer votre avatar';

  @override
  String get renderRichContent => 'Afficher le contenu enrichi des messages';

  @override
  String get replaceRoomWithNewerVersion =>
      'Remplacer le salon par une nouvelle version';

  @override
  String get reply => 'Répondre';

  @override
  String get reportMessage => 'Signaler un message';

  @override
  String get requestPermission => 'Demander la permission';

  @override
  String get roomHasBeenUpgraded => 'Le salon a été mis à niveau';

  @override
  String get roomVersion => 'Version du salon';

  @override
  String get saturday => 'Sam';

  @override
  String get saveFile => 'Enregistrer le fichier';

  @override
  String get searchForPeopleAndChannels => 'Personnes ou Salons';

  @override
  String get security => 'Sécurité';

  @override
  String get recoveryKey => 'Clé de récupération';

  @override
  String get recoveryKeyLost => 'Clé de récupération perdue ?';

  @override
  String seenByUser(Object username) {
    return 'Vu par $username';
  }

  @override
  String seenByUserAndCountOthers(Object username, num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vu par $username et $count autres',
    );
    return '$_temp0';
  }

  @override
  String seenByUserAndUser(Object username, Object username2) {
    return 'Vu par $username et $username2';
  }

  @override
  String get send => 'Envoyer';

  @override
  String get sendAMessage => 'Envoyer un message';

  @override
  String get sendAsText => 'Envoyer un texte';

  @override
  String get sendAudio => 'Envoyer un fichier audio';

  @override
  String get sendFile => 'Envoyer un fichier';

  @override
  String get sendImage => 'Envoyer une image';

  @override
  String get sendMessages => 'Envoyer des messages';

  @override
  String get sendMessage => 'Envoyer un message';

  @override
  String get sendOriginal => 'Envoyer le fichier original';

  @override
  String get sendSticker => 'Envoyer un autocollant';

  @override
  String get sendVideo => 'Envoyer une vidéo';

  @override
  String sentAFile(Object username) {
    return '📁 $username a envoyé un fichier';
  }

  @override
  String sentAnAudio(Object username) {
    return '🎤 $username a envoyé un fichier audio';
  }

  @override
  String sentAPicture(Object username) {
    return '🖼️ $username a envoyé une image';
  }

  @override
  String sentASticker(Object username) {
    return '😊 $username a envoyé un autocollant';
  }

  @override
  String sentAVideo(Object username) {
    return '🎥 $username a envoyé une vidéo';
  }

  @override
  String sentCallInformations(Object senderName) {
    return '$senderName a envoyé des informations sur l\'appel';
  }

  @override
  String get separateChatTypes =>
      'Séparer les discussions directes et les salons';

  @override
  String get setAsCanonicalAlias => 'Définir comme adresse principale';

  @override
  String get setCustomEmotes => 'Définir des émoticônes personnalisées';

  @override
  String get setGroupDescription => 'Définir la description du groupe';

  @override
  String get setInvitationLink => 'Créer un lien d\'invitation';

  @override
  String get setPermissionsLevel => 'Définir le niveau de permissions';

  @override
  String get setStatus => 'Définir le statut';

  @override
  String get settings => 'Réglages';

  @override
  String get share => 'Partager';

  @override
  String sharedTheLocation(Object username) {
    return '$username a partagé sa position';
  }

  @override
  String get shareLocation => 'Partager la localisation';

  @override
  String get showDirectChatsInSpaces =>
      'Afficher les discussions directes associées dans les espaces';

  @override
  String get showPassword => 'Afficher le mot de passe';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get singlesignon => 'Authentification unique';

  @override
  String get skip => 'Ignorer';

  @override
  String get invite => 'Inviter';

  @override
  String get sourceCode => 'Code source';

  @override
  String get spaceIsPublic => 'L\'espace est public';

  @override
  String get spaceName => 'Nom de l\'espace';

  @override
  String startedACall(Object senderName) {
    return '$senderName a démarré un appel';
  }

  @override
  String get startFirstChat => 'Commencez votre première discussion';

  @override
  String get status => 'Statut';

  @override
  String get statusExampleMessage => 'Comment allez-vous aujourd\'hui ?';

  @override
  String get submit => 'Soumettre';

  @override
  String get sunday => 'Dim';

  @override
  String get synchronizingPleaseWait =>
      'Synchronisation... Veuillez patienter.';

  @override
  String get systemTheme => 'Système';

  @override
  String get theyDontMatch => 'Elles ne correspondent pas';

  @override
  String get theyMatch => 'Elles correspondent';

  @override
  String get thisRoomHasBeenArchived => 'Ce salon a été archivé.';

  @override
  String get thursday => 'Jeu';

  @override
  String get title => 'FluffyChat';

  @override
  String get toggleFavorite => 'Activer/désactiver en favori';

  @override
  String get toggleMuted => 'Activer/désactiver la sourdine';

  @override
  String get toggleUnread => 'Marquer comme lu / non lu';

  @override
  String get tooManyRequestsWarning =>
      'Trop de requêtes. Veuillez réessayer plus tard !';

  @override
  String get transferFromAnotherDevice =>
      'Transfert à partir d\'un autre appareil';

  @override
  String get tryToSendAgain => 'Retenter l\'envoi';

  @override
  String get tuesday => 'Mar';

  @override
  String get unavailable => 'Indisponible';

  @override
  String unbannedUser(Object username, Object targetName) {
    return '$username a annulé le bannissement de $targetName';
  }

  @override
  String get unblockDevice => 'Retirer le blocage sur l\'appareil';

  @override
  String get unknownDevice => 'Appareil inconnu';

  @override
  String get unknownEncryptionAlgorithm => 'Algorithme de chiffrement inconnu';

  @override
  String unknownEvent(Object type, Object tipo) {
    return 'Événement de type inconnu : \'$type\'';
  }

  @override
  String get unmuteChat => 'Retirer la sourdine de la discussion';

  @override
  String get unpin => 'Désépingler';

  @override
  String unreadChats(num unreadCount) {
    String _temp0 = intl.Intl.pluralLogic(
      unreadCount,
      locale: localeName,
      other: '$unreadCount discussions non lues',
      one: '1 discussion non lue',
    );
    return '$_temp0';
  }

  @override
  String userAndOthersAreTyping(Object username, Object count) {
    return '$username et $count autres sont en train d\'écrire';
  }

  @override
  String userAndUserAreTyping(Object username, Object username2) {
    return '$username et $username2 sont en train d\'écrire';
  }

  @override
  String userIsTyping(Object username) {
    return '$username est en train d\'écrire';
  }

  @override
  String userLeftTheChat(Object username) {
    return '🚪 $username a quitté la discussion';
  }

  @override
  String get username => 'Nom d\'utilisateur·ice';

  @override
  String userSentUnknownEvent(Object username, Object type) {
    return '$username a envoyé un évènement de type $type';
  }

  @override
  String get unverified => 'Non vérifié';

  @override
  String get verified => 'Vérifié';

  @override
  String get verify => 'Vérifier';

  @override
  String get verifyStart => 'Commencer la vérification';

  @override
  String get verifySuccess => 'La vérification a été effectuée avec succès !';

  @override
  String get verifyTitle => 'Vérification de l\'autre compte';

  @override
  String get videoCall => 'Appel vidéo';

  @override
  String get visibilityOfTheChatHistory =>
      'Visibilité de l\'historique de la discussion';

  @override
  String get visibleForAllParticipants => 'Visible par tous les membres';

  @override
  String get visibleForEveryone => 'Visible pour tout le monde';

  @override
  String get voiceMessage => 'Message vocal';

  @override
  String get waitingPartnerAcceptRequest =>
      'En attente de l\'acceptation de la demande par le partenaire…';

  @override
  String get waitingPartnerEmoji =>
      'En attente de l\'acceptation de l\'émoji par le partenaire…';

  @override
  String get waitingPartnerNumbers =>
      'En attente de l\'acceptation des nombres par le partenaire…';

  @override
  String get wallpaper => 'Image de fond';

  @override
  String get warning => 'Attention !';

  @override
  String get wednesday => 'Mer';

  @override
  String get weSentYouAnEmail => 'Nous vous avons envoyé un message';

  @override
  String get whoCanPerformWhichAction => 'Qui peut faire quelle action';

  @override
  String get whoIsAllowedToJoinThisGroup =>
      'Qui est autorisé à rejoindre ce salon';

  @override
  String get whyDoYouWantToReportThis => 'Pourquoi voulez-vous le signaler ?';

  @override
  String get wipeChatBackup =>
      'Effacer la sauvegarde de votre discussion pour créer une nouvelle clé de récupération ?';

  @override
  String get withTheseAddressesRecoveryDescription =>
      'Grâce à ces adresses, vous pouvez récupérer votre mot de passe si vous en avez besoin.';

  @override
  String get writeAMessage => 'Écrivez un message…';

  @override
  String get yes => 'Oui';

  @override
  String get you => 'Vous';

  @override
  String get youAreInvitedToThisChat => 'Vous êtes invité·e à cette discussion';

  @override
  String get youAreNoLongerParticipatingInThisChat =>
      'Vous ne participez plus à cette discussion';

  @override
  String get youCannotInviteYourself =>
      'Vous ne pouvez pas vous inviter vous-même';

  @override
  String get youHaveBeenBannedFromThisChat =>
      'Vous avez été banni·e de cette discussion';

  @override
  String get yourPublicKey => 'Votre clé publique';

  @override
  String get messageInfo => 'Informations sur le message';

  @override
  String get time => 'Heure';

  @override
  String get messageType => 'Type de message';

  @override
  String get sender => 'Expéditeur/trice';

  @override
  String get openGallery => 'Ouvrir dans la Galerie';

  @override
  String get removeFromSpace => 'Supprimer de l’espace';

  @override
  String get addToSpaceDescription =>
      'Sélectionnez un espace pour y ajouter cette discussion.';

  @override
  String get start => 'Commencer';

  @override
  String get pleaseEnterRecoveryKeyDescription =>
      'Pour déverrouiller vos anciens messages, veuillez entrer votre clé de récupération qui a été générée lors d\'une session précédente. Votre clé de récupération n\'est PAS votre mot de passe.';

  @override
  String get addToStory => 'Ajouter à la story';

  @override
  String get publish => 'Publier';

  @override
  String get whoCanSeeMyStories => 'Qui peut voir mes stories ?';

  @override
  String get unsubscribeStories => 'Se désinscrire des stories';

  @override
  String get thisUserHasNotPostedAnythingYet =>
      'Cet(te) utilisateur(trice) n\'a encore rien posté dans sa story';

  @override
  String get yourStory => 'Votre story';

  @override
  String get replyHasBeenSent => 'La réponse a été envoyée';

  @override
  String videoWithSize(Object size) {
    return 'Vidéo ($size)';
  }

  @override
  String storyFrom(Object date, Object body) {
    return 'Story du $date : \n$body';
  }

  @override
  String get whoCanSeeMyStoriesDesc =>
      'Veuillez noter que les personnes peuvent se voir et se contacter dans votre story.';

  @override
  String get whatIsGoingOn => 'Que se passe-t-il ?';

  @override
  String get addDescription => 'Ajouter une description';

  @override
  String get storyPrivacyWarning =>
      'Veuillez noter que les personnes peuvent se voir et se contacter dans votre story. Vos stories seront visibles pendant 24 heures, mais il n\'y a aucune garantie qu\'elles seront supprimées de tous les appareils et de tous les serveurs.';

  @override
  String get iUnderstand => 'Je comprends';

  @override
  String get openChat => 'Ouvrir la discussion';

  @override
  String get markAsRead => 'Marquer comme lu';

  @override
  String get reportUser => 'Signaler l\'utilisateur/trice';

  @override
  String get dismiss => 'Rejeter';

  @override
  String get matrixWidgets => 'Widgets Matrix';

  @override
  String reactedWith(Object sender, Object reaction) {
    return '$sender a réagi avec $reaction';
  }

  @override
  String get pinChat => 'Épingler';

  @override
  String get confirmEventUnpin =>
      'Voulez-vous vraiment désépingler définitivement le message ?';

  @override
  String get emojis => 'Émojis';

  @override
  String get placeCall => 'Passer un appel';

  @override
  String get voiceCall => 'Appel vocal';

  @override
  String get unsupportedAndroidVersion =>
      'Version d\'Android non prise en charge';

  @override
  String get unsupportedAndroidVersionLong =>
      'Cette fonctionnalité nécessite une nouvelle version d\'Android. Veuillez vérifier les mises à jour ou la prise en charge de Lineage OS.';

  @override
  String get videoCallsBetaWarning =>
      'Veuillez noter que les appels vidéo sont actuellement en version bêta. Ils peuvent ne pas fonctionner comme prévu ou ne oas fonctionner du tout sur toutes les plateformes.';

  @override
  String get experimentalVideoCalls => 'Appels vidéo expérimentaux';

  @override
  String get emailOrUsername => 'Adresse e-mail ou identifiant';

  @override
  String get indexedDbErrorTitle => 'Problèmes relatifs au mode privé';

  @override
  String get indexedDbErrorLong =>
      'Le stockage des messages n\'est malheureusement pas activé par défaut en mode privé, ce qui empêche FluffyChat de fonctionner.\nPour activer le stockage local et pouvoir utiliser FluffyChat, veuillez :\n - sous Firefox : ouvrir l\'adresse \"about:config\" (vous devrez accepter le message d\'alerte), puis rechercher la clef \"dom.indexedDB.privateBrowsing.enabled\", et la définir à \"true\".';

  @override
  String switchToAccount(Object number) {
    return 'Passer au compte $number';
  }

  @override
  String get nextAccount => 'Compte suivant';

  @override
  String get previousAccount => 'Compte précédent';

  @override
  String get editWidgets => 'Modifier les widgets';

  @override
  String get addWidget => 'Ajouter un widget';

  @override
  String get widgetVideo => 'Vidéo';

  @override
  String get widgetEtherpad => 'Note textuelle';

  @override
  String get widgetJitsi => 'Jitsi Meet';

  @override
  String get widgetCustom => 'Personnalisé';

  @override
  String get widgetName => 'Nom';

  @override
  String get widgetUrlError => 'Ceci n\'est pas un lien valide.';

  @override
  String get widgetNameError => 'Veuillez fournir un nom d\'affichage.';

  @override
  String get errorAddingWidget => 'Erreur lors de l\'ajout du widget.';

  @override
  String get youRejectedTheInvitation => 'Vous avez rejeté l\'invitation';

  @override
  String get youJoinedTheChat => 'Vous avez rejoint la discussion';

  @override
  String get youAcceptedTheInvitation => '👍 Vous avez accepté l\'invitation';

  @override
  String youBannedUser(Object user) {
    return 'Vous avez banni $user';
  }

  @override
  String youHaveWithdrawnTheInvitationFor(Object user) {
    return 'Vous avez retiré l\'invitation pour $user';
  }

  @override
  String youInvitedBy(Object user) {
    return '📩 Vous avez été invité par $user';
  }

  @override
  String youInvitedUser(Object user) {
    return '📩 Vous avez invité $user';
  }

  @override
  String youKicked(Object user) {
    return '👞 Vous avez dégagé $user';
  }

  @override
  String youKickedAndBanned(Object user) {
    return '🙅 Vous avez dégagé et banni $user';
  }

  @override
  String youUnbannedUser(Object user) {
    return 'Vous avez débanni $user';
  }

  @override
  String get noEmailWarning =>
      'Veuillez saisir une adresse e-mail valide. Sinon, vous ne pourrez pas réinitialiser votre mot de passe. Si vous ne voulez pas le faire, appuyez à nouveau sur le bouton pour continuer.';

  @override
  String get stories => 'Stories';

  @override
  String get users => 'Utilisateurs/trices';

  @override
  String get enableAutoBackups => 'Activer les sauvegardes automatiques';

  @override
  String get unlockOldMessages => 'Déverrouiller les anciens messages';

  @override
  String get cannotUnlockBackupKey =>
      'Impossible de déverrouiller la clé de récupération.';

  @override
  String get storeInSecureStorageDescription =>
      'Stocker la clé de récupération dans un espace sécurisé de cet appareil.';

  @override
  String get saveKeyManuallyDescription =>
      'Enregistrer cette clé manuellement en déclenchant la boîte de dialogue de partage du système ou le presse-papiers.';

  @override
  String get storeInAndroidKeystore => 'Stocker dans Android KeyStore';

  @override
  String get storeInAppleKeyChain => 'Stocker dans Apple KeyChain';

  @override
  String get storeSecurlyOnThisDevice =>
      'Stocker de manière sécurisé sur cet appareil';

  @override
  String countFiles(Object count) {
    return '$count fichiers';
  }

  @override
  String get user => 'Utilisateur/trice';

  @override
  String get custom => 'Personnalisé';

  @override
  String get foregroundServiceRunning =>
      'Cette notification s’affiche lorsque le service au premier plan est en cours d’exécution.';

  @override
  String get screenSharingTitle => 'Partage d\'écran';

  @override
  String get screenSharingDetail => 'Vous partagez votre écran dans FuffyChat';

  @override
  String get callingPermissions => 'Permissions d\'appel';

  @override
  String get callingAccount => 'Compte d\'appel';

  @override
  String get callingAccountDetails =>
      'Permet à FluffyChat d\'utiliser l\'application de numérotation native d\'Android.';

  @override
  String get appearOnTop => 'Apparaître en haut';

  @override
  String get appearOnTopDetails =>
      'Permet à l\'application d\'apparaître en haut de l\'écran (non nécessaire si vous avez déjà configuré Fluffychat comme compte d\'appel)';

  @override
  String get otherCallingPermissions =>
      'Microphone, caméra et autres autorisations de FluffyChat';

  @override
  String get whyIsThisMessageEncrypted =>
      'Pourquoi ce message est-il illisible ?';

  @override
  String get noKeyForThisMessage =>
      'Cela peut se produire si le message a été envoyé avant que vous ne vous soyez connecté à votre compte sur cet appareil.\n\nIl est également possible que l\'expéditeur ait bloqué votre appareil ou qu\'un problème de connexion Internet se soit produit.\n\nÊtes-vous capable de lire le message dans une autre session ? Vous pouvez alors transférer le message à partir de celle-ci ! Allez dans Réglages > Appareils et assurez-vous que vos appareils ont été vérifiés mutuellement. Lorsque vous ouvrirez le salon la fois suivante et que les deux sessions seront au premier plan, les clés seront transmises automatiquement.\n\nVous ne voulez pas perdre les clés en vous déconnectant ou en changeant d\'appareil ? Assurez-vous que vous avez activé la sauvegarde des discussions dans les Réglages.';

  @override
  String get newGroup => 'Nouveau groupe';

  @override
  String get newSpace => 'Nouvel espace';

  @override
  String get enterSpace => 'Entrer dans l’espace';

  @override
  String get enterRoom => 'Entrer dans le salon';

  @override
  String get allSpaces => 'Tous les espaces';

  @override
  String numChats(Object number) {
    return '$number discussions';
  }

  @override
  String get hideUnimportantStateEvents =>
      'Masquer les événements d\'état sans importance';

  @override
  String get doNotShowAgain => 'Ne plus afficher';

  @override
  String wasDirectChatDisplayName(Object oldDisplayName) {
    return 'Discussion vide (était $oldDisplayName)';
  }

  @override
  String get newSpaceDescription =>
      'Les espaces vous permettent de consolider vos discussions et de construire des communautés privées ou publiques.';

  @override
  String get encryptThisChat => 'Chiffrer cette discussion';

  @override
  String get endToEndEncryption => 'Chiffrement de bout en bout';

  @override
  String get disableEncryptionWarning =>
      'Pour des raisons de sécurité, vous ne pouvez pas désactiver le chiffrement dans une discussion s\'il a été activé précédemment.';

  @override
  String get sorryThatsNotPossible => 'Désolé, ce n\'est pas possible';

  @override
  String get deviceKeys => 'Clés de l’appareil :';

  @override
  String get letsStart => 'C\'est parti';

  @override
  String get enterInviteLinkOrMatrixId =>
      'Entrez le lien d\'invitation ou l\'ID Matrix...';

  @override
  String get reopenChat => 'Rouvrir la discussion';

  @override
  String get noBackupWarning =>
      'Attention ! Sans l\'activation de la sauvegarde de la discussion, vous perdrez l\'accès à vos messages chiffrés. Il est fortement recommandé d\'activer la sauvegarde de la discussion avant de se déconnecter.';

  @override
  String get noOtherDevicesFound => 'Aucun autre appareil trouvé';

  @override
  String get fileIsTooBigForServer =>
      'Le serveur reporte que le fichier est trop large pour être envoyé.';

  @override
  String get onlineStatus => 'en ligne';

  @override
  String onlineMinAgo(Object min) {
    return 'en ligne il y a ${min}m';
  }

  @override
  String onlineHourAgo(Object hour) {
    return 'en ligne il y a ${hour}h';
  }

  @override
  String onlineDayAgo(Object day) {
    return 'en ligne il y a $day jours';
  }

  @override
  String get noMessageHereYet => 'Pas encore de message...';

  @override
  String get sendMessageGuide =>
      'Envoyez un message ou appuyez sur la salutation ci-dessous.';

  @override
  String get youCreatedGroupChat => 'Vous avez créé un groupe de discussion';

  @override
  String get chatCanHave => 'Le salon peut avoir :';

  @override
  String get upTo100000Members => 'Jusqu\'à 100 000 membres';

  @override
  String get persistentChatHistory => 'Historique des discussions persistant';

  @override
  String get addMember => 'Ajouter des membres';

  @override
  String get profile => 'Profil';

  @override
  String get channels => 'Salons';

  @override
  String get chatMessage => 'Nouveau message';

  @override
  String welcomeToTwake(Object user) {
    return 'Bienvenue sur Twake Chat, $user';
  }

  @override
  String get startNewChatMessage =>
      'Il est agréable de discuter avec vos amis et de collaborer avec vos équipes.\nEngageons une discussion, créons un salon, ou rejoignons un salon existant.';

  @override
  String get statusDot => '⬤';

  @override
  String get active => 'Compte activé';

  @override
  String get inactive => 'Compte non activé';

  @override
  String get newGroupChat => 'Nouveau groupe de discussion';

  @override
  String get twakeUsers => 'Utilisateurs de Twake';

  @override
  String get expand => 'Agrandir';

  @override
  String get shrink => 'Rétrécir';

  @override
  String noResultForKeyword(Object keyword) {
    return 'Pas de résultat pour \"$keyword\"';
  }

  @override
  String get searchResultNotFound1 =>
      '• Assurez-vous qu\'il n\'y a pas de fautes de frappe dans votre recherche.\n';

  @override
  String get searchResultNotFound2 =>
      '• Il se peut que l\'utilisateur ne figure pas dans votre carnet d\'adresses.\n';

  @override
  String get searchResultNotFound3 =>
      '• Vérifiez l\'autorisation d\'accès au contact, il se peut que l\'utilisateur figure dans votre liste de contacts.\n';

  @override
  String get searchResultNotFound4 =>
      '• Si la raison n\'est pas mentionnée ci-dessus, ';

  @override
  String get searchResultNotFound5 => 'demandez de l\'aide.';

  @override
  String get more => 'Plus';

  @override
  String get whoWouldYouLikeToAdd => 'Qui voulez-vous ajouter ?';

  @override
  String get addAPhoto => 'Ajouter une photo';

  @override
  String maxImageSize(Object max) {
    return 'Taille de fichier maximum : ${max}MB';
  }

  @override
  String get owner => 'Propriétaire';

  @override
  String participantsCount(Object count) {
    return 'Membres ($count)';
  }

  @override
  String get back => 'Revenir en arrière';

  @override
  String get wrongServerName => 'Mauvais nom de serveur';

  @override
  String get serverNameWrongExplain =>
      'L\'adresse du serveur vous a été envoyée par l\'administrateur de l\'entreprise. Vérifiez le message d\'invitation.';

  @override
  String get contacts => 'Contacts';

  @override
  String get searchForContacts => 'Recherche de contacts';

  @override
  String get soonThereHaveContacts => 'Bientôt, il y aura des contacts';

  @override
  String get searchSuggestion =>
      'Pour l\'instant, vous pouvez effectuer une recherche en tapant le nom d\'une personne ou l\'adresse d\'un serveur public';

  @override
  String get loadingContacts => 'Chargement des contacts...';

  @override
  String get recentChat => 'DISCUSSION RÉCENTE';

  @override
  String get selectChat => 'Sélectionner la discussion';

  @override
  String get search => 'Rechercher des personnes ou salons';

  @override
  String get forwardTo => 'Transférer à...';

  @override
  String get noConnection => 'Pas de connexion';

  @override
  String photoSelectedCounter(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count photos',
      one: '1 photo',
    );
    return '$_temp0 sélectionnée(s)';
  }

  @override
  String get addACaption => 'Ajouter une légende...';

  @override
  String get noImagesFound => 'Pas d\'image trouvée';

  @override
  String get captionForImagesIsNotSupportYet =>
      'La légende des images n\'est pas encore prise en charge.';

  @override
  String get tapToAllowAccessToYourGallery =>
      'Appuyez pour autoriser l\'accès à votre galerie';

  @override
  String get tapToAllowAccessToYourCamera =>
      'Vous pouvez activer l\'accès à la caméra dans les Réglages de l\'application pour passer des appels vidéo sur';

  @override
  String get twake => 'Twake Chat';

  @override
  String get permissionAccess => 'Accès aux autorisations';

  @override
  String get allow => 'Autoriser';

  @override
  String get explainStoragePermission =>
      'Twake Chat a besoin d\'accéder à votre espace de stockage pour prévisualiser le fichier';

  @override
  String get explainGoToStorageSetting =>
      'Twake Chat a besoin d\'accéder à votre espace de stockage pour prévisualiser les fichiers, allez dans les Réglages pour autoriser cette permission';

  @override
  String get gallery => 'Galerie';

  @override
  String get documents => 'Documents';

  @override
  String get location => 'Localisation';

  @override
  String get contact => 'Contact';

  @override
  String get file => 'Fichier';

  @override
  String get recent => 'Récent';

  @override
  String get chatsAndContacts => 'Discussions et Contacts';

  @override
  String get externalContactTitle => 'Inviter d\'autres utilisateurs';

  @override
  String get externalContactMessage =>
      'Certains des utilisateurs que vous souhaitez ajouter ne figurent pas dans vos contacts. Voulez-vous les inviter ?';

  @override
  String get clear => 'Effacer';

  @override
  String get keyboard => 'Clavier';

  @override
  String get changeChatAvatar => 'Modifier l\'image du salon';

  @override
  String get roomAvatarMaxFileSize => 'La taille de l\'avatar est trop grande';

  @override
  String roomAvatarMaxFileSizeLong(Object max) {
    return 'La taille de l\'avatar doit être inférieure à $max';
  }

  @override
  String get continueProcess => 'Continuer';

  @override
  String get youAreUploadingPhotosDoYouWantToCancelOrContinue =>
      'Erreur de téléchargement d\'image ! Voulez-vous toujours continuer à créer un salon ?';

  @override
  String hasCreatedAGroupChat(Object groupName) {
    return 'a créé le salon « $groupName »';
  }

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get yesterday => 'Hier';

  @override
  String get adminPanel => 'Administration';

  @override
  String get acceptInvite => 'Oui s\'il vous plait, rejoindre';

  @override
  String get askToInvite =>
      ' veut que vous participiez à cette discussion. Qu\'en dites-vous ?';

  @override
  String get select => 'Sélectionner';

  @override
  String get copyMessageText => 'Copier le texte du message';

  @override
  String get pinThisChat => 'Épingler ce salon';

  @override
  String get unpinThisChat => 'Désépingler ce salon';

  @override
  String get add => 'Ajouter';

  @override
  String get addMembers => 'Ajouter des membres';

  @override
  String get chatInfo => 'Informations de la discussion';

  @override
  String get mute => 'Mettre en sourdine';

  @override
  String membersInfo(Object count) {
    return 'Membres ($count)';
  }

  @override
  String get members => 'Membres';

  @override
  String get media => 'Médias';

  @override
  String get files => 'Fichiers';

  @override
  String get links => 'Liens';

  @override
  String get downloads => 'Téléchargements';

  @override
  String get downloadImageSuccess => 'Image sauvegardée dans Images';

  @override
  String get downloadImageError => 'Erreur d\'enregistrement de l\'image';

  @override
  String downloadFileInWeb(Object directory) {
    return 'Fichier enregistré dans $directory';
  }

  @override
  String get notInAChatYet => 'Vous n\'êtes pas encore dans une discussion';

  @override
  String get blankChatTitle =>
      'Choisissez une discussion ou appuyez sur #EditIcon# pour en créer une.';

  @override
  String get errorPageTitle => 'Il y a un problème';

  @override
  String get errorPageDescription => 'Cette page n\'existe pas.';

  @override
  String get errorPageButton => 'Retour aux discussions';

  @override
  String get playVideo => 'Jouer';

  @override
  String get done => 'Terminé';

  @override
  String get markThisChatAsRead => 'Marquer ce message comme lu';

  @override
  String get markThisChatAsUnRead => 'Marquer ce salon comme non lu';

  @override
  String get muteThisChat => 'Mettre ce salon en sourdine';

  @override
  String get unmuteThisChat => 'Retirer la sourdine de ce salon';

  @override
  String get read => 'Lire';

  @override
  String get unread => 'Marquer comme non lu';

  @override
  String get unmute => 'Retirer la sourdine';

  @override
  String get privacyAndSecurity => 'Vie privée & Sécurité';

  @override
  String get notificationAndSounds => 'Notification & Son';

  @override
  String get appLanguage => 'Langue de l\'application';

  @override
  String get chatFolders => 'Dossiers de discussion';

  @override
  String get displayName => 'Nom d\'affichage';

  @override
  String get bio => 'Biographie (facultatif)';

  @override
  String get matrixId => 'Matrix ID';

  @override
  String get email => 'E-mail';

  @override
  String get company => 'Entreprise';

  @override
  String get basicInfo => 'INFORMATIONS GÉNÉRALES';

  @override
  String get editProfileDescriptions =>
      'Mettez à jour votre profil avec un nouveau nom, une nouvelle photo et une courte présentation.';

  @override
  String get workIdentitiesInfo => 'INFORMATIONS PROFESSIONNELLES';

  @override
  String get editWorkIdentitiesDescriptions =>
      'Modifiez vos paramètres d\'identité professionnelle, y compris l\'ID Matrix, l\'email ou le nom de votre entreprise.';

  @override
  String get copiedMatrixIdToClipboard =>
      'Copie de l\'identifiant Matrix dans le presse-papiers.';

  @override
  String get changeProfileAvatar => 'Modifier l\'avatar';

  @override
  String countPinChat(Object countPinChat) {
    return 'DISCUSSIONS ÉPINGLÉES ($countPinChat)';
  }

  @override
  String countAllChat(Object countAllChat) {
    return 'TOUTES LES DISCUSSIONS ($countAllChat)';
  }

  @override
  String get thisMessageHasBeenEncrypted => 'Ce message a été crypté';

  @override
  String get roomCreationFailed => 'La création d\'un salon a échoué';

  @override
  String get errorGettingPdf => 'Erreur de lecture du PDF';

  @override
  String get errorPreviewingFile => 'Erreur de prévisualisation du fichier';

  @override
  String get paste => 'Coller';

  @override
  String get cut => 'Couper';

  @override
  String get pasteImageFailed => 'Échec du collage de l\'image';

  @override
  String get copyImageFailed => 'Échec de la copie de l\'image';

  @override
  String get fileFormatNotSupported => 'Format de fichier non pris en charge';

  @override
  String get noResultsFound => 'Aucun résultat trouvé';

  @override
  String get encryptionMessage =>
      'Cette fonction protège vos messages contre la lecture par d\'autres personnes, mais les empêche également d\'être sauvegardés sur nos serveurs. Vous ne pouvez pas désactiver cette fonction ultérieurement.';

  @override
  String get encryptionWarning =>
      'Vous risquez de perdre vos messages si vous accédez à l\'application Twake Chat sur un autre appareil.';

  @override
  String get selectedUsers => 'Utilisateurs sélectionnés';

  @override
  String get clearAllSelected => 'Tout désélectionner';

  @override
  String get newDirectMessage => 'Nouveau message';

  @override
  String get contactInfo => 'Coordonnées';

  @override
  String countPinnedMessage(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Message épinglé #$count',
      zero: 'Message épinglé',
    );
    return '$_temp0';
  }

  @override
  String pinnedMessages(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Messages épinglés',
      one: '1 Message épinglé',
    );
    return '$_temp0';
  }

  @override
  String get copyImageSuccess => 'Image copiée dans le presse-papiers';

  @override
  String get youNeedToAcceptTheInvitation =>
      'Vous devez accepter l\'invitation avant de commencer à échanger';

  @override
  String get hasInvitedYouToAChat =>
      ' vous a invité à discuter. Accepter ou refuser et supprimer la discussion ?';

  @override
  String get declineTheInvitation => 'Refuser l\'invitation ?';

  @override
  String get doYouReallyWantToDeclineThisInvitation =>
      'Voulez-vous vraiment refuser cette invitation et supprimer la discussion ? Vous ne pourrez pas annuler cette action.';

  @override
  String get declineAndRemove => 'Refuser et supprimer';

  @override
  String get notNow => 'Pas maintenant';

  @override
  String get contactsWarningBannerTitle =>
      'Pour vous vous connecter avec tous vos contacts, veuillez permettre à Twake d\'accéder aux contacts de votre appareil.';

  @override
  String contactsCount(Object count) {
    return 'Contacts ($count)';
  }

  @override
  String linagoraContactsCount(Object count) {
    return 'Contacts Linagora ($count)';
  }

  @override
  String fetchingPhonebookContacts(Object progress) {
    return 'Récupération des contacts de l\'appareil...($progress% complétés)';
  }

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageVietnamese => 'Vietnamien';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageRussian => 'Russe';

  @override
  String get settingsLanguageDescription =>
      'Définir la langue utilisée pour Twake Chat';

  @override
  String sendImages(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Envoyer $count images',
      one: 'Envoyer 1 image',
    );
    return '$_temp0';
  }

  @override
  String get enterCaption => 'Ajouter une légende...';

  @override
  String get failToSend => 'L\'envoi a échoué, veuillez réessayer';

  @override
  String get showLess => 'Montrer moins';

  @override
  String get showMore => 'Montrer plus';

  @override
  String get unreadMessages => 'Messages non lus';

  @override
  String get groupInformation => 'Informations sur le salon';

  @override
  String get linkInvite => 'Lien d\'invitation';

  @override
  String get noDescription => 'Pas de description';

  @override
  String get description => 'Description';

  @override
  String get groupName => 'Nom du salon';

  @override
  String get descriptionHelper =>
      'Vous pouvez fournir une description facultative pour votre salon.';

  @override
  String get groupNameCannotBeEmpty => 'Le nom du salon ne peut pas être vide';

  @override
  String get unpinAllMessages => 'Désépingler tous les messages';

  @override
  String get pinnedMessagesTooltip => 'Messages épinglés';

  @override
  String get jumpToMessage => 'Aller au message';

  @override
  String get failedToUnpin => 'Échec de l\'épinglage du message';

  @override
  String get welcomeTo => 'Bienvenue sur';

  @override
  String get descriptionWelcomeTo =>
      'une messagerie open source basée sur\nle protocole matrix, qui permet de\ncrypter vos données';

  @override
  String get startMessaging => 'Commencer à envoyer des messages';

  @override
  String get signIn => 'Se Connecter';

  @override
  String get createTwakeId => 'Créer un Twake ID';

  @override
  String get useYourCompanyServer => 'Utiliser le serveur de votre entreprise';

  @override
  String get descriptionTwakeId =>
      'Un messager open source qui crypte\nvos données avec le protocole matrix';

  @override
  String countFilesSendPerDialog(Object count) {
    return 'Le nombre maximum de fichiers envoyés est $count.';
  }

  @override
  String sendFiles(Object count) {
    return 'Envoyer $count fichiers';
  }

  @override
  String get addAnotherAccount => 'Ajouter un autre compte';

  @override
  String get accountSettings => 'Réglages du compte';

  @override
  String get failedToSendFiles => 'Échec de l\'envoi des fichiers';

  @override
  String get noResults => 'Pas de résultat';

  @override
  String get isSingleAccountOnHomeserver =>
      'Nous ne prenons pas encore en charge plusieurs comptes sur un seul serveur';

  @override
  String messageSelected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages',
      one: '1 message',
      zero: 'Aucun message',
    );
    return '$_temp0 sélectionnés';
  }

  @override
  String draftChatHookPhrase(String user) {
    return 'Bonjour $user ! J\'aimerais discuter avec vous.';
  }

  @override
  String get twakeChatUser => 'Utilisateur de Twake Chat';

  @override
  String get sharedMediaAndLinks => 'Fichiers et liens partagés';

  @override
  String get errorSendingFiles =>
      'Certains fichiers ne peuvent pas être envoyés en raison de limite de taille, de format ou d\'erreurs inattendues. Ils seront omis.';

  @override
  String get removeFileBeforeSend =>
      'Supprimer les fichiers avec des erreurs avant l\'envoi';

  @override
  String get unselect => 'Désélectionner';

  @override
  String get searchContacts => 'Rechercher des contacts';

  @override
  String get tapToAllowAccessToYourMicrophone =>
      'Vous pouvez activer l\'accès au micro dans l\'application Paramètres pour utiliser la voix';

  @override
  String get showInChat => 'Afficher dans le chat';

  @override
  String get phone => 'Téléphone';

  @override
  String get viewProfile => 'Voir le profil';

  @override
  String get profileInfo => 'Informations du profil';

  @override
  String get saveToDownloads => 'Enregistrer dans Téléchargements';

  @override
  String get saveToGallery => 'Enregistrer dans la gallerie';

  @override
  String get fileSavedToDownloads =>
      'Fichier enregistré dans le dossier Téléchargements';

  @override
  String get saveFileToDownloadsError =>
      'Echec de la sauvegarde du fichier dans le dossier Téléchargements';

  @override
  String explainPermissionToDownloadFiles(String appName) {
    return 'Pour continuer, veuillez autoriser $appName à accéder aux autorisations de stockage. Cette autorisation est essentielle pour enregistrer les fichiers dans le dossier Téléchargements.';
  }

  @override
  String get explainPermissionToAccessContacts =>
      'Twake Chat NE COLLECTE PAS vos contacts. Twake Chat envoie uniquement des empreintes (hash) des contacts aux serveurs Twake Chat pour identifier lesquels ont déjà rejoint Twake Chat, afin de vous permettre d\'établir ainsi la connexion avec eux. Vos contacts NE SONT PAS synchronisés ni conservés sur notre serveur.';

  @override
  String get explainPermissionToAccessMedias =>
      'Twake Chat ne synchronise pas les données entre votre appareil et nos serveurs. Nous stockons uniquement les fichiers multimédias que vous avez envoyés au salon de discussion. Tous les fichiers multimédias envoyés au chat sont cryptés et stockés en toute sécurité. Accédez à Paramètres > Autorisations et activez l\'autorisation Stockage : Photos et vidéos. Vous pouvez également refuser l\'accès à votre bibliothèque multimédia à tout moment.';

  @override
  String get explainPermissionToAccessPhotos =>
      'Twake Chat ne synchronise pas les données entre votre appareil et nos serveurs. Nous stockons uniquement les fichiers multimédias que vous avez envoyés au salon de discussion. Tous les fichiers multimédias envoyés dans la discussion sont cryptés et stockés en toute sécurité. Accédez à Paramètres > Autorisations et activez l\'autorisation Stockage : Photos. Vous pouvez également refuser l\'accès à votre bibliothèque multimédia à tout moment.';

  @override
  String get explainPermissionToAccessVideos =>
      'Twake Chat ne synchronise pas les données entre votre appareil et nos serveurs. Nous stockons uniquement les fichiers multimédias que vous avez envoyés au salon de discussion. Tous les fichiers multimédias envoyés dans la discussion sont cryptés et stockés en toute sécurité. Accédez à Paramètres > Autorisations et activez l\'autorisation Stockage : Vidéos. Vous pouvez également refuser l\'accès à votre bibliothèque multimédia à tout moment.';

  @override
  String get downloading => 'Téléchargement en cours';

  @override
  String get settingUpYourTwake =>
      'Configuration de votre Twake\nCela peut prendre un certain temps';

  @override
  String get performingAutomaticalLogin =>
      'Connexion automatique via SSO en cours';

  @override
  String get backingUpYourMessage =>
      'Préparation de l\'environnement serveur pour sauvegarder vos messages';

  @override
  String get recoveringYourEncryptedChats =>
      'Récupération de vos conversations chiffrées';

  @override
  String get configureDataEncryption => 'Configurer le chiffrement des données';

  @override
  String get configurationNotFound =>
      'Les données de configuration sont introuvables';

  @override
  String get fileSavedToGallery => 'Fichier enregistré dans la galerie';

  @override
  String get saveFileToGalleryError =>
      'Échec de l\'enregistrement du fichier dans la galerie';

  @override
  String explainPermissionToGallery(String appName) {
    return 'Pour continuer, veuillez autoriser $appName à accéder aux photos. Cette autorisation est essentielle pour enregistrer les fichiers dans la galerie.';
  }

  @override
  String get tokenNotFound => 'Le jeton de connexion est introuvable';

  @override
  String get dangerZone => 'Zone dangereuse';

  @override
  String get leaveGroupSubtitle =>
      'Ce salon continuera d\'exister après votre départ';

  @override
  String get leaveChatFailed => 'Échec de la sortie du salon';

  @override
  String get invalidLoginToken => 'Jeton de connexion invalide';

  @override
  String get copiedPublicKeyToClipboard =>
      'Clé publique copiée dans le presse-papiers.';

  @override
  String get removeFromGroup => 'Retirer du salon';

  @override
  String get removeUser => 'Supprimer l\'utilisateur';

  @override
  String removeReason(Object user) {
    return 'Retirer $user du salon';
  }

  @override
  String get switchAccounts => 'Changer de compte';

  @override
  String get selectAccount => 'Sélectionner le compte';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get byContinuingYourAgreeingToOur =>
      'En continuant, vous acceptez notre';

  @override
  String get youDontHaveAnyContactsYet =>
      'Vous n\'avez pas encore de contacts.';

  @override
  String get loading => 'Chargement en cours...';

  @override
  String get errorDialogTitle => 'Oups, quelque chose s\'est mal passé';

  @override
  String get shootingTips => 'Appuyez pour prendre une photo.';

  @override
  String get shootingWithRecordingTips =>
      'Appuyez pour prendre une photo. Appuyez longuement pour enregistrer une vidéo.';

  @override
  String get shootingOnlyRecordingTips =>
      'Appuyez longuement pour enregistrer une vidéo.';

  @override
  String get shootingTapRecordingTips => 'Appuyez pour enregistrer une vidéo.';

  @override
  String get loadFailed => 'Échec du chargement';

  @override
  String get saving => 'Enregistrement...';

  @override
  String get sActionManuallyFocusHint => 'mettre au point manuellement';

  @override
  String get sActionPreviewHint => 'aperçu';

  @override
  String get sActionRecordHint => 'enregistrer';

  @override
  String get sActionShootHint => 'prendre une photo';

  @override
  String get sActionShootingButtonTooltip => 'bouton de prise de vue';

  @override
  String get sActionStopRecordingHint => 'arrêter l\'enregistrement';

  @override
  String sCameraLensDirectionLabel(Object value) {
    return 'Direction de la lentille de la caméra : $value';
  }

  @override
  String sCameraPreviewLabel(Object value) {
    return 'Aperçu de la caméra : $value';
  }

  @override
  String sFlashModeLabel(Object mode) {
    return 'Mode flash : $mode';
  }

  @override
  String sSwitchCameraLensDirectionLabel(Object value) {
    return 'Passer à la caméra : $value';
  }

  @override
  String get photo => 'Photo';

  @override
  String get video => 'Vidéo';

  @override
  String get message => 'Message';

  @override
  String fileTooBig(int maxSize) {
    return 'Le fichier sélectionné est trop volumineux. La taille maximale est de $maxSize MB.';
  }

  @override
  String get enable_notifications => 'Activer les notifications';

  @override
  String get disable_notifications => 'Désactiver les notifications';

  @override
  String get logoutDialogWarning =>
      'Vous allez perdre tout vos messages chiffrés. Nous vous recommandons d\'activer la sauvegarde des messages avant de vous déconnecter';

  @override
  String get copyNumber => 'Copier le numéro';

  @override
  String get callViaCarrier => 'Appeler';

  @override
  String get scanQrCodeToJoin =>
      'L\'installation de l\'application mobile vous permettra de contacter des personnes du carnet d\'adresses de votre téléphone ; vos conversations seront synchronisées entre les appareils';

  @override
  String get thisFieldCannotBeBlank => 'Ce champ ne peut pas être vide';

  @override
  String get phoneNumberCopiedToClipboard =>
      'Numéro de téléphone copié dans le presse-papier';

  @override
  String get deleteAccountMessage =>
      'Les salons que vous avez créés continueront à exister sans administrateur, à moins que vous ayez donné à un autre utilisateur un droit d\'administrateur. Les autres utilisateurs du salon auront toujours accès à l\'historique des messages avec vous. La suppression du compte ne supprimera pas ces messages.';

  @override
  String get deleteLater => 'Supprimer plus tard';

  @override
  String get areYouSureYouWantToDeleteAccount =>
      'Confirmez-vous vouloir supprimer ce compte ?';

  @override
  String get textCopiedToClipboard => 'Texte copié dans le presse-papier';

  @override
  String get selectAnEmailOrPhoneYouWantSendTheInvitationTo =>
      'Sélectionnez l\'adresse e-mail ou le téléphone auquel vous souhaitez envoyer l\'invitation';

  @override
  String get phoneNumber => 'Numéro de téléphone';

  @override
  String get sendInvitation => 'Envoyer une invitation';

  @override
  String get verifyWithAnotherDevice => 'Vérifier avec un autre appareil';

  @override
  String get contactLookupFailed => 'Échec de la recherche du contact.';

  @override
  String get invitationHasBeenSuccessfullySent =>
      'L\'invitation a bien été envoyée !';

  @override
  String get failedToSendInvitation => 'Échec de l\'envoi de l\'invitation.';

  @override
  String get invalidPhoneNumber => 'Numéro de téléphone invalide';

  @override
  String get invalidEmail => 'Email invalide';

  @override
  String get shareInvitationLink => 'Partager le lien d\'invitation';

  @override
  String get failedToGenerateInvitationLink =>
      'Échec de la génération du lien d\'invitation.';

  @override
  String get youAlreadySentAnInvitationToThisContact =>
      'Vous avez déjà envoyé une invitation à ce contact';

  @override
  String get selectedEmailWillReceiveAnInvitationLinkAndInstructions =>
      'L\'email sélectionné recevra un lien d\'invitation et des instructions.';

  @override
  String get selectedNumberWillGetAnSMSWithAnInvitationLinkAndInstructions =>
      'Le numéro sélectionné recevra un SMS avec un lien d\'invitation et des instructions.';

  @override
  String get reaction => 'Réaction';

  @override
  String get noChatPermissionMessage =>
      'Vous n\'avez pas l\'autorisation d\'écrire dans cette discussion.';

  @override
  String get administration => 'Administration';

  @override
  String get yourDataIsEncryptedForSecurity =>
      'Vos données sont cryptées par sécurité';

  @override
  String get failedToDeleteMessage => 'Échec de la suppression du message.';

  @override
  String get noDeletePermissionMessage =>
      'Vous n\'avez pas l’autorisation de supprimer ce message.';

  @override
  String get edited => 'modifié';

  @override
  String get editMessage => 'Modifier le message';

  @override
  String get assignRoles => 'Assigner des rôles';

  @override
  String get permissions => 'Autorisations';

  @override
  String adminsOfTheGroup(Object number) {
    return 'ADMINISTRATEURS DU GROUPE ($number)';
  }

  @override
  String get addAdminsOrModerators => 'Ajouter des administrateurs/modérateurs';

  @override
  String get member => 'Membre';

  @override
  String get guest => 'Invité';

  @override
  String get exceptions => 'Cas particuliers';

  @override
  String get readOnly => 'Lecture seule';

  @override
  String readOnlyCount(Object number) {
    return 'LECTURE SEULE ($number)';
  }

  @override
  String get removedUsers => 'Utilisateurs supprimés';

  @override
  String bannedUsersCount(Object number) {
    return 'UTILISATEURS BANNIS ($number)';
  }

  @override
  String get downgradeToReadOnly => 'Passer en lecture seul';

  @override
  String memberOfTheGroup(Object number) {
    return 'Membres du groupe ($number)';
  }

  @override
  String get selectRole => 'Choisissez un rôle';

  @override
  String get canReadMessages => 'Peut lire les messages';

  @override
  String get canWriteMessagesSendReacts =>
      'Peut envoyer des messages, réagir...';

  @override
  String get canRemoveUsersDeleteMessages =>
      'Peut retirer des membres, suprimer des messages...';

  @override
  String get canAccessAllFeaturesAndSettings =>
      'Peut accéder a toutes les fonctionnalités et paramétrage';

  @override
  String get invitePeopleToTheRoom => 'Inviter des personnes dans le salon';

  @override
  String get sendReactions => 'Réagir';

  @override
  String get deleteMessagesSentByMe => 'Suprimer mes messages';

  @override
  String get notifyEveryoneUsingRoom =>
      'Notifier tout le monde en utilisant @room';

  @override
  String get joinCall => 'Rejoindre des appels';

  @override
  String get removeMembers => 'Retirer un membre';

  @override
  String get deleteMessagesSentByOthers => 'Suprimer les messages des autres';

  @override
  String get pinMessageForEveryone =>
      'Épingler un message (pour tout le monde)';

  @override
  String get startCall => 'Lancer un appel';

  @override
  String get changeGroupName => 'Modifier le nom du groupe';

  @override
  String get changeGroupDescription => 'Modifier la description du groupe';

  @override
  String get changeGroupAvatar => 'Modifier la photo de profil du groupe';

  @override
  String get changeGroupHistoryVisibility =>
      'Modifier la visibilité de l\'historique du groupe';

  @override
  String get searchGroupMembers => 'Recherche des membres du groupe';

  @override
  String get permissionErrorChangeRole =>
      'Vous n\'avez pas la permission de modifier les rôles. Veuillez contacter l\'administrateur de celui-ci pour de l\'aide.';

  @override
  String get demoteAdminsModerators =>
      'Rétrograder les administrateurs/modérateurs';

  @override
  String get deleteMessageConfirmationTitle =>
      'Êtes vous sûr de vouloir supprimer ce message ?';

  @override
  String get permissionErrorBanUser =>
      'Vous n\'avez pas la permission de bannir des membres. Veuillez contacter votre administrateur pour obtenir de l\'aide';

  @override
  String get removeMember => 'Retirer des membres';

  @override
  String get removeMemberSelectionError =>
      'Vous ne pouvez pas supprimer un membre avec un rôle égal ou supérieur que le votre.';

  @override
  String get downgrade => 'Rétrograder';

  @override
  String get deletedMessage => 'Suprimer un message';

  @override
  String get unban => 'Deban';

  @override
  String get permissionErrorUnbanUser =>
      'Vous n\'avez pas la permission d\'annuler le ban de quiconque. Veuillez contacter votre administrateur pour obtenir de l\'aide';

  @override
  String get transferOwnership => 'Définir comme nouveau propriétaire';

  @override
  String confirmTransferOwnership(Object name) {
    return 'Êtes-vous sûr de vouloir définir $name en tant que propriétaire ?';
  }

  @override
  String get transferOwnershipDescription =>
      'Ce membre obtiendra le pouvoir absolu sur ce groupe et vous perdrez vos droits sur celui ci. Cette action est irréversible.';

  @override
  String get confirmTransfer => 'Confirmer le transfert';

  @override
  String get unblockUser => 'Débloquer un membre';

  @override
  String get blockUser => 'Bloquer cet utilisateur';

  @override
  String get permissionErrorUnblockUser =>
      'Vous n\'êtes pas autorisé à débloquer cet utilisateur.';

  @override
  String get permissionErrorBlockUser =>
      'Vous n\'êtes pas autorisé à bloquer cet utilisateur.';

  @override
  String userIsNotAValidMxid(Object mxid) {
    return 'Le Matrix ID suivant n\'est pas valide : $mxid';
  }

  @override
  String userNotFoundInIgnoreList(Object mxid) {
    return '$mxid ne fait pas partie de votre liste d\'utilisateurs bloqués';
  }

  @override
  String get blockedUsers => 'Utilisateurs bloqués';

  @override
  String unblockUsername(Object name) {
    return 'Débloquer : $name';
  }

  @override
  String get unblock => 'Débloquer';

  @override
  String get unblockDescriptionDialog =>
      'Vous recevrez à nouveau des messages de cette personne. Elle ne sera pas informée que vous l\'aviez bloquée et que vous la débloquez.';

  @override
  String get report => 'Repporter';

  @override
  String get reportDesc => 'Pourquoi ce message est-il inapproprié ?';

  @override
  String get sendReport => 'Reporter';

  @override
  String get addComment => 'Ajouter un commentaire';

  @override
  String get spam => 'Spam';

  @override
  String get violence => 'Violence';

  @override
  String get childAbuse => 'Maltraitance infantile';

  @override
  String get pornography => 'Pornographie';

  @override
  String get copyrightInfringement => 'Violation du droit d\'auteur';

  @override
  String get terrorism => 'Terrorisme';

  @override
  String get other => 'Autre';

  @override
  String get enableRightAndLeftMessageAlignment =>
      'Activer l\'alignement alterné des messages';

  @override
  String get holdToRecordAudio => 'Maintenir pour enregistrer.';

  @override
  String get explainPermissionToAccessMicrophone =>
      'Autoriser Twake Chat à accéder au microphone, pour envoyer des messages vocaux.';

  @override
  String get allowMicrophoneAccess => 'Autoriser l\'accès au microphone';

  @override
  String get later => 'Plus tard';

  @override
  String get couldNotPlayAudioFile => 'Lecture du fichier audio impossible';

  @override
  String get slideToCancel => 'Glisser pour annuler';

  @override
  String get recordingInProgress => 'Enregistrement en cours';

  @override
  String get pleaseFinishOrStopTheRecording =>
      'Terminez l\'enregistrement avant d\'effectuer d\'autres actions.';

  @override
  String get audioMessageFailedToSend => 'Erreur lors de l\'envoie du vocal.';
}
