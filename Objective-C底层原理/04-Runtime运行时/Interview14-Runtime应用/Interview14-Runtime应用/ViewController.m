//
//  ViewController.m
//  Interview14-Runtime应用
//
//  Created by rz-technology on 2020/5/29.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (int i=0; i<count; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    free(ivars);
    
    self.textfield.placeholder = @"请输入用户名";
    
    // 已经禁止使用了
//    [self.textfield setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    
//    UILabel *placeholderLabel = [self.textfield valueForKeyPath:@"_placeholderLabel"];
//    NSLog(@"placeholderLabel-----%@",placeholderLabel);
    
    self.textfield.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入用户名" attributes:@{ NSForegroundColorAttributeName: [UIColor redColor] }];
}


@end
