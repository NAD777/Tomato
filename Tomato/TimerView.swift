//
//  TimerView.swift
//  Tomato
//
//  Created by Антон Нехаев on 20.01.2023.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ZStack {
            let backGroundColor = Color(hex: 0x355070)
            Rectangle()
                .fill(backGroundColor)
                .edgesIgnoringSafeArea(.all)
            VStack {
                TimerPicker(viewModel: viewModel)
                TimerButtons(timerState: $viewModel.timerState)
                    .padding(.top, 50)
            }
        }
    }
}

struct TimerPicker: View {
    var viewModel: ViewModel
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private struct CONSTS {
        static let radius = 125.0
        static let minValue = 0.0 * 60
        static let maxValue = 60.0 * 60
        static let knobRadius: CGFloat = 15
    }
    @State var angle: Double
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.angle = TimerPicker.calculateAngle(value: viewModel.sliderValue)
    }
    
    var body: some View {
        ZStack {
            Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(angle - 90), clockWise: true)
                .foregroundColor(Color(hex: 0xE56B6F))
            //                    .frame(width: CONSTS.radius * 2, height: CONSTS.radius * 2)
            Curve(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(angle - 90), clockWise: false)
                .stroke(style: StrokeStyle(lineWidth: 12, dash: [3, 20]))
                .foregroundColor(Color(hex: 0xE56B6F))
            
            Circle()
                .frame(width: CONSTS.knobRadius * 2, height: CONSTS.knobRadius * 2)
                .foregroundColor(Color(hex: 0xE56B6F))
                .offset(y: -CONSTS.radius)
                .rotationEffect(Angle.degrees(Double(angle)))
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if viewModel.timerState != .ON {
                            change(location: value.location)
                        }
                    })
            
            Text(viewModel.stringTime)
                .foregroundColor(Color.white)
                .font(.title)
        }
        .frame(width: CONSTS.radius * 2, height: CONSTS.radius * 2)
        .onReceive(timer) { _ in
            if viewModel.timerState != .ON {
                return
            }
            withAnimation(.easeIn(duration: 0.1)) {
                viewModel.updateCountDown()
                angle = TimerPicker.calculateAngle(value: viewModel.sliderValue)
            }
        }
    }
    
    private func radianToDegree(radian: Double) -> Double {
        return radian * 180 / .pi
    }
    
    private func change(location: CGPoint) {
        let ang = atan2(location.y, location.x) + .pi / 2
        let convertedAngle = radianToDegree(radian: ang)
        let newAngle = (convertedAngle > 0.0 ? convertedAngle : 360 + convertedAngle)

        if 330 <= angle, angle <= 360, 0 <= newAngle, newAngle <= 180 {
            angle = 360
        } else if 0 <= angle, angle <= 30, 180 <= newAngle, newAngle <= 360 {
            angle = 0
        } else {
            angle = newAngle
        }
        viewModel.sliderValue = Int(floor((CONSTS.maxValue - CONSTS.minValue) / 360 * angle / (5 * 60)) * (5 * 60))
    }
    
    static private func calculateAngle(value: Int) -> Double {
        Double(value) / (CONSTS.maxValue - CONSTS.minValue) * 360
    }
    
}

struct TimerButtons: View {
    @Binding var timerState: ViewModel.TimerState
    let backGroundColor = Color(hex: 0x355070)
    
    var body: some View {
        switch timerState {
        case .OFF, .PAUSE:
            Button {
                timerState = .ON
            } label: {
                Text("Start to Focus")
                    .foregroundColor(backGroundColor)
                    .padding(13)
                    .shadow(radius: 0)
                
            }.background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(hex: 0xEAAC8B))
                .shadow(radius: 3, y: 7)
            )
        case .ON:
            Button {
                timerState = .OFF
            } label: {
                Text("Stop")
                    .foregroundColor(backGroundColor)
                    .padding(13)
                    .shadow(radius: 0)
                
            }.background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(hex: 0xEAAC8B))
                .shadow(radius: 3, y: 7)
            )
        }
    }
}
