//
//  RootViewController.h
//  CategorySelection
//
//  Created by xcode4 on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
    NSArray *data;
}

@end
