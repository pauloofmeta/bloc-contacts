import 'package:bloc_contacts/repositories/contact_repository.dart';

import 'contact_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository repository;

  ContactBloc(this.repository) : super(ContactLoadingState()) {
    on<ClearContactEvent>(clear);
    on<FecthContactEvent>(fecth);
  }

  void clear(ClearContactEvent event, Emitter<ContactState> emit) {
    return emit(ContactListState([]));
  }

  void fecth(FecthContactEvent event, Emitter<ContactState> emit) async {
    emit(ContactLoadingState());
    try {
      final list = await repository.getAll();
      return emit(ContactListState(list));
    } catch (e) {
      return emit(ContactErrorState(e));
    }
  }
}
