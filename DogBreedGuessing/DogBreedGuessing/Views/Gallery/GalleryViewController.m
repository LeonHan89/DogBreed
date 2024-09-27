//
//  GalleryViewController.m
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import "GalleryViewController.h"
#import "GalleryTableViewCell.h"

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GalleryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GalleryCell"];
    cell.titleLabel.text = [self.dataSource[indexPath.row] breedStringForDisplay];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
