//
//  ContentView.swift
//  Moonshot
//
//  Created by Michele Volpato on 17/12/2020.
//

import SwiftUI

struct CustomText: View {
    var text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geo in
                    Image("100days")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width)
                }
                Button("Decode JSON") {
                    let input = """
    {
        "name": "Taylor Swift",
        "address": {
            "street": "555, Taylor Swift Avenue",
            "city": "Nashville"
        }
    }
    """

                    let data = Data(input.utf8)
                    let decoder = JSONDecoder()
                    if let user = try? decoder.decode(User.self, from: data) {
                        print(user.address.street)
                    }
                }
                NavigationLink(destination: listLinks) {
                    Text("Hello World")
                }
                ScrollView(.vertical) {
                    VStack(spacing: 10) {
                        ForEach(0..<20) {
                            CustomText("Item \($0)")
                                .font(.title)
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationBarTitle("SwiftUI")
        }
    }

    var listLinks: some View {
        List(0..<100) { row in
            NavigationLink(destination: Text("Detail \(row)")) {
                Text("Row \(row)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
