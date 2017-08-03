//
//  ViewController.m
//  MockTwitterUI
//
//  Created by Wei Fan on 01/08/2017.
//  Copyright © 2017 Wei Fan. All rights reserved.
//

#import "ViewController.h"
#import "FXBlurView.h"

const CGFloat offset_HeaderStop = 40.0; // At this offset the Header stops its transformations
const CGFloat offset_B_LabelHeader = 95.0; // At this offset the Black label reaches the Header
const CGFloat distance_W_LabelHeader = 35.0; // The distance between the bottom of the Header and the top of the White Label

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIButton *follow;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet FXBlurView *headerBlurImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.header.clipsToBounds = YES;
    
    self.headerBlurImageView.alpha = 0.0;
    self.headerBlurImageView.tintColor = UIColor.clearColor;
    self.headerBlurImageView.blurRadius = 20;
    
    self.avatar.clipsToBounds = YES;
    self.avatar.layer.borderColor = UIColor.whiteColor.CGColor;
    self.follow.layer.borderColor = [UIColor colorWithRed:85.0/255.0 green:172.0/255.0 blue:238.0/255.0 alpha:1.0].CGColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.header.translatesAutoresizingMaskIntoConstraints = YES;
    [self setAnchorPointWithoutFrameMove:CGPointMake(0.5, 0) forView:self.header];
    
    self.avatar.translatesAutoresizingMaskIntoConstraints = YES;
    [self setAnchorPointWithoutFrameMove:CGPointMake(0.5, 1) forView:self.avatar];
}

- (void)setAnchorPointWithoutFrameMove:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint oldAnchorPoint = view.layer.anchorPoint;
    CGPoint oldPosition = view.layer.position;
    CGPoint newPostion = CGPointZero;
    
    newPostion.x = oldPosition.x + view.bounds.size.width * (anchorPoint.x - oldAnchorPoint.x);
    newPostion.y = oldPosition.y + view.bounds.size.height * (anchorPoint.y - oldAnchorPoint.y);
    
    view.layer.position = newPostion;
    view.layer.anchorPoint = anchorPoint;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    
    CATransform3D headerTransform = CATransform3DIdentity;
    CATransform3D labelTransform = CATransform3DIdentity;
    CATransform3D avatarTransform = CATransform3DIdentity;
    
    if (offset < 0) {
        CGFloat headerScaleFactor = -(offset) / self.header.bounds.size.height;
        headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0);
    } else {
        headerTransform = CATransform3DTranslate(headerTransform, 0, fmax(-offset_HeaderStop, -offset), 0);
        labelTransform = CATransform3DTranslate(labelTransform, 0, fmax(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0);
        
        CGFloat avatarScaleFactor = (fmin(offset_HeaderStop, offset)) / self.avatar.bounds.size.height / 1.4;
        avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0);
    }
    
    if (offset <= offset_HeaderStop) {
        if (self.avatar.layer.zPosition < self.header.layer.zPosition){
            self.header.layer.zPosition = 0;
        }
    }else {
        if (self.avatar.layer.zPosition >= self.header.layer.zPosition){
            self.header.layer.zPosition = 2;
        }
    }
    
    self.headerBlurImageView.alpha = fmin(1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader);
    
    self.header.layer.transform = headerTransform;
    self.headerLabel.layer.transform = labelTransform;
    self.avatar.layer.transform = avatarTransform;
}

@end
