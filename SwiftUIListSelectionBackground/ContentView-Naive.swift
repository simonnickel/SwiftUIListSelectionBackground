//
//  ContentView.swift
//  SwiftUIListSelectionBackground
//
//  Created by Simon Nickel on 19.12.23.
//

import SwiftUI

struct ContentViewNaive: View {
	
	
	var body: some View {
		
		NavigationStack {
			
			ListViewNaive()
				.navigationTitle("List")
			
		}

	}
}

struct ListViewNaive: View {
	
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
		// > A navigationDestination for “Swift.Int” was declared earlier on the stack. Only the destination declared closest to the root view of the stack will be used.
		// See updated approach in ContentView.swift
		.navigationDestination(for: Int.self) { row in
			ListViewNaive()
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
