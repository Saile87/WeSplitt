//
//  ContentView.swift
//  WeSplit
//
//  Created by Elias Breitenbach on 20.01.23.
//

import SwiftUI

struct ContentView: View {
    @State private var betragPruefen = 0.0
    @State private var anzahlPersonen = 2
    @State private var trinkgeldProzentual = 0
    @FocusState private var amountIsFocused: Bool
    
    
    var totalPerPerson: Double {
        let personenZaehler = Double(anzahlPersonen + 2)
        let prozentAuswahl = Double(trinkgeldProzentual)
        
        let prozentWert = betragPruefen / 100 * prozentAuswahl
        let gesamtSumme = betragPruefen + prozentWert
        let betragProPerson = gesamtSumme / personenZaehler
        
        return betragProPerson
    }
    
    var rechnungsSumme: Double {
        let prozentAuswahl2 = Double(trinkgeldProzentual)
        let prozentWert2 = betragPruefen / 100 * prozentAuswahl2
        let scheck = betragPruefen + prozentWert2
        return scheck
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Betrag", value: $betragPruefen, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Anzahl Personen", selection: $anzahlPersonen) {
                        ForEach(1..<4) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section {
                    Picker("Prozentual", selection: $trinkgeldProzentual) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("Höhe des Trinkgeldes")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Betrag pro Person")
                }
                Section {
                    Text(rechnungsSumme, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Rechnungsbetrag Gesamt")
                }
            }
            .navigationTitle("We Splitt")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
