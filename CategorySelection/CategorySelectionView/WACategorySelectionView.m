//
//  WACategorySelectionView.m
//  CategorySelection
//
//  Created by xcode4 on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WACategorySelectionView.h"

@interface WACategoryItem : UILabel {
@private
    BOOL showsSelection;
}

@property(nonatomic) BOOL showsSelection;

@end

@implementation WACategoryItem

@synthesize showsSelection;

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10.0f;
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void) setShowsSelection:(BOOL)showsSelection_ {
    showsSelection = showsSelection_;
    self.backgroundColor = showsSelection? [UIColor cyanColor]:[UIColor lightGrayColor];
}

@end

@implementation WACategorySelectionView

@synthesize delegate;
@synthesize dataSource;
@synthesize selectedIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        selectedIndex = NSNotFound;
    }
    return self;
}

- (void) setDataSource:(id<UIPickerViewDataSource>)dataSource_ {
    dataSource = dataSource_;
    [self reloadAllComponents];
}

- (void) setDelegate:(id<UIPickerViewDelegate>)delegate_ {
    delegate = delegate_;
    [self reloadAllComponents];    
}

- (void) reloadComponent:(NSInteger)component {
    [items_ release];
    
    int numberOfItems = [dataSource pickerView:self numberOfRowsInComponent:0];
    items_ = [[NSMutableArray alloc] initWithCapacity:numberOfItems];
    
    [self.subviews makeObjectsPerformSelector:@selector(removeItem:)];
    for (int i=0; i<numberOfItems; i++) {
        WACategoryItem *label = [[WACategoryItem alloc] initWithFrame:CGRectZero];
//        label.backgroundColor = [UIColor clearColor];
        label.text = [delegate pickerView:self titleForRow:i forComponent:0];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = UITextAlignmentCenter;
        [items_ addObject:label];
        [self addSubview:label];
        [label release];
    }
    [self setNeedsLayout];
}

- (void) removeItem:(UIView *) view {
    [view removeFromSuperview];
}

#define ITEM_PADDING 10
#define ITEM_MARGIN 4
#define ITEM_HEIGHT 20

- (void) layoutSubviews {
    int count = [dataSource pickerView:self numberOfRowsInComponent:0];
    int yOffset = ITEM_MARGIN;
    int xOffset = ITEM_MARGIN;
    for (int i=0; i<count; i++) {
        WACategoryItem *item = [items_ objectAtIndex:i];
        CGSize size = [item sizeThatFits:self.bounds.size];
        if (xOffset + ITEM_PADDING + size.width + ITEM_MARGIN  > self.bounds.size.width) {
            yOffset += ITEM_HEIGHT + ITEM_MARGIN;
            xOffset = ITEM_MARGIN;
        }
        item.frame = CGRectMake(xOffset, yOffset, size.width + ITEM_PADDING, ITEM_HEIGHT);
        xOffset += item.frame.size.width + ITEM_MARGIN;
    }
}

- (void) reloadAllComponents {
    [self reloadComponent:0];
}

- (void) selectItem:(WACategoryItem *) item {
    if (selectedIndex != NSNotFound) {
        WACategoryItem *pastSelectedItem = [self.subviews objectAtIndex:selectedIndex];
        pastSelectedItem.showsSelection = NO;
    }
    selectedIndex = [self.subviews indexOfObject:item];
    item.showsSelection = YES;
    [delegate pickerView:self didSelectRow:selectedIndex inComponent:0];
}

- (WACategoryItem *) itemAtPoint:(CGPoint) point {
    for (WACategoryItem *view in self.subviews) {
        if (CGRectContainsPoint(view.frame, point)) {
            return view;
        }
    }
    return nil;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    WACategoryItem *item = [self itemAtPoint:[touches.anyObject locationInView:self]];
    if (item) {
        if (selectedIndex == NSNotFound) {
            itemUndergoingSelection = item;
            item.showsSelection = YES;
            return;
        }
        WACategoryItem *selectedItem = [self.subviews objectAtIndex:selectedIndex];
        if (selectedItem != item) {
            itemUndergoingSelection = item;
            item.showsSelection = YES;
        }
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!itemUndergoingSelection) {
        return;
    }
    WACategoryItem *item = [self itemAtPoint:[touches.anyObject locationInView:self]];
    if (item != itemUndergoingSelection) {
        itemUndergoingSelection.showsSelection = NO;
        itemUndergoingSelection = nil;
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!itemUndergoingSelection) {
        return;
    }
    WACategoryItem *item = [self itemAtPoint:[touches.anyObject locationInView:self]];
    if (item == itemUndergoingSelection) {
        [self selectItem:itemUndergoingSelection];
        itemUndergoingSelection = nil;
    }    else {
        itemUndergoingSelection.showsSelection = NO;
        itemUndergoingSelection = nil;
    }
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!itemUndergoingSelection) {
        return;
    }
    itemUndergoingSelection.showsSelection = NO;
    itemUndergoingSelection = nil;
}

- (void) present {
//    [self.subviews makeObjectsPerformSelector:@selector(setHidden:) withObject:YES];
    //TODO: Present with animation.
//    int count = [dataSource pickerView:self numberOfRowsInComponent:0];
//    for (int i=0; i< count; i++) {
//        CAAnimation *animation = [CAAnimation animation];
//        WACategoryItem *item = [self.subviews objectAtIndex:0];
//    }
}

- (void) hide {
    //TODO: Hide with animation.
}

@end
