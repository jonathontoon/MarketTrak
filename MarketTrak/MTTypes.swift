//
//  MTTypes.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 10/2/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//
//

enum Collection {
    
    case TheAlphaCollection, TheArmsDeal2Collection, TheArmsDeal3Collection, TheArmsDealCollection, TheAssaultCollection, TheAztecCollection, TheBaggageCollection, TheBankCollection, TheBravoCollection, TheBreakoutCollection, TheCacheCollection, TheChopShopCollection, TheChroma2Collection, TheChromaCollection, TheCobblestoneCollection, TheDust2Collection, TheDustCollection, TheeSports2013Collection, TheeSports2013WinterCollection, TheeSports2014SummerCollection, TheFalchionCollection, TheGodsandMonstersCollection, TheHuntsmanCollection, TheInfernoCollection, TheItalyCollection, TheLakeCollection, TheMilitiaCollection, TheMirageCollection, TheNukeCollection, TheOfficeCollection, TheOverpassCollection, ThePhoenixCollection, TheRisingSunCollection, TheSafehouseCollection, TheShadowCollection, TheTrainCollection, TheVanguardCollection, TheVertigoCollection, TheWinterOffensiveCollection, None
    
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
        case .None:
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
        case .None:
            return "&category_730_ItemSet%5B%5D=any"
        }
    }
}

