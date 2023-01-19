//
//  ModelView.swift
//  Tomato
//
//  Created by Антон Нехаев on 10.01.2023.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    public enum TimerState: Int {
        case ON = 0
        case PAUSE = 1
        case OFF = 2
    }
    
    @AppStorage("TIMER_STATE") var timerState: TimerState = .OFF {
        didSet {
            if timerState == .ON {
                start()
            }
        }
    }
    @Published private var model: Model = Model(value: 0)
    private var endDate = Date()
    
    var sliderValue: Int {
        set (newValueOfSlider){
            model.value = newValueOfSlider
        }
        get{
            model.value
        }
    }
    
    var stringTime: String {
        ViewModel.getformatedTime(timeInSec: sliderValue)
    }
    

    static func getformatedTime(timeInSec value: Int) -> String {
        String(format: "%02d", value / 60) + ":" + String(format: "%02d", value % 60)
    }
    
//    func start(amountOfMinutes value: Float)
    func start() {
//        timerState = TimerState.ON
        self.endDate = Date()
        self.endDate = Calendar.current.date(byAdding: .second, value: sliderValue, to: endDate)!
    }
    
    func updateCountDown() {
        if timerState != .ON {
            return
        }
        let now = Date()
        let dif = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if dif <= 0 {
            sliderValue = 0
            timerState = .OFF
            return
        }
        
        sliderValue = Int(dif - 1)
    }
    // MARK: move logic from view to viewModel
}
