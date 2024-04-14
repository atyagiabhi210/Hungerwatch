import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hungerwatch/features/Chatbot/models/chat.dart';
import 'package:hungerwatch/features/Chatbot/repository/chat_repo.dart';
import 'package:meta/meta.dart';

//import 'package:vrikka/chatbot/models/chat.dart';
//import 'package:vrikka/chatbot/repository/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
  }

  List<ChatMessageModel> messages = [];
  bool generating = false;
  String prompt="Answer as if you are an application called HungerWatch";
  FutureOr<void> chatGenerateNewTextMessageEvent(
      ChatGenerateNewTextMessageEvent event, Emitter<ChatState> emit) async {
        emit(ChatLoadingState());
    messages.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.inputMessage)]));
        emit(ChatLoadingState());
    emit(ChatSuccessState(messages: messages));
    generating = true;
    String generatedText = await ChatRepo.chatTextGenerationRepo(messages);
    emit(ChatLoadingState());
    if (generatedText.length > 0) {
      messages.add(ChatMessageModel(
          role: 'model', parts: [ChatPartModel(text: generatedText)]));
          emit(ChatLoadingState());
      emit(ChatSuccessState(messages: messages));
      //emit(ChatLoadingState());
    }
    generating = false;
  }
}