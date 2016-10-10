//
//	YKCreator.swift
//
//	Create by coderLL on 9/10/2016
//	Copyright © 2016. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct YKCreator{

	var birth : String!
	var descriptionField : String!
	var emotion : String!
	var gender : Int!
	var gmutex : Int!
	var hometown : String!
	var id : Int!
	var inkeVerify : Int!
	var level : Int!
	var location : String!
	var nick : String!
	var portrait : String!
	var profession : String!
	var rankVeri : Int!
	var thirdPlatform : String!
	var veriInfo : String!
	var verified : Int!
	var verifiedReason : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		birth = dictionary["birth"] as? String
		descriptionField = dictionary["description"] as? String
		emotion = dictionary["emotion"] as? String
		gender = dictionary["gender"] as? Int
		gmutex = dictionary["gmutex"] as? Int
		hometown = dictionary["hometown"] as? String
		id = dictionary["id"] as? Int
		inkeVerify = dictionary["inke_verify"] as? Int
		level = dictionary["level"] as? Int
		location = dictionary["location"] as? String
		nick = dictionary["nick"] as? String
		portrait = dictionary["portrait"] as? String
		profession = dictionary["profession"] as? String
		rankVeri = dictionary["rank_veri"] as? Int
		thirdPlatform = dictionary["third_platform"] as? String
		veriInfo = dictionary["veri_info"] as? String
		verified = dictionary["verified"] as? Int
		verifiedReason = dictionary["verified_reason"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if birth != nil{
			dictionary["birth"] = birth
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if emotion != nil{
			dictionary["emotion"] = emotion
		}
		if gender != nil{
			dictionary["gender"] = gender
		}
		if gmutex != nil{
			dictionary["gmutex"] = gmutex
		}
		if hometown != nil{
			dictionary["hometown"] = hometown
		}
		if id != nil{
			dictionary["id"] = id
		}
		if inkeVerify != nil{
			dictionary["inke_verify"] = inkeVerify
		}
		if level != nil{
			dictionary["level"] = level
		}
		if location != nil{
			dictionary["location"] = location
		}
		if nick != nil{
			dictionary["nick"] = nick
		}
		if portrait != nil{
			dictionary["portrait"] = portrait
		}
		if profession != nil{
			dictionary["profession"] = profession
		}
		if rankVeri != nil{
			dictionary["rank_veri"] = rankVeri
		}
		if thirdPlatform != nil{
			dictionary["third_platform"] = thirdPlatform
		}
		if veriInfo != nil{
			dictionary["veri_info"] = veriInfo
		}
		if verified != nil{
			dictionary["verified"] = verified
		}
		if verifiedReason != nil{
			dictionary["verified_reason"] = verifiedReason
		}
		return dictionary
	}

}
