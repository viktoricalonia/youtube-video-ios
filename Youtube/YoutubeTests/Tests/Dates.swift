import Testing
import Foundation

@testable import Youtube


struct Dates {

    @Test func stringISODateStringToDate() async throws {
      let dateString = "2025-01-24T05:00:38Z"
      let date = dateString.fromISO86601NoMSDateStringToDate()
      
      let df = DateFormatter()
      df.dateFormat = DateFormatterStyle.ISO86601NoMSStyle.rawValue
      let stringFromDate = df.string(from: date!)
      
      #expect(dateString == stringFromDate)
      #expect(date != nil)
    }

}
