//
//  ActionSheetView.swift
//  ActionSheet
//

let CELL_HEIGHT:CGFloat = 50;
let CELL_SPACE :CGFloat = 5;


import UIKit


protocol ActionSheetViewDelegate : NSObjectProtocol{
    func actionSheetAndClickButtonAtIndex(actionSheet:ActionSheetView,buttonIndex:NSInteger)
}

class ActionSheetView: UIView {

    
    var titleArray :Array<Any>?
    var btnView :UIView?
    var show :Bool = true
    var delegate:ActionSheetViewDelegate?
    
    lazy var btnBgView:UIView = {
        
        let btnBgView = UIView()
//        btnBgView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return btnBgView
    }()

}
extension ActionSheetView{

    func initWithTitleArrayAndShowCancel(titleArr:Array<Any>,show:Bool) {
        
        self.frame = UIScreen.main.bounds
        titleArray = titleArr;
        self.show = show
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(ActionSheetView.hiddenSheet))
        self.addGestureRecognizer(tap)
        
        setUpUI()
        
    }

}
extension ActionSheetView{
    
    func setUpUI() -> Void {
        
        let size = UIScreen.main.bounds.size
        var bgHeight: CGFloat = 0

        if show {
            
            bgHeight =  CELL_HEIGHT * CGFloat(titleArray!.count) + CELL_HEIGHT + CELL_SPACE
            
        }else{
            
            bgHeight  = CELL_HEIGHT * CGFloat(titleArray!.count);
            
        }
        
        self.btnBgView.frame = CGRect(x: 0, y: size.height, width: size.width, height: bgHeight)
        self.addSubview(self.btnBgView)
        
        let bgWidth = self.btnBgView.frame.size.width

        for i in 0..<Int((titleArray?.count)!) {
            let BtnX:CGFloat = 0;
            var BtnY:CGFloat = 0;

            if show {
                BtnY = (bgHeight - CELL_HEIGHT - CELL_SPACE  - CELL_HEIGHT*CGFloat(i+1));
            }else{
                BtnY = bgHeight - CELL_HEIGHT*CGFloat(i+1);
            }
            
            let btnW = bgWidth;
            let btnH = CELL_HEIGHT - 0.5;
            let btn = UIButton(type: UIButtonType.custom)
            btn.setTitle(titleArray?[i] as! String?, for: .normal)
            btn.backgroundColor = UIColor.white
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.frame = CGRect(x: BtnX, y: BtnY, width: btnW, height: CGFloat(btnH))
            btn.tag = i + 1
            btn.addTarget(self,action:#selector(buttonAtion(_:)),for:.touchUpInside)
            self.btnBgView.addSubview(btn)
        }
        
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.white
        btn.addTarget(self, action: #selector(ActionSheetView.hiddenSheet), for: .touchUpInside)
        btn.tag = 0;
        btn.frame = CGRect(x: CGFloat(0), y: bgHeight - CGFloat(CELL_HEIGHT), width: bgWidth, height: CGFloat(CELL_HEIGHT))
        self.btnBgView.addSubview(btn)
        btn.isHidden = !show
        UIView.animate(withDuration: 0.3) {
            var frame = self.btnBgView.frame;
            frame.origin.y =  size.height - frame.size.height;
            self.btnBgView.frame = frame;
        }
        
    }
    
}

extension ActionSheetView{

    func buttonAtion(_ sender:UIButton){
        if (delegate != nil) {
            delegate?.actionSheetAndClickButtonAtIndex(actionSheet:self, buttonIndex:sender.tag )
        }
        hiddenSheet()
    }
}

extension ActionSheetView{
    func hiddenSheet() -> Void {
        UIView.animate(withDuration: 0.3, animations: {
            var frame = self.btnBgView.frame;
            frame.origin.y = UIScreen.main.bounds.size.height;
            self.btnBgView.frame = frame;

        }) { (Bool) in
            self.removeFromSuperview()
        }
        
    }

}

