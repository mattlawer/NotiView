//
//  NotiView.h
//  NotiPad
//
//  Created by Mathieu Bolard on 24/07/12.
//  Copyright (c) 2012 Mathieu Bolard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotiView : UIView {
    UIColor *_color;
}
@property (nonatomic, assign) UIColor *color;
- (id)initWithTitle:(NSString *)title detail:(NSString *)detail icon:(UIImage *)icon;

- (UIColor *)lightenColor:(UIColor *)oldColor value:(float)value;

@end
