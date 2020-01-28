import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample/app/blocs/word/event.dart';
import 'package:provider/provider.dart';

import 'package:flutter_sample/app/blocs/word/bloc.dart';
import 'package:flutter_sample/app/blocs/word/state.dart';

import 'package:flutter_sample/domain/models/word.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WordShowBloc>(
      create: (BuildContext context) => WordShowBloc()..add(const WordNext()),
      child: HomeView(),
    );
  }
}

class WordNotifier extends ValueNotifier<Word> {
  WordNotifier(Word value) : super(value);
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('英単語帳'),
      ),
      body: ChangeNotifierProvider<WordNotifier>(
        create: (BuildContext context) => WordNotifier(null),
        child: BlocConsumer<WordShowBloc, WordState>(
          listener: (BuildContext context, WordState state) {
            final WordNotifier notifier = Provider.of<WordNotifier>(context, listen: false);
            notifier.value = state.word;
          },
          builder: (BuildContext context, WordState state) {
            debugPrint("HomeView ${state.word?.word}");
            return GestureDetector(
              onTap: () {
                BlocProvider.of<WordShowBloc>(context).add(const WordNext());
              },
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    ValueListenableProvider<Word>.value(
                      value: Provider.of<WordNotifier>(context, listen: false),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: WordView(),
                      ),
                    ),
                    if (state is WordLoadProgress)
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class WordView extends StatelessWidget {
  const WordView();

  @override
  Widget build(BuildContext context) {
    return Consumer<Word>(
      builder: (BuildContext context, Word value, Widget _) {
        debugPrint("WordView ${value?.word}");

        final ThemeData theme = Theme.of(context);
        final TextTheme textTheme = theme.textTheme;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                value?.word ?? '',
                style: textTheme.body1.copyWith(fontSize: 48.0),
              ),
            ),
            const SizedBox(height: 16.0),
            const SizedBox(width: 16.0),
            Align(
              alignment: Alignment.center,
              child: Text(
                value?.pronunciation ?? '',
                style: textTheme.caption.copyWith(fontSize: 24.0),
              ),
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: Text(
                value?.japanese ?? '',
                style: textTheme.body1.copyWith(fontSize: 48.0),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(value?.explanation ?? ''),
          ],
        );
      },
    );
  }
}
