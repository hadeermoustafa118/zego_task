import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_app/view/voice_chat_sceen.dart';
import 'package:zego_app/view_model/cubit/chat_cubit.dart';
import 'package:zego_app/view_model/cubit/chat_state.dart';
import '../core/constants/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      AppStrings.welcome,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      AppStrings.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(height: 1.5, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    TextFormField(
                      controller: cubit.userNameController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.textFieldHint,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        cubit.userNameController.text = value;
                      },
                    ),
                   const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(AppStrings.isHostQuestion, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                             Text(AppStrings.markSwitch, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                          ],
                        ),
                        CupertinoSwitch(
                          value: cubit.isHost,
                          onChanged: (_) {
                           cubit.changeIsHost();
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (cubit.userNameController.text.isNotEmpty) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => LivePage(
                                    userName: cubit.userNameController.text,
                                    isHost: cubit.isHost,
                                  ),
                                ),
                                (route) => false);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(AppStrings.nameWarning),
                            ));
                          }
                        },
                        child: const Text(AppStrings.joinChat),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
