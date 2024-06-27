import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_app/view/home_screen.dart';
import 'package:zego_app/view_model/cubit/chat_state.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import '../core/constants/app_strings.dart';
import '../view_model/cubit/chat_cubit.dart';

class LivePage extends StatelessWidget {
  final String userName;
  final bool isHost;

  const LivePage({
    super.key,
    required this.isHost,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getUserId(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              title: const Text(
                AppStrings.appBarTitle,
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            body: state is GetInfoLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : ZegoUIKitPrebuiltLiveAudioRoom(
                    appID: AppConstants.appId,
                    appSign: AppConstants.appSign,
                    userID: Platform.isAndroid
                        ? cubit.androidInfo!.id
                        : cubit.iosInfo!.identifierForVendor.toString(),
                    userName: userName,
                    roomID: AppConstants.roomId,
                    config: isHost
                        ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
                        : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience(),
                    events: ZegoUIKitPrebuiltLiveAudioRoomEvents(onEnded:
                        (ZegoLiveAudioRoomEndEvent event,
                            void Function() callback) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }),
                  ),
          );
        },
      ),
    );
  }
}
