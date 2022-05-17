//
//  ContentView.swift
//  Bookworm
//
//  Created by Lucas Chae on 5/17/22.
//

import SwiftUI

struct ContentView: View {
    // Create a fetch request with no sorting, and place it into a property called students that has the the type FetchedResults<Student>. -> You can use this like a regular array of Students (but with a catch)
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var listOfBooks: FetchedResults<Book>
    
    // Managed Object Context (like a container for all the manged objects?)
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var addBookReview = false
    
    
    var body: some View {
        NavigationView {
            List{
                ForEach(listOfBooks) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
                
            }
            .navigationTitle("Bookworm")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addBookReview.toggle()
                    } label: {
                        Label("Add book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $addBookReview) {
                AddBookView()
            }
            
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = listOfBooks[offset]
            managedObjectContext.delete(book)
        }
        try? managedObjectContext.save()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
