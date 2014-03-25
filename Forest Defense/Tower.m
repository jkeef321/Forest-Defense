//
//  Tower.m
//  Forest Defense
//
//  Created by Justin Keefer on 3/2/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "Tower.h"
#import "Enemy.h"

@implementation Tower

//getters and setters
@synthesize tower_sprite, scene;

//this is the incode constructor
+(id) nodeWithTheGame:(Level_1_1*)_scene location:(CGPoint)location
{
    return [[self alloc] initWithTheGame:_scene location:location];
}

//this is the constructor
-(id) initWithTheGame:(Level_1_1 *)_scene location:(CGPoint)location
{
    if( (self=[super init]))
    {
        scene = _scene;
        
        range = 70;
        damage = 10;
        fire_rate = 1;
        
        
        //add an image to your sprite
        tower_sprite = [CCSprite spriteWithFile:@"watch_tower.png"];
        
        //add child to "self"... you will add yourself to the scene... which is level_1_1
        [self addChild:tower_sprite];
        
        //set the position of the sprite on the screen
        [tower_sprite setPosition:location];
        
        //add the "tower" to the scene
        [scene addChild:self];
        
        //update the scene to display the new images
        [self scheduleUpdate];
        
    }
    
    return self;
}

//Attack the Enemy!!
-(void)attackEnemy
{
    //schedule the "shootweapon" function at the "fire_rate" interval
    [self schedule:@selector(shootWeapon) interval:fire_rate];
}

//Once an Enemy is chosen for attack, then schedule the attack
-(void)chosenEnemyForAttack:(Enemy *)enemy
{
    chosenEnemy = nil;
    chosenEnemy = enemy;
    [self attackEnemy];
    [enemy getAttacked:self];
    
}

//this function will create an "arrow" on screen and fire it towards the enemy, by first starting at the tower and going to the enemy
-(void)shootWeapon
{
    CCSprite * arrow = [CCSprite spriteWithFile:@"arrow.png"];
    [scene addChild:arrow];
    [arrow setPosition:tower_sprite.position];
    [arrow runAction:[CCSequence actions:
                      [CCMoveTo actionWithDuration:0.1 position:chosenEnemy.sprite.position],
                      [CCCallFunc actionWithTarget:self selector:@selector(damageEnemy)],
                      [CCCallFuncN actionWithTarget:self selector:@selector(removeArrow:)], nil]];
    
}

//remove the arrow from the scene once it hits the target
-(void)removeArrow:(CCSprite *)arrow
{
    
    [arrow.parent removeChild:arrow cleanup:YES];
}

//damage the enemy if it is hit by the arrow
-(void)damageEnemy
{
    [chosenEnemy getDamaged:damage];
}

//if the target has been killed, unschedule the GUNS!
-(void)targetKilled
{
    
    if(chosenEnemy)
        chosenEnemy = nil;
    
    [self unschedule:@selector(shootWeapon)];
    
}


//if the target has gone out of sit, then unschedule the firing
-(void)lostSightOfEnemy
{
    [chosenEnemy gotLostSight:self];
    if(chosenEnemy)
        chosenEnemy =nil;
    
    [self unschedule:@selector(shootWeapon)];
}


//this function will be called each frame
-(void)update:(ccTime)dt {
    
    if(chosenEnemy)
    {
        
        if(![scene circle:tower_sprite.position withRadius:range
      collisionWithCircle:chosenEnemy.sprite.position collisionCircleRadius:1])
        {
            //the current enemy is out of range, deselect and stop firing
            [self lostSightOfEnemy];
        }
    } else {
        for(Enemy * enemy in scene.enemies)
        {
            if([scene circle:tower_sprite.position withRadius:range
         collisionWithCircle:enemy.sprite.position collisionCircleRadius:1])
            {
                //since the enemy is in range, FIRE!!
                [self chosenEnemyForAttack:enemy];
                break;
            }
        }
    }
    
    
}

@end
