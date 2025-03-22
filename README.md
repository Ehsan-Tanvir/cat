# CAT 🐱  

**An offline mobile app for seamless attendance management.**  

## 📌 About  
CAT is designed for teachers and students to manage attendance effortlessly. Teachers can create sessions, and students can enter their roll numbers directly on the teacher’s device. The app works entirely offline and generates attendance reports as PDFs.  

## ✨ Features  
- **Offline Accessibility** – Works without internet.  
- **Easy Attendance Tracking** – Teachers set up sessions with student count validation.  
- **Real-Time Updates** – Prevents duplicate roll numbers and updates count live.  
- **Automated PDF Reports** – Saves attendance records in the device’s Downloads Directory.  

##🛠️ Setup Guide  
1. Clone the repository:  
   ```sh
   git clone https://github.com/Ehsan-Tanvir/CAT.git
   ```
2. Navigate to the project folder:
   ```sh
   cd CAT
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## 📺 Build APK
To generate an APK file and install it on your device, follow these steps:

1. Run the following command:
 ```sh
flutter build apk --build-name=1.0 --build-number=1
```
This will generate a release APK at:
 ```sh
build/app/outputs/flutter-apk/app-release.apk
```
2. Move the APK to your phone and install it manually.

