//
//  SlideMenuController.m
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import "SlideMenuController.h"
#import "MenuTableViewCell.h"

@interface SlideMenuController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SlideMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    if (indexPath.row == 0) {
        [cell.thumbnailImageView setImage:[UIImage systemImageNamed:@"books.vertical"]];
        cell.titleLabel.text = @"Gallery";
    } else {
        // Maybe can add more functions
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate slideMenuDidSelectOption:indexPath.row];
}

@end
