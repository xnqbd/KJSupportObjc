//
//  CKJTableViewDelegateObject.m
//  YHFSDK
//
//  Created by chenkaijie on 2018/7/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CKJTableViewDelegateObject.h"
#import "NSObject+WDYHFCategory.h"


@interface CKJTableViewDelegateObject ()

@property (strong, nonatomic) UIView *tempHeaderFooterView;


@end

@implementation CKJTableViewDelegateObject


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CKJCommonSectionModel *sectionModel = self.simpleTableView.dataArr[section];
    CKJCommonHeaderFooterModel *headerModel = sectionModel.headerModel;
    if ([headerModel isMemberOfClass:[CKJTableViewHeaderFooterEmptyModel class]]) {
        return sectionModel.headerHeight;
    }
    
    if (headerModel == nil) {
        return sectionModel.headerHeight;
    } else {
        if (sectionModel.headerHeight > 0) {
            return sectionModel.headerHeight;
        }
        return UITableViewAutomaticDimension;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CKJSimpleTableView *simpleTableView = self.simpleTableView;
    CKJCommonHeaderFooterModel *headerModel = simpleTableView.dataArr[section].headerModel;
    if (headerModel == nil) {
        return nil;
    }
    
    NSString *modelClassName = [NSString stringWithUTF8String:object_getClassName(headerModel)];
    
    NSString *kj_nameSpace = [CKJSimpleTableView kj_nameSpace];
    
    if ([modelClassName containsString:kj_nameSpace]) { // 为了Swift处理命名空间
        NSUInteger from = [modelClassName rangeOfString:kj_nameSpace].length;
        modelClassName = [modelClassName substringFromIndex:from];
    }
    
    NSString *headerClass = simpleTableView.header_Model_keyValues[modelClassName];
    
    if (headerClass) {
        
        CKJCommonTableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerClass];
        
        if (headerView == nil) {
            headerView = [[[CKJSimpleTableView returnClass_ClassString:headerClass] alloc] initWithReuseIdentifier:headerClass];
            if ([headerView isKindOfClass:[CKJTitleStyleHeaderFooterView class]]) {
                ((CKJTitleStyleHeaderFooterView *)headerView).delegate = simpleTableView.titleStyleHeaderFooterViewDelegate;
            }
        }
        
        headerView.simpleTableView = simpleTableView;
//        headerView.contentView.backgroundColor = simpleTableView.backgroundColor;
        
        headerView.headerFooterModel = headerModel;
        [headerView setupData:headerModel section:section tableView:(CKJSimpleTableView *)tableView];
        return headerView;
    } else {
        return self.tempHeaderFooterView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CKJCommonSectionModel *sectionModel = self.simpleTableView.dataArr[section];
    CKJCommonHeaderFooterModel *footerModel = sectionModel.footerModel;
    if ([footerModel isMemberOfClass:[CKJTableViewHeaderFooterEmptyModel class]]) {
        return sectionModel.footerHeight;
    }
    
    if (footerModel == nil) {
        return sectionModel.footerHeight;
    } else {
        if (sectionModel.footerHeight > 0) {
            return sectionModel.footerHeight;
        }
        return UITableViewAutomaticDimension;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CKJSimpleTableView *simpleTableView = self.simpleTableView;
    
    CKJCommonHeaderFooterModel *footerModel = simpleTableView.dataArr[section].footerModel;
    if (footerModel == nil) {
        return nil;
    }
    
    NSString *modelClassName = [NSString stringWithUTF8String:object_getClassName(footerModel)];
    
    NSString *kj_nameSpace = [CKJSimpleTableView kj_nameSpace];
    
    if ([modelClassName containsString:kj_nameSpace]) { // 为了Swift处理命名空间
        NSUInteger from = [modelClassName rangeOfString:kj_nameSpace].length;
        modelClassName = [modelClassName substringFromIndex:from];
    }
    
    NSString *footerClass = simpleTableView.footer_Model_keyValues[modelClassName];
    
    if (footerClass) {
        
        CKJCommonTableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerClass];
        
        if (footerView == nil) {
            footerView = [[[CKJSimpleTableView returnClass_ClassString:footerClass] alloc] initWithReuseIdentifier:footerClass];
            if ([footerView isKindOfClass:[CKJTitleStyleHeaderFooterView class]]) {
                ((CKJTitleStyleHeaderFooterView *)footerView).delegate = simpleTableView.titleStyleHeaderFooterViewDelegate;
            }
        }
        footerView.simpleTableView = simpleTableView;
//        footerView.contentView.backgroundColor = simpleTableView.backgroundColor;
        footerView.headerFooterModel = footerModel;
        [footerView setupData:footerModel section:section tableView:(CKJSimpleTableView *)tableView];
        return footerView;
    } else {
        return self.tempHeaderFooterView;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
#warning 如果此方法没有调用，请检查当前的tableView.delegate 是不是此 CKJSimpleTableView对象
    
    NSInteger section = indexPath.section, row = indexPath.row;
    
    // 显示的数组
    NSArray <CKJCommonCellModel *>*displayModelArray = [self.simpleTableView displayCellModelArrayAtSection:section];
    
    CKJCommonSectionModel *sectionModel = [self.simpleTableView.dataArr kjwd_objectAtIndex:section];
    
    CKJCommonCellModel *model = displayModelArray[row];
    if (model.cellHeight <= 0) {
        if (sectionModel.rowHeight > 0) {
            return sectionModel.rowHeight;
        }
        return UITableViewAutomaticDimension;
    } else {
        return model.cellHeight;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    BOOL cancel = NO;  // 默认保留 不悬浮
//    if ([self.simpleTableView.simpleTableViewDataSource respondsToSelector:@selector(savePlainStyleSectionHeaderSuspension)]) {
//        cancel = [self.simpleTableView.simpleTableViewDataSource savePlainStyleSectionHeaderSuspension];
//    }
//
//    if (cancel) {
//        CGFloat sectionHeaderHeight = 100;
//        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    } else {
//    }
    

    
//    if ([scrollView isKindOfClass:UITableView.class]) {
//        UITableView *tabV = (UITableView *)scrollView;
//        
//    }
    
//    CGFloat sectionHeaderHeight = 40;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    }
//    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
}


- (UIView *)tempHeaderFooterView {
    if (_tempHeaderFooterView) return _tempHeaderFooterView;
    _tempHeaderFooterView = [UIView new];
    return _tempHeaderFooterView;
}

@end
