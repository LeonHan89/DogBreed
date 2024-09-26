//
//  BreedImageService.m
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import "BreedImageService.h"

@implementation BreedImageService

- (void)fetchAllImagesWithBreed:(Breed *)breed completion:(void (^)(NSArray<NSString *> *imageURLStrings, NSError *error))completionHandler {
    NSString *urlString = [NSString stringWithFormat:@"%@breed/%@/images", API_HOST, [breed breedStringForRequest]];
    if (!breed) {
        // Let error happen
        urlString = nil;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [super sendRequestWithURL:url completion:^(id jsonData, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            NSMutableArray<NSString *> *resultArr = [[NSMutableArray alloc] init];
            NSArray *arr = jsonData;
            for (NSString *imageURLString in arr) {
                [resultArr addObject:imageURLString];
            }
            completionHandler([resultArr copy], nil);
        }
    }];
}

- (void)fetchRandomImagesWithBreed:(Breed *)breed count:(NSInteger)count completion:(void (^)(NSArray<NSString *> *imageURLStrings, NSError *error))completionHandler {
    NSString *urlString = [NSString stringWithFormat:@"%@breed/%@/images/random", API_HOST, [breed breedStringForRequest]];
    if (breed == nil) {
        urlString = [NSString stringWithFormat:@"%@breeds/image/random", API_HOST];
    }
    
    if (count && count > 1) {
        urlString = [urlString stringByAppendingFormat:@"/%ld", (long)count];
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [super sendRequestWithURL:url completion:^(id jsonData, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            NSMutableArray<NSString *> *resultArr = [[NSMutableArray alloc] init];
            if ([jsonData isKindOfClass:[NSArray class]]) {
                NSArray *arr = jsonData;
                for (NSString *imageURLString in arr) {
                    [resultArr addObject:imageURLString];
                }
            } else {
                NSString *imageURLString = jsonData;
                [resultArr addObject:imageURLString];
            }
            completionHandler([resultArr copy], nil);
        }
    }];
}

@end
