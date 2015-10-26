//
//  ShortRamp.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-24.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Crystal.h"


@implementation Crystal

@synthesize level = _level;

@synthesize graphicsComponent = _graphicsComponent;
@synthesize physicsComponent = _physicsComponent;

-(id)initWithLevel:(LevelLayer *)level
{
    NSLog(@"Initialized Obstacle class");
    
    self.level = level;
    
    self.graphicsComponent = [[GraphicsComponent alloc] initWithGameObject:self];
    self.physicsComponent = [[PhysicsSmallWedge alloc] initWithGameObject:self];
    self.graphicsComponent.sprite = [CCSprite spriteWithFile:@"crystal.png"];
    
    
    return self;
}

-(void) update:(ccTime)dt
{
    //NSLog(@"Obstacle update");
    
    [self.physicsComponent update:dt];
    [self.graphicsComponent update:dt];
}

-(void) send:(NSString *)message from:(id)sender
{
    //NSLog(@"Obstacle sent message: %@", message);
    
    // Send message to
    [self.graphicsComponent receive:message from:sender];
    [self.physicsComponent receive:message from:sender];
}

@end
