import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, FlatList} from 'react-native';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      dataSource: []
    }
  }
  componentDidMount(){
    return fetch('https://reactnative.dev/movies.json')
    .then((response) => response.json())
    .then((responseJson) => {
      this.setState({ dataSource: responseJson.movies});
    })
  }
  render(){
    return (
      <View style={styles.container}>
        <FlatList
          data={this.state.dataSource}
          renderItem={({item}) =><Text>{item.title}</Text>}
          //keyExtractor={(item, index) => index}
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default App;