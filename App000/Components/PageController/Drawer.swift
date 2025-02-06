//
//  Drawer.swift
//  App000
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import UIKit

public protocol AdvancedPageControlDraw {
    var currentItem: CGFloat { get set }
    var size: CGFloat { get set }

    var numberOfPages: Int { get set }
    func draw(_ rect: CGRect)
}

public class AdvancedPageControlDrawerParentWithIndicator: AdvancedPageControlDrawerParent {
    var indicatorBorderColor: UIColor
    var indicatorBorderWidth: CGFloat
    var indicatorColor: UIColor
    public init(numberOfPages: Int? = 5,
                height: CGFloat? = 16,
                width: CGFloat? = 16,
                space: CGFloat? = 16,
                raduis: CGFloat? = 8,
                currentItem: CGFloat? = 0,
                indicatorColor: UIColor? = .white,
                dotsColor: UIColor? = UIColor.lightGray,
                isBordered: Bool = false,
                borderColor: UIColor = .white,
                borderWidth: CGFloat = 1,
                indicatorBorderColor: UIColor = .white,
                indicatorBorderWidth: CGFloat = 2) {
        self.indicatorBorderColor = indicatorBorderColor
        self.indicatorBorderWidth = indicatorBorderWidth
        self.indicatorColor = indicatorColor!
        super.init(numberOfPages: numberOfPages,
                   height: height,
                   width: width,
                   space: space,
                   raduis: raduis,
                   currentItem: currentItem,
                   dotsColor: dotsColor,
                   isBordered: isBordered,
                   borderColor: borderColor,
                   borderWidth: borderWidth)
    }
}

public class AdvancedPageControlDrawerParent {
    public var numberOfPages: Int
       public var size: CGFloat
       public var currentItem: CGFloat
       public var items = [Int]()
       var width: CGFloat
       var space: CGFloat
       var radius: CGFloat
       var dotsColor: UIColor
       var isBordered: Bool
       var borderColor: UIColor
       var borderWidth: CGFloat

       public init(numberOfPages: Int? = 3,
                   height: CGFloat? = 8,
                   width: CGFloat? = 8,
                   space: CGFloat? = 16,
                   raduis: CGFloat? = 16,
                   currentItem: CGFloat? = 0,
                   dotsColor: UIColor? = UIColor.lightGray,
                   isBordered: Bool = false,
                   borderColor: UIColor = .white,
                   borderWidth: CGFloat = 1)
       {
           self.numberOfPages = numberOfPages!
           self.space = space!
           radius = raduis!
           self.currentItem = currentItem!
           self.dotsColor = dotsColor!
           self.width = width!
           size = height!
           self.isBordered = isBordered
           self.borderColor = borderColor
           self.borderWidth = borderWidth
       }

    func getScaleFactor(currentItem: CGFloat, ratio: CGFloat) -> CGFloat {
        let scale = currentItem - floor(currentItem)
        let scaleFactor = (scale > 0.5 ? 0.5 - (scale - 0.5) : scale) * ratio
        return scaleFactor
    }

    func getCenteredXPosition(_ rect: CGRect, itemPos: CGFloat, dotSize: CGFloat, space: CGFloat, numberOfPages: Int) -> CGFloat {
        let individualDotPos = (itemPos * (dotSize + space))
        let halfViewWidth = (rect.width / 2)
        let halfAlldotsWidthWithSpaces = ((CGFloat(numberOfPages) * (dotSize + (space - 1))) / 2.0)
        return individualDotPos - halfAlldotsWidthWithSpaces + halfViewWidth
    }

    func getCenteredYPosition(_ rect: CGRect, dotSize: CGFloat) -> CGFloat {
        let halfViewHeight = (rect.size.height / 2)
        let halfDotSize = (dotSize / 2)
        let centeredYPosition = halfViewHeight - halfDotSize
        return centeredYPosition
    }

    func drawItem(_ rect: CGRect, raduis: CGFloat, color: UIColor, borderWidth: CGFloat = 0, borderColor: UIColor = .clear, index _: Int = 0) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: raduis)
        path.lineWidth = borderWidth
        borderColor.setStroke()
        path.stroke()
        color.setFill()
        path.fill()
    }
}

public class ExtendedDotDrawer: AdvancedPageControlDrawerParentWithIndicator, AdvancedPageControlDraw {
    public func draw(_ rect: CGRect) {
        drawIndicators(rect)
    }

    func drawIndicators(_ rect: CGRect) {
        for i in 0 ..< numberOfPages {
            let dotColor: UIColor
            
            if i <= Int(currentItem) {
                dotColor = indicatorColor
            } else {
                dotColor = dotsColor
            }

            let centeredYPosition = getCenteredYPosition(rect, dotSize: size)
            let y = rect.origin.y + centeredYPosition
            let x = getCenteredXPosition(rect, itemPos: CGFloat(i), dotSize: width, space: space, numberOfPages: numberOfPages)
            
            drawItem(CGRect(x: rect.origin.x + x, y: y, width: width, height: size),
                     raduis: radius,
                     color: dotColor,
                     borderWidth: isBordered ? borderWidth : 0,
                     borderColor: borderColor)
        }
    }
}
