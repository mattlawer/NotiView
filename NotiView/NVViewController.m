//
//  NVViewController.m
//  NotiView
//
//  Created by Mathieu Bolard on 24/07/12.
//  Copyright (c) 2012 Mathieu Bolard. All rights reserved.
//

#import "NVViewController.h"
#import "NSTimer+Blocks.h"
#import "NotiView.h"

static CGFloat offset = 20.0;

@interface NVViewController ()
// UI stuff
- (CGFloat) viewWidth;

- (UIColor *)randomColor;
- (NSString *)msgTitle;
- (NSString *)msgDetail;
@end

@implementation NVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) viewWidth {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat width = self.view.frame.size.width;
    if (orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft) {
        width = self.view.frame.size.height;
    }
    return width;
}

- (IBAction)test:(id)sender {
    
    /*//Old way
     NotiView *nv = [[NotiView alloc] initWithTitle:[self msgTitle] detail:[self msgDetail] icon:[UIImage imageNamed:@"icon"]];*/
    
    //New way with custom width
    NotiView *nv = [[NotiView alloc] initWithWidth:300];
    [nv setTitle:[self msgTitle]];
    [nv setDetail:[self msgDetail]]; // this will update the nv height
    [nv setIcon:[UIImage imageNamed:@"icon"]];
    if (_randomcolors.isOn) {
        [nv setColor:[self randomColor]];
    }
    
    // make sure it's out of the screen
    CGRect f = nv.frame;
    f.origin.x = [self viewWidth] - f.size.width - offset;
    f.origin.y = -f.size.height;
    nv.frame = f;
    [self.view addSubview:nv];
    
    [UIView animateWithDuration:0.4 animations:^{
        nv.frame = CGRectOffset(nv.frame, 0.0, f.size.height+offset);
    } completion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:NO block:^(NSTimer *timer) {
            [UIView animateWithDuration:0.4 animations:^{
                nv.frame = CGRectOffset(nv.frame, f.size.width+offset, 0.0);
            } completion:^(BOOL finished) {
                [nv removeFromSuperview];
                [nv release];
            }];
        }];
    }];
    
}

- (NSString *)msgTitle {
    int r = arc4random()%5;
    switch (r) {
        case 0:
            return @"Hi";
            break;
        case 1:
            return @"Hello !";
            break;
        case 2:
            return @"I love you";
            break;
        case 3:
            return @"What's up ?";
            break;
        case 4:
            return @"WTF";
            break;
    }
    return @"test";
}

- (NSString *)msgDetail {
    int r = arc4random()%5;
    switch (r) {
        case 0:
            return @"Yep I'm a full CoreGraphics notification view";
            break;
        case 1:
            return @"Do you like that";
            break;
        case 2:
            return @"Nulla vitae elit libero, a pharetra augue. Etiam porta sem malesuada magna mollis euismod.";
            break;
        case 3:
            return @"You have 309483 new mails";
            break;
        case 4:
            return @"This is cool";
            break;
    }
    return @"test";
}

- (UIColor *)randomColor {
    CGFloat r = arc4random()%255;
    CGFloat g = arc4random()%255;
    CGFloat b = arc4random()%255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

@end
