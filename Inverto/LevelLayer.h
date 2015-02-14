//
//  LevelLayer.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32

// TODO: Set these dynamically instead
#define SCREEN_WIDTH 480
#define SCREEN_HEIGHT 320

// We need to know about the GameObject protocol
#import "GameObject.h"

@interface LevelLayer : CCLayer
{
    CCLabelTTF *_invertedLabel;
    BOOL _inverted;
    
    GLESDebugDraw *m_debugDraw;		// strong ref
}


@property (assign) b2World *pWorld;
@property (strong) NSArray *gameObjects;

// returns a CCScene that contains the HelloWorldLayer as the only child
-(CCScene *) scene;

-(void)receive:(NSString *)message from:(id)sender;

@end
