//
//  CongratsViewController.h
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/27.
//

#import <UIKit/UIKit.h>
#import "Breed.h"

@protocol CongratsViewControllerDelegate <NSObject>

- (void)congratsViewDidDismiss;

@end

@interface CongratsViewController : UIViewController

@property (nonatomic, weak) id<CongratsViewControllerDelegate> delegate;
@property (nonatomic, strong) Breed *breed;

@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;
@property (weak, nonatomic) IBOutlet UIImageView *imgView4;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
