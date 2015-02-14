//
//  GraphicsComponent.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "GraphicsComponent.h"


@implementation GraphicsComponent

@synthesize go = _go;
@synthesize sprite = _sprite;

-(id) init
{
    self.sprite = [CCSprite spriteWithFile:@"blocks.png"];
    
    return self;
}

-(id)initWithGameObject:(CCNode<GameObject> *)go
{
    [self init];
    
    self.go = go;
    
    return self;
}

-(void)update:(ccTime)dt
{
    //NSLog(@"GraphicsComponent update");
    
    self.sprite.position = self.go.position;
    self.sprite.rotation = self.go.rotation;
    self.sprite.scaleX = self.go.scaleX;
//    self.sprite.scaleY = self.go.scaleY;
    
    // Test messaging system
    //[self.go send:@"I'm a GraphicsComponent, and I just performed an update!"];
}

-(void) receive:(NSString *)message from:(id)sender
{
    //NSLog(@"GraphicsComponent recieved message: %@", message);
}

@end
