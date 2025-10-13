# Dedi Chat Client

<br />
<div align="center">
  <h2>Dedi Chat</h2>
  <p>A secure, decentralized Matrix-based chat application</p>
</div>

Dedi Chat is an open source, decentralized chat app based on the Matrix protocol. It was developed by DediApp. Dedi Chat is a good option for individuals and organizations who are looking for a secure and decentralized chat app. It is also a good choice for developers who want to build their own Matrix-based chat apps.

## Features

- Send all kinds of messages, images and files
- Voice messages
- Location sharing
- Push notifications
- Unlimited private and public group chats
- Public channels with thousands of participants
- Feature rich group moderation including all matrix features
- Discover and join public groups
- Dark mode
- Custom themes
- Hides complexity of Matrix IDs behind simple QR codes
- Custom emotes and stickers
- Spaces
- Compatible with Element, Nheko, NeoChat and all other Matrix apps
- End to end encryption
- Emoji verification & cross signing
- And much more...

## Development

Please make sure to run the following command at first, to verify your code before each commit:

```bash
bash scripts/config-pre-commit.sh
```
### Requirements

- [ ] Flutter 3.24 (more recent versions are not yet supported)

You can at any moment verify your flutter installation using:

```bash
flutter doctor -v
```

#### Web

If you only plan to work on the `web` target we recommend installing Google Chrome as it is the default supported target *(Flutter being developped by Google)*.

It is also **required** to have a web ready version of libolm available in the `assets/js/package` folder. You can build a version using:

```bash
docker run -v ./assets/js/package:/package nixos/nix:2.22.1

# within the docker
nix build -v --extra-experimental-features flakes --extra-experimental-features nix-command gitlab:matrix-org/olm/3.2.16?host=gitlab.matrix.org\#javascript
cp /result/javascript/* /package/. -v
exit

# back on your host
sudo chown $(id -u):$(id -g) ./assets/js/package -Rv
```
#### Android

- [ ] An implementation of JDK 17 *(tested with openjdk-17.0.13+11)*
- [ ] (Optional) Android Studio
- [ ] An Android SDK with:
  - [ ] Android build tools: 34.0.0
  - [ ] Android platform: 31, 32, 33, 34, 35
  - [ ] CMake: 3.22.1
  - [ ] Android NDK: 26.1.10909125
  - [ ] Google APIs: enabled

*Note: Gradle will try to install the JDK 8. If for any reasons the operation failed, try to install your own JDK manually.*

#### Linux

- [ ] Lib JsonCPP
- [ ] Lib Secret
- [ ] Lib RHash
- [ ] Lib WebKit 2 GTK
- [ ] Lib OLM

*If needed, a complete list is available in the `flake.nix`.*

On Ubuntu, the following command should install all the required elements:

```bash
sudo apt install libjsoncpp1 libsecret-1-dev libsecret-1-0 librhash0 libwebkit2gtk-4.0-dev libolm3
```
---

In addition, the Linux build requires Rust. For macOS or Linux, execute the following command in a terminal emulator:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
For Windows, download and install the official Rust installer.

In case you have Rust already installed, make sure to update it to latest version:

```bash
rustup update
```

#### [`devenv.nix`](devenv.nix)

A `devenv.nix` is provided in order to ease the process of setting up your dev environment.

Then you can use `devenv shell` to fire up your environment.

Supported platforms:

- [x] Linux x86_64
- [ ] MacOS aarch_64
- [ ] MacOS x86_64
- [ ] Windows WSL

### Configure the app

In order to run the web target you must provide a default configuration file. This can be done by copying the `config.sample.json` to `config.json`.
Here is an example working with `matrix.org`:

```json
{
  "application_name": "Dedi Chat",
  "application_welcome_message": "Welcome to Dedi Chat!",
  "default_homeserver": "matrix.org",
  "privacy_url": "https://dedim.com.tr/en/privacy/",
  "render_html": true,
  "hide_redacted_events": true,
  "hide_unknown_events": true,
  "issue_id": "",
  "app_grid_dashboard_available": false,
  "homeserver": "https://matrix.org/",
  "platform": "localDebug",
  "default_max_upload_avatar_size_in_bytes": 1000000,
  "dev_mode": true,
  "qr_code_download_url": "https://sign-up.dedim.com.tr/download/chat",
  "enable_logs": true,
  "support_url": "https://dedim.com.tr/support",
  "cozy_external_bridge_version": "0.16.1"
}
```

### Runing the code

Before running the app, please update the dependancies:

```bash
flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
```

Now you can run the project:

```bash
flutter devices   # To list available run targets
```

```bash
# flutter run -d <device>, e.g:
flutter run -d chrome
```

## Build

Please use the helper script corresponding to your target in order to build:

### Web

```bash
./scripts/build-web.sh
```

### Linux

```bash
# ./scripts/build-linux.sh          ## For release purposes
./scripts/build-linux-debug.sh
```

### Android

```bash
# ./scripts/build-android-apk.sh    ## For release purposes
./scripts/build-android-debug.sh
```

## Development Notes

- This project uses FVM (Flutter Version Management) for version control
- All Flutter commands should be prefixed with `fvm`
- The project follows Matrix protocol standards for compatibility
- For development setup, refer to the requirements section above
