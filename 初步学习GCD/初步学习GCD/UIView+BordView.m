//
//  UIView+BordView.m
//  初步学习GCD
//
//  Created by 杭州米发 on 2017/11/17.
//  Copyright © 2017年 冯硕. All rights reserved.
//

#import "UIView+BordView.h"

#define bili    4

@implementation UIView (BordView)
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType {
    self.backgroundColor = [UIColor clearColor];
//    if (borderType == UIBorderSideTypeAll) {
//        self.layer.borderWidth = borderWidth;
//        self.layer.borderColor = color.CGColor;
//        return self;
//    }
//
//
//    /// 左侧
//    if (borderType & UIBorderSideTypeLeft) {
//        /// 左侧线路径
//        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:color borderWidth:borderWidth]];
//    }
//
//    /// 右侧
//    if (borderType & UIBorderSideTypeRight) {
//        /// 右侧线路径
//        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
//    }
//
//    /// top
//    if (borderType & UIBorderSideTypeTop) {
//        /// top线路径
//        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:color borderWidth:borderWidth]];
//    }
//
//    /// bottom
//    if (borderType & UIBorderSideTypeBottom) {
//        /// bottom线路径
//        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
//    }
//
     [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    
    return self;
}

- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
   
    aPath.lineWidth = 1.0;
    aPath.lineCapStyle = kCGLineCapSquare; //线条拐角
    aPath.lineJoinStyle = kCGLineJoinBevel; //终点处理
    [aPath moveToPoint:CGPointMake(0, 6 * bili)];//设置初始点
    //终点  controlPoint:切点（并不是拐弯处的高度，不懂的同学可以去看三角函数）
    [aPath addQuadCurveToPoint:CGPointMake(6 * bili, 000) controlPoint:CGPointMake(0, 0)];
    
    [aPath addLineToPoint:CGPointMake(self.frame.size.width - 2 * bili, 0)];
    
    [aPath addQuadCurveToPoint:CGPointMake(self.frame.size.width, 2* bili) controlPoint:CGPointMake(self.frame.size.width, 0)];
    
    [aPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - 6 *bili)];
    
    
    [aPath addQuadCurveToPoint:CGPointMake(self.frame.size.width - 6 * bili, self.frame.size.height) controlPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    
    [aPath addLineToPoint:CGPointMake(2* bili, self.frame.size.height)];
    
    [aPath addQuadCurveToPoint:CGPointMake(0, self.frame.size.height - 2 * bili) controlPoint:CGPointMake(0, self.frame.size.height)];
    
    [aPath addLineToPoint:CGPointMake(0, 6 * bili)];
    [aPath stroke];
    
    /// 线的路径
//    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
//    [bezierPath moveToPoint:p0];
//    [bezierPath addLineToPoint:p1];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = aPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = borderWidth;
    return shapeLayer;
}  
@end
