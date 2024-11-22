# IMAN - Islamic Questions & Answers App

## Overview

IMAN is a Flutter-based mobile application that serves as a platform for users to ask questions about Islamic topics and receive answers from qualified scholars. The app provides a user-friendly interface for accessing Islamic knowledge, with features like topic categorization, favorites, and personal question tracking.

## Features

- 🔍 Topic-based question browsing
- ❓ Anonymous question submission
- 🔐 Secure authentication (Google & Apple Sign-in)
- 👤 Personal question tracking
- ⭐ Favorite questions management
- 🔔 Push notifications for answers
- 🌙 Clean and intuitive UI

## Tech Stack

- Flutter 3.0+
- Firebase (Auth, Database, Analytics, Messaging)
- BLoC Pattern for state management
- Google & Apple Sign-in integration

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0 <4.0.0)
- Dart SDK (>=3.0.0)
- iOS 13.0+ for iOS deployment
- Android SDK 23+ for Android deployment
- Firebase project setup

## Project Structure

lib/
├── src/
│ ├── features/ # Feature-based modules
│ │ ├── authentication/ # Auth related features
│ │ ├── home/ # Home screen features
│ │ ├── questions/ # Question management
│ │ └── profile/ # User profile features
│ └── shared/ # Shared utilities and widgets

## Architecture

The app follows a feature-first architecture with BLoC pattern for state management:

- Features are organized in separate modules
- Each feature contains its own presentation, domain, and data layers
- Shared components are extracted into the shared directory
- BLoC/Cubit handles state management
- Repository pattern for data access

## Configuration

The app requires several configuration files:

- Firebase configuration files
- Signing configurations for release builds
- Environment-specific variables

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under standard copyright laws. All rights reserved.

## Contact

For support or queries, please refer to the FAQ section in the app or contact through the app store listing.

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All contributors who have helped shape this project
