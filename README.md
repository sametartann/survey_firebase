# Survey Demo Firebase App
## Description

This Flutter app demonstrates a simple survey system using Firebase Firestore. Users can view a list of programming languages with their associated votes and increment the vote count by tapping on each item.

## Features

- **Real-time Data**: The app fetches survey data from Firebase Firestore in real-time and updates the UI automatically.
- **Interactive UI**: Users can vote for their favorite programming languages by tapping on the list items.
- **Firebase Integration**: Utilizes Firebase Firestore for data storage and retrieval.

## Requirements

- Flutter SDK
- Firebase Account
- Firebase Firestore

## Setup

1. **Clone the Repository:**
   ```
   git clone https://github.com/sametartann/survey_firebase.git
    ```
2. **Navigate to the Project Directory:**
    ```
    cd survey_firebase
     ```
3. **Install Dependencies:**
    ```
    flutter pub get
     ```
4. **Setup Firebase:**
   - Create a Firebase project on the Firebase Console.
   - Add your Flutter app to the Firebase project and follow the setup instructions.
   - Download the google-services.json file and place it in the android/app directory.
   - Make sure to configure Firebase for both Android and iOS as per the official documentation.

5. **Run the App:**
    ```
    flutter run
     ```

