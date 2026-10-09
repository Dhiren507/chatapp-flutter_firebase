import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/contacts_module/widgets/contact_list_tile.dart';
import 'package:chatapp_firebase/features/messages_module/widgets/chat_list_tile.dart';
import 'package:chatapp_firebase/features/search_module/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;

      if (args == true) {
        print('already selected members in search screen $args');

        context.read<SearchBloc>().add(
          SearchInitiated(
            currentUserid: context.read<AuthRepository>().getCurrentUserId()!,
            isGroupSearch: true,
          ),
        );
      } else if (args is List<UserModel>) {
        context.read<SearchBloc>().add(
          SearchInitiated(
            currentUserid: context.read<AuthRepository>().getCurrentUserId()!,
            selectedUsers: args,
            isGroupSearch: false,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: CommonBackButton(),
        backgroundColor: AppColors.white,
        title: Text(
          AppStrings.searchScreenTitle,
          style: AppTextStyles.heading(fontSize: 20, color: AppColors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    context.read<SearchBloc>().add(SearchInputChanged(searchQuery: value.trim()));
                  },
                  style: AppTextStyles.body(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.bgDisables,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: CommonSvgContainer(
                        iconPath: AppAssets.searchIcon,
                        iconSize: 24,
                        containerSize: 24,
                        borderColor: Colors.transparent,
                        iconColor: AppColors.black,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 24),
                    suffixIcon: state.searchQuery.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              context.read<SearchBloc>().add(SearchInputChanged(searchQuery: ''));
                            },
                            icon: Icon(Icons.close, color: AppColors.textPrimary),
                          )
                        : null,
                    hintText: AppStrings.searchHintText,
                    hintStyle: AppTextStyles.body(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return Text(
                  state.isGroup ? AppStrings.searchGroupsSectionText : AppStrings.searchPeopleSectionTitle,
                  style: AppTextStyles.heading(),
                );
              },
            ),

            const SizedBox(height: 16),

            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.status == .loading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state.status == .error) {
                    return Center(child: Text(state.errorMsg));
                  }

                  if (state.status == .loaded) {
                    print('search screen ${state.isGroup}');
                    int itemCount = state.isGroup ? state.filteredChatList.length : state.contacts.length;

                    print('this is the item count : $itemCount');

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        if (state.isGroup) {
                          final chatListData = state.filteredChatList[index];

                          return GestureDetector(
                            behavior: .opaque,
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                AppRoutes.chatDetailScreen,
                                arguments: chatListData.chatId,
                              );
                            },
                            child: ChatListTile(
                              chatListData: chatListData,
                              currentUserId: context.read<AuthRepository>().getCurrentUserId()!,
                            ),
                          );
                        }

                        final contact = state.contacts[index];
                        bool isSelected = state.selectedUsers.any((user) => user.uid == contact.uid);

                        return GestureDetector(
                          behavior: .opaque,
                          onTap: () {
                            context.read<SearchBloc>().add(ContactSelectionToggled(selectedUser: contact));
                          },
                          child: Row(
                            children: [
                              if (state.isGroup == false) ...[
                                Checkbox(
                                  value: isSelected,
                                  onChanged: null,
                                  checkColor: AppColors.white,
                                  fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return Colors.green;
                                    }
                                    return Colors.transparent;
                                  }),
                                ),
                              ],
                              Expanded(
                                child: ContactListTile(
                                  contactName: contact.name ?? '',
                                  profileUrl: contact.photoUrl ?? '',
                                  contactBio: contact.bioText ?? '',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemCount: itemCount,
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state.status == .loaded) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.pop(context, state.selectedUsers);
              },
              backgroundColor: AppColors.green,
              child: Icon(Icons.add, color: AppColors.white),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
