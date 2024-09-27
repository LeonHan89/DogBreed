//
//  CongratsViewController.m
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/27.
//

#import "CongratsViewController.h"
#import "BreedImageService.h"
#import <SDWebImage/SDWebImage.h>

@implementation CongratsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestImage];
}

- (void)requestImage {
    BreedImageService *imageService = [[BreedImageService alloc] init];
    __weak typeof (self) weakSelf = self;
    [imageService fetchRandomImagesWithBreed:self.breed count:4 completion:^(NSArray<NSString *> *imageURLStrings, NSError *error) {
        [imageURLStrings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            switch (idx) {
                case 0:
                    [weakSelf.imgView1 sd_setImageWithURL:[NSURL URLWithString:obj]];
                    break;
                case 1:
                    [weakSelf.imgView2 sd_setImageWithURL:[NSURL URLWithString:obj]];
                    break;
                case 2:
                    [weakSelf.imgView3 sd_setImageWithURL:[NSURL URLWithString:obj]];
                    break;
                default:
                    [weakSelf.imgView4 sd_setImageWithURL:[NSURL URLWithString:obj]];
                    break;
            }
        }];
        [weakSelf.activityIndicator stopAnimating];
    }];
}

- (IBAction)dismiss:(id)sender {
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf.delegate congratsViewDidDismiss];
    }];
}

@end
