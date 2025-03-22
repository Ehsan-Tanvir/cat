# cat 🐱

## Overview  
**cat** is an offline, cross-platform mobile app build in flutter for seamless attendance management. It allows teachers to create sessions where students enter their roll numbers directly on the teacher's device. The app generates attendance reports as PDFs and works entirely offline.

## Features  
- **Offline Accessibility** – No internet required.
- **Easy Attendance Tracking** – Teachers create sessions with student count validation.
- **Real-Time Updates** – Prevents duplicate roll numbers and updates count live.
- **Automated PDF Reports** – Saves attendance records in the device’s Downloads Directory.

## Setup & Installation  
### Prerequisites  
- **Flutter SDK** installed on your machine.

### Steps  
1. Clone the repository:  
   ```sh
   git clone https://github.com/Ehsan-Tanvir/cat.git
   ```
2. Navigate to the project folder:
   ```sh
   cd cat
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## Building APK  
To generate an APK file:
```sh
flutter build apk --build-name=1.0 --build-number=1
```
This will generate a release APK at:
```sh
build/app/outputs/flutter-apk/app-release.apk
```

---
