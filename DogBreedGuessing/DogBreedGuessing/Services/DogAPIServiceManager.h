//
//  DogAPIServiceManager.h
//  DogBreedGuessing
//
//  Created by Leon on 2024/9/26.
//

#import <Foundation/Foundation.h>

#define API_HOST                    @"https://dog.ceo/api/"
#define DogAPIServiceErrorDomain    @"com.dogceo.error"

typedef NS_ENUM(NSInteger, DogAPIServiceErrorCode) {
    DogAPIServiceErrorCodeUnknown = 1000,
    DogAPIServiceErrorCodeInvalidURL,
    DogAPIServiceErrorCodeInvalidData,
    DogAPIServiceErrorCodeNetworkFailure,
    DogAPIServiceErrorCodeServerInternalError
};

@interface DogAPIServiceManager : NSObject

@property (nonatomic, strong) NSURLSession *session;

+ (DogAPIServiceManager *)sharedManager;

@end
