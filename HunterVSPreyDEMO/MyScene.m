//
//  MyScene.m
//  HunterVSPreyDEMO
//
//  Created by fox on 14-3-6.
//  Copyright (c) 2014年 fox. All rights reserved.
//

#import "MyScene.h"

@implementation Food
- (void)flash{
    SKAction *fadeOut=[SKAction fadeOutWithDuration:1];
    SKAction *fadeIn=[SKAction fadeInWithDuration:1];
    SKAction *flash=[SKAction sequence:@[fadeOut,fadeIn]];
    SKAction *flashFiveTimes=[SKAction repeatAction:flash count:5];
    [self runAction:flashFiveTimes];
}
@end

@implementation MyScene

SKSpriteNode *backgroud;
SKSpriteNode *hunter;
SKSpriteNode *arrowUp;
SKSpriteNode *arrowDown;
SKSpriteNode *arrowLeft;
SKSpriteNode *arrowRight;
SKLabelNode *labelX;
SKLabelNode *labelY;
SKSpriteNode *bod;
const float speed=18.0;
const float fontsz=7.0;

int run=0;
//CGPoint *start=CGPointMake(240, 160);

//NSValue *value=[NSValue valueWithCGPoint:CGPointMake(240.0, 160.0)];

NSMutableArray *preyArray;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup scene here */
        SKTexture *back=[SKTexture textureWithImageNamed:@"background.png"];
        backgroud = [SKSpriteNode spriteNodeWithTexture:back size:CGSizeMake(480,320)];
        [backgroud setName:@"background"];
        [backgroud setAnchorPoint:CGPointZero];
        //backgroud.position=CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        backgroud.position=CGPointZero;
        //NSLog(NSStringFromCGSize(backgroud.size));
        [self addChild:backgroud];
        
        //hunter init
        hunter = [SKSpriteNode spriteNodeWithImageNamed:@"scor"];
        hunter.position = CGPointMake(CGRectGetMidX(self.frame)+20,
                                      CGRectGetMidY(self.frame));
        [hunter setSize:CGSizeMake(25.0, 25.0)];
        [self addChild:hunter];
        bod=[SKSpriteNode spriteNodeWithImageNamed:@"point"];
        bod.name=@"point";
        bod.position=CGPointMake(430, 240);
        [self addChild:bod];
        
        //random the prey location
        SKTexture *preyTextures=[SKTexture textureWithImageNamed:@"stonegezi"];
        arrowUp=[SKSpriteNode spriteNodeWithTexture:preyTextures size:CGSizeMake(28,28)];
        arrowDown=[SKSpriteNode spriteNodeWithTexture:preyTextures size:CGSizeMake(28,28)];
        arrowLeft=[SKSpriteNode spriteNodeWithTexture:preyTextures size:CGSizeMake(28,28)];
        arrowRight=[SKSpriteNode spriteNodeWithTexture:preyTextures size:CGSizeMake(28,28)];
        arrowUp.position=CGPointMake(430, 70);
        arrowDown.position=CGPointMake(430, 10);
        arrowLeft.position=CGPointMake(400, 40);
        arrowRight.position=CGPointMake(460, 40);
        
        [self addChild:arrowUp];
        [self addChild:arrowDown];
        [self addChild:arrowLeft];
        [self addChild:arrowRight];
        /*
        for (int i=0;i<7;i++){
            prey=[SKSpriteNode spriteNodeWithTexture:preyTextures size:CGSizeMake(31, 34)];
            prey.userInteractionEnabled=NO;
            float x=(rand())%480;
            float y=(rand())%320;
            prey.position=CGPointMake(x,y);
            prey.alpha=0.67;
            prey.name=@"prey";
            //NSLog(NSStringFromCGPoint(CGPointMake(120, 60)));
            [self addChild:prey];
        }
        */
        //NSLog(NSStringFromCGPoint(CGPointMake(CGRectGetMaxX(self.frame),
          //                        CGRectGetMaxY(self.frame))));
        
        
    }
    return self;
}

//add food mothod begins
- (void) addFood{
    //creat sprite node
    SKSpriteNode *food
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch=[[event allTouches] anyObject];
    CGPoint location=[touch locationInNode:self];
    SKAction *moveUp=[SKAction moveBy:CGVectorMake(0, speed) duration:1];
    SKAction *moveDown=[SKAction moveBy:CGVectorMake(0, -speed) duration:1];
    SKAction *moveLeft=[SKAction moveBy:CGVectorMake(-speed, 0) duration:1];
    SKAction *moveRight=[SKAction moveBy:CGVectorMake(speed, 0) duration:1];
    //NSLog(NSStringFromCGPoint(location));
    
    SKAction *fadeOut=[SKAction fadeOutWithDuration:0.5];
    SKAction *fadeIn=[SKAction fadeInWithDuration:0.5];
    SKAction *flash=[SKAction sequence:@[fadeOut,fadeIn]];
    SKAction *flashFiveTimes=[SKAction repeatAction:flash count:8];
    //SKNode *node=[self nodeAtPoint:location];
    
    [bod runAction:flashFiveTimes completion:^{[bod removeFromParent];}];
    
    if ([arrowUp containsPoint:location]) {
        [hunter runAction:moveUp];
    } else
    if ([arrowDown containsPoint:location]) {
        [hunter runAction:moveDown];
    }else
    if ([arrowLeft containsPoint:location]) {
        [hunter runAction:moveLeft];
    }else
    if ([arrowRight containsPoint:location]) {
        [hunter runAction:moveRight];
    }
    
    /*
    CGPoint location=[touch locationInView:touch.view];
    if (prey.) {
        <#statements#>
    }
     */
    
}
/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    / Called when a touch begins *
    
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
*/
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
