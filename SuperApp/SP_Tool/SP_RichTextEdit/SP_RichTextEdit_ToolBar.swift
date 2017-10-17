//
//  SP_RichTextEdit_ToolBar.swift
//  Fortuna
//
//  Created by LCD on 2017/8/28.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import Foundation
import YCXMenu
import RxCocoa
import RxSwift
import YYText
import YYImage
import YYWebImage
struct SP_RichTextEdit_ToolBarConfi {
    var lineSpacing:CGFloat = 10
    var isBold = false
    var isH:Bool = false {
        didSet{
            fontSize = isH ? 22 : 18
        }
    }
    var fontSize:CGFloat = 18
    var font:UIFont = UIFont.systemFont(ofSize: 18)
    var attributes:[String:Any] = [:]
}

extension SP_RichTextEdit {
    
    func makeToolBar() {
        
        toolBar.tool_B.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self](isOK) in
                self?.toolBarConfi.isBold = !self!.toolBarConfi.isBold
                self?.toolBar.tool_B.titleLabel?.font = self!.toolBarConfi.isBold ? UIFont.boldSystemFont(ofSize: 22) : UIFont.systemFont(ofSize: 18)
                
                if self!.toolBarConfi.isBold {
                    self?.toolBarConfi.attributes = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: self!.toolBarConfi.fontSize)]
                    self?.toolBarConfi.font = UIFont.boldSystemFont(ofSize: self!.toolBarConfi.fontSize)
                }
                else
                {
                    self?.toolBarConfi.attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: self!.toolBarConfi.fontSize)]
                    self?.toolBarConfi.font = UIFont.systemFont(ofSize: self!.toolBarConfi.fontSize)
                }
                self?.dataTextsAppendItem()
            }).addDisposableTo(disposeBag)
        
        //副标题作用域是整段落，是加粗
        toolBar.tool_A.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self](isOK) in
                self?.toolBarConfi.isH = !self!.toolBarConfi.isH
                self?.toolBar.tool_A.titleLabel?.font = UIFont.systemFont(ofSize: self!.toolBarConfi.fontSize)
                if self!.toolBarConfi.isBold {
                    self?.toolBarConfi.attributes = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: self!.toolBarConfi.fontSize)]
                    self?.toolBarConfi.font = UIFont.boldSystemFont(ofSize: self!.toolBarConfi.fontSize)
                }
                else
                {
                    self?.toolBarConfi.attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: self!.toolBarConfi.fontSize)]
                    self?.toolBarConfi.font = UIFont.systemFont(ofSize: self!.toolBarConfi.fontSize)
                }
                self?.dataTextsAppendItem()
            }).addDisposableTo(disposeBag)
        
        toolBar.tool_Img.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self](isOK) in
                self?.selectPhoto()
            }).addDisposableTo(disposeBag)
        
        toolBar.tool_Friend.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self](isOK) in
                self?.selectFriend()
            }).addDisposableTo(disposeBag)
        
        toolBar.tool_Wine.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self](isOK) in
                self?.selectWine()
            }).addDisposableTo(disposeBag)
        
        toolBar.tool_Link.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self](isOK) in
                self?.selectLink()
            }).addDisposableTo(disposeBag)
    }
    
    func selectFriend() {
        self.textView.resignFirstResponder()
        My_SearchFriendsVC.show(self, block:{ [weak self](model) in
            self?.addFriend(model)
        })
    }
    func addFriend(_ mo:M_Friends) {
        let tagText = NSMutableAttributedString(string: mo.name)
        tagText.yy_insertString(M_SP_RichTextType.t关注.prefixValue, at: 0)
        tagText.yy_appendString(M_SP_RichTextType.t关注.suffixValue)
        tagText.yy_font = UIFont.systemFont(ofSize: 18)
        tagText.yy_color = UIColor.main_btnNormal
        tagText.yy_paragraphSpacingBefore = self.toolBarConfi.lineSpacing
        tagText.yy_paragraphSpacing = self.toolBarConfi.lineSpacing
        tagText.yy_setTextBinding(YYTextBinding(deleteConfirm: true), range: tagText.yy_rangeOfAll())
        
        tagText.yy_language = mo.id
        
        
        self.locationStr.insert(tagText, at: self.textView.selectedRange.location)
        
        self.textView.attributedText = self.locationStr
        
//        //添加到 dataTexts
//        var model = M_SP_RichText()
//        model.type = []
//        model.text = " @" + mo.name + " "
//        dataTexts.append(model)
    }
    
    func selectWine() {
        self.textView.resignFirstResponder()
        My_SearchWineVC.show(self, block:{ [weak self](model) in
            self?.addWine(model)
            
        })
    }
    func addWine(_ mo:M_Attention) {
        let tagText = NSMutableAttributedString(string: mo.name)
        tagText.yy_insertString(M_SP_RichTextType.t自选酒.prefixValue, at: 0)
        tagText.yy_appendString(M_SP_RichTextType.t自选酒.suffixValue)
        tagText.yy_font = UIFont.systemFont(ofSize: 18)
        tagText.yy_color = UIColor.main_btnNormal
        tagText.yy_paragraphSpacingBefore = self.toolBarConfi.lineSpacing
        tagText.yy_paragraphSpacing = self.toolBarConfi.lineSpacing
        tagText.yy_setTextBinding(YYTextBinding(deleteConfirm: true), range: tagText.yy_rangeOfAll())
        
        tagText.yy_language = mo.code
        
        
        self.locationStr.insert(tagText, at: self.textView.selectedRange.location)
        
        self.textView.attributedText = self.locationStr
        

        
        //添加到 dataTexts
//        var model = M_SP_RichText()
//        model.type = 3
//        model.text = " #" + mo.name + " "
//        dataTexts.append(model)
    }
    func selectLink() {
        self.textView.resignFirstResponder()
        self.textViewTitle.resignFirstResponder()
        SP_RichTextEditAddLinkView.show({ [weak self](link,title) in
            self?.addLink(link,title)
        })
    }
    func addLink(_ link:String,_ title:String) {
        let tagText = NSMutableAttributedString(string: title)
        tagText.yy_insertString(M_SP_RichTextType.t超链接.prefixValue, at: 0)
        tagText.yy_appendString(M_SP_RichTextType.t超链接.suffixValue)
        tagText.yy_font = UIFont.systemFont(ofSize: 18)
        tagText.yy_color = UIColor.main_btnNormal
        tagText.yy_paragraphSpacingBefore = self.toolBarConfi.lineSpacing
        tagText.yy_paragraphSpacing = self.toolBarConfi.lineSpacing
        tagText.yy_setTextBinding(YYTextBinding(deleteConfirm: true), range: tagText.yy_rangeOfAll())
        
        tagText.yy_language = link
        
        
        self.locationStr.insert(tagText, at: self.textView.selectedRange.location)
        
        self.textView.attributedText = self.locationStr
        
        //添加到 dataTexts
//        var model = M_SP_RichText()
//        model.type = 4
//        model.text = " " + title + " "
//        dataTexts.append(model)
    }
    
    func selectPhoto() {
        self.textView.resignFirstResponder()
        let man = HXPhotoManager(type: HXPhotoManagerSelectedTypePhoto)
        man?.photoMaxNum = 1
        man?.selectTogether = false
        
        let vc = HXPhotoViewController()
        
        vc.delegate = self
        
        man?.emptySelectedList()
        vc.manager = man
        let nVC = UINavigationController(rootViewController: vc)
        UIApplication.shared.statusBarStyle = .default
        self.present(nVC, animated: true, completion: nil)
    }
}

