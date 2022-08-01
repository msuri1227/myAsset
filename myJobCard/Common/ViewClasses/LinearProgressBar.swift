//
//  LinearProgressBar.swift
//  LinearProgressBar
//
//  Created by Eliel Gordon on 11/13/15.
//  Copyright © 2015 Eliel Gordon. All rights reserved.
//

import UIKit
import mJCLib

/// Draws a progress bar
@IBDesignable
open class LinearProgressBar: UIView {
    
    /// The color of the progress bar
    @IBInspectable public var barColor: UIColor = UIColor.green
    /// The color of the base layer of the bar
    @IBInspectable public var trackColor: UIColor = UIColor.yellow
    /// The thickness of the bar
    @IBInspectable public var barThickness: CGFloat = 0
    /// Padding on the left, right, top and bottom of the bar, in relation to the track of the progress bar
    @IBInspectable public var barPadding: CGFloat = 0
    
    /// Padding on the track on the progress bar
    @IBInspectable public var trackPadding: CGFloat = 6 {
        didSet {
            if trackPadding < 0 {
                trackPadding = 0
            }else if trackPadding > barThickness {
                trackPadding = 0
            }
        }
    }
    
    @IBInspectable public var progressValue: CGFloat = 0 {
        didSet {
            progressValue = progressValue.clamped(lowerBound: 0, upperBound: 100)
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var capType: Int32 = 0 {
        didSet {
            
        }
    }
    
    open var barColorForValue: ((Float)->UIColor)?
    
    fileprivate var trackHeight: CGFloat {
        return barThickness + trackPadding
    }
        
    fileprivate var trackOffset: CGFloat {
        return trackHeight / 2
    }
        
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
        
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        mJCLogger.log("Starting", Type: "info")
        drawProgressView()
        mJCLogger.log("Ended", Type: "info")
    }
    
    /// Draws a line representing the progress bar
    ///
    /// - Parameters:
    ///   - context: context to be mutated
    ///   - lineWidth: width of track or bar
    ///   - begin: point to begin drawing
    ///   - end: point to end drawing
    ///   - lineCap: lineCap style
    ///   - strokeColor: color of bar
    func drawOn(context: CGContext, lineWidth: CGFloat, begin: CGPoint, end: CGPoint, lineCap: CGLineCap, strokeColor: UIColor) {
        mJCLogger.log("Starting", Type: "info")
        context.setStrokeColor(strokeColor.cgColor)
        context.beginPath()
        context.setLineWidth(lineWidth)
        context.move(to: begin)
        context.addLine(to: end)
        context.setLineCap(lineCap)
        context.strokePath()
        mJCLogger.log("Ended", Type: "info")
    }

    func drawProgressView() {
        mJCLogger.log("Starting", Type: "info")
        guard let context = UIGraphicsGetCurrentContext()
            else { return }
        
        let beginPoint = CGPoint(
            x: barPadding + trackOffset,
            y: frame.size.height / 2
        )
        
        // Progress Bar Track
        drawOn(
            context: context,
            lineWidth: barThickness + trackPadding,
            begin: beginPoint,
            end: CGPoint(x: frame.size.width - barPadding - trackOffset, y: frame.size.height / 2),
            lineCap: CGLineCap(rawValue: capType) ?? .round,
            strokeColor: trackColor
        )
        
        // Progress bar
        let colorForBar = barColorForValue?(Float(progressValue)) ?? barColor
        let barLineWidth = calculatePercentage() > 0 ? barThickness : 0
        
        drawOn(
            context: context,
            lineWidth: barLineWidth,
            begin: beginPoint,
            end: CGPoint(x: barPadding + trackOffset + calculatePercentage(), y: frame.size.height / 2),
            lineCap: CGLineCap(rawValue: capType) ?? .round,
            strokeColor: colorForBar
        )
        mJCLogger.log("Ended", Type: "info")
    }
    
    /// Clear graphics context and redraw on bounds change
    func setup() {
        mJCLogger.log("Starting", Type: "info")
        clearsContextBeforeDrawing = true
        self.contentMode = .redraw
        clipsToBounds = false
        mJCLogger.log("Ended", Type: "info")
    }
    
    /// Calculates the percent value of the progress bar
    ///
    /// - Returns: The percentage of progress
    func calculatePercentage() -> CGFloat {
        mJCLogger.log("Starting", Type: "info")
        let screenWidth = frame.size.width - (barPadding * 2) - (trackOffset * 2)
        let progress = ((progressValue / 100) * screenWidth)
        mJCLogger.log("Ended", Type: "info")
        return progress < 0 ? barPadding : progress
    }
}
