import SwiftUI
import RoomPlan
import SceneKit

struct NewScanView: View {
    @StateObject private var scanViewModel = RoomPlanScanViewModel()
    @State private var isShowingPreScanChecklist = true

    var body: some View {
        VStack {
            if scanViewModel.isRoomPlanSupported {
                if scanViewModel.isScanning {
                    RoomCaptureView(roomCaptureSession: scanViewModel.roomCaptureSession, scene: scanViewModel.scene)
                        .overlay(alignment: .bottom) {
                            HStack {
                                Button(action: {
                                    scanViewModel.pauseScanning()
                                }) {
                                    Text("Pause")
                                        .padding()
                                        .background(Color.yellow)
                                        .foregroundColor(.black)
                                        .cornerRadius(8)
                                }

                                Button(action: {
                                    scanViewModel.finishScanning()
                                }) {
                                    Text("Finish")
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            .padding()
                        }
                } else if let capturedRoom = scanViewModel.capturedRoom {
                    PostProcessingView(capturedRoom: capturedRoom)
                }
                else {
                    Button(action: {
                        scanViewModel.startScanning()
                    }) {
                        Text("Start Scan")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .onAppear {
                        isShowingPreScanChecklist = true
                    }
                    .sheet(isPresented: $isShowingPreScanChecklist) {
                        PreScanChecklistView(isPresented: $isShowingPreScanChecklist) // Corrected binding here
                    }
                }
            } else {
                Text("RoomPlan is not supported on this device.")
                    .padding()
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("New Scan")
        .onAppear {
            scanViewModel.checkDeviceSupport()
        }
    }
}