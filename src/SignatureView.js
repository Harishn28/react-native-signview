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
const SignViewModule = NativeModules.SignViewModule;

console.log('--------SignViewModule ', SignViewModule);

class SignatureView extends Component {
  constructor(props) {
    super(props);
    this.ref = React.createRef();
    this.state = {
      message: 'hello'
    }
  }

  clearSignature = () => {
    SignViewModule.clearSignature(findNodeHandle(this.ref.current));
  }

  onSignAvailable = (event) => {
    const { onChangeInSign } = this.props;
    if(onChangeInSign){
      onChangeInSign(event.nativeEvent.signature);
    }
  }

  render() {
    const { signatureColor, style, ...props } = this.props;
    return (
      <View style={style}>
        <SignViewNative
          ref={this.ref}
          style={{width:'100%', height:'100%'}}
          {...props}
          onSignAvailable={this.onSignAvailable}
          signatureColor={processColor(signatureColor)}
        />
      </View>
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