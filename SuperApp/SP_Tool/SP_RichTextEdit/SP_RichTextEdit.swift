//
//  SP_HtmlEdit.swift
//  Fortuna
//
//  Created by LCD on 2017/8/22.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit
import YYText
import RxCocoa
import RxSwift
import YYImage
import YYWebImage
import SwiftyJSON
class SP_RichTextEdit: SP_ParentVC {

    let disposeBag = DisposeBag()
    var _vcType = SP_RichTextEditType.t短评
    var _blog_id = ""//短评ID
    var _parent_blog_Title = ""
    var _placeholderText = ""
    var _vcBlock:(()->Void)?
    //MARK:--- 工具栏 ----------
    var toolBarConfi  = SP_RichTextEdit_ToolBarConfi()
    
    lazy var toolBar:SP_RichTextEditToolBar =  {
        let view = SP_RichTextEditToolBar.show()
        view.frame.size.height = 40
        view.view_Line.backgroundColor = UIColor.main_line
        return view
    }()
    //MARK:--- 编辑栏 ----------
    lazy var textViewTitle:YYTextView = {
        let text = YYTextView(frame: CGRect(x: 0, y: 64, width: sp_ScreenWidth, height: 70))
        text.textContainerInset = UIEdgeInsetsMake(0, 10, 0, 10)
        text.allowsCopyAttributedString = true;
        text.allowsPasteAttributedString = true;
        text.placeholderText = sp_localized("标题(最多30字)")
        text.delegate = self
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.placeholderFont = UIFont.boldSystemFont(ofSize: 20)
        text.showsVerticalScrollIndicator = false
        text.showsHorizontalScrollIndicator = false
        text.bounces = false
        return text
    }()
    
    lazy var textView:YYTextView = {
        let text = YYTextView()
        text.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
        text.allowsCopyAttributedString = true;
        text.allowsPasteAttributedString = true;
        text.placeholderText = self._placeholderText
        text.font = UIFont.systemFont(ofSize: 18)
        text.placeholderFont = UIFont.systemFont(ofSize: 18)
        text.inputAccessoryView = self.toolBar
        text.allowsCopyAttributedString = false
        text.delegate = self
        return text
    }()
    
    var dataTexts:[M_SP_RichText] = [] {
        didSet{
            
        }
    }
    
    var locationStr:NSMutableAttributedString = NSMutableAttributedString()
    var isDelete = false //是否是回删
    var newRange:NSRange?
    var newstr = ""    //记录最新内容的字符串
}


extension SP_RichTextEdit {
    override class func initSPVC() -> SP_RichTextEdit {
        return UIStoryboard(name: "SP_RichTextEditStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SP_RichTextEdit") as! SP_RichTextEdit
    }
    class func show(_ pVC:UIViewController?, type:SP_RichTextEditType = .t短评, blog_id:String = "", parent_blog_Title:String = "", placeholderText:String = sp_localized("正文"), block:(()->Void)? = nil) {
        let vc = SP_RichTextEdit.initSPVC()
        vc._vcType = type
        vc._placeholderText = placeholderText
        vc._blog_id = blog_id
        vc._vcBlock = block
        vc._parent_blog_Title = parent_blog_Title
        vc.hidesBottomBarWhenPushed = true
        pVC?.navigationController?.show(vc, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeNavigation()
        self.makeToolBar()
        self.makeYYtextView()
        
        //testText()
    }
    fileprivate func makeNavigation() {
        self.n_view._title = sp_localized(_vcType.rawValue)
        self.n_view.n_btn_R1_Text = "发布"
        self.fd_interactivePopDisabled = true
    }
    override func clickN_btn_R1() {
        self.textViewTitle.resignFirstResponder()
        self.textView.resignFirstResponder()
        
        if _vcType == .t长文 && self.textViewTitle.text.isEmpty {
            SP_HUD.showMsg(sp_localized("请输入标题(最多30字)"))
            return
        }
        var title = ""
        if _vcType == .t长文 {
            title = self.textViewTitle.text
        }
        if _vcType == .t转发 {
            title = "【转】" + _parent_blog_Title
        }
        SP_HUD.show(view: self.view, type: .tLoading, text: sp_localized("正在发布"))
        self.n_view.n_btn_R1.isEnabled = false
        
        let attributedJSON = self.attributedTextToJSON()
        /*
        switch _vcType {
        case .t评论:
            My_API.t_发表短评评论接口(content: attributedJSON.content, blog_id: self._blog_id).post(M_MyCommon.self) { [weak self](isOk, data, error) in
                SP_HUD.hidden()
                self?.n_view.n_btn_R1.isEnabled = true
                if isOk {
                    self?._vcBlock?()
                    SP_HUD.showMsg(sp_localized("已发表"))
                    _ = self?.navigationController?.popViewController(animated: true)
                }else{
                    SP_HUD.showMsg(error)
                }
            }
        case .t短评,.t长文, .t转发:
            My_API.t_发表短评接口(content: attributedJSON.content, title: title, bastract: attributedJSON.bastract, first_img: attributedJSON.first_img, friends: attributedJSON.friends, wines: attributedJSON.wines,parent_blog_id:self._blog_id).post(M_MyCommon.self) { [weak self](isOk, data, error) in
                SP_HUD.hidden()
                self?.n_view.n_btn_R1.isEnabled = true
                if isOk {
                    self?._vcBlock?()
                    SP_HUD.showMsg(sp_localized("已发布"))
                    _ = self?.navigationController?.popViewController(animated: true)
                }else{
                    SP_HUD.showMsg(error)
                }
            }
        
        }
        */
    }
    
