//
//  _MyScene.h
//  π
//

//  Copyright (c) 2014 Mind Diaper, LLC. All rights reserved.
//

typedef NS_ENUM(NSUInteger, kBarColor) {
    kBarColorTurquoise = 0,
    kBarColorEmerald = 1,
    kBarColorPeterRiver = 2,
    kBarColorAmethyst = 3,
    kBarColorWetAsphalt = 4
};

#import <SpriteKit/SpriteKit.h>

@interface _MyScene : SKScene

+ (UIColor *)barColorForIndex:(NSInteger)i;

@end
