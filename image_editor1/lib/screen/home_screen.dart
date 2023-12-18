import 'package:flutter/material.dart';
import 'package:image_editor1/component/main_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // 파일 관련 기능을 사용하기 위해 추가
import 'package:image_editor1/component/footer.dart';
import 'package:image_editor1/model/sitcker_model.dart';
import 'package:image_editor1/component/emotion_sticker.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  XFile? image; // 선택한 이미지를 저장할 변수
  Set<StickerModel> stikers = {}; // 화면에 추가된 스티커를 저장할 변수
  String? selectedId; // 현재 선택된 스티커의 ID


  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // 스크린에 Body, AppBar, Footer 순서로 쌓을 준비
        fit: StackFit.expand, // 자식 위젯들을 최대 크기로 펼치기
        children: [
          renderBody(),
          // MainAppBar 좌,우,위 끝에 정렬
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteItem: onDeleteItem,
            ),
          ),
          // image가 선택되면 Footer 위치하기
          if(image != null)
            Positioned( // 맨 아래에 Footer 위젯 위치하기
              bottom: 0,
              // left 와 right 를 모두 0을 주면 좌우로 최대 크기 차지함
              left: 0,
              right: 0,
              child: Footer(
                onEmoticonTap: onEmoticonTap,
              ),
            ),
        ],
      ),
    );
  }

  Widget renderBody() {
    if (image != null) {
      // Stack 크기의 최대 크기만큼 차지
      return Positioned.fill(
        // 위젯 확대 및 좌우 이동을 가능하게 하는 위젯
        child: InteractiveViewer(
          child: Stack(
            fit: StackFit.expand, // 크기 최대로 늘려주기
            children: [
            Image.file(
            File(image!.path),
            // 이미지가 부모 위젯 크기의 최대를 차지하도록 하기
            fit: BoxFit.cover,
            ),
              ...stikers.map(
                  (stiker) => Center( // 최초 스티커 선택시 중앙에 배치
                 child: EmoticonStictker(,
                    key: ObjectKey(stiker.id),
                    onTransform: onTransform,
                    imgPath : stiker.imgPath,
                    isSelected : selectedId == stiker.id,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // 이미지 선택이 안 된 경우 이미지 선택 버튼 표시
      return Center(
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          onPressed: onPickImage,
          child: Text('이미지 선택하기'),
        ),
      );
    }
  }


  void onPickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // 갤러리에서 이미지 선택하기
    setState(() {
      this.image = image; // 선택한 이미지 저장하기
    });
  }

  void onSaveImage() {}

  void onDeleteItem() {}

  void onEmoticonTap(int index) async{
    setState(() {
      stikers = {
        ...stikers,
        StickerModel(
          id: Uuid().v4(), // 스티커의 고유 ID
          imgPath: 'asset/img/emoticon_$index.png',
        ),
      };
    });
  }

  void onTransform() {}
}