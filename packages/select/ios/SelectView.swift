import SwiftUI
import ExpoModulesCore

struct SelectView: View {
  @ObservedObject var props: SelectProps
  
  var body: some View {
    if #available(iOS 14.0, *) {
      Picker("", selection: $props.value) {
        ForEach(props.options, id: \.self) { option in
          Text("\(option)")
        }
      }
      .conditionalTint(color: props.accentColor)
      .pickerType(type: props.type)
      .onChange(of: props.value) { newValue in
        props.onValueChange([
          "value": newValue
        ])
      }
    }
  }
}


extension View {
  func pickerType(type: String) -> some View {
    modifier(PickerType(type: type))
  }
  func conditionalLabel(hasLabel: Bool) -> some View {
    modifier(ConditionalLabel(hasLabel: hasLabel))
  }
  func conditionalTint(color: UIColor?) -> some View {
    modifier(ConditionalTint(color: color))
  }
}

struct PickerType: ViewModifier {
  var type: String
  func body(content: Content) -> some View {
    switch(type) {
    case "wheel":
      return AnyView(content.pickerStyle(.wheel))
    case "segmented":
      return AnyView(content.pickerStyle(.segmented))
    case "menu":
      if #available(iOS 14.0, *) {
        return AnyView(content.pickerStyle(.menu))
      } else {
        return AnyView(content.pickerStyle(.segmented))
      }
    default:
      return AnyView(content.pickerStyle(.segmented))
    }
  }
}

struct ConditionalLabel: ViewModifier {
  let hasLabel: Bool
  func body(content: Content) -> some View {
    if hasLabel {
      return AnyView(content)
    } else {
      return AnyView(content.labelsHidden())
    }
  }
}

struct ConditionalTint: ViewModifier {
  let color: UIColor?
  func body(content: Content) -> some View {
    if let color = color {
      if #available(iOS 16.0, *) {
        content.tint(Color(color))
      } else {
        content.accentColor(Color(color))
      }
    } else {
      content
    }
  }
}

