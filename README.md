# Weather App iOS project

"Weather App" the [openweathermap](https://openweathermap.org/api) current weather search client on iOS platform


## Getting Started

```
pod install
```

##### Prerequisites

- Xcode 11.2.1 or any version which is support `Swift 5.0`
- `Cocoapods` as a dependency manager
- Device or simulator which has `iOS 13.0` installed as a `minimum iOS version`

##### Installing

1. Download or clone the project from this repository
2. Install the pod dependencies by this command line `$ pod install`
3. Open `weather-app.xcworkspace` and try to build project

## Project structure

The project structure would be describe on these topic below

##### Structure

- weather-app.xcodeproj --- The project files
- weather-app.xcworkspace	--- The Xcode workspace file (including one or more project)
- weather-app	--- All project files
- weather-appTests --- Project testing target
- Podfile --- CocoaPods dependencies

##### Software Architecture

- VIPER

##### Modules

- Weather : A module to present the weather and search functions
- RecentSearches: A module to present search history and delete functions

## Built With
- Alamofire
- Log
- Kingfisher
- Alamofire
- RxSwift, RxCocoa, RxCoreLocation
- MaterialComponents/Snackbar
