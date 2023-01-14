//
//  ProfileButton.swift
//  swifty-companion
//
//  Created by Kyllian on 14/01/2023.
//

import SwiftUI

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

struct ProfileButton: View {
	@Binding var projectSelected: Bool
	var isProjectButton: Bool
	
	var body: some View {
		Button(isProjectButton ? "Projects" : "Skills") {
			if (isProjectButton && !projectSelected) {
				self.projectSelected = true
			} else if (!isProjectButton && projectSelected) {
				self.projectSelected = false
			}
		}
		.if((projectSelected && isProjectButton) || (!projectSelected && !isProjectButton)) { view in
			view.foregroundColor(Color("BlueLight"))
		}
		.if((projectSelected && isProjectButton) || (!projectSelected && !isProjectButton)) { view in
			view.padding([.bottom], 5)
		}
		.if((projectSelected && isProjectButton) || (!projectSelected && !isProjectButton)) { view in
			view.overlay(
					Rectangle()
						.frame(height: 2.5)
						.foregroundColor(Color("BlueLight")),
					alignment: .bottom
				)
		}
		.font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
	}
}
