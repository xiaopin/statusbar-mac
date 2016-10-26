//
//  EventMonitor.h
//  StatusBarDemo
//
//  Created by nhope on 2016/10/26.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

typedef void(^EventMonitorCallback)(NSEvent *event);

@interface EventMonitor : NSObject

@property (nonatomic, assign) NSEventMask eventMask;
@property (nonatomic, copy) EventMonitorCallback callback;


/**
 创建一个事件监听器

 @param eventMask 需要监听的事件
 @param callback  在监听到指定的事件后的回调

 @return EventMonitor
 */
+ (instancetype)eventMonitorWithEventMask:(NSEventMask)eventMask callback:(EventMonitorCallback)callback;


/**
 开始监听事件
 */
- (void)startMonitor;

/**
 停止监听事件
 */
- (void)stopMonitor;

@end
