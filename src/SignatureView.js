import React, { Component } from 'react';
import {
  View,
  Text,
  requireNativeComponent,
  NativeModules,
  ViewPropTypes,
  processColor,
  findNodeHandle,
  Platform,
} from 'react-native';
import PropTypes from 'prop-types';

const SignViewNative = requireNativeComponent('SignView');
const SignViewModule = NativeModules.SignViewManager || NativeModules.SignViewModule;

class SignatureView extends Component {
  constructor(props) {
    super(props);
    this.ref = React.createRef();
  }

  clearSignature = () => {
    SignViewModule.clearSignature(findNodeHandle(this.ref.current));
  }

  _onSignAvailable = (event) => {
    const { onChangeInSign } = this.props;
    if(onChangeInSign){
      onChangeInSign(event.nativeEvent.signature);
    }
  }

  getSignatureColor = () => {
    const { signatureColor } = this.props;

    if(Platform.OS === 'android'){
      return processColor(signatureColor);
    } 

    return signatureColor;
  }

  render() {
    const { signatureColor, style, ...props } = this.props;
    return (
      <View style={style}>
        <SignViewNative
          ref={this.ref}
          style={{width:'100%', height:'100%'}}
          {...props}
          onSignAvailable={this._onSignAvailable}
          signatureColor={this.getSignatureColor()}
        />
      </View>
    );
  }
}


SignatureView.propTypes = {
  style:ViewPropTypes.style,
  onChangeInSign: PropTypes.func,
  signatureColor: PropTypes.string,
  strokeWidth: PropTypes.number,
}

SignatureView.defaultProps = {
  style:{width:'100%', height:200, backgroundColor:'white', borderWidth:2, borderColor:'black'},
  onChangeInSign: null,
  signatureColor: 'black',
  strokeWidth: 6,
}

export default SignatureView;