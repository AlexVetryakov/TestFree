#  README:

## Application Tasks:
1) User should shake device to get answer.
2) Application gets random answers from endpoint https://8ball.delegator.com/magic/JSON/    <question_string>. You are free to use any string as parameter (no need to send     actual question) 
3) Any loaded answer should be stored
4) In case of internet connection absence or request failure, application uses one of     hardcoded answers
5) Application should have two screens: Main and Settings
6) Main screen contains call-to-shake text or answer, depending on current application state Settings screen allows user to set and save hardcoded answers  like ""Just do it!"", ""Change your mind"", etc.
7) Add counter of shake attempts. Store value in Keychain and display it somewhere in UI


## Technical Description
### Development Tools
MacOS Mojave v.10.14.5
XCode v.10.2
Language Swift v.5

### Build Notes:
You should run "pod install" command in terminal before building application.

### Requirements for application launch:
iPhone supported iOS: v. 12.0 or higher

## For Developers
### Technologies:
- MVVM
- Coordinators
- Alamofire
- RXSwift, RxDataSources, RXCocoa
- Programmatically creation of layouts using SnapKit
- Realm
- SwiftGen

### Recommendations for expansion:
- All images should be stored inside `Assets` in appropriate subfolder
- All colors should be stored inside `Assets\Colors`
- All strings must be localized. You should write localization keys in `Resources\Localizable.strings`
- All strings and Assets generated programmatically
- You should use `DataBaseProvider`, `NetworkProvider`, `KeychainProvider` to "talk" with database, server and keychains
- You should create new coordinator with `NavigationNode` as a Parent class, if you need to create new Flow
