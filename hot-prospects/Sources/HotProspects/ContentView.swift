import SwiftUI

public struct ContentView: View {
    public var body: some View {
        Image("example", bundle: .module, label: Text("Alien"))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .background(.black)
    }
}
