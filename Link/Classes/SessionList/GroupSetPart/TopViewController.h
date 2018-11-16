//
//  TopViewController.h
//  BM
//
//  Created by hackxhj on 15/9/7.
//  Copyright (c) 2015年 hackxhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "PersonModel.h"
#import "GroupMembersModel.h"

@protocol TopViewControllerDelagate <NSObject>

-(void)addBtnClick;
-(void)subBtnClick;
-(void)delDataWithStr:(PersonModel*)strF;
- (void)cellOfItemClicked:(GroupMembersModel *)model;
@end
@interface TopViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSString *signStr;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,copy) NSMutableArray * arrayTemp;
@property(nonatomic,strong)id<TopViewControllerDelagate>delagate;
@property(nonatomic) BOOL   isdelM;

-(void)delOneTximg:(PersonModel*)person;
-(void)addOneTximg:(PersonModel*)person;

- (void)deleteSomeOne:(GroupMembersModel *)person;
- (void)addSomeOne:(NSArray *)person;

//-(void)delGroupOneTximg:(PersonModel*)person;
-(void)isInputDelMoudle:(BOOL)isDel;
@property(nonatomic) BOOL   isGroupM;

@end
