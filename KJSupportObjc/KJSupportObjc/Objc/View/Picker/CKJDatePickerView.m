//
//  CKJDatePickerView.m
//  Demo
//
//  Created by admin2 on 2020/3/23.
//  Copyright © 2020 admin2. All rights reserved.
//

#import "CKJDatePickerView.h"
#import "NSObject+WDYHFCategory.h"

#define kPickerSize self.datePicker.frame.size



@interface NSDate (CKJDatePickerExtension)

@end

@implementation NSDate (CKJDatePickerExtension)

+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

- (NSInteger) hour
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

- (NSInteger) minute
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger) seconds
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

- (NSInteger) day
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger) month
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger) week
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfMonth;
}

- (NSInteger) weekday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger) year
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}


static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);


+ (NSDate *)_date:(NSString *)datestr WithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:datestr];
#if ! __has_feature(objc_arc)
    [dateFormatter release];
#endif
    return date;
}


-(NSDate *)_dateWithFormatter:(NSString *)formatter {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = formatter;
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}


@end


@interface CKJDatePickerView ()<UIPickerViewDelegate, UIPickerViewDataSource> {
    //日期存储数组
    NSMutableArray *_yearArray;
    NSMutableArray *_monthArray;
    NSMutableArray *_dayArray;
    NSMutableArray *_hourArray;
    NSMutableArray *_minuteArray;
    NSString *_dateFormatter;
    //记录位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    NSInteger hourIndex;
    NSInteger minuteIndex;
    
    NSInteger preRow;
    
    NSDate *_startDate;
    
}

@property (nonatomic,strong)UIPickerView *datePicker;
@property (nonatomic, retain) NSDate *scrollToDate;//滚到指定日期
@property (nonatomic,strong) void (^endScroll)(NSDate *);
@property (nonatomic,assign) CKJDateStyle datePickerStyle;
@property (strong, nonatomic) UILabel *showYearView;

@property (assign, nonatomic) NSInteger max_year;
@property (assign, nonatomic) NSInteger min_year;

@end


@implementation CKJDatePickerView


- (instancetype)initWithDateStyle:(CKJDateStyle)datePickerStyle maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate scrollToDate:(NSDate *)scrollToDate endScroll_didSelect_callBack:(void(^)(NSDate *currentDate))endScroll_didSelect_callBack {
    if (self = [super init]) {
        self.datePickerStyle = datePickerStyle;
        self.scrollToDate = scrollToDate;
        switch (datePickerStyle) {
            case CKJDateStyle1:
                _dateFormatter = @"yyyy-MM-dd HH:mm";
                break;
            case CKJDateStyle2:
                _dateFormatter = @"yyyy-MM-dd HH:mm";
                break;
            case CKJDateStyle3:
                _dateFormatter = @"yyyy-MM-dd";
                break;
            case CKJDateStyle4:
                _dateFormatter = @"yyyy-MM";
                break;
            case CKJDateStyle5:
                _dateFormatter = @"yyyy-MM-dd";
                break;
            case CKJDateStyle6:
                _dateFormatter = @"HH:mm";
                break;
            case CKJDateStyle7:
                _dateFormatter = @"yyyy";
                break;
            case CKJDateStyle8:
                _dateFormatter = @"MM";
                break;
            case CKJDateStyle9:
                _dateFormatter = @"dd HH:mm";
                break;
            default:
                _dateFormatter = @"yyyy-MM-dd HH:mm";
                break;
        }
        
        [self setupUI];

        self.endScroll = endScroll_didSelect_callBack;

        
        if (!_scrollToDate) {
            _scrollToDate = [NSDate date];
        }

        
        if (!maxDate) {
            maxDate = [NSDate _date:@"2099-12-31 23:59" WithFormat:@"yyyy-MM-dd HH:mm"];
        }
        if (!minDate) {
            minDate = [NSDate _date:@"1900-01-01 00:00" WithFormat:@"yyyy-MM-dd HH:mm"];
        }
        
        
        //循环滚动时需要用到
        preRow = (self.scrollToDate.kjwd_year.intValue-self.min_year)*12+self.scrollToDate.kjwd_month.intValue-1;
        
        //设置年月日时分数据
        _yearArray = [self setArray:_yearArray];
        _monthArray = [self setArray:_monthArray];
        _dayArray = [self setArray:_dayArray];
        _hourArray = [self setArray:_hourArray];
        _minuteArray = [self setArray:_minuteArray];
        
        for (int i=0; i<60; i++) {
            NSString *num = [NSString stringWithFormat:@"%02d",i];
            if (0<i && i<=12)
                [_monthArray addObject:num];
            if (i<24)
                [_hourArray addObject:num];
            [_minuteArray addObject:num];
        }
        
        self.max_year = maxDate.year;
        self.min_year = minDate.year;
        
        
        for (NSInteger i= self.min_year; i <= self.max_year; i++) {
            NSString *num = [NSString stringWithFormat:@"%ld",(long)i];
            [_yearArray addObject:num];
        }
        self.maxLimitDate = maxDate;
        self.minLimitDate = minDate;

    }
    return self;
}

