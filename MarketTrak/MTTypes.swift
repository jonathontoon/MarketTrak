//
//  MTTypes.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/2/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//
//

import UIKit

extension String
{
    func trim() -> String
    {
        return stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}

// http://stackoverflow.com/a/32418497
protocol EnumerableEnum: RawRepresentable {
    static func allValues() -> [Self]
}

extension EnumerableEnum where RawValue == Int {
    static func allValues() -> [Self] {
        var idx = 0
        return Array(anyGenerator { return Self(rawValue: idx++) })
    }
}

enum WeaponType: Int, EnumerableEnum {
    case AK47, AUG, AWP, Bayonet, ButterflyKnife, CZ75Auto, DesertEagle, DualBerettas, FalchionKnife, FAMAS, FiveSeveN, FlipKnife, G3SG1, GalilAR, Glock18, GutKnife, HuntsmanKnife, Karambit, M249, M4A1S, M4A4, M9Bayonet, MAC10, MAG7, MP7, MP9, Negev, Nova, P2000, P250, P90, PPBizon, R8Revolver, SawedOff, SCAR20, SG553, ShadowDaggers, SSG08, Tec9, UMP45, USPS, XM1014, None
    
    func stringDescription() -> String {
        switch self {
        case .AK47:
            return "AK-47"
        case .AUG:
            return "AUG"
        case .AWP:
            return "AWP"
        case .Bayonet:
            return "Bayonet"
        case .ButterflyKnife:
            return "Butterfly Knife"
        case .CZ75Auto:
            return "CZ75-Auto"
        case .DesertEagle:
            return "Desert Eagle"
        case .DualBerettas:
            return "Dual Berettas"
        case .FalchionKnife:
            return "Falchion Knife"
        case .FAMAS:
            return "FAMAS"
        case .FiveSeveN:
            return "Five-SeveN"
        case .FlipKnife:
            return "Flip Knife"
        case .G3SG1:
            return "G3SG1"
        case .GalilAR:
            return "Galil AR"
        case .Glock18:
            return "Glock-18"
        case .GutKnife:
            return "Gut Knife"
        case .HuntsmanKnife:
            return "Huntsman Knife"
        case .Karambit:
            return "Karambit"
        case .M249:
            return "M249"
        case .M4A1S:
            return "M4A1-S"
        case .M4A4:
            return "M4A4"
        case .M9Bayonet:
            return "M9 Bayonet"
        case .MAC10:
            return "MAC-10"
        case .MAG7:
            return "MAG-7"
        case .MP7:
            return "MP7"
        case .MP9:
            return "MP9"
        case .Negev:
            return "Negev"
        case .Nova:
            return "Nova"
        case .P2000:
            return "P2000"
        case .P250:
            return "P250"
        case .P90:
            return "P90"
        case .PPBizon:
            return "PP-Bizon"
        case .R8Revolver:
            return "R8 Revolver"
        case .SawedOff:
            return "Sawed-Off"
        case .SCAR20:
            return "SCAR-20"
        case .SG553:
            return "SG 553"
        case .ShadowDaggers:
            return "Shadow Daggers"
        case .SSG08:
            return "SSG 08"
        case .Tec9:
            return "Tec-9"
        case .UMP45:
            return "UMP-45"
        case .USPS:
            return "USP-S"
        case .XM1014:
            return "XM1014"
        case .None:
            return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
        case .AK47:
            return "&category_730_Weapon%5B%5D=tag_weapon_ak47"
        case .AUG:
            return "&category_730_Weapon%5B%5D=tag_weapon_aug"
        case .AWP:
            return "&category_730_Weapon%5B%5D=tag_weapon_awp"
        case .Bayonet:
            return "&category_730_Weapon%5B%5D=tag_weapon_bayonet"
        case .ButterflyKnife:
            return "&category_730_Weapon%5B%5D=tag_weapon_knife_butterfly"
        case .CZ75Auto:
            return "&category_730_Weapon%5B%5D=tag_weapon_cz75a"
        case .DesertEagle:
            return "&category_730_Weapon%5B%5D=tag_weapon_deagle"
        case .DualBerettas:
            return "&category_730_Weapon%5B%5D=tag_weapon_elite"
        case .FalchionKnife:
            return "&category_730_Weapon%5B%5D=tag_weapon_knife_falchion"
        case .FAMAS:
            return "&category_730_Weapon%5B%5D=tag_weapon_famas"
        case .FiveSeveN:
            return "&category_730_Weapon%5B%5D=tag_weapon_fiveseven"
        case .FlipKnife:
            return "&category_730_Weapon%5B%5D=tag_weapon_knife_flip"
        case .G3SG1:
            return "&category_730_Weapon%5B%5D=tag_weapon_g3sg1"
        case .GalilAR:
            return "&category_730_Weapon%5B%5D=tag_weapon_galilar"
        case .Glock18:
            return "&category_730_Weapon%5B%5D=tag_weapon_glock"
        case .GutKnife:
            return "&category_730_Weapon%5B%5D=tag_weapon_knife_gut"
        case .HuntsmanKnife:
            return "&category_730_Weapon%5B%5D=tag_weapon_knife_gut"
        case .Karambit:
            return "&category_730_Weapon%5B%5D=tag_weapon_knife_karambit"
        case .M249:
            return "&category_730_Weapon%5B%5D=tag_weapon_m249"
        case .M4A1S:
            return "&category_730_Weapon%5B%5D=tag_weapon_m4a1_silencer"
        case .M4A4:
            return "&category_730_Weapon%5B%5D=tag_weapon_m4a1"
        case .M9Bayonet:
            return "&category_730_Weapon%5B%5D=tag_weapon_knife_m9_bayonet"
        case .MAC10:
            return "&category_730_Weapon%5B%5D=tag_weapon_mac10"
        case .MAG7:
            return "&category_730_Weapon%5B%5D=tag_weapon_mag7"
        case .MP7:
            return "&category_730_Weapon%5B%5D=tag_weapon_mp7"
        case .MP9:
            return "&category_730_Weapon%5B%5D=tag_weapon_mp9"
        case .Negev:
            return "&category_730_Weapon%5B%5D=tag_weapon_negev"
        case .Nova:
            return "&category_730_Weapon%5B%5D=tag_weapon_nova"
        case .P2000:
            return "&category_730_Weapon%5B%5D=tag_weapon_hkp2000"
        case .P250:
            return "&category_730_Weapon%5B%5D=tag_weapon_p250"
        case .P90:
            return "&category_730_Weapon%5B%5D=tag_weapon_p90"
        case .PPBizon:
            return "&category_730_Weapon%5B%5D=tag_weapon_bizon"
        case .R8Revolver:
            return "&category_730_Weapon%5B%5D=tag_weapon_revolver"
        case .SawedOff:
            return "&category_730_Weapon%5B%5D=tag_weapon_sawedoff"
        case .SCAR20:
            return "&category_730_Weapon%5B%5D=tag_weapon_scar20"
        case .SG553:
            return "&category_730_Weapon%5B%5D=tag_weapon_sg556"
        case .ShadowDaggers:
            return "&category_730_Weapon%5B%5D=tag_weapon_knife_push"
        case .SSG08:
            return "&category_730_Weapon%5B%5D=tag_weapon_ssg08"
        case .Tec9:
            return "&category_730_Weapon%5B%5D=tag_weapon_tec9"
        case .UMP45:
            return "&category_730_Weapon%5B%5D=tag_weapon_ump45"
        case .USPS:
            return "&category_730_Weapon%5B%5D=tag_weapon_usp_silencer"
        case .XM1014:
            return "&category_730_Weapon%5B%5D=tag_weapon_xm1014"
        case .None:
            return "&category_730_Weapon%5B%5D=any"
        }
    }
}

func determineWeapon(string: String) -> WeaponType {
    
    if string.containsString("AK-47") {
        
        return WeaponType.AK47
        
    } else if string.containsString("AUG") {
        
        return WeaponType.AUG
        
    } else if string.containsString("AWP") {
        
        return WeaponType.AWP
        
    } else if string.containsString("Bayonet") {
        
        return WeaponType.Bayonet
        
    } else if string.containsString("Butterfly Knife") {
        
        return WeaponType.ButterflyKnife
        
    } else if string.containsString("CZ75-Auto") {
    
        return WeaponType.CZ75Auto
        
    } else if string.containsString("Desert Eagle") {
        
        return WeaponType.DesertEagle
        
    } else if string.containsString("Dual Berettas") {
        
        return WeaponType.DualBerettas
        
    } else if string.containsString("Falchion Knife") {
        
        return WeaponType.FalchionKnife
        
    } else if string.containsString("FAMAS") {
        
        return WeaponType.FAMAS
        
    } else if string.containsString("Five-SeveN") {
        
        return WeaponType.FiveSeveN
        
    } else if string.containsString("Flip Knife") {
        
        return WeaponType.FlipKnife
        
    } else if string.containsString("G3SG1") {
        
        return WeaponType.G3SG1
        
    } else if string.containsString("Galil AR") {
        
        return WeaponType.GalilAR
        
    } else if string.containsString("Glock-18") {
        
        return WeaponType.Glock18
        
    } else if string.containsString("Gut Knife") {
        
        return WeaponType.GutKnife
        
    } else if string.containsString("Huntsman Knife"){
        
        return WeaponType.HuntsmanKnife
        
    } else if string.containsString("Karambit") {
        
        return WeaponType.Karambit
        
    } else if string.containsString("M249") {
        
        return WeaponType.M249
        
    } else if string.containsString("M4A1-S") {
     
        return WeaponType.M4A1S
        
    } else if string.containsString("M4A4"){
        
        return WeaponType.M4A4
        
    } else if string.containsString("M9 Bayonet") {
        
        return WeaponType.M9Bayonet
        
    } else if string.containsString("MAC-10") {
        
        return WeaponType.MAC10
        
    } else if string.containsString("MAG-7") {
     
        return WeaponType.MAG7
        
    } else if string.containsString("MP7") {
        
        return WeaponType.MP7
        
    } else if string.containsString("MP9") {
        
        return WeaponType.MP9
        
    } else if string.containsString("Negev") {
        
        return WeaponType.Negev
        
    } else if string.containsString("Nova") {
        
        return WeaponType.Nova
        
    } else if string.containsString("P2000"){
        
        return WeaponType.P2000
        
    } else if string.containsString("P250") {
        
        return WeaponType.P250
        
    } else if string.containsString("P90") {
        
        return WeaponType.P90
        
    } else if string.containsString("PP-Bizon") {
        
        return WeaponType.PPBizon
        
    } else if string.containsString("R8 Revolver") {
    
        return WeaponType.R8Revolver
        
    } else if string.containsString("Sawed-Off") {
        
        return WeaponType.SawedOff
        
    } else if string.containsString("SCAR-20") {
        
        return WeaponType.SCAR20
        
    } else if string.containsString("SG 553") {
        
        return WeaponType.SG553
        
    } else if string.containsString("Shadow Daggers") {
        
        return WeaponType.ShadowDaggers
        
    } else if string.containsString("SSG 08") {
        
        return WeaponType.SSG08
        
    } else if string.containsString("Tec-9") {
        
        return WeaponType.Tec9
        
    } else if string.containsString("UMP-45") {
        
        return WeaponType.UMP45
        
    } else if string.containsString("USP-S") {
        
        return WeaponType.USPS
        
    } else if string.containsString("XM1014") {
     
        return WeaponType.XM1014
        
    } else {
        
        return WeaponType.None
        
    }
}

enum Exterior: Int, EnumerableEnum {
    
