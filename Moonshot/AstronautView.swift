//
//  AstronautView.swift
//  Moonshot
//
//  Created by Michele Volpato on 19/12/2020.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let crewMissions: [Mission]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)

                    HStack {
                        Text("Missions:")
                            .font(.headline)
                            .padding()
                        Spacer()
                    }

                    ForEach(crewMissions) { (mission) in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .frame(width: 50, height: 50)

                            Text(mission.displayName)
                                .font(.headline)

                            Spacer()

                            if (mission.launchDate != nil) {
                                Text(mission.formattedLaunchDate)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }

    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut

        self.crewMissions = missions.filter { (mission) -> Bool in
            mission.crew.contains { (crewRole) -> Bool in
                crewRole.name == astronaut.id
            }
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
