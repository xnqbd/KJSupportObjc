#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CKJLabelCounterMethod) {
    CKJLabelCounterMethodEaseInOut,
    CKJLabelCounterMethodEaseIn,
    CKJLabelCounterMethodEaseOut,
    CKJLabelCounterMethodLinear
};

typedef NSString* (^CKJCountingLabelFormatBlock)(CGFloat value);
typedef NSAttributedString* (^CKJCountingLabelAttributedFormatBlock)(CGFloat value);


/*
     self.numLab.format = @"%d";
     self.numLab.attributedFormatBlock = ^NSAttributedString *(CGFloat value) {
     NSLog(@"%f   ", value);
     
     return WDCKJAttBold([NSString stringWithFormat:@"%.1f", value], [UIColor whiteColor], @50);
     };
     [self.numLab countFrom:0 to:31.8];
 */


@interface CKJCountingLabel : UILabel

@property (nonatomic, strong) NSString *format;
@property (nonatomic, assign) CKJLabelCounterMethod method;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, copy) CKJCountingLabelFormatBlock formatBlock;
@property (nonatomic, copy) CKJCountingLabelAttributedFormatBlock attributedFormatBlock;
@property (nonatomic, copy) void (^completionBlock)(void);

-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue;
-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromCurrentValueTo:(CGFloat)endValue;
-(void)countFromCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromZeroTo:(CGFloat)endValue;
-(void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

- (CGFloat)currentValue;

@end

