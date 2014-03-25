//
//  Enemy.h
//  Forest Defense
//
//  Created by Justin Keefer on 3/22/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "cocos2d.h"
#import "Level_1_1.h"

@class Level_1_1, Waypoint, Tower;

@interface Enemy : CCNode
{
    //Will define the position of the Enemy on the screen
    CGPoint position;
    //Will define the MAX HP of the Enemy
    int maxHP;
    //The Current HP of the Enemy
    int currentHP;
    //The walking speed of the Enemy
    float walkingSpeed;
    //The waypoint that the Enemy is walking to on the screen
    Waypoint * destWay;
    //Is the Enemy Active
    BOOL active;
    //What Towers are attacking the Enemy
    NSMutableArray *attackedBy;
    
}

@property (nonatomic, assign) Level_1_1 * game;
//the image for the enemy
@property (nonatomic, assign) CCSprite * sprite;

+(id)nodeWithTheGame:(Level_1_1*)_game;
-(id)initWithTheGame:(Level_1_1*)_game;
-(void)doActivate;
-(void)getRemoved;
-(void)getAttacked:(Tower *)attacker;
-(void)gotLostSight:(Tower *)attacker;
-(void)getDamaged:(int)damage;


@end