func determineCollection(string: String) -> Collection {
    
    if string == "SCAR-20 | Emerald" || string == "FAMAS | Spitfire" || string == "AUG | Anodized Navy" || string == "PP-Bizon | Rust Coat" || string == "MAG-7 | Hazard" || string == "P250 | Facets" || string == "Sawed-Off | Mosaico" || string == "Negev | Palm" || string == "SSG 08 | Mayan Dreams" || string == "Glock-18 | Sand Dune" || string == "MP7 | Groundwater" || string == "XM1014 | Jungle" || string == "Five-SeveN | Anodized Gunmetal" || string == "MP9 | Dry Season" || string == "Tec-9 | Tornado" || string == "M249 | Jungle DDPAT" {
        
        return Collection.TheAlphaCollection
        
    } else if string == "The Arms Deal 2 Collection" {
        
        return Collection.TheArmsDeal2Collection
        
    } else if string == "The Arms Deal 3 Collection" {
        
        return Collection.TheArmsDeal3Collection
        
    } else if string == "The Arms Deal Collection" {
        
        return Collection.TheArmsDealCollection
        
    } else if string == "Glock-18 | Fade" || string == "MP9 | Bulldozer" || string == "AUG | Hot Rod" || string == "Negev | Anodized Navy" || string == "Five-SeveN | Candy Apple" || string == "UMP-45 | Caramel" || string == "SG 553 | Tornado" {
        
        return Collection.TheAssaultCollection
        
    } else if string == "Tec-9 | Ossified" || string == "M4A4 | Jungle Tiger" || string == "AK-47 | Jungle Spray" || string == "SSG 08 | Lichen Dashed" || string == "Five-SeveN | Jungle" || string == "Nova | Forest Leaves" {
        
        return Collection.TheAztecCollection
        
    } else if string == "AK-47 | Jet Set" || string == "Desert Eagle | Pilot" || string == "AK-47 | First Class" || string == "Sawed-Off | First Class" || string == "USP-S | Business Class" || string == "USP-S | Business Class" || string == "XM1014 | Red Leather" || string == "P90 | Leather" || string == "MAC-10 | Commuter" || string == "P2000 | Coach Class" || string == "SG 553 | Traveler" || string == "G3SG1 | Contractor" || string == "MP7 | Olive Plaid" || string == "CZ75-Auto | Green Plaid" || string == "MP9 | Green Plaid" || string == "SSG 08 | Sand Dune" {
        
        return Collection.TheBaggageCollection
        
    } else if string == "P250 | Franklin" || string == "AK-47 | Emerald Pinstripe" || string == "CZ75-Auto | Tuxedo" || string == "Desert Eagle | Meteorite" || string == "Galil AR | Tuxedo" || string == "G3SG1 | Green Apple" || string == "Glock-18 | Death Rattle" || string == "MAC-10 | Silver" || string == "Nova | Caged Steel" || string == "UMP-45 | Carbon Fiber" || string == "MP7 | Forest DDPAT" || string == "Negev | Army Sheen" || string == "Sawed-Off | Forest DDPAT" || string == "SG 553 | Army Sheen" || string == "Tec-9 | Urban DDPAT" {
        
        return Collection.TheBankCollection
        
    } else if string == "The Bravo Collection" {
        
        return Collection.TheBravoCollection
        
    } else if string == "The Breakout Collection" {
        
        return Collection.TheBreakoutCollection
        
    } else if string == "Galil AR | Cerberus" || string == "FAMAS | Styx" || string == "Tec-9 | Toxic" || string == "Glock-18 | Reactor" || string == "XM1014 | Bone Machine" || string == "MAC-10 | Nuclear Garden" || string == "MP9 | Setting Sun" || string == "AUG | Radiation Hazard" || string == "PP-Bizon | Chemical Green" || string == "Negev | Nuclear Waste" || string == "P250 | Contamination" || string == "Five-SeveN | Hot Shot" || string == "SG 553 | Fallout Warning" {
        
        return Collection.TheCacheCollection
        
    } else if string == "Glock-18 | Twilight Galaxy" || string == "M4A1-S | Hot Rod" || string == "SG 553 | Bulldozer" || string == "Dual Berettas | Duelist" || string == "MAC-10 | Fade" || string == "P250 | Whiteout" || string == "MP7 | Full Stop" || string == "Five-SeveN | Nitro" || string == "CZ75-Auto | Emerald" || string == "Desert Eagle | Night" || string == "USP-S | Para Green" || string == "SCAR-20 | Army Sheen" || string == "CZ75-Auto | Army Sheen" || string == "M249 | Impact Drill" || string == "MAG-7 | Seabird" {
        
        return Collection.TheChopShopCollection
        
    } else if string == "The Chroma 2 Collection" {
        
        return Collection.TheChroma2Collection
        
    } else if string == "The Chroma Collection" {
        
        return Collection.TheChromaCollection
        
    } else if string == "AWP | Dragon Lore" || string == "M4A1-S | Knight" || string == "Desert Eagle | Hand Cannon" || string == "CZ75-Auto | Chalice" || string == "MP9 | Dark Age" || string == "P2000 | Chainmail" || string == "USP-S | Royal Blue" || string == "Nova | Green Apple" || string == "MAG-7 | Silver" || string == "Sawed-Off | Rust Coat" || string == "P90 | Storm" || string == "UMP-45 | Indigo" || string == "MAC-10 | Indigo" || string == "SCAR-20 | Storm" || string == "Dual Berettas | Briar" {
        
        return Collection.TheCobblestoneCollection
        
    } else if string == "P2000 | Amber Fade" || string == "SG 553 | Damascus Steel" || string == "PP-Bizon | Brass" || string == "M4A1-S | VariCamo" || string == "Sawed-Off | Snake Camo" || string == "AK-47 | Safari Mesh" || string == "Five-SeveN | Orange Peel" || string == "MAC-10 | Palm" || string == "Tec-9 | VariCamo" || string == "G3SG1 | Desert Storm" || string == "P250 | Sand Dune" || string == "SCAR-20 | Sand Mesh" || string == "P90 | Sand Spray" || string == "MP9 | Sand Dashed" || string == "Nova | Predator" {
        
        return Collection.TheDust2Collection
        
    } else if string == "Glock-18 | Brass" || string == "P2000 | Scorpion" || string == "Desert Eagle | Blaze" || string == "Sawed-Off | Copper" || string == "AUG | Copperhead" || string == "AWP | Snake Camo" || string == "AK-47 | Predator" || string == "SCAR-20 | Palm" || string == "M4A4 | Desert Storm" {
        
        return Collection.TheDustCollection
        
    } else if string == "The eSports 2013 Collection" {
        
        return Collection.TheeSports2013Collection
        
    } else if string == "The eSports 2013 Winter Collection" {
        
        return Collection.TheeSports2013WinterCollection
        
    } else if string == "The eSports 2014 Summer Collection" {
        
        return Collection.TheeSports2014SummerCollection
        
    } else if string == "The Falchion Collection"{
        
        return Collection.TheFalchionCollection
        
    } else if string == "AWP | Medusa" || string == "M4A4 | Poseidon" || string == "G3SG1 | Chronos" || string == "M4A1-S | Icarus Fell" || string == "UMP-45 | Minotaur's Labyrinth" || string == "MP9 | Pandora's Box" || string == "Tec-9 | Hades" || string == "P2000 | Pathfinder" || string == "AWP | Sun in Leo" || string == "M249 | Shipping Forecast" || string == "MP7 | Asterion" || string == "AUG | Daedalus" || string == "Dual Berettas | Moon in Libra" || string == "Nova | Moon in Libra" {
        
        return Collection.TheGodsandMonstersCollection
        
    } else if string == "TheHuntsmanCollection" {
        
        return Collection.TheHuntsmanCollection
        
    } else if string == "Tec-9 | Brass" || string == "Dual Berettas | Anodized Navy" || string == "M4A4 | Tornado" || string == "P250 | Gunsmoke" || string == "Nova | Walnut" || string == "MAG-7 | Sand Dune" {
        
        return Collection.TheInfernoCollection
        
    } else if string == "AWP | Pit Viper" || string == "Sawed-Off | Full Stop" || string == "Glock-18 | Candy Apple" || string == "MP7 | Anodized Navy" || string == "XM1014 | CaliCamo" || string == "M4A1-S | Boreal Forest" || string == "UMP-45 | Gunsmoke" || string == "P2000 | Granite Marbleized" || string == "Dual Berettas | Stained" || string == "Nova | Candy Apple" || string == "Tec-9 | Groundwater" || string == "AUG | Contractor" || string == "FAMAS | Colony" || string == "Nova | Sand Dune" || string == "PP-Bizon | Sand Dashed" {
        
        return Collection.TheItalyCollection
        
    } else if string == "Dual Berettas | Cobalt Quartz" || string == "USP-S | Night Ops" || string == "P90 | Teardown" || string == "SG 553 | Anodized Navy" || string == "Desert Eagle | Mudder" || string == "AWP | Safari Mesh" || string == "PP-Bizon | Night Ops" || string == "FAMAS | Cyanospatter" || string == "XM1014 | Blue Steel" || string == "P250 | Boreal Forest" || string == "XM1014 | Blue Spruce" || string == "AUG | Storm" || string == "Galil AR | Sage Spray" || string == "SG 553 | Waves Perforated" || string == "G3SG1 | Jungle Dashed" {
        
        return Collection.TheLakeCollection
        
    } else if string == "The Militia Collection" {
        
        return Collection.TheMilitiaCollection
        
    } else if string == "The Mirage Collection" {
        
        return Collection.TheMirageCollection
        
    } else if string == "The Nuke Collection"{
        
        return Collection.TheNukeCollection
        
    } else if string == "The Office Collection" {
        
        return Collection.TheOfficeCollection
        
    } else if string == "The Overpass Collection" {
        
        return Collection.TheOverpassCollection
        
    } else if string == "The Phoenix Collection" {
        
        return Collection.ThePhoenixCollection
        
    } else if string == "The Rising Sun Collection" {
        
        return Collection.TheRisingSunCollection
        
    } else if string == "The Safehouse Collection" {
        
        return Collection.TheSafehouseCollection
        
    } else if string == "The Shadow Collection" {
        
        return Collection.TheShadowCollection
        
    } else if string == "The Train Collection" {
        
        return Collection.TheTrainCollection
        
    } else if string == "The Vanguard Collection" {
        
        return Collection.TheVanguardCollection
        
    } else if string == "The Vertigo Collection" {
        
        return Collection.TheVertigoCollection
        
    } else if string == "The Winter Offensive Collection" {
        
        return Collection.TheWinterOffensiveCollection
        
    } else {
        
        return Collection.None
        
    }
}

