import Foundation

extension Date {
  var relativeDateString: String {
    // original code: https://www.hackingwithswift.com/example-code/system/how-to-show-a-relative-date-and-time-using-relativedatetimeformatter
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    return formatter.localizedString(for: self, relativeTo: Date.now)
  }
}
