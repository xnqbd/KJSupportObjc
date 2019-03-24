//
//  CKJSimpleTableViewDelegate.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/2/28.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol CKJSimpleTableViewDelegate <NSObject>

@optional

- (void)kj_tableView:(nonnull CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(nonnull NSIndexPath *)indexPath model:(nonnull __kindof CKJCommonCellModel *)model cell:(nonnull __kindof CKJCommonTableViewCell *)cell;


#pragma mark - ScrollView相关

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidZoom:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view;
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale;
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView;


@end


