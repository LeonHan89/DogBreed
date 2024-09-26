//
//  BreedImageService.h
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"
#import "Breed.h"

@interface BreedImageService : BaseService

- (void)fetchAllImagesWithBreed:(Breed *)breed completion:(void (^)(NSArray<NSString *> *imageURLStrings, NSError *error))completionHandler;
- (void)fetchRandomImagesWithBreed:(Breed *)breed count:(NSInteger)count completion:(void (^)(NSArray<NSString *> *imageURLStrings, NSError *error))completionHandler;

@end
