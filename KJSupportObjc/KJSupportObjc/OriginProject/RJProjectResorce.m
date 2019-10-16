//
//  RJProjectResorce.m
//  MobileHospital_Renji
//
//  Created by chenkaijie on 2019/6/17.
//  Copyright © 2019 Lyc. All rights reserved.
//

#import "RJProjectResorce.h"
#import "CKJBaseModel.h"
#import "CKJInputCell.h"

@implementation RJProjectResorce

+ (NSArray <NSString *>*)pwdNoChars {
    return @[@"|", @"_", @"&"];
}


+ (NSArray <NSDictionary *>*)item1 {
    UIImage *(^b_image)(NSString *imageName) = ^UIImage *(NSString *imageName) {
        return [[UIImage kjwd_imageNamed:imageName] kjwd_scaleToSize:CGSizeMake(40, 40)];
    };
    return @[
             @{cNormalAttTitle : WDAtt13(@"自助预约"), cNormalImage : b_image(@"newhome_自助预约")},
             @{cNormalAttTitle : WDAtt13(@"自助挂号"), cNormalImage : b_image(@"newhome_自助挂号")},
             @{cNormalAttTitle : WDAtt13(@"线上缴费"), cNormalImage : b_image(@"newhome_线上缴费")},
             @{cNormalAttTitle : WDAtt13(@"排队叫号"), cNormalImage : b_image(@"newhome_排队叫号")},
             ];
}
+ (NSArray <NSDictionary *>*)item2 {
    UIImage *(^b_image)(NSString *imageName) = ^UIImage *(NSString *imageName) {
        return [[UIImage kjwd_imageNamed:imageName] kjwd_scaleToSize:CGSizeMake(30, 30)];
    };
    return @[
             @{cNormalAttTitle : WDAtt13(@"报告查询"), cNormalImage : b_image(@"newhome_报告")},
             @{cNormalAttTitle : WDAtt13(@"费用查询"), cNormalImage : b_image(@"newhome_药费查询")},
//             @{cNormalAttTitle : WDAtt13(@"处方查询"), cNormalImage : b_image(@"newhome_处方")},
//             @{cNormalAttTitle : WDAtt13(@"药品查询"), cNormalImage : b_image(@"newhome_药品")},
             @{cNormalAttTitle : WDAtt13(@"精准预约"), cNormalImage : b_image(@"newhome_预约")},
             @{cNormalAttTitle : WDAtt13(@"日间手术"), cNormalImage : b_image(@"newhome_手术")},
             @{cNormalAttTitle : WDAtt13(@"小i机器人"), cNormalImage : b_image(@"newhome_机器人")},
             @{cNormalAttTitle : WDAtt13(@"预交金"), cNormalImage : b_image(@"newhome_预交金")
               },
             @{cNormalAttTitle : WDAtt13(@"项目药品价格"), cNormalImage : b_image(@"newhome_项目药品价格")}
             ];
}
+ (NSArray <NSDictionary *>*)item3 {
    return @[
             @{@"title" : @"入院取号", @"imageName" : @"newhome_入院取号"},
             @{@"title" : @"出院取号", @"imageName" : @"newhome_出院取号"},
//             @{@"title" : @"住院日清单", @"imageName" : @"newhome_住院清单"},
             @{@"title" : @"临床营养", @"imageName" : @"newhome_营养点餐"}
             ];
}
// @"doctDic" : 
+ (NSArray <NSDictionary *>*)item4 {
    NSString *doctDic = @"doctDic";
    return @[
             @{@"avatarImageName" : @"http://image.cmsfg.com/Images/600100/newDoctor/刘芳荪.png", @"name" : @"刘芳荪", @"job" : @"主任", @"department" : @"妇产科", doctDic : @{@"AppId" : @"600100",
                                                                                                                                                                   @"DeptName" : @"妇产科",
                                                                                                                                                                   @"Description" : @"东院:周一下午（特需），周四全天（特需） / 西院:周三全天（特需），周五上午（特需）",
                                                                                                                                                                   @"DoctorLevel" : @"1",
                                                                                                                                                                   @"DoctorLevelName" : @"主任",
                                                                                                                                                                   @"DoctorName" : @"刘芳荪",
                                                                                                                                                                   @"DoctorWorkNum" : @"2073",
                                                                                                                                                                   @"ImageUrl" : @"http://image.cmsfg.com/Images/600100/newDoctor/刘芳荪.png",
                                                                                                                                                                   @"Profession" : @"主要从事妇产科超声的医疗、教学及科研工作，有丰富的妇产科常见病临床超声诊断经验，尤其擅长妇科良恶性肿瘤的超声诊断和鉴别诊断，血液动力学在习惯性流产和生殖医学领域等的应用等。",
                                                                                                                                                                   @"Sort" : @"0",
                                                                                                                                                                   @"Status" : @"0",
                                                                                                                                                                   @"Title" : @"教育经历\n1976.11-1986.2上海交大医学院医疗系\n学术职务\n上海医学会妇产科分会超声学组委员\n论文著作\n《B型超声观察孕期宫颈机能生理性变化》、《窦卵泡计数及卵巢动脉血流变化与助孕术治疗结局的关系探讨》、《宫颈内口功能检查在预防早产、流产中的作用》、《经阴道超声和彩色多普勒超声在诊断绝经后宫腔病变中的价值》、《妊娠早期子宫动脉血流的变化及对妊娠结局的影响》等，参与编写《生殖疾病诊断学》等专著。\n获得荣誉\n在2008-2010年被杨浦区卫生局推荐为“名医师”参与杨浦区卫生局下属医院的医教研工作。参与复发性流产方面的研究成果先后获得国家科技进步二等奖、国家教育部科技进步二等奖、教育部提名国家科学技术奖自然科学二等奖，中华医学科技奖二等奖、上海市科技进步二等奖、上海市医学科技二等奖以及上海第二医科大学临床医疗成果二等奖等。\n",}
               
               },
             @{@"avatarImageName" : @"http://image.cmsfg.com/Images/600100/newDoctor/曹兰芳.png", @"name" : @"曹兰芳", @"job" : @"主任", @"department" : @"儿科", doctDic : @{@"AppId" : @"600100",
                                                                                                                                                                    @"DeptName" : @"儿科",
                                                                                                                                                                    @"Description" : @"西院:周五上午（特需），周六上午（特需）",
                                                                                                                                                                    @"DoctorLevel" : @"1",
                                                                                                                                                                    @"DoctorLevelName" : @"主任",
                                                                                                                                                                    @"DoctorName" : @"曹兰芳",
                                                                                                                                                                    @"DoctorWorkNum" : @"1098",
                                                                                                                                                                    @"ImageUrl" : @"http://image.cmsfg.com/Images/600100/newDoctor/曹兰芳.png",
                                                                                                                                                                    @"Profession" : @"过敏性儿童疾病",
                                                                                                                                                                    @"Sort" : @"0",
                                                                                                                                                                    @"Status" : @"0",
                                                                                                                                                                    @"Title" : @"教育经历\n曹兰芳主任从事儿科临床和科研工作38个春秋。19*屏蔽的关键字*师从欧阳仁荣教授，1992年获硕士学位。现任仁济儿科科主任，博士研究生导师。她具有丰富的临床经验，强烈进取、组织团队协作精神，准确把握定位仁济儿科的专业特色。明确儿科在医院的定位，让综合性医院的儿科走出困境，必须利用综合性医院成人重点学科的优势。仁济风湿科是全国闻名的重点学科，她带领儿科参加陈顺乐教授领导的GROPEC协作组。经过十八年的努力，形成仁济儿科风湿病规范诊治和特色，同时开展课题研究，总结发表论文70余篇，SIC文章6篇，参编专著6部。获得市科委进步奖一项。培养、指导21名硕士研究生和9名博士研究生。连续六年举办了《儿童风湿病诊治进展》全国继续教育学习班，4期卫生部继续教育网络学习班。多次受小儿专科医院邀请主讲《儿童风湿病诊治进展》。《全身性幼年特发性关节炎临床特征及预后的研究》论文在国际会议中心召开的首届东方儿童国际论坛上演讲，参与主持第一届北京儿科发展国际论坛，受到与会专家学者的一致认可。仁济儿科在风湿病方面开展的特色项目如关节腔内药物注射治疗幼年特发性关节炎的技术和水平在国内开展最早,尤其是通过关节腔内药物注射治疗幼年特发性关节炎少关节炎型在临床上为病人解除痛苦同时减少了全身用药的副作用，并积累了丰富的临床经验。另外生物制剂在仁济儿科很早就开始临床应用，生物制剂依那西普对儿童关节炎的疗效打破了传统金字塔的用药理念。在促进许多幼年特发性关节炎患者快速得到疾病缓解的同时也减少了以往使用糖皮质激素治疗JIA的副作用。该技术已得到许多患儿及家长的广泛认可，许多患儿及家长络绎不绝纷纷从全国各地来院诊治。\n学术职务\n曹兰芳主任现任中华医学会小儿免疫分会委员，全国儿童风湿病协作组副组长，中华医学会上海分会顾问，中华医学会上海分会变态反应专科委员会顾问，上海儿科免疫学会副主任委员，《临床儿科杂志》编委，《中华实用儿科临床杂志》编委，中华临床医师杂志编委兼审稿专家，上海市卫生局儿科临床质量控制中心专家委员会委员，上海市卫生局儿科住院医生规范培训基地专家。\n课题研究\n现已完成1项卫生部课题，四项上海市科委基金资助项目。目前承担着 2项上海市科委基金资助的重大项目，1项卫生局重点项目，2项局级横向课题。\n"}},
             @{@"avatarImageName" : @"http://image.cmsfg.com/Images/20190422/2019042204580875.jpg", @"name" : @"江一鸣", @"job" : @"副主任", @"department" : @"耳鼻咽喉科", doctDic : @{@"AppId" : @"600100",
                                                                                                                                                                             @"DeptName" : @"耳鼻咽喉科",
                                                                                                                                                                             @"DoctorLevel" : @"2",
                                                                                                                                                                             @"DoctorLevelName" : @"副主任",
                                                                                                                                                                             @"DoctorName" : @"江一鸣",
                                                                                                                                                                             @"DoctorWorkNum" : @"1698",
                                                                                                                                                                             @"ImageUrl" : @"http://image.cmsfg.com/Images/20190422/2019042204580875.jpg",
                                                                                                                                                                             @"Profession" : @"鼻科疾病的内外科综合诊治",
                                                                                                                                                                             @"Sort" : @"0",
                                                                                                                                                                             @"Status" : @"0",
                                                                                                                                                                             @"Title" : @"教育经历\n2001年毕业于上海第二医科大学（现上海交通大学医学院）临床医学法文班；2009年获医学硕士学位；2010年赴法国斯特拉斯堡H?pital de Hautepierre耳鼻咽喉头颈外科进修，目前于上海交通大学医学院“神经细胞信号调控”徐天乐研究组攻读博士学位。\n学术职务\n担任《中国中西医结合耳鼻咽喉科杂志》通讯编委。\n论文著作\n先后在*屏蔽的关键字*发表数篇高质量文献，多次参加国内外学术交流，参与多项市局级课题\n课题研究\n神经细胞信号调控\n获得荣誉\n评为优秀青年教师"}},
             @{@"avatarImageName" : @"http://image.cmsfg.com/Images/20190422/2019042205263422.png", @"name" : @"曹芝君", @"job" : @"主任", @"department" : @"消化科", doctDic : @{@"AppId" : @"600100",
                                                                                                                                                                          @"DeptName" : @"消化科",
                                                                                                                                                                          @"DoctorLevel" : @"1",
                                                                                                                                                                          @"DoctorLevelName" : @"主任",
                                                                                                                                                                          @"DoctorName" : @"曹芝君",
                                                                                                                                                                          @"DoctorWorkNum" : @"1021",
                                                                                                                                                                          @"ImageUrl" : @"http://image.cmsfg.com/Images/20190422/2019042205263422.png",
                                                                                                                                                                          @"Profession" : @"胃－食管反流病、慢性便秘等胃肠道动力和功能性疾病，内镜检查",
                                                                                                                                                                          @"Sort" : @"0",
                                                                                                                                                                          @"Status" : @"0"}},
             @{@"avatarImageName" : @"http://image.cmsfg.com/Images/20190422/2019042205231714.jpg", @"name" : @"周立新", @"job" : @"主任", @"department" : @"泌尿科", doctDic : @{@"AppId" : @"600100",
                                                                                                                                                                          @"DeptName" : @"泌尿科",
                                                                                                                                                                          @"DoctorLevel" : @"1",
                                                                                                                                                                          @"DoctorLevelName" : @"主任",
                                                                                                                                                                          @"DoctorName" : @"周立新",
                                                                                                                                                                          @"DoctorWorkNum" : @"1261",
                                                                                                                                                                          @"ImageUrl" : @"http://image.cmsfg.com/Images/20190422/2019042205231714.jpg",
                                                                                                                                                                          @"Profession" : @"泌尿生殖系肿瘤，擅长肿瘤冷冻微创治疗；显微外科技术治疗精索静脉曲张",
                                                                                                                                                                          @"Sort" : @"0",
                                                                                                                                                                          @"Status" : @"0"}},
             @{@"avatarImageName" : @"http://image.cmsfg.com/Images/600100/newDoctor/徐纪文.png", @"name" : @"徐纪文", @"job" : @"主任", @"department" : @"功能神经科", doctDic : @{@"AppId" : @"600100",
                                                                                                                                                                       @"DeptName" : @"功能神经科",
                                                                                                                                                                       @"Description" : @"西院:周一上午 / 东院:周三上午",
                                                                                                                                                                       @"DoctorLevel" : @"1",
                                                                                                                                                                       @"DoctorLevelName" : @"主任",
                                                                                                                                                                       @"DoctorName" : @"徐纪文",
                                                                                                                                                                       @"DoctorWorkNum" : @"1197",
                                                                                                                                                                       @"ImageUrl" : @"http://image.cmsfg.com/Images/600100/newDoctor/徐纪文.png",
                                                                                                                                                                       @"Profession" : @"难治性癫痫和帕金森病外科治疗",
                                                                                                                                                                       @"Sort" : @"0",
                                                                                                                                                                       @"Status" : @"0",
                                                                                                                                                                       @"Title" : @"学术职务\n现任中国医师协会-神经外科分会-功能神经外科全国专家委员会委员；\n中国医师协会-疼痛分会 全国专家委员会委员；\n中国医师协会-神经调控分会委员；\n中国抗癫痫协会理事；\n《中华神经医学杂志》编委；\n上海癫痫之友的专家组成员\n论文著作\n刘强强,徐纪文,田鑫. 迷走神经刺激对癫痫患者生活质量影响的研究. 立体定向和功能性神经外科杂志,2012;24(1):34-37.\n刘强强,徐纪文,田鑫. 胼胝体切开术治疗药物难治性全身性癫痫的临床研究. 中国临床神经外科杂志,2012;17(4):197-199.\nHongyu Zhou, Jiwen Xu, Jiyao Jiang. Deep brain stimulation of nucleus accumbens on heroin-seeking behaviors: a case report. Biological Psychiatry,2011;69(11):e41-e42.\n刘强强,徐纪文,田鑫. 迷走神经刺激治疗难治性癫痫持续状态一例并文献复习. 中华神经外科杂志,2011;27(11):1111-1112.\n赵晨杰,徐纪文,王桂松. 导航辅助皮层功能拓扑定位在累及功能区致痫灶手术中的初步应用. 中华神经外科杂志,2011;27(11):1086-1090.\n刘强强,徐纪文. 迷走神经刺激术治疗药物难治性癫痫的价值. 中华神经医学杂志,2011;10（9）:970-972.\n徐虎,徐纪文,赵晨杰. 功能磁共振与皮层电刺激定位感觉运动区的比较. 中华神经外科杂志,2010;26(12):1094-1097.\nPing Zheng, Jiwen Xu,guisong wang, Evaluation of ef?cacy and safety of anterior corpus callosotomy with keyhole in refractory seizures. Seizure. 2009 ;18(6):417-419.\n课题研究\n2007年 浦东新区脑血管病防治平台建立--上海市浦东新区科学技术委员会 \n2010年 VNS对难治性癫痫中多药耐药基因表达变化的机制研究--上海市科委基础研究重点项目\n2013年 VNS对难治性癫痫大鼠脑内异常的兴奋抑制平衡网络的调节--上海交通大学医学院附属仁济医院\n获得荣誉\n上海市科技进步三等奖"}}
             ];
}



