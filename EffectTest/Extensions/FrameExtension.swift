//
//  CGFloatExtension.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/16/23.
//
import Foundation
import SwiftUI

extension View {
    func layout(_ cgfloat: Double, width: Bool) ->  CGFloat {
        width ? UIScreen.main.bounds.width * (cgfloat / 375) : UIScreen.main.bounds.height * (cgfloat / 812)
    }
    
    @inline(__always) func frameCustom(width: Double? = nil, height: Double? = nil, alignment: Alignment? = nil) -> some View {
        modifier(FrameModifier(width: width, height: height, alignment: alignment))
    }
}

struct FrameModifier: ViewModifier {
    var width: Double?
    var height: Double?
    var alignment: Alignment?
    
    init(width: Double? = nil, height: Double? = nil, alignment: Alignment? = nil) {
        self.width = width
        self.height = height
        self.alignment = alignment
    }
    
    func body(content: Content) -> some View {
        if let alignment {
            if let width, let height {
                return content.frame(
                    width: UIScreen.main.bounds.width * (width / 375),
                    height: UIScreen.main.bounds.height * (height / 812),
                    alignment: alignment
                )
            }
            else if let height {
                return content.frame(
                    width: UIScreen.main.bounds.width * (height / 375),
                    alignment: alignment
                )
            }
            else {
                return content.frame(
                    width: UIScreen.main.bounds.width * (width! / 375),
                    alignment: alignment
                )
            }
        }
        else {
            if let width, let height {
                return content.frame(
                    width: UIScreen.main.bounds.width * (width / 375),
                    height: UIScreen.main.bounds.height * (height / 812)
                )
            }
            else if let height {
                return content.frame(
                    width: UIScreen.main.bounds.width * (height / 375)
                )
            }
            else {
                return content.frame(
                    width: UIScreen.main.bounds.width * (width! / 375)
                )
            }
        }
    }
}
