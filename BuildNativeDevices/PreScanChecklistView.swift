import SwiftUI

struct PreScanChecklistView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("Before you start scanning:")
                .font(.title)
                .padding()

            List {
                Text("✅ Ensure good lighting conditions.")
                Text("✅ Clear clutter from the space if possible.")
                Text("✅ Move slowly and steadily during the scan.")
                Text("✅ Scan the complete perimeter of the room.")
            }
            .padding(.horizontal)

            Button(action: {
                isPresented = false
            }) {
                Text("I'm Ready!")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}