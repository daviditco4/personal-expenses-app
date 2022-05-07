# Personal Expenses App

This basic app lets you save your daily expenses and portrays them in a bar chart.
Also, this is the second Flutter app I made in Academind's Flutter & Dart course.

Links to the course:

* On Udemy.com - [Flutter & Dart - The Complete Guide](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/)
* On Academind.com - [Learn Flutter & Dart to Build iOS & Android Apps](https://pro.academind.com/p/learn-flutter-dart-to-build-ios-android-apps-2020)

## Table of contents

* [Concepts used during development](#concepts-used-during-development)
* [Getting started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [How to use](#how-to-use)
    * [Screenshots](#screenshots)
* [Built with](#built-with)
* [Authors](#authors)
* [License](#license)

## Concepts used during development

* Core widgets
  * Row & Column
  * ScrollView
  * ListView vs. ListView.builder
  * TextField
  * Stack
  * Flexible & Expanded
  * ListTile
  * IconButton
* Styling
  * Container decoration
  * Text style
* Theming & assets
  * Custom fonts
  * Custom images
* More Dart basics
  * "for" loops
* Date formatting with a package (intl)
* Responsive UI
  * Getting the device's size & orientation (MediaQuery)
  * Using the textScaleFactor property of MediaQueryData
  * LayoutBuilder
  * Controlling the device orientation
  * Respecting the soft keyboard inset
  * SafeArea
* Adaptive UI
  * Showing different content based on device platform
  * Cupertino (iOS-style) widgets
* Widget & Flutter internals
  * Widget, Element & Render trees
  * How Flutter rebuilds and repaints the screen
  * How Flutter executes "build()"
  * Life cycle of a widget ("initState()", "didUpdateWidget()", "dispose()", etc.)
  * Life cycle of an app ("inactive", "paused", "resumed" and "suspending")
  * InheritedWidget & context
  * Keys and when to use them
* Writing good code
  * Extracting widgets
  * Builder methods

## Getting Started

Read this for downloading and installing the app from your mobile device.

### Prerequisites

You'll need:

```
- Android Jelly Bean or later (version 4.1, API level 16).

- Installation of apps from unknown sources permitted (see the "Setting up your device"
section at https://www.cnet.com/tech/mobile/how-to-install-apps-outside-of-google-play/).

- The application's binary file (download from the "Releases" section in this project's
GitHub repository home page), then begin the installation by opening the file.
```

### How to use

1. Open the app.
2. Tap the "+" button next to the app bar's title or the one at the bottom of the screen.
3. Enter your expense's title, amount and date.
4. Tap "Add Transaction".
5. If your phone is in landscape mode, you can view the expenses chart by toggling the "Show chart" switch.
6. In the list of expenses, tap the "delete" button of an entry to delete it.

#### Screenshots

<p float="left">
  <img alt="App Screenshot 1" src="/dev_assets/images/app_screenshot_1.png" width="250" />
  <img alt="App Screenshot 2" src="/dev_assets/images/app_screenshot_2.png" width="250" />
  <img alt="App Screenshot 3" src="/dev_assets/images/app_screenshot_3.png" width="250" />
  <img alt="App Screenshot 4" src="/dev_assets/images/app_screenshot_4.png" width="250" />
  <img alt="App Screenshot 5" src="/dev_assets/images/app_screenshot_5.png" width="250" />
</p>
<p float="left">
  <img alt="App Screenshot 6" src="/dev_assets/images/app_screenshot_6.png" width="444" />
  <img alt="App Screenshot 7" src="/dev_assets/images/app_screenshot_7.png" width="444" />
</p>

## Built with

* [Dart 2.13.4](https://dart.dev/) - The programming language used

## Authors

* **David Itcovici** - [LinkedIn](https://www.linkedin.com/in/david-itcovici/)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
