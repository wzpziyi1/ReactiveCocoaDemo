//
//  ZYTokenEntity.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/4.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYTokenEntity.h"

@implementation ZYTokenEntity

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = [expires_in copy];
    if (self.expireDate == nil)
    {
        NSTimeInterval scoend = [expires_in doubleValue];
        
        _expireDate = [[NSDate date] dateByAddingTimeInterval:scoend];
    }
}

- (BOOL)isTokenUseable
{
    if (_expireDate != nil)
    {
        if ([_expireDate compare:[NSDate date]] == NSOrderedDescending) return YES;
    }
    return NO;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.remind_in = [aDecoder decodeObjectForKey:@"remind_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expireDate = [aDecoder decodeObjectForKey:@"expireDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expireDate forKey:@"expireDate"];
}

@end