- (void)setupUI {
    _showYearView = [[UILabel alloc] init];
    _showYearView.font = [UIFont systemFontOfSize:80];
    _showYearView.textColor = [UIColor colorWithRed:233 / 255.0 green:237 / 255.0 blue:242 / 255.0 alpha:1];
    _showYearView.textAlignment = NSTextAlignmentCenter;
    
    _showYearView.userInteractionEnabled = YES;
    [_showYearView kjwd_addToSuperView:self constraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.edges.equalTo(superview);
    }];
    
    

    _datePicker = [[UIPickerView alloc] init];
    _datePicker.showsSelectionIndicator = YES;
    _datePicker.delegate = self;
    _datePicker.dataSource = self;
    [_datePicker kjwd_addToSuperView:_showYearView constraints:^(MASConstraintMaker * _Nonnull make, UIView * _Nonnull superview) {
        make.edges.equalTo(superview);
    }];
}


- (NSMutableArray *)setArray:(id)mutableArray
{
    if (mutableArray)
        [mutableArray removeAllObjects];
    else
        mutableArray = [NSMutableArray array];
    return mutableArray;
}

-(void)setYearLabelColor:(UIColor *)yearLabelColor {
    self.showYearView.textColor = yearLabelColor;
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (self.datePickerStyle) {
        case CKJDateStyle1:
            [self addLabelWithName:@[@"年",@"月",@"日",@":",@""]];
            return 5;
        case CKJDateStyle2:
            [self addLabelWithName:@[@"月",@"日",@"时",@"分"]];
            return 4;
        case CKJDateStyle3:
            [self addLabelWithName:@[@"年",@"月",@"日"]];
            return 3;
        case CKJDateStyle4:
            [self addLabelWithName:@[@"年",@"月"]];
            return 2;
        case CKJDateStyle5:
            [self addLabelWithName:@[@"月",@"日"]];
            return 2;
        case CKJDateStyle6:
            [self addLabelWithName:@[@"时",@"分"]];
            return 2;
        case CKJDateStyle7:
            [self addLabelWithName:@[@"年"]];
            return 1;
        case CKJDateStyle8:
            [self addLabelWithName:@[@"月"]];
            return 1;
        case CKJDateStyle9:
            [self addLabelWithName:@[@"日",@"时",@"分"]];
            return 3;
        default:
            return 0;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *numberArr = [self getNumberOfRowsInComponent];
    return [numberArr[component] integerValue];
}

-(NSArray *)getNumberOfRowsInComponent {
    
    NSInteger yearNum = _yearArray.count;
    NSInteger monthNum = _monthArray.count;
    NSInteger dayNum = [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
    
    NSInteger dayNum2 = [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:1];//确保可以选到31日
    
    NSInteger hourNum = _hourArray.count;
    NSInteger minuteNUm = _minuteArray.count;
    
    NSInteger timeInterval = self.max_year - self.min_year;
    
    switch (self.datePickerStyle) {
        case CKJDateStyle1:
            return @[@(yearNum),@(monthNum),@(dayNum),@(hourNum),@(minuteNUm)];
            break;
        case CKJDateStyle2:
            return @[@(monthNum*timeInterval),@(dayNum),@(hourNum),@(minuteNUm)];
            break;
        case CKJDateStyle3:
            return @[@(yearNum),@(monthNum),@(dayNum)];
            break;
        case CKJDateStyle4:
            return @[@(yearNum),@(monthNum)];
            break;
        case CKJDateStyle5:
            return @[@(monthNum*timeInterval),@(dayNum),@(hourNum)];
            break;
        case CKJDateStyle6:
            return @[@(hourNum),@(minuteNUm)];
            break;
        case CKJDateStyle7:
            return @[@(yearNum)];
            break;
        case CKJDateStyle8:
            return @[@(monthNum)];
            break;
        case CKJDateStyle9:
            return @[@(dayNum2),@(hourNum),@(minuteNUm)];
            break;
        default:
            return @[];
            break;
    }
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:[UIFont systemFontOfSize:17]];
    }
    NSString *title;
    
    switch (self.datePickerStyle) {
        case CKJDateStyle1:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            if (component==2) {
                title = _dayArray[row];
            }
            if (component==3) {
                title = _hourArray[row];
            }
            if (component==4) {
                title = _minuteArray[row];
            }
            break;
        case CKJDateStyle3:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            if (component==2) {
                title = _dayArray[row];
            }
            break;
        case CKJDateStyle4:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            break;
        case CKJDateStyle2:
            if (component==0) {
                title = _monthArray[row%12];
            }
            if (component==1) {
                title = _dayArray[row];
            }
            if (component==2) {
                title = _hourArray[row];
            }
            if (component==3) {
                title = _minuteArray[row];
            }
            break;
        case CKJDateStyle5:
            if (component==0) {
                title = _monthArray[row%12];
            }
            if (component==1) {
                title = _dayArray[row];
            }
            break;
        case CKJDateStyle6:
            if (component==0) {
                title = _hourArray[row];
            }
            if (component==1) {
                title = _minuteArray[row];
            }
            break;
        case CKJDateStyle7:
            if (component==0) {
                title = _yearArray[row];
            }
            break;
        case CKJDateStyle8:
            if (component==0) {
                title = _monthArray[row];
            }
            break;
        case CKJDateStyle9:
            if (component==0) {
                title = _dayArray[row];
            }
            if (component==1) {
                title = _hourArray[row];
            }
            if (component==2) {
                title = _minuteArray[row];
            }
            break;
        default:
            title = @"";
            break;
    }
    
    customLabel.text = title;
    if (!_datePickerColor) {
        _datePickerColor = [UIColor blackColor];
    }
    customLabel.textColor = _datePickerColor;
    return customLabel;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (self.datePickerStyle) {
        case CKJDateStyle1:{
            if (component == 0) {
                yearIndex = row;
                self.showYearView.text =_yearArray[yearIndex];
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 3) {
                hourIndex = row;
            }
            if (component == 4) {
                minuteIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
        }
            break;
        case CKJDateStyle3:{
            if (component == 0) {
                yearIndex = row;
                self.showYearView.text =_yearArray[yearIndex];
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
        }
            break;
        case CKJDateStyle4:{
            if (component == 0) {
                yearIndex = row;
                self.showYearView.text =_yearArray[yearIndex];
            }
            if (component == 1) {
                monthIndex = row;
            }
        }
            break;
        case CKJDateStyle2:{
            if (component == 1) {
                dayIndex = row;
            }
            if (component == 2) {
                hourIndex = row;
            }
            if (component == 3) {
                minuteIndex = row;
            }
            if (component == 0) {
                [self yearChange:row];
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
            [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
            
        }
            break;
        case CKJDateStyle5:{
            if (component == 1) {
                dayIndex = row;
            }
            if (component == 0) {
                [self yearChange:row];
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
            [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
        }
            break;
        case CKJDateStyle6:{
            if (component == 0) {
                hourIndex = row;
            }
            if (component == 1) {
                minuteIndex = row;
            }
        }
            break;
        case CKJDateStyle7:{
            if (component == 0) {
                yearIndex = row;
                self.showYearView.text =_yearArray[yearIndex];
            }
        }
            break;
        case CKJDateStyle8:{
            if (component == 0) {
                monthIndex = row;
            }
        }
            break;
        case CKJDateStyle9:{
            if (component == 0) {
                dayIndex = row;
            }
            if (component == 1) {
                hourIndex = row;
            }
            if (component == 2) {
                minuteIndex = row;
            }
        }
            break;
        default:
            break;
    }
    
    [pickerView reloadAllComponents];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",_yearArray[yearIndex],_monthArray[monthIndex],_dayArray[dayIndex],_hourArray[hourIndex],_minuteArray[minuteIndex]];
    switch (self.datePickerStyle) {
        case CKJDateStyle3:
            dateStr = [NSString stringWithFormat:@"%@-%@-%@",_yearArray[yearIndex],_monthArray[monthIndex],_dayArray[dayIndex]];
            break;
        case CKJDateStyle4:
            dateStr = [NSString stringWithFormat:@"%@-%@",_yearArray[yearIndex],_monthArray[monthIndex]];
            break;
        case CKJDateStyle5:
            dateStr = [NSString stringWithFormat:@"%@-%@-%@",_yearArray[yearIndex],_monthArray[monthIndex],_dayArray[dayIndex]];
            break;
        case CKJDateStyle6:
            dateStr = [NSString stringWithFormat:@"%@:%@",_hourArray[hourIndex],_minuteArray[minuteIndex]];
            break;
        case CKJDateStyle7:
            dateStr = [NSString stringWithFormat:@"%@",_yearArray[yearIndex]];

            break;
        case CKJDateStyle8:
            dateStr = [NSString stringWithFormat:@"%@",_monthArray[monthIndex]];

            break;
        case CKJDateStyle9:
            dateStr = [NSString stringWithFormat:@"%@ %@:%@",_dayArray[dayIndex],_hourArray[hourIndex],_minuteArray[minuteIndex]];

            break;
        default:
            dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",_yearArray[yearIndex],_monthArray[monthIndex],_dayArray[dayIndex],_hourArray[hourIndex],_minuteArray[minuteIndex]];
            break;
    }

    
    self.scrollToDate = [[NSDate _date:dateStr WithFormat:_dateFormatter] _dateWithFormatter:_dateFormatter];
    
    if ([self.scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        self.scrollToDate = self.minLimitDate;
        [self getNowDate:self.minLimitDate animated:YES];
    }else if ([self.scrollToDate compare:self.maxLimitDate] == NSOrderedDescending){
        self.scrollToDate = self.maxLimitDate;
        [self getNowDate:self.maxLimitDate animated:YES];
    }
    
    _startDate = self.scrollToDate;
    
    if (self.endScroll) {
        self.endScroll(_startDate);
    }
//    NSLog(@"%@   ", [_startDate kjwd_dateString]);
}

-(void)yearChange:(NSInteger)row {
    
    monthIndex = row%12;
    
    //年份状态变化
    if (row-preRow <12 && row-preRow>0 && [_monthArray[monthIndex] integerValue] < [_monthArray[preRow%12] integerValue]) {
        yearIndex ++;
    } else if(preRow-row <12 && preRow-row > 0 && [_monthArray[monthIndex] integerValue] > [_monthArray[preRow%12] integerValue]) {
        yearIndex --;
    }else {
        NSInteger interval = (row-preRow)/12;
        yearIndex += interval;
    }
    
    self.showYearView.text = _yearArray[yearIndex];
    
    preRow = row;
}

#pragma mark - tools
//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
    switch (num_month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
            [self setdayArray:31];
            return 31;
        }
        case 4:case 6:case 9:case 11:{
            [self setdayArray:30];
            return 30;
        }
        case 2:{
            if (isrunNian) {
                [self setdayArray:29];
                return 29;
            }else{
                [self setdayArray:28];
                return 28;
            }
        }
        default:
            break;
    }
    return 0;
}

//设置每月的天数数组
- (void)setdayArray:(NSInteger)num
{
    [_dayArray removeAllObjects];
    for (int i=1; i<=num; i++) {
        [_dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
}

//滚动到指定的时间位置
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated
{
    if (!date) {
        date = [NSDate date];
    }
    
    [self DaysfromYear:date.year andMonth:date.month];
    
    yearIndex = date.year-self.min_year;
    monthIndex = date.month-1;
    dayIndex = date.day-1;
    hourIndex = date.hour;
    minuteIndex = date.minute;
    
    //循环滚动时需要用到
    preRow = (self.scrollToDate.year-self.min_year)*12+self.scrollToDate.month-1;
    
    NSArray *indexArray;
    
    if (self.datePickerStyle == CKJDateStyle1)
        indexArray = @[@(yearIndex),@(monthIndex),@(dayIndex),@(hourIndex),@(minuteIndex)];
    if (self.datePickerStyle == CKJDateStyle3)
        indexArray = @[@(yearIndex),@(monthIndex),@(dayIndex)];
    if (self.datePickerStyle == CKJDateStyle4)
        indexArray = @[@(yearIndex),@(monthIndex)];
    if (self.datePickerStyle == CKJDateStyle2)
        indexArray = @[@(monthIndex),@(dayIndex),@(hourIndex),@(minuteIndex)];
    if (self.datePickerStyle == CKJDateStyle5)
        indexArray = @[@(monthIndex),@(dayIndex)];
    if (self.datePickerStyle == CKJDateStyle6)
        indexArray = @[@(hourIndex),@(minuteIndex)];
    if (self.datePickerStyle == CKJDateStyle7)
        indexArray = @[@(yearIndex)];
    if (self.datePickerStyle == CKJDateStyle8)
        indexArray = @[@(monthIndex)];
    if (self.datePickerStyle == CKJDateStyle9)
        indexArray = @[@(dayIndex),@(hourIndex),@(minuteIndex)];
    
    self.showYearView.text = _yearArray[yearIndex];
    
    [self.datePicker reloadAllComponents];
    
    for (int i=0; i<indexArray.count; i++) {
        if ((self.datePickerStyle == CKJDateStyle2 || self.datePickerStyle == CKJDateStyle5)&& i==0) {
            NSInteger mIndex = [indexArray[i] integerValue]+(12*(self.scrollToDate.year - self.min_year));
            [self.datePicker selectRow:mIndex inComponent:i animated:animated];
        } else {
            [self.datePicker selectRow:[indexArray[i] integerValue] inComponent:i animated:animated];
        }
    }
}


#pragma mark - getter / setter

-(void)setMinLimitDate:(NSDate *)minLimitDate {
    _minLimitDate = minLimitDate;
    if ([_scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        _scrollToDate = self.minLimitDate;
    }
    [self getNowDate:self.scrollToDate animated:NO];
}


-(void)addLabelWithName:(NSArray *)nameArr {
    for (id subView in self.showYearView.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
   
    if (!_dateLabelColor) {
        _dateLabelColor = [UIColor colorWithRed:247 / 255.0 green:133 / 255.0 blue:51 / 255.0 alpha:1];
    }
    
    for (int i=0; i<nameArr.count; i++) {
        CGFloat labelX = kPickerSize.width/(nameArr.count*2)+18+kPickerSize.width/nameArr.count*i + 10;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, self.showYearView.frame.size.height/2-15/2.0, 15, 15)];
        
        label.text = nameArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor =  _dateLabelColor;
        
        [self.showYearView addSubview:label];
    }
}



-(void)setHideBackgroundYearLabel:(BOOL)hideBackgroundYearLabel {
    _showYearView.textColor = [UIColor clearColor];
}

@end
