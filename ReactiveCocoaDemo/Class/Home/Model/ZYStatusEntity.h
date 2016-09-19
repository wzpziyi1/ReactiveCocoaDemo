//
//  ZYStatusEntity.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/19.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYBaseEntity.h"

@interface ZYStatusEntity : ZYBaseEntity
@property (nonatomic, assign) BOOL favorited;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, assign) int id;

@property (nonatomic, assign) BOOL truncated;

@property (nonatomic, copy) NSString *in_reply_to_screen_name;

@property (nonatomic, assign) BOOL isLongText;

@property (nonatomic, assign) int is_show_bulletin;



@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *idstr;

@property (nonatomic, copy) NSString *gif_ids;

@property (nonatomic, assign) int hasActionTypeCard;

@property (nonatomic, assign) int source_type;



@property (nonatomic, assign) int comments_count;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, assign) int source_allowclick;

@property (nonatomic, assign) int biz_feature;



@property (nonatomic, assign) int positive_recom_flag;



@property (nonatomic, copy) NSString *in_reply_to_status_id;

@property (nonatomic, copy) NSString *mid;

@property (nonatomic, assign) int reposts_count;

@property (nonatomic, assign) int mlevel;

@property (nonatomic, assign) int attitudes_count;



@property (nonatomic, copy) NSString *rid;

@property (nonatomic, assign) int userType;

@property (nonatomic, copy) NSString *in_reply_to_user_id;
@end
