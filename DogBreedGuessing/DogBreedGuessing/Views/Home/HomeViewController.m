//
//  HomeViewController.m
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/25.
//

#import "HomeViewController.h"
#import "SlideMenu.h"
#import "BreedImageService.h"
#import "BreedsListService.h"
#import <SDWebImage/SDWebImage.h>
#import "GalleryViewController.h"

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageView.layer.cornerRadius = 40;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.borderWidth = 2;
    self.imageView.layer.borderColor = UIColor.grayColor.CGColor;
    
    self.chooseAnswerButton.layer.cornerRadius = 20;
    self.chooseAnswerButton.clipsToBounds = YES;
    
    self.isFetchingData = YES;
    [self requestDataForHomePage];
}

- (void)beginAnswerChoosing {
    [self.incorrectAnswerWarningLabel setHidden:YES];
    self.answerChooseViewTopConstraint.constant = -280;
    [UIView animateWithDuration: 0.5f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)finishAnswerChoosing {
    self.answerChooseViewTopConstraint.constant = 0;
    [UIView animateWithDuration: 0.5f animations:^{
        [self.view layoutIfNeeded];
        [self validateAnswer];
    }];
}

- (void)validateAnswer {
    if ([[[self.breedForImage breedStringForDisplay] lowercaseString] isEqualToString:[[self.answer breedStringForDisplay] lowercaseString]]) {
        // Correct
        [self performSegueWithIdentifier:@"SegueCongrats" sender:nil];
    } else {
        // Incorrect
        [self shakeView:self.imageView];
        [self.incorrectAnswerWarningLabel setHidden:NO];
    }
}

- (void)shakeView:(UIView *)viewToShake {
    CGFloat t = 6.0;
    CGAffineTransform translateRight = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    viewToShake.transform = translateLeft;
    [UIView animateWithDuration:0.001 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished) {
        if (finished) {
            viewToShake.transform = CGAffineTransformIdentity;
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SegueCongrats"]) {
        CongratsViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        vc.breed = self.breedForImage;
    } else if ([segue.identifier isEqualToString:@"SegueGallery"]) {
        GalleryViewController *vc = [segue destinationViewController];
        vc.dataSource = self.dataSource;
    }
}

// MARK: - Services

- (void)requestDataForHomePage {
    BreedsListService *listService = [[BreedsListService alloc] init];
    __weak typeof (self) weakSelf = self;
    [listService fetchAllBreedsWithCompletion:^(NSArray<Breed *> *breeds, NSError *error) {
        weakSelf.dataSource = breeds;
        [weakSelf.pickerView reloadAllComponents];
        [weakSelf requestImage];
    }];
}

- (void)requestImage {
    self.isFetchingData = YES;
    BreedImageService *imageService = [[BreedImageService alloc] init];
    __weak typeof (self) weakSelf = self;
    [imageService fetchRandomImagesWithBreed:nil count:1 completion:^(NSArray<NSString *> *imageURLStrings, NSError *error) {
        [weakSelf.imageView sd_setImageWithURL:[NSURL URLWithString:imageURLStrings.firstObject] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            weakSelf.breedForImage = [[Breed alloc] initWithImageURLString:imageURLStrings.firstObject];
            self.isFetchingData = NO;
        }];
    }];
}

- (void)setIsFetchingData:(BOOL)isFetchingData {
    if (isFetchingData) {
        [self.activityIndicator setHidden:NO];
        [self.activityIndicator startAnimating];
        [self.chooseAnswerButton setBackgroundColor:UIColor.lightGrayColor];
    } else {
        [self.activityIndicator stopAnimating];
        [self.chooseAnswerButton setBackgroundColor:UIColor.systemBlueColor];
    }
    [self.chooseAnswerButton setEnabled:!isFetchingData];
}

// MARK: - Picker delegates

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.dataSource[row] breedStringForDisplay];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.answer = self.dataSource[row];
}

// MARK: - CongratsViewControllerDelegate

- (void)congratsViewDidDismiss {
    [self requestImage];
}

// MARK: - Button event

- (IBAction)menuButtonDidTap:(id)sender {
    [self.slideMenu showMenuViewControllerAnimated:YES];
}

- (IBAction)chooseAnswerDidTap:(id)sender {
    [self beginAnswerChoosing];
}

- (IBAction)confirmAnswerDidTap:(id)sender {
    [self finishAnswerChoosing];
}

- (void)slideMenuDidSelectOption:(NSInteger)option {
    [self.slideMenu showRootViewControllerAnimated:YES];
    if (option == 0) {
        // Gallery
        [self performSegueWithIdentifier:@"SegueGallery" sender:nil];
    } else {
        // Profile
        [self performSegueWithIdentifier:@"SegueProfile" sender:nil];
    }
}

@end
