//
//  WDYHFSelectHospitalModel.m
//  WDYHFSDK
//
//  Created by chenkaijie on 2018/9/15.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "WDYHFHospitalItem.h"
#import "NSObject+WDYHFCategory.h"

@implementation WDYHFHospitalItem

@synthesize org_name = _org_name;

- (NSString *)org_code {
    return WDKJ_ConfirmString(_org_code);
}
- (NSString *)org_name {
    return WDKJ_ConfirmString(_org_name);
}
- (void)setOrg_name:(NSString *)org_name {
    _org_name = org_name;
    self.title = org_name;
}

@end


@implementation WDYHFAreaItem

- (void)setArea_name:(NSString *)area_name {
    _area_name = area_name;
    self.title = area_name;
}

@end

@implementation WDYHFSelectHospitalPickerView

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    CKJPickerComponentModel *comModel = self.dataArr[component];
    CKJPickerRowModel *rowModel = comModel.modelArray[row];
    if ([rowModel isKindOfClass:[WDYHFAreaItem class]]) {
        WDYHFAreaItem *areaModel = (WDYHFAreaItem *)rowModel;

        CKJPickerComponentModel *hospitalComponent = [self.dataArr kjwd_objectAtIndex:1];
        hospitalComponent.modelArray = areaModel.hospitals;
        
        [pickerView reloadAllComponents];
    } else if ([rowModel isKindOfClass:[WDYHFHospitalItem class]]) {
        
    }
}

@end
