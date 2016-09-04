//
//  NSObject+PropertyCode.m
//  DuoBao
//
//  Created by 王志盼 on 16/8/1.
//
//

#import "NSObject+PropertyCode.h"

@implementation NSObject (PropertyCode)
+ (void)modelStrWithDict:(NSDictionary *)dict
{
    NSMutableString *strM = [NSMutableString string];
    
    // 遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull propertyName, id  _Nonnull value, BOOL * _Nonnull stop) {
        //        NSLog(@"%@ %@",propertyName,[value class]);
        NSString *code;
        
        if ([value isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",propertyName]
            ;
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) int %@;",propertyName]
            ;
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFArray")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",propertyName]
            ;
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",propertyName]
            ;
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",propertyName]
            ;
        }
        [strM appendFormat:@"\n%@\n",code];
        
    }];
    
    NSLog(@"%@",strM);
}
@end
