//
//  Breed.m
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/25.
//

#import "Breed.h"

@implementation Breed

- (instancetype)initWithKind:(NSString *)kind name:(NSString *)name {
    Breed *breed = [[Breed alloc] init];
    breed.kind = kind;
    breed.name = name;
    return breed;
}

- (instancetype)initWithImageURLString:(NSString *)imageURLString {
    Breed *breed = [[Breed alloc] init];
    
    if (imageURLString != nil) {
        NSString *stringWithoutHost = [imageURLString stringByReplacingOccurrencesOfString:@"https://images.dog.ceo/breeds/" withString:@""];
        NSString *rawName = stringWithoutHost.pathComponents.firstObject;
        NSArray<NSString *> *components = [rawName componentsSeparatedByString:@"-"];
        if (components.count > 1) {
            breed.name = components.lastObject;
        }
        breed.kind = components.firstObject;
    }
    
    return breed;
}

- (NSString *)breedStringForRequest {
    NSString *string = nil;
    if (self.kind) {
        string = self.kind;
        if (self.name) {
            string = [string stringByAppendingFormat:@"/%@", self.name];
        }
    }
    return string;
}

@end
