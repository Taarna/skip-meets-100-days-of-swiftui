//
// Copyright (c) 2024 Ivana Rast. All rights reserved.
//

import SwiftUI

struct FlagView: View {
    var flagImage: String
    var accessibilityLabel: String
    var onTapped: () -> Void
    var animation: () -> Void
    
    var body: some View {
        Button {
            onTapped()
            withAnimation {
                animation()
            }
        } label: {
            Image(flagImage, bundle: .module)
                .clipShape(.capsule)
                .shadow(radius: 5)
                .accessibilityLabel(accessibilityLabel)
#if SKIP
                .frame(maxWidth: 250, maxHeight: 150)
#endif
        }
    }
}