    func attributedTextToJSON() -> (content:String,bastract:String,first_img:String,friends:String,wines:String) {
        var strContent = ""
        var strBastract = ""
        var strBastractIndex = 0
        var first_img = ""
        var friends = ""
        var wines = ""
        
        var effectiveRange:NSRange = NSMakeRange(0, 0)
        let attributedString:NSAttributedString = self.textView.attributedText!
        while (effectiveRange.location + effectiveRange.length < attributedString.length) {
            
            let attributes = attributedString.attributes(at: effectiveRange.location, effectiveRange: &effectiveRange)
            
            let text:String = (attributedString.string as NSString).substring(with: effectiveRange)
            
            let attachment:YYTextAttachment? = attributes["YYTextAttachment"] as? YYTextAttachment
            let binding:YYTextBinding? = attributes["YYTextBinding"] as? YYTextBinding
            if (attachment != nil) {
                let imageUrl:String = attributes["NSLanguage"] as? String ?? ""
                var ww:CGFloat = sp_ScreenWidth - 20
                var hh:CGFloat = sp_ScreenWidth - 20
                if let con = attachment?.content as? UIImageView {
                    ww = con.frame.size.width
                    hh = con.frame.size.height
                }
                /*
                let dict = ["type":M_SP_RichTextType.t图片.rawValue,
                            "text":"",
                            "fontPt":String(format:"%.0f",18),
                            "fontPx":String(format:"%.0f",18*2),
                            "isBold":"0",
                            "code":"",
                            "link":"",
                            "imgUrl":imageUrl,
                            "imgWidth":String(format:"%.2f",ww),
                            "imgHeight":String(format:"%.2f",hh)
                            ]
                arrContent.append(dict)*/
                let str = ("type:" + M_SP_RichTextType.t图片.rawValue + "<*|属性:参数|*>")
//                    + ("text:" + "" + "<*|属性:参数|*>")
                    + ("fontPt:" + String(format:"%.0f",18) + "<*|属性:参数|*>")
                    + ("fontPx:" + String(format:"%.0f",18*2) + "<*|属性:参数|*>")
                    + ("isBold:" + "0" + "<*|属性:参数|*>")
//                    + ("code:" + "" + "<*|属性:参数|*>")
//                    + ("link:" + "" + "<*|属性:参数|*>")
                    + ("imgUrl:" + imageUrl + "<*|属性:参数|*>")
                    + ("imgWidth:" + String(format:"%.2f",ww) + "<*|属性:参数|*>")
                    + ("imgHeight:" + String(format:"%.2f",hh) + "<*|属性:参数|*>")
                
                
                strContent += (str + "<*|换行:字符串|*>")
                first_img = first_img.isEmpty ? imageUrl : first_img
            }
            else if binding != nil {
                if text.hasPrefix(M_SP_RichTextType.t关注.prefixValue) {
                    let code:String = attributes["NSLanguage"] as? String ?? ""
                    
                    let str = ("type:" + M_SP_RichTextType.t关注.rawValue + "<*|属性:参数|*>")
                        + ("text:" + text + "<*|属性:参数|*>")
                        + ("fontPt:" + String(format:"%.0f",18.0) + "<*|属性:参数|*>")
                        + ("fontPx:" + String(format:"%.0f",18.0*2) + "<*|属性:参数|*>")
                        + ("isBold:" + "0" + "<*|属性:参数|*>")
                        + ("code:" + code + "<*|属性:参数|*>")

                    strContent += (str + "<*|换行:字符串|*>")
                    if strBastractIndex <= 10 {
                        strBastract += (str + "<*|换行:字符串|*>")
                        strBastractIndex += 1
                    }
                    friends += friends.isEmpty ? code : ("|"+code)
                }else if text.hasPrefix(M_SP_RichTextType.t自选酒.prefixValue) {
                    let code:String = attributes["NSLanguage"] as? String ?? ""
                    
                    let str = ("type:" + M_SP_RichTextType.t自选酒.rawValue + "<*|属性:参数|*>")
                        + ("text:" + text + "<*|属性:参数|*>")
                        + ("fontPt:" + String(format:"%.0f",18.0) + "<*|属性:参数|*>")
                        + ("fontPx:" + String(format:"%.0f",18.0*2) + "<*|属性:参数|*>")
                        + ("isBold:" + "0" + "<*|属性:参数|*>")
                        + ("code:" + code + "<*|属性:参数|*>")

                    strContent += (str + "<*|换行:字符串|*>")
                    if strBastractIndex <= 10 {
                        strBastract += (str + "<*|换行:字符串|*>")
                        strBastractIndex += 1
                    }
                    wines += wines.isEmpty ? code : ("|"+code)
                }else if text.hasPrefix(M_SP_RichTextType.t超链接.prefixValue) {
                    let code:String = attributes["NSLanguage"] as? String ?? ""
                    
                    let str = ("type:" + M_SP_RichTextType.t超链接.rawValue + "<*|属性:参数|*>")
                        + ("text:" + text + "<*|属性:参数|*>")
                        + ("fontPt:" + String(format:"%.0f",18.0) + "<*|属性:参数|*>")
                        + ("fontPx:" + String(format:"%.0f",18.0*2) + "<*|属性:参数|*>")
                        + ("isBold:" + "0" + "<*|属性:参数|*>")
                        + ("link:" + code + "<*|属性:参数|*>")
                    
                    strContent += (str + "<*|换行:字符串|*>")
                    if strBastractIndex <= 10 {
                        strBastract += (str + "<*|换行:字符串|*>")
                        strBastractIndex += 1
                    }
                }else{
                    
                }
                
            }else{
                let font:UIFont = attributes[NSFontAttributeName] as? UIFont ?? UIFont.systemFont(ofSize: 18)
                let isBold = font.description.contains("font-weight: bold")
                let fontSize:CGFloat = CGFloat(font.fontDescriptor.fontAttributes["NSFontSizeAttribute"] as? Float ?? 18.0)
                
                let str = ("type:" + M_SP_RichTextType.t文字.rawValue + "<*|属性:参数|*>")
                    + ("text:" + text + "<*|属性:参数|*>")
                    + ("fontPt:" + String(format:"%.0f",fontSize) + "<*|属性:参数|*>")
                    + ("fontPx:" + String(format:"%.0f",fontSize*2) + "<*|属性:参数|*>")
                    + ("isBold:" + (isBold ? "1" : "0") + "<*|属性:参数|*>")

                strContent += (str + "<*|换行:字符串|*>")
                if strBastractIndex <= 10 {
                    strBastract += (str + "<*|换行:字符串|*>")
                    strBastractIndex += 1
                }
                
            }
            
            effectiveRange = NSMakeRange(effectiveRange.location + effectiveRange.length, 0);
        }
        
        
        
        var strBastract2 = ""
        for item in strBastract.characters {
            if item != "\n" {
                strBastract2.append(item)
            }
        }
        
        let contentUTF8:String = strContent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? strContent
        let bastractUTF8:String = strBastract2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? strBastract2
        
        //print_SP(contentJson)
        return (contentUTF8,bastractUTF8,first_img,friends,wines)
    }
    
    
    override func clickN_btn_L1() {
        if self.textView.attributedText?.length == 0 {
            _ = self.navigationController?.popViewController(animated: true)
        }else {
            UIAlertController.showAler(self, btnText: [sp_localized("取消"),sp_localized("退出")], title: sp_localized("退出编辑?"), message: "") { [weak self](str) in
                switch str {
                case sp_localized("保存草稿"):
                    break
                case sp_localized("取消"):
                    break
                case sp_localized("退出"):
                    _ = self?.navigationController?.popViewController(animated: true)
                default:break
                }
            }
        }
    }
    
}
extension SP_RichTextEdit {
    fileprivate func makeYYtextView() {
        
        switch _vcType {
        case .t长文:
            self.view.addSubview(textViewTitle)
            self.view.addSubview(textView)
            //下划线
            let lineView = UIView(frame: CGRect(x: 10, y: textViewTitle.frame.maxY+5, width: sp_ScreenWidth-20, height: 0.7))
            self.view.addSubview(lineView)
            lineView.backgroundColor = UIColor.main_line
            textView.frame = CGRect(x: 0, y: lineView.frame.maxY+5, width: sp_ScreenWidth, height: sp_ScreenHeight-lineView.frame.maxY-5)
        case .t短评,.t评论,.t转发:
            self.view.addSubview(textViewTitle)
            self.view.addSubview(textView)
            textViewTitle.frame = CGRect(x: 0, y: -10, width: sp_ScreenWidth, height: 70)
            //下划线
            let lineView = UIView(frame: CGRect(x: 10, y: textViewTitle.frame.maxY+5, width: sp_ScreenWidth-20, height: 0.7))
            self.view.addSubview(lineView)
            lineView.backgroundColor = UIColor.clear
            textView.frame = CGRect(x: 0, y: lineView.frame.maxY+5, width: sp_ScreenWidth, height: sp_ScreenHeight-lineView.frame.maxY-5)
            if _vcType == .t评论 || _vcType == .t转发 {
                self.toolBar.tool_A.isHidden = true
                self.toolBar.tool_B.isHidden = true
                self.toolBar.tool_Link.isHidden = true
                self.toolBar.tool_Img.isHidden = true
            }
            
        }
        
    }
    func dataTextsAppendItem() {
        
    }
    
    
    
    
}

extension SP_RichTextEdit:YYTextViewDelegate {
    
    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        switch textView{
        case textViewTitle:
            if (range.location >= 30 || range.location + text.characters.count > 30) {
                return false
            }else{
                return true
            }
        case textView:
            //self.newstr = text
            //print_SP("self.newstr => \(text)")
            //print_SP("range.location => \(range.location)")
            //print_SP("range.length => \(range.length)")
            
            //self.newRange = NSMakeRange(range.location, text.characters.count);
            return true
        default:
            return true
        }
        
        
    }
    
