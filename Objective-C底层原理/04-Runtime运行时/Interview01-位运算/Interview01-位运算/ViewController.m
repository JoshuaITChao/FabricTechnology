//
//  ViewController.m
//  Interview01-位运算
//
//  Created by rz-technology on 2020/5/26.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"

//typedef enum {
//    MCOptionsOne = 1,       // 0b0001
//    MCOptionsTwo = 2,       // 0b0010
//    MCOptionsThreee = 4,    // 0b0100
//    MCOptionsFour = 8       // 0b1000
//} MCOptions;

typedef enum {
    MCOptionsOne = 1<<0,        // 0b0001
    MCOptionsTwo = 1<<1,        // 0b0010
    MCOptionsThree = 1<<2,      // 0b0100
    MCOptionsFour = 1<<3        // 0b1000
}MCOptions;

@interface ViewController ()

@end

@implementation ViewController

- (void)test
{
    
}

- (void)setOptions:(MCOptions)opt
{
    if(opt & MCOptionsOne){
        NSLog(@"包含了MCOptionsOne");
    }
    if(opt & MCOptionsTwo){
        NSLog(@"包含了MCOptionsTwo");
    }
    if(opt & MCOptionsThree){
        NSLog(@"包含了MCOptionsThree");
    }
    if(opt & MCOptionsFour){
        NSLog(@"包含了MCOptionsFour");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [self performSelector:@selector(test)];
    
    // self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    
    // [self setOptions:MCOptionsOne | MCOptionsFour];
    [self setOptions:MCOptionsOne + MCOptionsTwo + MCOptionsFour];
}


@end
