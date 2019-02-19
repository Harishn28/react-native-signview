

Signature view for react-native.

## installing
`npm i react-native-signview`

`react-native link`

for **IOS** users, if you get any error in building, please create an empty swift file in your project [COULD NOT FOUND AUTOLIKED LIBRARY](https://stackoverflow.com/questions/50096025/it-gives-errors-when-using-swift-static-library-with-objective-c-project/50495316#50495316)

## usage
```
...
import {Text, Button, View} from 'react-native';
import { SignatureView } from 'react-native-signview';

export default class SomeComponent extends Component<Props> {

...

  render() {
    return (
      <View style={{flex:1}}>
        <SignatureView />
      </View>
    );
  }
}
```
## Properties
* ###### style: [View Styles](https://facebook.github.io/react-native/docs/view-style-props)
* ###### signatureColor: Color for signature(stroke color)
* ###### strokeWidth: width of signature (stroke width)

## Callbacks
* ###### onChangeInSign: Triggered whenever there is a change in signature. Base64 string of signature will be passes as parameter.

## Methods
* ###### clearSignature: When called it'll clear the signature. onChangeInSign gets triggered with null as parameter.

## Example
```
import React, {Component} from 'react';
import { StyleSheet, Text, Button, View} from 'react-native';
import { SignatureView } from 'react-native-signview';

export default class App extends Component<Props> {
  constructor(props){
    super(props);
    this.signView = React.createRef();
  }

  clearSignature = () => {
    if(this.signView && this.signView.current){
      this.signView.current.clearSignature();
    }
  }

  onChangeInSign = (base64StringOfSign) => {
    if(base64StringOfSign){
      console.log('Signature Available', base64StringOfSign.length);
    } else{
      console.log('No Signature');
    }
  }

  render() {
    return (
      <View style={styles.container}>
        <Text>Sign in below box</Text>
        <SignatureView 
          ref={this.signView}
        />
        <Button title={'clear signature'} onPress={this.clearSignature}/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
});

```
