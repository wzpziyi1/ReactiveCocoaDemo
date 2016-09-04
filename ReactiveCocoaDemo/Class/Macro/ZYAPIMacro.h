//
//  ZYAPIMacro.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/1.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#ifndef ZYAPIMacro_h
#define ZYAPIMacro_h

//授权
#define kApiAuthorize [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", kWeiboAppKey, kWeiboCallBack]

//OAuth2的access_token接口
#define kApiAccessToken @"oauth2/access_token"


#endif /* ZYAPIMacro_h */
