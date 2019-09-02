import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/src/base/bloc_provider.dart';
import 'package:flutter_bloc_boilerplate/src/model/git_item.dart';
import 'package:flutter_bloc_boilerplate/src/model/response/error_model.dart';
import 'package:provider/provider.dart';

import 'git_single_item_widget.dart';
import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  static getLaunchPage() => BlocProvider(bloc: HomeBloc(), child: HomePage());

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Git Trending Api'),
        ),
        body: MultiProvider(
          providers: [
            StreamProvider<List<GitItem>>.value(
                value: _bloc.dataStreamController.stream),
            StreamProvider<ErrorModel>.value(
                value: _bloc.errorStreamController.stream),
            StreamProvider<bool>.value(
                initialData: true, value: _bloc.loadingStreamController.stream),
          ],
          child: GitItemsWidget(),
        ));
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class GitItemsWidget extends StatefulWidget {
  @override
  _GitItemsWidgetState createState() => _GitItemsWidgetState();
}

class _GitItemsWidgetState extends State<GitItemsWidget> {
  HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<HomeBloc>(context);
    _bloc.getTrendingData();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<List<GitItem>>(context);
    var error = Provider.of<ErrorModel>(context);
    var loading = Provider.of<bool>(context);

    if (error == null)
      return SafeArea(
          child: !loading
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return GitSingleItemWidget(data[index]);
                  },
                  itemCount: data.length,
                )
              : Center(child: CircularProgressIndicator()));
    else {
      return Center(child: Text(error.errorMessage));
    }

  }
}
