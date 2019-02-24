

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, Button, View} from 'react-native';
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
      console.log('Signature Available', base64StringOfSign);
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
          onChangeInSign={this.onChangeInSign}
          style={styles.signBox}
          strokeWidth={2}
          signatureColor={'red'}
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
  signBox: {
    height:200,
    width:'90%', 
    margin:20,
    backgroundColor:'white',
    borderColor:'black',
    borderWidth:1,
    borderRadius:4
  }
});
