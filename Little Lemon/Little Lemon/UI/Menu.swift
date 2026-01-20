//
//  menu.swift
//  Little Lemon
//
//  Created by Champani Hamy on 2026-01-19.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    
    var body: some View {
        VStack{
            TextField("Search Menu", text: $searchText, prompt: Text("Search.."))
            FetchedObjects(
                predicate:buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                List{
                    ForEach(dishes){
                        dish in
                        HStack{
                            Text("\(dish.name ?? "")")
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                        }
                    }
                }
            }
        }.task {
            await getMenuData()
        }
    }
    
    func buildPredicate() -> NSPredicate {
        return searchText == "" ? NSPredicate(value: true): NSPredicate(format: "name CONTAINS[cd] %@", searchText)
    }
    
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        [NSSortDescriptor(
            key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare)
        )]
        
    }
    
    func getMenuData() async{
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let urlSession = URLSession.shared
        
        do {
            PersistenceController.shared.clear()
            let (data, _) = try await urlSession.data(from: url)
            let menuList = try JSONDecoder().decode(MenuList.self, from: data)
            print("URL Session: \(menuList)")
            let menuItems = menuList.menu
            
            var dishes: [Dish] = []
            menuItems.forEach { item in
                let dish = Dish(context: viewContext)
                dish.name = item.title
                dish.image = item.image
                dish.price = item.price
                dishes.append(dish)
                
            }
            try? viewContext.save()
            
        }
        catch {
            // Check if error is actually cancellation
            if let urlError = error as? URLError, urlError.code == .cancelled {
                print("Request was cancelled - this is normal if the user navigated away.")
            } else {
                print("Error Occurred: \(error)")
            }
        }
        
        
        
    }
}



func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func itemsTask(with url: URL, completionHandler: @escaping (MenuList?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
