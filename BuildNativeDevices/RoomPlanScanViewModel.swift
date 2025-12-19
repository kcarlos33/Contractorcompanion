import SwiftUI
import RoomPlan
import SceneKit

class RoomPlanScanViewModel: ObservableObject, RoomCaptureSessionDelegate {
    @Published var isRoomPlanSupported: Bool = false
    @Published var isScanning: Bool = false
    @Published var capturedRoom: CapturedRoom? = nil
    @Published var objectsDetectedCount: Int = 0

    let roomCaptureSession = RoomCaptureSession()
    let scene = SCNScene()

    init() {
        roomCaptureSession.delegate = self
    }

    func checkDeviceSupport() {
        isRoomPlanSupported = RoomCaptureSession.isSupported
    }

    func startScanning() {
        guard RoomCaptureSession.isSupported else {
            print("RoomPlan is not supported on this device.")
            return
        }

        isScanning = true
        capturedRoom = nil
        roomCaptureSession.run(configuration: RoomCaptureSession.Configuration())
    }

    func pauseScanning() {
        if #available(iOS 17.0, *) {
            roomCaptureSession.pause()
        } else {
            roomCaptureSession.stop()
            isScanning = false
        }
    }

    func finishScanning() {
        roomCaptureSession.stop()
        isScanning = false
    }

    func captureSession(_ session: RoomCaptureSession, didUpdate object: CapturedObject) {
        DispatchQueue.main.async {
            self.objectsDetectedCount += 1
            print("Object detected: \(object)")
        }
    }

    func captureSession(_ session: RoomCaptureSession, didProvide processedData: CapturedRoom, error: Error?) {
        if let error = error {
            print("Error capturing room: \(error)")
        } else {
            DispatchQueue.main.async {
                self.capturedRoom = processedData
                print("Captured room: \(processedData)")
            }
        }
    }
}