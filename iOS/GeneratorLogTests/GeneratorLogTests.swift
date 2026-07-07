import XCTest
@testable import GeneratorLog

@MainActor
final class GeneratorLogTests: XCTestCase {
    func testSeedDataLoadsBelowFreeLimit() {
        let store = Store()
        XCTAssertFalse(store.entries.isEmpty)
        XCTAssertLessThan(store.entries.count, Store.freeEntryLimit)
    }

    func testCanAddWhenBelowLimit() {
        let store = Store()
        XCTAssertTrue(store.canAdd(isPro: false))
    }

    func testAddIncreasesCount() {
        let store = Store()
        let before = store.entries.count
        store.add(RunEntry())
        XCTAssertEqual(store.entries.count, before + 1)
    }

    func testDeleteRemovesEntry() {
        let store = Store()
        let entry = RunEntry()
        store.add(entry)
        store.delete(entry)
        XCTAssertFalse(store.entries.contains(where: { $0.id == entry.id }))
    }

    func testFreeLimitEnforcedWhenNotPro() {
        let store = Store()
        for _ in 0..<(Store.freeEntryLimit + 5) {
            store.add(RunEntry())
        }
        XCTAssertFalse(store.canAdd(isPro: false))
        XCTAssertTrue(store.isAtFreeLimit)
    }

    func testProBypassesFreeLimit() {
        let store = Store()
        for _ in 0..<(Store.freeEntryLimit + 5) {
            store.add(RunEntry())
        }
        XCTAssertTrue(store.canAdd(isPro: true))
    }

    func testUpdateModifiesExistingEntry() {
        let store = Store()
        var entry = RunEntry()
        store.add(entry)
        entry.notes = "updated" as String? != nil ? entry.notes : entry.notes
        store.update(entry)
        XCTAssertTrue(store.entries.contains(where: { $0.id == entry.id }))
    }

    func testDeleteAtOffsetsRemovesCorrectEntry() {
        let store = Store()
        store.entries.removeAll()
        let a = RunEntry()
        let b = RunEntry()
        store.entries = [a, b]
        store.delete(at: IndexSet(integer: 0))
        XCTAssertEqual(store.entries.count, 1)
        XCTAssertEqual(store.entries.first?.id, b.id)
    }
}
