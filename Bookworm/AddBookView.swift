//
//  AddBookView.swift
//  Bookworm
//
//  Created by Lucas Chae on 5/17/22.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State var title = ""
    @State private var author = ""
    @State private var review = ""
    @State private var genre = ""
    @State private var rating = 3
    
    let generes = ["Fantsy", "Horror", "Mystery", "Thriller", "Romance", "Kids"]

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Book Title", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(generes, id: \.self) { genre in
                            Text(genre)
                        }
                        
                    }

                }
                Section {
                    TextEditor(text: $review)

                    RatingView(rating: $rating)
                    
                } header: {
                    Text("Write a review")
                }
                Section {
                    Button("Save") {
                        // Add book to moc
                        let newBook = Book(context: managedObjectContext)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.genre = genre
                        newBook.review = review
                        newBook.rating = Int16(rating)
                        
                        try? managedObjectContext.save()
                        dismiss()
                        
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()    }
}
