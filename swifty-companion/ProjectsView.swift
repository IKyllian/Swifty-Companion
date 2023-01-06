//
//  ProjectsView.swift
//  swifty-companion
//
//  Created by Kyllian on 06/01/2023.
//

import SwiftUI

struct ProjectsView: View {
	var projects: [Project]
	
	init(userProjects: [Project]) {
		self.projects = userProjects
	}
	
	var body: some View {
		VStack() {
			Text("Projects")
			ScrollView {
				VStack() {
					ForEach(0..<projects.count, id: \.self) { index in
						HStack {
							Text(projects[index].project.name)
							Spacer()
								.padding()
							if (projects[index].status == "finished") {
								Text(String(projects[index].final_mark ?? 0))
								Image(systemName: "checkmark.circle")
									.foregroundColor(.green)
							} else if (projects[index].status == "in_progress") {
								Text("In Progress")
							} else {
								Image(systemName: "xmark.circle.fill")
									.foregroundColor(.red)
							}
						}
						if (index < projects.count - 1) {
							Divider()
						}
					}
				}.frame(maxWidth: .infinity)
			}
			.padding()
		}
	}
}

//struct ProjectsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectsView()
//    }
//}
