import Foundation

struct RoomMeasurements {
    let floorArea: Double
    let perimeter: Double
    let ceilingHeight: Double
    let walls: [Wall]
    let openings: [Opening]
    let objects: [Object]
}

struct Wall: Identifiable {
    let id: Int
    let length: Double
    let height: Double
}

struct Opening: Identifiable {
    let id: Int
    let width: Double
    let height: Double
    let wallId: Int
}

struct Object: Identifiable {
    let id: Int
    let type: String
    let width: Double
    let height: Double
    let depth: Double
}