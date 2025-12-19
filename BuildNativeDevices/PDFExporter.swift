import PDFKit
import SwiftUI
import RoomPlan

class PDFExporter {
    func export(capturedRoom: CapturedRoom, measurements: RoomMeasurements) {
        let pdfDocument = PDFDocument()

        // Add title page
        let titlePage = createTitlePage()
        pdfDocument.insert(titlePage, at: 0)

        // Add room summary page
        let roomSummaryPage = createRoomSummaryPage(measurements: measurements)
        pdfDocument.insert(roomSummaryPage, at: 1)

        // Add walls page
        let wallsPage = createWallsPage(measurements: measurements)
        pdfDocument.insert(wallsPage, at: 2)

        // Add openings page
        let openingsPage = createOpeningsPage(measurements: measurements)
        pdfDocument.insert(openingsPage, at: 3)

        // Add objects page
        let objectsPage = createObjectsPage(measurements: measurements)
        pdfDocument.insert(objectsPage, at: 4)

        // Save the PDF
        savePDF(pdfDocument: pdfDocument)
    }

    private func createTitlePage() -> PDFPage {
        let page = PDFPage()
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0

        // Title
        let title = "Room Scan Report"
        let titleFont = UIFont.systemFont(ofSize: 36, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont
        ]
        let titleString = NSAttributedString(string: title, attributes: titleAttributes)
        let titleSize = titleString.size()
        let titleRect = CGRect(x: (pageWidth - titleSize.width) / 2, y: 100, width: titleSize.width, height: titleSize.height)
        titleString.draw(in: titleRect)

        // Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: Date())
        let dateFont = UIFont.systemFont(ofSize: 12)
        let dateAttributes: [NSAttributedString.Key: Any] = [
            .font: dateFont
        ]
        let dateAttributedString = NSAttributedString(string: "Generated on: \(dateString)", attributes: dateAttributes)
        let dateSize = dateAttributedString.size()
        let dateRect = CGRect(x: (pageWidth - dateSize.width) / 2, y: 150, width: dateSize.width, height: dateSize.height)
        dateAttributedString.draw(in: dateRect)

        page.setBounds(CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), for: .mediaBox)
        return page
    }

    private func createRoomSummaryPage(measurements: RoomMeasurements) -> PDFPage {
        let page = PDFPage()
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0

        // Title
        let title = "Room Summary"
        let titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont
        ]
        let titleString = NSAttributedString(string: title, attributes: titleAttributes)
        let titleSize = titleString.size()
        let titleRect = CGRect(x: 50, y: 50, width: titleSize.width, height: titleSize.height)
        titleString.draw(in: titleRect)

        // Floor Area
        let floorAreaString = "Total Floor Area: \(measurements.floorArea, specifier: "%.2f") sq ft"
        let floorAreaFont = UIFont.systemFont(ofSize: 12)
        let floorAreaAttributes: [NSAttributedString.Key: Any] = [
            .font: floorAreaFont
        ]
        let floorAreaAttributedString = NSAttributedString(string: floorAreaString, attributes: floorAreaAttributes)
        let floorAreaSize = floorAreaAttributedString.size()
        let floorAreaRect = CGRect(x: 50, y: 100, width: floorAreaSize.width, height: floorAreaSize.height)
        floorAreaAttributedString.draw(in: floorAreaRect)

        // Perimeter
        let perimeterString = "Perimeter: \(measurements.perimeter, specifier: "%.2f") ft"
        let perimeterFont = UIFont.systemFont(ofSize: 12)
        let perimeterAttributes: [NSAttributedString.Key: Any] = [
            .font: perimeterFont
        ]
        let perimeterAttributedString = NSAttributedString(string: perimeterString, attributes: perimeterAttributes)
        let perimeterSize = perimeterAttributedString.size()
        let perimeterRect = CGRect(x: 50, y: 120, width: perimeterSize.width, height: perimeterSize.height)
        perimeterAttributedString.draw(in: perimeterRect)

        // Ceiling Height
        let ceilingHeightString = "Average Ceiling Height: \(measurements.ceilingHeight, specifier: "%.2f") ft"
        let ceilingHeightFont = UIFont.systemFont(ofSize: 12)
        let ceilingHeightAttributes: [NSAttributedString.Key: Any] = [
            .font: ceilingHeightFont
        ]
        let ceilingHeightAttributedString = NSAttributedString(string: ceilingHeightString, attributes: ceilingHeightAttributes)
        let ceilingHeightSize = ceilingHeightAttributedString.size()
        let ceilingHeightRect = CGRect(x: 50, y: 140, width: ceilingHeightSize.width, height: ceilingHeightSize.height)
        ceilingHeightAttributedString.draw(in: ceilingHeightRect)

        page.setBounds(CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), for: .mediaBox)
        return page
    }

    private func createWallsPage(measurements: RoomMeasurements) -> PDFPage {
        let page = PDFPage()
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0

        // Title
        let title = "Walls"
        let titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont
        ]
        let titleString = NSAttributedString(string: title, attributes: titleAttributes)
        let titleSize = titleString.size()
        let titleRect = CGRect(x: 50, y: 50, width: titleSize.width, height: titleSize.height)
        titleString.draw(in: titleRect)

        var yPosition: CGFloat = 100

        for wall in measurements.walls {
            let wallString = "Wall \(wall.id): Length \(wall.length, specifier: "%.2f") ft, Height \(wall.height, specifier: "%.2f") ft"
            let wallFont = UIFont.systemFont(ofSize: 12)
            let wallAttributes: [NSAttributedString.Key: Any] = [
                .font: wallFont
            ]
            let wallAttributedString = NSAttributedString(string: wallString, attributes: wallAttributes)
            let wallSize = wallAttributedString.size()
            let wallRect = CGRect(x: 50, y: yPosition, width: wallSize.width, height: wallSize.height)
            wallAttributedString.draw(in: wallRect)

            yPosition += 20
        }

        page.setBounds(CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), for: .mediaBox)
        return page
    }

    private func createOpeningsPage(measurements: RoomMeasurements) -> PDFPage {
        let page = PDFPage()
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0

        // Title
        let title = "Openings"
        let titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont
        ]
        let titleString = NSAttributedString(string: title, attributes: titleAttributes)
        let titleSize = titleString.size()
        let titleRect = CGRect(x: 50, y: 50, width: titleSize.width, height: titleSize.height)
        titleString.draw(in: titleRect)

        var yPosition: CGFloat = 100

        for opening in measurements.openings {
            let openingString = "Opening \(opening.id): Width \(opening.width, specifier: "%.2f") ft, Height \(opening.height, specifier: "%.2f") ft"
            let openingFont = UIFont.systemFont(ofSize: 12)
            let openingAttributes: [NSAttributedString.Key: Any] = [
                .font: openingFont
            ]
            let openingAttributedString = NSAttributedString(string: openingString, attributes: openingAttributes)
            let openingSize = openingAttributedString.size()
            let openingRect = CGRect(x: 50, y: yPosition, width: openingSize.width, height: openingSize.height)
            openingAttributedString.draw(in: openingRect)

            yPosition += 20
        }

        page.setBounds(CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), for: .mediaBox)
        return page
    }

    private func createObjectsPage(measurements: RoomMeasurements) -> PDFPage {
        let page = PDFPage()
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0

        // Title
        let title = "Objects"
        let titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont
        ]
        let titleString = NSAttributedString(string: title, attributes: titleAttributes)
        let titleSize = titleString.size()
        let titleRect = CGRect(x: 50, y: 50, width: titleSize.width, height: titleSize.height)
        titleString.draw(in: titleRect)

        var yPosition: CGFloat = 100

        for object in measurements.objects {
            let objectString = "Object \(object.id): \(object.type), Dimensions: \(object.width, specifier: "%.2f") x \(object.height, specifier: "%.2f") x \(object.depth, specifier: "%.2f") ft"
            let objectFont = UIFont.systemFont(ofSize: 12)
            let objectAttributes: [NSAttributedString.Key: Any] = [
                .font: objectFont
            ]
            let objectAttributedString = NSAttributedString(string: objectString, attributes: objectAttributes)
            let objectSize = objectAttributedString.size()
            let objectRect = CGRect(x: 50, y: yPosition, width: objectSize.width, height: objectSize.height)
            objectAttributedString.draw(in: objectRect)

            yPosition += 20
        }

        page.setBounds(CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), for: .mediaBox)
        return page
    }

    private func savePDF(pdfDocument: PDFDocument) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pdfURL = documentsDirectory.appendingPathComponent("RoomScanReport.pdf")

        pdfDocument.write(to: pdfURL)
        print("PDF saved to: \(pdfURL)")
    }
}