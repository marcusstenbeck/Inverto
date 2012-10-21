//
//  FairyMover.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-20.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MoverComponent.h"

@interface FairyMover : MoverComponent
{
    CGPoint _centerPoint;
}

-(CGPoint)relativePosition;

@end
