import Foundation

class ScanStorageManager: ObservableObject {
    @Published var scans: [Scan] = []

    private let scansKey = "savedScans"

    func loadScans() {
        if let data = UserDefaults.standard.data(forKey: scansKey) {
            do {
                let decodedScans = try JSONDecoder().decode([Scan].self, from: data)
                scans = decodedScans
            } catch {
                print("Error decoding scans: \(error)")
                scans = []
            }
            return
        }
        scans = []
    }

    func saveScans() {
        do {
            let encodedData = try JSONEncoder().encode(scans)
            UserDefaults.standard.set(encodedData, forKey: scansKey)
        } catch {
            print("Error encoding scans: \(error)")
        }
    }

    func addScan(name: String, notes: String) {
        let newScan = Scan(name: name, timestamp: Date(), notes: notes)
        scans.append(newScan)
        saveScans()
    }

    func deleteScan(at offsets: IndexSet) {
        scans.remove(atOffsets: offsets)
        saveScans()
    }
}