import Foundation

struct Scan: Identifiable, Codable {
    let id = UUID()
    var name: String
    let timestamp: Date
    var notes: String
}