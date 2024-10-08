//
//  ItemAddFeature.swift
//  TCATreeBasedNavigationSample
//
//  Created by KoichiroUeki on 2024/09/01.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ItemAddFeature {
    @ObservableState
    struct State: Equatable {}

    enum Action: Sendable {}

    var body: some Reducer<State, Action> {
        Reduce { _, _ in
            return .none
        }
    }
}

struct ItemAddView: View {
    @Bindable var store: StoreOf<ItemAddFeature>

    var body: some View {
        Text(" Item Add")
            .navigationTitle("Item Add View")
    }
}
