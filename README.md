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


<div style="width: 10%; font-size: 14px;">

|Splash | AppIcon |
|----------|----------|
| <img src="https://private-user-images.githubusercontent.com/132365672/410717787-10901b84-2a0f-46f2-b60a-d24ab454246e.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTMxNzMsIm5iZiI6MTczODg5Mjg3MywicGF0aCI6Ii8xMzIzNjU2NzIvNDEwNzE3Nzg3LTEwOTAxYjg0LTJhMGYtNDZmMi1iNjBhLWQyNGFiNDU0MjQ2ZS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMTQ3NTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yZTg0ZDdmYTEyMDgzNjBjMzNhNGMwYmFjM2ZkOGQwNTk2OWFkOWQ4MTA4MTQ0MTk1YzZhY2Q3MTk2ZTc5YWEwJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.BcjX0PPPn16jAt3pvPmABhlgD-r7Zu7NDqlaKhXUgs0" width="360" height="771"/>|<img src="https://private-user-images.githubusercontent.com/132365672/410718465-1f0f7d43-e771-47a0-9e62-bfef33b100f6.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTMyNDIsIm5iZiI6MTczODg5Mjk0MiwicGF0aCI6Ii8xMzIzNjU2NzIvNDEwNzE4NDY1LTFmMGY3ZDQzLWU3NzEtNDdhMC05ZTYyLWJmZWYzM2IxMDBmNi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMTQ5MDJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yNzQ1YWFkMmIyMDc4ZjQ4NjIzNzUyNWU4OTczODg2NzZjNWFiZDM3NmUzMzk2NjA2NjNjNzBlMzkwZDcwMDZjJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.fu9S8PgqqDba8yT40XyRM2P1_lsEoRHGIPckaxuIyik" width="360" height="771"/> |
| 앱 실행시 최초로 보이는 화면 | 앱 아이콘 |




## MainView


| Main Empty View | AddTravelView | Main View |
|----------|----------|----------|
| <img src="https://private-user-images.githubusercontent.com/132365672/410717788-2941279d-b8cb-4213-9c05-a30047e4ac24.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTI1MzQsIm5iZiI6MTczODg5MjIzNCwicGF0aCI6Ii8xMzIzNjU2NzIvNDEwNzE3Nzg4LTI5NDEyNzlkLWI4Y2ItNDIxMy05YzA1LWEzMDA0N2U0YWMyNC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMTM3MTRaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yM2NjMGM3ODZhMDE2M2Q1NjVhZmViOTAzMTk3MGRjY2Y2YTM0OTU5MzRjMWRhMThlYmQxMmJkODg2YzZhN2EyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.XS1QhWpzvryjGqpIm37ETPjQteEtuwjYaOcS8tNy5Kc" width="360" height="771"/>| <img src="https://private-user-images.githubusercontent.com/132365672/410717764-1b23862b-861a-44de-8bf4-c06844c8db89.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTI1MzQsIm5iZiI6MTczODg5MjIzNCwicGF0aCI6Ii8xMzIzNjU2NzIvNDEwNzE3NzY0LTFiMjM4NjJiLTg2MWEtNDRkZS04YmY0LWMwNjg0NGM4ZGI4OS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMTM3MTRaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yMzEyMDFiZTNjMzFhODliOWQ5MGNhYTgxMGNkZjViZGZlMzc0ZWIzZmQ1NzEzN2EyZjg1YWMzNjFjYjk1MzFkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.wQpK9Ke-X3Obd7nwqfE5RBlKFRW22253Mgf3dAPlX3w" width="360" height="771"/> | <img src="https://private-user-images.githubusercontent.com/132365672/410717767-66976817-d337-42ec-88b0-4bce366174c2.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTYyOTUsIm5iZiI6MTczODg5NTk5NSwicGF0aCI6Ii8xMzIzNjU2NzIvNDEwNzE3NzY3LTY2OTc2ODE3LWQzMzctNDJlYy04OGIwLTRiY2UzNjYxNzRjMi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMjM5NTVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01Yzc5ODIyYzkxNGQyNTQ4OGFiYWE0NGNhOWM5ODBkOWI3MGM0ZTE0NzdkYWQ0N2RmMTQ0NmU4MGQyYTEwNGEwJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.Xp4OmTpoqP1i-xtUI1cS8V4oYPdYW5Pq3YgbPZQr1GA" width="360" height="771"/> |
| 여행정보가 없을 떄 나오는 화면 | 여행 일정 생성 뷰 | 여행정보가 있을 경우 나오는 화면 |


