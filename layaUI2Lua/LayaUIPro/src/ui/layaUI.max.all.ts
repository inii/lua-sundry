
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
    export class Act12116GiftCellUI extends View {
		public img_bg:Laya.Image;
		public img_titleBg:Laya.Image;
		public btn_pick:Laya.Image;
		public lab_btnTxt:Laya.Label;
		public rich_Title:laya.html.dom.HTMLDivElement;
		public lab_2:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        			View.regComponent("HTMLDivElement",laya.html.dom.HTMLDivElement);

            super.createChildren();
            this.loadUI("activityModule/Act12116GiftCell");

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
    export class AutoTestModuleUI extends View {
		public btnClose:Laya.Image;
		public lsv:Laya.List;
		public topPanel:Laya.Panel;
		public title:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
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
