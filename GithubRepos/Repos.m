//
//  Repos.m
//  GithubRepos
//
//  Created by Katrina de Guzman on 2017-06-19.
//  Copyright © 2017 Katrina de Guzman. All rights reserved.
//

#import "Repos.h"

@implementation Repos

- (instancetype)initWithName:(NSString*)name
{
    
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

@end
