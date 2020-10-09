import SwiftUI

struct TempView: View {
    @State private var enableLogging = false

    @State private var selectedColor = 0
    @State private var colors = ["Red", "Green", "Blue"]

    var body: some View {
        NavigationView {
            Form {
                Section(footer: Text("Note: Enabling logging may slow down the app")) {
                    Picker(selection: $selectedColor, label: Text("Select a color")) {
                        ForEach(0 ..< colors.count) {
                            Text(self.colors[$0]).tag($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())

                    Toggle(isOn: $enableLogging) {
                        Text("Enable Logging")
                    }
                }

                Section {
                    Button(action: {
                    // activate theme!
                    }) {
                        Text("Save changes")
                    }
                }
            }.navigationBarTitle("Settings")
        }
    }
}
