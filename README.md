# 📡 Morse Code Translator

Morse Code Translator is a simple and intuitive Flutter application that allows users to translate text to Morse code and vice versa. It also provides a reference table for Morse code alphabets and numbers, along with sound playback for better learning.

---

## 📌 Features

✅ **Instant Translation** – Convert text to Morse code and vice versa in real time.  
✅ **Complete Morse Alphabet** – Learn A-Z Morse codes with an easy-to-read table.  
✅ **Morse Numbers Guide** – Quickly reference Morse code for numbers 0-9.  
✅ **Audio Support** – Listen to the correct Morse code sounds.  
✅ **Clean UI** – Simple and intuitive design for easy use.

---

## 📲 Installation

### Clone the repository:

```sh
git clone https://github.com/your-repo/morse-code-translator.git
cd morse-code-translator
```

### Install dependencies:

```sh
flutter pub get
```

### Run the app:

```sh
flutter run
```

---

## 🔧 Configuration

### Change App Name

Modify the app name in `pubspec.yaml` using `flutter_launcher_name`:

```yaml
dev_dependencies:
  flutter_launcher_name: ^0.0.1

flutter_launcher_name:
  name: "Morse Translator"
```

Then run:

```sh
flutter pub get
flutter pub run flutter_launcher_name:main
```

### Change App Icon

1. Replace the icon files in `assets/icon/`.
2. Update the icons using:

```sh
flutter pub run flutter_launcher_icons:main
```

---

## 📂 Project Structure

```
lib/
│-- main.dart          # Entry point of the app
│-- pages/
│   │-- home_page.dart  # Main tab navigation
│   │-- translator_page.dart  # Text to Morse translator
│   │-- alphabet_page.dart  # Morse alphabet reference
│   │-- number_page.dart  # Morse number reference
│
│-- assets/
│   │-- audios/   # Morse sound files
│   │-- icons/    # App icons
```

---

## 🛠️ Dependencies

- `flutter_launcher_icons` – Set custom app icons
- `flutter_launcher_name` – Modify app name easily
- `audioplayers` – Play Morse code sounds

Install them with:

```sh
flutter pub get
```

---

## 📜 License

This project is licensed under the MIT License

---

## Website

[Morse Code Translator](https://www.morsecode.club)
[iOS App](https://apps.apple.com/tw/app/morse-code-club/id6742086747)
[Android App](https://play.google.com/store/apps/details?id=com.kuantark.morse_code)

## 🌟 Support

If you like this project, give it a ⭐ on GitHub!
