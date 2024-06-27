import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);
  var deviceInfo = DeviceInfoPlugin();
  TextEditingController userNameController = TextEditingController();
  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;
   bool isHost = false;

  getUserId() async {
    emit(GetInfoLoading());
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
    }
    emit(GetInfo());
  }
  changeIsHost() {
    isHost = !isHost;
    emit(ChangeIsHost());
  }
}
