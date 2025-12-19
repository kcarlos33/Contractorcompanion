import SwiftUI
import RoomPlan

struct ExportView: View {
    let capturedRoom: CapturedRoom
    let measurements: RoomMeasurements

    var body: some View {
        VStack {
            Button(action: {
                exportToPDF()
            }) {
                Text("Export to PDF")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Button(action: {
                exportToUSDZ()
            }) {
                Text("Export to USDZ")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Button(action: {
                exportToJSON()
            }) {
                Text("Export to JSON")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }

    func exportToPDF() {
        let pdfExporter = PDFExporter()
        pdfExporter.export(capturedRoom: capturedRoom, measurements: measurements)
    }

    func exportToUSDZ() {
        // Export to USDZ logic (implementation pending)
        print("Exporting to USDZ...")
    }

    func exportToJSON() {
        // Export to JSON logic (implementation pending)
        print("Exporting to JSON...")
    }
}