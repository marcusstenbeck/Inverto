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

-(id)initWithLevel:(CCLayer *)level
{
    NSLog(@"Initialized Fairy class");
    
    self.level = level;
    
    _graphicsComponent = [[GraphicsComponent alloc] initWithGameObject:self];
    _moverComponent = [[FollowerMover alloc] initWithGameObject:self];
    
    _graphicsComponent.sprite.color = ccRED;
    
    return self;
}

-(void)send:(NSString *)message from:(id)sender
{
    //NSLog(@"Fairy sent message: %@", message);
    
    // Send message to
    [_graphicsComponent receive:message from:sender];
    [_moverComponent receive:message from:sender];
}

-(void)update:(ccTime)dt
{
    //NSLog(@"Fairy update");
    
    [_moverComponent update:dt];
    [_graphicsComponent update:dt];
}

@end
