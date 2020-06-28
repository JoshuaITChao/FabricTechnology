//
//  ViewController.m
//  Interview16-方法交换的使用场景
//
//  Created by rz-technology on 2020/6/1.
//  Copyright © 2020 rz-technology. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.textfield addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    NSString *obj = nil;
    
//    NSMutableArray *array = [NSMutableArray array];
//    [array addObject:@"Jack"];
//    // [array insertObject:obj atIndex:0];
//    [array addObject:obj];
//
//    NSLog(@"%@", array);
    
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"name"] = @"Jack";
//    dict[obj] = @"rose";
//    dict[@"age"] = obj;
//
//    NSLog(@"%@", dict);
    
    NSDictionary *dict = @{
        @"name": [[NSObject alloc] init],
        @"age": @"Jack"
    };
    NSString *value = dict[nil];
    
    NSLog(@"%@",[dict class]);
    
    
    
}

- (IBAction)click1:(UIButton *)sender {
    NSLog(@"%s",__func__);
}
- (IBAction)click2:(id)sender {
     NSLog(@"%s",__func__);
}
- (IBAction)click3:(UIButton *)sender {
     NSLog(@"%s",__func__);
}

- (void)textFieldChanged:(UITextField *)textField
{
    NSLog(@"textFieldChanged----%@",textField);
}

#pragma mark - UITextField代理方法
/**
 * 默认不会调用sendAction:to:forEvent
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@-%@-%@", textField, NSStringFromRange(range), string);
    
    return YES;
}

@end
