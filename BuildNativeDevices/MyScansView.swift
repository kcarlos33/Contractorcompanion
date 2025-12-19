import SwiftUI

struct MyScansView: View {
    @StateObject private var scanStorageManager = ScanStorageManager()

    var body: some View {
        List {
            ForEach(scanStorageManager.scans) { scan in
                NavigationLink(destination: ScanDetailView(scan: scan)) {
                    HStack {
                        Text(scan.name)
                        Spacer()
                        Text(scan.timestamp, style: .date)
                    }
                }
            }
            .onDelete(perform: deleteScan)
        }
        .navigationTitle("My Scans")
        .onAppear {
            scanStorageManager.loadScans()
        }
        .toolbar {
            EditButton()
        }
    }

    func deleteScan(at offsets: IndexSet) {
        scanStorageManager.deleteScan(at: offsets)
    }
}