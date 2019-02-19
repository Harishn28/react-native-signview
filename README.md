

Signature view for react-native.

#Getting Started

##installing
`npm i react-native-signview`



import { SignatureView } from 'react-native-signview';

Use as a normal view in you app.

```
<SignatureView 
    ref={this.signView}
    style={{
        width:300, 
        height:200, 
        borderWidth:2, 
        borderColor:'black',
    }}
    signatureColor={'red'}
    strokeWidth={40}
/>
```
