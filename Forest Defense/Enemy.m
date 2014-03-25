//
//  Enemy.m
//  Forest Defense
//
//  Created by Justin Keefer on 3/22/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "Enemy.h"
#import "Tower.h"
#import "Waypoint.h"

#define HEALTH_BAR_WIDTH 20
#define HEALTH_BAR_ORIGIN -10

@implementation Enemy

@synthesize sprite, game;

-(id)initWithTheGame:(Level_1_1 *)_game
{
    
    if ((self=[super init]))
    {
        game = _game;
        
        //Set the MaxHP to 40
        maxHP = 40;
        
        currentHP = maxHP;
        
        //The Enemey is not currently Active
        active = NO;
        
        //Walking Speed
        walkingSpeed = 0.5;
        
        //The image for the enemy
        sprite = [CCSprite spriteWithFile:@"goblin.png"];
        
        attackedBy = [[NSMutableArray alloc] initWithCapacity:5];
        
        [self addChild:sprite];
        
        //Get the current waypoint
        Waypoint * waypoint = (Waypoint *)[game.waypoints objectAtIndex:([game.waypoints count]-1)];
        
        //get the next waypoint from the current waypoint
        destWay = waypoint.nextWay;
        
        //set enemy to starting waypoint position
        CGPoint pos = waypoint.position;
        
        //set image on screen to starting waypoint position
        [sprite setPosition:pos];
        
        //add Enemy to the scene
        [game addChild:self];
        
        //update the screen
        [self scheduleUpdate];
        
    }
    
    return self;
    
    
    
}

+(id)nodeWithTheGame:(Level_1_1*)_game {
    return [[self alloc] initWithTheGame:_game];
}

//activate the enemy
-(void)doActivate
{
    active = YES;
}

//this code block is called every frame
-(void)update:(ccTime)dt
{
    if(!active)return;
    
    //check to see if enemy is at the next waypoint
    if([game circle:position withRadius:1 collisionWithCircle:destWay.position
collisionCircleRadius:1])
    {
        //if there is another waypoint, go to that
        if(destWay.nextWay)
        {
            destWay = destWay.nextWay;
        }else
        {
            //Reached the end of the road. Damage the player
            [game getHpDamage];
            [self getRemoved];
        }
    }
    
    //this next block of code is to move the Enemy
    CGPoint targetPoint = destWay.position;
    float movementSpeed = walkingSpeed;
    
    CGPoint normalized = ccpNormalize(ccp(targetPoint.x-position.x,targetPoint.y-position.y));
    sprite.rotation = CC_RADIANS_TO_DEGREES(atan2(normalized.y,-normalized.x));
    
    
    position = ccp(position.x+normalized.x * movementSpeed,
                   position.y+normalized.y * movementSpeed);
    
    [sprite setPosition:position];
    
    
}

//remove the enemy from the game
-(void)getRemoved
{
    //
    for(Tower * attacker in attackedBy)
    {
        [attacker targetKilled];
    }
    
    [self.parent removeChild:self cleanup:YES];
    [game.enemies removeObject:self];
    
    //Notify the game that we killed an enemy so we can check if we can send another wave
    [game enemyGotKilled];
}

//This code block will draw a health bar above the enemy image
-(void)draw
{
    ccDrawSolidRect(ccp(position.x+HEALTH_BAR_ORIGIN,
                        position.y+16),
                    ccp(position.x+HEALTH_BAR_ORIGIN+HEALTH_BAR_WIDTH,
                        position.y+14),
                    ccc4f(1.0, 0, 0, 1.0));
    
    ccDrawSolidRect(ccp(position.x+HEALTH_BAR_ORIGIN,
                        position.y+16),
                    ccp(position.x+HEALTH_BAR_ORIGIN + (float)(currentHP * HEALTH_BAR_WIDTH)/maxHP,
                        position.y+14),
                    ccc4f(0, 1.0, 0, 1.0));
}

// keep track of what tower is attacking the Enemy
-(void)getAttacked:(Tower *)attacker
{
    [attackedBy addObject:attacker];
}

//when the tower can't see the attacker anymore, stop tracking the tower
-(void)gotLostSight:(Tower *)attacker
{
    [attackedBy removeObject:attacker];
}

//if "arrow" his the enemy, then decrease the current HP
-(void)getDamaged:(int)damage
{
    currentHP -=damage;
    if(currentHP <=0)
    {
        [self getRemoved];
    }
}



@end
