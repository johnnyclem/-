//
//  SquareNode.m
//  π
//
//  Created by John Clem on 5/31/14.
//  Copyright (c) 2014 Mind Diaper, LLC. All rights reserved.
//

#import "SquareNode.h"

@interface SquareNode ()

@property (nonatomic, strong) SKAction *playSoundAction;
@property (nonatomic, strong) SKAction *changeColorAction;

@end

@implementation SquareNode

- (void)setBarColor:(kBarColor)barColor
{
    _barColor = barColor;
    _playSoundAction = [SKAction playSoundFileNamed:[NSString stringWithFormat:@"square_blip%d.aac", _barColor] waitForCompletion:NO];
    
    _changeColorAction = [SKAction customActionWithDuration:0.8 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        [self setColor:[_MyScene barColorForIndex:_barColor]];
    }];
}

- (void)lightUp:(BOOL)litUp
{
    if (_litUp) {
        return;
    }
    _litUp = litUp;
    
    SKAction *actions = [SKAction sequence:@[_playSoundAction, _changeColorAction]];
    [self runAction:actions];
}
@end
