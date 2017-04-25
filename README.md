
# React Native Braintree Drop-in UI

![Braintree Drop-in UI Gif](https://raw.githubusercontent.com/yusufyildirim/react-native-braintree/develop/drop-in-ui.gif)


## Getting started

`$ npm install react-native-braintree --save`

### Mostly automatic installation

`$ react-native link react-native-braintree`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-braintree` and add `RNBraintree.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNBraintree.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNBraintreePackage;` to the imports at the top of the file
  - Add `new RNBraintreePackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-braintree'
  	project(':react-native-braintree').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-braintree/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-braintree')
  	```

## Usage
```javascript
import RNBraintree from 'react-native-braintree';

// TODO: What to do with the module?
RNBraintree;
```
  
