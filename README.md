# 여행친구 ✈️
![Platform](https://img.shields.io/badge/Platforms-iOS%2018.0+-007AFF?logo=apple) ![Framework](https://img.shields.io/badge/Framework-Xcode%2016.2+-0047AB?logo=apple) ![Swift](https://img.shields.io/badge/Swift-6.0-F05138?logo=swift)  

"**여행친구**"는 **해외여행 중** 알뜰하고 똑똑한 친구와 함께 여행하는 것처럼 지출 내역을 기록하고 여러 상황에서의 회화표현을 제시하는 앱입니다.

팀 **이륙**에서 개발하며, AI 기반의 국가 및 장소별 현지 회화 기능, 환율 계산, 여행 가계부 기능을 통해 더 편리하고 스마트한 여행에 필요한 기능을 지원합니다.

## 주요 기능 🌍
1. **AI 챗봇을 이용한 현지 회화 기능**  
   - 국가별 사용 언어 지원.
   - 자주 쓰는 여행 회화 제공.
   - 장소에 따른 맞춤형 여행 회화 제공.
   - 현지 사용 언어 및 한국어 동시 지원.

2. **실시간 환율 변환 기능**  
   - 국가별 최신 환율 정보 조회.  
   - 환율 정보를 이용해 통화 변환 기능 제공.
   - 간편한 모션 감지 기능을 활용한 환율 정보 화면 자동 표출.
     (스마트폰을 흔들면 환율 화면이 자동으로 활성화되어 빠르고 간편하게 여행지의 환율 정보를 확인할 수 있습니다.) //의견 필요

3. **여행 가계부 기능**  
   - 여행 중 가계부 기능을 통해 불필요한 지출 방지.  
   - 카테고리별 지출 기록 기능 제공
   - 지출 카테고리 및 차트를 이용한 시각화를 통해 편의성 제공.  
   - SwiftData를 활용한 영구 데이터 저장


## 기술 스택 🛠
- **사용언어** - Swift
- **프레임워크** - SwiftUI / SwiftData
- **IDE** - Xcode 16.2
- **버전관리** - Git / GitHub
- **API**
    - [AI 챗봇](https://openai.com/index/openai-api/)
    - [환율 API](https://www.exchangerate-api.com/)


## 📂 폴더 구조
```
TravelFriend/
├── TravelFriend.xcodeproj  # Xcode 프로젝트 파일
├── TravelFriend/           
│   ├── Const/              # 유틸리티
│   ├── Extensions/         # 데이터 모델
│   ├── Manager/            # 유틸리티 및 공통 모듈
│   ├── Views/              # UI 관련 뷰 파일
│   ├── Model/              # 데이터 모델
│   └── Assets/             # 이미지 및 리소스 파일
├── README.md               
└── .gitignore              # Git 제외 파일 설정
```


## 📱 뷰 살펴보기

## Splash & APP Icon

<div align="center" >

   
|Splash | AppIcon |
|----------|----------|
| <img src="https://github.com/user-attachments/assets/e893fa71-dc82-4c8f-8588-00d8fc53a155" width="150" height="320"/>|<img src= "https://github.com/user-attachments/assets/32c087ad-60c0-4087-9efa-02aa4917b3bd" width="150" height="320"/> |
| 앱 실행시 최초로 보이는 화면 | 앱 아이콘 |


## MainView


| Main Empty View | AddTravelView | Main View |
|----------|----------|----------|
| <img src="https://github.com/user-attachments/assets/729c3074-946f-4edc-9672-42435c627e0a" width="150" height="320"/>| <img src="https://github.com/user-attachments/assets/97eb28f6-fda5-4f90-b37e-99d9bb49187a" width="150" height="320"/> | <img src="https://github.com/user-attachments/assets/e2a5f2bf-7be2-48b9-8659-aa093393ae0d" width="150" height="320"/> |
| 여행정보가 없을 떄 나오는 화면 | 여행 일정 생성 뷰 | 여행정보가 있을 경우 나오는 화면 |


## MainView

| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| <img src="https://github.com/user-attachments/assets/e96c5097-887b-46ff-a432-362eac60eef4" width="150" height="320"/> | <img src="https://github.com/user-attachments/assets/7b61e11f-2e97-447a-a340-2708ed80a3b4" width="150" height="320"/> | <img src="https://github.com/user-attachments/assets/5fddd3da-8d59-4e7b-ab17-c28c2763838e" width="150" height="320"/> |
| 지출 내역 화면 | 지출 내역 입력 화면 | 내용 |


## ExchangeView

| ExchangeView 기본 | ExchangeView sheet 입력  | ExchangeView sheet 기본 |
|----------|----------|----------|
| <img src="https://github.com/user-attachments/assets/e714afbc-26f3-4257-8c4e-aded0aeb9ba1" width="150" height="320"/> | <img src="https://github.com/user-attachments/assets/f313a072-dd26-47d3-926c-75b7ab8b9870" width="150" height="320"/> | <img src="https://github.com/user-attachments/assets/0708e30e-f33c-420d-8e8e-efbd7d6e7224" width="150" height="320"/> |
| 버튼을 통해 표출한 화면 | 환율 정보 입력 화면 | 모션을 통해 표출한 화면 |


### ChatBotView

| 챗봇 뷰 기본 화면 | 검색 중 표출 화면 | 결과 출력 |
|----------|----------|----------|
| <img src="https://github.com/user-attachments/assets/1c3d402b-51c8-4797-b97d-557ca6a50556" width="150" height="320"/>|<img src="https://github.com/user-attachments/assets/5ffc2d1d-c628-40f1-8cdf-a988844c5318" width="150" height="320"/>|<img src="https://github.com/user-attachments/assets/dd4c29a9-2604-470e-8108-d8b0be341025" width="150" height="320"/> |
| 검색어를 제시하는 버튼이 함께 제공됩니다. | 응답 생성간 로딩 화면이 표시됩니다 | 고정된 포맷으로 이루어진 답변이 제공됩니다. |

</div>


# **팀 소개 & 회고**
멋쟁이 사자처럼 AppSchool 7기 SwiftUI 프로젝트 팀 2조 **"이륙"**

## 팀원
|이재용 ⭐️|박세라|김태건|
|:---:|:---:|:---:|
|[@AIsiteru98](https://github.com/AIsiteru98)|[@hiereit-dev](https://github.com/hiereit-dev)|[@ktg-tfot](https://github.com/zooneon)|[hsju0202](https://github.com/ktg-tfot)|
|![스크린샷 2025-02-07 오전 9.27.45-2](https://hackmd.io/_uploads/HJA6DCGt1g.png)|![](https://hackmd.io/_uploads/BykCfkmt1g.png)|![](https://avatars.githubusercontent.com/u/192176991?v=4)

## 역할 및 회고
- 이재용(팀장)
    - ChatBotView 뷰 디자인 및 기능 구현
    - OpenAI API 연결
    - MainChartView 뷰 디자인 및 구현
    - **회고**
        ```
        K
            - 우수한 팀
            - 기획의도와 맞게 잘 구성된 앱
            - 아침, 점심, 저녁으로 중간점검, 문제가 있는 경우 공유 및 해결하고 다음 스텝으로 넘어가는 소형 에자일 방법론 수행
            - 깔끔한 데이터 모델 설계로 수정없이 앱 전체에서 기능구현
            - 챗지피티 API를 prompt의 적절한 변경을 통해 여러 상황에 대처 가능하도록 활용
            - APP Key를 숨기는 방법을 공부하고 실행
            - 프로젝트 초기 셋팅과 깃 세팅 - 문제가 거의 없었다.
              
        P
            - 디자인 일관성 부족
            - 빈 영역에 대한 처리 미흡
            - 데이터 전달 구조가 다소 어설픈 부분 존재
            - 설계 실패로 사용하지 않을 네트워크 매니저에 시간을 크게 할애함
            - 워라벨이 잘 지켜짐 좀 더 고생해야 함

        T
            - 좀 더 구조적으로 복잡한 앱을 구현하기 그래서 잠 못자보기
            - 디자인에 하루정도 들여도 괜찮을 것 같음
            - Environment를 잘 활용하기
            - 앱 설계시 필요한것과 필요하지 않은 것을 잘 구분하기
            - 아이폰의 내장센서를 이용한 앱 만들어보기
        
        소감
        - 전체적으로 만족스러웠던 과정이었습니다. 
          저번 프로젝트를 완결짓지 못한 것이, 어떠한 극복해야할 지점으로 남아 이번 프로젝트는 반드시 매듭을 짓겠다는 의지가 있었습니다.
          유저 타겟과 앱의 기능이 잘 맞아 떨어져서 규모는 작지만 목표한 바를 이룰 수 있었다는 점이 뿌듯합니다. 
          
          팀원들께 맡은 바 책임을 다하고 적극적 소통을 해 준 부분에 있어 감사를 표합니다. 
          세라님께서는 가장 코어한 부분을 맡으셔서 부담감이 많으셨을 텐데도 저와 태건님의 질문에 매번 성실히 답해주시고 요구사항을 수행해 주셨습니다.
          태건님꼐서는 스위프트가 처음이신데도 불구하고 자이로 센서와 같이 하드웨어와 연동되는 기능을 구현하시는 도전정신을 보여주셨고 완벽하게 해내셨습니다. 
          고생 많으셨습니다!
        ```
- 박세라
    - 메인화면 구성
    - 여행 계획 조회/추가/삭제 기능 및 화면 구현
    - 지출 내역 조회/추가/수정 기능 및 화면 구현
    - DBManager 구현 - SwiftData를 활용한 데이터 관리
    - **회고**
        ```
        K
            - 아침 조회를 통해 하루동안 구현해야 할 것을 정리하고 간 점
            - 포기할 것은 확실히 포기하는 결단력
            - 개발 기간에 알맞는 개발의 양
            - 빠른 주제 선정
        P
            - 미흡한 화면정의와 디자인의 아쉬움
            - 구조화 되지 못한 코드 (제 코드)
            - dbManager 싱글톤패턴 적용 못한 부분
        T 
            - 확실하게 화면 정의를 해놓고 개발을 시작해야 함
            - 평소에 어려워 했던 개념이나 키워드를 두려워하지 않고 사용하는 방향으로
            - 팀원들과 다양한 이야기를 할 것
            - HackMD
        
        소감: 평소에는 마음만 앞서서 많은 기능을 구현하다 시간에 쫓겨 결국에는 앱을 완성시키지 못했는데, 이번엔 기획의도가 확실해서 주요기능 구현완료라는 목적을 가지고 끝까지 기능을 구현할 수 잇었다. 초반에는 dbManager를 싱글톤으로 시도하려고 했으나, 개발중에 잘못된 것을 깨달아 고치지 못하고 올바르게 사용하지 못한게 아쉽다. @State, @Biniding, @Environment 등의 개념에 대해서 실습하고 배울때는 확 와 닿지 않았는데, 프로젝트를 하며 다양하게 사용해봄으로써 약간의 감을 익힌듯 하다. 근데 아직도 @Environment 활용은 어렵다.. 각자의 장점은 두드러지고 단점은 보완할 수 있는 밸런스 좋은 팀이었다고 생각합니다 😊
        ```
- 김태건
    - 환율 정보 디자인 및 기능 구현
    - iPhone의 가속도 센서를 활용한 기능 구현
    - ExchangeRate API를 활용한 기능 구현
    - **회고**
        ```
        K
          - 함께 부족한 부분과 문제점을 해결하여 의도와 목적에 맞게 완성한 부분에 만족.
        P
          - 전체적인 디자인의 통일성 부족.
          - 데드라인을 고려한 시간 관리.
        T
          - 세부적인 부분에 대한 의견 공유. 
        
        소감: 열정과 실력이 넘치는 팀원들과 함께 협업의 경험을 할 수 있던 부분이 정말 좋았습니다. 개인적인 어려움으로 크고 작은 어려움도 있었지만 팀원분들과의 협업으로 잘 해결해낸 부분이 만족스럽고, 부족한 부분을 알 수 있었던 좋은 경험이었습니다. 다들 감사합니다.
        ```
