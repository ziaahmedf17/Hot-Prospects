//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Zi on 21/08/2025.
//

import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacred, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
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
                }
            }
                .navigationTitle(title)
                .toolbar{
                    Button{
                        let prospect = Prospect()
                        prospect.name = "Zia Ahmed"
                        prospect.emailAddress = "ziaahmedryk@gmail.com"
                        prospects.people.append(prospect)
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
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
