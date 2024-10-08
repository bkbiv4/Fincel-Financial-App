//
//  CreditView.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 10/22/22.
//

import SwiftUI
import CoreData

struct CreditView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: CreditCard.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CreditCard.cardBalance, ascending: true)])
    var creditCards: FetchedResults<CreditCard>
    
    
    
    @State var showAddCreditCardView: Bool = false
    @State var showCreditCardDetailsView: Bool = false
    
    
    
    var body: some View {
        var creditCard: CreditCard? = nil
        ZStack {
            NavigationView {
//                Rectangle()
//                    .size(CGSize(width: 10, height: 10))
//                    .foregroundColor(.red)
//                Text("Fill Up Space with the view")
                List {
                    ForEach(self.creditCards.indices, id: \.self) { index in
                        HStack {
                            Text(String(creditCards[index].cardName!))
                            if creditCards[index].cardBalance >= 0 {
                                Text("$ \(String(creditCards[index].cardBalance))")
                                .foregroundColor(Color.green)
                            }
                            else {
                                Text("$ \(String(creditCards[index].cardBalance))")
                                .foregroundColor(Color.red)
                            }
                        }
                        .onTapGesture {
                            print("Showing Details for \(creditCards[index].cardName ?? "") Credit Card")
                            creditCard = creditCards[index]
                            showCreditCardDetailsView.toggle()


                        }
                    }
                }
                    .navigationTitle("Credit Cards")
                    .navigationBarItems(trailing: Button("Add") { showAddCreditCardView.toggle() } )
            }
                .navigationViewStyle(.stack)
                .sheet(isPresented: $showAddCreditCardView) {
                    Add_Credit_Card_View()
                }
                .sheet(isPresented: $showCreditCardDetailsView) {
                    Credit_Card_Details_View(creditCard: creditCard)
                }
        }
    }
}

struct CreditView_Previews: PreviewProvider {
    static var previews: some View {
        CreditView()
    }
}
