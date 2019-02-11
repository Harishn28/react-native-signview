

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

  render() {
    return (
      <View style={styles.container}>
        <Text>Sign in below box</Text>
        <SignatureView 
        ref={this.signView}
        style={{
          width:300, 
          height:200, 
          borderWidth:2, 
          borderColor:'black',
        }}
        signatureColor={'black'}
        strokeWidth={40}
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
