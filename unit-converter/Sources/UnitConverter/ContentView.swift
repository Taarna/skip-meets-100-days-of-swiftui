import SwiftUI

enum DurationUnit: String, CaseIterable {
    case seconds = "Seconds"
    case minutes = "Minutes"
    case hours = "Hours"
    
    var conversionFactor: Double {
        switch self {
        case .seconds: return 1
        case .minutes: return 60
        case .hours: return 3600
        }
    }
}

struct ContentView: View {
    @State private var inputUnit = DurationUnit.minutes
    @State private var outputUnit = DurationUnit.minutes
    @State private var time = "10"
    
    private var outputTime: Double {
        guard let inputValue = Double(time) else { return 0 }
        let baseValue = inputValue * inputUnit.conversionFactor
        return baseValue / outputUnit.conversionFactor
    }
    
    var body: some View {
        
        VStack {
            VStack {
                Text("Input Time")
                
                Picker("Input unit", selection: $inputUnit) {
                    ForEach(DurationUnit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                TextField("Time", text: $time)
                    .keyboardType(.numberPad)
            }
            .padding()
            
            VStack {
                Text("Output Time")
                
                Picker("Output unit", selection: $outputUnit) {
                    ForEach(DurationUnit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Text(String(format: "%.2f", outputTime))
            }
            .padding()
        }
        
        Spacer()
    }
}
