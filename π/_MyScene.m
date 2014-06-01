//
//  _MyScene.m
//  π
//
//  Created by John Clem on 5/30/14.
//  Copyright (c) 2014 Mind Diaper, LLC. All rights reserved.
//

#import "_MyScene.h"
#import "SquareNode.h"

#define kDefaultSquareWidth 220.f
#define kSmallSquareWidth 40.f
#define kDefaultXOffset 180.f

@interface _MyScene ()
{
    CGFloat kRemainderOfPi;
}
@property (nonatomic, strong) SKSpriteNode *circle;
@property (nonatomic, strong) SKAction *playSoundAction;
@property (nonatomic, strong) NSMutableArray *squares;
@property (nonatomic) BOOL isRolling;
@end

@implementation _MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {

        kRemainderOfPi = M_PI-3;
        self.backgroundColor = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1];
        
        [self setupCircle];
        [self setupSquares];
    }
    return self;
}

#pragma mark - Game Objects

- (void)setupCircle
{
    _circle = [SKSpriteNode spriteNodeWithImageNamed:@"circle"];
    [_circle setScale:1.f];
    [_circle setSize:CGSizeMake(130.f, 130.f)];
    [_circle setPosition:CGPointMake(109.5, 317.5)];
    [self addChild:_circle];
}

- (void)setupSquares
{
    _squares = [NSMutableArray new];

    for (CGFloat i=0.0; i<3.0; i++) {
        UIColor *barColor = [UIColor colorWithRed:0.498 green:0.549 blue:0.553 alpha:1];
        CGSize squareSize = CGSizeMake(kDefaultSquareWidth, 20.f);
        SquareNode *square = [SquareNode spriteNodeWithColor:barColor size:squareSize];
        square.barColor = i;
        [square setScale:1.f];
        [square setPosition:CGPointMake(kDefaultXOffset+(kDefaultSquareWidth/2.f)+(kDefaultSquareWidth*i), 5.f)];
        [_squares addObject:square];
        [self addChild:square];
    }

    // add the π square
    UIColor *barColor = [UIColor colorWithRed:0.498 green:0.549 blue:0.553 alpha:1];
    CGSize squareSize = CGSizeMake(kSmallSquareWidth, 20.f);
    SquareNode *square = [SquareNode spriteNodeWithColor:barColor size:squareSize];
    square.barColor = 3;
    [square setScale:1.f];
    [square setPosition:CGPointMake(kDefaultXOffset+(kSmallSquareWidth/2.f)+(3.f*kDefaultSquareWidth), 5.f)];
    [_squares addObject:square];
    [self addChild:square];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if ([_circle containsPoint:location] && !_isRolling) {
            [self rollFromPoint:location];
        }
    }
}

- (CGPathRef)animationPathForOffset:(CGFloat)offset
{
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(109.5, 317.5)];
    [bezierPath addCurveToPoint: CGPointMake(198, 79.5) controlPoint1: CGPointMake(134.38, 317.2) controlPoint2: CGPointMake(198, 79.5)];
    [bezierPath addLineToPoint: CGPointMake(offset, 79.5)];
    [[UIColor blackColor] setStroke];
    bezierPath.lineWidth = 10;
    [bezierPath stroke];
    return bezierPath.CGPath;
}

- (void)rollFromPoint:(CGPoint)point
{
    _isRolling = YES;

    SKAction *rotate = [SKAction rotateByAngle:-M_PI duration:1.f];
    [_circle runAction:[SKAction repeatActionForever:rotate] withKey:@"rotateWheel"];
    
    SKAction *roll = [SKAction followPath:[self animationPathForOffset:1400.f] asOffset:NO orientToPath:NO duration:6.5];
    [_circle runAction:roll];
}

-(void)update:(CFTimeInterval)currentTime
{
//    CGPoint circleCenter = _circle.position;
    for (SquareNode *square in _squares) {
        if ([square intersectsNode:_circle]) {
            [square lightUp:YES];
            if ([_squares indexOfObject:square] == 3) {
                [self performSelector:@selector(addNumbers) withObject:nil afterDelay:0.9];
            }
        }
    }
}

- (void)addNumbers
{
    SKSpriteNode *numberOne = [SKSpriteNode spriteNodeWithImageNamed:@"bracket1"];
    [numberOne setScale:1.f];
    [numberOne setPosition:CGPointMake(kDefaultXOffset+(kDefaultSquareWidth/2.f), 85.f)];
    [self addChild:numberOne];

    SKSpriteNode *numberTwo = [SKSpriteNode spriteNodeWithImageNamed:@"bracket2"];
    [numberTwo setScale:1.f];
    [numberTwo setPosition:CGPointMake(kDefaultXOffset+(kDefaultSquareWidth/2.f)+(kDefaultSquareWidth), 85.f)];
    [self addChild:numberTwo];

    SKSpriteNode *numberThree = [SKSpriteNode spriteNodeWithImageNamed:@"bracket3"];
    [numberThree setScale:1.f];
    [numberThree setPosition:CGPointMake(kDefaultXOffset+(kDefaultSquareWidth/2.f)+(kDefaultSquareWidth*2), 85.f)];
    [self addChild:numberThree];

    SKSpriteNode *remainder = [SKSpriteNode spriteNodeWithImageNamed:@"bracketRemainder"];
    [remainder setScale:1.f];
    [remainder setPosition:CGPointMake(kDefaultXOffset+(kSmallSquareWidth/2.f)+(3.f*kDefaultSquareWidth), 85.f)];
    [self addChild:remainder];

}

+ (UIColor *)barColorForIndex:(NSInteger)i
{
    UIColor *barColor;
    
    switch (i) {
        case kBarColorTurquoise:
            barColor = [UIColor colorWithRed:0.098 green:0.737 blue:0.612 alpha:1];
            break;
        case kBarColorEmerald:
            barColor = [UIColor colorWithRed:0.180 green:0.800 blue:0.443 alpha:1];
            break;
        case kBarColorPeterRiver:
            barColor = [UIColor colorWithRed:0.200 green:0.596 blue:0.859 alpha:1];
            break;
        case kBarColorAmethyst:
            barColor = [UIColor colorWithRed:0.608 green:0.349 blue:0.714 alpha:1];
            break;
        case kBarColorWetAsphalt:
            barColor = [UIColor colorWithRed:0.204 green:0.282 blue:0.369 alpha:1];
            break;
    }
    
    return barColor;

}

@end
