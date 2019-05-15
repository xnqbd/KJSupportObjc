//
//  CKJSimpleTableViewDelegate.h
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/2/28.
//  Copyright © 2019年 Lyc. All rights reserved.
//

#import <Foundation/Foundation.h>



#define cellKEY  @"CellKEY"
#define isRegisterNibKEY  @"isRegisterNibKEY"
#define registerNibNameKEY  @"registerNibNameKEY"
#define configDicKEY_ConfigModel @"configDicKEY_ConfigModel"
#define headerFooterKey @"HeaderFooterKey"



@class CKJSimpleTableView;


@protocol CKJSimpleTableViewDelegate <NSObject>

@optional

- (void)kj_tableView:(nonnull CKJSimpleTableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(nonnull NSIndexPath *)indexPath model:(nonnull __kindof CKJCommonCellModel *)model cell:(nonnull __kindof CKJCommonTableViewCell *)cell;


#pragma mark - ScrollView相关

- (void)scrollViewDidScroll:(nonnull UIScrollView *)scrollView;
- (void)scrollViewDidZoom:(nonnull UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(nonnull UIScrollView *)scrollView;
- (void)scrollViewWillEndDragging:(nonnull UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)scrollViewDidEndDragging:(nonnull UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewWillBeginDecelerating:(nonnull UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(nonnull UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(nonnull UIScrollView *)scrollView;
- (nullable UIView *)viewForZoomingInScrollView:(nonnull UIScrollView *)scrollView;
- (void)scrollViewWillBeginZooming:(nonnull UIScrollView *)scrollView withView:(nullable UIView *)view;
- (void)scrollViewDidEndZooming:(nonnull UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale;
- (BOOL)scrollViewShouldScrollToTop:(nonnull UIScrollView *)scrollView;
- (void)scrollViewDidScrollToTop:(nonnull UIScrollView *)scrollView;
- (void)scrollViewDidChangeAdjustedContentInset:(nonnull UIScrollView *)scrollView;


@end


