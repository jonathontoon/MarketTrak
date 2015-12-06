//
//  MTTypes.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/2/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//
//

import UIKit

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

enum Collection: Int, EnumerableEnum {
    
    case TheAlphaCollection, TheArmsDeal2Collection, TheArmsDeal3Collection, TheArmsDealCollection, TheAssaultCollection, TheAztecCollection, TheBaggageCollection, TheBankCollection, TheBravoCollection, TheBreakoutCollection, TheCacheCollection, TheChopShopCollection, TheChroma2Collection, TheChromaCollection, TheCobblestoneCollection, TheDust2Collection, TheDustCollection, TheeSports2013Collection, TheeSports2013WinterCollection, TheeSports2014SummerCollection, TheFalchionCollection, TheGodsandMonstersCollection, TheHuntsmanCollection, TheInfernoCollection, TheItalyCollection, TheLakeCollection, TheMilitiaCollection, TheMirageCollection, TheNukeCollection, TheOfficeCollection, TheOverpassCollection, ThePhoenixCollection, TheRisingSunCollection, TheSafehouseCollection, TheShadowCollection, TheTrainCollection, TheVanguardCollection, TheVertigoCollection, TheWinterOffensiveCollection, Any
    
    func stringDescription() -> String {
        switch self {
        case .TheAlphaCollection:
            return "The Alpha Collection"
        case .TheArmsDeal2Collection:
            return "The Arms Deal 2 Collection"
        case .TheArmsDeal3Collection:
            return "The Arms Deal 3 Collection"
        case .TheArmsDealCollection:
            return "The Arms Deal Collection"
        case .TheAssaultCollection:
            return "The Assault Collection"
        case .TheAztecCollection:
            return "The Aztec Collection"
        case .TheBaggageCollection:
            return "The Baggage Collection"
        case .TheBankCollection:
            return "The Bank Collection"
        case .TheBravoCollection:
            return "The Bravo Collection"
        case .TheBreakoutCollection:
            return "The Breakout Collection"
        case .TheCacheCollection:
            return "The Cache Collection"
        case .TheChopShopCollection:
            return "The Chop Shop Collection"
        case .TheChroma2Collection:
            return "The Chroma 2 Collection"
        case .TheChromaCollection:
            return "The Chroma Collection"
        case .TheCobblestoneCollection:
            return "The Cobblestone Collection"
        case .TheDust2Collection:
            return "The Dust 2 Collection"
        case .TheDustCollection:
            return "The Dust Collection"
        case .TheeSports2013Collection:
            return "The eSports 2013 Collection"
        case .TheeSports2013WinterCollection:
            return "The eSports 2013 Winter Collection"
        case .TheeSports2014SummerCollection:
            return "The eSports 2014 Summer Collection"
        case .TheFalchionCollection:
            return "The Falchion Collection"
        case .TheGodsandMonstersCollection:
            return "The Gods and Monsters Collection"
        case .TheHuntsmanCollection:
            return "The Huntsman Collection"
        case .TheInfernoCollection:
            return "The Inferno Collection"
        case .TheItalyCollection:
            return "The Italy Collection"
        case .TheLakeCollection:
            return "The Lake Collection"
        case .TheMilitiaCollection:
            return "The Militia Collection"
        case .TheMirageCollection:
            return "The Mirage Collection"
        case .TheNukeCollection:
            return "The Nuke Collection"
        case .TheOfficeCollection:
            return "The Office Collection"
        case .TheOverpassCollection:
            return "The Overpass Collection"
        case .ThePhoenixCollection:
            return "The Phoenix Collection"
        case .TheRisingSunCollection:
            return "The Rising Sun Collection"
        case .TheSafehouseCollection:
            return "The Safehouse Collection"
        case .TheShadowCollection:
            return "The Shadow Collection"
        case .TheTrainCollection:
            return "The Train Collection"
        case .TheVanguardCollection:
            return "The Vanguard Collection"
        case .TheVertigoCollection:
            return "The Vertigo Collection"
        case .TheWinterOffensiveCollection:
            return "The Winter Offensive Collection"
        case .Any:
            return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
        case .TheAlphaCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_bravo_ii"
        case .TheArmsDeal2Collection:
            return "&category_730_ItemSet%5B%5D=tag_set_weapons_ii"
        case .TheArmsDeal3Collection:
            return "&category_730_ItemSet%5B%5D=tag_set_weapons_iii"
        case .TheArmsDealCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_weapons_i"
        case .TheAssaultCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_assault"
        case .TheAztecCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_aztec"
        case .TheBaggageCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_baggage"
        case .TheBankCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_bank"
        case .TheBravoCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_bravo_i"
        case .TheBreakoutCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_community_4"
        case .TheCacheCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_cache"
        case .TheChopShopCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_chopshop"
        case .TheChroma2Collection:
            return "&category_730_ItemSet%5B%5D=tag_set_community_7"
        case .TheChromaCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_community_6"
        case .TheCobblestoneCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_cobblestone"
        case .TheDust2Collection:
            return "&category_730_ItemSet%5B%5D=tag_set_dust_2"
        case .TheDustCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_dust"
        case .TheeSports2013Collection:
            return "&category_730_ItemSet%5B%5D=tag_set_esports"
        case .TheeSports2013WinterCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_esports_ii"
        case .TheeSports2014SummerCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_esports_iii"
        case .TheFalchionCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_community_8"
        case .TheGodsandMonstersCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_gods_and_monsters"
        case .TheHuntsmanCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_community_3"
        case .TheInfernoCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_inferno"
        case .TheItalyCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_italy"
        case .TheLakeCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_lake"
        case .TheMilitiaCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_militia"
        case .TheMirageCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_mirage"
        case .TheNukeCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_nuke"
        case .TheOfficeCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_office"
        case .TheOverpassCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_overpass"
        case .ThePhoenixCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_community_2"
        case .TheRisingSunCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_kimono"
        case .TheSafehouseCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_safehouse"
        case .TheShadowCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_community_9"
        case .TheTrainCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_train"
        case .TheVanguardCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_community_5"
        case .TheVertigoCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_vertigo"
        case .TheWinterOffensiveCollection:
            return "&category_730_ItemSet%5B%5D=tag_set_community_1"
        case .Any:
            return "&category_730_ItemSet%5B%5D=any"
        }
    }
}

func determineCollection(string: String) -> Collection {
    
    switch string {
        
        case "The Alpha Collection":
            return .TheAlphaCollection
        case "The Arms Deal 2 Collection":
            return .TheArmsDeal2Collection
        case "The Arms Deal 3 Collection":
            return .TheArmsDeal3Collection
        case "The Arms Deal Collection":
            return .TheArmsDealCollection
        case "The Assault Collection":
            return .TheAssaultCollection
        case "The Aztec Collection":
            return .TheAztecCollection
        case "The Baggage Collection":
            return .TheBaggageCollection
        case "The Bank Collection":
            return .TheBankCollection
        case "The Bravo Collection":
            return .TheBravoCollection
        case "The Breakout Collection":
            return .TheBreakoutCollection
        case "The Cache Collection":
            return .TheCacheCollection
        case "The Chop Shop Collection":
            return .TheChopShopCollection
        case "The Chroma 2 Collection":
            return .TheChroma2Collection
        case "The Chroma Collection":
            return .TheChromaCollection
        case "The Cobblestone Collection":
            return .TheCobblestoneCollection
        case "The Dust 2 Collection":
            return .TheDust2Collection
        case "The Dust Collection":
            return .TheDustCollection
        case "The eSports 2013 Collection":
            return .TheeSports2013Collection
        case "The eSports 2013 Winter Collection":
            return .TheeSports2013WinterCollection
        case "The eSports 2014 Summer Collection":
            return .TheeSports2014SummerCollection
        case "The Falchion Collection":
            return .TheFalchionCollection
        case "The Gods and Monsters Collection":
            return .TheGodsandMonstersCollection
        case "The Huntsman Collection":
            return .TheHuntsmanCollection
        case "The Inferno Collection":
            return .TheInfernoCollection
        case "The Italy Collection":
            return .TheItalyCollection
        case "The Lake Collection":
            return .TheLakeCollection
        case "The Militia Collection":
            return .TheMilitiaCollection
        case "The Mirage Collection":
            return .TheMirageCollection
        case "The Nuke Collection":
            return .TheNukeCollection
        case "The Office Collection":
            return .TheOfficeCollection
        case "The Overpass Collection":
            return .TheOverpassCollection
        case "The Phoenix Collection":
            return .ThePhoenixCollection
        case "The Rising Sun Collection":
            return .TheRisingSunCollection
        case "The Safehouse Collection":
            return .TheSafehouseCollection
        case "The Shadow Collection":
            return .TheShadowCollection
        case "The Train Collection":
            return .TheTrainCollection
        case "The Vanguard Collection":
            return .TheVanguardCollection
        case "The Vertigo Collection":
            return .TheVertigoCollection
        case "The Winter Offensive Collection":
            return .TheWinterOffensiveCollection
        default:
            return .Any
    }
}

