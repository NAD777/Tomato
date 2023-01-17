//
//  TomatoApp.swift
//  Tomato
//
//  Created by Антон Нехаев on 09.01.2023.
//

import SwiftUI

@main
struct TomatoApp: App {
    let viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
