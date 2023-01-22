//
//  ContentView.swift
//  Tomato
//
//  Created by Антон Нехаев on 09.01.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            InfoPresets(viewModel: viewModel)
                .badge(2)
                .tabItem {
                    Label("Presets", systemImage: "tray.and.arrow.down.fill")
                }
                .tag(0)
            TimerView(viewModel: viewModel)
                .tabItem {
                    Label("Timer", systemImage: "timer.circle.fill")
                        
                }
                .tag(1)
            TimerView(viewModel: viewModel)
                .badge("!")
                .tabItem {
                    Label("Settings", systemImage: "person.crop.circle.fill")
                }
                .tag(2)
        }
        .onAppear {
            UITabBar.appearance().barTintColor = .white
        }
        .font(.headline)
        .tint(Color(hex: 0xE56B6F))
//        .tint(Color(hex: 0xEAAC8B))
    }
}

// MARK: rename this strucrute :)
struct InfoPresets: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ZStack {
            let backGroundColor = Color(hex: 0x355070)
            Rectangle()
                .fill(backGroundColor)
                .edgesIgnoringSafeArea(.all)
            Text("First view")
                .foregroundColor(.white)
        }
        
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        ContentView(viewModel: viewModel)
    }
}

