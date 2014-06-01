//
//  SquareNode.h
//  π
//
//  Created by John Clem on 5/31/14.
//  Copyright (c) 2014 Mind Diaper, LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "_MyScene.h"

@interface SquareNode : SKSpriteNode

@property (nonatomic, getter = isLitUp, setter = lightUp:) BOOL litUp;
@property (nonatomic) kBarColor barColor;
@end
