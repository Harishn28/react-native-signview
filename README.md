

Signature view for react-native.

## installing
`npm i react-native-signview`

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
