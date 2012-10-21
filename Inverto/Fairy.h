//
//  Fairy.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphicsComponent.h"
#import "FollowerMover.h"
#import "CourierComponent.h"

@interface Fairy : CCNode<GameObject>

@property (assign) GraphicsComponent *graphicsComponent;
@property (assign) FollowerMover *moverComponent;
@property (assign) CourierComponent *courierComponent;

@end
