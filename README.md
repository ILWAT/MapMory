# <img src="https://github.com/ILWAT/MapMory/assets/87518434/9d2b28fb-aefb-49c8-99b5-4ad2bd56e0dd" align="center" width="50" height="50"></img> MapMory
<img src="https://github.com/ILWAT/MapMory/assets/87518434/cf382f27-a390-4833-8ba8-f7d6ebf6f1ca"></img>

### 📲[AppStore 보러가기](https://apps.apple.com/kr/app/mapmory/id6470199900)  

***🗺️MapMory***는 지도 기반 추억 기록 어플리케이션 입니다.   
어떤 장소에서 어떤 감정을 느꼈는지 텍스트로 기반할 뿐만 아니라, 감정도 기록할 수 있습니다!!


**📱주요 기능**
- AppleMap을 통한 지도 표현
- 위치, 사진, 텍스트를 포함한 사용자 기록 저장
- 위치 검색 기능
- 현재 위치 표시 및 이동

------
**📋핵심 기술**
- `MapKit`을 통한 지도 표시
- `RealmSwift`를 통한 사용자 입력 데이터 저장 기능 구현
- `Alamofire` 네트워크 통신
- `Custom Observable` + `MVVM`을 통한 `Reactive Programming` 소급 적용
- `CoreLocation`을 사용한 사용자 현재 위치 확인 구현
- `PHPickerViewController`를 활용한 사용자 사진 입력 구현
- `Firebase Crashlytics`를 활용한 Run Time Error 추적 및 관리
-  `Toast`를 사용한 사용자 Notification 구현
- `EmojiPicker`를 통한 이모지 입력 구현


## 🛠️개발
***🌎개발 환경***
> ver. 1.0 개발 기간: 2023.09.23. ~ 11.02.  
>> 출시 및 업데이트: 2023.11. 02. ~ 현재
>
> 개발 인원: 1인  
> 개발 언어: Swift  
> Minimum Deployment: iOS 15.0+: `UISheetPresentationController`
---------
***⚙️기술 스택***
- **Framework**: `UIKit`
- **Design Pattern**: `MVVC`, `Singleton`, `Router Pattern`
- **Package Management**: `SPM`, `CocoaPods`
- **Library**:  `Alamofire`, `realmSwift`, `SnapKit`, `Then`, `Toast`, `Firebase Cloud Messaging`, `Firebase Crashlytics`, `EmojiPicker`
- **Etc**: `PHPickerViewController` 


## 🔥개발 Point
### Git을 통한 프로젝트 형상관리
  - [**이슈 발행**](https://github.com/ILWAT/MapMory/issues), branch 분기 및 작업 수행,  [**Pull request**](https://github.com/ILWAT/MapMory/pulls?q=is%3Apr+is%3Aclosed)를 활용한 형상 관리 진행를 진행.

### `Custom Observable` + `MVVM`을 통한 View-ViewModel 동적 반영
- 뷰와 뷰 모델의 분리를 위해 `MVVM`을 적용하고, 동적으로 뷰에 반영 하기 위해 **Custom Observable**을 구현.
- 코드는 다음과 같으며, Observable 클래스는 **타입을 대신하는 역할을 수행하고 내부의 Value 값을 할당하면 didSet을 통해 Closure를 실행시키고 Closure를 통해 뷰에 그 값을 전달** 하는 구조.
```Swift
class Observable<T>{
    private var notifier: ((T)->Void)?
    
    var value: T {
        didSet{
            notifier?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T)->Void){
        self.notifier = closure
    }
}
```

### URLRequestConvertible를 활용한 Alamofire Router Pattern 적용
- Alamofire의 URLRequestConvertible Protocol을 통해 Router Pattern을 구현.
- Router Pattern을 통해 API request를 추상화하면 API 호출당 1:1 대응 하지 않아도 되어 **코드가 간결해지고 유지 보수성을 높일 수 있는 장점**이 있다.
```Swift
enum Router: URLRequestConvertible{
    case ...
    
    private var baseURL: URL{ switch self { ... } }
    
    private var endPoint: String{ switch self { ... } }
    
    var header: HTTPHeaders{ switch self { ... } }
    
    var method: HTTPMethod{ switch self { ... } }
    
    var query: [String: String]{ switch self { ... } }
    
    func asURLRequest() throws -> URLRequest { ... }
}
```


<!-- 
## ⚠Trouble Shooting

## 📔회고
- 최초로 PG사의 SDK를 통해 결제를 달 수 있어, **결제 시스템 구현에 대한 두려움이 해소**되었다.
- 열거형을 RawValue로 초기화 해야하는 상황에서 추상화를 하기 위해 많은 고민을 끝에 `RawValue Protocol`을 알게되었고 이를 통해 NetworkError에 관해서 추상화하여 Generic사용이 가능하게 하여 재사용성을 높일 수 있게 되었다.
- Moya의 TargetType(Router Pattern)을 **DI를 통해 분리**를 했다면 유지보수성이 좋고 간결한 코드를 작성할 수 있을 것 같지만 실제로 적용하지 못해 아쉽다.
-->