    case FieldTested, MinimalWear, BattleScarred, WellWorn, FactoryNew, NotPainted, None
    
    func stringDescription() -> String {
        switch self {
        case .BattleScarred:
            return "Battle Scarred"
        case .FactoryNew:
            return "Factory New"
        case .FieldTested:
            return "Field-Tested"
        case .MinimalWear:
            return "Minimal Wear"
        case .WellWorn:
            return "Well-Worn"
        case .NotPainted:
            return "Not Painted"
        case .None:
            return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
        case .BattleScarred:
            return "&category_730_Exterior%5B%5D=tag_Wear&category4"
        case .FactoryNew:
            return "&category_730_Exterior%5B%5D=tag_Wear&category0"
        case .FieldTested:
            return "&category_730_Exterior%5B%5D=tag_Wear&category2"
        case .MinimalWear:
            return "&category_730_Exterior%5B%5D=tag_Wear&category1"
        case .NotPainted:
            return "&category_730_Exterior%5B%5D=tag_Wear&categoryNA"
        case .WellWorn:
            return "&category_730_Exterior%5B%5D=tag_Wear&category3"
        case .None:
            return "&category_730_Exterior%5B%5D=any"
        }
    }
}

func determineExterior(string: String) -> Exterior {
    
    if string.containsString("Battle-Scarred") {
        
        return Exterior.BattleScarred
        
    } else if string.containsString("Factory New") {
        
        return Exterior.FactoryNew
        
    } else if string.containsString("Field-Tested") {
        
        return Exterior.FieldTested
        
    } else if string.containsString("Minimal Wear") {
        
        return Exterior.MinimalWear
        
    } else if string.containsString("Well-Worn") {
        
        return Exterior.WellWorn
        
    } else {
        return Exterior.NotPainted
    }
}

enum Category: Int, EnumerableEnum {
    
