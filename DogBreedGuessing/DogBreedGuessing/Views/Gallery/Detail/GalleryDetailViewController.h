//
//  GalleryDetailViewController.h
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/27.
//

#import <UIKit/UIKit.h>
#import "Breed.h"

@interface GalleryDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) Breed *breed;
@property (nonatomic, strong) NSArray<NSString *> *dataSource;

@end
