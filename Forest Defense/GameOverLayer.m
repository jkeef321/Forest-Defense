//
//  GameOverLayer.m
//  Forest Defense
//
//  Created by Justin Keefer on 3/23/14.
//  Copyright (c) 2014 Justin Keefer. All rights reserved.
//

#import "GameOverLayer.h"
#import "MainMenuLayer.h"

@implementation GameOverLayer

// Helper class method that creates a Scene with the GameOverLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOverLayer *layer = [GameOverLayer node];
	
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
        
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"You Lose!" fontName:@"Marker Felt" fontSize:64];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];

        
        //create a Main Menu item
        CCMenuItem *mainMenu = [CCMenuItemFont itemWithString:@"Main Menu" target:self selector:@selector(mainMenu)];
        
        //add Main Menu
        CCMenu *myMenu = [CCMenu menuWithItems: mainMenu, nil];
		
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



//this function will move the game back to the main menu
- (void) mainMenu
{
    NSLog(@"Back to the Main Menu");
    
    [[CCDirector sharedDirector] replaceScene: [MainMenuLayer scene]];
    
}

@end
