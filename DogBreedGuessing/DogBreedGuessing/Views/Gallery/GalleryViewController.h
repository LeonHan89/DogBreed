//
//  GalleryViewController.h
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import <UIKit/UIKit.h>
#import "Breed.h"

@interface GalleryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<Breed *> *dataSource;

@end
