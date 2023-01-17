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
    
    @AppStorage("TIMER_STATE") var timerState: TimerState = .OFF
    @Published private var model: Model = Model(value: 0)
    
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
}
