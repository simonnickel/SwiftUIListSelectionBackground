//
//  ContentView.swift
//  SwiftUIListSelectionBackground
//
//  Created by Simon Nickel on 19.12.23.
//

import SwiftUI
import Observation

@Observable class SelectionState {
	var selectedItems: [ListItem] = []
}

struct ContentView: View {
	
	let selectionState = SelectionState()
	
    var body: some View {
		
		NavigationStack {
			
			ListView()
				.navigationTitle("List")
				.navigationDestination(for: ListItem.self) { item in
					ListView()
						.navigationTitle(item.title)
						.onAppear {
							selectionState.selectedItems.append(item)
						}
						.onDisappear {
							selectionState.selectedItems.removeAll(where: { $0 == item })
						}
				}
			
		}
		.environment(selectionState)

    }
	
}

struct ListItem: Identifiable, Hashable {
	let id: UUID = UUID()
	let title: String
}

struct ListView: View {
	
	@Environment(SelectionState.self) private var selectionState
	
	private let items: [ListItem] = {
		(0..<10).map({ ListItem(title: "Row \($0)") })
	}()
	
	var body: some View {
			
		List {
			ForEach(items, id: \.id) { item in
				NavigationLink(value: item) {
					Text(item.title)
				}
				.if(selectionState.selectedItems.contains(item)) { view in
					view.listRowBackground(
						Color.yellow
					)
				}
			}
		}

	}
}

#Preview {
    ContentView()
}

extension View {
	/// Applies the given transform if the given condition evaluates to `true`.
	/// - Parameters:
	///   - condition: The condition to evaluate.
	///   - transform: The transform to apply to the source `View`.
	/// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
	@ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
		if condition {
			transform(self)
		} else {
			self
		}
	}
}
