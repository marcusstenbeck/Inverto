//
//  HelloWorldLayer.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-16.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"

// We use the Player class
#import "Player.h"
#import "Fairy.h"
#import "FairyHelper.h"

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32

// TODO: Set these dynamically instead
#define SCREEN_WIDTH 480
#define SCREEN_HEIGHT 320

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
	Player* _player;
    Fairy* _fairy;
    FairyHelper* _fairyHelper;
    Fairy* _cameraTarget;
    
    GLESDebugDraw *m_debugDraw;		// strong ref
}

@property (assign) b2World* pWorld;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
