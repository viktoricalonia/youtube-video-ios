import Foundation

extension String {
  func fromISO86601NoMSDateStringToDate() -> Date? {
    let fromDateFormatter = DateFormatter()
    fromDateFormatter.dateFormat = DateFormatterStyle.ISO86601NoMSStyle.rawValue
    
    let isoDate = fromDateFormatter.date(from: self)
    return isoDate
  }
}
