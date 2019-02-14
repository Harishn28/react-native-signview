import React, { Component } from 'react';
import {
  View,
  Text,
  requireNativeComponent,
  NativeModules,
  ViewPropTypes,
  processColor,
  findNodeHandle,
} from 'react-native';

const SignViewNative = requireNativeComponent('SignView');
const SignViewModule = NativeModules.SignViewManager;

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

  render() {
    const { signatureColor, style, ...props } = this.props;
    return (
        <SignViewNative
          ref={this.ref}
          style={{...style}}
          {...props}
          onSignAvailable={this._onSignAvailable}
          signatureColor={processColor(signatureColor)}
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