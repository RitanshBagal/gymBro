import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
                    NavigationView {
                        MainView()
                    }
                    .tabItem {
                        Label("Daily log", systemImage: "list.bullet")
                    }

                    NavigationView {
                        MemoryPoolView()
                    }
                    .tabItem {
                        Label("Add pulls", systemImage: "dumbbell")
                    }
                }
        
    }
    

}