enum ProfessionalPlayer: Int, EnumerableEnum {
    
    case AdreN, Aizy, Allu, ApEX, AZR, B1ad3, Boltz, Bondik, Byali, Cajunb, ChrisJ, Coldzera, DavCost, Denis, Dennis, Device, Dupreeh, Edward, EliGE, Emagine, Ex6TenZ, F0rest, FalleN, Fer, Flamie, Flusha, FNS, Fox, Freakazoid, Friberg, Fugly, Furlan, GeTRiGhT, GobB, GruBy, GuardiaN, Happy, Havoc, Hazed, Hiko, Hyper, James, Jdm64, Jkaem, Jks, JW, Karrigan, KennyS, KioShiMa, Kjaerbye, KRIMZ, Maikelele, Maniac, Markeloff, MSL, N0thing, NBK, NEO, Nex, NiKo, Nitr0, Olofmeister, PashaBiceps, Peet, Pimp, Pronax, Rain, Rallen, ReltuC, Rickeh, RpK, ScreaM, Seangares, Seized, Shox, Shroud, Skadoodle, SmithZz, Snax, SnypeR, Spiidi, SPUNJ, Steel, Tarik, TaZ, Tenzki, USTILO, WorldEdit, Xizt, Xyp9x, Yam, Zeus, Any
    
