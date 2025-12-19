import SwiftUI

struct ScanDetailView: View {
    let scan: Scan

    var body: some View {
        VStack {
            Text("Scan Name: \(scan.name)")
                .font(.title)
                .padding()

            Text("Timestamp: \(scan.timestamp, style: .date)")
                .padding()

            Text("Notes: \(scan.notes)")
                .padding()

            Spacer()
        }
        .navigationTitle("Scan Details")
    }
}