enum ProfessionalPlayer {
    
    case  Allu, ApEX, AZR, B1ad3, Boltz, Bondik, Byali, Cajunb, ChrisJ, Coldzera, DavCost, Denis, Dennis, Device, Dupreeh, Edward, Emagine, Ex6TenZ, F0rest, FalleN, Fer, Flamie, Flusha, FNS, Fox, Freakazoid, Friberg, Furlan, GeTRiGhT, GobB, GruBy, GuardiaN, Happy, Havoc, Hazed, Hyper, James, Jdm64, Jks, JW, Karrigan, KennyS, KioShiMa, KRIMZ, Maikelele,  Maniac, Markeloff, N0thing, NBK, NEO, Nex, Olofmeister, PashaBiceps, Peet, Pronax, Rain, Rallen, ReltuC, Rickeh, RpK, ScreaM, Seangares, Seized, Shox, Shroud, Skadoodle, SmithZz, Snax, SnypeR, Spiidi, SPUNJ, Steel, Tarik, TaZ, USTILO, WorldEdit, Xizt, Xyp9x, Yam, Zeus, None
    
    func stringDescription() -> String {
        switch self {
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
        case .Hyper:
            return "Hyper (Bartosz Wolny)"
        case .James:
            return "James (James Quinn)"
        case .Jdm64:
            return "jdm64 (Joshua Marzano)"
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
        case .Olofmeister:
            return "olofmeister (Olof Kajbjer)"
        case .PashaBiceps:
            return "pashaBiceps (Jarosław Jarząbkowski)"
        case .Peet:
            return "peet (Piotr Ćwikliński)"
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
        case .None:
            return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
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
        case .Hyper:
            return "&category_730_ProPlayer%5B%5D=tag_hyper"
        case .James:
            return "&category_730_ProPlayer%5B%5D=tag_james"
        case .Jdm64:
            return "&category_730_ProPlayer%5B%5D=tag_jdm64"
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
        case .Olofmeister:
            return "&category_730_ProPlayer%5B%5D=tag_olofmeister"
        case .PashaBiceps:
            return "&category_730_ProPlayer%5B%5D=tag_pasha"
        case .Peet:
            return "&category_730_ProPlayer%5B%5D=tag_peet"
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
        case .None:
            return "&category_730_ProPlayer%5B%5D=any"
        }
    }
}

