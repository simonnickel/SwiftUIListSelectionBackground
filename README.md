#  Navigation List Selection Background

A little example project to demonstrate how to highlight list rows in a `NavigationStack`.


## Goal

A List of NavigationLinks in a NavigationStack. The expected behaviour is to highlight the row of the selected NavigationLink and only remove the highlight when the destination view is popped from the stack.


## Obstacles

 - List selection binding does not work together with NavigationLink.
 - The closest NavigationDestination to the root is used. This means you can't overwrite the destination for each Entity of your View (see ContentView-Naive.swift).


## Related Feedback Tickets

FB12515251 - .listRowBackground should have a value for when its highlighted.
FB13091169 - A List of NavigationLinks should be able to define the selected background color
