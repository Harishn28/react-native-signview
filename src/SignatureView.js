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
        <SignViewNative
          ref={this.ref}
          style={{...style}}
          {...props}
          onSignAvailable={this._onSignAvailable}
          signatureColor={this.getSignatureColor()}
        />
    );
  }
}


// SignatureView.propTypes = {
//   style:ViewPropTypes.style,
//   onSignAvailable: PropTypes.func,
//   signatureColor: PropTypes.string,
//   strokeWidth: PropTypes.number,
// }

// SignatureView.defaultProps = {
//   style:null,
//   onSignAvailable: null,
//   signatureColor: 'black',
//   strokeWidth: 10,
// }

export default SignatureView;