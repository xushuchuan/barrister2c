//
//  PersonCenterViewController.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/15.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "PersonCenterModel.h"
#import "PersonCenterCustomCell.h"
#import "PersonCenterAccountCell.h"
#import "MyMessageViewController.h"
#import "PersonInfoViewController.h"
#import "SettingViewController.h"
#import "MyLikeViewController.h"
#import "MyAccountViewController.h"
#import "MyOrderListViewController.h"
#import "BarristerLoginManager.h"
#import "NeedHelpViewController.h"
#import "MyUploadYingShowViewController.h"
#import "MyBuyYingShowViewController.h"
#import <UMSocialCore/UMSocialManager.h>
#import <UShareUI/UShareUI.h>
#import "ShareCosumeListViewController.h"

@implementation PersonCenterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    [self configData];
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:NOTIFICATION_LOGIN_SUCCESS object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:NOTIFICATION_LOGOUT_SUCCESS object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPayData) name:NOTIFICATION_PAYSWITCH_NOTIFICATION object:nil];

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showTabbar:YES];
    if (self.tableView) {
        [self.tableView reloadData];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma -mark ------Data-------

-(void)reloadPayData
{
    if (self.items.count > 0) {
        [self.items removeAllObjects];
        [self configData];
    }
}


-(void)configData
{
    
    if (self.items) {
        [self.items removeAllObjects];    
    }
    
    
    PersonCenterModel *model1 = [[PersonCenterModel alloc] init];
    model1.cellType = PersonCenterModelTypeZH;

    if ([BaseDataSingleton shareInstance].loginState.integerValue == 1) {
        model1.titleStr = [BaseDataSingleton shareInstance].userModel.nickname;
        model1.iconNameStr = [BaseDataSingleton shareInstance].userModel.userIcon;
        model1.isShowArrow = NO;
        model1.isAccountLogin = YES;

    }
    else
    {
        model1.titleStr = @"注册/登录";
        model1.cellType = PersonCenterModelTypeZH;
        model1.iconNameStr = @"commom_default_head.png";
        model1.isShowArrow = NO;
        model1.isAccountLogin = NO;

    }
    
    
    PersonCenterModel *model = [[PersonCenterModel alloc] init];
    model.titleStr = @"我的收藏";
    model.cellType = PersonCenterModelTypeSC;
    model.iconNameStr = @"Me_like";
    model.isShowArrow = YES;

    

    
    PersonCenterModel *model5 = [[PersonCenterModel alloc] init];
    model5.titleStr = @"我的订单";
    model5.cellType = PersonCenterModelTypeDD;
    model5.iconNameStr = @"Me_order";
    model5.isShowArrow = YES;

    
    PersonCenterModel *model3 = [[PersonCenterModel alloc] init];
    model3.titleStr = @"我的消息";
    model3.cellType = PersonCenterModelTypeXX;
    model3.iconNameStr = @"Me_message";
    model3.isShowArrow = YES;
    
    
    PersonCenterModel *model4 = [[PersonCenterModel alloc] init];
    model4.titleStr = @"我要求助";
    model4.cellType = PersonCenterModelTypeQiuZhu;
    model4.iconNameStr = @"Me_help";
    model4.isShowArrow = YES;
 
    
    
    PersonCenterModel *model7 = [[PersonCenterModel alloc] init];
    model7.titleStr = @"我上传的债权债务信息";
    model7.cellType = PersonCenterModelTypeYSSC;
    model7.iconNameStr = @"zhaixitong";
    model7.isShowArrow = YES;
    
    PersonCenterModel *model8 = [[PersonCenterModel alloc] init];
    model8.titleStr = @"我购买的债权债务信息";
    model8.cellType = PersonCenterModelTypeYSGM;
    model8.iconNameStr = @"zhaixitong";
    model8.isShowArrow = YES;
   
    
    PersonCenterModel *model9 = [[PersonCenterModel alloc] init];
    model9.titleStr = @"推荐给好友";
    model9.cellType = PersonCenterModelTypeTJHY;
    model9.iconNameStr = @"me_share";
    model9.isShowArrow = YES;
    
   
    
    PersonCenterModel *model6 = [[PersonCenterModel alloc] init];
    model6.titleStr = @"设置";
    model6.cellType = PersonCenterModelTypeSZ;
    model6.iconNameStr = @"Me_setting";
    model6.isShowArrow = YES;
    
    
   
    
    [self.items addObject:model1];
    [self.items addObject:model];
    [self.items addObject:model5];
    
    if ([BaseDataSingleton shareInstance].isClosePay) {
        
    }
    else
    {
        PersonCenterModel *model2 = [[PersonCenterModel alloc] init];
        model2.titleStr = @"我的账户";
        model2.cellType = PersonCenterModelTypeZHU;
        model2.iconNameStr = @"Me_Account";
        model2.isShowArrow = YES;
        [self.items addObject:model2];
    }
    
    
    [self.items addObject:model3];
    [self.items addObject:model4];
    [self.items addObject:model7];
    [self.items addObject:model8];
    [self.items addObject:model9];

    if ([[BaseDataSingleton shareInstance].userModel.salesman isEqualToString:@"1"]) {
        PersonCenterModel *model10 = [[PersonCenterModel alloc] init];
        model10.titleStr = @"分销记录";
        model10.cellType = PersonCenterModelTypeFXXF;
        model10.iconNameStr = @"me_share";
        model10.isShowArrow = YES;
        
        [self.items addObject:model10];

    }
    

    
    
    [self.items addObject:model6];
    
    

}


#pragma -mark --------UI--------

-(void)reloadTableView
{
    [self.items removeAllObjects];
    [self configData];
    [self.tableView reloadData];
}

-(void)configView
{
    
}


#pragma -mark --------UITableView DataSource Methods----------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return self.items.count - 2;
    }
    else
    {
        return 1;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20)];
        view.backgroundColor = kBaseViewBackgroundColor;
        return view;
    }
    else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        return 20;
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"accountCell";
        PersonCenterAccountCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            cell = [[PersonCenterAccountCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        PersonCenterModel *model =  (PersonCenterModel *)[self.items safeObjectAtIndex:0];
        cell.model = model;
        return cell;
        
    }
    else
    {
        static NSString *CellIdentifier = @"customCell";
        PersonCenterCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            cell = [[PersonCenterCustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        PersonCenterModel *model =  (PersonCenterModel *)[self.items safeObjectAtIndex:indexPath.section == 1?(indexPath.row + 1):(self.items.count - 1)];
        cell.model = model;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [PersonCenterAccountCell getCellHeight];
    }
    else
    {
        return  [PersonCenterCustomCell getCellHeight];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    
    if (indexPath.section == 0) {
        
        if ([BaseDataSingleton shareInstance].loginState.integerValue != 1) {
            [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
            return;
        }
        
        PersonInfoViewController *personInfo = [[PersonInfoViewController alloc] init];
        [self.navigationController pushViewController:personInfo animated:YES];
    }
    else if (indexPath.section == 1)
    {
        
        if ([BaseDataSingleton shareInstance].loginState.integerValue != 1) {
            [[BarristerLoginManager shareManager] showLoginViewControllerWithController:self];
            return;
        }

        
        PersonCenterModel *model = [self.items objectAtIndex:indexPath.row + 1];
        if (!model) {
            return;
        }
        
        switch (model.cellType) {
            case PersonCenterModelTypeSC:
            {
                MyLikeViewController *likeVC = [[MyLikeViewController alloc] init];
                [self.navigationController pushViewController:likeVC animated:YES];

            }
                break;
            case PersonCenterModelTypeDD:
            {
                MyOrderListViewController *orderListVC = [[MyOrderListViewController alloc] init];
                [self.navigationController pushViewController:orderListVC animated:YES];
            }
                break;
            case PersonCenterModelTypeZHU:
            {
                
                MyAccountViewController *accountVC = [[MyAccountViewController alloc] init];
                [self.navigationController pushViewController:accountVC animated:YES];

            }
                break;
            case PersonCenterModelTypeXX:
            {
                MyMessageViewController *messageVC = [[MyMessageViewController alloc] init];
                [self.navigationController pushViewController:messageVC animated:YES];

            }
                break;
            case PersonCenterModelTypeQiuZhu:
            {
                NeedHelpViewController *needVC = [[NeedHelpViewController alloc] init];
                [self.navigationController pushViewController:needVC animated:YES];
            }
                break;
              case PersonCenterModelTypeYSSC:
            {
                MyUploadYingShowViewController *uploadVC = [[MyUploadYingShowViewController alloc] init];
                [self.navigationController pushViewController:uploadVC animated:YES];
            }
                break;
                
            case PersonCenterModelTypeYSGM:
            {
                MyBuyYingShowViewController *buyVC = [[MyBuyYingShowViewController alloc] init];
                [self.navigationController pushViewController:buyVC animated:YES];
            }
                break;
            case PersonCenterModelTypeTJHY:
            {
                [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Sina)]];
                [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                    // 根据获取的platformType确定所选平台进行下一步操作
                    
                    [self shareContentWithPlatFormType:platformType];
                    
                }];
                
            }
                break;
                case PersonCenterModelTypeFXXF:
            {
                ShareCosumeListViewController *shareComsumeList = [[ShareCosumeListViewController alloc] init];
                [self.navigationController pushViewController:shareComsumeList animated:YES];
                
            }
                break;
            default:
                break;
        }
    }
    else
    {
        SettingViewController *settingVC = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

-(void)shareContentWithPlatFormType:(UMSocialPlatformType)platformType
{

        //创建分享消息对象
//    UMShareWebpageObject *messageObject = [[UMShareWebpageObject alloc] init];
//    messageObject.title = @"中国大律师";
//    messageObject.descr = @"端起法律武器，纠纷业务一键了解;权威律师一键预约，应用法律全面搜集;书籍视频随时学习，做生活中的大律师";
//    
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"中国大律师" descr:@"端起法律武器，纠纷业务一键了解;权威律师一键预约，应用法律全面搜集;书籍视频随时学习，做生活中的大律师" thumImage:[UIImage imageNamed:@"logoForShare"]];
    
    shareObject.webpageUrl = [NSString stringWithFormat:@"http://app.dls.com.cn:8080/clientservice/wap/barrister2c.do?uid=%@",[BaseDataSingleton shareInstance].userModel.userId];

    
    UMSocialMessageObject *object  = [UMSocialMessageObject messageObjectWithMediaObject:shareObject];
    
    
    
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:object currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                [XuUItlity showFailedHint:@"分享失败" completionBlock:nil];
            }else{
                [XuUItlity showSucceedHint:@"分享成功" completionBlock:nil];
            }
        }];

}
    
    
    
@end
