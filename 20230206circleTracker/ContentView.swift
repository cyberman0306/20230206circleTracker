//
//  ContentView.swift
//  20230206circleTracker
//
//  Created by yook on 2023/02/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: trackingView()) {
                Text("start tracking")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
