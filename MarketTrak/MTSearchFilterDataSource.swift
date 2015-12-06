//
//  MTSearchFilterDataSource.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 12/6/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

extension Array {
    
    mutating func removeObject<T: Equatable>(object: T) -> Bool {
        var index: Int?
        for (idx, objectToCompare) in self.enumerate() {
            
            if let toCompare = objectToCompare as? T {
                if toCompare == object {
                    index = idx
                    break
                }
            }
        }
        
        if(index != nil) {
            self.removeAtIndex(index!)
            return true
        } else {
            return false
        }
    }
    
    func containsObject(object: Any) -> Bool
    {
        if let anObject: AnyObject = object as? AnyObject
        {
            for obj in self
            {
                if let anObj: AnyObject = obj as? AnyObject
                {
                    if anObj === anObject { return true }
                }
            }
        }
        return false
    }
}

class MTSearchFilterDataSource {
    
    var searchFilters: [[Any]]! = []
    var displayedSearchFilters: [[Any]]! = []
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
                
                searchFilters.append(collections)
                
            case 1:
                
                var playerValues: [ProfessionalPlayer] = ProfessionalPlayer.allValues()
                var players: [Any]! = []
                for pla in 0..<playerValues.count {
                    players.append(playerValues[pla] as ProfessionalPlayer)
                }
                
                searchFilters.append(players)
                
            case 2:
                
                var teamValues: [Team] = Team.allValues()
                var teams: [Any]! = []
                for tea in 0..<teamValues.count {
                    teams.append(teamValues[tea] as Team)
                }
                
                searchFilters.append(teams)
                
            case 3:
                
                var weaponValues: [Weapon] = Weapon.allValues()
                var weapons: [Any]! = []
                for wea in 0..<weaponValues.count {
                    weapons.append(weaponValues[wea] as Weapon)
                }
                
                searchFilters.append(weapons)
                
            case 4:
                
                var exteriorValues: [Exterior] = Exterior.allValues()
                var exterior: [Any]! = []
                for ext in 0..<exteriorValues.count {
                    exterior.append(exteriorValues[ext] as Exterior)
                }
                
                searchFilters.append(exterior)
                
            case 5:
                
                var categoryValues: [Category] = Category.allValues()
                var category: [Any]! = []
                for cat in 0..<categoryValues.count {
                    category.append(categoryValues[cat] as Category)
                }
                
                searchFilters.append(category)
                
            case 6:
                
                var qualityValues: [Quality] = Quality.allValues()
                var quality: [Any]! = []
                for qua in 0..<qualityValues.count {
                    quality.append(qualityValues[qua] as Quality)
                }
                
                searchFilters.append(quality)
                
            case 7:
                
                var stickerCollectionValues: [StickerCollection] = StickerCollection.allValues()
                var stickerCollection: [Any]! = []
                for stiCo in 0..<stickerCollectionValues.count {
                    stickerCollection.append(stickerCollectionValues[stiCo] as StickerCollection)
                }
                
                searchFilters.append(stickerCollection)
                
            case 8:
                
                var stickerCategoryValues: [StickerCategory] = StickerCategory.allValues()
                var stickerCategory: [Any]! = []
                for stiCa in 0..<stickerCategoryValues.count {
                    stickerCategory.append(stickerCategoryValues[stiCa] as StickerCategory)
                }
                
                searchFilters.append(stickerCategory)
                
            case 9:
                
                var tournamentValues: [Tournament] = Tournament.allValues()
                var tournament: [Any]! = []
                for tou in 0..<tournamentValues.count {
                    tournament.append(tournamentValues[tou] as Tournament)
                }
                
                searchFilters.append(tournament)
                
            case 10:
                
                var typeValues: [Type] = Type.allValues()
                var type: [Any]! = []
                for typ in 0..<typeValues.count {
                    type.append(typeValues[typ] as Type)
                }
                
                searchFilters.append(type)
                
            default:
                
