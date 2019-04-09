//
//  UIBezierPath+HeFengPath.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "UIBezierPath+HeFengPath.h"
#import <objc/runtime.h>

@implementation UIBezierPath (HeFengPath)

- (void)setContractionFactor:(CGFloat)contractionFactor
{
    objc_setAssociatedObject(self, @selector(contractionFactor), @(contractionFactor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)contractionFactor
{
    id contractionFactorAssociatedObject = objc_getAssociatedObject(self, @selector(contractionFactor));
    if (contractionFactorAssociatedObject == nil) {
        return 0.7;
    }
    return [contractionFactorAssociatedObject floatValue];
}

- (void)addBezierThroughPoints:(NSArray *)pointArray
{
    if (pointArray.count == 0)
    {
        return;
    }
    NSAssert(pointArray.count > 0, @"You must give at least 1 point for drawing the curve.");
    
    if (pointArray.count < 3) {
        switch (pointArray.count) {
                case 1:
            {
                NSString * point0Value = pointArray[0];
                CGPoint point0 = CGPointFromString(point0Value);
                [self addLineToPoint:point0];
            }
                break;
                case 2:
            {
                NSString * point0Value = pointArray[0];
                CGPoint point0 = CGPointFromString(point0Value);
                NSString * point1Value = pointArray[1];
                CGPoint point1 = CGPointFromString(point1Value);
                [self addQuadCurveToPoint:point1 controlPoint:ControlPointForTheBezierCanThrough3Point(self.currentPoint, point0, point1)];
            }
                break;
            default:
                break;
        }
    }
    
    CGPoint previousPoint = CGPointZero;
    
    CGPoint previousCenterPoint = CGPointZero;
    CGPoint centerPoint = CGPointZero;
    CGFloat centerPointDistance = 0;
    
    CGFloat obliqueAngle = 0;
    
    CGPoint previousControlPoint1 = CGPointZero;
    CGPoint previousControlPoint2 = CGPointZero;
    CGPoint controlPoint1 = CGPointZero;
    
    previousPoint = self.currentPoint;
    
    for (int i = 0; i < pointArray.count; i++) {
        
        NSString * pointIValue = pointArray[i];
        CGPoint pointI = CGPointFromString(pointIValue);
        
        if (i > 0) {
            
            previousCenterPoint = CenterPointOf(self.currentPoint, previousPoint);
            centerPoint = CenterPointOf(previousPoint, pointI);
            
            centerPointDistance = DistanceBetweenPoint(previousCenterPoint, centerPoint);
            
            obliqueAngle = ObliqueAngleOfStraightThrough(centerPoint, previousCenterPoint);
            
            previousControlPoint2 = CGPointMake(previousPoint.x - 0.5 * self.contractionFactor * centerPointDistance * cos(obliqueAngle), previousPoint.y - 0.5 * self.contractionFactor * centerPointDistance * sin(obliqueAngle));
            controlPoint1 = CGPointMake(previousPoint.x + 0.5 * self.contractionFactor * centerPointDistance * cos(obliqueAngle), previousPoint.y + 0.5 * self.contractionFactor * centerPointDistance * sin(obliqueAngle));
        }
        
        if (i == 1) {
            
            [self addQuadCurveToPoint:previousPoint controlPoint:previousControlPoint2];
        }
        else if (i > 1 && i < pointArray.count - 1) {
            
            [self addCurveToPoint:previousPoint controlPoint1:previousControlPoint1 controlPoint2:previousControlPoint2];
        }
        else if (i == pointArray.count - 1) {
            
            [self addCurveToPoint:previousPoint controlPoint1:previousControlPoint1 controlPoint2:previousControlPoint2];
            [self addQuadCurveToPoint:pointI controlPoint:controlPoint1];
        }
        else {
            
        }
        
        previousControlPoint1 = controlPoint1;
        previousPoint = pointI;
    }
}

CGFloat ObliqueAngleOfStraightThrough(CGPoint point1, CGPoint point2)   //  [-π/2, 3π/2)
{
    CGFloat obliqueRatio = 0;
    CGFloat obliqueAngle = 0;
    
    if (point1.x > point2.x) {
        
        obliqueRatio = (point2.y - point1.y) / (point2.x - point1.x);
        obliqueAngle = atan(obliqueRatio);
    }
    else if (point1.x < point2.x) {
        
        obliqueRatio = (point2.y - point1.y) / (point2.x - point1.x);
        obliqueAngle = M_PI + atan(obliqueRatio);
    }
    else if (point2.y - point1.y >= 0) {
        
        obliqueAngle = M_PI/2;
    }
    else {
        obliqueAngle = -M_PI/2;
    }
    
    return obliqueAngle;
}

CGPoint ControlPointForTheBezierCanThrough3Point(CGPoint point1, CGPoint point2, CGPoint point3)
{
    return CGPointMake(2 * point2.x - (point1.x + point3.x) / 2, 2 * point2.y - (point1.y + point3.y) / 2);
}

CGFloat DistanceBetweenPoint(CGPoint point1, CGPoint point2)
{
    return sqrt((point1.x - point2.x) * (point1.x - point2.x) + (point1.y - point2.y) * (point1.y - point2.y));
}

CGPoint CenterPointOf(CGPoint point1, CGPoint point2)
{
    return CGPointMake((point1.x + point2.x) / 2, (point1.y + point2.y) / 2);
}

+ (UIBezierPath*)drawLine:(NSMutableArray*)linesArray
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [linesArray enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0)
        {
            [path moveToPoint:CGPointFromString(obj)];
        }
        
        else
        {
            [path addLineToPoint:CGPointFromString(obj)];
        }
    }];
    return path;
}

+ (NSMutableArray<__kindof UIBezierPath*>*)drawLines:(NSMutableArray<NSMutableArray*>*)linesArray
{
    NSAssert(0 != linesArray.count && NULL != linesArray, @"传入的数组为nil ,打印结果---->>%@",linesArray);
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSMutableArray *lineArray in linesArray)
    {
        UIBezierPath *path = [UIBezierPath drawLine:lineArray];
        [resultArray addObject:path];
    }
    return resultArray;
}

-(void)drawCurveLine:(NSMutableArray*)valueArray
{
    
}
@end
