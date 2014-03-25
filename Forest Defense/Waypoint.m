//
//  Waypoint.m
//  Forest Defense
//
//  Created by Justin Keefer on 3/22/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "Waypoint.h"

@implementation Waypoint

@synthesize position, nextWay;

-(id)initWithTheGame:(Level_1_1 *)_game location:(CGPoint)location
{
    
    if( (self=[super init]))
    {
        level = _game;
        
        //set position of the waypoint
        [self setPosition:CGPointZero];
        position = location;
        
        //add the waypoint to the scene
        [level addChild:self];
        
    }
    
    return self;
    
}


+(id)nodeWithTheGame:(Level_1_1 *)_game location:(CGPoint)location
{
    return [[self alloc] initWithTheGame:_game location:location];
}


@end
