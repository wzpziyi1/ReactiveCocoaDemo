//
//  ZYCommonKeyMacro.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/1.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#ifndef ZYCommonKeyMacro_h
#define ZYCommonKeyMacro_h

#define ZYWeakSelf __weak typeof(self) weakSelf = self

#define kScreenH [UIScreen mainScreen].bounds.size.height

#define kScreenW [UIScreen mainScreen].bounds.size.width

#define ZYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//十六进制的颜色转为iOS可用的UIColor
#define UIColorFromRGB(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(hexValue,alphaValue)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue]

#define kDocumentPath [ZYFilePathUtil documentPath]

#define kCachePath [ZYFilePathUtil cachePath]

#define kLibraryPath [ZYFilePathUtil libraryPath]

#define kTmpPath [ZYFilePathUtil tmpPath]



#endif /* ZYCommonKeyMacro_h */
