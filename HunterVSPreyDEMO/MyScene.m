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
        
        //self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        backgroud = [SKSpriteNode spriteNodeWithImageNamed:@"bg.jpg"];
        [backgroud setName:@"back"];
        [backgroud setAnchorPoint:CGPointZero];
        
        CGPoint center = CGPointMake(CGRectGetMidX(self.frame),
                                    CGRectGetMidY(self.frame));
        
        //NSValue *value=[NSValue valueWithCGPoint:center];
        //preyArray=[NSMutableArray arrayWithObject:value];

        hunter = [SKSpriteNode spriteNodeWithImageNamed:@"scor"];
        hunter.position = center;
        
        labelX=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        labelX.fontSize = fontsz;
        labelX.text = [NSString stringWithFormat:@"%f",center.x];
        labelX.position=CGPointMake(CGRectGetMidX(self.frame)+50,
                                   CGRectGetMidY(self.frame)+50);
        labelY=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        labelY.fontSize = fontsz;
        labelY.text = [NSString stringWithFormat:@"%f",center.y];
        labelY.position=CGPointMake(CGRectGetMidX(self.frame)+50,
                                    CGRectGetMidY(self.frame)+80);
        
        
        
        [self addChild:backgroud];
        [self addChild:hunter];
        //[self addChild:labelX];
        //[self addChild:labelY];
    }
    return self;
}

-(void) block{
    [preyArray removeObjectAtIndex:0];
    run=0;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        NSValue *value=[NSValue valueWithCGPoint:location];
        [preyArray addObject:value];
        if (!run){
            run=1;
            CGPoint positionOfHunter=hunter.position;
            
            float deltaX,deltaY;
            //CGPoint location=[[preyArray objectAtIndex:0] CGPointValue];
            deltaX=[[preyArray objectAtIndex:0] CGPointValue].x-positionOfHunter.x;
            deltaY=[[preyArray objectAtIndex:0] CGPointValue].y-positionOfHunter.y;
            //CGPoint deltaPoint=CGPointMake(deltaX, deltaY);
            //NSLog(NSStringFromCGPoint(deltaPoint));
            SKAction *actionx=[SKAction moveByX:deltaX/speed y:0 duration:1];
            SKAction *actiony=[SKAction moveByX:0 y:deltaY/speed duration:1];
            SKAction *sequence=[SKAction sequence:@[actionx, actiony]];
            
            //[hunter runAction:actionx];
            //[hunter runAction:actiony];
            [hunter runAction:[SKAction repeatAction:sequence count:speed] completion:^{
                [preyArray removeObjectAtIndex:0];
                run=0;}];
            /*
            if (hunter.position.x==location.x && hunter.position.y==location.y){
                NSLog(@"RUN here");

                [preyArray removeObjectAtIndex:0];
                run=0;
            }*/
            
            
        }
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
