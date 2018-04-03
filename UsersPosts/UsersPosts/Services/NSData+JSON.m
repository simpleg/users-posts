//
//  UsersManager.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

-(id)objectFromJSONData {
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:&error];
    return object;
}

+(NSData *) dataFromObject:(id) object {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    return jsonData;
}
@end
