//
//  ItemDetailFeature.swift
//  TCATreeBasedNavigationSample
//
//  Created by KoichiroUeki on 2024/09/01.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ItemDetailFeature {
    @ObservableState
    struct State: Equatable {
        var item: String
    }

    enum Action: Sendable {}

    var body: some Reducer<State, Action> {
        Reduce { _, _ in
            return .none
        }
    }
}

struct ItemDetailView: View {
    @Bindable var store: StoreOf<ItemDetailFeature>

    var body: some View {
        Text(" Item Detail of \(store.item)")
            .navigationTitle("Item Detail View")
    }
}
