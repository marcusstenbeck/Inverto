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

@synthesize graphicsComponent = _graphicsComponent;
@synthesize inputComponent = _inputComponent;
@synthesize moverComponent = _moverComponent;

-(id)initWithLevel:(LevelLayer *)level
{
    NSLog(@"Initialized FairyHelper object");
    
    self.level = level;
    
    self.graphicsComponent = [[GraphicsComponent alloc] initWithGameObject:self];
    self.moverComponent = [[FairyMover alloc] initWithGameObject:self];
    self.inputComponent = [[InputComponent alloc] initWithGameObject:self];
    
    self.graphicsComponent.sprite.opacity = 0;
    
    return self;
}

-(void)send:(NSString *)message from:(id)sender
{
    //NSLog(@"FairyHelper sent message: %@", message);
    
    // Send message to
    [self.graphicsComponent receive:message from:sender];
    [self.moverComponent receive:message from:sender];
    [self.inputComponent receive:message from:sender];
}

-(void)update:(ccTime)dt
{
    //NSLog(@"FairyHelper update");
    
    [self.inputComponent update:dt];
    [self.moverComponent update:dt];
    [self.graphicsComponent update:dt];
}

@end
