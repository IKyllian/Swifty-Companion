//
//  ProfilePage.swift
//  swifty-companion
//
//  Created by Kyllian on 11/12/2022.
//

import SwiftUI

struct CircleImage: View {
	var userImageLink: String
	
	init(userImage: String) {
		self.userImageLink = userImage
	}
	
	var body: some View {
		AsyncImage(url: URL(string: userImageLink)) { image in
			image
				.resizable()
				.clipShape(Circle())
				.aspectRatio(contentMode: .fill)
				.overlay {
					Circle().stroke(.white, lineWidth: 3)
				}
				.shadow(radius: 7)
		} placeholder: {
			ProgressView()
		}.frame(width: 110, height: 110)
	}
}

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

struct SkillsView: View {
	var skills: [Skill]
	
	init(userSkills: [Skill]) {
		self.skills = userSkills
	}
	
	var body: some View {
		VStack() {
			Text("Skills")
			ScrollView {
				VStack() {
					ForEach(0..<skills.count, id: \.self) { index in
						ProgressView(value: skills[index].level, total: 20) {
							HStack() {
								Text(skills[index].name)
								Spacer()
								Text(String(skills[index].level))
							}
						}
						if (index < skills.count - 1) {
							Divider()
						}
					}
				}.frame(maxWidth: .infinity)
			}
			.padding()
		}
	}
}

struct ProfilePage: View {
	@Binding var userDatas: UserType?
	var cursusId: Int = 0
	
	init(userDatas: Binding<UserType?>) {
		self._userDatas = userDatas
		if (self.userDatas != nil) {
			cursusId = self.userDatas!.cursus_users.count - 1
		}
	}
	
    var body: some View {
		VStack() {
			VStack() {
				HStack() {
					CircleImage(userImage: userDatas!.cursus_users[cursusId].user.image.link)
					Spacer()
					VStack(alignment: .leading) {
						Text("\(userDatas!.cursus_users[cursusId].user.displayname) (\(userDatas!.cursus_users[cursusId].user.login))")
							.font(.title3)
							.fontWeight(.medium)
						Text(userDatas!.cursus_users[cursusId].user.email)
							.font(.footnote)
							.fontWeight(.light)
						Spacer()
							.frame(height: 10.0)
						if (userDatas!.cursus_users[cursusId].grade != nil) {
							Text("Grade: \(userDatas!.cursus_users[cursusId].grade!)")
								.font(.subheadline)
						}
						Text("Evaluation points: \(String(userDatas!.cursus_users[cursusId].user.correction_point))")
							.font(.subheadline)
						Text("Wallet: \(String(userDatas!.cursus_users[cursusId].user.wallet))")
							.font(.subheadline)
					}
				}
				ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/) {
					Text("Level 8.66")
				}
			}
			.padding([.leading, .bottom, .trailing])
			//.background(Image("Image-Background"))
			ProjectsView(userProjects: userDatas!.projects_users)
			SkillsView(userSkills: userDatas!.cursus_users[cursusId].skills)
		}
		//.background(Color(hue: 1.0, saturation: 0.0, brightness: 0.823))
    }
}

//struct ProfilePage_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfilePage()
//    }
//}
