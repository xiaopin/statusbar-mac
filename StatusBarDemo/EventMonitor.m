//
//  EventMonitor.m
//  StatusBarDemo
//
//  Created by nhope on 2016/10/26.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

#import "EventMonitor.h"

@implementation EventMonitor
{
    id  _monitor;
}

+ (instancetype)eventMonitorWithEventMask:(NSEventMask)eventMask callback:(EventMonitorCallback)callback {
    EventMonitor *monitor = [[EventMonitor alloc] init];
    [monitor setEventMask:eventMask];
    [monitor setCallback:callback];
    
    return monitor;
}

- (void)startMonitor {
    _monitor = [NSEvent addGlobalMonitorForEventsMatchingMask:self.eventMask handler:self.callback];
}

- (void)stopMonitor {
    if (nil != _monitor) {
        [NSEvent removeMonitor:_monitor];
        _monitor = nil;
    }
}

@end
