import React, { Component } from 'react';
import { View, Text, requireNativeComponent, ViewPropTypes } from 'react-native';

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
    return(
      <SignViewNative 
         {...this.props}
        onSignAvailable={this.onSignAvailable}
        signatureColor={0x00f0}
      />
    );
  }
}

export default SignatureView;