    case Normal, StatTrak™, Souvenir, Star, StarStatTrak™, None
    
    func stringDescription() -> String {
        switch self {
        case .Normal:
            return "Normal"
        case .StatTrak™:
            return "StatTrak™"
        case .Souvenir:
            return "Souvenir"
        case .Star:
            return "★"
        case .StarStatTrak™:
            return "★ StatTrak™"
        case .None:
            return ""
        }
    }
    
    func colorForCategory() -> UIColor {
        switch self {
        case .Normal:
            return UIColor.whiteColor()
        case .StatTrak™:
            return UIColor.statTrak™ItemColor()
        case .Souvenir:
            return UIColor.souvenirItemColor()
        case .Star:
            return UIColor.starItemColor()
        case .StarStatTrak™:
            return UIColor.starStatTrak™ItemColor()
        default:
            return UIColor.whiteColor()
        }
    }
    
    func urlArgument() -> String {
        switch self {
        case .Normal:
            return "&category_730_Quality%5B%5D=tag_normal"
        case .StatTrak™:
            return "&category_730_Quality%5B%5D=tag_strange"
        case .Souvenir:
            return "&category_730_Quality%5B%5D=tag_tournament"
        case .Star:
            return "&category_730_Quality%5B%5D=tag_unusual"
        case .StarStatTrak™:
            return "&category_730_Quality%5B%5D=tag_unusual_strange"
        default:
            return "&category_730_Quality%5B%5D=any"
        }
    }
}

func determineCategory(name: String) -> Category {

    if name.containsString("StatTrak™") && !name.containsString("★") {
        
        return Category.StatTrak™
        
    } else if name.containsString("Souvenir") && !name.containsString("Souvenir Package") {
        
        return Category.Souvenir
        
    } else if name.containsString("★") {
        
        if name.containsString("★ StatTrak™") {
            
            return Category.StarStatTrak™
        } else {
            return Category.Star
        }
        
    } else {
        return Category.Normal
    }
}

enum Quality: Int, EnumerableEnum {
    
