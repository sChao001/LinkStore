//
//  EditContentViewController.m
//  EditContentDemo
//
//  Created by Eleven on 2017/3/25.
//  Copyright © 2017年 Hawk. All rights reserved.
//

#import "EditContentViewController.h"
#import "EditContentAllView.h"
#import "EditContentModel.h"
#import "ResultPromptView.h"

static CGFloat const kFooterHeight = 45;

@interface EditContentViewController () <UITableViewDataSource, UITableViewDelegate, TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<EditContentModel *> *dataArr;
@property (nonatomic, strong) EditContentTableHeader *tableHeader;
@property (nonatomic, strong) UIButton *footerView;
@property (nonatomic, assign) NSInteger responderIndex;
@property (nonatomic, getter=isInsertImg) BOOL insertImg;
@property (nonatomic, copy) NSArray *testUrls;

@end

@implementation EditContentViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBarButtonWithNorImgName:@"y_back"];
    [self _initSubViews];
    [self _initData];
    [self creatMyAlertlabel];
}
- (void)viewDidLayoutSubviews {
    self.tableHeader.frame = CGRectMake(0, 0, kScreenWidth, 67);
}

#pragma mark - private methods
- (void)_initSubViews {
    self.title = @"发布资讯";
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(_publish)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [rightBarItem setTintColor:RGB(28, 28, 28)];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
}

- (void)_initData {
    _testUrls = @[@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_b.jpg",
                  @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_b.jpg",
                  @"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_b.jpg"];
    EditContentModel *textModel = [[EditContentModel alloc] init];
    textModel.inputStr = @"";
    textModel.cellType = EditContentCellTypeText;
    [self.dataArr addObject:textModel];
    [self.tableView reloadData];
}

- (void)_uploadWithImage:(UIImage *)image index:(NSInteger)index {
    NSLog(@"%zi", index);
    NSLog(@"q%@", image);
    
    EditContentModel *model = self.dataArr[index];
    
    NSData *imageData = UIImageJPEGRepresentation(model.img, 0.5);
    NSString *imageString = [imageData base64EncodedString];
    model.imageUrl = imageString;
    NSLog(@"imageString:%@", imageString);
 
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        EditContentModel *model = self.dataArr[index];
//        // 模拟上传返回的图片路径
//        model.imageUrl = self.testUrls[arc4random() % 3];
//    });
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditContentModel *model = self.dataArr[indexPath.row];
    if (model.cellType == EditContentCellTypeImage) {
        EditContentImgViewCell *imgCell = [EditContentImgViewCell cellWithTableView:tableView];
        [imgCell setModel:model];
        imgCell.deleteImgBlock = ^() {
            [self.dataArr removeObjectAtIndex:indexPath.row];
            if (indexPath.row != 0) {
                EditContentModel *frontModel = self.dataArr[indexPath.row - 1];
                EditContentModel *lastModel = self.dataArr[indexPath.row];
                NSString *text = nil;
                if (!frontModel.inputStr.length || !lastModel.inputStr.length) {
                    text = [NSString stringWithFormat:@"%@%@", frontModel.inputStr, lastModel.inputStr];
                } else {
                    text = [NSString stringWithFormat:@"%@\n%@", frontModel.inputStr, lastModel.inputStr];
                }
                frontModel.inputStr = text;
                [self.dataArr removeObjectAtIndex:indexPath.row];
            }
            [self.tableView reloadData];
        };
        return imgCell;
    } else {
        EditContentTextViewCell *textCell = [EditContentTextViewCell cellWithTableView:tableView];
        [textCell setModel:model];
        textCell.insertImgBlock = ^() {
            [self _insertImg];
        };
        return textCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditContentModel *model = self.dataArr[indexPath.row];
    if (model.cellType == EditContentCellTypeImage) {
        return 212;
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - event response
- (void)_addImg {
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:100 delegate:self];
    imagePickerVC.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                                        NSForegroundColorAttributeName:HexColorInt32_t(D6BD99)};
    @weakify(self);
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        @strongify(self);
        for (NSInteger i = 0; i < photos.count; i ++) {
            EditContentModel *imgModel = [[EditContentModel alloc] init];
            imgModel.img = photos[i];
            NSLog(@"AA%@===%ld", photos[i], i);
            imgModel.cellType = EditContentCellTypeImage;
            if (self.isInsertImg == YES) {
                [self.dataArr insertObject:imgModel atIndex:self.responderIndex + (2 * i + 1)];
            } else {
                [self.dataArr addObject:imgModel];
            }
            [self _uploadWithImage:photos[i] index:[self.dataArr indexOfObject:imgModel]];
            
            
            EditContentModel *textModel = [[EditContentModel alloc] init];
            textModel.inputStr = @"";
            textModel.cellType = EditContentCellTypeText;
            if (self.isInsertImg == YES) {
                [self.dataArr insertObject:textModel atIndex:self.responderIndex + (2 * i + 2)];
            } else {
                [self.dataArr addObject:textModel];
            }
        }
        [self.tableView reloadData];
        [self.tableView scrollToBottom];
        self.insertImg = NO;
    }];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)headerBtnClicked:(UIButton *)sender {
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *fromPhotoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
        
        imagePicker.delegate = self;
        
        
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* fromCameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault                                                             handler:^(UIAlertAction * action) {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            
        {
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            
            imagePicker.delegate = self;
            
            //            imagePicker.allowsEditing = YES;
            
            imagePicker.allowsEditing = YES;
            
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
    }];
    [alertSheet addAction:cancelAction];
    
    [alertSheet addAction:fromCameraAction];
    
    [alertSheet addAction:fromPhotoAction];
    [self presentViewController:alertSheet animated:YES completion:nil];
}
//用户选择完毕 头像的选择器的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //头像
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:) withObject:img afterDelay:0.5];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    EditContentModel *imgModel = [[EditContentModel alloc] init];
    imgModel.img = [info objectForKey:UIImagePickerControllerOriginalImage];
