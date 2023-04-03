import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:space_x_demo/0_data/datasources/launch_remote_datasource.dart';
import 'package:space_x_demo/0_data/repositories/launch_repo_impl.dart';
import 'package:space_x_demo/1_domain/repositories/launch_repo.dart';
import 'package:space_x_demo/2_application/pages/launch_detail_page/bloc/launch_detail_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_list_bloc.dart';
import 'package:space_x_demo/2_application/pages/launch_list_page/bloc/launch_upcoming_list_bloc.dart';

final sl = GetIt.I;

Future<void> init() async {
  sl.registerFactory(() => LaunchDetailBloc(launchRepository: sl()));
  sl.registerFactory<LaunchListBloc>(
      () => LaunchListBloc(launchRepository: sl()));
  sl.registerFactory(() => LaunchUpcomingListBloc(launchRepository: sl()));

  sl.registerFactory<LaunchRepository>(
      () => LaunchRepositoryImpl(launchRemoteDataSource: sl()));

  sl.registerFactory<LaunchRemoteDataSource>(
      () => LaunchRemoteDataSourceImpl(client: Client()));
}
