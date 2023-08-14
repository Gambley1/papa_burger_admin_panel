import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger_admin_panel/src/config/constants/padding.dart';
import 'package:papa_burger_admin_panel/src/config/constants/radius.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/navigator_extension.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/snack_bar_extension.dart';
import 'package:papa_burger_admin_panel/src/pages/main/components/tags_list_view.dart';
import 'package:papa_burger_admin_panel/src/pages/main/state/restaurants_actions/restaurants_actions_cubit.dart';
import 'package:papa_burger_admin_panel/src/widgets/custom_form_field.dart';
import 'package:papa_burger_admin_panel/src/widgets/custom_scaffold.dart';
import 'package:papa_burger_admin_panel/src/widgets/k_text.dart';

class AddRestaurantView extends StatefulWidget {
  const AddRestaurantView({super.key});

  @override
  State<AddRestaurantView> createState() => _AddRestaurantViewState();
}

class _AddRestaurantViewState extends State<AddRestaurantView> {
  final _tagController = TextEditingController();
  final _placeIdNode = FocusNode();
  final _nameNode = FocusNode();
  final _tagsNode = FocusNode();
  final _imageUrlNode = FocusNode();
  final _ratingNode = FocusNode();
  final _userRatingsTotalNode = FocusNode();
  final _latitudeNode = FocusNode();
  final _longitudeNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<RestaurantsActionsCubit>().removeRestaurantsField();
  }

  @override
  void dispose() {
    _tagController.dispose();
    _placeIdNode.dispose();
    _nameNode.dispose();
    _tagsNode.dispose();
    _imageUrlNode.dispose();
    _ratingNode.dispose();
    _userRatingsTotalNode.dispose();
    _latitudeNode.dispose();
    _longitudeNode.dispose();
    context.read<RestaurantsActionsCubit>().removeRestaurantsField();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantsActionsCubit, RestaurantsActionsState>(
      listenWhen: (p, c) => p.submissionStatus != c.submissionStatus,
      listener: (context, state) {
        final success = state.success;
        final clientFailed = state.clientRequestFailed;
        final malformed = state.malformedResponse;
        final invalidCredentials = state.addRestaurantInvalidCredentials;
        final message = state.message;
        if (success) {
          Future.delayed(const Duration(seconds: 2), () {
            context.pop<String?>(message);
          });
        }
        if (clientFailed) {
          context.showSnackBar(
            message ?? 'Client request failed. Try again later.',
          );
        }
        if (malformed) {
          context
              .showSnackBar(message ?? 'Malformed response. Try again later.');
        }
        if (invalidCredentials) {
          context.showSnackBar(message ?? 'Invalid credentials.');
        }
      },
      builder: (context, state) {
        final cubit = context.read<RestaurantsActionsCubit>();
        final tags = state.tags;
        final loading = state.loading;
        return CustomScaffold(
          withReleaseFocus: true,
          withSafeArea: true,
          appBar: AppBar(
            title: const KText(
              'Create restaurant',
              size: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                children: [
                  CustomFormField(
                    labelText: 'Restaurant place id',
                    helperText: 'optional (String)',
                    focusNode: _placeIdNode,
                    onChanged: cubit.onPlaceIdChange,
                    contentPadding: const EdgeInsets.only(
                      bottom: bottomPadding,
                      left: leftPadding,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      borderSide: const BorderSide(
                        width: 4,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    labelText: 'Restaurant name',
                    helperText: '*required (String)',
                    focusNode: _nameNode,
                    onChanged: cubit.onNameChange,
                    contentPadding: const EdgeInsets.only(
                      bottom: bottomPadding,
                      left: leftPadding,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                        labelText: 'Restaurant tags',
                        helperText: '*required (List string)',
                        focusNode: _tagsNode,
                        hintText: 'e.g Fast Food, Burgers',
                        textController: _tagController,
                        contentPadding: const EdgeInsets.only(
                          bottom: bottomPadding,
                          left: leftPadding,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_tagController.text.isNotEmpty) {
                            cubit.onTagAdd(_tagController.text);
                            _tagController.clear();
                          }
                        },
                        child: const KText(
                          'Add',
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TagsListView(
                    tags: tags.toList(),
                    onDeleted: cubit.onTagDelete,
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    labelText: 'Restaurant user ratings total',
                    helperText: '*required (String)',
                    focusNode: _userRatingsTotalNode,
                    onChanged: cubit.onUserRatingsTotalChange,
                    contentPadding: const EdgeInsets.only(
                      bottom: bottomPadding,
                      left: leftPadding,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    labelText: 'Restaurant rating',
                    helperText: '*required (double)',
                    focusNode: _ratingNode,
                    onChanged: cubit.onRatingChange,
                    contentPadding: const EdgeInsets.only(
                      bottom: bottomPadding,
                      left: leftPadding,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    labelText: 'Restaurant latitude',
                    helperText: '*required (double)',
                    focusNode: _latitudeNode,
                    onChanged: cubit.onLatitudeChange,
                    contentPadding: const EdgeInsets.only(
                      bottom: bottomPadding,
                      left: leftPadding,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    labelText: 'Restaurant longitude',
                    helperText: '*required (double)',
                    focusNode: _longitudeNode,
                    onChanged: cubit.onLongitudeChange,
                    contentPadding: const EdgeInsets.only(
                      bottom: bottomPadding,
                      left: leftPadding,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    labelText: 'Restaurant image url',
                    helperText: 'optional (String)',
                    focusNode: _imageUrlNode,
                    onChanged: cubit.onImageUrlChange,
                    contentPadding: const EdgeInsets.only(
                      bottom: bottomPadding,
                      left: leftPadding,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (loading)
                    ElevatedButton(
                      onPressed: () {},
                      child: Transform.scale(
                        scale: 0.5,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  else
                    ElevatedButton(
                      onPressed: cubit.addRestaurant,
                      child: const KText(
                        'Submit',
                        size: 42,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
