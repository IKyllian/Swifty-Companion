//
//  SkillsView.swift
//  swifty-companion
//
//  Created by Kyllian on 06/01/2023.
//

import SwiftUI

struct SkillsView: View {
	var skills: [Skill]
	
	init(userSkills: [Skill]) {
		self.skills = userSkills
	}
	
	var body: some View {
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
