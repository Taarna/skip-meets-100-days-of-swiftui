
import SwiftUI

struct TemperatureUnit: Hashable {
    let unit: UnitTemperature
    let name: String
}

struct ContentView: View {
    let temperatureUnits = [
        TemperatureUnit(unit: UnitTemperature.celsius, name: "Celsius"),
        TemperatureUnit(unit: UnitTemperature.kelvin, name: "Kelvin"),
        TemperatureUnit(unit: UnitTemperature.fahrenheit, name: "Fahrenheit")
    ]
    
    @State private var inputUnitIndex = 1
    @State private var outputUnitIndex = 1
    
    @State private var temperature = "0.0"
    
    private var outputTemperature: Double {
        let inputUnit = temperatureUnits[inputUnitIndex].unit
        let outputUnit = temperatureUnits[outputUnitIndex].unit
        
        let measurement = Measurement(value: Double(temperature) ?? 0, unit: inputUnit)
        return measurement.converted(to: outputUnit).value
    }
    
    var body: some View {
        Section("Input temperature") {
            Picker("Input unit", selection: $inputUnitIndex) {
                ForEach(0..<temperatureUnits.count, id: \.self) { index in
                    Text(temperatureUnits[index].name)
                }
            }
            .pickerStyle(.segmented)
            TextField("Temperature", text: $temperature)
                .keyboardType(.numberPad)
        }
        .padding()

        Section("Output temperature") {
            Picker("Output unit", selection: $outputUnitIndex) {
                ForEach(0..<temperatureUnits.count, id: \.self) { index in
                    Text(temperatureUnits[index].name)
                }
            }
            .pickerStyle(.segmented)
            HStack {
                Text(outputTemperature.formatted())
                Spacer()
            }
        }
        .padding()
        
        Spacer()
    }
}

#Preview {
    ContentView()
}
