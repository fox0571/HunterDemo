//
//  MyScene.m
//  HunterVSPreyDEMO
//
//  Created by fox on 14-3-6.
//  Copyright (c) 2014年 fox. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

SKSpriteNode *backgroud;
SKSpriteNode *hunter;
SKLabelNode *labelX;
SKLabelNode *labelY;
const float speed=2.0;
const float fontsz=7.0;

int run=0;
//CGPoint *start=CGPointMake(240, 160);

//NSValue *value=[NSValue valueWithCGPoint:CGPointMake(240.0, 160.0)];

NSMutableArray *preyArray;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //backgroud init
        backgroud = [SKSpriteNode spriteNodeWithImageNamed:@"bg.jpg"];
        [backgroud setName:@"back"];
        [backgroud setAnchorPoint:CGPointZero];
        [self addChild:backgroud];
        //hunter init
        hunter = [SKSpriteNode spriteNodeWithImageNamed:@"scor"];
        hunter.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame));
        
        //random the prey location
        SKTexture *preyTextures=[SKTexture textureWithImageNamed:@"point.png"];
        for (int i=0;i<15;i++){
            SKSpriteNode *prey=[SKSpriteNode spriteNodeWithTexture:preyTextures size:CGSizeMake(9.0, 9.0)];
            prey.position=CGPointMake(rand()%360,rand()%480);
            //NSLog(NSStringFromCGPoint(prey.position));
            [self addChild:prey];
        }
        //NSLog(NSStringFromCGPoint(CGPointMake(CGRectGetMaxX(self.frame),
          //                        CGRectGetMaxY(self.frame))));
        
        [self addChild:hunter];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSValue *value=[NSValue valueWithCGPoint:location];
        [preyArray addObject:value];
      
        CGPoint positionOfHunter=hunter.position;
            
        float deltaX,deltaY;
        deltaX=[[preyArray objectAtIndex:0] CGPointValue].x-positionOfHunter.x;
        deltaY=[[preyArray objectAtIndex:0] CGPointValue].y-positionOfHunter.y;
        SKAction *actionx=[SKAction moveByX:deltaX/speed y:0 duration:1];
        SKAction *actiony=[SKAction moveByX:0 y:deltaY/speed duration:1];
        SKAction *sequence=[SKAction sequence:@[actionx, actiony]];
            
        [hunter runAction:actionx];
            
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"point"];
        sprite.position = location;
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        [sprite runAction:[SKAction repeatActionForever:action]];

        [self addChild:sprite];
        

        //[sprite isHidden];
        //[self removeAllChildren];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
