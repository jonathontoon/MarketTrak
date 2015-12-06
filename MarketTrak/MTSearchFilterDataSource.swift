//
//  MTSearchFilterDataSource.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 12/6/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTSearchFilterDataSource {
    
    var searchFiltersMaster: [[Any]]! = []
    var currentSearchFilters: [[Any]]! = []
    var currentFilters: [Any]! = []
    
    init() {
        
        for i in 0...10 {
            switch i {
            case 0:
                
                var collectionValues: [Collection] = Collection.allValues()
                var collections: [Any]! = []
                for col in 0..<collectionValues.count {
                    collections.append(collectionValues[col] as Collection)
                }
                
                searchFiltersMaster.append(collections)
                
            case 1:
                
                var playerValues: [ProfessionalPlayer] = ProfessionalPlayer.allValues()
                var players: [Any]! = []
                for pla in 0..<playerValues.count {
                    players.append(playerValues[pla] as ProfessionalPlayer)
                }
                
                searchFiltersMaster.append(players)
                
            case 2:
                
                var teamValues: [Team] = Team.allValues()
                var teams: [Any]! = []
                for tea in 0..<teamValues.count {
                    teams.append(teamValues[tea] as Team)
                }
                
                searchFiltersMaster.append(teams)
                
            case 3:
                
                var weaponValues: [Weapon] = Weapon.allValues()
                var weapons: [Any]! = []
                for wea in 0..<weaponValues.count {
                    weapons.append(weaponValues[wea] as Weapon)
                }
                
                searchFiltersMaster.append(weapons)
                
            case 4:
                
                var exteriorValues: [Exterior] = Exterior.allValues()
                var exterior: [Any]! = []
                for ext in 0..<exteriorValues.count {
                    exterior.append(exteriorValues[ext] as Exterior)
                }
                
                searchFiltersMaster.append(exterior)
                
            case 5:
                
                var categoryValues: [Category] = Category.allValues()
                var category: [Any]! = []
                for cat in 0..<categoryValues.count {
                    category.append(categoryValues[cat] as Category)
                }
                
                searchFiltersMaster.append(category)
                
            case 6:
                
                var qualityValues: [Quality] = Quality.allValues()
                var quality: [Any]! = []
                for qua in 0..<qualityValues.count {
                    quality.append(qualityValues[qua] as Quality)
                }
                
                searchFiltersMaster.append(quality)
                
            case 7:
                
                var stickerCollectionValues: [StickerCollection] = StickerCollection.allValues()
                var stickerCollection: [Any]! = []
                for stiCo in 0..<stickerCollectionValues.count {
                    stickerCollection.append(stickerCollectionValues[stiCo] as StickerCollection)
                }
                
                searchFiltersMaster.append(stickerCollection)
                
            case 8:
                
                var stickerCategoryValues: [StickerCategory] = StickerCategory.allValues()
                var stickerCategory: [Any]! = []
                for stiCa in 0..<stickerCategoryValues.count {
                    stickerCategory.append(stickerCategoryValues[stiCa] as StickerCategory)
                }
                
                searchFiltersMaster.append(stickerCategory)
                
            case 9:
                
                var tournamentValues: [Tournament] = Tournament.allValues()
                var tournament: [Any]! = []
                for tou in 0..<tournamentValues.count {
                    tournament.append(tournamentValues[tou] as Tournament)
                }
                
                searchFiltersMaster.append(tournament)
                
            case 10:
                
                var typeValues: [Type] = Type.allValues()
                var type: [Any]! = []
                for typ in 0..<typeValues.count {
                    type.append(typeValues[typ] as Type)
                }
                
                searchFiltersMaster.append(type)
                
            default:
                
                searchFiltersMaster.append([])
            }
        }
    
        currentSearchFilters = searchFiltersMaster
    }

    func addItemToFilter(section: Int, row: Int) {
        
        switch section {
        case 0:
            currentFilters.append(currentSearchFilters[section][row] as! Collection)
        case 1:
            currentFilters.append(currentSearchFilters[section][row] as! ProfessionalPlayer)
        case 2:
            currentFilters.append(currentSearchFilters[section][row] as! Team)
        case 3:
            currentFilters.append(currentSearchFilters[section][row] as! Weapon)
        case 4:
            currentFilters.append(currentSearchFilters[section][row] as! Exterior)
        case 5:
            currentFilters.append(currentSearchFilters[section][row] as! Category)
        case 6:
            currentFilters.append(currentSearchFilters[section][row] as! Quality)
        case 7:
            currentFilters.append(currentSearchFilters[section][row] as! StickerCollection)
        case 8:
            currentFilters.append(currentSearchFilters[section][row] as! StickerCategory)
        case 9:
            currentFilters.append(currentSearchFilters[section][row] as! Tournament)
        case 10:
            currentFilters.append(currentSearchFilters[section][row] as! Type)
        default:
            ""
        }
    }
    
    func descriptionForItemInSection(section: Int, row: Int) -> String? {
        
        var description: String! = ""
        
        switch section {
        case 0:
            description = (currentSearchFilters[section][row] as! Collection).stringDescription()
        case 1:
            description = (currentSearchFilters[section][row] as! ProfessionalPlayer).stringDescription()
        case 2:
            description = (currentSearchFilters[section][row] as! Team).stringDescription()
        case 3:
            description = (currentSearchFilters[section][row] as! Weapon).stringDescription()
        case 4:
            description = (currentSearchFilters[section][row] as! Exterior).stringDescription()
        case 5:
            description = (currentSearchFilters[section][row] as! Category).stringDescription()
        case 6:
            description = (currentSearchFilters[section][row] as! Quality).stringDescription()
        case 7:
            description = (currentSearchFilters[section][row] as! StickerCollection).stringDescription()
        case 8:
            description = (currentSearchFilters[section][row] as! StickerCategory).stringDescription()
        case 9:
            description = (currentSearchFilters[section][row] as! Tournament).stringDescription()
        case 10:
            description = (currentSearchFilters[section][row] as! Type).stringDescription()
        default:
            return nil
        }
        
        return description
    }
    
    func resetCurrentSearchFilters() {
        currentSearchFilters = searchFiltersMaster
    }
    
    func filterDataSourceForString(inputString: String) {
        for i in 0..<searchFiltersMaster.count {
            currentSearchFilters[i] = searchFiltersMaster[i].filter {
                
                switch i {
                    case 0:
                        return ($0 as! Collection).stringDescription().lowercaseString.rangeOfString(inputString.lowercaseString) != nil
                    case 1:
                        return ($0 as! ProfessionalPlayer).stringDescription().lowercaseString.rangeOfString(inputString.lowercaseString) != nil
                    case 2:
                        return ($0 as! Team).stringDescription().lowercaseString.rangeOfString(inputString.lowercaseString) != nil
                    case 3:
                        return ($0 as! Weapon).stringDescription().lowercaseString.rangeOfString(inputString.lowercaseString) != nil
                    case 4:
                        return ($0 as! Exterior).stringDescription().lowercaseString.rangeOfString(inputString.lowercaseString) != nil
                    case 5:
                        return ($0 as! Category).stringDescription().lowercaseString.rangeOfString(inputString.lowercaseString) != nil
                    case 6:
                        return ($0 as! Quality).stringDescription().lowercaseString.rangeOfString(inputString.lowercaseString) != nil
                    case 7:
                        return ($0 as! StickerCollection).stringDescription().lowercaseString.rangeOfString(inputString.lowercaseString) != nil
                    case 8:
                        return ($0 as! StickerCategory).stringDescription().lowercaseString.rangeOfString(inputString.lowercaseString) != nil
                    case 9:
                        return ($0 as! Tournament).stringDescription().lowercaseString.rangeOfString(inputString.lowercaseString) != nil
                    case 10:
                        return ($0 as! Type).stringDescription().lowercaseString.rangeOfString(inputString.lowercaseString) != nil
                    default:
                        print("filterDataSourceForString no match")
                    return false
                }
            }
        }
    }
}