                searchFilters.append([])
            }
        }
    
        displayedSearchFilters = searchFilters
    }

    func addFilter(section: Int, row: Int) {
        
        switch section {
        case 0:
            currentFilters.append(displayedSearchFilters[section][row] as! Collection)
        case 1:
            currentFilters.append(displayedSearchFilters[section][row] as! ProfessionalPlayer)
        case 2:
            currentFilters.append(displayedSearchFilters[section][row] as! Team)
        case 3:
            currentFilters.append(displayedSearchFilters[section][row] as! Weapon)
        case 4:
            currentFilters.append(displayedSearchFilters[section][row] as! Exterior)
        case 5:
            currentFilters.append(displayedSearchFilters[section][row] as! Category)
        case 6:
            currentFilters.append(displayedSearchFilters[section][row] as! Quality)
        case 7:
            currentFilters.append(displayedSearchFilters[section][row] as! StickerCollection)
        case 8:
            currentFilters.append(displayedSearchFilters[section][row] as! StickerCategory)
        case 9:
            currentFilters.append(displayedSearchFilters[section][row] as! Tournament)
        case 10:
            currentFilters.append(displayedSearchFilters[section][row] as! Type)
        default:
            ""
        }
    }

    func removeFilter(section: Int, row: Int) {
        
        switch section {
        case 0:
            currentFilters.removeObject(displayedSearchFilters[section][row] as! Collection)
        case 1:
            currentFilters.removeObject(displayedSearchFilters[section][row] as! ProfessionalPlayer)
        case 2:
            currentFilters.removeObject(displayedSearchFilters[section][row] as! Team)
        case 3:
            currentFilters.removeObject(displayedSearchFilters[section][row] as! Weapon)
        case 4:
            currentFilters.removeObject(displayedSearchFilters[section][row] as! Exterior)
        case 5:
            currentFilters.removeObject(displayedSearchFilters[section][row] as! Category)
        case 6:
            currentFilters.removeObject(displayedSearchFilters[section][row] as! Quality)
        case 7:
            currentFilters.removeObject(displayedSearchFilters[section][row] as! StickerCollection)
        case 8:
            currentFilters.removeObject(displayedSearchFilters[section][row] as! StickerCategory)
        case 9:
            currentFilters.removeObject(displayedSearchFilters[section][row] as! Tournament)
        case 10:
            currentFilters.removeObject(displayedSearchFilters[section][row] as! Type)
        default:
            ""
        }
    }
    
    func descriptionForFilterInSection(section: Int, row: Int) -> String? {
        
        var description: String! = ""
        
        switch section {
        case 0:
            description = (displayedSearchFilters[section][row] as! Collection).stringDescription()
        case 1:
            description = (displayedSearchFilters[section][row] as! ProfessionalPlayer).stringDescription()
        case 2:
            description = (displayedSearchFilters[section][row] as! Team).stringDescription()
        case 3:
            description = (displayedSearchFilters[section][row] as! Weapon).stringDescription()
        case 4:
            description = (displayedSearchFilters[section][row] as! Exterior).stringDescription()
        case 5:
            description = (displayedSearchFilters[section][row] as! Category).stringDescription()
        case 6:
            description = (displayedSearchFilters[section][row] as! Quality).stringDescription()
        case 7:
            description = (displayedSearchFilters[section][row] as! StickerCollection).stringDescription()
        case 8:
            description = (displayedSearchFilters[section][row] as! StickerCategory).stringDescription()
        case 9:
            description = (displayedSearchFilters[section][row] as! Tournament).stringDescription()
        case 10:
            description = (displayedSearchFilters[section][row] as! Type).stringDescription()
        default:
            return nil
        }
        
        return description
    }
    
    func resetDisplayedSearchFilters() {
        displayedSearchFilters = searchFilters
    }
    
    func filterDataSourceForString(inputString: String) {
        for i in 0..<searchFilters.count {
            displayedSearchFilters[i] = searchFilters[i].filter {
                
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
    
    func filterHasBeenAdded(section: Int, row: Int) -> Bool {
        
        if displayedSearchFilters[section][row] is Collection {
      
            return currentFilters.contains { $0 as? Collection == displayedSearchFilters[section][row] as? Collection}
        
        } else if displayedSearchFilters[section][row] is ProfessionalPlayer {
        
            return currentFilters.contains { $0 as? ProfessionalPlayer == displayedSearchFilters[section][row] as? ProfessionalPlayer}
        
        } else if displayedSearchFilters[section][row] is Team {
       
            return currentFilters.contains { $0 as? Team == displayedSearchFilters[section][row] as? Team}
        
        } else if displayedSearchFilters[section][row] is Weapon {
       
            return currentFilters.contains { $0 as? Weapon == displayedSearchFilters[section][row] as? Weapon}
        
        } else if displayedSearchFilters[section][row] is Exterior {
        
            return currentFilters.contains { $0 as? Exterior == displayedSearchFilters[section][row] as? Exterior}
        
        } else if displayedSearchFilters[section][row] is Category {
       
            return currentFilters.contains { $0 as? Category == displayedSearchFilters[section][row] as? Category}
        
        } else if displayedSearchFilters[section][row] is Quality {
            
            return currentFilters.contains { $0 as? Quality == displayedSearchFilters[section][row] as? Quality}
            
        } else if displayedSearchFilters[section][row] is StickerCollection {
            
            return currentFilters.contains { $0 as? StickerCollection == displayedSearchFilters[section][row] as? StickerCollection}
            
        } else if displayedSearchFilters[section][row] is StickerCategory {
            
            return currentFilters.contains { $0 as? StickerCategory == displayedSearchFilters[section][row] as? StickerCategory}
            
        } else if displayedSearchFilters[section][row] is Tournament {
            
            return currentFilters.contains { $0 as? Tournament == displayedSearchFilters[section][row] as? Tournament}
            
        } else if displayedSearchFilters[section][row] is Type {
            
            return currentFilters.contains { $0 as? Type == displayedSearchFilters[section][row] as? Type}
    
        } else {
        
            return false
        }
    }
}
