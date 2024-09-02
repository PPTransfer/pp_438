import 'package:flutter/material.dart';
import 'package:pp_438/core/app_export.dart';
import 'package:pp_438/core/services/database/database_service.dart';

import '../../data/models/icon_model/icon_model.dart';
import '../../gen/assets.gen.dart';

class ChooseIconScreen extends StatefulWidget {
  @override
  _ChooseIconScreenState createState() => _ChooseIconScreenState();
}

class _ChooseIconScreenState extends State<ChooseIconScreen> {
  List<IconModel> iconsBox = [];

  @override
  void initState() {
    super.initState();
    iconsBox = DatabaseService.getAllIcons();
//    _initializeIcons();
  }

  void _selectIcon(int index) {
    IconModel selectedIcon = iconsBox[index]!;
    context.maybePop(selectedIcon.path);
    //Navigator.pop(context, selectedIcon.path); // Return to the previous screen with the selected icon path
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
     body: BackgroundWidget(
        
        child: Column(
          children: [
            SizedBox(height: 50.h),
            _buildHeader(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: iconsBox.length,
                  itemBuilder: (context, index) {
                    IconModel icon = iconsBox[index]!;
                    return GestureDetector(
                      onTap: () => _selectIcon(index),
                      //onLongPress: () => _deleteCustomIcon(index),
                      child: GridTile(
                        child: icon.isDefault
                            ? CustomImageView(
                                imagePath: icon.path,
                              )
                            : Image.asset(icon.path),
                        // Use Image.network if using URLs
                        footer: icon.isDefault
                            ? null
                            : IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => null,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
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
                    onTap: () => context.maybePop(),
                    child: CustomImageView(imagePath: Assets.images.btnBack),
                  ),
                  SizedBox(width: 16.h),
                  Expanded(
                    child: Text('Icons', style: theme.textTheme.displayLarge),
                  ),
                  SizedBox(width: 16.h),
                  InkWell(
                    child: CustomImageView(imagePath: Assets.images.addButton),
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
