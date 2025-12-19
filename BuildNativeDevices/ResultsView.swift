import SwiftUI
import SceneKit
import RoomPlan // Import RoomPlan

struct ResultsView: View {
    let capturedRoom: CapturedRoom
    let measurements: RoomMeasurements

    @State private var selectedTab = 0

    var body: some View {
        VStack {
            Picker("View", selection: $selectedTab) {
                Text("3D Model").tag(0)
                Text("2D Floor Plan").tag(1)
                Text("Measurements").tag(2)
                Text("Export").tag(3)
            }
            .pickerStyle(.segmented)
            .padding()

            switch selectedTab {
            case 0:
                SceneKitView(scene: capturedRoom.scene)
            case 1:
                FloorPlanView(capturedRoom: capturedRoom)
            case 2:
                MeasurementsView(measurements: measurements)
            case 3:
                ExportView(capturedRoom: capturedRoom, measurements: measurements)
            default:
                Text("Error")
            }
        }
        .navigationTitle("Scan Results")
    }
}

struct SceneKitView: View {
    let scene: SCNScene

    var body: some View {
        SceneView(scene: scene)
    }
}

struct SceneView: UIViewControllerRepresentable {
    let scene: SCNScene

    func makeUIViewController(context: Context) -> SCNViewController {
        let viewController = SCNViewController()
        viewController.scene = scene
        return viewController
    }

    func updateUIViewController(_ uiViewController: SCNViewController, context: Context) {
        // Update the view controller if needed.
        uiViewController.scene = scene
    }
}

class SCNViewController: UIViewController {
    var scene: SCNScene?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let scene = scene else {
            print("Error: Scene is nil")
            return
        }

        let sceneView = SCNView(frame: view.frame)
        sceneView.scene = scene
        sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sceneView.allowsCameraControl = true
        view.addSubview(sceneView)
    }
}