//
//  NSHTTPRequestManger.h
//  HTTPRequest
//
//  Created by kn on 14/11/20.
//  Copyright (c) 2014年 kn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSHTTPRequestManger : NSObject

@property(nonatomic,strong)NSMutableDictionary *mangerDict;

+(NSHTTPRequestManger *)sharedNSHTTPRequestManger;
-(void)addTask:(NSString *)code andObject:(id)object;
-(void)removeTask:(NSString *)code;
@end