    func stringDescription() -> String {
        switch self {
        case .AdreN:
            return "adreN (Eric Hoag)"
        case .Aizy:
            return "aizy (Philip Aistrup Larsen)"
        case .Allu:
            return "allu (Aleksi Jalli)"
        case .ApEX:
            return "apEX (Dan Madesclaire)"
        case .AZR:
            return "AZR (Aaron Ward)"
        case .B1ad3:
            return "B1ad3 (Andrey Gorodenskiy)"
        case .Boltz:
            return "boltz (Ricardo Prass)"
        case .Bondik:
            return "bondik (Vladyslav Nechyporchuk)"
        case .Byali:
            return "byali (Pawel Bielinsky)"
        case .Cajunb:
            return "cajunb (Rene Borg)"
        case .ChrisJ:
            return "chrisJ (Chris de Jong)"
        case .Coldzera:
            return "coldzera (Marcelo David)"
        case .DavCost:
            return "DavCost (Vadim Vasilyev)"
        case .Denis:
            return "denis (Denis Howell)"
        case .Dennis:
            return "dennis (Dennis Edman)"
        case .Device:
            return "device (Nicolai Reedtz)"
        case .Dupreeh:
            return "dupreeh (Peter Rasmussen)"
        case .Edward:
            return "Edward (Ioann Sukhariev)"
        case .EliGE:
            return "EliGE (Jonathan Jablonowski)"
        case .Emagine:
            return "emagine (Chris Rowlands)"
        case .Ex6TenZ:
            return "Ex6TenZ (Kévin Droolans)"
        case .F0rest:
            return "f0rest (Patrik Lindberg)"
        case .FalleN:
            return "FalleN (Gabriel Toledo)"
        case .Fer:
            return "fer (Fernando Alvarenga)"
        case .Flamie:
            return "flamie (Egor Vasilyev)"
        case .Flusha:
            return "flusha (Robin Rönnquist)"
        case .FNS:
            return "FNS (Pujan Mehta)"
        case .Fox:
            return "fox (Ricardo Pacheco)"
        case .Freakazoid:
            return "freakazoid (Ryan Abadir)"
        case .Friberg:
            return "friberg (Adam Friberg)"
        case .Fugly:
            return "FugLy (Jacob Medina)"
        case .Furlan:
            return "Furlan (Damian Kislowski)"
        case .GeTRiGhT:
            return "GeT_RiGhT (Christopher Alesund)"
        case .GobB:
            return "gob b (Fatih Dayik)"
        case .GruBy:
            return "GruBy (Dominik Swiderski)"
        case .GuardiaN:
            return "GuardiaN (Ladislav Kovács)"
        case .Happy:
            return "Happy (Vincent Cervoni)"
        case .Havoc:
            return "Havoc (Luke Paton)"
        case .Hazed:
            return "hazed (James Cobb)"
        case .Hiko:
            return "Hiko (Spencer Martin)"
        case .Hyper:
            return "Hyper (Bartosz Wolny)"
        case .James:
            return "James (James Quinn)"
        case .Jdm64:
            return "jdm64 (Joshua Marzano)"
        case .Jkaem:
            return "jkaem (Joakim Myrbostad)"
        case .Jks:
            return "jks (Justin Savage)"
        case .JW:
            return "JW (Jesper Wecksell)"
        case .Karrigan:
            return "karrigan (Finn Andersen)"
        case .KennyS:
            return "kennyS (Kenny Schrub)"
        case .KioShiMa:
            return "kioShiMa (Fabien Fiey)"
        case .KRIMZ:
            return "KRIMZ (Lars Freddy Johansson)"
        case .Maikelele:
            return "Maikelele (Mikail Bill)"
        case .Maniac:
            return "Maniac (Mathieu Quiquerez)"
        case .Markeloff:
            return "markeloff (Yegor Markelov)"
        case .N0thing:
            return "n0thing (Jordan Gilbert)"
        case .NBK:
            return "NBK- (Nathan Schmitt)"
        case .NEO:
            return "NEO (Filip Kubski)"
        case .Nex:
            return "nex (Johannes Maget)"
        case .NiKo:
            return "NiKo (Nikola Kovač)"
        case .Nitr0:
            return "nitr0 (Nicholas Cannella)"
        case .Olofmeister:
            return "olofmeister (Olof Kajbjer)"
        case .PashaBiceps:
            return "pashaBiceps (Jarosław Jarząbkowski)"
        case .Peet:
            return "peet (Piotr Ćwikliński)"
        case .Pimp:
            return "Pimp (Jacob Winneche)"
        case .Pronax:
            return "pronax (Markus Wallsten)"
        case .Rain:
            return "rain (Håvard Nygaard)"
        case .Rallen:
            return "rallen (Karol Rodowicz)"
        case .ReltuC:
            return "reltuC (Steven Cutler)"
        case .Rickeh:
            return "Rickeh (Ricardo Mulholland)"
        case .RpK:
            return "RpK (Cédric Guipouy)"
        case .ScreaM:
            return "ScreaM (Adil Benrlitom)"
        case .Seangares:
            return "seang@res (Sean Gares)"
        case .Seized:
            return "seized (Denis Kostin)"
        case .Shox:
            return "shox (Richard Papillon)"
        case .Shroud:
            return "shroud (Michael Grzesiek)"
        case .Skadoodle:
            return "Skadoodle (Tyler Latham)"
        case .SmithZz:
            return "SmithZz (Edouard Dubourdeaux)"
        case .Snax:
            return "Snax (Janusz Pogorzelski)"
        case .SnypeR:
            return "SnypeR (Iain Turner)"
        case .Spiidi:
            return "Spiidi (Timo Richter)"
        case .SPUNJ:
            return "SPUNJ (Chad Burchill)"
        case .Steel:
            return "steel (Lucas Lopes)"
        case .Tarik:
            return "tarik (Tarik Celik)"
        case .TaZ:
            return "TaZ (Wiktor Wojtas)"
        case .Tenzki:
            return "tenzki (Jesper Mikalski)"
        case .USTILO:
            return "USTILO (Karlo Pivac)"
        case .WorldEdit:
            return "WorldEdit (Georgy Yaskin)"
        case .Xizt:
            return "Xizt (Richard Landström)"
        case .Xyp9x:
            return "Xyp9x (Andreas Højsleth)"
        case .Yam:
            return "yam (Yaman Ergenekon)"
        case .Zeus:
            return "Zeus (Danylo Teslenko)"
        default:
            return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
            case .AdreN:
                return "&category_730_ProPlayer%5B%5D=tag_adren"
            case .Aizy:
                return "&category_730_ProPlayer%5B%5D=tag_aizy"
            case .Allu:
                return "&category_730_ProPlayer%5B%5D=tag_allu"
            case .ApEX:
                return "&category_730_ProPlayer%5B%5D=tag_apex"
            case .AZR:
                return "&category_730_ProPlayer%5B%5D=tag_azr"
            case .B1ad3:
                return "&category_730_ProPlayer%5B%5D=tag_b1ad3"
            case .Boltz:
                return "&category_730_ProPlayer%5B%5D=tag_boltz"
            case .Bondik:
                return "&category_730_ProPlayer%5B%5D=tag_bondik"
            case .Byali:
                return "&category_730_ProPlayer%5B%5D=tag_byali"
            case .Cajunb:
                return "&category_730_ProPlayer%5B%5D=tag_cajunb"
            case .ChrisJ:
                return "&category_730_ProPlayer%5B%5D=tag_chrisj"
            case .Coldzera:
                return "&category_730_ProPlayer%5B%5D=tag_coldzera"
            case .DavCost:
                return "&category_730_ProPlayer%5B%5D=tag_davcost"
            case .Denis:
                return "&category_730_ProPlayer%5B%5D=tag_denis"
            case .Dennis:
                return "&category_730_ProPlayer%5B%5D=tag_dennis"
            case .Device:
                return "&category_730_ProPlayer%5B%5D=tag_device"
            case .Dupreeh:
                return "&category_730_ProPlayer%5B%5D=tag_dupreeh"
            case .Edward:
                return "&category_730_ProPlayer%5B%5D=tag_edward"
            case .EliGE:
                return "&category_730_ProPlayer%5B%5D=tag_elige"
            case .Emagine:
                return "&category_730_ProPlayer%5B%5D=tag_emagine"
            case .Ex6TenZ:
                return "&category_730_ProPlayer%5B%5D=tag_ex6tenz"
            case .F0rest:
                return "&category_730_ProPlayer%5B%5D=tag_forest"
            case .FalleN:
                return "&category_730_ProPlayer%5B%5D=tag_fallen"
            case .Fer:
                return "&category_730_ProPlayer%5B%5D=tag_fer"
            case .Flamie:
                return "&category_730_ProPlayer%5B%5D=tag_flamie"
            case .Flusha:
                return "&category_730_ProPlayer%5B%5D=tag_flusha"
            case .FNS:
                return "&category_730_ProPlayer%5B%5D=tag_fns"
            case .Fox:
                return "&category_730_ProPlayer%5B%5D=tag_fox"
            case .Freakazoid:
                return "&category_730_ProPlayer%5B%5D=tag_freakazoid"
            case .Friberg:
                return "&category_730_ProPlayer%5B%5D=tag_friberg"
            case .Fugly:
                return "&category_730_ProPlayer%5B%5D=tag_fugly"
            case .Furlan:
                return "&category_730_ProPlayer%5B%5D=tag_furlan"
            case .GeTRiGhT:
                return "&category_730_ProPlayer%5B%5D=tag_getright"
            case .GobB:
                return "&category_730_ProPlayer%5B%5D=tag_gobb"
            case .GruBy:
                return "&category_730_ProPlayer%5B%5D=tag_gruby"
            case .GuardiaN:
                return "&category_730_ProPlayer%5B%5D=tag_guardian"
            case .Happy:
                return "&category_730_ProPlayer%5B%5D=tag_happy"
            case .Havoc:
                return "&category_730_ProPlayer%5B%5D=tag_havoc"
            case .Hazed:
                return "&category_730_ProPlayer%5B%5D=tag_hazed"
            case .Hiko:
                return "&category_730_ProPlayer%5B%5D=tag_hiki"
            case .Hyper:
                return "&category_730_ProPlayer%5B%5D=tag_hyper"
            case .James:
                return "&category_730_ProPlayer%5B%5D=tag_james"
            case .Jdm64:
                return "&category_730_ProPlayer%5B%5D=tag_jdm64"
            case .Jkaem:
                return "&category_730_ProPlayer%5B%5D=tag_jkaem"
            case .Jks:
                return "&category_730_ProPlayer%5B%5D=tag_jks"
            case .JW:
                return "&category_730_ProPlayer%5B%5D=tag_jw"
            case .Karrigan:
                return "&category_730_ProPlayer%5B%5D=tag_karrigan"
            case .KennyS:
                return "&category_730_ProPlayer%5B%5D=tag_kennys"
            case .KioShiMa:
                return "&category_730_ProPlayer%5B%5D=tag_kioshima"
            case .KRIMZ:
                return "&category_730_ProPlayer%5B%5D=tag_krimz"
            case .Maikelele:
                return "&category_730_ProPlayer%5B%5D=tag_maikelele"
            case .Maniac:
                return "&category_730_ProPlayer%5B%5D=tag_maniac"
            case .Markeloff:
                return "&category_730_ProPlayer%5B%5D=tag_markeloff"
            case .N0thing:
                return "&category_730_ProPlayer%5B%5D=tag_nothing"
            case .NBK:
                return "&category_730_ProPlayer%5B%5D=tag_nbk"
            case .NEO:
                return "&category_730_ProPlayer%5B%5D=tag_neo"
            case .Nex:
                return "&category_730_ProPlayer%5B%5D=tag_nex"
            case .NiKo:
                return "&category_730_ProPlayer%5B%5D=tag_niko"
            case .Nitr0:
                return "&category_730_ProPlayer%5B%5D=tag_nitro"
            case .Olofmeister:
                return "&category_730_ProPlayer%5B%5D=tag_olofmeister"
            case .PashaBiceps:
                return "&category_730_ProPlayer%5B%5D=tag_pasha"
            case .Peet:
                return "&category_730_ProPlayer%5B%5D=tag_peet"
            case .Pimp:
                return "&category_730_ProPlayer%5B%5D=tag_pimp"
            case .Pronax:
                return "&category_730_ProPlayer%5B%5D=tag_pronax"
            case .Rain:
                return "&category_730_ProPlayer%5B%5D=tag_rain"
            case .Rallen:
                return "&category_730_ProPlayer%5B%5D=tag_rallen"
            case .ReltuC:
                return "&category_730_ProPlayer%5B%5D=tag_reltuc"
            case .Rickeh:
                return "&category_730_ProPlayer%5B%5D=tag_rickeh"
            case .RpK:
                return "&category_730_ProPlayer%5B%5D=tag_rpk"
            case .ScreaM:
                return "&category_730_ProPlayer%5B%5D=tag_scream"
            case .Seangares:
                return "&category_730_ProPlayer%5B%5D=tag_sgares"
            case .Seized:
                return "&category_730_ProPlayer%5B%5D=tag_seized"
            case .Shox:
                return "&category_730_ProPlayer%5B%5D=tag_shox"
            case .Shroud:
                return "&category_730_ProPlayer%5B%5D=tag_shroud"
            case .Skadoodle:
                return "&category_730_ProPlayer%5B%5D=tag_skadoodle"
            case .SmithZz:
                return "&category_730_ProPlayer%5B%5D=tag_smithzz"
            case .Snax:
                return "&category_730_ProPlayer%5B%5D=tag_snax"
            case .SnypeR:
                return "&category_730_ProPlayer%5B%5D=tag_snyper"
            case .Spiidi:
                return "&category_730_ProPlayer%5B%5D=tag_spiidi"
            case .SPUNJ:
                return "&category_730_ProPlayer%5B%5D=tag_spunj"
            case .Steel:
                return "&category_730_ProPlayer%5B%5D=tag_steel"
            case .Tarik:
                return "&category_730_ProPlayer%5B%5D=tag_tarik"
            case .TaZ:
                return "&category_730_ProPlayer%5B%5D=tag_taz"
            case .Tenzki:
                return "&category_730_ProPlayer%5B%5D=tag_tenzki"
            case .USTILO:
                return "&category_730_ProPlayer%5B%5D=tag_ustilo"
            case .WorldEdit:
                return "&category_730_ProPlayer%5B%5D=tag_worldedit"
            case .Xizt:
                return "&category_730_ProPlayer%5B%5D=tag_xizt"
            case .Xyp9x:
                return "&category_730_ProPlayer%5B%5D=tag_xyp9x"
            case .Yam:
                return "&category_730_ProPlayer%5B%5D=tag_yam"
            case .Zeus:
                return "&category_730_ProPlayer%5B%5D=tag_zeus"
            case .Any:
                return "&category_730_ProPlayer%5B%5D=any"
            default:
                return ""
        }
    }
}

