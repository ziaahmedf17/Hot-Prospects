//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Zi on 21/08/2025.
//
import CodeScanner
import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacred, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    
    let filter: FilterType
    
    var body: some View {
        NavigationView{
            List{
                ForEach(filteredProspects){prospects in
                    VStack(alignment: .leading){
                        Text(prospects.name)
                            .font(.headline)
                        Text(prospects.emailAddress)
                            .foregroundColor(.secondary)
                    }
                    .swipeActions{
                        if prospects.isConnected {
                            Button{
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person,crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        }
                        else {
                            Button{
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person,crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                        }
                    }
                }
            }
                .navigationTitle(title)
                .toolbar{
                    Button{
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
                .sheet(isPresented: $isShowingScanner){
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Zia Ahmed\nziaahmedryk@gmail.com", completion: handleScan)
                }
        }
    }
    var title: String {
        switch filter{
        case .none:
            return "Everyone"
        case .contacred:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    var filteredProspects: [Prospect]{
        switch filter {
        case .none:
            return prospects.people
        case .contacred:
            return prospects.people.filter { $0.isConnected }
        case .uncontacted:
            return prospects.people.filter { !$0.isConnected }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>)
    {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string?.components(separatedBy: "\n")
            guard details.count == 2 else { else }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.people.append(person)
            
        case .failure(let error):
            print("Scanning Failed: \(error.localizedDescription)")
            
        }
    }
}

struct ProspectsView_Previews: PreviewProvider{
    static var previews: some View{
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}

#Preview {
    ProspectsView(filter: .none)
}
