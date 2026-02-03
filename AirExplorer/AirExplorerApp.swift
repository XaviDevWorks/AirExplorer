//
//  AirExplorerApp.swift
//  AirExplorer
//
//  Created by alumne on 12/01/2026.
//

import SwiftUI

@main
struct AirExplorerApp: App {
    @StateObject var user = UserViewModel()
    @StateObject var vm = AircraftViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
                .environmentObject(vm)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        if user.isLoggedIn {
            AircraftListView()
        } else {
            LoginView()
        }
    }
}


