//
//  UIViewController+SlideMenu.m
//  SlideMenu
//
//  Created by Leon on 2024/9/25.
//

#import "UIViewController+SlideMenu.h"
#import "SlideMenu.h"

@implementation UIViewController (SlideMenu)

- (SlideMenu *)slideMenu {
    UIViewController *slideMenu = self.parentViewController;
    while (slideMenu) {
        if ([slideMenu isKindOfClass:[SlideMenu class]]) {
            return (SlideMenu *)slideMenu;
        } else if (slideMenu.parentViewController && slideMenu.parentViewController != slideMenu) {
            slideMenu = slideMenu.parentViewController;
        } else {
            slideMenu = nil;
        }
    }
    return nil;
}

@end
