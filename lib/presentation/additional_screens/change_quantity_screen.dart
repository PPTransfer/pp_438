import 'package:flutter/material.dart';
import 'package:pp_438/core/services/database/database_service.dart';
import 'package:pp_438/data/models/ingredient_model/ingredient.dart';
import 'package:pp_438/presentation/view_screens/widgets/ingredient_widget.dart';
import 'package:pp_438/widgets/custom_text_field_form.dart';

import '../../core/app_export.dart';
import '../../core/helpers/enums.dart';
import '../../widgets/custom_elevated_button.dart';

@RoutePage()
class ChangeQuantityScreen extends StatefulWidget {
  final Ingredient ingredient;

  const ChangeQuantityScreen({super.key, required this.ingredient});

  @override
  State<ChangeQuantityScreen> createState() => _ChangeQuantityScreenState();
}

class _ChangeQuantityScreenState extends State<ChangeQuantityScreen> {
  Unit _selectedUnit = Unit.kgg; // Default selected unit
  TextEditingController _amountController = TextEditingController();
  TextEditingController _amountAddController = TextEditingController();

  FocusNode _amountNode = FocusNode();
  FocusNode _amountAddNode = FocusNode();

  @override
  void dispose() {
    _amountController.dispose();
    _amountAddController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _amountController.text = widget.ingredient.amount.toString();
    _amountAddController.text = widget.ingredient.amountAdd.toString();
    _selectedUnit = widget.ingredient.unit;
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            _buildHeader(),
            _buildBody(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: ValueListenableBuilder<bool>(
          valueListenable: ValueNotifier(_isFieldsFill()),
          builder: (BuildContext context, bool value, Widget? child) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 80.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomElevatedButton(
                    buttonStyle: CustomButtonStyles.fillRed,
                    text: 'Save',
                    isDisabled: !value,
                    onPressed: _onSaveTap,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: AppDecoration.fillGray,
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: CustomImageView(imagePath: Assets.images.btnBack),
                  ),
                  SizedBox(width: 16.h),
                  Expanded(
                    child:
                        Text('Quantity', style: theme.textTheme.displayLarge),
                  ),
                  SizedBox(width: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16.h),
          IngredientWidget(ingredient: widget.ingredient),
          SizedBox(height: 16.h),
          _buildUnitChoose(),
          SizedBox(height: 20.h),
          _buildTextFields(),
        ],
      ),
    );
  }

  Widget _buildUnitChoose() {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,

        //crossAxisAlignment:WrapCrossAlignment.sr,
        spacing: 16.h,
        runSpacing: 16.h,
        children: [
          _buildRadioButton(Unit.kgg),
          _buildRadioButton(Unit.pcs),
          _buildRadioButton(Unit.lboz),
        ],
      ),
    );
  }

  Widget _buildRadioButton(Unit unit) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedUnit = unit;
        });
      },
      child: Container(
        width: 150.h,
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
        decoration: AppDecoration.fillPrimary,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Radio<Unit>(
              value: unit,
              groupValue: _selectedUnit,
              fillColor: WidgetStateProperty.all(theme.colorScheme.surface),
              onChanged: (Unit? value) {
                // setState(() {
                //   _selectedUnit = value!;
                // });
              },
            ),
            SizedBox(
              width: 16.h,
            ),
            Text(
              unitToString(unit),
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    switch (_selectedUnit) {
      case Unit.kgg:
        return Container(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('Kg', style: theme.textTheme.bodySmall),
                    ),
                    CustomTextFormField(
                      controller: _amountController,
                      focusNode: _amountNode,
                      textInputType: TextInputType.numberWithOptions(),
                      hintText: '-',
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 16.h,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('G', style: theme.textTheme.bodySmall),
                    ),
                    CustomTextFormField(
                      controller: _amountAddController,
                      focusNode: _amountAddNode,
                      textInputType: TextInputType.numberWithOptions(),
                      hintText: '-',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case Unit.pcs:
        return Container(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('Pieces', style: theme.textTheme.bodySmall),
                    ),
                    CustomTextFormField(
                      controller: _amountController,
                      focusNode: _amountNode,
                      textInputType: TextInputType.numberWithOptions(),
                      hintText: '-',
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 16.h,
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        );
      case Unit.lboz:
        return Container(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('Lb', style: theme.textTheme.bodySmall),
                    ),
                    CustomTextFormField(
                      controller: _amountController,
                      focusNode: _amountNode,
                      textInputType: TextInputType.numberWithOptions(),
                      hintText: '-',
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 16.h,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('Oz', style: theme.textTheme.bodySmall),
                    ),
                    CustomTextFormField(
                      controller: _amountAddController,
                      focusNode: _amountAddNode,
                      textInputType: TextInputType.numberWithOptions(),
                      hintText: '-',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      default:
        return Container();
    }
  }

  bool _isFieldsFill() {
    return _amountController.text.isNotEmpty ||
        _amountAddController.text.isNotEmpty;
  }

  void _onSaveTap() async {
    Ingredient ingredient = widget.ingredient.copyWith(
      unit: _selectedUnit,
      amount: int.parse(_amountController.value.text),
      amountAdd: int.parse(_amountAddController.value.text),
    );

    await DatabaseService.saveIngredient(ingredient);
    Navigator.of(context).maybePop(ingredient.id);
  }
}
