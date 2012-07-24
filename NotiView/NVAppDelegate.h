//
//  NVAppDelegate.h
//  NotiView
//
//  Created by Mathieu Bolard on 24/07/12.
//  Copyright (c) 2012 Mathieu Bolard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NVViewController;

@interface NVAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NVViewController *viewController;

@end
