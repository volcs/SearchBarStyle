//
//  UIView+VAdd.m
//  SearchExample
//
//  Created by Vols on 2016/11/4.
//  Copyright © 2016年 vols. All rights reserved.
//

#import "UIView+VAdd.h"

@implementation UIView (VAdd)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.origin.x;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
}
- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

/** 设置锚点 */
- (CGPoint)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
    return self.layer.anchorPoint;
}

/** 根据手势触摸点修改相应的锚点，就是沿着触摸点做相应的手势操作 */
- (CGPoint)setAnchorPointBaseOnGestureRecognizer:(UIGestureRecognizer *)gr {
    // 手势为空 直接返回
    if (!gr) return CGPointMake(0.5, 0.5);
    
    // 创建锚点
    CGPoint anchorPoint;
    if ([gr isKindOfClass:[UIPinchGestureRecognizer class]]) { // 捏合手势
        if (gr.numberOfTouches == 2) {
            // 当触摸开始时，获取两个触摸点
            CGPoint point1 = [gr locationOfTouch:0 inView:gr.view];
            CGPoint point2 = [gr locationOfTouch:1 inView:gr.view];
            anchorPoint.x = (point1.x + point2.x) / 2 / gr.view.width;
            anchorPoint.y = (point1.y + point2.y) / 2 / gr.view.height;
        }
    } else if ([gr isKindOfClass:[UITapGestureRecognizer class]]) { // 点击手势
        // 获取触摸点
        CGPoint point = [gr locationOfTouch:0 inView:gr.view];
        
        CGFloat angle = acosf(gr.view.transform.a);
        if (ABS(asinf(gr.view.transform.b) + M_PI_2) < 0.01) angle += M_PI;
        CGFloat width = gr.view.width;
        CGFloat height = gr.view.height;
        if (ABS(angle - M_PI_2) <= 0.01 || ABS(angle - M_PI_2 * 3) <= 0.01) { // 旋转角为90°
            // width 和 height 对换
            width = gr.view.height;
            height = gr.view.width;
        }
        // 如果旋转了
        anchorPoint.x = point.x / width;
        anchorPoint.y = point.y / height;
    };
    return [self setAnchorPoint:anchorPoint forView:self];
}

@end
