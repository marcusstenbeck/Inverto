//
//  MoverComponent.m
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MoverComponent.h"

@implementation MoverComponent

@synthesize go = _go;

-(id)initWithGameObject:(CCNode<GameObject> *)go
{
    [self init];
    
    self.go = go;
    
    return self;
}

-(void)update:(ccTime)dt
{
    //NSLog(@"MoverComponent: update not implemented");
}

-(void)receive:(NSString *)message from:(id)sender
{
    //NSLog(@"MoverComponent: received message: %@", message);
    
    if( [message isEqualToString:@"player_jump"] )
    {
        [self jump];
    }
    
    if( [message isEqualToString:@"player_move_right"] )
    {
        CGPoint p = self.go.position;
        p.x++;
        self.go.position = p;
    }
}

-(void)jump
{
    NSLog(@"MoverComponent: Jump!");
}

@end
