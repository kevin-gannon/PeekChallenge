import UIKit

class Star: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        /// rating
        do {
            context.saveGState()
            context.translateBy(x: 0, y: 0)
            
            /// Shape
            let shape = UIBezierPath()
            shape.move(to: CGPoint(x: 19.89, y: 7.18))
            shape.addCurve(to: CGPoint(x: 18.05, y: 5.63), controlPoint1: CGPoint(x: 19.62, y: 6.35), controlPoint2: CGPoint(x: 18.91, y: 5.76))
            shape.addLine(to: CGPoint(x: 13.9, y: 5.03))
            shape.addLine(to: CGPoint(x: 12.04, y: 1.27))
            shape.addCurve(to: CGPoint(x: 10, y: 0), controlPoint1: CGPoint(x: 11.66, y: 0.49), controlPoint2: CGPoint(x: 10.87, y: 0))
            shape.addCurve(to: CGPoint(x: 10, y: 0), controlPoint1: CGPoint(x: 10, y: 0), controlPoint2: CGPoint(x: 10, y: 0))
            shape.addCurve(to: CGPoint(x: 7.95, y: 1.27), controlPoint1: CGPoint(x: 9.12, y: 0), controlPoint2: CGPoint(x: 8.34, y: 0.49))
            shape.addLine(to: CGPoint(x: 6.1, y: 5.03))
            shape.addLine(to: CGPoint(x: 1.95, y: 5.63))
            shape.addCurve(to: CGPoint(x: 0.11, y: 7.19), controlPoint1: CGPoint(x: 1.09, y: 5.76), controlPoint2: CGPoint(x: 0.38, y: 6.35))
            shape.addCurve(to: CGPoint(x: 0.69, y: 9.52), controlPoint1: CGPoint(x: -0.16, y: 8.02), controlPoint2: CGPoint(x: 0.06, y: 8.91))
            shape.addLine(to: CGPoint(x: 3.69, y: 12.45))
            shape.addLine(to: CGPoint(x: 2.99, y: 16.58))
            shape.addCurve(to: CGPoint(x: 3.89, y: 18.81), controlPoint1: CGPoint(x: 2.84, y: 17.44), controlPoint2: CGPoint(x: 3.19, y: 18.29))
            shape.addCurve(to: CGPoint(x: 5.23, y: 19.25), controlPoint1: CGPoint(x: 4.29, y: 19.1), controlPoint2: CGPoint(x: 4.76, y: 19.25))
            shape.addCurve(to: CGPoint(x: 6.29, y: 18.98), controlPoint1: CGPoint(x: 5.59, y: 19.25), controlPoint2: CGPoint(x: 5.96, y: 19.16))
            shape.addLine(to: CGPoint(x: 10, y: 17.03))
            shape.addLine(to: CGPoint(x: 13.71, y: 18.98))
            shape.addCurve(to: CGPoint(x: 16.11, y: 18.8), controlPoint1: CGPoint(x: 14.49, y: 19.39), controlPoint2: CGPoint(x: 15.41, y: 19.32))
            shape.addCurve(to: CGPoint(x: 17.02, y: 16.57), controlPoint1: CGPoint(x: 16.82, y: 18.29), controlPoint2: CGPoint(x: 17.17, y: 17.44))
            shape.addLine(to: CGPoint(x: 16.31, y: 12.44))
            shape.addLine(to: CGPoint(x: 19.31, y: 9.52))
            shape.addCurve(to: CGPoint(x: 19.89, y: 7.18), controlPoint1: CGPoint(x: 19.94, y: 8.91), controlPoint2: CGPoint(x: 20.16, y: 8.01))
            shape.close()
            shape.move(to: CGPoint(x: 14.26, y: 10.66))
            shape.addCurve(to: CGPoint(x: 13.6, y: 12.68), controlPoint1: CGPoint(x: 13.72, y: 11.19), controlPoint2: CGPoint(x: 13.48, y: 11.94))
            shape.addLine(to: CGPoint(x: 14.2, y: 16.18))
            shape.addLine(to: CGPoint(x: 11.06, y: 14.53))
            shape.addCurve(to: CGPoint(x: 8.94, y: 14.53), controlPoint1: CGPoint(x: 10.4, y: 14.18), controlPoint2: CGPoint(x: 9.6, y: 14.18))
            shape.addLine(to: CGPoint(x: 5.8, y: 16.18))
            shape.addLine(to: CGPoint(x: 6.4, y: 12.68))
            shape.addCurve(to: CGPoint(x: 5.74, y: 10.66), controlPoint1: CGPoint(x: 6.53, y: 11.94), controlPoint2: CGPoint(x: 6.28, y: 11.19))
            shape.addLine(to: CGPoint(x: 3.2, y: 8.19))
            shape.addLine(to: CGPoint(x: 6.71, y: 7.68))
            shape.addCurve(to: CGPoint(x: 8.43, y: 6.43), controlPoint1: CGPoint(x: 7.46, y: 7.57), controlPoint2: CGPoint(x: 8.1, y: 7.1))
            shape.addLine(to: CGPoint(x: 10, y: 3.25))
            shape.addLine(to: CGPoint(x: 11.57, y: 6.43))
            shape.addCurve(to: CGPoint(x: 13.29, y: 7.68), controlPoint1: CGPoint(x: 11.9, y: 7.1), controlPoint2: CGPoint(x: 12.54, y: 7.57))
            shape.addLine(to: CGPoint(x: 16.8, y: 8.19))
            shape.addLine(to: CGPoint(x: 14.26, y: 10.66))
            shape.close()
            context.saveGState()
            context.translateBy(x: 0.15, y: 0)
            UIColor.label.setFill()
            shape.fill()
            context.restoreGState()
            
            context.restoreGState()
        }
    }
}
