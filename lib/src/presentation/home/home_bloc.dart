import 'dart:async';

import 'package:flutter_bloc_boilerplate/src/base/bloc.dart';
import 'package:flutter_bloc_boilerplate/src/model/git_item.dart';
import 'package:flutter_bloc_boilerplate/src/model/response/error_model.dart';
import 'package:flutter_bloc_boilerplate/src/repository/repository.dart';

class HomeBloc extends Bloc {
  var repository = Repository();
  StreamController<List<GitItem>> dataStreamController;
  StreamController<ErrorModel> errorStreamController;
  StreamController<bool> loadingStreamController;

  HomeBloc() {
    dataStreamController = StreamController();
    errorStreamController = StreamController();
    loadingStreamController = StreamController();
  }

  getTrendingData() {
    loadingStreamController.add(true);

    repository.getTrendingGithubDataAsync(
        (data) {
          dataStreamController.add(data.items);
          loadingStreamController.add(false);
        },
        (localData) {
          
        },
        (error) {
          errorStreamController.add(error);
          loadingStreamController.add(false);
        },
        onCancel: () {},
        jobId: "trending_api");
  }

  @override
  void dispose() {
    dataStreamController.close();
    errorStreamController.close();
    loadingStreamController.close();
  }
}
