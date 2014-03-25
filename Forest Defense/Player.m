//
//  Player.m
//  Forest Defense
//
//  Created by Justin Keefer on 3/25/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "Player.h"

@implementation Player

//getters and setters
@synthesize  game, currentLives;

-(id)initWithTheGame:(Level_1_1 *)_game
{
    
    if ((self=[super init]))
    {
        game = _game;
        
        //Set the Current Lives to 5
        currentLives = 5;
        
        //add Player to the scene
        [game addChild:self];
        
    }
    
    return self;
    
}

@end
