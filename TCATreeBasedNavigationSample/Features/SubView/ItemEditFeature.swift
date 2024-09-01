//
//  ItemEditFeature.swift
//  TCATreeBasedNavigationSample
//
//  Created by KoichiroUeki on 2024/09/01.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ItemEditFeature {
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

struct ItemEditView: View {
    @Bindable var store: StoreOf<ItemEditFeature>

    var body: some View {
        Text(" Item Edit of \(store.item)")
            .navigationTitle("Item Edit View")
    }
}
