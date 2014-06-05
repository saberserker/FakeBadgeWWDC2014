//
//  COPViewController.m
//  badge
//
//  Created by Henry Tsang on 6/2/14.
//  Copyright (c) 2014 freezedpeanuts. All rights reserved.
//

#import "COPViewController.h"

@interface COPViewController ()
@property (weak, nonatomic) IBOutlet UILabel *logo;
@property (weak, nonatomic) IBOutlet UIView *barcodeView;

@end

@implementation COPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self makePathForBarCode];
    
}

- (void) makePathForBarCode {
    UIBezierPath* bpath = [UIBezierPath bezierPath];
    bpath.usesEvenOddFillRule = true;
    [bpath moveToPoint:CGPointMake(0,0)];
    [bpath addLineToPoint:CGPointMake(0, 40)];
    NSInteger acumulatedWidth = 0;
    for (int iter = 0; iter < 100; iter++) {
        NSInteger barWidth = 1 + arc4random() % 4;
        acumulatedWidth += barWidth;
        CGFloat barHeight = iter % 2 == 1 ? 40 : 0;
        [bpath addLineToPoint:CGPointMake(acumulatedWidth, 40 - barHeight)];
        [bpath addLineToPoint:CGPointMake(acumulatedWidth, barHeight)];
    }
    [bpath addLineToPoint:CGPointMake(acumulatedWidth, 0)];

    [bpath closePath];
    
    
    CAShapeLayer* shapelayer = [CAShapeLayer layer];
    shapelayer.path = bpath.CGPath;
    self.barcodeView.layer.mask = shapelayer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1000;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"someCell" forIndexPath:indexPath];
    
    CGFloat size = 1;
    NSInteger cutoff = 100;
    if (indexPath.row > cutoff)
        size = 1 + 0.1f * ((indexPath.row - cutoff) / 5);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m44 = size;
    cell.layer.transform = transform;
    
    return cell;
}

- (IBAction)unwindPrev:(UIStoryboardSegue *)unwindSegue
{
}

@end