//    imgModel.img = photos[i];
//    NSLog(@"AA%@===%ld", photos[i], i);
    imgModel.cellType = EditContentCellTypeImage;
    [self.dataArr addObject:imgModel];
    [self _uploadWithImage:imgModel.img index:[self.dataArr indexOfObject:imgModel]];
    
    
    EditContentModel *textModel = [[EditContentModel alloc] init];
    textModel.inputStr = @"";
    textModel.cellType = EditContentCellTypeText;
    [self.dataArr addObject:textModel];

    [self.tableView reloadData];
    self.insertImg = NO;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"用户取消了");
    [picker dismissViewControllerAnimated:YES completion:nil];
}



//裁剪保存头像图片
- (void)saveImage:(UIImage *)image{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error;
    NSString *path = [self getheadPath];
    BOOL success = [manager fileExistsAtPath:path];
    if (success) {
        success = [manager removeItemAtPath:path error:&error];
    }
    //将图片设置成200*200压缩图片
    UIImage *smallImage = [CommentTool scallImage:image toSize:CGSizeMake(200, 200)];
    //写入文件
    [UIImagePNGRepresentation(smallImage) writeToFile:path atomically:YES];
    //    [self postImageData:path];
    
    //读取文件
    //    UIImage *photoImg = [UIImage imageWithContentsOfFile:path];
    //    [_headerBtn setBackgroundImage:photoImg forState:(UIControlStateNormal)];
    
}
//再本地获取图片路径啊
-(NSString *)getheadPath
{
    NSString* str=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* path=[str stringByAppendingPathComponent:@"postImage.png"];
    return path;
}
- (void)_insertImg {
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    id firstResponder = [keywindow performSelector:@selector(firstResponder)];
    if ([firstResponder isKindOfClass:[UITextView class]]) {
        // 这里已经判断出来了第一响应者，可以完成相应的操作
        UITextView *textView = (UITextView *)firstResponder;
        EditContentTextViewCell *textCell = (EditContentTextViewCell *)textView.superview.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:textCell];
        self.responderIndex = indexPath.row;
        self.insertImg = YES;
        [self _addImg];
//        [self headerBtnClicked:nil];
    }
}