extension SP_RichTextEdit:HXPhotoViewControllerDelegate {
    func photoViewControllerDidCancel() {
        print_SP("===================== 取消了 ==================")
    }
    func photoViewControllerDidNext(_ allList: [HXPhotoModel]!, photos: [HXPhotoModel]!, videos: [HXPhotoModel]!, original: Bool) {
        
        if photos.count > 0 {
            self.uploadImagesAtIndex(photos)
        }
        
    }
    
    func uploadImagesAtIndex(_ photos:[HXPhotoModel]) {
        for item in photos {
            switch item.type {
            case HXPhotoModelMediaTypePhoto:
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                options.deliveryMode = .highQualityFormat
                options.resizeMode = .exact
                PHImageManager.default().requestImage(for: item.asset, targetSize: CGSize(width: item.asset.pixelWidth, height: item.asset.pixelHeight), contentMode: .aspectFit, options: options, resultHandler: { [weak self](image, dact) in
                    guard self != nil else{return}
                    self?.uploadImage(SP_ImageUnit.toJpgData(image!, isZip: true), index:0, fileUrl:"")
                })
            case HXPhotoModelMediaTypeCameraPhoto:
                
                self.uploadImage(SP_ImageUnit.toJpgData(item.thumbPhoto, isZip: true), index:0, fileUrl:"")
                
            default:
                break
            }
        }
    }
    //MARK:--- 上传图片
    func uploadImage(_ data:Data, index:Int, fileUrl:String) {
        //转化图片模型
        var p = SP_UploadParam()
        p.fileData = data //as? Data ?? Data()
        p.filename =  Date.sp_Date("yyyyMMddHHmmssSSS") + ".jpg"
        p.serverName = "file"
        p.mimeType = "image/jpg"
        p.type = .tData
        
        let fileStr = String(format: "%.0f", Date().timeIntervalSince1970*1000) + ".jpg"
        let path:String = FCFileManager.pathForDocumentsDirectory(withPath: fileStr)
        FCFileManager.writeFile(atPath: fileStr, content: data as NSObject! )
        
        //添加图片
        let image = YYImage(data: data)
        image?.preloadAllAnimatedImageFrames = true
        let imageView = YYAnimatedImageView(image: image)
        imageView.clipsToBounds = true
        
        let size = CGSize(width:sp_ScreenWidth-20, height:image!.size.height/(image!.size.width/(sp_ScreenWidth-20)))
        imageView.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let attachText = NSMutableAttributedString.yy_attachmentString(withContent: imageView, contentMode: .scaleAspectFill, attachmentSize: size, alignTo: self.toolBarConfi.font, alignment: YYTextVerticalAlignment.center)
        attachText.yy_font = self.toolBarConfi.font
        attachText.yy_language = path
        
        //添加进度条
        let bgView = UIView()
        imageView.addSubview(bgView)
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let progressView = UIProgressView()
        bgView.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        let lab = UILabel()
        bgView.addSubview(lab)
        lab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressView.snp.bottom).offset(5)
        }
        lab.textColor = UIColor.white
        lab.text = sp_localized("上传中...")
        lab.font = UIFont.systemFont(ofSize: 12)
        
        let highlight = YYTextHighlight()
        highlight.tapAction = { [weak self](containerView,text,range,rect) in
            if lab.text == sp_localized("上传失败，点我重试") {
                self?.uploadImage(p,index,progressView,bgView,lab,path,attachText)
            }
        }
        attachText.yy_setTextHighlight(highlight, range: attachText.yy_rangeOfAll())
        attachText.yy_paragraphSpacingBefore = self.toolBarConfi.lineSpacing
        attachText.yy_paragraphSpacing = self.toolBarConfi.lineSpacing
        self.locationStr.insert(attachText, at: self.textView.selectedRange.location)
        //print_SP(self.textView.selectedRange.location)
        self.textView.attributedText = self.locationStr
        
        self.uploadImage(p,index,progressView,bgView,lab,path,attachText)
        
    }
    
    func uploadImage(_ uploadParams:SP_UploadParam, _ index:Int, _ progressView:UIProgressView, _ bgView:UIView, _ lab:UILabel, _ path:String, _ attachText:NSMutableAttributedString) {
        
        SP_SVHUD.dismiss()
        My_API.t_媒体文件上传(uploadParams: [uploadParams]).upload(M_MyCommon.self, block: { [weak self](isOk, data, error) in
            if isOk {
                guard self != nil else{return}
                guard let datas = data as? M_MyCommon else{return}
                
                var effectiveRange:NSRange = NSMakeRange(0, 0)
                let attributedString:NSAttributedString = self!.textView.attributedText!
                while (effectiveRange.location + effectiveRange.length < attributedString.length) {
                    
                    let attributes = attributedString.attributes(at: effectiveRange.location, effectiveRange: &effectiveRange)
                    let attachment:YYTextAttachment? = attributes["YYTextAttachment"] as? YYTextAttachment
                    
                    if (attachment != nil) {
                        let imageUrl:String = attributes["NSLanguage"] as? String ?? ""
                        if imageUrl == path {
                            attachText.yy_language = datas.media_url
                            attachText.insert(NSAttributedString(string: M_SP_RichTextType.t图片.prefixValue), at: 0)
                            attachText.append(NSAttributedString(string: M_SP_RichTextType.t图片.suffixValue))
                            
                            self?.locationStr.yy_removeAttributes(in: effectiveRange)
                            self?.locationStr.insert(attachText, at: effectiveRange.location)
                            self?.textView.attributedText = self!.locationStr
                            
                        }
                        
                    }
                    effectiveRange = NSMakeRange(effectiveRange.location + effectiveRange.length, 0);
                }
                
                bgView.removeFromSuperview()
            }else{
                lab.text = sp_localized("上传失败，点我重试")
            }
        }) { (progress) in
            let progre = Float(progress!.completedUnitCount)/Float(progress!.totalUnitCount)
            progressView.progress = progre
        }
    }

}