func determineProfessionalPlayer(string: String) -> ProfessionalPlayer {
    
    switch string {
    case "adreN (Eric Hoag)":
        return .AdreN
    case "aizy (Philip Aistrup Larsen)":
        return .Aizy
    case "allu (Aleksi Jalli)":
        return .Allu
    case "apEX (Dan Madesclaire)":
        return .ApEX
    case "AZR (Aaron Ward)":
        return .AZR
    case "B1ad3 (Andrey Gorodenskiy)":
        return .B1ad3
    case "boltz (Ricardo Prass)":
        return .Boltz
    case "bondik (Vladyslav Nechyporchuk)":
        return .Bondik
    case "byali (Pawel Bielinsky)":
        return .Byali
    case "cajunb (Rene Borg)":
        return .Cajunb
    case "chrisJ (Chris de Jong)":
        return .ChrisJ
    case "coldzera (Marcelo David)":
        return .Coldzera
    case "DavCost (Vadim Vasilyev)":
        return .DavCost
    case "denis (Denis Howell)":
        return .Denis
    case "dennis (Dennis Edman)":
        return .Dennis
    case "device (Nicolai Reedtz)":
        return .Device
    case "dupreeh (Peter Rasmussen)":
        return .Dupreeh
    case "Edward (Ioann Sukhariev)":
        return .Edward
    case "EliGE (Jonathan Jablonowski)":
        return .EliGE
    case "emagine (Chris Rowlands)":
        return .Emagine
    case "Ex6TenZ (Kévin Droolans)":
        return .Ex6TenZ
    case "f0rest (Patrik Lindberg)":
        return .F0rest
    case "FalleN (Gabriel Toledo)":
        return .FalleN
    case "fer (Fernando Alvarenga)":
        return .Fer
    case "flamie (Egor Vasilyev)":
        return .Flamie
    case "flusha (Robin Rönnquist)":
        return .Flusha
    case "FNS (Pujan Mehta)":
        return .FNS
    case "fox (Ricardo Pacheco)":
        return .Fox
    case "freakazoid (Ryan Abadir)":
        return .Freakazoid
    case "friberg (Adam Friberg)":
        return .Friberg
    case "FugLy (Jacob Medina)":
        return .Fugly
    case "Furlan (Damian Kislowski)":
        return .Furlan
    case "GeT_RiGhT (Christopher Alesund)":
        return .GeTRiGhT
    case "gob b (Fatih Dayik)":
        return .GobB
    case "GruBy (Dominik Swiderski)":
        return .GruBy
    case "GuardiaN (Ladislav Kovács)":
        return .GuardiaN
    case "Happy (Vincent Cervoni)":
        return .Happy
    case "Havoc (Luke Paton)":
        return .Havoc
    case "hazed (James Cobb)":
        return .Hazed
    case "Hiko (Spencer Martin)":
        return .Hiko
    case "Hyper (Bartosz Wolny)":
        return .Hyper
    case "James (James Quinn)":
        return .James
    case "jdm64 (Joshua Marzano)":
        return .Jdm64
    case "jkaem (Joakim Myrbostad)":
        return .Jkaem
    case "jks (Justin Savage)":
        return .Jks
    case "JW (Jesper Wecksell)":
        return .JW
    case "karrigan (Finn Andersen)":
        return .Karrigan
    case "kennyS (Kenny Schrub)":
        return .KennyS
    case "kioShiMa (Fabien Fiey)":
        return .KioShiMa
    case "KRIMZ (Lars Freddy Johansson)":
        return .KRIMZ
    case "Maikelele (Mikail Bill)":
        return .Maikelele
    case "Maniac (Mathieu Quiquerez)":
        return .Maniac
    case "markeloff (Yegor Markelov)":
        return .Markeloff
    case "n0thing (Jordan Gilbert)":
        return .N0thing
    case "NBK- (Nathan Schmitt)":
        return .NBK
    case "NEO (Filip Kubski)":
        return .NEO
    case "nex (Johannes Maget)":
        return .Nex
    case "NiKo (Nikola Kovač)":
        return .NiKo
    case "nitr0 (Nicholas Cannella)":
        return .Nitr0
    case "olofmeister (Olof Kajbjer)":
        return .Olofmeister
    case "pashaBiceps (Jarosław Jarząbkowski)":
        return .PashaBiceps
    case "peet (Piotr Ćwikliński)":
        return .Peet
    case "Pimp (Jacob Winneche)":
        return .Pimp
    case "pronax (Markus Wallsten)":
        return .Pronax
    case "rain (Håvard Nygaard)":
        return .Rain
    case "rallen (Karol Rodowicz)":
        return .Rallen
    case "reltuC (Steven Cutler)":
        return  .ReltuC
    case "Rickeh (Ricardo Mulholland)":
        return .Rickeh
    case "RpK (Cédric Guipouy)":
        return .RpK
    case "ScreaM (Adil Benrlitom)":
        return .ScreaM
    case "seang@res (Sean Gares)":
        return .Seangares
    case "seized (Denis Kostin)":
        return .Seized
    case "shox (Richard Papillon)":
        return .Shox
    case "shroud (Michael Grzesiek)":
        return .Shroud
    case "Skadoodle (Tyler Latham)":
        return .Skadoodle
    case "SmithZz (Edouard Dubourdeaux)":
        return .SmithZz
    case "Snax (Janusz Pogorzelski)":
        return .Snax
    case "SnypeR (Iain Turner)":
        return .SnypeR
    case "Spiidi (Timo Richter)":
        return .Spiidi
    case "SPUNJ (Chad Burchill)":
        return .SPUNJ
    case "steel (Lucas Lopes)":
        return .Steel
    case "tarik (Tarik Celik)":
        return .Tarik
    case "TaZ (Wiktor Wojtas)":
        return .TaZ
    case "tenzki (Jesper Mikalski)":
        return .Tenzki
    case "USTILO (Karlo Pivac)":
        return .USTILO
    case "WorldEdit (Georgy Yaskin)":
        return .WorldEdit
    case "Xizt (Richard Landström)":
        return .Xizt
    case "Xyp9x (Andreas Højsleth)":
        return .Xyp9x
    case "yam (Yaman Ergenekon)":
        return .Yam
    case "Zeus (Danylo Teslenko)":
        return .Zeus
    default:
        return .Any
    }
}

enum Team: Int, EnumerableEnum {
    
    case RReasonGaming, ThreeDMax, AstanaDragons, BravadoGaming, ClanMystik, Cloud9, Cloud9G2A, CompLexityGaming, CopenhagenWolves, CounterLogicGaming, DATteam, EpsilonESports, ESCGaming, Flipsid3Tactics, Fnatic, G2Esports, HellRaisers, IBUYPOWER, KeydStars, LGBESports, LondonConspiracy, LuminosityGaming, Mousesports, MTSGameGodWolf, myXMG, NIfaculty, NatusVincere, NinjasInPyjamas, NIPTeamA, NIPTeamB, PENTASports, PlanetkeyDynamics, ReasonGaming, Renegades, SKGaming, TeamDignitas, TeamDuncan, TeamEBettle, TeamEnVyUs, TeamImmunity, TeamKinguin, TeamLDLC, TeamLiquid, TeamSoloMid, TeamTomi, Titan, TSMKinguin, UniversalSoldiers, ValveSquadAlpha, ValveSquadBravo, VeryGames, VexedGaming, VirtusPro, VoxEminor, WeGotGame, Xapso, Any
    
