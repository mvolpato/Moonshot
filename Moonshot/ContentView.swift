//
//  ContentView.swift
//  Moonshot
//
//  Created by Michele Volpato on 17/12/2020.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showLaunchDates = true

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, missions: missions)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if (showLaunchDates) {
                            Text(mission.formattedLaunchDate)
                        } else {
                            Text(memberNames(for: mission))
                                .font(.caption2)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.showLaunchDates.toggle()
                                    }) {
                                        Image(systemName: self.showLaunchDates ? "person.3.fill" : "calendar")
                                    }
            )
        }
    }

    private func memberNames(for mission: Mission) -> String {
        var matches = [String]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(match.name)
            } else {
                fatalError("Missing \(member)")
            }
        }

        return matches.joined(separator: ", ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
