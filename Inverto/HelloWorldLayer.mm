//
//  HelloWorldLayer.mm
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-16.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

@implementation HelloWorldLayer

@synthesize pWorld = _pWorld;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    //UITouch* touch = [touches anyObject];
    //in your touchesEnded event, you would want to see if you touched
    //down and then up inside the same place, and do your logic there.
    
    NSLog(@"Screen touches began");
    
    // Test the input component
    [_player.inputComponent touchesBegan:touches withEvent:event];
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Screen touches ended");
}

-(void) createPhysicsDemo
{
    self.pWorld = new b2World(b2Vec2(0, -10));
    
    m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	self.pWorld->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
	//		flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	flags += b2Draw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);

    
    
    
    
    
    
    // Define a body and set the needed parameters
    b2BodyDef roomDef;
    roomDef.position.Set(0, 0);
    
    // Create the body and attach it to the world
    b2Body *roomBody = self.pWorld->CreateBody(&roomDef);
    
    // Define the floor fixture and set the needed parameters
    b2EdgeShape edge;
    edge.Set(b2Vec2(0, 0), b2Vec2(SCREEN_WIDTH / PTM_RATIO, 0));
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &edge;
    
    // Create the fixture and attach it to the body
    roomBody->CreateFixture(&fixtureDef);
    
    // Create the left wall (reusing the fixtureDef)
    edge.Set(b2Vec2(0, 0), b2Vec2(0, SCREEN_HEIGHT / PTM_RATIO));
    roomBody->CreateFixture(&fixtureDef);
    
    // Create the ceiling (reusing the fixtureDef)
    edge.Set(b2Vec2(0, SCREEN_HEIGHT / PTM_RATIO), b2Vec2(SCREEN_WIDTH / PTM_RATIO, SCREEN_HEIGHT / PTM_RATIO));
    roomBody->CreateFixture(&fixtureDef);
    
    // Create the right wall (reusing the fixtureDef)
    edge.Set(b2Vec2(SCREEN_WIDTH / PTM_RATIO, 0), b2Vec2(SCREEN_WIDTH / PTM_RATIO, SCREEN_HEIGHT / PTM_RATIO));
    roomBody->CreateFixture(&fixtureDef);
}

-(void) draw
{
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	self.pWorld->DrawDebugData();
	
	kmGLPopMatrix();
}

-(id) init
{
	if(self = [super init])
    {
        self.isTouchEnabled = YES;
        
		// Little bit of physics setup
        [self createPhysicsDemo];
        
        NSLog(@"Player code start...");
        // Little bit of player code
		_player = [[Player alloc] initWithLevel:self];
        NSLog(@"... add player sprite to layer...");
        [self addChild:_player.graphicsComponent.sprite];
        NSLog(@"... Player code end.");
        
        
        
        NSLog(@"FairyHelper creation start...");
        // Little bit of player code
		_fairyHelper = [[FairyHelper alloc] initWithLevel:self];
        NSLog(@"... add FairyHelper sprite to layer...");
        [self addChild:_fairyHelper.graphicsComponent.sprite];
        NSLog(@"... FairyHelper code end.");
        
        
        
        NSLog(@"Fairy creation start...");
        // Little bit of player code
		_fairy = [[Fairy alloc] initWithLevel:self];
        NSLog(@"... add FollowerMover target...");
        _fairy.moverComponent.targetGo = _fairyHelper;
        NSLog(@"... add Fairy sprite to layer...");
        [self addChild:_fairy.graphicsComponent.sprite];
        NSLog(@"... Fairy code end.");
        
        
        
        
        [self scheduleUpdate];
	}
	return self;
}

-(void) update:(ccTime)dt
{
    // COMMENT: Maybe this is the integration resolution
    self.pWorld->Step(dt, 10, 10);
    self.pWorld->DrawDebugData();
    
    // Update the game objects
    // TODO: Update automatically from an array
    [_player update:dt];
    [_fairyHelper update:dt];
    [_fairy update:dt];
}

-(void) dealloc
{
    // Now handled by synthesize?
    /*
	delete _world;
	_world = NULL;
	*/
    
	delete m_debugDraw;
	m_debugDraw = NULL;
	
	[super dealloc];
}

@end
