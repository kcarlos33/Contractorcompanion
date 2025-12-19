import SwiftUI

struct MeasurementsView: View {
    let measurements: RoomMeasurements

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Room Summary")
                    .font(.headline)
                    .padding(.bottom, 5)

                Text("Total Floor Area: \(measurements.floorArea, specifier: "%.2f") sq ft")
                Text("Perimeter: \(measurements.perimeter, specifier: "%.2f") ft")
                Text("Average Ceiling Height: \(measurements.ceilingHeight, specifier: "%.2f") ft")

                Divider()

                Text("Walls")
                    .font(.headline)
                    .padding(.bottom, 5)

                ForEach(measurements.walls) { wall in
                    Text("Wall \(wall.id): Length \(wall.length, specifier: "%.2f") ft, Height \(wall.height, specifier: "%.2f") ft")
                }

                Divider()

                Text("Openings")
                    .font(.headline)
                    .padding(.bottom, 5)

                ForEach(measurements.openings) { opening in
                    Text("Opening \(opening.id): Width \(opening.width, specifier: "%.2f") ft, Height \(opening.height, specifier: "%.2f") ft")
                }

                Divider()

                Text("Objects")
                    .font(.headline)
                    .padding(.bottom, 5)

                ForEach(measurements.objects) { object in
                    Text("Object \(object.id): \(object.type), Dimensions: \(object.width, specifier: "%.2f") x \(object.height, specifier: "%.2f") x \(object.depth, specifier: "%.2f") ft")
                }
            }
            .padding()
        }
    }
}