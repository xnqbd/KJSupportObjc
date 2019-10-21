# KJSupportObjc

KJSupportObjc 是在iOS平台集常用分类、工具、异常处理、和自定义UITableView及常见的Cell套件为一体的一个常用轻量级的库，适用于所有iOS开发者，包括Objective-C和Swift

## 系统的UITableView有什么问题？
传统情况下，项目里很多控制器都会使用到UITableView，而且每个控制器要注册不同的Cell，实现


* registerNib:forCellReuseIdentifier:
* registerClass:forCellReuseIdentifier:
* numberOfSectionsInTableView:  
* tableView:numberOfRowsInSection:
* tableView:cellForRowAtIndexPath: 
* tableView:heightForRowAtIndexPath:
* tableView:heightForHeaderInSection:
* tableView:heightForFooterInSection:
* tableView:didSelectRowAtIndexPath:

几乎每一个用到UITableView的地方都要重复的写上面几行代码，这样传统的方式存在下面一些问题


* 每个用到UITableView的地方都要重复注册Cell和实现上面几行代码，以及维护数据源和UITableView匹配关系
* 对于UITableView里面有多重不同类型的Cell，处理Cell上显示的数据和Cell不等高，区头、区尾高度或者标题，稍有不慎，如果匹配不上，就会导致崩溃
* 我的界面和设置界面里常见的一些Cell（比如左边一个图片和标题、右边一个文字和箭头）在别的用到UITableView的地方又要重新写和注册等操作 
* 在一些控制器里，某些情况下需要隐藏若干个Cell，然后在另一种情况下又要显示这几个Cell，在传统的代码实现上，处理麻烦而且很难跨越项目统一处理
* 在一些时候需要对UITableView增加删除移动等操作，数据源处理不好，容易崩溃

```obj-c

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *resourceDic;
@property (strong, nonatomic) NSDictionary *selectedScheduleDic;
@property (strong, nonatomic) NSMutableDictionary *statusDic;
@property (strong, nonatomic) NSMutableDictionary *scheduleDetailDic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RJExpertPanbanTableViewCell" bundle:nil] forCellReuseIdentifier:@"RJExpertPanbanTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RJIntroductionCell" bundle:nil] forCellReuseIdentifier:@"RJIntroductionCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RJYuyueDateTableViewCell" bundle:nil] forCellReuseIdentifier:@"RJYuyueDateTableViewCell"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RJScheduleCell" bundle:nil] forCellReuseIdentifier:@"RJScheduleCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RJScheduleTitleCell" bundle:nil] forCellReuseIdentifier:@"RJScheduleTitleCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RJDepartmentImageCell" bundle:nil] forCellReuseIdentifier:@"RJDepartmentImageCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RJScheduleDetailTitleCell" bundle:nil] forCellReuseIdentifier:@"RJScheduleDetailTitleCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RJScheduleDetailCell" bundle:nil] forCellReuseIdentifier:@"RJScheduleDetailCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (3 + [self.resourceDic[_currentDateStr] count]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return _appointmentType != RJRegister  ? 2 : 1;
            break;
        case 2:
            return 1;
            break;
        default:
            if (_canShowDetail == true) {
               NSDictionary *scheduleDic = self.resourceDic[_currentDateStr][section - 3];
                NSString *planId = scheduleDic[@"PlanId"];
                if ([self.statusDic[planId] integerValue] == 1) {
                    return ( 2 + [self.scheduleDetailDic[planId] count]);
                }
            }
            return 1;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return self.outpatientType > 1 ? 60 : 100;
        }else{
            return UITableViewAutomaticDimension;
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            return 40;
        }else{
            return 60;
        }
    }else{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf(self);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (_outpatientType > 1) {
                RJExpertPanbanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RJExpertPanbanTableViewCell" forIndexPath:indexPath];
                cell.dataDic = _dataDic;
                return cell;
            }else{
                RJDepartmentImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RJDepartmentImageCell" forIndexPath:indexPath];
                cell.text = _deptModel.HisDeptName;
                return cell;
            }
        }else{
            RJIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RJIntroductionCell" forIndexPath:indexPath];
            cell.text = _outpatientType > 1 ? _dataDic[@"Profession"] : _deptModel.Description;
            return cell;
        }
        
    }else if(indexPath.section == 1){
        if(indexPath.row){
            RJYuyueDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RJYuyueDateTableViewCell" forIndexPath:indexPath];
            cell.appointmentDateArray = self.appointmentDateArray;
            cell.currentDateStr = self.currentDateStr;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
            NSString *dateText = [NSString stringWithFormat:@"%@  %@",_currentDateStr ? _currentDateStr : @"",_currentWeekStr ? _currentWeekStr : @""];
            cell.textLabel.text = dateText;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if(indexPath.section == 2){
        RJScheduleTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RJScheduleTitleCell" forIndexPath:indexPath];
        return cell;
    }else{
        NSDictionary *scheduleDic = self.resourceDic[_currentDateStr][indexPath.section - 3];
        NSString *planId = scheduleDic[@"PlanId"];
        
        if (indexPath.row == 0) {
            RJScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RJScheduleCell" forIndexPath:indexPath];
            cell.canShowDetail = self.canShowDetail;
            return cell;
        }else if(indexPath.row == 1){
            RJScheduleDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RJScheduleDetailTitleCell" forIndexPath:indexPath];
            return cell;
        }else{
            RJScheduleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RJScheduleDetailCell" forIndexPath:indexPath];
            cell.dataDic = self.scheduleDetailDic[planId][indexPath.row - 2];
            return cell;
        }
    }
}

@end

```
上面这样一个示例，你会清晰的发现，当一个UITableView里面有多种类型的情况时，这代码已经变得难以阅读你也很难很好的掌握这几个协议方法之间匹配关系了，上面的示例仅仅是在一个UITableView里面，往往公司的项目都很庞大，使用UITableView地方特别多，

