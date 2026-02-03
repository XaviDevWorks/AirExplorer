import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authStore: AuthStore
    
    var body: some View {
        NavigationView {
            if authStore.isLoggedIn {
                AircraftListView()
            } else {
                LoginView()
            }
        }
    }
}