+ (NSString *)yuyueXuZHi {
    NSString *str =
    @"1、预约成功后，您可随时通过预约平台查询您的预约信息，请认真核对您的预约信息，并按时就诊。\n"
    @"2、平台预约周期按医院实际开放天数为准。\n"
    @"3、一个账号只能首诊预约一次。\n"
    @"4、我院男性科、妇科、儿科，生殖医学科等有预约条件限制，请在预约时注意信息具体提示，按要求进行预约。\n"
    @"5、请保持手机畅通，若有门诊停诊等情况，我们将通过短信通知的方式提前通知您。\n"
    @"6、如您因故不能按时就诊，请提前取消预约，非本平台的预约，请在原预约渠道进行取消。\n"
    @"7、爽约三次以上将进入黑名单。\n"
    @"本须知内容最终解释权归仁济医院所有";
    return str;
}


+ (NSString *)guahaoXuZHi {
    NSString *str =
    @"1、目前只支持自费卡挂号。\n"
    @"2、我院男性科、妇科、儿科，生殖医学科等有挂号条件限制，请在挂号时注意信息具体提示，按要求进行挂号。\n"
    @"3、请保持手机畅通，若有门诊停诊等情况，我们将通过短信通知的方式提前通知您。\n"
    @"4、预约上午就诊者请于就诊当天10:30前完成挂号，下午就诊者请于15:30前完成挂号。\n"
    @"5、持就诊卡可至该挂号就诊院区的门诊收费处换取正式收据。\n"
    @"6、挂号当班有效，隔班作废。\n"
    @"本须知内容最终解释权归仁济医院所有";
    return str;
}


