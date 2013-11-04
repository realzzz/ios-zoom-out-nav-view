//
//  zoomInOutNavView.h
//  zoomInOutNav
//
//  Created by Zhang Peng on 13-11-4.
//  Copyright (c) 2013年 Zhang Peng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zoomInOutNavView : UIView


- (void) addSubview:(UIView *)view fromRect:(CGRect)origRect byScale:(CGFloat)scale;

- (void) zoomInBack:(CGRect)origRect byScale:(CGFloat)scale;
@end
