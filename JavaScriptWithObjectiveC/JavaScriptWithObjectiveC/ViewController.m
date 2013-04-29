//
//  ViewController.m
//  JavaScriptWithObjectiveC
//
//  Created by thanhnv on 4/29/13.
//  Copyright (c) 2013 Techmaster. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *_dataArray;
    AVAudioPlayer *_audioPlayer;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
        
    NSString *pathname = [[NSBundle mainBundle]  pathForResource:@"index" ofType:@"html" inDirectory:@"/"];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:pathname encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSURL *url = request.URL;
        if([url.scheme isEqualToString:@"techmaster"]){
            NSString *functionName=url.host;
            SEL selector = NSSelectorFromString(functionName);
            [self performSelector:selector];
        }
    }
}
-(void)playMusic{
    NSLog(@"Music Player");
    [self playASound:@"background"];
}
- (IBAction)drawChart:(id)sender {
    NSString *_path=[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    _dataArray=[[NSArray alloc]initWithContentsOfFile:_path];

    NSString *arrayStr = [_dataArray componentsJoinedByString:@","];
    NSString *jsFunc = [NSString stringWithFormat:@"drawChart([%@])", arrayStr];
    [self.webView stringByEvaluatingJavaScriptFromString:jsFunc];
    
}


- (void)playASound:(NSString *)fileName {
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath],fileName]];
    NSError *error;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    _audioPlayer.numberOfLoops = 0;
    _audioPlayer.volume = 1;
    [_audioPlayer play];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