    func stringDescription() -> String {
        switch self {
        case .RReasonGaming:
            return "[R]eason Gaming"
        case .AstanaDragons:
            return "Astana Dragons"
        case .BravadoGaming:
            return "Bravado Gaming"
        case .ClanMystik:
            return "Clan Mystik"
        case .Cloud9:
            return "Cloud9"
        case .Cloud9G2A:
            return "Cloud9 G2A"
        case .CompLexityGaming:
            return "CompLexity Gaming"
        case .CopenhagenWolves:
            return "Copenhagen Wolves"
        case .CounterLogicGaming:
            return "Counter Logic Gaming"
        case .DATteam:
            return "dAT Team"
        case .EpsilonESports:
            return "Epsilon eSports"
        case .ESCGaming:
            return "ESC Gaming"
        case .Flipsid3Tactics:
            return "Flipsid3 Tactics"
        case .Fnatic:
            return "Fnatic"
        case .G2Esports:
            return "G2 Esports"
        case .HellRaisers:
            return "HellRaisers"
        case .IBUYPOWER:
            return "iBUYPOWER"
        case .KeydStars:
            return "Keyd Stars"
        case .LGBESports:
            return "LGB eSports"
        case .LondonConspiracy:
            return "London Conspiracy"
        case .LuminosityGaming:
            return "Luminosity Gaming"
        case .Mousesports:
            return "Mousesports"
        case .MTSGameGodWolf:
            return "MTS GameGod Wolf"
        case .myXMG:
            return "myXMG"
        case .NatusVincere:
            return "Natus Vincere"
        case .NIfaculty:
            return "n!faculty"
        case .NinjasInPyjamas:
            return "Ninjas in Pyjamas"
        case .NIPTeamA:
            return "NIP Team A"
        case .NIPTeamB:
            return "NIP Team B"
        case .PENTASports:
            return "PENTA Sports"
        case .PlanetkeyDynamics:
            return "Planetkey Dynamics"
        case .ReasonGaming:
            return "Reason Gaming"
        case .Renegades:
            return "Renegages"
        case .SKGaming:
            return "SK Gaming"
        case .TeamDignitas:
            return "Team Dignitas"
        case .TeamDuncan:
            return "Team Duncan"
        case .TeamEBettle:
            return "Team eBettle"
        case .TeamEnVyUs:
            return "Team EnVyUs"
        case .TeamImmunity:
            return "Team Immunity"
        case .TeamKinguin:
            return "Team Kinguin"
        case .TeamLDLC:
            return "Team LDLC.com"
        case .TeamLiquid:
            return "Team Liquid"
        case .TeamSoloMid:
            return "Team SoloMid"
        case .TeamTomi:
            return "Team Tomi"
        case .ThreeDMax:
            return "3DMax"
        case .Titan:
            return "Titan"
        case .TSMKinguin:
            return "TSM Kinguin"
        case .UniversalSoldiers:
            return "Universal Soldiers"
        case .ValveSquadAlpha:
            return "Valve Square Alpha"
        case .ValveSquadBravo:
            return "Value Squad Bravo"
        case .VeryGames:
            return "Very Games"
        case .VexedGaming:
            return "Vexed Gaming"
        case .VirtusPro:
            return "Virtus.Pro"
        case .VoxEminor:
            return "Vox Eminor"
        case .WeGotGame:
            return "We got game"
        case .Xapso:
            return "Xapso"
        case .Any:
            return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
        case .RReasonGaming:
            return "&category_730_TournamentTeam%5B%5D=tag_Team16"
        case .AstanaDragons:
            return "&category_730_TournamentTeam%5B%5D=tag_Team2"
        case .BravadoGaming:
            return "&category_730_TournamentTeam%5B%5D=tag_Team40"
        case .ClanMystik:
            return "&category_730_TournamentTeam%5B%5D=tag_Team7"
        case .Cloud9:
            return "&category_730_TournamentTeam%5B%5D=tag_Team33"
        case .Cloud9G2A:
            return "&category_730_TournamentTeam%5B%5D=tag_Team52"
        case .CompLexityGaming:
            return "&category_730_TournamentTeam%5B%5D=tag_Team3"
        case .CopenhagenWolves:
            return "&category_730_TournamentTeam%5B%5D=tag_Team10"
        case .CounterLogicGaming:
            return "&category_730_TournamentTeam%5B%5D=tag_Team49"
        case .DATteam:
            return "&category_730_TournamentTeam%5B%5D=tag_Team34"
        case .EpsilonESports:
            return "&category_730_TournamentTeam%5B%5D=tag_Team35"
        case .ESCGaming:
            return "&category_730_TournamentTeam%5B%5D=tag_Team42"
        case .Flipsid3Tactics:
            return "&category_730_TournamentTeam%5B%5D=tag_Team43"
        case .Fnatic:
            return "&category_730_TournamentTeam%5B%5D=tag_Team6"
        case .G2Esports:
            return "&category_730_TournamentTeam%5B%5D=tag_Team59"
        case .HellRaisers:
            return "&category_730_TournamentTeam%5B%5D=tag_Team25"
        case .IBUYPOWER:
            return "&category_730_TournamentTeam%5B%5D=tag_Team5"
        case .KeydStars:
            return "&category_730_TournamentTeam%5B%5D=tag_Team50"
        case .LGBESports:
            return "&category_730_TournamentTeam%5B%5D=tag_Team9"
        case .LondonConspiracy:
            return "&category_730_TournamentTeam%5B%5D=tag_Team36"
        case .LuminosityGaming:
            return "&category_730_TournamentTeam%5B%5D=tag_Team57"
        case .Mousesports:
            return "&category_730_TournamentTeam%5B%5D=tag_Team29"
        case .MTSGameGodWolf:
            return "&category_730_TournamentTeam%5B%5D=tag_Team37"
        case .myXMG:
            return "&category_730_TournamentTeam%5B%5D=tag_Team38"
        case .NatusVincere:
            return "&category_730_TournamentTeam%5B%5D=tag_Team12"
        case .NIfaculty:
            return "&category_730_TournamentTeam%5B%5D=tag_Team13"
        case .NinjasInPyjamas:
            return "&category_730_TournamentTeam%5B%5D=tag_Team1"
        case .NIPTeamA:
            return "&category_730_TournamentTeam%5B%5D=tag_Team20"
        case .NIPTeamB:
            return "&category_730_TournamentTeam%5B%5D=tag_Team21"
        case .PENTASports:
            return "&category_730_TournamentTeam%5B%5D=tag_Team39"
        case .PlanetkeyDynamics:
            return "&category_730_TournamentTeam%5B%5D=tag_Team41"
        case .ReasonGaming:
            return "&category_730_TournamentTeam%5B%5D=tag_Team30"
        case .Renegades:
            return "&category_730_TournamentTeam%5B%5D=tag_Team53"
        case .SKGaming:
            return "&category_730_TournamentTeam%5B%5D=tag_Team14"
        case .TeamDignitas:
            return "&category_730_TournamentTeam%5B%5D=tag_Team24"
        case .TeamDuncan:
            return "&category_730_TournamentTeam%5B%5D=tag_Team23"
        case .TeamEBettle:
            return "&category_730_TournamentTeam%5B%5D=tag_Team56"
        case .TeamEnVyUs:
            return "&category_730_TournamentTeam%5B%5D=tag_Team46"
        case .TeamImmunity:
            return "&category_730_TournamentTeam%5B%5D=tag_Team54"
        case .TeamKinguin:
            return "&category_730_TournamentTeam%5B%5D=tag_Team55"
        case .TeamLDLC:
            return "&category_730_TournamentTeam%5B%5D=tag_Team26"
        case .TeamLiquid:
            return "&category_730_TournamentTeam%5B%5D=tag_Team48"
        case .TeamSoloMid:
            return "&category_730_TournamentTeam%5B%5D=tag_Team58"
        case .TeamTomi:
            return "&category_730_TournamentTeam%5B%5D=tag_Team22"
        case .ThreeDMax:
            return "&category_730_TournamentTeam%5B%5D=tag_Team28"
        case .Titan:
            return "&category_730_TournamentTeam%5B%5D=tag_Team27"
        case .TSMKinguin:
            return "&category_730_TournamentTeam%5B%5D=tag_Team51"
        case .UniversalSoldiers:
            return "&category_730_TournamentTeam%5B%5D=tag_Team11"
        case .ValveSquadAlpha:
            return "&category_730_TournamentTeam%5B%5D=tag_Team17"
        case .ValveSquadBravo:
            return "&category_730_TournamentTeam%5B%5D=tag_Team18"
        case .VeryGames:
            return "&category_730_TournamentTeam%5B%5D=tag_Team4"
        case .VexedGaming:
            return "&category_730_TournamentTeam%5B%5D=tag_Team47"
        case .VirtusPro:
            return "&category_730_TournamentTeam%5B%5D=tag_Team31"
        case .VoxEminor:
            return "&category_730_TournamentTeam%5B%5D=tag_Team32"
        case .WeGotGame:
            return "&category_730_TournamentTeam%5B%5D=tag_Team8"
        case .Xapso:
            return "&category_730_TournamentTeam%5B%5D=tag_Team15"
        case .Any:
            return "&category_730_TournamentTeam%5B%5D=any"
        }
    }
}

