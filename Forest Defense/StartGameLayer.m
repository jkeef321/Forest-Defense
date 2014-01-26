//
//  StartGameLayer.m
//  Forest Defense
//
//  Created by Justin Keefer on 1/18/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "StartGameLayer.h"
#import "MainMenuLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - StartGameLayer

@implementation StartGameLayer

// Helper class method that creates a Scene with the StartGameLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	StartGameLayer *layer = [StartGameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        //create a Start Level1 1 menu item
        CCMenuItem *level1_1 = [CCMenuItemFont itemWithString:@"Level 1-1" target:self selector:@selector(startLvl1_1)];
        
        //create a Start Level1 1 menu item
        CCMenuItem *mainMenu = [CCMenuItemFont itemWithString:@"Main Menu" target:self selector:@selector(mainMenu)];
        
        //add startgame, helpscreen, and aboutscreen to menu item
        CCMenu *myMenu = [CCMenu menuWithItems: level1_1, mainMenu, nil];
		
        //aligh the items horizontally
        [myMenu alignItemsHorizontallyWithPadding:20];
        
        //set menu position
		[myMenu setPosition:ccp( size.width/2, size.height/2 - 50)];
        
        //add menu to the layer
        [self addChild: myMenu];
		
        
	}
	return self;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

//this function will move the game to the Level 1-1 layer
- (void) startLvl1_1
{
    NSLog(@"Start Level 1 1");
    
}

//this function will move the game back to the main menu
- (void) mainMenu
{
    NSLog(@"Back to the Main Menu");
    
    [[CCDirector sharedDirector] replaceScene: [MainMenuLayer scene]];
    
}

@end
