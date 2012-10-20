//
//  InputComponent.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameComponent.h"
#import <CoreMotion/CoreMotion.h>

@interface InputComponent : CCNode<GameComponent>

@property (nonatomic, retain) CMMotionManager *motionManager;
@property (strong) CMDeviceMotion* deviceMotion;

-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event;



@end
