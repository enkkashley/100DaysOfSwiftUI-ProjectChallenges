//
//  ContentView.swift
//  Unit Conversion
//
//  Created by Emmanuel Ashley on 02/07/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue = ""
    @State private var selectedInputIndex = 0
    @State private var selectedOutputIndex = 0
    
    let lengthUnits = ["m", "km", "ft", "yd", "mi"]
    
    var outputSectionHeader: Text {
        let inputUnit = lengthUnits[selectedInputIndex]
        let outputUnit = lengthUnits[selectedOutputIndex]
        
        let label = "\(inputValue)\(inputUnit) in \(outputUnit)"
        return Text(label)
    }
    
    var outputValue: Measurement<UnitLength> {
        
        var inputMeasurement: Measurement<UnitLength>
        let input = Double(inputValue) ?? 0
        let inputUnit = lengthUnits[selectedInputIndex]
        
        var outputMeasurement: Measurement<UnitLength>
        let outputUnit = lengthUnits[selectedOutputIndex]
        
        // converting inputs base on unit selected using the Measurement struct.
        switch inputUnit {
        case "m":
            inputMeasurement = Measurement(value: input, unit: UnitLength.meters)
        case "km":
            inputMeasurement = Measurement(value: input, unit: UnitLength.kilometers)
        case "ft":
            inputMeasurement = Measurement(value: input, unit: UnitLength.feet)
        case "yd":
            inputMeasurement = Measurement(value: input, unit: UnitLength.yards)
        case "mi":
            inputMeasurement = Measurement(value: input, unit: UnitLength.miles)
        default:
            inputMeasurement = Measurement(value: input, unit: UnitLength.meters)
        }
        
        // converting to output value based on output unit selected
        switch outputUnit {
        case "m":
            outputMeasurement = inputMeasurement.converted(to: UnitLength.meters)
        case "km":
            outputMeasurement = inputMeasurement.converted(to: UnitLength.kilometers)
        case "ft":
            outputMeasurement = inputMeasurement.converted(to: UnitLength.feet)
        case "yd":
            outputMeasurement = inputMeasurement.converted(to: UnitLength.yards)
        case "mi":
            outputMeasurement = inputMeasurement.converted(to: UnitLength.miles)
        default:
            outputMeasurement = inputMeasurement.converted(to: UnitLength.meters)
        }
        
        return outputMeasurement
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Choose Input Unit")) {
                    Picker("Input Units", selection: $selectedInputIndex) {
                        ForEach(0..<lengthUnits.count) {
                            Text("\(lengthUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Input Value")) {
                    TextField("Enter Input Value", text: $inputValue)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Choose Output Unit")) {
                    Picker("Output Units", selection: $selectedOutputIndex) {
                        ForEach(0..<lengthUnits.count) {
                            Text("\(lengthUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: outputSectionHeader) {
                    Text("\(outputValue.value, specifier: "%.2f")")
                }
            }
            .navigationTitle("Length Conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
