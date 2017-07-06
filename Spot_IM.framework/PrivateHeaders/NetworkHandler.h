//
//  NetworkHandler.h
//  Spot_IM
//
//  Created by Nissim Pardo on 28/12/2016.
//  Copyright © 2016 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkHandler : NSObject
+ (NetworkHandler *)shared;
- (NSDictionary *)fetchRecirculation:(NSURLComponents *)queryItem
                          completion:(void(^)(NSDictionary *params, NSError *error))completion;
- (void)fetchData:(NSURLComponents *)queryItem withId:(NSString *)currentId
       completion:(void(^)(NSString *currentId, NSData *data, NSError *error))completion;
- (void)fetchDataAtUrl:(NSURL *)url withId:(NSString *)currentId
       completion:(void(^)(NSString *currentId, NSData *data, NSError *error))completion;
- (void)triggerEvent:(NSURLComponents *)component
          completion:(void(^)(NSError *error))completion;
@end
