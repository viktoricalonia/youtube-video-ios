import Foundation

var isRunningUnitTest: Bool {
  return ProcessInfo.processInfo.environment["XCTestSessionIdentifier"] != nil
}
