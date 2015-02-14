//
//  GameObject.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

// TODO: Send method to make sure we can message all our components!

// In order to specify type
@class LevelLayer;

@protocol GameObject

// TODO: Change to platform agnostic level representation
@property (assign) LevelLayer *level;

@required
-(id)initWithLevel:(LevelLayer *)level;

-(void) update:(ccTime)dt;

@required
-(void) send:(NSString*)message from:(id)sender;


@end