enum Team {
    
    case ThreeDMax, AstanaDragons, BravadoGaming, ClanMystik, Cloud9, Cloud9G2A, CompLexityGaming, CopenhagenWolves, CounterLogicGaming, DATteam, EpsilonESports, ESCGaming, Flipsid3Tactics, Fnatic, HellRaisers, IBUYPOWER, KeydStars, LGBESports, LondonConspiracy, LuminosityGaming, Mousesports, MTSGameGodWolf, myXMG, NIfaculty, NatusVincere, NinjasInPyjamas, NIPTeamA, NIPTeamB, PENTASports, PlanetkeyDynamics, ReasonGaming, Renegades, SKGaming, TeamDignitas, TeamDuncan, TeamEBettle, TeamEnVyUs, TeamImmunity, TeamKinguin, TeamLDLC, TeamSoloMid, TeamTomi, Titan, TSMKinguin, UniversalSoldiers, ValveSquadAlpha, ValveSquadBravo, VeryGames, VirtusPro, VoxEminor, WeGotGame, Xapso, None
    
    func stringDescription() -> String {
        switch self {
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
        case .VirtusPro:
            return "Virtus.Pro"
        case .VoxEminor:
            return "Vox Eminor"
        case .WeGotGame:
            return "We got game"
        case .Xapso:
            return "Xapso"
        case .None:
            return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
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
            return "&category_730_TournamentTeam%5B%5D=tag_Team16"
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
        case .VirtusPro:
            return "&category_730_TournamentTeam%5B%5D=tag_Team31"
        case .VoxEminor:
            return "&category_730_TournamentTeam%5B%5D=tag_Team32"
        case .WeGotGame:
            return "&category_730_TournamentTeam%5B%5D=tag_Team8"
        case .Xapso:
            return "&category_730_TournamentTeam%5B%5D=tag_Team15"
        case .None:
            return "&category_730_TournamentTeam%5B%5D=any"
        }
    }
}

