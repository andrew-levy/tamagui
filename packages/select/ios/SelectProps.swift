import SwiftUI
import ExpoModulesCore

class SelectProps: ObservableObject {
  @Published var type: String = "menu"
  @Published var value: String = ""
  @Published var options: [String] = []
  @Published var accentColor: UIColor?
  @Published var onValueChange: EventDispatcher
  
  init(onValueChange: EventDispatcher) {
    self.onValueChange = onValueChange
  }
}
