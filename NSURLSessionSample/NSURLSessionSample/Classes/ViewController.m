//
//  ViewController.m
//  NSURLSessionSample
//
//  Created by Saurav Nagpal on 17/11/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

#import "UIImage+Downlading.h"
#import "HTTPSession.h"
#import "ViewController.h"
#define imageUrl    @"http://1.bp.blogspot.com/-N2fSe2JF0rg/T-vAeJcx4tI/AAAAAAAAErU/bOy8ya936xA/s1600/Tiger+3D+Wallpapers.jpg"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*HTTPSession* httpSession = [[HTTPSession alloc] init];
    [httpSession startDownloadingDataWithUrlString:imageUrl];*/
    /*NSURL* url = [NSURL URLWithString:imageUrl];
    [UIImage imageDownloadWithUrl:url onCompletion:^(NSURL *location, NSURLResponse *response, NSError *error){
        
    }];*/
    [self performSelectorInBackground:@selector(downloadImage:) withObject:@"thread1"];
    NSThread* thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"thread2"];
    [thread start];
    [self performSelectorInBackground:@selector(downloadImage:) withObject:@"thread3"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) downloadImage:(NSString*)threadID{
    NSLog(@"EnterThread%@",threadID);
    @synchronized(self){
        NSURL* url = [NSURL URLWithString:imageUrl];
        UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        NSLog(@"thread%@",threadID);
    }
   
}

@end
