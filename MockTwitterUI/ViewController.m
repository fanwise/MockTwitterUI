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
}

@end