+ (NSArray <CKJStringChooseItem *>*)Gender {
    return @[
    [CKJStringChooseItem itemWithContent:@"男"  takeStr:@"1"],
    [CKJStringChooseItem itemWithContent:@"女"   takeStr:@"2"],
    [CKJStringChooseItem itemWithContent:@"未知" takeStr:@"0"]
    ];
}

+ (NSArray <CKJStringChooseItem *>*)CardType {
    return @[
       [CKJStringChooseItem itemWithContent:@"自费卡"  takeStr:@"0"],
       [CKJStringChooseItem itemWithContent:@"医保卡"  takeStr:@"1"]
       ];
}

+ (NSArray <CKJStringChooseItem *>*)Relationship {
    return @[
       [CKJStringChooseItem itemWithContent:@"本人"  takeStr:@"0"],
       [CKJStringChooseItem itemWithContent:@"家人"   takeStr:@"1"],
       [CKJStringChooseItem itemWithContent:@"朋友" takeStr:@"2"],
       [CKJStringChooseItem itemWithContent:@"其他" takeStr:@"3"]
       ];
}

+ (NSArray <CKJStringChooseItem *>*)IDCardType {
    return @[
        [CKJStringChooseItem itemWithContent:@"身份证" takeStr:@"1"],
        [CKJStringChooseItem itemWithContent:@"护照"   takeStr:@"3"],
        [CKJStringChooseItem itemWithContent:@"驾驶证" takeStr:@"5"],
        [CKJStringChooseItem itemWithContent:@"军官证" takeStr:@"4"],
        [CKJStringChooseItem itemWithContent:@"其他"   takeStr:@"99"]
    ];
}



@end
