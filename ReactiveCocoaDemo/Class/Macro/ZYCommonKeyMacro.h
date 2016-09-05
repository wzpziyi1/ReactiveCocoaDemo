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

#define kDocumentPath [ZYFilePathUtil documentPath]

#define kCachePath [ZYFilePathUtil cachePath]

#define kLibraryPath [ZYFilePathUtil libraryPath]

#define kTmpPath [ZYFilePathUtil tmpPath]



#endif /* ZYCommonKeyMacro_h */
