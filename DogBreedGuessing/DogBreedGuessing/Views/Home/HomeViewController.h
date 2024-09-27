//
//  HomeViewController.h
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/25.
//

#import <UIKit/UIKit.h>
#import "Breed.h"
#import "CongratsViewController.h"
#import "SlideMenuController.h"

@interface HomeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, CongratsViewControllerDelegate, SlideMenuControllerDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *chooseAnswerButton;
@property (weak, nonatomic) IBOutlet UILabel *incorrectAnswerWarningLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *answerChooseViewTopConstraint;

@property (strong, nonatomic) NSArray<Breed *> *dataSource;
@property (strong, nonatomic) Breed *answer;
@property (strong, nonatomic) Breed *breedForImage;

@property (assign, nonatomic) BOOL isFetchingData;

@end

