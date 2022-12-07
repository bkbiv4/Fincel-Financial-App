//
//  Credit Card Details View.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 10/22/22.
//

import SwiftUI
import CoreData

struct Credit_Card_Details_View: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var creditCard: CreditCard?
    
    var body: some View {
        Text((creditCard?.cardName)!)
        Text("$" + String(creditCard!.cardBalance))
        let cardUsage = creditCard!.cardBalance / creditCard!.cardLimit * 100
        Text(String(cardUsage) + "%") /* Round the percentage to two decimal places */
        
        
    }
    
    func showSelectedCard() {
    }
}

struct Credit_Card_Details_View_Previews: PreviewProvider {
    static var previews: some View {
        Credit_Card_Details_View()
    }
}
