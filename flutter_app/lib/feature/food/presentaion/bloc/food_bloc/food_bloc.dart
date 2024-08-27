import 'package:flutter_app/feature/food/domain/usecases/get_all_food_usecase.dart';
import 'package:flutter_app/feature/food/domain/usecases/get_food_by_id_usecase.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_event.dart';
import 'package:flutter_app/feature/food/presentaion/bloc/food_bloc/food_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/core/usecases/usecase.dart';

class FetchAllFoodBloc extends Bloc<FoodEvent, FoodState> {
  final GetAllFoodUseCase getAllFoodUseCase;

  FetchAllFoodBloc({required this.getAllFoodUseCase}) : super(FoodInitial()) {
    on<FetchAllFoodEvent>((event, emit) async {
      emit(FoodLoading());
      try {
        final result = await getAllFoodUseCase(NoParams());
        result.fold(
          (failure) => emit(FoodError(failure.message)),
          (foodItems) => emit(FoodLoaded(foodItems)),
        );
      } catch (e) {
        emit(FoodError('Failed to fetch food items'));
      }
    });
  }
}

class DetailBloc extends Bloc<FoodEvent, FoodState> {
  final GetFoodByIdUseCase getFoodByIdUseCase;

  DetailBloc({required this.getFoodByIdUseCase}) : super(FoodInitial()) {
    on<FetchFoodDetailEvent>((event, emit) async {
      emit(FoodLoading());
      try {
        final result = await getFoodByIdUseCase(FoodParams(id: event.id));
        result.fold(
          (failure) => emit(FoodError(failure.message)),
          (foodItem) => emit(FoodDetailLoaded(foodItem)),
        );
      } catch (e) {
        emit(FoodError('Failed to fetch food item'));
      }
    });
  }
}


// class DetailBloc extends Bloc<FoodEvent, FoodState> {
//   final GetFoodByIdUseCase getFoodByIdUsecase;
//   final String foodId;

//   DetailBloc({
//     required this.getFoodByIdUsecase,
//     required this.foodId,
//   }) : super(FoodInitial()) {
//     on<FetchFoodDetailEvent>((event, emit) async {
//       emit(FoodLoading());
//       try {
//         final result = await getFoodByIdUsecase(FoodParams(id: foodId));
//         result.fold(
//           (failure) => emit(FoodError(failure.message)),
//           (food) => emit(FoodDetailLoaded(food)),
//         );
//       } catch (e) {
//         emit(FoodError("Failed to fetch details"));
//       }
//     });
//   }
// }