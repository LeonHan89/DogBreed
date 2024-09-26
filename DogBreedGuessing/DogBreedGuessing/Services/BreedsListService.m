//
//  BreedsListService.m
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import "BreedsListService.h"

@implementation BreedsListService

- (void)fetchAllBreedsWithCompletion:(void (^)(NSArray<Breed *> *breeds, NSError *error))completionHandler {
    NSString *urlString = [NSString stringWithFormat:@"%@breeds/list/all", API_HOST];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [super sendRequestWithURL:url completion:^(id jsonData, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            NSMutableArray<Breed *> *resultArr = [[NSMutableArray alloc] init];
            NSDictionary *dict = jsonData;
            for (NSString *key in dict.allKeys) {
                NSArray *nameArr = dict[key];
                if (!nameArr || nameArr.count == 0) {
                    Breed *breed = [[Breed alloc] initWithKind:key name:nil];
                    [resultArr addObject:breed];
                } else {
                    for (NSString *nameString in nameArr) {
                        Breed *breed = [[Breed alloc] initWithKind:key name:nameString];
                        [resultArr addObject:breed];
                    }
                }
            }
            completionHandler([resultArr copy], nil);
        }
    }];
}

- (void)fetchAllSubBreedsWithBreedKind:(NSString *)breedKind completion:(void (^)(NSArray<Breed *> *breeds, NSError *error))completionHandler {
    NSString *urlString = [NSString stringWithFormat:@"%@breed/%@/list", API_HOST, breedKind];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [super sendRequestWithURL:url completion:^(id jsonData, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            NSMutableArray<Breed *> *resultArr = [[NSMutableArray alloc] init];
            NSArray *arr = jsonData;
            for (NSString *name in arr) {
                Breed *breed = [[Breed alloc] initWithKind:breedKind name:name];
                [resultArr addObject:breed];
            }
            completionHandler([resultArr copy], nil);
        }
    }];
}

@end
