import Foundation

struct HomeModel {
    private static let bestScoreKey = "bestScoreKey"
    
    
    
    static func loadBestScore() -> Int? {
        //todo
        //mock
        UserDefaults.standard.set(100500, forKey: bestScoreKey)
        //
        
        let value = UserDefaults.standard.value(forKey: bestScoreKey) as? Int
        return value
    }
    
    static func hasUnfinishedGame() -> Bool {
        // todo
        return false
    }
    
}
