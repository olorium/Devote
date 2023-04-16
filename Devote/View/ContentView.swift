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
	@AppStorage("isDarkMode") private var isDarkMode = false
	@State var task: String = ""
	@State private var showNewTaskItem: Bool = false
	
	@Environment(\.managedObjectContext) private var viewContext
	
	@FetchRequest(
		sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
		animation: .default)
	
	private var items: FetchedResults<Item>
	
	// MARK: - Body
	var body: some View {
		NavigationView {
			ZStack {
				VStack {
					HStack(spacing: 10) {
						Text("Devote")
							.font(.largeTitle)
							.fontWeight(.heavy)
							.padding(.leading, 4)
						Spacer()
						EditButton()
							.font(.system(size: 16, weight: .semibold, design: .rounded))
							.padding(.horizontal, 10)
							.frame(minWidth: 70, minHeight: 24)
							.background(Capsule().stroke(Color.white, lineWidth: 2))
						Button {
							isDarkMode.toggle()
						} label: {
							Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
								.resizable()
								.frame(width: 24, height: 24)
								.font(.title)
						}

					}
					.padding()
					.foregroundColor(.white)
					
					Spacer(minLength: 80)
					
					Button {
						showNewTaskItem = true
					} label: {
						Image(systemName: "plus.circle")
							.font(.system(size: 30, weight: .semibold, design: .rounded))
						Text("New Task")
							.font(.system(size: 24, weight: .bold, design: .rounded))
					}
					.foregroundColor(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 15)
					.background(
						LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
							.clipShape(Capsule())
					)
					.shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 4.0)

					
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
						if items.isEmpty {
							Spacer()
								.listRowBackground(Color.clear)
						}
					}
					.listStyle(.insetGrouped)
					.scrollContentBackground(.hidden)
					.background(Color.clear)
					.shadow(color: .black.opacity(0.3), radius: 12)
					.padding(.vertical, 0)
					.frame(maxWidth: 640)
				}
				if showNewTaskItem {
					BlankView()
						.onTapGesture {
							withAnimation {
								showNewTaskItem = false
							}
						}
					NewTaskItemView(isShowing: $showNewTaskItem)
				}
			}
			.navigationTitle("Daily Tasks")
			.navigationBarHidden(true)
			.background(BackgroundImageView())
			.background(Constant.backgroundGradient.ignoresSafeArea())
		}.navigationViewStyle(StackNavigationViewStyle())
	}
	
	// MARK: - Methods
	
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
