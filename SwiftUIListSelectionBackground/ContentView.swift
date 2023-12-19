//
//  ContentView.swift
//  SwiftUIListSelectionBackground
//
//  Created by Simon Nickel on 19.12.23.
//

import SwiftUI

struct ContentView: View {
	
	
    var body: some View {
		
		NavigationStack {
			
			ListView()
				.navigationTitle("List")
			
		}

    }
}

struct ListView: View {
	
	@State var selected: Int? = nil
	
	var body: some View {
			
		List {
			ForEach(0..<10) { row in
				NavigationLink(value: row) {
					Text("Row \(row)")
				}
				.if(selected == row) { view in
					view.listRowBackground(
						Color.yellow
					)
				}
			}
		}
		// TODO: Same Destination type on each instance of ListView.
		// > A navigationDestination for “Swift.Int” was declared earlier on the stack. Only the destination declared closest to the root view of the stack will be used.
		// Needs either a unique type for each List or unique List items and a shared array of selected items.
		.navigationDestination(for: Int.self) { row in
			ListView()
				.navigationTitle("Row \(row)")
				.onAppear {
					selected = row
				}
				.onDisappear {
					selected = nil
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
