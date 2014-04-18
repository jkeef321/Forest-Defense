//
//  ArcherTower.m
//  Forest Defense
//
//  Created by Justin Keefer on 4/2/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "ArcherTower.h"
#import "Tower.h"

@implementation ArcherTower


//this is the constructor
-(id) initWithTheGame:(Level_1_1 *)_scene location:(CGPoint)location
{
    if( (self=[super init]))
    {
        super.scene = _scene;
        
        super.range = 70;
        super.damage = 10;
        super.fire_rate = 1;
        
        
        //add an image to your sprite
        super.tower_sprite = [CCSprite spriteWithFile:@"watch_tower.png"];
        
        //super.tower_sprite = [CCSprite spriteWithFile:@"tower_round.png"];
        
        super.shoot_sprite = @"arrow.png";
        
        //add child to "self"... you will add yourself to the scene... which is level_1_1
        [self addChild:super.tower_sprite];
        
        //set the position of the sprite on the screen
        [super.tower_sprite setPosition:location];
        
        //add the "tower" to the scene
        [super.scene addChild:self];
        
        //update the scene to display the new images
        [self scheduleUpdate];
        
    }
    
    return self;
}



@end
