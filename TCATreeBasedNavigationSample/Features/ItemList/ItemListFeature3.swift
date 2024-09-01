//
//  ItemListFeature3.swift
//  TCATreeBasedNavigationSample
//
//  Created by KoichiroUeki on 2024/09/01.
//

import Foundation
import ComposableArchitecture
import SwiftUI

var items3: [String] = ["Apple", "Banana", "Chocolate"]
var description3 = """
+ User can go to 3 screens from ItemListView
    1. ItemDetail
    2. ItemEdit
    3. ItemAdd
+ Use `Destination enum`
"""

@Reducer
struct ItemListFeature3 {
    @Reducer(state: .equatable)
    enum Destination {
        case itemDetail(ItemDetailFeature)
        case itemEdit(ItemEditFeature)
        case itemAdd(ItemAddFeature)
    }

    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?

        var itemList: [String] = items2
    }

    enum Action: Sendable {
        case tapItem(item: String)
        case tapEdit(item: String)
        case tapAdd

        case destination(PresentationAction<Destination.Action>)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tapItem(let item):
                state.destination = .itemDetail(ItemDetailFeature.State(item: item))
                return .none
            case .tapEdit(let item):
                state.destination = .itemEdit(ItemEditFeature.State(item: item))
                return .none
            case .tapAdd:
                state.destination = .itemAdd(ItemAddFeature.State())
                return .none
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

struct ItemListView3: View {
    @Bindable var store: StoreOf<ItemListFeature3>

    var body: some View {
        NavigationStack {
            VStack {
                Text(description3)
                    .font(.headline)
                    .padding(.horizontal, 10)
                List {
                    ForEach(store.itemList, id: \.self) { item in
                        HStack {
                            Button(action: {
                                store.send(.tapItem(item: item))
                            }, label: {
                                Text("Item: \(item)")
                            })
                            .swipeActions(edge: .trailing) {
                                Button(action: {
                                    store.send(.tapEdit(item: item))
                                }, label: {
                                    Text("Edit")
                                })
                            }
                        }
                    }
                }
            }
            .navigationDestination(item: $store.scope(state: \.destination?.itemDetail, action: \.destination.itemDetail)) { store in
                ItemDetailView(store: store)
            }
            .navigationDestination(item: $store.scope(state: \.destination?.itemEdit, action: \.destination.itemEdit)) { store in
                ItemEditView(store: store)
            }
            .sheet(item: $store.scope(state: \.destination?.itemAdd, action: \.destination.itemAdd)) { store in
                ItemAddView(store: store)
            }
            .navigationTitle("Item List View")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        store.send(.tapAdd)
                    }, label: {
                        Text("Add")
                    })
                }
            }
        }
    }
}
