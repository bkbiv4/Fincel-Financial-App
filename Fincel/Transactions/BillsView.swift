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
    
    
    
//    @FetchRequest(entity: Bill.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Bill.billDate, ascending: true)])
    @FetchRequest(entity: Bill.entity(), sortDescriptors: [NSSortDescriptor(key: "billDate", ascending: true)])
    var bills: FetchedResults<Bill>
    
    func grabBillMonths() -> [String] {
        
        var billMonths : [String] = []
        
        for x in bills {
            let date = x.billDate?.formatted(.dateTime.month(.wide).year()) ?? ""
            billMonths.append(date)
        }
        
        return billMonths.uniqued()
    }
    
    
    
    var body: some View {
        let billMonths = grabBillMonths()
//        let _ = print(bills)
        
        NavigationView {
            List {
                ForEach(billMonths, id: \.self) { billDate in
                    Section(header: Text(billDate)) {
                        ForEach(self.bills, id: \.self) { bill in
                            HStack {
                                Text(bill.billName ?? "")
                                Text(bill.billDate?.formatted(.dateTime.month(.wide).day().year()) ?? "")
                            }
                        }
                    }
                }
                
                
                
//                ForEach(self.bills, id: \.self) { bill in
//                    Section(header: Text(bill.billDate?.formatted(.dateTime.month(.wide).year()) ?? "")) {
////                        HStack {
////                            Text(bill.billDate?.formatted() ?? "")
////                            //                            Text(bill.billAmount)
////                        }
//                    }
//                }
            }
            
//                List {
//                    ForEach(self.bills.indices, id:\.self) { index in
//                        let _ = print(bills[index].billDate?.formatted(.dateTime.month(.wide).year()))
//                        HStack {
//                            let billDate = bills[index].billDate?.formatted()
//
//                            Text(bills[index].billName!)
//                            Text(billDate ?? "")
//                        }
//                    }
//                }
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
