//
//  WACategorySelectionView.h
//  CategorySelection
//
//  Created by xcode4 on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class WACategoryItem;
@interface WACategorySelectionView : UIPickerView {
    id<UIPickerViewDataSource> dataSource;
    id<UIPickerViewDelegate> delegate;
    NSMutableArray *items_;
    WACategoryItem *itemUndergoingSelection;
    int selectedIndex;
}

@property(nonatomic, readwrite) int selectedIndex;
@property(nonatomic, assign) id<UIPickerViewDataSource> dataSource;
@property(nonatomic, assign) id<UIPickerViewDelegate> delegate;

@end
