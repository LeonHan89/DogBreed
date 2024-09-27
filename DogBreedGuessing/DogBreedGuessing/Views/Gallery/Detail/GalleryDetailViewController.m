//
//  GalleryDetailViewController.m
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/27.
//

#import "GalleryDetailViewController.h"
#import "BreedImageService.h"
#import "GalleryDetailTableViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface GalleryDetailViewController ()

@end

@implementation GalleryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = [self.breed breedStringForDisplay];
}

- (IBAction)onDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestImage];
}

// MARK: - Services

- (void)requestImage {
    BreedImageService *imageService = [[BreedImageService alloc] init];
    __weak typeof (self) weakSelf = self;
    [imageService fetchAllImagesWithBreed:self.breed completion:^(NSArray<NSString *> *imageURLStrings, NSError *error) {
        weakSelf.dataSource = imageURLStrings;
        [weakSelf.tableView reloadData];
    }];
}

// MARK: - Table view delegates

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GalleryDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GalleryDetailCell"];
    NSInteger idx = indexPath.row * 2;
    [cell.firstImgView sd_setImageWithURL:[NSURL URLWithString:self.dataSource[idx]]];
    [cell.secondImgView sd_setImageWithURL:[NSURL URLWithString:self.dataSource[idx + 1]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return floor(self.dataSource.count / 2);
}

@end
