//
//  MyScene.h
//  HunterVSPreyDEMO
//

//  Copyright (c) 2014年 fox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene

@end

@interface Food : SKSpriteNode{
    NSString *name;//the name of food
    int lifeTime;//the life time of a food (second)
    int power;/*the power of the food:
               1 for acceleration
               2 for invincible
               3 for unstoppable
               4 for heal*/
}

- (void)flash;

@end
