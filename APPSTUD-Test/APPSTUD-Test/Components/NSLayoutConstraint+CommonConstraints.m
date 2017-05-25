//  NSLayoutConstraint+CommonConstraints.M
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

#import "NSLayoutConstraint+CommonConstraints.h"

@implementation NSLayoutConstraint (CommonConstraints)

NSLayoutConstraint *getWidthConstraintForViewAndWidth(UIView *view, CGFloat width)
{
    return [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:width];
}

NSLayoutConstraint *getHeightConstraintForViewAndHeight(UIView *view, CGFloat height)
{
    return [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:height];
}

NSLayoutConstraint *getTopConstraintForViewsAndInset(UIView *view1, UIView *view2, CGFloat inset)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeTop multiplier:1.0f constant:inset];
}

NSLayoutConstraint *getBottomConstraintForViewsAndInset(UIView *view1, UIView *view2, CGFloat inset)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-inset];
}

NSLayoutConstraint *getLeftConstraintForViewsAndInset(UIView *view1, UIView *view2, CGFloat inset)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeLeft multiplier:1.0f constant:inset];
}

NSLayoutConstraint *getRightConstraintForViewsAndInset(UIView *view1, UIView *view2, CGFloat inset)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeRight multiplier:1.0f constant:-inset];
}

NSLayoutConstraint *getConstraintForVerticallyCenteredViewInView(UIView *view1, UIView *view2)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
}

NSLayoutConstraint *getConstraintForHorizontallyCenteredViewInView(UIView *view1, UIView *view2)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
}

NSLayoutConstraint *getConstraintForViewToTheLeftOfView(UIView *view1, UIView *view2, CGFloat inset)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeLeft multiplier:1.0f constant:-inset];
}

NSLayoutConstraint *getConstraintForViewToTheRightOfView(UIView *view1, UIView *view2, CGFloat inset)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeRight multiplier:1.0f constant:inset];
}

NSLayoutConstraint *getConstraintForViewBelowView(UIView *view1, UIView *view2, CGFloat inset)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeBottom multiplier:1.0f constant:inset];
}

NSLayoutConstraint *getConstraintForViewAboveView(UIView *view1, UIView *view2, CGFloat inset)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeTop multiplier:1.0f constant:-inset];
}

NSArray *getSameFrameConstraintsForViews(UIView *view1, UIView *view2)
{
    return @[getTopConstraintForViewsAndInset(view1, view2, 0),
             getLeftConstraintForViewsAndInset(view1, view2, 0),
             getRightConstraintForViewsAndInset(view1, view2, 0),
             getBottomConstraintForViewsAndInset(view1, view2, 0)
             ];
}

NSLayoutConstraint *getSameWidthConstraintForViews(UIView *view1, UIView *view2, CGFloat multiplier)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeWidth multiplier:multiplier constant:0];
}

NSLayoutConstraint *getSameLeadingConstraintForViewsAndInset(UIView *view1, UIView *view2, CGFloat inset)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeLeading multiplier:1 constant:inset];
}
NSLayoutConstraint *getSameTrailingConstraintForViewsAndInset(UIView *view1, UIView *view2, CGFloat inset)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeTrailing multiplier:1 constant:-inset];
}

NSLayoutConstraint *getSameHeightConstraintForViews(UIView *view1, UIView *view2, CGFloat multiplier)
{
    return [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeHeight multiplier:multiplier constant:0];
}

NSArray *getConstraintForElementsStackedVerticallyInView(NSArray *elements, UIView *view, CGFloat spacing, CGFloat topSpacing, CGFloat bottomSpacing, BOOL connectBottom, BOOL sameWidth, BOOL addSubViews)
{
    NSMutableArray *constraints = [NSMutableArray array];
    __block UIView *firstView;
    __block UIView *prev = view;
    [elements enumerateObjectsUsingBlock:^(UIView *v, NSUInteger idx, BOOL *stop) {
        if (addSubViews) {
            [view addSubview:v];
        }
        NSArray *newConstraints;
        if (sameWidth) {
            newConstraints = @[getSameWidthConstraintForViews(v, view, 1),
                               getLeftConstraintForViewsAndInset(v, view, 0)];
            [constraints addObjectsFromArray:newConstraints];
        }
        
        if (idx == 0) {
            firstView = v;
            newConstraints = @[getTopConstraintForViewsAndInset(v, view, topSpacing)
                            ];
            [constraints addObjectsFromArray:newConstraints];
        } else {
            newConstraints = @[getConstraintForViewBelowView(v, prev, spacing)
                               ];
            [constraints addObjectsFromArray:newConstraints];
        }
        
        if (idx >= elements.count - 1) {
            if (connectBottom) {
                newConstraints = @[getBottomConstraintForViewsAndInset(v, view, bottomSpacing)];
                [constraints addObjectsFromArray:newConstraints];
            }
        }
        
        prev = v;
    }];
    return constraints;
}

NSLayoutConstraint *getAspectRatioConstraintForView(UIView *view, CGFloat ratio)
{
    return [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:ratio constant:0];
}

NSLayoutConstraint *ratioHeightAndWidth(UIView *view, CGFloat ratio) {
    return [NSLayoutConstraint
            constraintWithItem:view
            attribute:NSLayoutAttributeHeight
            relatedBy:NSLayoutRelationEqual
            toItem:view
            attribute:NSLayoutAttributeWidth
            multiplier:1
            constant:0];
}

@end
