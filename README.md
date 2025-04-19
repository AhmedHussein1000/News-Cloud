# News Cloud

A Flutter application that displays the latest news in a simple, clean, and user-friendly interface. The app fetches real-time news and categorizes it for a better reading experience. Built using Clean and maintainable folder structure and state management with Cubit.

## Demo

[▶️ Watch Demo Video](https://drive.google.com/file/d/15ay2_y2mncf3IAx0xHBxrkzyQb6GgzXS/view?usp=drivesdk)

This video showcases the app's functionality, including browsing categories, reading news articles, and refreshing content.

## Features

- Browse latest news articles
- View detailed news articles
- Categorized news filtering
- Offline-first experience using Hive
- Clean and maintainable folder structure
- State management with Cubit and flutter_bloc

## Getting Started

To run the app locally:

```bash
git clone https://github.com/AhmedHussein1000/News-Cloud.git
cd News-Cloud
flutter pub get
flutter run

## Folder Structure

lib/
│
├── core/                          # Reusable core modules
│   ├── cache/                     # Local cache logic (e.g. Hive)
│   ├── cubits/                    # Shared cubits used globally
│   ├── di/                        # Dependency injection setup
│   ├── errors/                    # Custom error handling
│   ├── functions/                 # Global reusable functions
│   ├── helpers/                   # Helper methods/utilities
│   ├── network/                   # API services and interceptors
│   ├── routing/                   # Named routes and navigation
│   ├── themes/                    # Light/Dark themes
│   ├── utils/                     # Constants, enums, extensions
│   └── widgets/                   # Shared widgets (buttons, loaders…)
│
├── features/
│   └── news/
│       ├── data/
│       │   ├── data_sources/      # API sources for news fetching
│       │   ├── models/            # Data models (e.g. ArticleModel)
│       │   ├── repositories/      # Implementations of repositories
│       │   └── static_data/       # Static data (e.g. categories list)
│       │
│       └── presentation/
│           ├── controllers/       # Cubits for managing state
│           ├── screens/           # Screen UI widgets (e.g. Home, Category)
│           └── widgets/           # News cards, builders, etc.
│
├── custom_bloc_observer.dart      # Custom BlocObserver for debugging
└── main.dart                      # Entry point of the app

 
