import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
public struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    
    @State private var animationRotation = 0.0
    
    @State private var buttonOpacity = 1.0
    @State private var scaleFactor = 1.0
    
    public var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(viewModel.getCorrectCountry())
                            .font(.largeTitle.weight(.semibold))
                        ForEach(0..<3) { number in
                            let country = viewModel.countries[number]
                            let label = viewModel.labels[country] ?? ""
                            FlagView(flagImage: country, accessibilityLabel: label) {
                                viewModel.flagTapped(number)
                            } animation: {
                                animationRotation += 360
                                buttonOpacity = 0.25
                                scaleFactor = 0.8
                            }
#if !SKIP
                            .rotation3DEffect(.degrees(viewModel.selectedIndex == number ? animationRotation : 0), axis: (x: 0, y: 1, z: 0))
                            .opacity(viewModel.selectedIndex == number ? 1.0 : buttonOpacity)
                            .scaleEffect(viewModel.selectedIndex == number ? 1.0 : scaleFactor)
#endif

                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(20)
                    
                    Spacer()
                    Spacer()
                    Text("Score: \(viewModel.score)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    Text("Tries left: \(viewModel.numberOfTries)")
                        .foregroundStyle(.white)
                        .font(.title)
                    Spacer()
                }
                .padding()
            }
            .alert(viewModel.scoreTitle, isPresented: $viewModel.showingScore) {
                Button("Continue", action: {
                    viewModel.askQuestion()
                })
            } message: {
                Text("Your score is \(viewModel.score)")
            }
            .alert("Game finished!", isPresented: $viewModel.showingGameFinished) {
                Button("Reset", action: viewModel.resetGame)
            } message: {
                Text("Your score is \(viewModel.score)")
            }
        }
    }
}
