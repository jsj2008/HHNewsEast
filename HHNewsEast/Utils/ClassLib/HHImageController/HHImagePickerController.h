//
//  HHImagePickerController.h
//  SeaMallSell
//
//  Created by d gl on 14-3-24.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "BaseViewController.h"
#import "HHUploadImageType.h"
#import "HHImageModel.h"
@class HHImagePickerController;
@class HHResponseResult;
@protocol HHImagePickerControlelrDelegate <NSObject>
@optional
/**
 *  将要上传
 *
 *  @param imgPath 本地图片的路径
 *  @param imgMark imagemark
 */
- (void)hhImagePickerControllerWillUpaloadImageWithLocalPath:(NSString *)imgPath imageMark:(HHUploadImageMark)imgMark;

/**
 *  完成上传
 *
 *  @param imgPath      本地图片路径
 *  @param imgMark      imagemark
 *  @param responseData 返回的图片的路径
 */
- (void)hhImagePickerControllerDidFinisUpaloadImageWithLocalPath:(NSString *)imgPath imageMark:(HHUploadImageMark)imgMark responseData:(id )responseData;

/**
 *  上传失败
 *
 *  @param imgPath imgPath
 *  @param imgMark 
 */
- (void)hhImagePickerControllerFailedToUploadImageWithWithLocalPath:(NSString *)imgPath imgMark:(HHUploadImageMark)imgMark;
- (void)hhImagePickerControllerDidCancelWithMark:(HHUploadImageMark)imgMark;
@end

@interface HHImagePickerController : NSObject
@property(nonatomic,assign)HHUploadImageMark imgMark;//上传图片的类型
@property(nonatomic,strong)UIImagePickerController *imagePickerController;
@property(nonatomic,weak)UIViewController *parentController;
@property(nonatomic,weak)id<HHImagePickerControlelrDelegate>delegate;
-(id)initWithParentControler:(id)controller delegate:(id)delegate;

-(void)takePhotoByCameraWithImageMark:(HHUploadImageMark)img_mark;
-(void)getPitureFromPhotoLibaryWithImageMark:(HHUploadImageMark)img_mark;
-(void)hhImagePickerControllerPickImageWithImageMark:(HHUploadImageMark)img_mark;
@end
