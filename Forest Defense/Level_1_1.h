//
//  Level_1_1.h
//  Forest Defense
//
//  Created by Justin Keefer on 2/7/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Player.h"

// Level_1_1
@interface Level_1_1 : CCLayer
{
    NSMutableArray *towerLocations;
    
    //this will keep track of what "wave" of enemies the game is on
    int wave;
    
    //this label will display what wave
    CCLabelBMFont * ui_wave_label;
    
    CCLabelBMFont * ui_hp_label;
    BOOL gameOver;
}

//create an array to track towers that are built in the game
@property (nonatomic, strong) NSMutableArray * towers_in_game;

//create an array to track the waypoints in the scene
@property (nonatomic, strong) NSMutableArray *waypoints;

//create an array to track the enemies in the scene
@property (nonatomic, strong) NSMutableArray *enemies;

@property (nonatomic) Player * currentPlayer;

// returns a CCScene that contains the Level_1_1 as the only child
+(CCScene *) scene;

//this method will determine if there is a collision between the two circles
-(BOOL)circle:(CGPoint)circlePoint withRadius:(float)radius collisionWithCircle:(CGPoint)circlePointTwo collisionCircleRadius:(float)radiusTwo;

//this method will be called when an enemey will be killed in the level
-(void) enemyGotKilled;

//this method will handle the game over
-(void)doGameOver;

-(void)getHpDamage;

@end
