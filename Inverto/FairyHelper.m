//
//  FairyHelper.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FairyHelper.h"


@implementation FairyHelper

@synthesize level = _level;

-(id)initWithLevel:(CCLayer *)level
{
    NSLog(@"Initialized FairyHelper object");
    
    self.level = level;
    
    _graphicsComponent = [[GraphicsComponent alloc] initWithGameObject:self];
    _moverComponent = [[FairyMover alloc] initWithGameObject:self];
    _inputComponent = [[InputComponent alloc] initWithGameObject:self];
    
    _graphicsComponent.sprite.color = ccGREEN;
    
    return self;
}

-(void)send:(NSString *)message from:(id)sender
{
    //NSLog(@"FairyHelper sent message: %@", message);
    
    // Send message to
    [_graphicsComponent receive:message from:sender];
    [_moverComponent receive:message from:sender];
    [_inputComponent receive:message from:sender];
}

-(void)update:(ccTime)dt
{
    //NSLog(@"FairyHelper update");
    
    [_inputComponent update:dt];
    [_moverComponent update:dt];
    [_graphicsComponent update:dt];
}

@end
