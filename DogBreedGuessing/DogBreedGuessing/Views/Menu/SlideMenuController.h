//
//  SlideMenuController.h
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import <UIKit/UIKit.h>

@protocol SlideMenuControllerDelegate <NSObject>

- (void)slideMenuDidSelectOption:(NSInteger)option;

@end

@interface SlideMenuController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<SlideMenuControllerDelegate> delegate;

@end
