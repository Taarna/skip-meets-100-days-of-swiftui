import Foundation
import SwiftUI

public struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    private var percentageFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter
    }()
    private var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var total: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        
        return checkAmount + tipValue
    }
    
    public var body: some View {
        NavigationStack {
            Form {
                Section {
#if !SKIP
                    TextField("Amount", value: $checkAmount, formatter: currencyFormatter)
                        .keyboardType(.numberPad)
#else
                    ComposeView { _ in
                        CurrencyTextField(value: checkAmount, onValueChange: { checkAmount = $0 })
                    }
#endif
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<10) {
                            Text("\($0) people")
                                .tag($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text(percentageFormatter.string(from: NSNumber(value: Double($0) / 100))!)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Total amount") {
                    Text(currencyFormatter.string(from: NSNumber(value: total))!)
                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
                Section("Amount per person") {
                    Text(currencyFormatter.string(from: NSNumber(value: totalPerPerson))!)
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