## MainView


| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| <img src="https://private-user-images.githubusercontent.com/132365672/410717765-31485d08-9747-4470-950e-1cbb293483c0.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTYwMDksIm5iZiI6MTczODg5NTcwOSwicGF0aCI6Ii8xMzIzNjU2NzIvNDEwNzE3NzY1LTMxNDg1ZDA4LTk3NDctNDQ3MC05NTBlLTFjYmIyOTM0ODNjMC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMjM1MDlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xNDRhNzE3OTdhOGQyNDAzZGRmMDE0MDdkODVmNDRiYTEyZjZmZDVmYzE0MzFmZDY0NzQ3ZDQ4MzM3NzBiZDU1JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.0-Nd_ptbJqZNUbPZvyPEdD3iecn0LBogvq9XkKKRdmE" width="360" height="771"/> | <img src="https://private-user-images.githubusercontent.com/132365672/410717770-072219e5-426d-42bb-a9f6-74006fb223dd.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTYyOTUsIm5iZiI6MTczODg5NTk5NSwicGF0aCI6Ii8xMzIzNjU2NzIvNDEwNzE3NzcwLTA3MjIxOWU1LTQyNmQtNDJiYi1hOWY2LTc0MDA2ZmIyMjNkZC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMjM5NTVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1iMTZmZTNiNGFkZmI0M2E1YzBlOWE0YzZmNTQ5Y2VhMDFiNjdiZWI5MDUxMjU1NmE4MzUwY2MwMzIzYzEwM2EzJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.Q6Cukse0cbw5PCODQe5tqWcBDb5x1JMQYla3GFiIvh8" width="360" height="771"/> | <img src="https://private-user-images.githubusercontent.com/132365672/410717771-a79bce83-94e2-45e3-8543-9aa10de18ae1.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTIyNjQsIm5iZiI6MTczODg5MTk2NCwicGF0aCI6Ii8xMzIzNjU2NzIvNDEwNzE3NzcxLWE3OWJjZTgzLTk0ZTItNDVlMy04NTQzLTlhYTEwZGUxOGFlMS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMTMyNDRaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1mOTZjMGM3YTk5YWFhZjNlYzMxMTUwMWZlOGY0NzdmZjhhZDkzMWIwMjMwNGI0NDZjZWI1YjRmMDg1ZWFmYzU3JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.X1USiBpKrHS0NpRPKZIk_Psbqk1w7hcKI2_hGm0XXjk" width="360" height="771"/> |
| 지출 내역 화면 | 지출 내역 입력 화면 | 내용 |


## ExchangeView


