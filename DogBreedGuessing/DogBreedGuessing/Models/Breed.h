//
//  Breed.h
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/25.
//

#import <Foundation/Foundation.h>

@interface Breed : NSObject

// Breed
@property (nonatomic, strong) NSString *kind;

// Sub-Breed
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithKind:(NSString *)kind name:(NSString *)name;
- (instancetype)initWithImageURLString:(NSString *)imageURLString;
- (NSString *)breedStringForRequest;
- (NSString *)breedStringForDisplay;

@end
