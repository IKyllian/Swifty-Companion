//
//  Types.swift
//  swifty-companion
//
//  Created by Kyllian on 01/01/2023.
//

import Foundation

struct ImageVersions: Codable {
	var large: String
	var medium: String
	var micro: String
	var lasmallrge: String
}

struct ImageType: Codable {
	var link: String
	//var versions: ImageVersions
}

struct ProjectInfo: Codable {
	var name: String
}

struct Project: Codable {
	var id: Double
	var created_at: String
	var final_mark: Int?
	var project: ProjectInfo
	var status: String
	var validated: Bool?
}

struct Skill: Codable {
	var id: Int
	var level: Float
	var name: String
}

struct User: Codable {
	var displayname: String
	var email: String
	var login: String
	var correction_point: Int
	var wallet: Int
	var image: ImageType
	var kind: String
}

struct Cursus: Codable {
	var user: User
	var level: Float
	var grade: String?
	var skills: [Skill]
	
}

struct UserType: Codable {
	var cursus_users: [Cursus]
	var projects_users: [Project]
}

struct ResponseToken: Codable {
	let access_token: String
	let created_at: Int
	let expires_in: Int
	let scope: String
	let token_type: String
}
