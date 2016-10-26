//
//  AppDelegate.m
//  StatusBarDemo
//
//  Created by nhope on 2016/10/26.
//  Copyright © 2016年 xiaopin. All rights reserved.
//

#import "AppDelegate.h"
#import "EventMonitor.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) NSPopover *popover;
@property (nonatomic, strong) EventMonitor *eventMonitor;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    // 创建展示在StatusBar上的按钮
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    _statusItem = [statusBar statusItemWithLength:NSSquareStatusItemLength];
    [_statusItem.button setTarget:self];
    [_statusItem.button setAction:@selector(statusItemAction:)];
    [_statusItem.button setImage:[NSImage imageNamed:@"statusbar-icon"]];
    
    // 创建模态弹出框
    _popover = [[NSPopover alloc] init];
    [_popover setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameAqua]];
    [_popover setBehavior:NSPopoverBehaviorTransient];
    
    // 设置NSPopover内容视图控制器
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    NSViewController *vc = [storyboard instantiateControllerWithIdentifier:@"TestViewController"];
    [_popover setContentViewController:vc];
    
    // 监听鼠标点击事件
    _eventMonitor = [EventMonitor eventMonitorWithEventMask:(NSEventMaskLeftMouseDown | NSEventMaskRightMouseDown) callback:^(NSEvent *event) {
        AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
        if ([delegate.popover isShown]) {
            [delegate.popover close];
            [delegate.eventMonitor stopMonitor];
        }
    }];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - Actions

- (void)statusItemAction:(NSStatusItem *)sender {
//    [[NSRunningApplication currentApplication] activateWithOptions:NSApplicationActivateIgnoringOtherApps];
    
    if ([_popover isShown]) {
        [_popover close];
        [_eventMonitor stopMonitor];
    } else {
        [_popover showRelativeToRect:_statusItem.button.frame ofView:_statusItem.button preferredEdge:NSRectEdgeMinY];
        [_eventMonitor startMonitor];
    }
}


@end
