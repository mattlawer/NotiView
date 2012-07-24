//
//  NotiView.m
//  NotiPad
//
//  Created by Mathieu Bolard on 24/07/12.
//  Copyright (c) 2012 Mathieu Bolard. All rights reserved.
//

#import "NotiView.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat defaultWidth = 300.0;


@implementation NotiView

- (id)initWithTitle:(NSString *)title detail:(NSString *)detail icon:(UIImage *)icon
{
    CGFloat detailHeight = [detail sizeWithFont:[UIFont boldSystemFontOfSize:16.0] constrainedToSize:CGSizeMake(defaultWidth-120.0, 80.0) lineBreakMode:UILineBreakModeTailTruncation].height;
    if (detailHeight < 20)
        detailHeight = 20.0;
    CGFloat notifHeight = detailHeight + 78.0;
        
    
    self = [super initWithFrame:CGRectMake(0.0, 0.0, defaultWidth, notifHeight)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        UIImageView *_icon = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 22.0, 50.0, 50.0)];
        _icon.clipsToBounds = YES;
        _icon.layer.cornerRadius = 8.0;
        _icon.backgroundColor = [UIColor whiteColor];
        [_icon setImage:icon];
        [self addSubview:_icon];
        [_icon release];
        
        UILabel *_title = [[UILabel alloc] initWithFrame:CGRectMake(90.0, 22.0, defaultWidth-120.0, 24.0)];
        _title.backgroundColor = [UIColor clearColor];
        _title.textColor = [UIColor whiteColor];
        _title.shadowColor = [UIColor blackColor];
        _title.shadowOffset = CGSizeMake(0.0, 1.0);
        _title.font = [UIFont boldSystemFontOfSize:22.0];
        _title.text = title;
        [self addSubview:_title];
        [_title release];
        
        
        UILabel *_detail = [[UILabel alloc] initWithFrame:CGRectMake(90.0, 52.0, defaultWidth-120.0, detailHeight)];
        _detail.backgroundColor = [UIColor clearColor];
        _detail.textColor = [UIColor lightGrayColor];
        _detail.shadowColor = [UIColor blackColor];
        _detail.shadowOffset = CGSizeMake(0.0, 1.0);
        _detail.font = [UIFont boldSystemFontOfSize:16.0];
        _detail.text = detail;
        _detail.numberOfLines = 0;
        [self addSubview:_detail];
        [_detail release];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat alpha = 0.6;
    
    //// Colors
    UIColor* grayshadow = [UIColor colorWithRed: 0.61 green: 0.65 blue: 0.69 alpha: alpha];
    UIColor* border = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: alpha];
    UIColor* topColor = [UIColor colorWithRed: 0.37 green: 0.37 blue: 0.37 alpha: alpha];
    UIColor* midColor = [UIColor colorWithRed: 0.1 green: 0.1 blue: 0.1 alpha: alpha];
    UIColor* bottomColor = [UIColor colorWithRed: 0.12 green: 0.12 blue: 0.12 alpha: alpha];
    
    //// Gradient Declarations
    NSArray* newGradientColors = [NSArray arrayWithObjects:
                                  (id)topColor.CGColor,
                                  (id)midColor.CGColor,
                                  (id)border.CGColor,
                                  (id)border.CGColor,
                                  (id)bottomColor.CGColor, nil];
    CGFloat newGradientLocations[] = {0, 0.500, 0.501, 0.66, 1};
    CGGradientRef newGradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)newGradientColors, newGradientLocations);
    
    //// Shadow Declarations
    UIColor* shadow = grayshadow;
    CGSize shadowOffset = CGSizeMake(0, 2);
    CGFloat shadowBlurRadius = 0;
    UIColor* shadow2 = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    CGSize shadow2Offset = CGSizeMake(0.0, 2.0);
    CGFloat shadow2BlurRadius = 4.0;

    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(4.5, 2.5, rect.size.width-8.0, rect.size.height-8.0) cornerRadius: 10];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2.CGColor);
    CGContextSetFillColorWithColor(context, shadow2.CGColor);
    [roundedRectanglePath fill];
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, newGradient, CGPointMake(0.0, 2.5), CGPointMake(0.0, rect.size.height-5.5), 0);
    
    ////// Rounded Rectangle Inner Shadow
    CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -shadowBlurRadius, -shadowBlurRadius);
    roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -shadowOffset.width, -shadowOffset.height);
    roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
    
    UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
    [roundedRectangleNegativePath appendPath: roundedRectanglePath];
    roundedRectangleNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(roundedRectangleBorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadowBlurRadius,
                                    shadow.CGColor);
        
        [roundedRectanglePath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0);
        [roundedRectangleNegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [roundedRectangleNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    CGContextRestoreGState(context);
    
    [border setStroke];
    roundedRectanglePath.lineWidth = 1;
    [roundedRectanglePath stroke];
    
    //// Cleanup
    CGGradientRelease(newGradient);
    CGColorSpaceRelease(colorSpace);
}

@end
