//
//  MainView.swift
//  SagakSagak
//
//  Created by 신정연 on 2023/05/10.
//

import SwiftUI

struct MainButton{
    let imageName: String
    let offset_x: CGFloat
    let offset_y: CGFloat
}

enum Theme : String {
    // dayOn , nightOn -> on
    case day
    case night
    
    static let dayRange = 1..<18
    static let nightRange = 18..<24
//    static let nightRange = (0..<6) + (18..<24)
//    static let nightRange = (0..<6).joined(with: 18..<24)
    static var current : Theme{
        let hour = Calendar.current.component(.hour, from: Date())
        if Theme.dayRange.contains(hour) || Theme.nightRange.contains(hour) {
            return hour >= 6 && hour < 18 ? .day : .night
        }
        return .day // 기본값은 day로 설정
    }
}
enum ButtonStyle: String, Identifiable{
    case archive
    case lamp
    case frame
    case clock
    case letter
    
    var id : UUID{
        UUID()
    }
    
    var imageName: String{
        switch Theme.current {
        case .day:
            switch self {
            case .archive: return "archive_day"
            case .lamp: return "lamp_day"
            case .frame: return "frame_day"
            case .clock: return "clock_day"
            case .letter: return "letter_day"
            }
        case .night:
            switch self {
            case .archive: return "archive_night"
            case .lamp: return "lamp_night"
            case .frame: return "frame_night"
            case .clock: return "clock_night"
            case .letter: return "letter_night"
            }
        }
    }
}

let buttons: [ButtonStyle] = [.archive, .clock, .frame, .lamp, .letter]

struct MainView: View {
    @EnvironmentObject private var coordinator: Coordinator

    //time related
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default)
        .autoconnect()
    @State private var currentTime : Date = Date.now
    @State var hour = currentHour
    
    //button related
    @State private var isActive = false
    @State private var isLampOn = false
    @State private var isCurtainOn = false
    @State private var isLetter = false

    var body: some View {
        ZStack {
            //창문 밖 색깔? 이미지?
            ZStack {
                if(!isLampOn){
                    Image("background1" +
                        (Theme.current == .day ? "_night" : "_day"))
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else{
                    Image("background_on")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
    //            Image("bg")
    //                .resizable()
    //                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Button(action: {
                    isActive = true
                }) {
                    Image("profile")
                }
                .offset(x: -377.5, y: -148.4)
                .sheet(isPresented: $isActive) {
                    MainView()
                }
                Button(action: {
                    isActive = true
                }) {
                    if (isLampOn == false){
                        Image("curtain_closed" +
                            (Theme.current == .day ? "_night" : "_day"))
                    }
                    else{
                        Image("curtain_closed")
                    }
                }
                .offset(x: 0, y: -120)
                .sheet(isPresented: $isActive) {
                    MainView()
                }
                Button(action: {
                    isLampOn.toggle()
                }) {
                    if (isLampOn == false){
                        Image("lamp" +
                            (Theme.current == .day ? "_night" : "_day"))
                    }
                    else{
                        Image("lamp")
                    }
                    
                }
                .offset(x: -310, y: -47)
                .sheet(isPresented: $isActive) {
                    MainView()
                }
                Button(action: {
                    isActive = true
                }) {
                    if (!isLampOn){
                        Image("clock" +
                            (Theme.current == .day ? "_night" : "_day"))
                    }
                    else{
                        Image("clock")
                    }
                    
                }
                .offset(x: 334, y: 25)
                .sheet(isPresented: $isActive) {
                    MainView()
                }
                Text(Date(), formatter: DateFormatter.timeOnlyFormatter)
                    .offset(x: 348, y: 28)
                    .font(FontManager.shared.nanumsquare(.extrabold, 24))
                    .foregroundColor(.clock2)
                Button(action: {
                    isActive = true
                }) {
                    if (!isLampOn){
                        Image("frame" +
                            (Theme.current == .day ? "_night" : "_day"))
                    }
                    else{
                        Image("frame")
                    }
                }
                .offset(x: 334, y: -107.5)
                .sheet(isPresented: $isActive) {
                    MainView()
                }
                Button(action: {
                    isActive = true
                }) {
                    if(!isLampOn){
                        Image("archive" +
                            (Theme.current == .day ? "_night" : "_day"))
                    }
                    else{
                        Image("archive")
                    }
                }
                .offset(x: -224, y: 97)
                .sheet(isPresented: $isActive) {
                    MainView()
                }
                Button(action: {
                    isLetter = true
                }) {
                    if(!isLampOn){
                        Image("letter" +
                              (Theme.current == .day ? "_night" : "_day"))
                    }
                    else{
                        Image("letter")
                    }
                }
                .offset(x: 0, y: 97)
                .sheet(isPresented: $isLetter) {
                    DrawingView()
                }
            }
            .background(Theme.current == .day ? .black : .blue)
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    //        .onAppear(perform: {
    //            let calender = Calendar.current
    //            let hour = calender.component(.hour, from: Date())
    //            let min = calender.component(.minute, from: Date())
    //            withAnimation(Animation.linear(duration: 0.1)){
    //                self.time = currentTime
    //            }
    //        })
    //                .onReceive(receiver) { (_) in
    //                    let calender = Calendar.current
    //                    let hour = calender.component(.hour, from: Date())
    //                    let min = calender.component(.minute, from: Date())
    //                    withAnimation(Animation.linear(duration: 0.1)){
    //                        self.time = currentTime
    //                    }
    //                }
            .onReceive(receiver) { time in
                currentTime = time
                
        }
        }
    }
}

extension DateFormatter {
    static let timeOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
