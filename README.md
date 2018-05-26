
本库的README



1. CommonTableViewTool
这一个可以减少UITableView代理和数据源代码的一个工具项目，通过继承工具里面的基类Controller、View和Model，利用多态、工厂模式、继承特性，将UITableView的header、footer以及cell统一处理，在项目很庞大时，就会感到非常非常的节约代码量，提高项目的高内聚低耦合性

完全遵守iOS的MVC设计模式


以下是用法:

一般只需以下操作即可 ( 下面演示的是最简单的只有cell的情况， 如果要添加header视图或者footer视图，本git项目中TableViewToolDemo文件夹下有介绍)

M: 新建模型 @interface DemoModel : CommonTableViewCellModel
V: 新建视图 @interface DemoCell : CommonTableViewCell
C: 新建控制器 @interface DemoTableVC : BaseTableViewToolVC




---------------------------- DemoTableVC.m 里面 ----------------------------

- (void)viewDidLoad {
[super viewDidLoad];

DemoModel *model1 = [DemoModel new];
model1.name = @"张三";
DemoModel *model2 = [DemoModel new];
model2.name = @"李四";
DemoModel *model3 = [DemoModel new];
model3.name = @"王五";

CommonSectionModel *section = [CommonSectionModel new];
section.modelArray = @[model1, model2, model3];
self.tableViewTool.dataArr = @[section];
[self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row selectIndexPath:(NSIndexPath *)indexPath model:(CommonTableViewCellModel *)cellModel tableViewTool:(CommonTableViewTool *)tool {

// 如果需要点击cell 进行处理事件， 可以在这里 写
DemoModel *model = (DemoModel *)cellModel;
NSLog(@"点击了 %@", model.name);
}

/**
这个方法一定要实现
*/
- (NSDictionary<NSString *,NSDictionary<NSString *,id> *> *)returnCell_Model_keyValues {
return @{NSStringFromClass([DemoModel class]) : @{cellKEY : NSStringFromClass([DemoCell class]), isRegisterNibKEY: @NO}};
}




---------------------------- DemoCell.m 里面 ----------------------------
- (void)setupData:(CommonTableViewCellModel *)cellModel section:(NSInteger)section row:(NSInteger)row tableView:(UITableView *)tableView {
DemoModel *model = (DemoModel *)cellModel;

   // 在这里进行给子类Cell身上的一些控件赋值
      self.textLabel.text = model.name;
      }
