//  NSLayoutConstraint+CommonConstraints.h
//  APPSTUD-Test
//
//  Created by Yauheni Shauchenka on 5/25/17.
//  Copyright © 2017 com.appstub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (CommonConstraints)

NSLayoutConstraint *getWidthConstraintForViewAndWidth(UIView *view, CGFloat width);
NSLayoutConstraint *getHeightConstraintForViewAndHeight(UIView *view, CGFloat height);
NSLayoutConstraint *getTopConstraintForViewsAndInset(UIView *view1, UIView *view2, CGFloat inset);
NSLayoutConstraint *getBottomConstraintForViewsAndInset(UIView *view1, UIView *view2, CGFloat inset);
NSLayoutConstraint *getLeftConstraintForViewsAndInset(UIView *view1, UIView *view2, CGFloat inset);
NSLayoutConstraint *getRightConstraintForViewsAndInset(UIView *view1, UIView *view2, CGFloat inset);
NSLayoutConstraint *getConstraintForVerticallyCenteredViewInView(UIView *view1, UIView *view2);
NSLayoutConstraint *getConstraintForHorizontallyCenteredViewInView(UIView *view1, UIView *view2);
NSLayoutConstraint *getConstraintForViewToTheLeftOfView(UIView *view1, UIView *view2, CGFloat inset);
NSLayoutConstraint *getConstraintForViewToTheRightOfView(UIView *view1, UIView *view2, CGFloat inset);
NSLayoutConstraint *getConstraintForViewBelowView(UIView *view1, UIView *view2, CGFloat inset);
NSLayoutConstraint *getConstraintForViewAboveView(UIView *view1, UIView *view2, CGFloat inset);
NSArray *getSameFrameConstraintsForViews(UIView *view1, UIView *view2);
NSLayoutConstraint *getSameWidthConstraintForViews(UIView *view1, UIView *view2, CGFloat multiplier);
NSLayoutConstraint *getSameHeightConstraintForViews(UIView *view1, UIView *view2, CGFloat multiplier);
NSLayoutConstraint *getSameLeadingConstraintForViewsAndInset(UIView *view1, UIView *view2, CGFloat inset);
NSLayoutConstraint *getSameTrailingConstraintForViewsAndInset(UIView *view1, UIView *view2, CGFloat inset);
NSArray *getConstraintForElementsStackedVerticallyInView(NSArray *elements, UIView *view, CGFloat spacing, CGFloat topSpacing, CGFloat bottomSpacing, BOOL connectBottom, BOOL sameWidth, BOOL addSubViews);
NSLayoutConstraint *getAspectRatioConstraintForView(UIView *view, CGFloat ratio);
NSLayoutConstraint *ratioHeightAndWidth(UIView *view, CGFloat ratio);

@end
