//
//  CoreDataBootcamp.swift
//  Tutorial
//
//  Created by Hunter Walker on 8/31/21.
//

import SwiftUI
import CoreData
import Combine


class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        self.container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { disription, error in
            if let error = error {
                print("error loading coredata \(error)")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
           savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("\(error)")
        }
        
    }
    
    func updatefruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        savedData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        savedData()
    }
    
    
    func addFruit(text: String) {
        let newfruit = FruitEntity(context: container.viewContext)
        newfruit.name = text
    }
    
    func savedData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("\(error) saving")
        }
        
    }
    
}


struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State private var textFieldText: String = ""
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                TextField("add fruit here", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                Button(action: {
                    guard !textFieldText.isEmpty else {return}
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                }, label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
                        .cornerRadius(10)
                })
                .padding(.horizontal)
                
                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "n/a")
                            .onTapGesture {
                                vm.updatefruit(entity: entity)
                            }
                    }.onDelete(perform: vm.deleteFruit)
                }.listStyle(PlainListStyle())
                
                Spacer()
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
