import SwiftUI
import RoomPlan

struct PostProcessingView: View {
    let capturedRoom: CapturedRoom
    @State private var isLoading = true
    @State private var measurements: RoomMeasurements? = nil

    var body: some View {
        VStack {
            if isLoading {
                Text("Processing scan...")
                    .padding()
            } else if let measurements = measurements {
                ResultsView(capturedRoom: capturedRoom, measurements: measurements)
            } else {
                Text("Error processing scan.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            processRoom(capturedRoom: capturedRoom)
        }
    }

    private func processRoom(capturedRoom: CapturedRoom) {
        // Simulate processing delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            measurements = MeasurementExtractor.extractMeasurements(from: capturedRoom)
            isLoading = false
        }
    }
}