func determineTeam(string: String) -> Team {
    switch string {
    case "[R]eason Gaming":
        return .RReasonGaming
    case "Astana Dragons":
        return .AstanaDragons
    case "Bravado Gaming":
        return .BravadoGaming
    case "Clan Mystik":
        return .ClanMystik
    case "Cloud9":
        return .Cloud9
    case "Cloud9 G2A":
        return .Cloud9G2A
    case "CompLexity Gaming":
        return .CompLexityGaming
    case "Copenhagen Wolves":
        return .CopenhagenWolves
    case "Counter Logic Gaming":
        return .CounterLogicGaming
    case "dAT Team":
        return .DATteam
    case "Epsilon eSports":
        return .EpsilonESports
    case "ESC Gaming":
        return .ESCGaming
    case "Flipsid3 Tactics":
        return .Flipsid3Tactics
    case "Fnatic":
        return .Fnatic
    case "G2 Esports":
        return .G2Esports
    case "HellRaisers":
        return .HellRaisers
    case "iBUYPOWER":
        return .IBUYPOWER
    case "Keyd Stars":
        return .KeydStars
    case "LGB eSports":
        return .LGBESports
    case "London Conspiracy":
        return .LondonConspiracy
    case "Luminosity Gaming":
        return .LuminosityGaming
    case "Mousesports":
        return .Mousesports
    case "MTS GameGod Wolf":
        return .MTSGameGodWolf
    case "myXMG":
        return .myXMG
    case "Natus Vincere":
        return .NatusVincere
    case "n!faculty":
        return .NIfaculty
    case "Ninjas in Pyjamas":
        return .NinjasInPyjamas
    case "NIP Team A":
        return .NIPTeamA
    case "NIP Team B":
        return .NIPTeamB
    case "PENTA Sports":
        return .PENTASports
    case "Planetkey Dynamics":
        return .PlanetkeyDynamics
    case "Reason Gaming":
        return .ReasonGaming
    case "Renegages":
        return .Renegades
    case "SK Gaming":
        return .SKGaming
    case "Team Dignitas":
        return .TeamDignitas
    case "Team Duncan":
        return .TeamDuncan
    case "Team eBettle":
        return .TeamEBettle
    case "Team EnVyUs":
        return .TeamEnVyUs
    case "Team Immunity":
        return .TeamImmunity
    case "Team Kinguin":
        return .TeamKinguin
    case "Team LDLC.com":
        return .TeamLDLC
    case "Team Liquid":
        return .TeamLiquid
    case "Team SoloMid":
        return .TeamSoloMid
    case "Team Tomi":
        return .TeamTomi
    case "3DMax":
        return .ThreeDMax
    case "Titan":
        return .Titan
    case "TSM Kinguin":
        return .TSMKinguin
    case "Universal Soldiers":
        return .UniversalSoldiers
    case "Valve Square Alpha":
        return .ValveSquadAlpha
    case "Value Squad Bravo":
        return .ValveSquadBravo
    case "Very Games":
        return .VeryGames
    case "Vexed Gaming":
        return .VexedGaming
    case "Virtus.Pro":
        return .VirtusPro
    case "Vox Eminor":
        return .VoxEminor
    case "We got game":
        return .WeGotGame
    case "Xapso":
        return .Xapso
    default:
        return .Any
    }
}

enum Weapon: Int, EnumerableEnum {
    case AK47, AUG, AWP, Bayonet, ButterflyKnife, CZ75Auto, DesertEagle, DualBerettas, FalchionKnife, FAMAS, FiveSeveN, FlipKnife, G3SG1, GalilAR, Glock18, GutKnife, HuntsmanKnife, Karambit, M249, M4A1S, M4A4, M9Bayonet, MAC10, MAG7, MP7, MP9, Negev, Nova, P2000, P250, P90, PPBizon, SawedOff, SCAR20, SG553, ShadowDaggers, SSG08, Tec9, UMP45, USPS, XM1014, Any
    
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
        case .Any:
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
        case .Any:
            return "&category_730_Weapon%5B%5D=any"
        }
    }
}

func determineWeapon(string: String) -> Weapon {
    
    if string.containsString("AK-47") {
        
        return Weapon.AK47
        
    } else if string.containsString("AUG") {
        
        return Weapon.AUG
        
    } else if string.containsString("AWP") {
        
        return Weapon.AWP
        
    } else if string.containsString("Bayonet") {
        
        return Weapon.Bayonet
        
    } else if string.containsString("Butterfly Knife") {
        
        return Weapon.ButterflyKnife
        
    } else if string.containsString("CZ75-Auto") {
    
        return Weapon.CZ75Auto
        
    } else if string.containsString("Desert Eagle") {
        
        return Weapon.DesertEagle
        
    } else if string.containsString("Dual Berettas") {
        
        return Weapon.DualBerettas
        
    } else if string.containsString("Falchion Knife") {
        
        return Weapon.FalchionKnife
        
    } else if string.containsString("FAMAS") {
        
        return Weapon.FAMAS
        
    } else if string.containsString("Five-SeveN") {
        
        return Weapon.FiveSeveN
        
    } else if string.containsString("Flip Knife") {
        
        return Weapon.FlipKnife
        
    } else if string.containsString("G3SG1") {
        
        return Weapon.G3SG1
        
    } else if string.containsString("Galil AR") {
        
        return Weapon.GalilAR
        
    } else if string.containsString("Glock-18") {
        
        return Weapon.Glock18
        
    } else if string.containsString("Gut Knife") {
        
        return Weapon.GutKnife
        
    } else if string.containsString("Huntsman Knife"){
        
        return Weapon.HuntsmanKnife
        
    } else if string.containsString("Karambit") {
        
        return Weapon.Karambit
        
    } else if string.containsString("M249") {
        
        return Weapon.M249
        
    } else if string.containsString("M4A1-S") {
     
        return Weapon.M4A1S
        
    } else if string.containsString("M4A4"){
        
        return Weapon.M4A4
        
    } else if string.containsString("M9 Bayonet") {
        
        return Weapon.M9Bayonet
        
    } else if string.containsString("MAC-10") {
        
        return Weapon.MAC10
        
    } else if string.containsString("MAG-7") {
     
        return Weapon.MAG7
        
    } else if string.containsString("MP7") {
        
        return Weapon.MP7
        
    } else if string.containsString("MP9") {
        
        return Weapon.MP9
        
    } else if string.containsString("Negev") {
        
        return Weapon.Negev
        
    } else if string.containsString("Nova") {
        
        return Weapon.Nova
        
    } else if string.containsString("P2000"){
        
        return Weapon.P2000
        
    } else if string.containsString("P250") {
        
        return Weapon.P250
        
    } else if string.containsString("P90") {
        
        return Weapon.P90
        
    } else if string.containsString("PP-Bizon") {
        
        return Weapon.PPBizon
        
    } else if string.containsString("Sawed-Off") {
        
        return Weapon.SawedOff
        
    } else if string.containsString("SCAR-20") {
        
        return Weapon.SCAR20
        
    } else if string.containsString("SG 553") {
        
        return Weapon.SG553
        
    } else if string.containsString("Shadow Daggers") {
        
        return Weapon.ShadowDaggers
        
    } else if string.containsString("SSG 08") {
        
        return Weapon.SSG08
        
    } else if string.containsString("Tec-9") {
        
        return Weapon.Tec9
        
    } else if string.containsString("UMP-45") {
        
        return Weapon.UMP45
        
    } else if string.containsString("USP-S") {
        
        return Weapon.USPS
        
    } else if string.containsString("XM1014") {
     
        return Weapon.XM1014
        
    } else {
        
        return Weapon.Any
        
    }
}

enum Exterior: Int, EnumerableEnum {
    
