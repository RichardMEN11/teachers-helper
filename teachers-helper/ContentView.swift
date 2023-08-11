//
//  ContentView.swift
//  teachers-helper
//
//  Created by Richard Menning on 11.08.23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let data = (1...20).map { $0 }

    var body: some View {
        ScrollView {
                   LazyVGrid(columns: [
                       GridItem(.flexible(minimum: 100, maximum: 200)),
                       GridItem(.flexible(minimum: 100, maximum: 200)),
                       GridItem(.flexible(minimum: 100, maximum: 200))
                   ], spacing: 16) {
                       ForEach(data, id: \.self) { item in
                           Text("\(item)")
                               .frame(maxWidth: .infinity, maxHeight: .infinity)
                               .background(Color.blue)
                               .foregroundColor(.white)
                       }
                   }
                   .padding()
               }
           }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
