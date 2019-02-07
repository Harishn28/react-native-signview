import React, { Component } from 'react';
import { View, Text, requireNativeComponent, ViewPropTypes, processColor } from 'react-native';

const SignViewNative = requireNativeComponent('SignView');

class SignatureView extends Component{
  constructor(props){
    super(props);
    this.state = {
      message: 'hello'
    }
  }

  onSignAvailable = (event) => {
    console.log('----sign=', event.nativeEvent.signature);
    
  }

  render(){
    const { signatureColor } = this.props;
    return(
      <SignViewNative 
         {...this.props}
        onSignAvailable={this.onSignAvailable}
        signatureColor={processColor(signatureColor)}
      />
    );
  }
}

export default SignatureView;