enum Weapon {
    case AK47, AUG, AWP, Bayonet, ButterflyKnife, CZ75Auto, DesertEagle, DualBerettas, FalchionKnife, FAMAS, FiveSeveN, FlipKnife, G3SG1, GalilAR, Glock18, GutKnife, HuntsmanKnife, Karambit, M249, M4A1S, M4A4, M9Bayonet, MAC10, MAG7, MP7, MP9, Negev, Nova, P2000, P250, P90, PPBizon, SawedOff, SCAR20, SG553, ShadowDaggers, SSG08, Tec9, UMP45, USPS, XM1014, None
    
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
            return "Sawed Off"
        case .SCAR20:
            return "SCAR-20"
        case .SG553:
            return "SG553"
        case .ShadowDaggers:
            return "Shadow Daggers"
        case .SSG08:
            return "SSG08"
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
        
    } else if string.containsString("Sawed Off") {
        
        return Weapon.SawedOff
        
    } else if string.containsString("SCAR-20") {
        
        return Weapon.SCAR20
        
    } else if string.containsString("SG553") {
        
        return Weapon.SG553
        
    } else if string.containsString("Shadow Daggers") {
        
        return Weapon.ShadowDaggers
        
    } else if string.containsString("SSG08") {
        
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
        
        return Weapon.None
        
    }
}

enum Exterior {
    
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
        case .NotPainted:
            return "Not Painted"
        case .WellWorn:
            return "Well-Worn"
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
        
        return Exterior.None
        
    }
}

enum Category {
    
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
        case .None:
            return "&category_730_Quality%5B%5D=any"
        }
    }
}

func determineCategory(color: String, name: String) -> Category {
    
    if color.containsString("#CF6A32") {
        
        return Category.StatTrak™
        
    } else if color.containsString("#FFD700") {
        
        return Category.Souvenir
        
    } else if color.containsString("#8650AC") {
        
        if name.containsString("★") {
        
            if name.containsString("★ StatTrak™") {
            
                return Category.StarStatTrak™
                
            } else {
                
                return Category.Star
                
            }
        }
        
    } else if color.containsString("#D2D2D2") {
        
        return Category.Normal
        
    }

    return Category.None
}

enum Quality {
    
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
        return Quality.None
    }
    
}

enum StickerCollection {
    
    case ESLOneCologne2015PlayerAutographs, ESLOneKatowice2015Legends, ESLOneKatowice2015Challengers, DreamHack2014Legends, ESLOneCologne2014Challengers, ESLOneCologne2015Legends, CommunityStickerCapsule1, ESLOneCologne2015Challengers, EMSKatowice2014Challengers, EMSKatowice2014Legends, StickerCapsule2, StickerCapsule, ESLOneCologne2014Legends, EnfuStickerCapsule, DreamHack2014Challengers, None
    
    func stringDescription() -> String {
        switch self {
        case .CommunityStickerCapsule1:
            return "Community Sticker Capsule 1"
        case .DreamHack2014Challengers:
            return "DreamHack 2014 Challengers"
        case .DreamHack2014Legends:
            return "DreamHack 2014 Legends"
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
        case .None:
            return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
        case .CommunityStickerCapsule1:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack01"
        case .DreamHack2014Challengers:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_dhw2014_02"
        case .DreamHack2014Legends:
            return "&category_730_StickerCapsule%5B%5D=tag_crate_sticker_pack_dhw2014_01_collection"
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
        case .None:
            return "&category_730_StickerCapsule%5B%5D=any"
        }
    }
}

