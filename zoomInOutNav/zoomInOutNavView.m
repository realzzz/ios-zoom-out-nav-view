//
//  zoomInOutNavView.m
//  zoomInOutNav
//
//  Created by Zhang Peng on 13-11-4.
//  Copyright (c) 2013年 Zhang Peng. All rights reserved.
//

#import "zoomInOutNavView.h"

@interface zoomInOutNavView ()
{
    UIImageView * zoomBg;
    BOOL          inTrans;
}

@end

@implementation zoomInOutNavView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        inTrans = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void) addSubview:(UIView *)view fromRect:(CGRect)origRect byScale:(CGFloat)scale
{
    if (inTrans) {
        return;
    }
    else{
        inTrans = YES;
    }
    // first calculate the max scale
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    CGFloat finalScale = scale;
    if (scale == 0.0) {
        CGFloat wScale = selfWidth/origRect.size.width;
        CGFloat hScale = selfHeight/origRect.size.height;
        finalScale = MAX(wScale, hScale);
    }

    UIImage * currentBg = [self captureCurrentBGimg];    
    if (zoomBg == nil) {
        zoomBg = [[UIImageView alloc]init];
        zoomBg.alpha = 1.0;
        [self addSubview:zoomBg];
    }
    
    zoomBg.frame = CGRectMake(0, 0, selfWidth, selfHeight);
    [zoomBg setImage:currentBg];

    [UIView animateWithDuration:0.3 animations:^{
        zoomBg.frame = CGRectMake(-origRect.origin.x * (finalScale-1), -origRect.origin.y * (finalScale -1), selfWidth * finalScale, selfHeight * finalScale);
        //zoomBg.alpha = 0.0;

    } completion:^(BOOL finished) {
        [zoomBg removeFromSuperview];
        zoomBg = nil;
        [self addSubview:view];
        inTrans = NO;
    }];
    
}

- (void) zoomInBack:(CGRect)origRect byScale:(CGFloat)scale
{
    if (inTrans) {
        return;
    }
    else{
        inTrans = YES;
    }
    // first calculate the max scale
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    CGFloat finalScale = scale;
    if (scale == 0.0) {
        CGFloat wScale = selfWidth/origRect.size.width;
        CGFloat hScale = selfHeight/origRect.size.height;
        finalScale = MAX(wScale, hScale);
    }
    
    UIImage * currentBg = [self captureCurrentBGimg];
    if (zoomBg == nil) {
        zoomBg = [[UIImageView alloc]init];
        zoomBg.alpha = 1.0;
        [self addSubview:zoomBg];
    }
    zoomBg.frame = CGRectMake(-origRect.origin.x * (finalScale-1), -origRect.origin.y * (finalScale -1), selfWidth * finalScale, selfHeight * finalScale);
    
    [zoomBg setImage:currentBg];
    
    [UIView animateWithDuration:0.3 animations:^{
        zoomBg.frame = CGRectMake(0, 0, selfWidth, selfHeight);
        //zoomBg.alpha = 0.0;
    } completion:^(BOOL finished) {
        [zoomBg removeFromSuperview];
        zoomBg = nil;
        inTrans = NO;
    }];
}

- (UIImage *)captureCurrentBGimg
{
    CGRect selfF = self.frame;
    
    UIGraphicsBeginImageContextWithOptions(selfF.size, 0, 1);
    CGContextRef contextR = UIGraphicsGetCurrentContext();
    CGContextSaveGState(contextR);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    CGFloat kBorderGray[4] = {0.0, 0.0, 0.0, 0.0};
    [self drawRect:selfF fill:kBorderGray radius:0];
    
    // Restore the context
    CGContextRestoreGState(contextR);
    
    UIImage * currentBGImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return currentBGImg;
}

- (void)drawRect:(CGRect)rect fill:(const CGFloat*)fillColors radius:(CGFloat)radius
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    if (fillColors)
    {
        CGContextSaveGState(context);
        
        CGContextSetFillColor(context, fillColors);
        
        if (radius)
        {
            [self addRoundedRectToPath:context rect:rect radius:radius];
            CGContextFillPath(context);
        }
        else
        {
            CGContextFillRect(context, rect);
        }
        CGContextRestoreGState(context);
    }
    
    CGColorSpaceRelease(space);
}

- (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius
{
    CGContextBeginPath(context);
    CGContextSaveGState(context);
    
    if (radius == 0)
    {
        CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddRect(context, rect);
    }
    else
    {
        rect = CGRectOffset(CGRectInset(rect, 0.5, 0.5), 0.5, 0.5);
        CGContextTranslateCTM(context, CGRectGetMinX(rect)-0.5, CGRectGetMinY(rect)-0.5);
        CGContextScaleCTM(context, radius, radius);
        float fw = CGRectGetWidth(rect) / radius;
        float fh = CGRectGetHeight(rect) / radius;
        
        CGContextMoveToPoint(context, fw, fh/2);
        CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
        CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
        CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
        CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    }
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

@end
