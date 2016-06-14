//
//  ArcDefine.h
//  MenuSifu
//
//  Created by 高磊 on 14-2-21.
//  Copyright (c) 2014年 高磊. All rights reserved.
//

#ifndef MenuSifu_ArcDefine_h
#define MenuSifu_ArcDefine_h

#ifndef MenuSifu_STRONG
    #if __has_feature(objc_arc)
        #define MenuSifu_STRONG strong
    #else
        #define MenuSifu_STRONG retain
    #endif
#endif

#ifndef MenuSifu_WEAK
    #if __has_feature(objc_arc_weak)
        #define MenuSifu_WEAK weak
    #elif __has_feature(objc_arc)
        #define MenuSifu_WEAK unsafe_unretained
    #else
        #define MenuSifu_WEAK assign
    #endif
#endif

#if __has_feature(objc_arc)
    #define MenuSifu_AUTORELEASE(expression) expression
    #define MenuSifu_RELEASE(expression) expression
    #define MenuSifu_RETAIN(expression) expression
#else
    #define MenuSifu_AUTORELEASE(expression) [expression autorelease]
    #define MenuSifu_RELEASE(expression) [expression release]
    #define MenuSifu_RETAIN(expression) [expression retain]
#endif

#endif