enum StickerCategory {
 
    case TeamLogo, PlayerAutograph, Tournament, None
    
    func stringDescription() -> String {
        switch self {
        case .PlayerAutograph:
            return "Player Autograph"
        case .TeamLogo:
            return "Team Logo"
        case .Tournament:
            return "Tournament"
        case .None:
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
        case .None:
            return "&category_730_StickerCategory%5B%5D=any"
        }
    }
}

enum Tournament {
 
    case ESLOneCologne2015, ESLOneKatowice2015, ESLOneCologne2014, EMSOneKatowice2014, DreamHackWinter2014, DreamHackWinter2013, None
    
    func stringDescription() -> String {
        switch self {
        case .DreamHackWinter2013:
            return "2013 DreamHack Winter"
        case .DreamHackWinter2014:
            return "2014 DreamHack Winter"
        case .EMSOneKatowice2014:
            return "2014 EMS One Katowice"
        case .ESLOneCologne2014:
            return "2014 ESL One Cologne"
        case .ESLOneCologne2015:
            return "2015 ESL One Colonge"
        case .ESLOneKatowice2015:
            return "2015 ESL One Katowice"
        case .None:
            return ""
        }
    }
    
    func urlArgument() -> String {
        switch self {
        case .DreamHackWinter2013:
            return "&category_730_Tournament%5B%5D=tag_Tournament1"
        case .DreamHackWinter2014:
            return "&category_730_Tournament%5B%5D=tag_Tournament5"
        case .EMSOneKatowice2014:
            return "&category_730_Tournament%5B%5D=tag_Tournament3"
        case .ESLOneCologne2014:
            return "&category_730_Tournament%5B%5D=tag_Tournament4"
        case .ESLOneCologne2015:
            return "&category_730_Tournament%5B%5D=tag_Tournament6"
        case .ESLOneKatowice2015:
            return "&category_730_Tournament%5B%5D=tag_Tournament7"
        case .None:
            return "&category_730_Tournament%5B%5D=any"
        }
    }
}

enum Type {
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
            
            return Type.None
            
        }

    
    } else {
        
        if string.containsString("Key") {
            
            return Type.Key
            
        } else if string.containsString("Case") {
         
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
            
            return Type.None
            
        }
        
    }
}

func determineSkinName(name: String!) -> String {
    
    var skinName = name
    
    if skinName.containsString("Battle-Scarred") {
        skinName = skinName.stringByReplacingOccurrencesOfString("(Battle-Scarred)", withString: "")
    } else if skinName.containsString("Factory New") {
        skinName = skinName.stringByReplacingOccurrencesOfString("(Factory New)", withString: "")
    } else if skinName.containsString("Field-Tested") {
        skinName = skinName.stringByReplacingOccurrencesOfString("(Field-Tested)", withString: "")
    } else if skinName.containsString("Minimal Wear") {
        skinName = skinName.stringByReplacingOccurrencesOfString("(Minimal Wear)", withString: "")
    } else if skinName.containsString("Well-Worn") {
        skinName = skinName.stringByReplacingOccurrencesOfString("(Well-Worn)", withString: "")
    }
    
    if skinName.containsString("StatTrak™") {
        skinName = skinName.stringByReplacingOccurrencesOfString("StatTrak™", withString: "")
    } else if skinName.containsString("Souvenir") {
        skinName = skinName.stringByReplacingOccurrencesOfString("Souvenir", withString: "")
    } else if skinName.containsString("★") {
        skinName = skinName.stringByReplacingOccurrencesOfString("★", withString: "")
    } else if skinName.containsString("★ StatTrak™") {
        skinName = skinName.stringByReplacingOccurrencesOfString("★ StatTrak™", withString: "")
    }

    return skinName
}
