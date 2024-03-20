import 'package:clean_architicure_posts/core/network/network_info.dart';
import 'package:clean_architicure_posts/features/posts/data/data_source/posts_local_data_source.dart';
import 'package:clean_architicure_posts/features/posts/data/data_source/posts_remote_data_source.dart';
import 'package:clean_architicure_posts/features/posts/data/repos/post_repo_impl.dart';
import 'package:clean_architicure_posts/features/posts/domain/repos/posts_repo.dart';
import 'package:clean_architicure_posts/features/posts/domain/use_cases/add_post_usecase.dart';
import 'package:clean_architicure_posts/features/posts/domain/use_cases/delete_post_usecase.dart';
import 'package:clean_architicure_posts/features/posts/domain/use_cases/get_posts_usecase.dart';
import 'package:clean_architicure_posts/features/posts/domain/use_cases/update_post_usecase.dart';
import 'package:clean_architicure_posts/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:clean_architicure_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features =posts

  //Bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddUpdateDeletePostBloc(
      addPost: sl(), updatePost: sl(), deletePost: sl()));
  //UseCases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  //Repository
  sl.registerLazySingleton<PostsRepo>(() => PostRepoImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  //Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImplement(client: sl()),
  );
  sl.registerLazySingleton<PostsLocalDataSource>(
    () => PostsLocalDataSourceImplement(sharedPreferences: sl()),
  );
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => sharedPreferences);
}
