//
//  ItemListFeature2.swift
//  TCATreeBasedNavigationSample
//
//  Created by KoichiroUeki on 2024/09/01.
//

import Foundation
import ComposableArchitecture
import SwiftUI

var items2: [String] = ["Apple", "Banana", "Chocolate"]
var description2 = """
+ User can go to 3 screens from ItemListView
    1. ItemDetail
    2. ItemEdit
    3. ItemAdd
"""

@Reducer
struct ItemListFeature2 {
    @ObservableState
    struct State: Equatable {
        @Presents var itemDetail: ItemDetailFeature.State?
        @Presents var itemEdit: ItemEditFeature.State?
        @Presents var itemAdd: ItemAddFeature.State?

        var itemList: [String] = items2
    }

    enum Action: Sendable {
        case tapItem(item: String)
        case tapEdit(item: String)
        case tapAdd

        case itemDetail(PresentationAction<ItemDetailFeature.Action>)
        case itemEdit(PresentationAction<ItemEditFeature.Action>)
        case itemAdd(PresentationAction<ItemAddFeature.Action>)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tapItem(let item):
                state.itemDetail = ItemDetailFeature.State(item: item)
                return .none
            case .tapEdit(let item):
                state.itemEdit = ItemEditFeature.State(item: item)
                return .none
            case .tapAdd:
                state.itemAdd = ItemAddFeature.State()
                return .none
            case .itemDetail, .itemEdit, .itemAdd:
                return .none
            }
        }
        .ifLet(\.$itemDetail, action: \.itemDetail) {
            ItemDetailFeature()
        }
        .ifLet(\.$itemEdit, action: \.itemEdit) {
            ItemEditFeature()
        }
        .ifLet(\.$itemAdd, action: \.itemAdd) {
            ItemAddFeature()
        }
    }
}

struct ItemListView2: View {
    @Bindable var store: StoreOf<ItemListFeature2>

    var body: some View {
        NavigationStack {
            VStack {
                Text(description2)
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
            .navigationDestination(item: $store.scope(state: \.itemDetail, action: \.itemDetail)) { store in
                ItemDetailView(store: store)
            }
            .navigationDestination(item: $store.scope(state: \.itemEdit, action: \.itemEdit)) { store in
                ItemEditView(store: store)
            }
            .sheet(item: $store.scope(state: \.itemAdd, action: \.itemAdd)) { store in
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
