//
//  NSTimer+Blocks.m
//  NotiView
//
//  Created by Mathieu Bolard on 25/07/12.
//  Copyright (c) 2012 Mathieu Bolard. All rights reserved.
//

#import "NSTimer+Blocks.h"

@interface NSObject (BlockInvoke)
-(void)tc_invoke:(NSTimer*)sender;
@end
@implementation NSObject (BlockInvoke)
-(void)tc_invoke:(NSTimer*)sender;
{
	void(^block)(NSTimer*) = (void*)self;
	block(sender);
}
@end

@implementation NSTimer (Blocks)
+ (NSTimer*)timerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer*))block;
{
	return [NSTimer timerWithTimeInterval:ti target:[[block copy] autorelease] selector:@selector(tc_invoke:) userInfo:nil repeats:yesOrNo];
}
+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer*))block;
{
	return [NSTimer scheduledTimerWithTimeInterval:ti target:[[block copy] autorelease] selector:@selector(tc_invoke:) userInfo:nil repeats:yesOrNo];
}
@end