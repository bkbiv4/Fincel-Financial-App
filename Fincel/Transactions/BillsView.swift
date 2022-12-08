//
//  BillsView.swift
//  Fincel
//
//  Created by Bruce Beuzard IV on 6/25/22.
//

import SwiftUI
import CoreData

struct BillsView: View {
    
    @State var account: Account?
    @State var showCreateBillView: Bool = false
    
    
    @FetchRequest(entity: Bill.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Bill.billDate, ascending: true)])
    var bills: FetchedResults<Bill>
    
    
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        printBills()
        NavigationView {
            
            List {
                
                ForEach(self.bills.indices, id:\.self) { index in
                    HStack {
                        let billDate = bills[index].billDate?.formatted()
                        
                        
                        Text(bills[index].billName!)
                        Text(billDate ?? "")
                    }
                    
                }
            }
            .navigationBarItems(
                trailing:
                    Button("Add") {
                        showCreateBillView.toggle()
                })
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showCreateBillView) {
            CreateBillsView()
        }
    }
}

struct BillssView_Previews: PreviewProvider {
    static var previews: some View {
        BillsView()
    }
}
