
import View=laya.ui.View;
import Dialog=laya.ui.Dialog;
module ui.activity {
    export class UITemplateUI extends View {

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("activity/UITemplate");

        }

    }
}

module ui.activityModule {
    export class Act12555CellUI extends View {
		public imgEgg:Laya.Image;
		public imgTitleBgN:Laya.Image;
		public labName1:Laya.Label;
		public labName2:Laya.Label;
		public btnBuy:Laya.Image;
		public labBtn:Laya.Label;
		public richDailyLimit:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("activityModule/Act12555Cell");

        }

    }
}

module ui.activityModule {
    export class Act12555PanelUI extends View {
		public imgBgN:Laya.Image;
		public imgBanner:Laya.Image;
		public imgTimeBgN:Laya.Image;
		public labTitleN:Laya.Label;
		public richTime:Laya.Label;
		public imgBottom:Laya.Image;
		public richEggDescN:Laya.Label;
		public btnTips:Laya.Image;
		public imgTitleN:Laya.Image;
		public imgEggHoldN:Laya.Image;

        constructor(){ super()}
        createChildren():void {
        			View.regComponent("ui.activityModule.Act12555SignInCellUI",ui.activityModule.Act12555SignInCellUI);
			View.regComponent("ui.activityModule.Act12555CellUI",ui.activityModule.Act12555CellUI);

            super.createChildren();
            this.loadUI("activityModule/Act12555Panel");

        }

    }
}

module ui.activityModule {
    export class Act12555SignInCellUI extends View {
		public imgBg:Laya.Image;
		public labDay:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("activityModule/Act12555SignInCell");

        }

    }
}

module ui.activityModule {
    export class TestPanelUI extends View {
		public img_bg:Laya.Image;
		public img_title_bg:Laya.Image;
		public lab_title:Laya.Label;
		public btn_close:Laya.Image;
		public img_list_bg:Laya.Image;
		public lsv:Laya.List;
		public nodeCell:Act12116GiftCell;
		public rich_1:laya.html.dom.HTMLDivElement;

        constructor(){ super()}
        createChildren():void {
        			View.regComponent("Act12116GiftCell",Act12116GiftCell);
			View.regComponent("HTMLDivElement",laya.html.dom.HTMLDivElement);

            super.createChildren();
            this.loadUI("activityModule/TestPanel");

        }

    }
}

module ui.autoTestModule {
    export class AutoTestGiftCellUI extends View {
		public img_bg:Laya.Image;
		public img_titleBg:Laya.Image;
		public btn_pick:Laya.Image;
		public lab_btnTxt:Laya.Label;
		public rich_Title:laya.html.dom.HTMLDivElement;
		public labTitle:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        			View.regComponent("HTMLDivElement",laya.html.dom.HTMLDivElement);

            super.createChildren();
            this.loadUI("autoTestModule/AutoTestGiftCell");

        }

    }
}

module ui.autoTestModule {
    export class AutoTestModuleUI extends View {
		public imgBgN:Laya.Image;
		public imgTitleN:Laya.Image;
		public btnClose:Laya.Image;
		public imgLsvBgN:Laya.Image;
		public richTips:Laya.Label;
		public lsv:AutoTestGiftCell;
		public scv:Laya.Panel;
		public labTitle:Laya.Label;
		public btnPIck:Laya.Image;
		public labConfirm:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        			View.regComponent("AutoTestGiftCell",AutoTestGiftCell);
			View.regComponent("ui.autoTestModule.AutoTestGiftCellUI",ui.autoTestModule.AutoTestGiftCellUI);

            super.createChildren();
            this.loadUI("autoTestModule/AutoTestModule");

        }

    }
}

module ui.test {
    export class TestPageUI extends View {
		public btn:Laya.Button;
		public clip:Laya.Clip;
		public combobox:Laya.ComboBox;
		public tab:Laya.Tab;
		public list:Laya.List;
		public btn2:Laya.Button;
		public check:Laya.CheckBox;
		public radio:Laya.RadioGroup;
		public box:Laya.Box;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("test/TestPage");

        }

    }
}
