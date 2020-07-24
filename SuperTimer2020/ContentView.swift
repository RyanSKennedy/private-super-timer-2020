//
//  ContentView.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 21.06.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            List {
                NavigationLink(destination: StandartStopwatch()) {
                    Image(systemName: "stopwatch")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                    VStack (alignment: .leading) {
                        Text("Standart Stopwatcher")
                            .font(.title)
                        Text("Default stopwatcher")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                NavigationLink(destination: StandartTimer()) {
                    Image(systemName: "timer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                    VStack (alignment: .leading) {
                        Text("Standart Timer")
                            .font(.title)
                        Text("Default timer")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                NavigationLink(destination: AdvancedTimer()) {
                    Image(systemName: "goforward.plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                    VStack (alignment: .leading) {
                        Text("Advanced Timer")
                            .font(.title)
                        Text("Timer available for modify")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                NavigationLink(destination: IntervalTimerSet()) {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.yellow)
                    VStack (alignment: .leading) {
                        Text("Interval Timer")
                            .font(.title)
                        Text("Simple interval timer")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                NavigationLink(destination: AnyView(Text("Adv Interval Timer page..."))) {
                    Image(systemName: "arrow.clockwise.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                    VStack (alignment: .leading) {
                        Text("Adv Interval Timer")
                            .font(.title)
                        Text("Interval timer available for modify")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                NavigationLink(destination: AnyView(Text("Super Custom Timer page..."))) {
                    Image(systemName: "arrow.2.circlepath.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                    VStack (alignment: .leading) {
                        Text("Super Custom Timer")
                            .font(.title)
                        Text("Maximum flexible timer")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                NavigationLink(destination: SavedTimers()) {
                    Image(systemName: "bookmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                    VStack (alignment: .leading) {
                        Text("My Saved Timers")
                            .font(.title)
                        Text("My presets of timers")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                NavigationLink(destination: Records()) {
                    Image(systemName: "pencil.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.purple)
                    VStack (alignment: .leading) {
                        Text("My Records")
                            .font(.title)
                        Text("My saveded results")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationBarTitle(Text("Timers"), displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: CurrentUserProfile()) {
                    Image(systemName: "person").imageScale(.large)
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