    case FieldTested, MinimalWear, BattleScarred, WellWorn, FactoryNew, NotPainted, Any
    
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
        case .NotPainted:
            return "Not Painted"
        case .WellWorn:
            return "Well-Worn"
        case .Any:
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
        case .Any:
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
        
        return Exterior.Any
        
    }
}

enum Category: Int, EnumerableEnum {
    
    case Normal, StatTrak™, Souvenir, Star, StarStatTrak™, Any
    
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
        case .Any:
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
        case .Any:
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
        case .Any:
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
        
    } else if name.containsString("Normal") {
        return Category.Normal
    }
    
    return Category.Any
}

enum Quality: Int, EnumerableEnum {
    
    case ConsumerGrade, MilSpecGrade, IndustrialGrade, Restricted, Classified, Covert, BaseGrade, HighGrade, Exotic, Remarkable, Contraband, Any
    
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
        case .Any:
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
        case .Any:
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
        case .Any:
            return "&category_730_Rarity%5B%5D=any"
        }
    }
}

func determineQuality(string: String!) -> Quality {
    
    if string.containsString("Base") {
        return Quality.BaseGrade
    } else if string.containsString("Classified") {
        return Quality.Classified
    } else if string.containsString("Consumer") {
        return Quality.ConsumerGrade
    } else if string.containsString("Contraband") {
        return Quality.Contraband
    } else if string.containsString("Covert") {
        return Quality.Covert
    } else if string.containsString("Exotic") {
        return Quality.Exotic
    } else if string.containsString("High") {
        return Quality.HighGrade
    } else if string.containsString("Industrial") {
        return Quality.IndustrialGrade
    } else if string.containsString("Mil-Spec") {
        return Quality.MilSpecGrade
    } else if string.containsString("Remarkable") {
        return Quality.Remarkable
    } else if string.containsString("Restricted") {
        return Quality.Restricted
    } else {
        return Quality.Any
    }
    
}

enum StickerCollection: Int, EnumerableEnum {
    
    case ESLOneCologne2015PlayerAutographs, DreamHackClujNapoca2015PlayerAutographs, ESLOneKatowice2015Legends, ESLOneKatowice2015Challengers, DreamHack2014Legends, ESLOneCologne2014Challengers, DreamHackClujNapoca2015Legends, ESLOneCologne2015Legends, DreamHackClujNapoca2015Challengers, CommunityStickersSeries1, CommunityStickersSeries2, CommunityStickersSeries3, ESLOneCologne2015Challengers, EMSKatowice2014Challengers, EMSKatowice2014Legends, StickerCapsule2, StickerCapsule, ESLOneCologne2014Legends, EnfuStickerCapsule, DreamHack2014Challengers, Any
    
    func stringDescription() -> String {
        switch self {
        case .CommunityStickersSeries1:
            return "Community Stickers Series 1"
        case .CommunityStickersSeries2:
            return "Community Stickers Series 2"
        case .CommunityStickersSeries3:
            return "Community Stickers Series 3"
        case .DreamHack2014Challengers:
            return "DreamHack 2014 Challengers"
        case .DreamHack2014Legends:
            return "DreamHack 2014 Legends"
        case .DreamHackClujNapoca2015PlayerAutographs:
            return "DreamHack Cluj-Napoca 2015 Player Autographs"
        case .DreamHackClujNapoca2015Challengers:
            return "DreamHack Cluj-Napoca 2015 Challengers"
        case .DreamHackClujNapoca2015Legends:
            return "DreamHack Cluj-Napoca 2015 Legends"
        case .EMSKatowice2014Challengers:
            return "EMS Katowice 2014 Challengers"
        case .EMSKatowice2014Legends:
            return "EMS Katowice 2014 Lgends"
        case .EnfuStickerCapsule:
            return "Enfu Sticker Capsule"
        case .ESLOneCologne2014Challengers:
            return "ESL One Colonge 2014 Challengers"
        case .ESLOneCologne2014Legends:
            return "ESL One Colone 2014 Legends"
        case .ESLOneCologne2015Challengers:
            return "ESL One Colonge 2015 Challengers"
        case .ESLOneCologne2015Legends:
            return "ESL One Colonge 2015 Legends"
        case .ESLOneCologne2015PlayerAutographs:
            return "ESL One Colonge 2015 Player Autographs"
        case .ESLOneKatowice2015Challengers:
            return "ESL One Katowice 2015 Challengers"
        case .ESLOneKatowice2015Legends:
            return "ESL One Katowice 2015 Legends"
        case .StickerCapsule:
            return "Sticker Capsule"
        case .StickerCapsule2:
            return "Sticker Capsule 2"
        case .Any:
            return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
        case .CommunityStickersSeries1:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack01"
        case .CommunityStickersSeries2:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack02"
        case .CommunityStickersSeries3:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack03"
        case .DreamHack2014Challengers:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_dhw2014_02"
        case .DreamHack2014Legends:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_dhw2014_01_collection"
        case .DreamHackClujNapoca2015PlayerAutographs:
            return "&category_730_StickerCapsule_crate_signature_pack_cluj2015_group_players_collection"
        case .DreamHackClujNapoca2015Challengers:
            return "&category_730_StickerCapsule_crate_sticker_pack_cluj2015_legends_collection"
        case .DreamHackClujNapoca2015Legends:
            return "&category_730_StickerCapsule_crate_sticker_pack_cluj2015_challengers_collection"
        case .EMSKatowice2014Challengers:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_kat2014_01"
        case .EMSKatowice2014Legends:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_kat2014_02"
        case .EnfuStickerCapsule:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_enfu_capsule_lootlist"
        case .ESLOneCologne2014Challengers:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_cologne2014_02"
        case .ESLOneCologne2014Legends:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_cologne2014_01"
        case .ESLOneCologne2015Challengers:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_eslcologne2015_challengers_collection"
        case .ESLOneCologne2015Legends:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_eslcologne2015_legends_collection"
        case .ESLOneCologne2015PlayerAutographs:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_signature_pack_eslcologne2015_group_players_collection"
        case .ESLOneKatowice2015Challengers:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_eslkatowice2015_02_collection"
        case .ESLOneKatowice2015Legends:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_eslkatowice2015_01_collection"
        case .StickerCapsule:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack01"
        case .StickerCapsule2:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack02"
        case .Any:
            return "&category_730_StickerCapsule%5B%5D=any"
        }
    }
}

func determineStickerCollection(string: String!) -> StickerCollection {
    
    switch string {
        case "Community Stickers Series 1":
            return .CommunityStickersSeries1
        case "Community Stickers Series 2":
            return .CommunityStickersSeries2
        case "Community Stickers Series 3":
            return .CommunityStickersSeries3
        case "DreamHack 2014 Challengers":
            return .DreamHack2014Challengers
        case "DreamHack 2014 Legends":
            return .DreamHack2014Legends
        case "DreamHack Cluj-Napoca 2015 Player Autographs":
            return .DreamHackClujNapoca2015PlayerAutographs
        case "DreamHack Cluj-Napoca 2015 Challengers":
            return .DreamHackClujNapoca2015Challengers
        case "DreamHack Cluj-Napoca 2015 Legends":
            return .DreamHackClujNapoca2015Legends
        case "EMS Katowice 2014 Challengers":
            return .EMSKatowice2014Challengers
        case "EMS Katowice 2014 Legends":
            return .EMSKatowice2014Legends
        case "Enfu Sticker Capsule":
            return .EnfuStickerCapsule
        case "ESL One Colonge 2014 Challengers":
            return .ESLOneCologne2014Challengers
        case "ESL One Colone 2014 Legends":
            return .ESLOneCologne2014Legends
        case "ESL One Colonge 2015 Challengers":
            return .ESLOneCologne2015Challengers
        case "ESL One Colonge 2015 Legends":
            return .ESLOneKatowice2015Legends
        case "Sticker Capsule":
            return .StickerCapsule
        case "Sticker Capsule 2":
            return .StickerCapsule2
        default:
            return .Any
    }
}

enum StickerCategory: Int, EnumerableEnum {
 
    case TeamLogo, PlayerAutograph, Tournament, Any
    
