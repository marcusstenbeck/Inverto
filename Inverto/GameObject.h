//
//  GameObject.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

// TODO: Send method to make sure we can message all our components!

@protocol GameObject

// TODO: Change to platform agnostic level representation
@property (assign) CCLayer* level;

@required
-(id)initWithLevel:(CCLayer *)level;

-(void) update:(ccTime)dt;

@required
-(void) send:(NSString*)message from:(id)sender;


@end
