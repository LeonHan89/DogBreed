//
//  BreedsListService.h
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"
#import "Breed.h"

@interface BreedsListService : BaseService

- (void)fetchAllBreedsWithCompletion:(void (^)(NSArray<Breed *> *breeds, NSError *error))completionHandler;
- (void)fetchAllSubBreedsWithBreedKind:(NSString *)breedKind completion:(void (^)(NSArray<Breed *> *breeds, NSError *error))completionHandler;

@end
