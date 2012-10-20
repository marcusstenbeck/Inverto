//
//  PlayerPhysicsMover.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MoverComponent.h"
#import "Box2D.h"

@interface PlayerPhysicsMover : MoverComponent
{
    b2Body* _pBody;
}

-(void) setPhysicsBody:(b2Body*)body;

@end
