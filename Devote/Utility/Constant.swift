//
//  Constant.swift
//  Devote
//
//  Created by Oleksii Vasyliev on 11.04.2023.
//

import Foundation

enum Constant {
	
	// MARK: - Formatter.
	
	static let itemFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		formatter.timeStyle = .medium
		return formatter
	}()
	
	// MARK: - UI
	
	// MARK: - UX
}
