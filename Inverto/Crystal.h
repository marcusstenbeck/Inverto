//
//  ShortRamp.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-24.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"
#import "GraphicsComponent.h"
#import "PhysicsSmallWedge.h"


@interface Crystal : CCNode<GameObject>

@property (assign) GraphicsComponent* graphicsComponent;
@property (assign) PhysicsComponent* physicsComponent;

@end
