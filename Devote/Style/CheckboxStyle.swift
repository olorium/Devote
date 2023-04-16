//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Oleksii Vasyliev on 16.04.2023.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
				.foregroundColor(configuration.isOn ? .pink : .primary)
				.font(.system(size: 30, weight: .semibold, design: .rounded))
				.onTapGesture {
					configuration.isOn.toggle()
				}
			configuration.label
			
		}
	}
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
		Toggle("Placeholder", isOn: .constant(false))
			.toggleStyle(CheckboxStyle())
			.padding()
    }
}
