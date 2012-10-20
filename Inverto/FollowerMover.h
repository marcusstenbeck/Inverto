//
//  FollowerMover.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MoverComponent.h"
#import "GameObject.h"

@interface FollowerMover : MoverComponent

@property (assign) CCNode<GameObject>* targetGo;

@end
