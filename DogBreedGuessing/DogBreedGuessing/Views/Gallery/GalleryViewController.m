//
//  GalleryViewController.m
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import "GalleryViewController.h"
#import "GalleryTableViewCell.h"
#import "GalleryDetailViewController.h"

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onDismiss:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// MARK: - Table view delegates

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
    self.selectedBreed = self.dataSource[indexPath.row];
    [self performSegueWithIdentifier:@"SegueGalleryDetail" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SegueGalleryDetail"]) {
        GalleryDetailViewController *vc = [segue destinationViewController];
        vc.breed = self.selectedBreed;
    }
}

@end
