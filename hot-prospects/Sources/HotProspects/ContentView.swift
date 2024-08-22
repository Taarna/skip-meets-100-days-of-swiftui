import SwiftUI

public struct ContentView: View {
    @State private var output = ""

    public var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }

    func fetchReadings() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        do {
            let result = try await fetchTask.value
            output = result
        } catch {
            output = "Error: \(error.localizedDescription)"
        }
    }
}
