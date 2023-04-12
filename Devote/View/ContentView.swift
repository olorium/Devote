//
//  ContentView.swift
//  Devote
//
//  Created by Oleksii Vasyliev on 11.04.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
	// MARK: - Properties
	@State var task: String = ""
	private var isButtonDisabled: Bool {
		task.isEmpty
	}
	
	@Environment(\.managedObjectContext) private var viewContext
	
	@FetchRequest(
		sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
		animation: .default)
	
	private var items: FetchedResults<Item>
	
	// MARK: - Body
	var body: some View {
		NavigationView {
			VStack {
				VStack(spacing: 16) {
					TextField("New Task", text: $task)
						.padding()
						.background(Color(UIColor.systemGray6))
						.cornerRadius(10)
					Button {
						addItem()
					} label: {
						Spacer()
						Text("SAVE")
						Spacer()
					}
					.disabled(isButtonDisabled)
					.padding()
					.font(.headline)
					.foregroundColor(.white)
					.background(isButtonDisabled ? Color.gray : Color.pink)
					.cornerRadius(10)
				}
				.padding()
				List {
					ForEach(items) { item in
						VStack(alignment: .leading) {
							Text(item.task ?? "")
								.font(.headline)
								.fontWeight(.bold)
							Text("Item at \(item.timestamp!, formatter: Constant.itemFormatter)")
								.font(.footnote)
								.foregroundColor(.gray)
							
						}
					}
					.onDelete(perform: deleteItems)
				}
				.navigationTitle("Daily Tasks")
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						EditButton()
					}
				}
			}
		}
	}
	
	// MARK: - Methods
	private func addItem() {
		withAnimation {
			let newItem = Item(context: viewContext)
			newItem.timestamp = Date()
			newItem.task = task
			newItem.completion = false
			newItem.id = UUID()
			
			do {
				try viewContext.save()
			} catch {
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
			
			task = ""
			hideKeyboard()
		}
	}
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			offsets.map { items[$0] }.forEach(viewContext.delete)
			
			do {
				try viewContext.save()
			} catch {
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
