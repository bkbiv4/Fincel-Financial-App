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
    @State var showEditBillVeiw: Bool = false
    @State private var showBillDeleteOptions = false
    @State var tempBill: Bill?
    
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
    func someFinNum() -> Double {
        var tempNum: Double = 0
        for x in bills {
            tempNum += x.billAmount
        }
        return tempNum
        
    }
    func deleteBill() {
        let context = CoreDataManager.shared.container.viewContext
        context.delete(tempBill!)
        
        do {
            try context.save()
        } catch let err {
            print("Failed to delete the bill", err)
        }
    }
    func deleteBillSeries() {
        
        let context = CoreDataManager.shared.container.viewContext
        
        for bill in bills {
            if bill.billName == tempBill?.billName {
                context.delete(bill)
            }
        }
        
        do {
            try context.save()
        } catch let err {
            print("Failed to delete the bill", err)
        }
        

    }
    func editBill() {
        
    }
    
    var body: some View {
        let billMonths = grabBillMonths()
        let someFinNum = someFinNum()
        
        
        NavigationView {
            List {
                ForEach(billMonths, id: \.self) { billDate in
        // MARK: - Calculate predicted balance and add it to each section
                    Section(header: HStack { Text(billDate); Text("CashFLow") }) {
                        ForEach(self.bills, id: \.self) { bill in
                            if bill.billDate?.formatted(.dateTime.month(.wide).year()) == billDate {
                                BillRow(bill: bill)
                                .swipeActions {
                                    Button("Delete") {
                                        showBillDeleteOptions = true
                                        tempBill = bill
                                    }
                                    .tint(.red)
                                    Button("Edit") {
                                        print("Editing!")
                                        tempBill = bill
                                        showEditBillVeiw.toggle()
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
            .background(Color.red)
            .alert("Delete Options", isPresented: $showBillDeleteOptions) {
                Button("Delete this Bill Only", action: deleteBill).keyboardShortcut(.defaultAction)
                Button("Delete Bill Series", role: .destructive, action: deleteBillSeries)
                Button("Cancel", role: .cancel, action: {})
            }
            
            .navigationBarItems(trailing: Button("Add") { showCreateBillView.toggle() })
            .navigationTitle(Text("Future Balance \(someFinNum, specifier: "$%.2f")"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showCreateBillView) { CreateBillsView() }
        .sheet(isPresented: $showEditBillVeiw) {
            
            /*
                This Code Works here but there is a bug, the bill does not get passed when the app is intiially loaded
             
             */
            
            CreateBillsView(bill: tempBill)
            
        }
    }
    struct BillsView_Previews: PreviewProvider {
        static var previews: some View {
            BillsView()
        }
    }
    
}

struct BillRow: View {
    
    let bill: Bill
    
    var body: some View {
        HStack (
            spacing: nil

        ){
            Text(bill.billName ?? "")
                .multilineTextAlignment(.leading)
            
            Spacer()
            Text(bill.billDate?.formatted(.dateTime.month(.abbreviated).day()) ?? "")
            Spacer()
            if bill.billAmount > 0 {
                Text("$ \(String(bill.billAmount))")
                    .foregroundColor(.green)
            }
            else {
                Text("$ \(String(bill.billAmount))")
                    .foregroundColor(.red)
            }
        }
    }
}
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
