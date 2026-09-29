import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/contacts_module/bloc/contact_list_bloc.dart';
import 'package:chatapp_firebase/features/contacts_module/widgets/contact_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ContactListBloc>().add(ContactListFetchRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 24),
        leadingWidth: 65,
        backgroundColor: Colors.transparent,
        title: Text(
          'Contacts',
          style: AppTextStyles.heading(fontSize: 20, color: AppColors.white),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: CommonSvgContainer(
            iconPath: AppAssets.searchIcon,
            iconSize: 22,
            containerSize: 44,
            iconColor: AppColors.white,
            borderColor: AppColors.borderGrey,
          ),
        ),
        actions: [
          CommonSvgContainer(
            iconPath: AppAssets.addContactIcon,
            iconSize: 22,
            containerSize: 44,
            iconColor: AppColors.white,
            borderColor: AppColors.borderGrey,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    height: 3,
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppColors.mutedGrey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Align(
                      alignment: AlignmentGeometry.topLeft,
                      child: Text(
                        'My Contacts',
                        style: AppTextStyles.heading(fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Expanded(
                    child: BlocBuilder<ContactListBloc, ContactListState>(
                      builder: (context, state) {
                        if (state is ContactListLoading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (state is ContactListError) {
                          Center(child: Text(state.errorMsg));
                        }

                        if (state is ContactListLoaded) {
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            itemBuilder: (context, index) {
                              final contact = state.contacts[index];

                              final currentLetter = contact.name![0]
                                  .toUpperCase();
                              bool showHeader = false;

                              if (index == 0) {
                                showHeader = true;
                              } else {
                                final previousContact =
                                    state.contacts[index - 1];
                                final previousLetter = previousContact.name![0]
                                    .toUpperCase();
                                if (currentLetter != previousLetter) {
                                  showHeader = true;
                                }
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (showHeader) ...[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        currentLetter,
                                        style: AppTextStyles.heading(
                                          fontWeight: .w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, AppRoutes.chatDetailScreen, arguments: contact.uid);
                                    },
                                    child: ContactListTile(
                                      contactName: contact.name ?? '',
                                      profileUrl: contact.photoUrl ?? '',
                                      contactBio: contact.bioText ?? '',
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: state.contacts.length,
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