    case ConsumerGrade, MilSpecGrade, IndustrialGrade, Restricted, Classified, Covert, BaseGrade, HighGrade, Exotic, Remarkable, Contraband, None
    
    func stringDescription() -> String {
        switch self {
        case .BaseGrade:
            return "Base Grade"
        case .Classified:
            return "Classified"
        case .ConsumerGrade:
            return "Consumer Grade"
        case .Contraband:
            return "Contraband"
        case .Covert:
            return "Covert"
        case .Exotic:
            return "Exotic"
        case .HighGrade:
            return "High Grade"
        case .IndustrialGrade:
            return "Industrial Grade"
        case .MilSpecGrade:
            return "Mil-Spec Grade"
        case .Remarkable:
            return "Remarkable"
        case .Restricted:
            return "Restricted"
        case .None:
            return ""
        }
    }
    
    func colorForQuality() -> UIColor {
        switch self {
        case .BaseGrade:
            return UIColor.baseGradeItemColor()
        case .Classified:
            return UIColor.consumerGradeItemColor()
        case .ConsumerGrade:
            return UIColor.consumerGradeItemColor()
        case .Contraband:
            return UIColor.contrabandItemColor()
        case .Covert:
            return UIColor.covertItemColor()
        case .Exotic:
            return UIColor.exoticItemColor()
        case .HighGrade:
            return UIColor.highGradeItemColor()
        case .IndustrialGrade:
            return UIColor.industrialGradeItemColor()
        case .MilSpecGrade:
            return UIColor.milSpecGradeItemColor()
        case .Remarkable:
            return UIColor.remarkableItemColor()
        case .Restricted:
            return UIColor.restrictedItemColor()
        case .None:
            return UIColor.whiteColor()
        }
    }
    
