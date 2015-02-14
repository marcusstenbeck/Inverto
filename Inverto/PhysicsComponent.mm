//
//  PhysicsComponent.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PhysicsComponent.h"

// Needed for level representation
// TODO: Don't depend on HelloWorldLayer!
#import "LevelLayer.h"

// TODO: Get PTM_RATIO elsewhere
//#define PTM_RATIO 32.0

@implementation PhysicsComponent

@synthesize go = _go;

-(id)initWithGameObject:(CCNode<GameObject> *)go
{
    self.go = go;
    
    NSLog(@"(%@): -(id)initWithGameObject:(CCNode<GameObject> *)go", self);
    
    return self;
}

-(void)setPhysicsBody:(b2Body *)body
{
    _pBody = body;
}

-(void)update:(ccTime)dt
{
    //
}

-(void)receive:(NSString *)message from:(id)sender
{
    // 
}

@end
