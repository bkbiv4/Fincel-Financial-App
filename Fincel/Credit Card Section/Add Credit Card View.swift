//
//  AddCreditCardView.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 10/22/22.
//

import SwiftUI
import CoreData

struct Add_Credit_Card_View: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    
    @FetchRequest(entity: CreditCard.entity(), sortDescriptors: [])
    private var creditCards: FetchedResults<CreditCard>
    
    @State var cardNameTextField: String = ""
    @State var cardBalanceTextField: Double = 0.0
    @State var cardLimitTextField: Double = 0.0
    @State var cardInterestTextField: Double = 0.0
    
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack (spacing: 25) {
                    HStack () {
                        Text("Card Name")
                            .frame(width: 150, height: 15, alignment: .leading)
                        TextField("Card Name", text: $cardNameTextField)
                            .padding(5)
                            .background(Color.gray.opacity(0.25).cornerRadius(10))
                        Spacer()
                    }
                    .frame(height: 15.0)
                    
                    HStack () {
                        Text("Card Balance")
                            .frame(width: 150, height: 15, alignment: .leading)
                        TextField("Card Balance", value: $cardBalanceTextField, format: .currency(code: "USD"))
                            .padding(5)
                            .background(Color.gray.opacity(0.25).cornerRadius(10))
                        Spacer()
                    }
                    .frame(height: 15)
                    
                    HStack () {
                        Text("Card Limit")
                            .frame(width: 150, height: 15, alignment: .leading)
                        TextField("Card Balance", value: $cardLimitTextField, format: .currency(code: "USD"))
                            .padding(5)
                            .background(Color.gray.opacity(0.25).cornerRadius(10))
                        Spacer()
                    }
                    .frame(height: 15)
                        
                    HStack () {
                        Text("Card Interest")
                            .frame(width: 150, height: 15, alignment: .leading)
                        TextField("Card Limit", value: $cardInterestTextField, format: .percent)
                            .padding(5)
                            .background(Color.gray.opacity(0.25).cornerRadius(10))
                        Spacer()
                    }
                    .frame(height: 15)
                    Spacer()
                }
                .padding()
                .navigationTitle("Add Credit Card")
                
                .navigationBarItems(
                    trailing:
                        Button(action: addCreditCard) {
                            Text("Save".uppercased())
                        })
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationViewStyle(.stack)
        .cornerRadius(10)
    }
    
    private func addCreditCard() {
        let newCreditCard = CreditCard(context: viewContext)
        
        newCreditCard.cardName = cardNameTextField
        newCreditCard.cardBalance = cardBalanceTextField
        newCreditCard.cardLimit = cardLimitTextField
        newCreditCard.cardInterest = cardInterestTextField
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        print("Adding New Card", newCreditCard)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddCreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        Add_Credit_Card_View()
    }
}
