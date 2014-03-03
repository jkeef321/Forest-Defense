//
//  Tower.m
//  Forest Defense
//
//  Created by Justin Keefer on 3/2/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "Tower.h"

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

@end
