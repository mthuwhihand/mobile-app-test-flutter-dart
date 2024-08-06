# Mobile App Test

## Introduction

This Flutter project is a new testing application. It includes basic features for testing and developing mobile applications using Flutter.

## Technical

 ● Using Flutter, Dart.<br>
 ● Use the MVVM pattern.<br>
 ● Manage state with BLoC.<br>
 ● Store data using the Shared Preferences plugin<br>
 
## Functions
Login/Logout: using [Shared Preferences](https://sampleapis.com/](https://pub.dev/packages/shared_preferences)) to save/remove login info.<br>
Home Screen: <br>
 ● Display a list view of movies which are called from api of [Sample APIs](https://sampleapis.com/)<br>
The api is 
   ```
   https://api.sampleapis.com/movies/animation
   ```

 ● Pull to Refresh: Allow users to refresh the list of movies by pulling down on the screen.<br>
 ● Pull to Refresh: Allow users to refresh the list of movies by pulling down on the screen.<br>
 ● Load More Items: Load additional movies when the user scrolls down (pagination).<br>

## Installation

To run this application on your machine, follow these steps:
1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/mobile_app_test.git
   cd mobile_app_test

2. **Install Dependencies**
Make sure the pubspec.yaml like this:
   ```
   name: mobile_app_test
   description: "A new Flutter testing project."
   publish_to: 'none'
   version: 1.0.0+1
   
   environment:
     sdk: '>=3.4.4 <4.0.0'
   
   dependencies:
     flutter:
       sdk: flutter
   
     cupertino_icons: ^1.0.6
     shared_preferences: ^2.0.13
     flutter_bloc: ^8.1.6
     equatable: ^2.0.5
     http: ^1.2.2
   
   dev_dependencies:
     flutter_test:
       sdk: flutter
   
     flutter_lints: ^3.0.0
   
   flutter:
   
     uses-material-design: true
   
     assets:
       - assets/
       - assets/mock/
       - assets/imgs/
   ```
focus on version, environment, dependencies and assets.
Make sure you have Flutter installed. Then, install the project dependencies
   ```
   flutter pub get
   ```
3. **Run the Application**
Use the following command to run the app on a device or emulator, or you can use other methods to run it, such as using an IDE:
   ```
   flutter run
   ```
## **Dependencies**
This project uses the following dependencies:
   ```
   flutter - Main Flutter SDK.
   cupertino_icons - Cupertino icons for iOS style icons.
   shared_preferences - For simple data storage.
   flutter_bloc - Library for Bloc state management.
   equatable - Provides a base class for value equality.
   http - Library for making HTTP requests.
   ```
## Project Structure

### lib/
```plaintext
lib/
   ├── blocs/
   │   ├── auth_bloc/
   │   │   ├── auth_bloc.dart
   │   │   ├── auth_event.dart
   │   │   ├── auth_state.dart
   │   └── home_bloc/
   │       ├── home_bloc.dart
   │       ├── home_event.dart
   │       ├── home_state.dart
   ├── models/
   │   ├── movie_model.dart
   │   ├── user_model.dart
   ├── repositories/
   │   ├── auth_repository.dart
   │   ├── movie_repository.dart
   ├── views/
   │   ├── widgets/
   │   │   └── network_image_with_fallback.dart
   │   └── screens/
   │       ├── home_view.dart
   │       ├── login_view.dart
   ├── utils/
   │   └── validators.dart
   └── main.dart
```
