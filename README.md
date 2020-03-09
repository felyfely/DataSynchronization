# DataSynchronization
A generic data layer

## Installation

DataSynchronization is available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:

```ruby
github "felyfely/DataSynchronization" "master"
```

## Usage

###### Swift
```swift
struct YourCustomRequestStruct: DataRequestable {}
enum YourCustomRequestEnum: DataRequestable {}

customRequest.request{ (result: Result<YourDecodableType, Error>) in
```
