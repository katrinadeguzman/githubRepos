//
//  Repos.h
//  GithubRepos
//
//  Created by Katrina de Guzman on 2017-06-19.
//  Copyright © 2017 Katrina de Guzman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repos : NSObject

@property (nonatomic) NSString *name;

- (instancetype)initWithName:(NSString*)name;

@end
