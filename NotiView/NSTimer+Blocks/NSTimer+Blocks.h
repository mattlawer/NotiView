//
//  NSTimer+Blocks.h
//  NotiView
//
//  Created by Mathieu Bolard on 25/07/12.
//  Copyright (c) 2012 Mathieu Bolard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Blocks)
+ (NSTimer*)timerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer*))block;
+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer*))block;
@end
