//
//  ViewController.m
//  GithubRepos
//
//  Created by Katrina de Guzman on 2017-06-19.
//  Copyright © 2017 Katrina de Guzman. All rights reserved.
//

#import "ViewController.h"
#import "Repos.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *reposTableView;
@property NSMutableArray* objects;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL* url = [NSURL URLWithString:@"https://api.github.com/users/katrinadeguzman/repos"];
    
    NSURLRequest* urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession* session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse* response, NSError* error)
    {
        if(error)
        {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError* jsonError = nil;
        NSArray* repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        
        if(jsonError)
        {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        NSMutableArray* reposArray = [[NSMutableArray alloc]init];
        for(NSDictionary* repo in repos)
        {
            NSString* repoName = repo[@"name"];
            NSLog(@"repo: %@", repoName);
            Repos* aRepo = [[Repos alloc]initWithName:repoName];
            [reposArray addObject:aRepo];
        }
        self.objects = reposArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.reposTableView reloadData];
        });
        
    }];
    [dataTask resume];
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.reposTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Repos *repo = self.objects[indexPath.row];
    cell.textLabel.text = repo.name;
    return cell;
}
- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}


@end
