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
//    @FetchRequest(entity: Bill.entity(), sortDescriptors: [])
    var bills: FetchedResults<Bill>
    
    func grabBillMonths() -> [String] {
        
        var billMonths : [String] = []
        
        for x in bills {
            let date = x.billDate?.formatted(.dateTime.month(.wide).year()) ?? ""
            billMonths.append(date)
        }


//        print(typeof(Array(Set(billMonths))))
        print(type(of: Array(Set(billMonths))))

//        billMonths = Array(Set(billMonths))
        return billMonths
    }
    
    
    var body: some View {
//        let _ = self.grabBillMonths()
        let billMonths = grabBillMonths()
        
//        for x in bills {
//
//        }
        
        NavigationView {
            List {
                ForEach(self.bills, id: \.self) { bill in
                    Section(header: Text(bill.billDate?.formatted(.dateTime.month(.wide).year()) ?? "")) {
//                        HStack {
//                            Text(bill.billDate?.formatted() ?? "")
//                            //                            Text(bill.billAmount)
//                        }
                    }
                }
            }.listStyle(InsetGroupedListStyle())
            
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
