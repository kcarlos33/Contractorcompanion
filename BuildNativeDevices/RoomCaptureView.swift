import SwiftUI
import RoomPlan
import SceneKit

struct RoomCaptureView: UIViewControllerRepresentable {
    let roomCaptureSession: RoomCaptureSession
    let scene: SCNScene

    func makeUIViewController(context: Context) -> RoomCaptureViewController {
        let viewController = RoomCaptureViewController(roomCaptureSession: roomCaptureSession, scene: scene)
        return viewController
    }

    func updateUIViewController(_ uiViewController: RoomCaptureViewController, context: Context) {
    }
}

class RoomCaptureViewController: UIViewController {
    let roomCaptureSession: RoomCaptureSession
    let scene: SCNScene

    init(roomCaptureSession: RoomCaptureSession, scene: SCNScene) {
        self.roomCaptureSession = roomCaptureSession
        self.scene = scene
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let sceneView = SCNView(frame: view.frame)
        sceneView.scene = scene
        sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(sceneView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        roomCaptureSession.run(configuration: RoomCaptureSession.Configuration())
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        roomCaptureSession.stop()
    }
}