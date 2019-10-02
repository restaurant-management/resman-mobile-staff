import 'package:bloc/bloc.dart';

//import '../../repositories/repository.dart';
import 'event.dart';
import 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//  final Repository _userRepository = Repository.instance;

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();

//      try {
//        await _userRepository.register(
//            event.username, event.email, event.password);
//        yield RegisterSuccess();
//      } catch (e) {
//        yield RegisterFailure(e.toString());
//      }
//      _ProcessUtils._sleep(5000);
    }
  }
}
