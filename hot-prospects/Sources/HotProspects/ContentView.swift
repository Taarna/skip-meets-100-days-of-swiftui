import SwiftUI

public struct ContentView: View {
    @State private var backgroundColor = Color.red
    
    public var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)
            
#if !SKIP
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                        backgroundColor = .red
                    }
                    
                    Button("Green") {
                        backgroundColor = .green
                    }
                    
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
#else
            ComposeView { _ in
                ColorChangeContextMenu()
            }
#endif
        }
    }
}