| ExchangeView 기본 | ExchangeView sheet 입력  | ExchangeView sheet 기본 |
|----------|----------|----------|
| <img src="https://private-user-images.githubusercontent.com/132365672/410717761-ab0f8eb2-90b4-4004-a88d-fface09dfc97.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTI4MDMsIm5iZiI6MTczODg5MjUwMywicGF0aCI6Ii8xMzIzNjU2NzIvNDEwNzE3NzYxLWFiMGY4ZWIyLTkwYjQtNDAwNC1hODhkLWZmYWNlMDlkZmM5Ny5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMTQxNDNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT05NGMzY2Y0Y2FlZDI3YzBlMTNjODZiNDk3YTA1ZDZiZmQ3NDI5Nzk2OGUxMjllZWU4NDcwN2Q1ZTdjNzUxZWMyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.fzJuJ04-7SfJIUFAHKy-7bekyzv1unSHXNz8qTzSlYw" width="360" height="771"/> | <img src="https://private-user-images.githubusercontent.com/192176991/410720039-014c87e4-cea6-4da0-8bc9-4bc160803513.PNG?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTMxNDksIm5iZiI6MTczODg5Mjg0OSwicGF0aCI6Ii8xOTIxNzY5OTEvNDEwNzIwMDM5LTAxNGM4N2U0LWNlYTYtNGRhMC04YmM5LTRiYzE2MDgwMzUxMy5QTkc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMTQ3MjlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xMTJlNDkwOTc5MGQxZTlmMjEwMzQxNGRlZjcxZWEzNjNmOGQwMGI3YmExNDc3YjhkZGFkNmZlYmVmZTg1N2M3JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.Zp16n1Rkt3LBHQEQ-DSi829MrqRkmKui2uMX-basuDY" width="360" height="771"/> | <img src="https://private-user-images.githubusercontent.com/192176991/410720038-05817c3f-fe7c-4b4f-b241-650eab98cbd7.PNG?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTMxNDksIm5iZiI6MTczODg5Mjg0OSwicGF0aCI6Ii8xOTIxNzY5OTEvNDEwNzIwMDM4LTA1ODE3YzNmLWZlN2MtNGI0Zi1iMjQxLTY1MGVhYjk4Y2JkNy5QTkc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMTQ3MjlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0wNzhhMmY1MjkyMGJlYWU3NWM3M2RjNzA3MjkwZjQ5OTkxODAxNTBjZTVhNTY1NWE5NjJjMDVkNjNjYTU4NTliJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.AFjH_hkukAtt7s-iPWL0OEjyoc8wwcHClXXSfFLXOWo" width="360" height="771"/> |
| 버튼을 통해 표출한 화면 | 환율 정보 입력 화면 | 모션을 통해 표출한 화면 |


### ChatBotView


| 챗봇 뷰 기본 화면 | 검색 중 표출 화면 | 결과 출력 |
|----------|----------|----------|
| <img src="https://private-user-images.githubusercontent.com/132365672/410717772-a4ba96d6-7fea-415d-b342-639736c9c66a.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTI1MzQsIm5iZiI6MTczODg5MjIzNCwicGF0aCI6Ii8xMzIzNjU2NzIvNDEwNzE3NzcyLWE0YmE5NmQ2LTdmZWEtNDE1ZC1iMzQyLTYzOTczNmM5YzY2YS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMTM3MTRaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03MTQ0MGQ5ZjAzNjFmYzRjMDJjYzAwMjQxNDFkMTNmZTlkNjQ3MjFhZWQ0MDYwYjQxZDdmZWFlMjJlOTlkM2Q3JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.rRvZTBK3Rk6oL4elh1LgaiN0Ar7wAjP9vFTExxCV0GA" width="360" height="771"/>|<img src="https://private-user-images.githubusercontent.com/132365672/410717766-13efce8e-9b22-4ab9-b903-bb57a3cfb6d5.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTI1MzQsIm5iZiI6MTczODg5MjIzNCwicGF0aCI6Ii8xMzIzNjU2NzIvNDEwNzE3NzY2LTEzZWZjZThlLTliMjItNGFiOS1iOTAzLWJiNTdhM2NmYjZkNS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMTM3MTRaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1kYzc3ODY2OGEzZmFjMGEyZGNkY2E5NzcyMWMyYzRjYzkxOGU2MzY4MjFlMTlkYzA3ZDkyYmFhZjQ1ZmQ5YmQyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.fZbdb_TWjKtpiKZAm4WepeTD_pOp-ysmYroKc7iVIM8" width="360" height="771"/>|<img src="https://private-user-images.githubusercontent.com/132365672/410717769-597c9ce0-5d07-407d-b0db-e29a1a5bbf8f.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzg4OTM4MjMsIm5iZiI6MTczODg5MzUyMywicGF0aCI6Ii8xMzIzNjU2NzIvNDEwNzE3NzY5LTU5N2M5Y2UwLTVkMDctNDA3ZC1iMGRiLWUyOWExYTViYmY4Zi5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjA3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIwN1QwMTU4NDNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT03MTZmYTcyZWUzYWI4NDFhOGY2ZDE4NTFlZTY5MDcyYzEyYzM3M2ExZjg2NTkzOTRiNmQ3NTI5ZmU5Y2FiZTdiJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.pG0_IEKzmp_JlXHMhU17Dq3SB2j02anvZNJ7L2Clb4w" width="360" height="771"/> |
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
        
        소감: 
        ```
