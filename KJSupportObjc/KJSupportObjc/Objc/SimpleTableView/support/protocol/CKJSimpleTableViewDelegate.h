//
//  CKJSimpleTableViewDelegate.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/2/28.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CKJSimpleTableView, CKJCommonSectionModel;


@protocol CKJSimpleTableViewDelegate <NSObject>

@optional

- (void)kj_tableView:(CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell;
- (void)tableView:(CKJSimpleTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath section:(NSInteger)section row:(NSInteger)row model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell;

- (UITableViewCellEditingStyle)tableView:(CKJSimpleTableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath section:(NSInteger)section row:(NSInteger)row model:(__kindof CKJCommonCellModel *)model cell:(__kindof CKJCommonTableViewCell *)cell;

/// willDisplayCell
- (void)tableView:(CKJSimpleTableView *)tableView willDisplayCell:(__kindof CKJCommonTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath section:(NSInteger)section row:(NSInteger)row model:(__kindof CKJCommonCellModel *)model sectionModel:(CKJCommonSectionModel *)sectionModel;



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



NS_ASSUME_NONNULL_END
