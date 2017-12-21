//
//  FSLabel.m
//  初步学习GCD
//
//  Created by 杭州米发 on 2017/11/17.
//  Copyright © 2017年 冯硕. All rights reserved.
//

#import "FSLabel.h"
#define bili    4
@implementation FSLabel

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


- (void)setHeights:(CGFloat)heights
{
    _heights =heights;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backgroundColor = [UIColor clearColor];
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    UIColor* clor  =[UIColor redColor];
    [clor set];
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
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
