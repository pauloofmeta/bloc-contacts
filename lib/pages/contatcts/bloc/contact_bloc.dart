import 'package:bloc_contacts/repositories/contact_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_contacts/models/contact.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository repository;

  ContactBloc(this.repository) : super(const ContactState()) {
    on<ContactClearEvent>(clear);
    on<ContactFetchEvent>(fecth);
  }

  void clear(ContactClearEvent event, Emitter<ContactState> emit) {
    emit(state.copyWith(
      contacts: [],
      error: '',
      loading: false,
    ));
  }

  void fecth(ContactFetchEvent event, Emitter<ContactState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      final list = await repository.getAll();
      emit(state.copyWith(contacts: list, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }
}