    func textViewDidChange(_ textView: YYTextView) {
        guard textView == self.textView else {
            return
        }
        let len = textView.attributedText!.length - self.locationStr.length
        
        if len > 0 {
            self.isDelete = false
            self.newRange = NSMakeRange(self.textView.selectedRange.location - len, len);
            if self.newRange == nil {
                return
            }
            let strrr:NSString = textView.text as NSString
            self.newstr = strrr.substring(with: self.newRange!)
        }else{
            self.isDelete = true
        }
        
        self.locationStr = NSMutableAttributedString(attributedString: self.textView.attributedText!)
        
        if self.isDelete {
            return
        }
        
        var attributes:[String:Any] = [:]
        if toolBarConfi.isBold {
            attributes = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: toolBarConfi.fontSize)]
            
        }
        else
        {
            attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: toolBarConfi.fontSize)]
            
        }
        
        let replaceStr = NSAttributedString(string: self.newstr, attributes: attributes)
        
        self.locationStr.replaceCharacters(in: self.newRange!, with: replaceStr)
        
        self.textView.attributedText = self.locationStr
        //这里需要把光标的位置重新设定
        self.textView.selectedRange = NSMakeRange(self.newRange!.location+self.newRange!.length, 0)
        
    }
    
    /*var attributes:[String:Any] = [:]
     if toolBarConfi.isBold {
     attributes = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: toolBarConfi.fontSize)]
     
     }
     else
     {
     attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: toolBarConfi.fontSize)]
     
     }
     
     let replaceStr = NSAttributedString(string: self.newstr, attributes: attributes)
     //self.newRange?.length = len
     self.newRange = NSMakeRange(self.textView.selectedRange.location - self.newstr.characters.count, len);
     print_SP("self.newRange.location => \(self.newRange?.location)")
     print_SP("self.newRange.length => \(self.newRange?.length)")
     self.locationStr.replaceCharacters(in: self.newRange!, with: replaceStr)
     
     self.textView.attributedText = self.locationStr
     //这里需要把光标的位置重新设定
     self.textView.selectedRange = NSMakeRange(self.newRange!.location+self.newRange!.length, 0)
     */
    
    func textViewDidChangeSelection(_ textView: YYTextView) {
        textView.scrollRangeToVisible(textView.selectedRange)
        
    }
    
    func textView(_ textView: YYTextView, didTap highlight: YYTextHighlight, in characterRange: NSRange, rect: CGRect) {
        
    }
    func textView(_ textView: YYTextView, didLongPress highlight: YYTextHighlight, in characterRange: NSRange, rect: CGRect) {
        
    }
    
}
//MARK:--- 禁止弹出 选择 复制 ----------
extension YYTextView {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        UIMenuController.shared.isMenuVisible = false
        return false
    }
}
