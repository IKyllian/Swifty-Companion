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

struct ProfilePage: View {
	@State private var selection = "Piscine"
	@State private var cursusId: Int = 0
	@State private var cursus = ["Piscine"]
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
		VStack() {
			VStack() {
				HStack() {
					VStack() {
						CircleImage(userImage: userDatas!.cursus_users[cursusId].user.image.link)
						Picker("Select a cursus", selection: $selection) {
							ForEach(cursus, id: \.self) {
								Text($0)
							}
						}
						.onAppear(perform: initSelection)
						.onChange(of: selection) { newValue in
							searchNewIndex(pickerValue: newValue)
						}
					}
					Spacer()
					VStack(alignment: .leading) {
						Text("\(userDatas!.cursus_users[cursusId].user.displayname)")
							.font(.title3)
							.fontWeight(.medium)
						Text("(\(userDatas!.cursus_users[cursusId].user.login))")
							.font(.subheadline)
							.fontWeight(.medium)
						Text(userDatas!.cursus_users[cursusId].user.email)
							.font(.footnote)
							.fontWeight(.light)
						Spacer()
							.frame(height: 10.0)
						Text("Grade: \(userDatas!.cursus_users[cursusId].grade ?? "Novice")")
							.font(.subheadline)
						Text("Evaluation points: \(String(userDatas!.cursus_users[cursusId].user.correction_point))")
							.font(.subheadline)
						Text("Wallet: \(String(userDatas!.cursus_users[cursusId].user.wallet))")
							.font(.subheadline)
					}
				}
				ProgressView(value: userDatas!.cursus_users[cursusId].level.truncatingRemainder(dividingBy: 1)) {
					Text("Level \(String(format: "%.2f", userDatas!.cursus_users[cursusId].level))")
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
