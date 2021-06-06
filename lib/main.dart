import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


final _suggestions = <WordPair>[];
Set<WordPair> saved=<WordPair>{};
final _biggerFont = const TextStyle(fontSize: 18.0);

void main() => runApp(MyApp());

// #docregion MyApp
class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
// #enddocregion build
}
// #enddocregion MyApp

// #docregion RWS-var
class _RandomWordsState extends State<RandomWords>{

  // #enddocregion RWS-var



  // #docregion _buildSuggestions
  Widget _buildSuggestions() {

    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(WordPair pair) {
    final alreadySaved = saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            saved.remove(pair);
          } else {
            saved.add(pair);
          }
        });
      },
    );
  }
  // #enddocregion _buildRow

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),

    );
  }
  // #enddocregion RWS-build

  void _pushSaved() {
    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute(
        builder: (context) {


          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: saved.length,
                itemBuilder: /*1*/ (context, i) {

                  return SavedWords(saved.elementAt(i));
                })
          );
        },
      ), // ...to here.
    );
  }

  Widget SavedWords(WordPair pair){

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),

      onTap: () {
        setState(() {
          saved.remove(pair);

          Navigator.push(context,MaterialPageRoute(

            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            builder: (context) => MyApp(),
          ));
        },
        );
      }
       );
    }





// #docregion RWS-var
}
// #enddocregion RWS-var

class RandomWords extends StatefulWidget {
  @override
  State<RandomWords> createState() => _RandomWordsState();
}


/*

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.


  // In the constructor, require a Todo.


  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as ;
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }



}

*/
