//
//  YPMenuComponets.h
//  Pods
//
//  Created by Yaping Liu on 3/20/19.
//

#ifndef YPMenuComponets_h
#define YPMenuComponets_h

typedef NS_ENUM(NSInteger, YPMenuControllerType) {
    YPMenuControllerSystem,
    YPMenuControllerImageOnly,
    YPMenuControllerTitleLeftImageRight,
    YPMenuControllerImageLeftTitleRight,
    YPMenuControllerImageUpTitleDown,
    YPMenuControllerTitleUpImageDown,
    YPMenuControllerCustom
};

typedef NS_ENUM(NSInteger, YPMenuControllerArrowDirection) {
    YPMenuControllerArrowDefault, // up or down based on screen location
    YPMenuControllerArrowUp,
    YPMenuControllerArrowDown,
};

#endif /* YPMenuComponets_h */
