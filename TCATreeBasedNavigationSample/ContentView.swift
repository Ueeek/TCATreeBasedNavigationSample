//
//  ContentView.swift
//  TCATreeBasedNavigationSample
//
//  Created by KoichiroUeki on 2024/09/01.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        TabView {
            ItemListView1(store: .init(initialState: ItemListFeature1.State()) {
                ItemListFeature1()
            })
            .tabItem {
                Text("Tab 1")
            }

            ItemListView2(store: .init(initialState: ItemListFeature2.State()) {
                ItemListFeature2()
            })
            .tabItem {
                Text("Tab 2")
            }

            ItemListView3(store: .init(initialState: ItemListFeature3.State()) {
                ItemListFeature3()
            })
            .tabItem {
                Text("Tab 3")
            }
        }
    }
}

#Preview {
    ContentView()
}