## 准备与CKJSimpleTableView见面
这是CKJSimpleTableView的写法

```obj-c
- (nonnull NSDictionary <NSString *, NSDictionary <NSString *, id>*> *)returnCell_Model_keyValues:(CKJSimpleTableView *_Nonnull)s {
    return @{
             NSStringFromClass([RJDepartmentImageCellModel class]) : @{cellKEY : NSStringFromClass([RJDepartmentImageCell class]), isRegisterNibKEY : @YES},
             NSStringFromClass([RJSchedule_DoctorCellModel class]) : @{cellKEY : NSStringFromClass([RJSchedule_DoctorCell class]), isRegisterNibKEY : @YES},
             NSStringFromClass([RJSchedule_IntroductionCellModel class]) : @{cellKEY : NSStringFromClass([RJSchedule_IntroductionCell class]), isRegisterNibKEY : @YES},
             NSStringFromClass([RJSchedule_DateCellModel class]) : @{cellKEY : NSStringFromClass([RJSchedule_DateCell class]), isRegisterNibKEY : @YES},
             NSStringFromClass([RJSchedule_DetailTitleCellModel class]) : @{cellKEY : NSStringFromClass([RJSchedule_DetailTitleCell class]), isRegisterNibKEY : @NO}
             };
}

- (void)initSimpleTableViewData {
    KJ_typeweakself
    CKJCommonSectionModel *section1 = [CKJCommonSectionModel sectionWithDetailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        RJSchedule_DoctorCellModel *model1 = [RJSchedule_DoctorCellModel modelWithCellHeight:70 cellModel_id:nil detailSettingBlock:^(RJSchedule_DoctorCellModel * _Nonnull m) {
            m.doctModel = _doctModel;
        } didSelectRowBlock:nil];
        RJDepartmentImageCellModel *model2 = [RJDepartmentImageCellModel modelWithCellHeight:120 cellModel_id:nil detailSettingBlock:^(__kindof RJDepartmentImageCellModel * _Nonnull m) {
            m.dep = _deptModel.HisDeptName;
        } didSelectRowBlock:nil];
        RJSchedule_IntroductionCellModel *model3 = [RJSchedule_IntroductionCellModel modelWithCellHeight:0 cellModel_id:nil detailSettingBlock:^(__kindof RJSchedule_IntroductionCellModel * _Nonnull m) {
            m.text = self.category.type > 1 ? _doctModel.Profession : _deptModel.Description;
        } didSelectRowBlock:nil];
        _sec.modelArray = @[model1, model2, model3];
    }];
    
    CKJCommonSectionModel *section2 = [CKJCommonSectionModel sectionWithHeaderHeight:10 detailSetting:^(__kindof CKJCommonSectionModel * _Nonnull _sec) {
        RJSchedule_DetailTitleCellModel *model1 = [RJSchedule_DetailTitleCellModel modelWithCellHeight:40 cellModel_id:nil detailSettingBlock:nil didSelectRowBlock:nil];
        RJSchedule_DateCellModel *model2 = [RJSchedule_DateCellModel modelWithCellHeight:60 cellModel_id:@(kCollectionDateCell) detailSettingBlock:^(__kindof RJSchedule_DateCellModel * __weak _Nonnull m) {
            m.selectedDateBlock = ^(NSInteger index, NSString *dateStr, NSString *weekStr) {
                NSLog(@"点击 某一天");
            };
        } didSelectRowBlock:nil];
        _sec.modelArray = @[model1, model2];
    }];
    self.simpleTableView.dataArr = @[section1, section2];
}
```
你可以只需要创建`CKJCommonSectionModel`分区对象和`CKJCommonCellModel`每一行CellModel的子对象，用CKJSimpleTableViewDataSource、CKJSimpleTableViewDelegate代替系统的UITableViewDataSource、UITableViewDelegate方法，此刻你只需要管理数据即可，不需要担心CKJSimpleTableView数据匹配不上导致的闪退问题