    func urlArgument() -> String {
        switch self {
        case .BaseGrade:
            return "&category_730_Rarity%5B%5D=tag_Rarity_Common"
        case .Classified:
            return "&category_730_Rarity%5B%5D=tag_Rarity_Legendary"
        case .ConsumerGrade:
            return "&category_730_Rarity%5B%5D=tag_Rarity_Common_Weapon"
        case .Contraband:
            return "&category_730_Rarity%5B%5D=tag_Rarity_Contraband"
        case .Covert:
            return "&category_730_Rarity%5B%5D=tag_Rarity_Ancient_Weapon"
        case .Exotic:
            return "&category_730_Rarity%5B%5D=tag_Rarity_Legendary"
        case .HighGrade:
            return "&category_730_Rarity%5B%5D=tag_Rarity_Rare"
        case .IndustrialGrade:
            return "&category_730_Rarity%5B%5D=tag_Rarity_Uncommon_Weapon"
        case .MilSpecGrade:
            return "&category_730_Rarity%5B%5D=tag_Rarity_Rare_Weapon"
        case .Remarkable:
            return "&category_730_Rarity%5B%5D=tag_Rarity_Mythical"
        case .Restricted:
            return "&category_730_Rarity%5B%5D=tag_Rarity_Mythical_Weapon"
        case .None:
            return "&category_730_Rarity%5B%5D=any"
        }
    }
}

func determineQuality(string: String!) -> Quality {
    
    if string.containsString("Base Grade") {
        return Quality.BaseGrade
    } else if string.containsString("Classified") {
        return Quality.Classified
    } else if string.containsString("Consumer Grade") {
        return Quality.ConsumerGrade
    } else if string.containsString("Contraband") {
        return Quality.Contraband
    } else if string.containsString("Covert") {
        return Quality.Covert
    } else if string.containsString("Exotic") {
        return Quality.Exotic
    } else if string.containsString("High Grade") {
        return Quality.HighGrade
    } else if string.containsString("Industrial Grade") {
        return Quality.IndustrialGrade
    } else if string.containsString("Mil-Spec Grade") {
        return Quality.MilSpecGrade
    } else if string.containsString("Remarkable") {
        return Quality.Remarkable
    } else if string.containsString("Restricted") {
        return Quality.Restricted
    } else {
        
        print("######", string)
        
        return Quality.None
    }
    
}

enum Type: Int, EnumerableEnum {
    case Pistol, SMG, Rifle, Shotgun, SniperRifle, Machinegun, Container, Knife, Sticker, MusicKit, Key, Pass, Gift, Tag, Tool, None
    
