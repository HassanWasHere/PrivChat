import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import io from 'socket.io-client';

export const socket = io("http://127.0.0.1:5000/");

export default function App() {
  return (
    <View style={styles.container}>
      <Text>YEP Woohoo! Open up App.js to start working on your app!</Text>
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
