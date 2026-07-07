import Foundation

struct RunEntry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var createdAt: Date = Date()
    var dateISO: String
    var hoursRun: String
    var fuelLevel: String
    var notes: String

    init(id: UUID = UUID(), createdAt: Date = Date(), dateISO: String = "", hoursRun: String = "", fuelLevel: String = "", notes: String = "") {
        self.id = id
        self.createdAt = createdAt
        self.dateISO = dateISO
        self.hoursRun = hoursRun
        self.fuelLevel = fuelLevel
        self.notes = notes
    }
}
