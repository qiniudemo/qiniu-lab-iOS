//
//  NSHTTPRequestManger.m
//  HTTPRequest
//
//  Created by kn on 14/11/20.
//  Copyright (c) 2014年 kn. All rights reserved.
//

#import "NSHTTPRequestManger.h"

@implementation NSHTTPRequestManger
+(NSHTTPRequestManger *)sharedNSHTTPRequestManger;
{
    static NSHTTPRequestManger *_manger;
    if(!_manger)
    {
        _manger=[[NSHTTPRequestManger alloc] init];
        _manger.mangerDict=[[NSMutableDictionary alloc] init];
    }
    return _manger;
}
-(void)addTask:(NSString *)code andObject:(id)object;
{
    [self.mangerDict setObject:object forKey:code];
}
-(void)removeTask:(NSString *)code;
{
    [self.mangerDict removeObjectForKey:code];
}
@end
