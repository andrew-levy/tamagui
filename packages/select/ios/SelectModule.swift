import ExpoModulesCore

public class SelectModule: Module {
  public func definition() -> ModuleDefinition {
    Name("Select")
    View(SelectExpoView.self) {
      Events("onValueChange")
      Prop("type") { (view: SelectExpoView, prop: String?) in
        view.props.type = prop ?? "menu"
      }
      Prop("options") { (view: SelectExpoView, prop: [String]) in
        view.props.options = prop
      }
      Prop("value") { (view: SelectExpoView, prop: String) in
        view.props.value = prop
      }
      Prop("accent") { (view: SelectExpoView, prop: UIColor?) in
        view.props.accentColor = prop
      }
    }
  }
}
