//
//  Fairy.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Fairy.h"


@implementation Fairy

@synthesize level = _level;

@synthesize graphicsComponent = _graphicsComponent;
@synthesize moverComponent = _moverComponent;
@synthesize courierComponent = _courierComponent;

-(id)initWithLevel:(HelloWorldLayer *)level
{
    NSLog(@"Initialized Fairy class");
    
    self.level = level;
    
    self.graphicsComponent = [[GraphicsComponent alloc] initWithGameObject:self];
    self.moverComponent = [[FollowerMover alloc] initWithGameObject:self];
    self.courierComponent = [[CourierComponent alloc] initWithGameObject:self];
    
    self.graphicsComponent.sprite.color = ccRED;
    
    return self;
}

-(void)send:(NSString *)message from:(id)sender
{
    //NSLog(@"Fairy sent message: %@", message);
    
    // Send message to
    [self.courierComponent receive:message from:sender];
    [self.graphicsComponent receive:message from:sender];
    [self.moverComponent receive:message from:sender];
}

-(void)update:(ccTime)dt
{
    //NSLog(@"Fairy update");
    
    [self.moverComponent update:dt];
    [self.graphicsComponent update:dt];
    [self.courierComponent update:dt];
}

@end
