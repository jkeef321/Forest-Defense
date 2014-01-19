//
//  MainMenuLayer.m
//  Forest Defense
//
//  Created by Justin Keefer on 12/21/13.
//  Copyright Justin Keefer 2013. All rights reserved.
//


// Import the interfaces
#import "MainMenuLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - MainMenuLayer

// MainMenuLayer implementation
@implementation MainMenuLayer

// Helper class method that creates a Scene with the MainMenuLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
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
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Forest Defense" fontName:@"Marker Felt" fontSize:64];

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
        //create a startGame menu item
        CCMenuItem *startGame = [CCMenuItemFont itemWithString:@"Start Game" target:self selector:@selector(startGame)];
        
        //create a help menu item
        CCMenuItem *helpScreen = [CCMenuItemFont itemWithString:@"Help" target:self selector:@selector(helpScreen)];
        
        //create a about menu item
        CCMenuItem *aboutScreen = [CCMenuItemFont itemWithString:@"About" target:self selector:@selector(aboutScreen)];
        
        //add startgame, helpscreen, and aboutscreen to menu item
        CCMenu *myMenu = [CCMenu menuWithItems: startGame, helpScreen, aboutScreen, nil];
		
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

//this function will move the game to the start game layer
- (void) startGame
{
    NSLog(@"Start Game");
    
}

//this function will move the game to the help screen layer
- (void) helpScreen
{
    NSLog(@"Help Screen");
}

//this function will move the game to the about screen layer
- (void) aboutScreen
{
    NSLog(@"About Screen");
}

@end
