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
				.shadow(color: Color("Blue2"), radius: 5)
		} placeholder: {
			ProgressView()
		}
		.frame(width: 150, height: 150)
	}
}

struct ProfilePage: View {
	@State private var selection = "Piscine"
	@State private var cursusId: Int = 0
	@State private var cursus = ["Piscine"]
	@State private var projectSelected: Bool = true
	@Binding var userDatas: UserType?
	
	init(userDatas: Binding<UserType?>) {
		self._userDatas = userDatas
	}
	
	func initSelection() {
		if (self.userDatas != nil) {
			for userCursus in self.userDatas!.cursus_users {
				if (userCursus.grade == "Learner") {
					if (!self.cursus.contains("42cursus")) {
						self.cursus.append("42cursus")
					}
				} else if (userCursus.grade == "Member") {
					if (!self.cursus.contains("42cursus")) {
						self.cursus.append("42cursus")
					}
				} else if (userCursus.grade == "Commander") {
					if (!self.cursus.contains("42")) {
						self.cursus.append("42")
					}
				}
			}
			
			self.cursusId = self.userDatas!.cursus_users.count - 1
			
			if (self.userDatas!.cursus_users[self.cursusId].grade == "Learner" || self.userDatas!.cursus_users[self.cursusId].grade == "Member") {
				self.selection = "42cursus"
			} else if (self.userDatas!.cursus_users[self.cursusId].grade == "Commander") {
				self.selection = "42"
			}
		}
	}
	
	func searchNewIndex(pickerValue: String) {
		var count: Int = 0
		if (self.userDatas != nil) {
			for userCursus in self.userDatas!.cursus_users {
				if (pickerValue == "42cursus" && userCursus.grade == "Learner" || userCursus.grade == "Member") {
					self.cursusId = count
					break
				} else if (pickerValue == "42" && userCursus.grade == "Commander") {
					self.cursusId = count
					break
				} else if (pickerValue == "Piscine" && userCursus.grade == nil) {
					self.cursusId = count
					break
				}
				count += 1
			}
		}
	}
	
	var body: some View {
		ZStack() {
			backgroundGradient
				.ignoresSafeArea()
			VStack() {
				VStack() {
					CircleImage(userImage: userDatas!.cursus_users[cursusId].user.image.link)
					Text("\(userDatas!.cursus_users[cursusId].user.displayname)")
						.font(.title3)
						.fontWeight(.medium)
					Text("(\(userDatas!.cursus_users[cursusId].user.login))")
						.font(.subheadline)
						.fontWeight(.medium)
					Text(userDatas!.cursus_users[cursusId].user.email)
						.font(.footnote)
						.fontWeight(.light)
						.padding(.vertical, 1)
					HStack(alignment: .center, spacing: 40.0) {
						VStack(alignment: .center) {
							Text("\(String(userDatas!.cursus_users[cursusId].user.wallet))")
								.font(.headline)
							Text("WALLET").foregroundColor(Color("Blue2")).font(.caption)
						}
						VStack(alignment: .center) {
							if (userDatas!.campus.count > 0) {
								Text("\(userDatas!.campus[0].name)")
									.font(.headline)
							} else {
								Text("Null")
									.font(.headline)
							}
							Text("CAMPUS").foregroundColor(Color("Blue2")).font(.caption)
						}
						VStack(alignment: .center) {
							Text("\(userDatas!.cursus_users[cursusId].grade ?? "Novice")")
								.font(.headline)
							Text("GRADRE").foregroundColor(Color("Blue2")).font(.caption)
						}
						VStack(alignment: .center) {
							Text("\(String(userDatas!.cursus_users[cursusId].user.correction_point))")
								.font(.headline)
							Text("CORR.PTS").foregroundColor(Color("Blue2")).font(.caption)
						}
					}
					.padding(.horizontal)
					Picker("Select a cursus", selection: $selection) {
						ForEach(cursus, id: \.self) {
							Text($0)
						}
					}
					.onAppear(perform: initSelection)
					.onChange(of: selection) { newValue in
						searchNewIndex(pickerValue: newValue)
					}
					ProgressView(value: userDatas!.cursus_users[cursusId].level.truncatingRemainder(dividingBy: 1)) {
						Text("Level \(String(format: "%.2f", userDatas!.cursus_users[cursusId].level))")
							.multilineTextAlignment(.center)
							.frame(maxWidth: .infinity)
					}
					.padding(.horizontal)
				}
				.frame(minWidth: 0, maxWidth: .infinity)
				.foregroundColor(.white)
				HStack(alignment: .center, spacing: 30.0) {
					ProfileButton(projectSelected: $projectSelected, isProjectButton: true)
					ProfileButton(projectSelected: $projectSelected, isProjectButton: false)
				}
				.padding(.top, 4)
				if (projectSelected) {
					ProjectsView(userProjects: userDatas!.projects_users)
				} else {
					SkillsView(userSkills: userDatas!.cursus_users[cursusId].skills)
				}
			}
		}
		.foregroundColor(.white)
	}
}
