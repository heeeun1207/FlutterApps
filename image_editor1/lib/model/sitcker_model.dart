class StickerModel {
  final String id;
  final String imgPath;

  StickerModel({
    required this.id,
    required this.imgPath,
  });

  @override
  bool operator ==(Object other) {
    // 1. == 같은지 비교 할 목적
    // ID 값이 같은 인스턴스 끼리 같은 스티커로 인식
    return (other as StickerModel).id == id;
  }

  // 2. Set 에서 중복 여부를 결정하는 속성
  // ID 값이 같으면 Set 안에서 같은 인스턴스로 인식
  @override
  int get hashCode => id.hashCode;
}

// 1. 하나의 인스턴스가 다른 인스턴스와 같은지 비교할 때 사용한다.
// StickerModel 은 id에 유일한 값으 입력하고 만약에 겹치면 중복 값을 제거한다.

// 2. 세트 등 해시값을 이용하는 데이터 구조에서 사용하는 게터이다. 
// 마찬가지로 id값만 유일하면 되므로 id의 hashCode 값만 반환해준다. 



