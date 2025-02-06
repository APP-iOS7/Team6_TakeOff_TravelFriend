//
//  GyroManager.swift
//  TravelFriend
//
//  Created by 김태건 on 2/6/25.
//

import SwiftUI
import CoreMotion
import SwiftData

class GyroManager: ObservableObject {
    @Environment(\.modelContext) private var modelContext
    @State private var dbManager: DBManager?
    
    static let shared = GyroManager()
    private let motionManager = CMMotionManager()
    @State private var index: Int = 0
    @State private var backTapDetected = false
    @State private var travelItem: Travel?
    
    var locationString: String = "" //여행지
    
    private init() { // 앱 실행되자마자 실행
        startMonitoringMotion()
    }
    
    func setLocationText(_ locationString: String)
    {
        self.locationString = locationString
    }
    
    // 모션 값 확인
    private func startMonitoringMotion()
    {
        if (motionManager.isAccelerometerAvailable)
        {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main)
            { data, error in
                if let data = data
                {
                    let zAcceleration = data.acceleration.z
                    
                    if (zAcceleration > 1.0) // 값 조절 하면서 테스트 중
                    {
                        self.backTapDetected = true
                        self.showGlobalSheet()
                        
                        // 잦은 감지 방지. 1초 후 다시 감지.
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
                        {
                            self.backTapDetected = false
                        }
                    }
                }
            }
        }
    }
    
    // 어느 화면에서든 시트 띄우기
    private func showGlobalSheet()
    {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first
        {
            let viewController = UIHostingController(
                rootView: ExchangeView(location: locationString)
            ) // SwiftUI View를 UIKit에서 실행
            
            if let sheet = viewController.sheetPresentationController {
                sheet.detents = [.medium()]  //시트 크기 설정
                sheet.prefersGrabberVisible = true  // 드래그 핸들 표시
            }
            
            window.rootViewController?.present(viewController, animated: true)
        }
    }
   
    private func fetchTravelData() {
        dbManager = DBManager(modelContext: modelContext)
        
        if let firstTravel = dbManager?.fetchTravel().first {
            travelItem = firstTravel
        }
    }
}
