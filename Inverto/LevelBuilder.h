//
//  LevelBuilder.h
//  Inverto
//
//  Created by Marcus Stenbeck on 2012-10-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelLayer.h"


@interface LevelBuilder : NSObject <NSXMLParserDelegate>

+(LevelLayer*) createLevel:(NSString*)levelName;

@end
