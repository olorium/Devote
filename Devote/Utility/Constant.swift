//
//  Constant.swift
//  Devote
//
//  Created by Oleksii Vasyliev on 11.04.2023.
//

import SwiftUI

enum Constant {
	
	// MARK: - Formatter.
	
	static let itemFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		formatter.timeStyle = .medium
		return formatter
	}()
	
	// MARK: - UI
	
	static var backgroundGradient: LinearGradient {
		LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
	}
	
	// MARK: - UX
}
