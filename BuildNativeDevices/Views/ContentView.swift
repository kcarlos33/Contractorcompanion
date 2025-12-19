import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("RoomScan App")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: NewScanView()) {
                    Text("New Scan")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: MyScansView()) {
                    Text("My Scans")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: SettingsView()) {
                    Text("Settings")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Home")
        }
    }
}