    func stringDescription() -> String {
        switch self {
        case .PlayerAutograph:
            return "Player Autograph"
        case .TeamLogo:
            return "Team Logo"
        case .Tournament:
            return "Tournament"
        case .Any:
            return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
        case .PlayerAutograph:
            return "&category_730_StickerCategory%5B%5D=tag_PlayerSignature"
        case .TeamLogo:
            return "&category_730_StickerCategory%5B%5D=tag_TeamLogo"
        case .Tournament:
            return "&category_730_StickerCategory%5B%5D=tag_Tournament"
        case .Any:
            return "&category_730_StickerCategory%5B%5D=any"
        }
    }
}

func determineStickerCategory(string: String!) -> StickerCategory {
    switch string {
    case "Player Autograph":
        return .PlayerAutograph
    case "Team Logo":
        return .TeamLogo
    case "Tournament":
        return .Tournament
    default:
        return .Any
    }
}

enum Tournament: Int, EnumerableEnum {
 
    case ESLOneCologne2015, ESLOneKatowice2015, ESLOneCologne2014, EMSOneKatowice2014, DreamHackClujNapoca2015, DreamHackWinter2014, DreamHackWinter2013, Any
    
    func stringDescription() -> String {
        switch self {
            case .DreamHackWinter2013:
                return "DreamHack Winter 2013"
            case .DreamHackWinter2014:
                return "DreamHack Winter 2014"
            case .DreamHackClujNapoca2015:
                return "DreamHack Cluj-Napoca 2015"
            case .EMSOneKatowice2014:
                return "EMS One Katowice 2014"
            case .ESLOneCologne2014:
                return "ESL One Cologne 2014"
            case .ESLOneCologne2015:
                return "ESL One Colonge 2015"
            case .ESLOneKatowice2015:
                return "ESL One Katowice 2015"
            case .Any:
                return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
        case .DreamHackWinter2013:
            return "&category_730_Tournament%5B%5D=tag_Tournament1"
        case .DreamHackWinter2014:
            return "&category_730_Tournament%5B%5D=tag_Tournament5"
        case .DreamHackClujNapoca2015:
            return "&category_730_Tournament%5B%5D=tag_Tournament8"
        case .EMSOneKatowice2014:
            return "&category_730_Tournament%5B%5D=tag_Tournament3"
        case .ESLOneCologne2014:
            return "&category_730_Tournament%5B%5D=tag_Tournament4"
        case .ESLOneCologne2015:
            return "&category_730_Tournament%5B%5D=tag_Tournament6"
        case .ESLOneKatowice2015:
            return "&category_730_Tournament%5B%5D=tag_Tournament7"
        case .Any:
            return "&category_730_Tournament%5B%5D=any"
        }
    }
}

func determineTournament(string: String!) -> Tournament {
    
    switch string {
        
        case "2013 DreamHack Winter":
            return .DreamHackWinter2013
        case "2014 DreamHack Winter":
            return .DreamHackWinter2014
        case "2015 DreamHack Cluj-Napoca":
            return .DreamHackClujNapoca2015
        case "2014 EMS One Katowice":
            return .EMSOneKatowice2014
        case "2014 ESL One Cologne":
            return .ESLOneCologne2014
        case "2015 ESL One Cologne":
            return .ESLOneCologne2015
        case "2015 ESL One Katowice":
            return .ESLOneKatowice2015
        default:
            return .Any
        
    }

}

enum Type: Int, EnumerableEnum {
    case Pistol, SMG, Rifle, Shotgun, SniperRifle, Machinegun, Container, Knife, Sticker, MusicKit, Key, Pass, Gift, Tag, Tool, Any
    
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
        case .Any:
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
        case .Any:
            return "&category_730_Type%5B%5D=any"
        }
    }
}

func determineType(string: String) -> Type {
    
    if string.containsString("Case Hardened") {
        
        if string.containsString("Negev") || string.containsString("M249") {
            
            return Type.Machinegun
            
        } else if string.containsString("CZ75-Auto") || string.containsString("Desert Eagle") || string.containsString("Dual Berettas") || string.containsString("Five-SeveN") || string.containsString("Glock-18") || string.containsString("P2000") || string.containsString("P250") || string.containsString("Tec-9") || string.containsString("USP-S") {
            
            return Type.Pistol
            
        } else if string.containsString("AK-47") || string.containsString("AUG") || string.containsString("FAMAS") || string.containsString("Galil AR") || string.containsString("M4A1-S") || string.containsString("M4A4") || string.containsString("SG 553") {
            
            return Type.Rifle
            
        } else if string.containsString("MAC-10") || string.containsString("MP7") || string.containsString("MP9") || string.containsString("PP-Bizon") || string.containsString("P90") || string.containsString("UMP-45") {
            
            return Type.SMG
            
        } else if string.containsString("MAG-7") || string.containsString("Nova") || string.containsString("Sawed-Off") || string.containsString("XM1014") {
            
            return Type.Shotgun
            
        } else if string.containsString("AWP") || string.containsString("SSG 08") || string.containsString("G3SG1") || string.containsString("SCAR-20") {
            
            return Type.SniperRifle
            
        } else if string.containsString("Bayonet") || string.containsString("Butterfly Knife") || string.containsString("Falchion Knife") || string.containsString("Flip Knife") || string.containsString("Gut Knife") || string.containsString("Huntsman Knife") || string.containsString("Karambit") || string.containsString("M9 Bayonet") || string.containsString("Shadow Daggers") {
            
            return Type.Knife
            
        } else {
            
            return Type.Any
            
        }

    
    } else {
        
        if string.containsString("Sticker |") {
            
            return Type.Sticker
            
        } else if string.containsString("Key") {
            
            return Type.Key
            
        } else if string.containsString("Case") || string.containsString("Capsule") || string.containsString("Legends") || string.containsString("Challengers") || string.containsString("Souvenir Package") && !string.containsString("Key") {
         
            return Type.Container
            
        } else if string.containsString("Pass") {
            
            return Type.Pass
            
        } else if string.containsString("Music Kit") {
            
            return Type.MusicKit
            
        } else if string.containsString("Gift") || string.containsString("Parcel") || string.containsString("Presents") {
            
            return Type.Gift
            
        } else if string.containsString("Name Tag") {
            
            return Type.Tag
            
        } else if string.containsString("StatTrak™ Swap Tool") {
            
            return Type.Tool
            
        } else if string.containsString("Negev") || string.containsString("M249") {
            
            return Type.Machinegun
            
        } else if string.containsString("CZ75-Auto") || string.containsString("Desert Eagle") || string.containsString("Dual Berettas") || string.containsString("Five-SeveN") || string.containsString("Glock-18") || string.containsString("P2000") || string.containsString("P250") || string.containsString("Tec-9") || string.containsString("USP-S") {
            
            return Type.Pistol
            
        } else if string.containsString("AK-47") || string.containsString("AUG") || string.containsString("FAMAS") || string.containsString("Galil AR") || string.containsString("M4A1-S") || string.containsString("M4A4") || string.containsString("SG 553") {
            
            return Type.Rifle
            
        } else if string.containsString("MAC-10") || string.containsString("MP7") || string.containsString("MP9") || string.containsString("PP-Bizon") || string.containsString("P90") || string.containsString("UMP-45") {
            
            return Type.SMG
            
        } else if string.containsString("MAG-7") || string.containsString("Nova") || string.containsString("Sawed-Off") || string.containsString("XM1014") {
            
            return Type.Shotgun
            
        } else if string.containsString("AWP") || string.containsString("SSG 08") || string.containsString("G3SG1") || string.containsString("SCAR-20") {
            
            return Type.SniperRifle
            
        } else if string.containsString("Bayonet") || string.containsString("Butterfly Knife") || string.containsString("Falchion Knife") || string.containsString("Flip Knife") || string.containsString("Gut Knife") || string.containsString("Huntsman Knife") || string.containsString("Karambit") || string.containsString("M9 Bayonet") || string.containsString("Shadow Daggers") {
            
            return Type.Knife
            
        } else {
            
            return Type.Any
            
        }
        
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
        itemName = itemName.stringByReplacingOccurrencesOfString("★ ", withString: "")
    } else if itemName.containsString("★ StatTrak™") {
        itemName = itemName.stringByReplacingOccurrencesOfString("★ StatTrak™ ", withString: "")
    }

    if itemName.containsString("Music Kit |") {
        
        itemName = itemName.stringByReplacingOccurrencesOfString("Music Kit |", withString: "")
        itemName = itemName.componentsSeparatedByString(", ")[1]
        
    }
    
    return itemName
}