- (void)_publish {
    if ((self.dataArr.count == 1 && !self.dataArr[0].inputStr.length) || !self.tableHeader.field.text.length) {
        [ResultPromptView showPromptWithMessage:@"请完善发布内容"];
        return;
    }
    NSMutableArray *arrM = [NSMutableArray array];
    NSLog(@"%ld", self.dataArr.count);
    if (self.dataArr.count % 2 == 0) {
        for (NSInteger i = 0; i < self.dataArr.count / 2; i ++) {
            EditContentItemModel *model = [[EditContentItemModel alloc] init];
            model.imageUrl = self.dataArr[2 * i].imageUrl;
            model.inputStr = self.dataArr[2 * i + 1].inputStr;
            
            [arrM addObject:model];
            NSLog(@"文字%@", model.inputStr);
            NSLog(@"1图片%@", model.imageUrl);
        }
    } else {
        for (NSInteger i = 0; i < (self.dataArr.count + 1) / 2; i ++) {
            if (i == 0) {
                EditContentItemModel *model = [[EditContentItemModel alloc] init];
                model.imageUrl = @"";
                model.inputStr = self.dataArr[0].inputStr;
                [arrM addObject:model];
                NSLog(@"文字%@", model.inputStr);
                NSLog(@"2图片%@", model.imageUrl);
                NSLog(@"%@", arrM);
            } else {
                EditContentItemModel *model = [[EditContentItemModel alloc] init];
                model.imageUrl = self.dataArr[2 * i - 1].imageUrl;
                model.inputStr = self.dataArr[2 * i].inputStr;
                [arrM addObject:model];
                NSLog(@"文字%@", model.inputStr);
                NSLog(@"3图片%@", model.imageUrl);
            }
        }
    }
    NSDictionary *dict = @{@"data" : arrM};
    NSString *mEditorDatas = [dict modelToJSONString];
    NSLog(@"%@", dict);
    NSLog(@"%@", mEditorDatas);
    
    [self publishTextAndImage:mEditorDatas];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [ResultPromptView showPromptWithMessage:@"发布成功"];
//    });
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kFooterHeight + LK_iPhoneXNavHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 180;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = HexColorInt32_t(F0F0F0);
        _tableView.tableHeaderView = self.tableHeader;
//        _tableView.backgroundColor = [UIColor redColor];
        
    }
    return _tableView;
}

- (EditContentTableHeader *)tableHeader {
    if (!_tableHeader) {
        _tableHeader = [[[NSBundle mainBundle] loadNibNamed:@"EditContentAllView" owner:self options:nil] objectAtIndex:0];
    }
    return _tableHeader;
}

- (UIButton *)footerView {
    if (!_footerView) {
        _footerView = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - kFooterHeight-LK_TabbarSafeBottomMargin, kScreenWidth, kFooterHeight)];
        [_footerView setTitle:@"添加图片" forState:UIControlStateNormal];
        _footerView.backgroundColor = [UIColor lightGrayColor];
        [_footerView addTarget:self action:@selector(_addImg) forControlEvents:UIControlEventTouchUpInside];
//        [_footerView addTarget:self action:@selector(headerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

- (NSMutableArray<EditContentModel *> *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)publishTextAndImage:(NSString *)textJSONStr {
    NSLog(@"%@", self.tableHeader.field.text);
    NSString *titleString = self.tableHeader.field.text;
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid, @"content" : textJSONStr, @"title" : titleString, @"type" : @"1"};
    [SCNetwork postWithURLString:BDUrl_s(@"usernews/issueUserNewsIos") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            [self alertShowWithTitle:dic[@"result"]];
//            [self publishReward];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败，检查网络"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}
// 发帖奖励
- (void)publishReward {
    NSDictionary *paramet = @{@"sign" : BD_MD5Sign.md5String, @"userId" : [UserInfo sharedInstance].getUserid};
    [SCNetwork postWithURLString:BDUrl_s(@"gold/postGold") parameters:paramet success:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] > 0) {
            NSLog(@"%@", dic);
            [self alertShowWithTitle:[NSString stringWithFormat:@"发布成功获得%@金币", dic[@"gold"]]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络连接失败"];
        [SVProgressHUD dismissWithDelay:0.7];
    }];
}







@end
