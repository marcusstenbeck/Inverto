//
//  FollowerMover.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FollowerMover.h"


@implementation FollowerMover

@synthesize targetGo = _targetGo;

-(id)initWithGameObject:(CCNode<GameObject> *)go
{
    [self init];
    
    self.go = go;
    
    self.targetGo = [CCNode node];
    
    return self;
}

-(void)update:(ccTime)dt
{
    
    // TODO: Make this use strategy
    CGPoint targetPoint = self.targetGo.position;
    CGPoint intermediatePoint = self.go.position;
    

    intermediatePoint.x = intermediatePoint.x + (targetPoint.x - intermediatePoint.x ) / 10.0;
    intermediatePoint.y = intermediatePoint.y + (targetPoint.y - intermediatePoint.y ) / 10.0;
    
    
    self.go.position = intermediatePoint;
}

@end
