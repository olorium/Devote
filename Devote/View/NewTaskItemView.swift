//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Oleksii Vasyliev on 16.04.2023.
//

import SwiftUI

struct NewTaskItemView: View {
	// MARK: - Properties
	@Environment(\.managedObjectContext) private var viewContext
	@AppStorage("isDarkMode") private var isDarkMode = false
	@State private var task = ""
	@Binding var isShowing: Bool
	private var isButtonDisabled: Bool {
		task.isEmpty
	}
	
	// MARK: - Body
    var body: some View {
		VStack {
			Spacer()
			
			VStack(spacing: 16) {
				TextField("New Task", text: $task)
					.foregroundColor(.pink)
					.font(.system(size: 24, weight: .bold, design: .rounded))
					.padding()
					.background(Color(isDarkMode ? UIColor.tertiarySystemBackground : UIColor.secondarySystemBackground))
					.cornerRadius(10)
				Button {
					addItem()
				} label: {
					Spacer()
					Text("SAVE")
						.font(.system(size: 24, weight: .bold, design: .rounded))
					Spacer()
				}
				.disabled(isButtonDisabled)
				.padding()
				.foregroundColor(.white)
				.background(isButtonDisabled ? Color.blue : Color.pink)
				.cornerRadius(10)
			}
			.padding(.horizontal)
			.padding(.vertical, 20)
			.background(isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white)
			.cornerRadius(16)
			.shadow(color: .black.opacity(0.65), radius: 24)
			.frame(maxWidth: 640)
		}
		.padding()
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
			isShowing = false
		}
	}
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
		NewTaskItemView(isShowing: .constant(true))
			.background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
