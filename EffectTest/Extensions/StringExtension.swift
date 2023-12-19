//
//  ExtensionString.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/18/23.
//

import Foundation

extension String {
    func countdownEnding(_ id: Int) -> String {
        switch id {
        case 1: return "Первый"
        case 2: return "Второй"
        case 3: return "Третий"
        case 4: return "Четвертый"
        case 5: return "Пятый"
        case 6: return "Шестой"
        case 7: return "Седьмой"
        case 8: return "Восьмой"
        case 9: return "Девятый"
        case 10: return "Десятый"
        default:
            return "\(id)"
        }
    }
    
    func sum(_ first: Int?, _ second: Int?,_ thirty: Int?) -> String {
        if let first, let second, let thirty {
            let sum = "\(first + second + thirty)"
            return sum.prefix(3) + "," + sum.suffix(3)
        } else {
            return ""
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        var result = email.range(
            of: emailPattern,
            options: .regularExpression
        )
        
        return result != nil
    }
}
