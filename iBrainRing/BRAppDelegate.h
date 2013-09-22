//
//  BRAppDelegate.h
//  iBrainRing
//
//  Created by Sergey Dunets on 21.09.13.
//  Copyright (c) 2013 Sergey Dunets. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BRViewController;

@interface BRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BRViewController *viewController;

@end
