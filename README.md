# Campus Bus Tracking Mobile Applications

## Project Overview

The Campus Bus Tracking Mobile Applications system is designed to improve the commuting experience for students and staff at the KNUST campus. The system consists of two mobile applications:

1. Driver Application: Enables shuttle drivers to share their real-time location with the central system.
2. Student and Staff Application: Allows students and staff to track the location of shuttles in real-time, view estimated arrival times, and select preferred routes.

This project is intended to provide a reliable and efficient way for the campus community to monitor shuttle movements, reducing wait times and enhancing overall transportation logistics.

## Features

### Driver Application
- Real-Time Location Sharing: Drivers can broadcast their real-time location to the system.
- Route Assignment: Displays the assigned route to the driver.
- Status Updates: Allows drivers to manually update their status (e.g., "En Route," "At Stop").

### Student and Staff Application
- Real-Time Shuttle Tracking: Track the current location of shuttles on a map.
- Estimated Time of Arrival (ETA): Provides real-time updates on the shuttle's ETA at selected stops.
- Route Selection: Users can select and view different shuttle routes available on campus.
- Notifications: Alerts users when the shuttle is approaching their stop.

## Installation

### Prerequisites
- Flutter SDK
- Dart SDK
- Firebase Account (for backend services)
- Google Maps API Key

### Setup Instructions

1. Clone the Repository:
   ```bash
   git clone https://github.com/Pa-ppy/Bus_system.git
   cd Bus_system
   ```

2. Install Dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Create a Firebase project.
   - Add Android and iOS apps to your Firebase project.
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) and place them in the appropriate directories.
   - Enable Firestore and Authentication in the Firebase console.

4. Add Google Maps API Key:
   - Go to your Google Cloud Console.
   - Generate an API key for Google Maps.
   - Add the API key to your `AndroidManifest.xml` and `Info.plist` files.

5. Run the Application:
   ```bash
   flutter run
   ```

## Usage

1. Driver Application:
   - Log in using the credentials provided by the admin.
   - Start sharing your location by toggling the location-sharing button.
   - Monitor your route assignment and update your status as needed.

2. Student and Staff Application:
   - Open the app and select your desired route.
   - Track the shuttle in real-time on the map.
   - Receive notifications when the shuttle is nearing your stop.

## Testing

The application has undergone extensive testing, including:
- Unit Testing: Verification of individual components like the map interface, route selection, and location sharing.
- Integration Testing: Ensuring seamless interaction between the Firebase backend and the mobile front-end.
- System Testing: End-to-end testing of the entire user journey from the driver sharing their location to students and staff tracking the shuttle in real-time.

For more detailed information on the testing process, please refer to the documentation.

## Project Structure

```
campus-bus-tracking/
│
├── lib/
│   ├── models/           # Data models for the app
│   ├── screens/          # UI screens for different parts of the app
│   └── main.dart         # Main entry point of the application
│
├── assets/               # Images, icons, and other assets
├── android/              # Android-specific files and configurations
├── ios/                  # iOS-specific files and configurations
└  
```

## Contributing

Contributions are welcome! If you'd like to contribute, please fork the repository and use a feature branch. Pull requests are reviewed and approved as necessary.

## Acknowledgments

- Special thanks to my project supervisor for guidance and support.
- Thanks to the KNUST community for their feedback during the testing phase.
- Thanks to all contributors and open-source projects that made this project possible.

