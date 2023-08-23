import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/app/screens/authentication/models/channel_model.dart';
import 'package:youtube_clone/constants/app_colors.dart';
import 'package:youtube_clone/constants/app_style.dart';

import 'controllers/blocs/channel/channel_bloc.dart';

class ChannelWrapper extends StatefulWidget {
  const ChannelWrapper({super.key});

  @override
  State<ChannelWrapper> createState() => _ChannelWrapperState();
}

class _ChannelWrapperState extends State<ChannelWrapper> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() {
    if (auth.currentUser == null) return;
    context.read<ChannelBloc>().add(
          GetChannelEvent(
            userUid: auth.currentUser!.uid,
            channelId: "",
          ),
        );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelBloc, ChannelState>(
      builder: (context, state) {
        if (state is ChannelLoadingState) {
          return const Scaffold(
            body: SafeArea(
                child: Center(
              child: CircularProgressIndicator(),
            )),
          );
        } else if (state is ChannelLoadedState) {
          return const Scaffold(
            body: SafeArea(
              child: Center(
                child: Text('My Channel'),
              ),
            ),
          );
        }
        return const ChannelCreateScreen();
      },
    );
  }
}

class ChannelCreateScreen extends StatefulWidget {
  const ChannelCreateScreen({super.key});

  @override
  State<ChannelCreateScreen> createState() => _ChannelCreateScreenState();
}

class _ChannelCreateScreenState extends State<ChannelCreateScreen> {
  TextEditingController _editingController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  _submit() async {
    if (_editingController.text.isNotEmpty && auth.currentUser != null) {
      context.read<ChannelBloc>().add(
            AddChannelEvent(
              userUid: auth.currentUser!.uid,
              channelModel: ChannelModel(
                id: UniqueKey().toString(),
                uid: "",
                name: _editingController.text,
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0.9,
              leading: Ink(
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              title: Text(
                'How you\'ll appear',
                style: AppStyle.latoStyle.copyWith(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  Ink(
                    child: InkWell(
                      onTap: () => print("images"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Picture',
                                style: AppStyle.latoStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Change your photo or take a new one',
                                style: AppStyle.latoStyle.copyWith(
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: CircleAvatar(
                              radius: MediaQuery.sizeOf(context).width * 0.07,
                              child: const Icon(
                                Icons.person_2_outlined,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextField(
                    controller: _editingController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Ink(
                height: 45,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blueColor),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: InkWell(
                  onTap: () => _submit(),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Create Channel'.toUpperCase(),
                      style: AppStyle.latoStyle.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
