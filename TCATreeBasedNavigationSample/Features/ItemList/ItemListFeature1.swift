//
//  ItemListFeature.swift
//  TCATreeBasedNavigationSample
//
//  Created by KoichiroUeki on 2024/09/01.
//

import ComposableArchitecture
import SwiftUI

var items1: [String] = ["Apple", "Banana", "Chocolate"]
var description1 = """
+ Implement ItemListView and ItemDetailView with TCA
+ User can go to ItemDetail from ItemListView
"""

@Reducer
struct ItemListFeature1 {
    @ObservableState
    struct State: Equatable {
        @Presents var itemDetail: ItemDetailFeature.State?
        var itemList: [String] = items1
    }

    enum Action: Sendable {
        case tapItem(item: String)
        case itemDetail(PresentationAction<ItemDetailFeature.Action>)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tapItem(let item):
                state.itemDetail = ItemDetailFeature.State(item: item)
                return .none
            case .itemDetail:
                return .none
            }
        }
        .ifLet(\.$itemDetail, action: \.itemDetail) {
            ItemDetailFeature()
        }
    }
}

struct ItemListView1: View {
    @Bindable var store: StoreOf<ItemListFeature1>

    var body: some View {
        NavigationStack {
            VStack {
                Text(description1)
                    .font(.headline)
                    .padding(.horizontal, 10)
                List {
                    ForEach(store.itemList, id: \.self) { item in
                        Button(action: {
                            store.send(.tapItem(item: item))
                        }, label: {
                            Text("Item: \(item)")
                        })
                    }
                }
            }
            .navigationDestination(item: $store.scope(state: \.itemDetail, action: \.itemDetail)) { store in
                ItemDetailView(store: store)
            }
            .navigationTitle("Item List View")
        }
    }
}
