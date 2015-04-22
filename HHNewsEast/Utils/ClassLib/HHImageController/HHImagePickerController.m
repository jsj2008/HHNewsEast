//
//  HHImagePickerController.m
//  SeaMallSell
//
//  Created by d gl on 14-3-24.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHImagePickerController.h"
#import "HHNetWorkEngine+UploadImage.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface HHImagePickerController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@end

@implementation HHImagePickerController
@synthesize imagePickerController       =_imagePickerController;
@synthesize parentController            =_parentController;
@synthesize delegate                    =_delegate;
@synthesize imgMark                     =_imgMark;

-(void)dealloc{
    _imagePickerController.delegate=nil;
    _imagePickerController=nil;
    _delegate=nil;
    _parentController=nil;
}

-(id)initWithParentControler:(id)controller delegate:(id)delegate{
    self =[super init];
    if (self) {
        _delegate=delegate;
        _parentController=controller;
        _imagePickerController=[[UIImagePickerController alloc] init];
        _imagePickerController.delegate=self;
    }
    return self;
}
-(void)hhImagePickerControllerPickImageWithImageMark:(HHUploadImageMark)img_mark{
    _imgMark=img_mark;
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照上传" otherButtonTitles:@"相册上传", nil];
    actionSheet.tag=1000;
    if ([_parentController isKindOfClass:[UIViewController class]]) {
        [actionSheet showInView:_parentController.view];
    }else if ([_parentController isKindOfClass:[UIView class]]){
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    
}
#pragma mark -选取照片并上传
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *images=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage *dealImage=[self compressionImage:images ToSize:CGSizeMake(800.0, 1000.0)];
    NSString *filePath=[self imagePathByWirteToCacheDiroctoryWithImage:dealImage];
    [_parentController dismissViewControllerAnimated:YES completion:^{
        [self uploadImagWithImagePath:filePath imageMark:_imgMark ];
        //[self uploadImageWithImage:images imageMark:_imgMark];
    }];
}
#pragma mark- 照相
-(void)takePhotoByCameraWithImageMark:(HHUploadImageMark)img_mark{
    BOOL isAvable=[UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (isAvable) {
        _imgMark=img_mark;
        if (nil==_imagePickerController) {
            _imagePickerController=[[UIImagePickerController alloc] init];
            _imagePickerController.delegate=self;
        }
        _imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
        _imagePickerController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
        _imagePickerController.allowsEditing=NO;
        [_parentController presentViewController:_imagePickerController animated:YES completion:nil];
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
            AVAuthorizationStatus  authoStatus=[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) && (authoStatus==AVAuthorizationStatusDenied)) {
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                    // app名称
                NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
                NSString *message=[NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"选项中,允许%@访问你的相机",app_Name];
                UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alerView show];
            }
        }
    }else{
        [_parentController  showAlertView:@"该设备不支持照相功能"];
    }
}
#pragma mark- 选择照片
-(void)getPitureFromPhotoLibaryWithImageMark:(HHUploadImageMark)img_mark{
    _imgMark=img_mark;
    if (nil==_imagePickerController) {
        _imagePickerController=[[UIImagePickerController alloc] init];
        _imagePickerController.delegate=self;
    }
    _imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [_parentController presentViewController:_imagePickerController animated:YES completion:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        ALAuthorizationStatus authoStatus = [ALAssetsLibrary authorizationStatus];
        if (([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) && (authoStatus==ALAuthorizationStatusDenied)) {
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                // app名称
            NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
            NSString *message=[NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"选项中,允许%@访问你的相册",app_Name];
            UIAlertView *alerView=[[UIAlertView alloc]  initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alerView show];
        }
    }
}
#pragma mark- 上传图片
-(void)uploadImagWithImagePath:(NSString *)filePath imageMark:(HHUploadImageMark)mark{
    if (_delegate&&[_delegate respondsToSelector:@selector(hhImagePickerControllerWillUpaloadImageWithLocalPath:imageMark:)]) {
        [_delegate hhImagePickerControllerWillUpaloadImageWithLocalPath:filePath imageMark:mark];
    }
    [[HHNetWorkEngine sharedHHNetWorkEngine] uploadImageWithImagePath:filePath imageMark:mark OnCompletionHandler:^(HHResponseResult *responseResult) {
        if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
            UIImage *upImage=[UIImage imageWithContentsOfFile:filePath];
            HHImageModel *model=responseResult.responseData;
            [[SDImageCache sharedImageCache] storeImage:upImage forKey:model.imageSourceUrl];
            
            if (_delegate&&[_delegate respondsToSelector:@selector(hhImagePickerControllerDidFinisUpaloadImageWithLocalPath:imageMark:responseData:)]) {
                [_delegate hhImagePickerControllerDidFinisUpaloadImageWithLocalPath:filePath imageMark:mark responseData:responseResult.responseData];
            }
        }else{
            if (_delegate&&[_delegate respondsToSelector:@selector(hhImagePickerControllerFailedToUploadImageWithWithLocalPath:imgMark:)]) {
                [_delegate hhImagePickerControllerFailedToUploadImageWithWithLocalPath:filePath imgMark:mark];
            }
        }
    } onErrorHandler:^(NSError *error) {
        if (_delegate&&[_delegate respondsToSelector:@selector(hhImagePickerControllerFailedToUploadImageWithWithLocalPath:imgMark:)]) {
            [_delegate hhImagePickerControllerFailedToUploadImageWithWithLocalPath:filePath imgMark:mark];
        }
    }];
}
-(void)uploadImageWithImage:(UIImage *)upImage imageMark:(HHUploadImageMark)mark{
    NSString *filePath=[self imagePathByWirteToCacheDiroctoryWithImage:upImage];
    NSData *data=UIImageJPEGRepresentation(upImage, 0.9);
    [[HHNetWorkEngine sharedHHNetWorkEngine] uploadImageWithImageData:data imageMark:mark OnCompletionHandler:^(HHResponseResult *responseResult) {
        if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
            HHImageModel *model=responseResult.responseData;
            [[SDImageCache sharedImageCache] storeImage:upImage forKey:model.imageSourceUrl];
            if (_delegate&&[_delegate respondsToSelector:@selector(hhImagePickerControllerDidFinisUpaloadImageWithLocalPath:imageMark:responseData:)]) {
                [_delegate hhImagePickerControllerDidFinisUpaloadImageWithLocalPath:filePath imageMark:mark responseData:responseResult.responseData];
            }
        }else{
            [_parentController  showAlertView:responseResult.responseMessage];
        }
    } onErrorHandler:^(NSError *error) {
        [_parentController  showAlertView:@"网络错误，请检查网络"];

    }];
}
#pragma mark- actiont sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==1000) {//上传照片
        if (buttonIndex==0) {//相机
            [self takePhotoByCameraWithImageMark:_imgMark];
        }else if (buttonIndex==1){//相册
            [self getPitureFromPhotoLibaryWithImageMark:_imgMark];
        }
    }}