    func stringDescription() -> String {
        switch self {
        case .Container:
            return "Container"
        case .Gift:
            return "Gift"
        case .Key:
            return "Key"
        case .Knife:
            return "Knife"
        case .Machinegun:
            return "Machinegun"
        case .MusicKit:
            return "Music Kit"
        case .Pass:
            return "Pass"
        case .Pistol:
            return "Pistol"
        case .Rifle:
            return "Rifle"
        case .Shotgun:
            return "Shotgun"
        case .SMG:
            return "SMG"
        case .SniperRifle:
            return "Sniper Rifle"
        case .Sticker:
            return "Sticker"
        case .Tag:
            return "Tag"
        case .Tool:
            return "Tool"
        case .None:
            return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
        case .Container:
            return "&category_730_Type%5B%5D=tag_CSGO_Type_WeaponCase"
        case .Gift:
            return "&category_730_Type%5B%5D=tag_CSGO_Tool_GiftTag"
        case .Key:
            return "&category_730_Type%5B%5D=tag_CSGO_Tool_WeaponCase_KeyTag"
        case .Knife:
            return "&category_730_Type%5B%5D=tag_CSGO_Type_Knife"
        case .Machinegun:
            return "&category_730_Type%5B%5D=tag_CSGO_Type_Machinegun"
        case .MusicKit:
            return "&category_730_Type%5B%5D=tag_CSGO_Type_MusicKit"
        case .Pass:
            return "&category_730_Type%5B%5D=tag_CSGO_Type_Ticket"
        case .Pistol:
            return "&category_730_Type%5B%5D=tag_CSGO_Type_Pistol"
        case .Rifle:
            return "&category_730_Type%5B%5D=tag_CSGO_Type_Rifle"
        case .Shotgun:
            return "&category_730_Type%5B%5D=tag_CSGO_Type_Shotgun"
        case .SMG:
            return "&category_730_Type%5B%5D=tag_CSGO_Type_SMG"
        case .SniperRifle:
            return "&category_730_Type%5B%5D=tag_CSGO_Type_SniperRifle"
        case .Sticker:
            return "&category_730_Type%5B%5D=tag_CSGO_Tool_Sticker"
        case .Tag:
            return "&category_730_Type%5B%5D=tag_CSGO_Tool_Name_TagTag"
        case .Tool:
            return "&category_730_Type%5B%5D=tag_CSGO_Type_Tool"
        case .None:
            return "&category_730_Type%5B%5D=any"
        }
    }
}

func determineType(string: String) -> Type {
    
    if string.containsString("Sticker | ") || string == "Sticker" {
        
        return Type.Sticker
        
    } else if string.containsString("Key") || string.containsString("Case Key") || string == "Key" {
        
        return Type.Key
        
    } else if string.containsString("Pass") || string == "Pass" {
        
        return Type.Pass
        
    } else if string.containsString("Music Kit") {
        
        return Type.MusicKit
        
    } else if string.containsString("Gift") || string.containsString("Parcel") || string.containsString("Presents") {
        
        return Type.Gift
        
    } else if string == "Name Tag" || string.containsString("Tag") {
        
        return Type.Tag
        
    } else if string.containsString("Swap Tool") {
        
        return Type.Tool
        
    } else if string.containsString("Negev") || string.containsString("M249") || string == "Machinegun" {
        
        return Type.Machinegun
        
    } else if string.containsString("CZ75-Auto") || string.containsString("Desert Eagle") || string.containsString("Dual Berettas") || string.containsString("Five-SeveN") || string.containsString("Glock-18") || string.containsString("P2000") || string.containsString("P250") || string.containsString("Tec-9") || string.containsString("USP-S") || string.containsString("USP-S") || string.containsString("R8 Revolver") || string == "Pistol" {
        
        return Type.Pistol
        
    } else if string.containsString("AK-47") || string.containsString("AUG") || string.containsString("FAMAS") || string.containsString("Galil AR") || string.containsString("M4A1-S") || string.containsString("M4A4") || string.containsString("SG 553") || string == "Rifle" {
        
        return Type.Rifle
        
    } else if string.containsString("MAC-10") || string.containsString("MP7") || string.containsString("MP9") || string.containsString("PP-Bizon") || string.containsString("P90") || string.containsString("UMP-45") || string == "SMG" {
        
        return Type.SMG
        
    } else if string.containsString("MAG-7") || string.containsString("Nova") || string.containsString("Sawed-Off") || string.containsString("XM1014") || string == "Shotgun" {
        
        return Type.Shotgun
        
    } else if string.containsString("AWP") || string.containsString("SSG 08") || string.containsString("G3SG1") || string.containsString("SCAR-20") || string == "Sniper Rifle" {
        
        return Type.SniperRifle
        
    } else if string.containsString("Bayonet") || string.containsString("Butterfly Knife") || string.containsString("Falchion Knife") || string.containsString("Flip Knife") || string.containsString("Gut Knife") || string.containsString("Huntsman Knife") || string.containsString("Karambit") || string.containsString("M9 Bayonet") || string.containsString("Shadow Daggers") || string == "Knife" {
        
        return Type.Knife
        
    } else if string.containsString("Container") || string.containsString("Case") || string.containsString("Capsule") || string.containsString("Legends") || string.containsString("Challengers") || string.containsString("Souvenir Package") || string == "Container" {
        
        return Type.Container
        
    } else {
        
        return Type.None
        
    }

}

func determineItemName(name: String!) -> String {
    
    var itemName = name

    if itemName.containsString("Battle-Scarred") {
        itemName = itemName.stringByReplacingOccurrencesOfString(" (Battle-Scarred)", withString: "")
    } else if itemName.containsString("Factory New") {
        itemName = itemName.stringByReplacingOccurrencesOfString(" (Factory New)", withString: "")
    } else if itemName.containsString("Field-Tested") {
        itemName = itemName.stringByReplacingOccurrencesOfString(" (Field-Tested)", withString: "")
    } else if itemName.containsString("Minimal Wear") {
        itemName = itemName.stringByReplacingOccurrencesOfString(" (Minimal Wear)", withString: "")
    } else if itemName.containsString("Well-Worn") {
        itemName = itemName.stringByReplacingOccurrencesOfString(" (Well-Worn)", withString: "")
    }
    
    if itemName.containsString("StatTrak™") {
        itemName = itemName.stringByReplacingOccurrencesOfString("StatTrak™ ", withString: "")
    } else if itemName.containsString("Souvenir") && !itemName.containsString("Souvenir Package") {
        itemName = itemName.stringByReplacingOccurrencesOfString("Souvenir ", withString: "")
    } else if itemName.containsString("★") {
        itemName = "★"
    } else if itemName.containsString("★ StatTrak™") {
        itemName = itemName.stringByReplacingOccurrencesOfString("★ StatTrak™ ", withString: "")
    }

    if itemName.containsString("Music Kit |") {
        
        itemName = itemName.stringByReplacingOccurrencesOfString("Music Kit |", withString: "")
        itemName = itemName.componentsSeparatedByString(", ")[1]
        
    } else if itemName.containsString(" | ") && !itemName.containsString("Autograph Capsule") {
        
        itemName = itemName.componentsSeparatedByString(" | ")[1]
    
    }
    
    itemName = itemName.trim()
    
    return itemName
}
