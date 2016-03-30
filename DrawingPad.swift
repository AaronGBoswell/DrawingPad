//
//  DrawingPad.swift
//
//
//  Created by Aaron Boswell on 3/25/16.
//
//

import UIKit
import QuartzCore

public class DrawingPad {
    
    /**
     This block of code gets runs 60 times per second.
     */
    public var redraw = { }{
        didSet{
            runClosure()
        }
    }
    
    /**
     The view that is drawn on.
     */
    public let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    
    /**
        Color drawn inside the shape.
     */
    public var fillColor:UIColor = UIColor.clearColor()
    
    /**
        Color of the border of the shape.
     */
    public var strokeColor:UIColor = UIColor.blackColor()
    
    /**
        Size of the text.
     */
    public var textSize = 20;
    
    /**
        Backround color of the DrawingPad.
     */
    public var backroundColor:UIColor{
        get{
            return view.backgroundColor!
        }
        set{
            view.backgroundColor = newValue
        }
    }
    /**
        Width of the border of the shape.
     */
    public var strokeWidth = 1

    public init(){
        
    }
    
    func runClosure(){
        redraw();
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1/60 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue())  {
            self.runClosure()
        }
    }
    
    /**
     Erases all things drawn on the DrawingPad.
     */
    public func eraseAll(){
        view.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
    }
    
    /**
     Draws an ellispe at (x,y) with width and height with the current settings.
     
     - Parameters:
        - x: The x coordinate of top left corner of the ellipse.
        - y: The y coordinate of top left corner of the ellipse.
        - width: The width of the ellipse.
        - height: The height of the ellipse.
     */
    public func drawEllipse(x x:Int, y:Int,width:Int,height:Int){
        let path = UIBezierPath(ovalInRect: CGRect(x: x, y: y, width: width, height: height))
        addShapeViewWithPreparedPath(path)
    }
    
    
    /**
     Draws a rectangle at (x,y) with width and height with the current settings.
     
     - Parameters:
        - x: The x coordinate of top left corner of the rectangle.
        - y: The y coordinate of top left corner of the rectangle.
        - width: The width of the rectangle.
        - height: The height of the rectangle.
     */
    public func drawRectangle(x x:Int, y:Int,width:Int,height:Int){
        let path = UIBezierPath(rect: CGRect(x: x, y: y, width: width, height: height))
        addShapeViewWithPreparedPath(path)
    }
    
    /**
     Draws a line from (x1,y1) to (x2,y2) with the current settings.
     
     - Parameters:
        - x1: The x coordinate of the first end of the line.
        - y1: The y coordinate of the first end of the line.
        - x2: The x coordinate of the second end of the line.
        - y2: The y coordinate of the second end of the line.
     */
    public func drawLine(x1 x1:Int, y1:Int, x2:Int, y2:Int){
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: x1, y: y1))
        path.addLineToPoint(CGPoint(x: x2, y: y2))
        addShapeViewWithPreparedPath(path)

    }
    
    /**
     Draws a text at (x,y).
     
     - Parameters:
        - text: The text that is drawn.
        - x: The x coordinate of top left corner of the rectangle.
        - y: The y coordinate of top left corner of the rectangle.
     */
    public func drawText(text text:String, x:Int, y:Int){
        let textLabel = CATextLayer()
        textLabel.string = text
        textLabel.foregroundColor = strokeColor.CGColor
        textLabel.fontSize = CGFloat(textSize)
        
        textLabel.font = "Arial"
        textLabel.alignmentMode = kCAAlignmentCenter
        textLabel.frame = view.frame

        textLabel.contentsScale = UIScreen.mainScreen().scale
        
        view.layer.addSublayer(textLabel)
    }
    
    func addShapeViewWithPreparedPath(path:UIBezierPath){
        
        let shapeView = CAShapeLayer()
        shapeView.path = path.CGPath
        shapeView.strokeColor = strokeColor.CGColor
        shapeView.fillColor = fillColor.CGColor
        shapeView.lineWidth = CGFloat(strokeWidth)
        
        view.layer.addSublayer(shapeView)
    }

    
}
