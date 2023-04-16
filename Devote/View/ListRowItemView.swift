//
//  ListRowItemView.swift
//  Devote
//
//  Created by Oleksii Vasyliev on 16.04.2023.
//

import SwiftUI

struct ListRowItemView: View {
	// MARK: - Properties
	@Environment(\.managedObjectContext) var viewContext
	@ObservedObject var item: Item
	
	// MARK: - Body
    var body: some View {
		Toggle(isOn: $item.completion) {
			Text(item.task ?? "")
				.font(.title2)
				.fontWeight(.heavy)
				.foregroundColor(item.completion ? .pink : .primary)
				.padding(.vertical, 12)
		}
		.toggleStyle(CheckboxStyle())
		.onReceive(item.objectWillChange) { _ in
			if self.viewContext.hasChanges {
				try? self.viewContext.save()
			}
		}
    }
}
