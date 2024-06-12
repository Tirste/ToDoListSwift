//
//  MainView.swift
//  ToDoListApp
//
//  Created by student on 01/06/2024.
//

import SwiftUI
import CoreData

struct MainView: View {
    // zapytanie FetchRequest pobierajace kategorie z CoreData
    @FetchRequest(
        entity: Category.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)]
    ) var categories: FetchedResults<Category>
    
   // dostep do zawartosci zarzadzanej przez Core Data
    @Environment(\.managedObjectContext) private var viewContext
    // okreslenie czy widok jest pokazywany
    @State private var showingEditCategoryView = false
    // aktualni edytowana kategoria
    @State private var categoryToEdit: Category?
    
    
    var body: some View {
        NavigationView {
            VStack {
                // container do wyswietlania zdjecia z okreslonymi parametrami
                GeometryReader { geometry in
                    Image("bg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                }
        
                Text("Kategorie")
                    .font(.title3)
               
               //lista kategorii
                List {
                    ForEach(categories) { category in
                        NavigationLink(destination: TaskListView(category: category)) {
                            Text(category.name ?? "")
                        }
                        // menu 
                        .contextMenu {
                            Button("Edytuj") {
                                categoryToEdit = category
                                showingEditCategoryView = true
                            }
                            Button("Usun") {
                                deleteCategory(category: category)
                            }
                        }
                        // gest przesuniecia
                        .swipeActions(edge: .leading) {
                            Button(role: .destructive) {
                                deleteCategory(category: category)
                            } label: {
                                Label("Usun", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // przycisk dodania nowej kategorii
                    NavigationLink(destination: AddCategoryView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            // edycja kategorii (widok typu sheet)
            .sheet(isPresented: $showingEditCategoryView) {
                if let categoryToEdit = categoryToEdit {
                    EditCategoryView(category: categoryToEdit)
                }
            }
        }
    }
    
    // funkcja do usuwania kategorii 
    private func deleteCategory(category: Category) {
        withAnimation {
            let context = category.managedObjectContext
            context?.delete(category)
            
            do {
                try context?.save()
            } catch {
                print("Wystapil problem podczas usuwania kategorii: \(error.localizedDescription)")
            }
        }
    }
}
