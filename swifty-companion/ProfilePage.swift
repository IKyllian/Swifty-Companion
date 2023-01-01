//
//  ProfilePage.swift
//  swifty-companion
//
//  Created by Kyllian on 11/12/2022.
//

import SwiftUI

struct CircleImage: View {
	var body: some View {
		Image("ImageTest")
			.resizable()
			.clipShape(Circle())
		   .aspectRatio(contentMode: .fill)
			.frame(width: 110, height: 110)
			.overlay {
				Circle().stroke(.white, lineWidth: 3)
			}
			.shadow(radius: 7)
	}
}

struct ProjectsView: View {
	var body: some View {
		VStack() {
			Text("Projects")
			ScrollView {
				VStack {
					HStack {
						Text("Minishell")
						Spacer()
							.padding()
						Text("100")
						Image(systemName: "checkmark.circle")
							.foregroundColor(.green)
					}
					Divider()
					HStack {
						Text("Minishell")
						Spacer()
							.padding()
						Text("20")
						Image(systemName: "xmark.circle.fill")
							.foregroundColor(.red)
					}
					Divider()
					HStack {
						Text("Minishell")
						Spacer()
							.padding()
						Text("20")
						Image(systemName: "xmark.circle.fill")
							.foregroundColor(.red)
					}
					Divider()
					HStack {
						Text("Minishell")
						Spacer()
							.padding()
						Text("20")
						Image(systemName: "xmark.circle.fill")
							.foregroundColor(.red)
					}
					Divider()
					HStack {
						Text("Minishell")
						Spacer()
							.padding()
						Text("20")
						Image(systemName: "xmark.circle.fill")
							.foregroundColor(.red)
					}
				}.frame(maxWidth: .infinity)
			}
			.padding()
		}
	}
}

struct SkillsView: View {
	var body: some View {
		VStack() {
			Text("Skills")
			ScrollView {
				VStack() {
					ProgressView(value: 0.5) {
						HStack() {
							Text("Imperative programming")
							Spacer()
							Text("4.57")
						}
					}
					Divider()
					ProgressView(value: 0.5) {
						HStack() {
							Text("Imperative programming")
							Spacer()
							Text("4.57")
						}
					}
					Divider()
					ProgressView(value: 0.5) {
						HStack() {
							Text("Imperative programming")
							Spacer()
							Text("4.57")
						}
					}
					Divider()
					ProgressView(value: 0.5) {
						HStack() {
							Text("Imperative programming")
							Spacer()
							Text("4.57")
						}
					}
					Divider()
					ProgressView(value: 0.5) {
						HStack() {
							Text("Imperative programming")
							Spacer()
							Text("4.57")
						}
					}
					Divider()
					
					
				}.frame(maxWidth: .infinity)
			}
			.padding()
		}
		
	}
}

struct ProfilePage: View {
//	@Binding var userDatas: UserType?
//	
//	init(userDatas: Binding<UserType?>) {
//		self._userDatas = userDatas
//	}
	
	
    var body: some View {
		VStack() {
			VStack() {
				HStack() {
					CircleImage()
					Spacer()
					VStack(alignment: .leading) {
						Text("Kyllian Delporte (kdelport)")
							.font(.title3)
							.fontWeight(.medium)
						Text("kdelport@student.42lyon.fr")
							.font(.footnote)
							.fontWeight(.light)
						Spacer()
							.frame(height: 10.0)
						Text("Wallet: 636")
							.font(.subheadline)
						Text("Evaluation points: 4")
							.font(.subheadline)
						Text("Grade: Learner")
							.font(.subheadline)
						
					}
				}
				ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/) {
					Text("Level 8.66")
				}
			}
			.padding()
			ProjectsView()
			SkillsView()
		}
		//.background(Color(hue: 1.0, saturation: 0.0, brightness: 0.823))
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