-(NSString *)imagePathByWirteToCacheDiroctoryWithImage:(UIImage *)image{
    if(self){
        NSData *imgData=UIImageJPEGRepresentation(image, 1.0);
        NSFileManager *fileMgr=[NSFileManager defaultManager];
        NSTimeInterval timeInterval=[[NSDate date] timeIntervalSince1970]*1000;
        NSString *fileName = [NSString stringWithFormat:@"%lli.jpg",[@(floor(timeInterval)) longLongValue]];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachesDir = [paths objectAtIndex:0];
        NSString *cachePath=[cachesDir stringByAppendingPathComponent:@"ImageCache"];
       BOOL isCategory= [[NSFileManager defaultManager] fileExistsAtPath:cachePath];
        if (!isCategory) {
            [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString  *filePath=[cachePath stringByAppendingPathComponent:fileName];
        BOOL isExist=[fileMgr fileExistsAtPath:filePath];
        if (!isExist) {
            BOOL isSuccess=[imgData writeToFile:filePath atomically:YES];
            if (isSuccess) {
                return filePath;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}
-(UIImage *)compressionImage:(UIImage *)img ToSize:(CGSize)itemSize{
    if (img.size.width<itemSize.width&&img.size.height<itemSize.height) {
        return img;
    }else{
        if ((img.size.width/img.size.height)>(itemSize.width/itemSize.height)) {
            itemSize.height=(itemSize.width*img.size.height)/img.size.width;
        }else{
            itemSize.width=(itemSize.height*img.size.width)/img.size.height;
        }
        UIImage *i;
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect=CGRectMake(0, 0, itemSize.width, itemSize.height);
        [img drawInRect:imageRect];
        i=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return i;
    }
}
@end
