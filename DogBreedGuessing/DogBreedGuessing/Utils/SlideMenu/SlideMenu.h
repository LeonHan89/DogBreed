//
//  SlideMenu.h
//  SlideMenu
//
//  Created by Leon on 2024/9/25.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SlideMenu.h"

@interface SlideMenu: UIViewController
// Main view
@property (nonatomic, strong) UIViewController *rootViewController;
// Menu View
@property (nonatomic, strong) UIViewController *menuViewController;
@property (nonatomic, assign) CGFloat menuWidth;
// Margin width
@property (nonatomic, assign) CGFloat emptyWidth;
@property (nonatomic, assign) BOOL slideEnabled;

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;
- (void)showRootViewControllerAnimated:(BOOL)animated;
- (void)showMenuViewControllerAnimated:(BOOL)animated;

@end
