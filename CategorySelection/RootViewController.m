//
//  RootViewController.m
//  CategorySelection
//
//  Created by xcode4 on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "WACategorySelectionView.h"

@implementation RootViewController

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    data = [NSArray arrayWithObjects:@"General", @"Career", @"Family", @"Health", @"Recreation", @"Finance", @"Sports", @"Fitness", @"Travel", @"Spirituality",  nil];
    [data retain];
    WACategorySelectionView *picker = [[WACategorySelectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    picker.backgroundColor = [UIColor clearColor];
    picker.delegate = self;
    picker.dataSource = self;
    [self.view addSubview:picker];
    [picker release];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"Selected item: %@",[self pickerView:pickerView titleForRow:row forComponent:component]);
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 0;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return data.count;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    [formatter setNumberStyle: NSNumberFormatterSpellOutStyle];
//    [formatter setLocale:]; // Set locale if you want to use something other then the current one
//    return [formatter stringFromNumber:[NSNumber numberWithInt: 10 + row+1]];
    return [data objectAtIndex:row];
}

@end
