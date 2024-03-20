import Foundation

extension Date {
    
    public var components: DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .weekday, .second, .minute, .hour], from: self)
        return components
    }
    
}
