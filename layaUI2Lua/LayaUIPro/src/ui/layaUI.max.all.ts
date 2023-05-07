
import View=laya.ui.View;
import Dialog=laya.ui.Dialog;
module ui.activityModule {
    export class Act12555CellUI extends View {
		public imgEgg:Laya.Image;
		public imgTitleBg:Laya.Image;
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
    export class Act12559CellUI extends View {
		public imgBg:Laya.Image;
		public imgTitleBgN:Laya.Image;
		public btnBuy:Laya.Image;
		public labBtnBuy:Laya.Label;
		public labTitle:Laya.Label;
		public richTimes:Laya.Label;
		public labDiscount:Laya.Label;
		public labPercentN:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("activityModule/Act12559Cell");

        }

    }
}

module ui.activityModule {
    export class Act12559PanelUI extends View {
		public imgBg:Laya.Image;
		public imgBanner:Laya.Image;
		public imgTimeBgN:Laya.Image;
		public labTitleN:Laya.Label;
		public richTime:Laya.Label;
		public btnTips:Laya.Image;
		public imgBottom:Laya.Image;
		public lsv:Laya.List;
		public tab:Laya.Tab;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("activityModule/Act12559Panel");

        }

    }
}

module ui.activityModule {
    export class Act12601CellUI extends View {
		public imgLine:Laya.Image;
		public richName:Laya.Label;
		public imgBase1:Laya.Image;
		public imgBase2:Laya.Image;
		public imgAdv1:Laya.Image;
		public imgAdv2:Laya.Image;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("activityModule/Act12601Cell");

        }

    }
}

module ui.activityModule {
    export class Act12601PanelUI extends View {
		public imgBgN:Laya.Image;
		public imgBottomN:Laya.Image;
		public imgBg1N:Laya.Image;
		public labTaskN:Laya.Label;
		public imgBg2N:Laya.Image;
		public labBaseN:Laya.Label;
		public imgBg3N:Laya.Image;
		public labAdvN:Laya.Label;
		public lsv:Laya.List;
		public imgLineN:Laya.Image;
		public imgDescBgBgN:Laya.Image;
		public imgDescBgN:Laya.Image;
		public richDesc:Laya.Label;
		public imgTitleBGN:Laya.Image;
		public labTitle:Laya.Label;
		public labTitleDescN:Laya.Label;
		public imgBtnBgN:Laya.Image;
		public btnOneKey:Laya.Image;
		public labBtnOneKeyN:Laya.Label;
		public btnUnlock:Laya.Image;
		public labBtnUnlock:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        			View.regComponent("ui.activityModule.Act12601CellUI",ui.activityModule.Act12601CellUI);

            super.createChildren();
            this.loadUI("activityModule/Act12601Panel");

        }

    }
}

module ui.activityModule {
    export class Act12603DayCellUI extends View {
		public imgBg:Laya.Image;
		public imgSelected:Laya.Image;
		public labDay:Laya.Label;
		public imgLock:Laya.Image;
		public imgRed:Laya.Image;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("activityModule/Act12603DayCell");

        }

    }
}

module ui.activityModule {
    export class Act12603ProgressCellUI extends View {
		public imgArrow:Laya.Image;
		public imgItem:Laya.Image;
		public imgRed:Laya.Image;
		public labValue:Laya.Label;
		public imgPoint:Laya.Image;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("activityModule/Act12603ProgressCell");

        }

    }
}

module ui.activityModule {
    export class Act12603SevenDayModuleUI extends View {
		public imgBg:Laya.Image;
		public imgBanarBgN:Laya.Image;
		public imgBanarTxtN:Laya.Image;
		public imgTitleN:Laya.Image;
		public btnClose:Laya.Image;
		public labTitle:Laya.Label;
		public imgLsvBg:Laya.Image;
		public lsvTask:AutoTestGiftCell;
		public imgBarBg:Laya.Image;
		public imgBar:Laya.Image;
		public imgIcon:Laya.Image;
		public labScore:Laya.Label;
		public imgBox1:ui.activityModule.Act12603ProgressCellUI;
		public imgBox2:ui.activityModule.Act12603ProgressCellUI;
		public imgBox3:ui.activityModule.Act12603ProgressCellUI;
		public imgBox4:ui.activityModule.Act12603ProgressCellUI;
		public imgBox5:ui.activityModule.Act12603ProgressCellUI;
		public imgLightN:Laya.Image;
		public imgFinal:Laya.Image;
		public labFinal:Laya.Label;
		public tabTitle:Laya.Tab;
		public lsvDay:AutoTestGiftCell;
		public imgTimeBg:Laya.Image;
		public labTimeTitle:Laya.Label;
		public richTime:Laya.Label;
		public btnTips:Laya.Image;

        constructor(){ super()}
        createChildren():void {
        			View.regComponent("AutoTestGiftCell",AutoTestGiftCell);
			View.regComponent("ui.activityModule.Act12603ProgressCellUI",ui.activityModule.Act12603ProgressCellUI);

            super.createChildren();
            this.loadUI("activityModule/Act12603SevenDayModule");

        }

    }
}

module ui.activityModule {
    export class Act12603TaskCellUI extends View {
		public imgBg:Laya.Image;
		public imgTitleBg:Laya.Image;
		public richTitle:Laya.Label;
		public btnBuy:Laya.Image;
		public richBtnLab:Laya.Label;
		public imgRed:Laya.Image;
		public richOriginal:Laya.Label;
		public imgLine:Laya.Image;
		public labBuyed:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("activityModule/Act12603TaskCell");

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

module ui.shipModule {
    export class BattleShipIconCellUI extends View {
		public imgBg:Laya.Image;
		public imgShipIcon:Laya.Image;
		public imgSelected:Laya.Image;
		public labName:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("shipModule/BattleShipIconCell");

        }

    }
}

module ui.shipModule {
    export class BattleShipRemodelModuleUI extends View {
		public imgBgN:Laya.Image;
		public imgTitleN:Laya.Image;
		public btnCloseN:Laya.Image;
		public labTitleN:Laya.Label;
		public imgPartCurBg:Laya.Image;
		public imgIconBg1N:Laya.Image;
		public imgNameBg1N:Laya.Image;
		public labShipName1:Laya.Label;
		public imgTitleBg1N:Laya.Image;
		public labTitle1N:Laya.Label;
		public imgShipHoldCur:Laya.Image;
		public richPropCur:Laya.Label;
		public btnTips:Laya.Image;
		public btnRemodel:Laya.Image;
		public labBtnRemodel:Laya.Label;
		public imgSelectBg:Laya.Image;
		public imgTitleBg2N:Laya.Image;
		public labTitle2N:Laya.Label;
		public btnAddShip:Laya.Image;
		public imgPartTargetBg:Laya.Image;
		public imgTarTitleBgN:Laya.Image;
		public labTarTitleN:Laya.Label;
		public richPropTar:Laya.Label;
		public btnChange:Laya.Image;
		public labBtnChange:Laya.Label;
		public imgIconBg2N:Laya.Image;
		public imgNameBg2N:Laya.Image;
		public labShipName2:Laya.Label;
		public imgShipHoldTar:Laya.Image;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("shipModule/BattleShipRemodelModule");

        }

    }
}

module ui.shipModule {
    export class BattleShipRemodelSelectModuleUI extends View {
		public imgBgN:Laya.Image;
		public imgTitleN:Laya.Image;
		public btnCloseN:Laya.Image;
		public labTitleN:Laya.Label;
		public imgPart1Bg:Laya.Image;
		public imgTitleBg1N:Laya.Image;
		public labTitle1N:Laya.Label;
		public labNoTarget:Laya.Label;
		public imgIconBgN:Laya.Image;
		public imgNameBgN:Laya.Image;
		public labShipName:Laya.Label;
		public imgShipHold:Laya.Image;
		public richProp:Laya.Label;
		public btnConfirmN:Laya.Image;
		public labBtnRemodel:Laya.Label;
		public imgArrowRN:Laya.Image;
		public imgArrowLN:Laya.Image;
		public lsv:Laya.List;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("shipModule/BattleShipRemodelSelectModule");

        }

    }
}

module ui.shipModule {
    export class BattleShipUpstageModuleUI extends View {
		public imgBgN:Laya.Image;
		public imgTitleN:Laya.Image;
		public btnCloseN:Laya.Image;
		public labTitleN:Laya.Label;
		public imgNameBgN:Laya.Image;
		public labShipName1:Laya.Label;
		public labShipName2:Laya.Label;
		public imgShipBg1:Laya.Image;
		public imgShipBg2:Laya.Image;
		public imgBg1N:Laya.Image;
		public imgTitleBg1N:Laya.Image;
		public labTitle1N:Laya.Label;
		public imgBg2N:Laya.Image;
		public imgTitleBg2N:Laya.Image;
		public labTitle2N:Laya.Label;
		public btnTips:Laya.Image;
		public imgArrow1:Laya.Image;
		public imgArrow2:Laya.Image;
		public btnUpstage:Laya.Image;
		public labBtnUp:Laya.Label;
		public richProp1:Laya.Label;
		public richProp2:Laya.Label;
		public richEnergy:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("shipModule/BattleShipUpstageModule");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortAwardPreviewModuleUI extends View {
		public imgBgN:Laya.Image;
		public imgTitleN:Laya.Image;
		public btnCloseN:Laya.Image;
		public labTitleN:Laya.Label;
		public imgContentBg:Laya.Image;
		public imgL1N:Laya.Image;
		public imgL2N:Laya.Image;
		public labDesc1:Laya.Label;
		public labAwardTitle1:Laya.Label;
		public labDesc2:Laya.Label;
		public labAwardTitle2N:Laya.Label;
		public labBottomDesc:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortAwardPreviewModule");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortBossIconCellUI extends View {
		public imgBarBg:Laya.Image;
		public imgBar:Laya.Image;
		public imgBg:Laya.Image;
		public imgSelected:Laya.Image;
		public imgIcon:Laya.Image;
		public labName:Laya.Label;
		public imgPicked:Laya.Image;
		public imgRed:Laya.Image;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortBossIconCell");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortBossPanelUI extends View {
		public nodeMid:Laya.Box;
		public imgBg:Laya.Image;
		public imgHeadBg:Laya.Image;
		public imgHead:Laya.Image;
		public imgBossIcon:Laya.Image;
		public imgLN:Laya.Image;
		public labAwardTitleN:Laya.Label;
		public imgRN:Laya.Image;
		public richKillDesc:Laya.Label;
		public labName:Laya.Label;
		public labBossN:Laya.Label;
		public nodeBottom:Laya.Box;
		public btnKill:Laya.Image;
		public labBtnKill:Laya.Label;
		public imgRed:Laya.Image;
		public imgHpBg:Laya.Image;
		public imgHpBar:Laya.Image;
		public labHpValue:Laya.Label;
		public richTimesDesc:Laya.Label;
		public richHurtRank:Laya.Label;
		public nodeLock:Laya.Box;
		public imgLock:Laya.Image;
		public labLock:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortBossPanel");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortHurtRankModuleUI extends View {
		public imgBgN:Laya.Image;
		public imgTitleN:Laya.Image;
		public btnClose:Laya.Image;
		public imgLsvBgN:Laya.Image;
		public lsv:AutoTestGiftCell;
		public labTitle:Laya.Label;
		public imgTitleBgN:Laya.Image;
		public labRankN:Laya.Label;
		public labNameN:Laya.Label;
		public labLvN:Laya.Label;
		public labScoreN:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        			View.regComponent("AutoTestGiftCell",AutoTestGiftCell);

            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortHurtRankModule");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortKillPreviewModuleUI extends View {
		public imgBgN:Laya.Image;
		public imgTitleN:Laya.Image;
		public btnClose:Laya.Image;
		public labTitleN:Laya.Label;
		public imgContentBg:Laya.Image;
		public imgRwdBgN:Laya.Image;
		public labAwardTitleN:Laya.Label;
		public richKillResult:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortKillPreviewModule");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortListCellUI extends View {
		public imgBg1:Laya.Image;
		public imgEscortable:Laya.Image;
		public labEscortable:Laya.Label;
		public labAreaName:Laya.Label;
		public imgTaskBg:Laya.Image;
		public richShipName:Laya.Label;
		public labPlayerName:Laya.Label;
		public imgShipIcon:Laya.Image;
		public imgSelected:Laya.Image;
		public imgPickable:Laya.Image;
		public imgNew:Laya.Image;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortListCell");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortListPanelUI extends View {
		public nodeTop:Laya.Box;
		public imgBarBg:Laya.Image;
		public imgBar:Laya.Image;
		public labEnergy:Laya.Label;
		public labRecoverEnergy:Laya.Label;
		public imgVit:Laya.Image;
		public nodeMid:Laya.Box;
		public imgLsvBgN:Laya.Image;
		public lsv:Laya.List;
		public imgEscortBgN:Laya.Image;
		public richEscortTimes:Laya.Label;
		public labEscortTime:Laya.Label;
		public btnEscortTips:Laya.Image;
		public nodeBottom:Laya.Box;
		public nodeEscort:Laya.Box;
		public btnEscort:Laya.Image;
		public labBtnEscort:Laya.Label;
		public imgRed:Laya.Image;
		public richEscortDesc:Laya.Label;
		public nodeGo:Laya.Box;
		public imgBottomBg:Laya.Image;
		public btnAppeal:Laya.Image;
		public labBtnAppeal:Laya.Label;
		public btnGo:Laya.Image;
		public labBtnGo:Laya.Label;
		public imgHpBg:Laya.Image;
		public imgHpBar:Laya.Image;
		public labHpValue:Laya.Label;
		public imgShipIcon:Laya.Image;
		public richAttackDesc:Laya.Label;
		public labErea:Laya.Label;
		public labDisappearTime:Laya.Label;
		public nodeMember:Laya.Box;
		public imgAwardPreview:Laya.Image;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortListPanel");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortMemberModuleUI extends View {
		public imgBgN:Laya.Image;
		public imgTitleN:Laya.Image;
		public labTitleN:Laya.Label;
		public btnCloseN:Laya.Image;
		public imgLsvBg:Laya.Image;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortMemberModule");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortMonsterOperateModuleUI extends View {
		public imgBgN:Laya.Image;
		public btnClose:Laya.Image;
		public labTitle:Laya.Label;
		public richName:Laya.Label;
		public imgMonsterIcon:Laya.Image;
		public imgTimeBgN:Laya.Image;
		public richTimes:Laya.Label;
		public imgBarBg:Laya.Image;
		public imgBar:Laya.Image;
		public labProgress:Laya.Label;
		public labRankTitleN:Laya.Label;
		public btnTips:Laya.Image;
		public btnInfo:Laya.Image;
		public btnReward:Laya.Image;
		public btnFight:Laya.Image;
		public btnScout:Laya.Image;
		public lsv:Laya.List;
		public labCostOne:Laya.Label;
		public imgRankTitleBgN:Laya.Image;
		public labRankN:Laya.Label;
		public labNameN:Laya.Label;
		public labLvN:Laya.Label;
		public labScoreN:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortMonsterOperateModule");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortPlayerHurtCellUI extends View {
		public imgBgN:Laya.Image;
		public imgTeamPos:Laya.Image;
		public labName:Laya.Label;
		public labLv:Laya.Label;
		public labHurt:Laya.Label;
		public imgHeadBgN:Laya.Image;
		public imgHead:Laya.Image;
		public imgRank:Laya.Image;
		public labRank:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortPlayerHurtCell");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortRankAwardCellUI extends View {
		public imgBgN:Laya.Image;
		public imgHeadBgN:Laya.Image;
		public labTitle:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortRankAwardCell");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortRankAwardModuleUI extends View {
		public imgBgN:Laya.Image;
		public imgTitleN:Laya.Image;
		public btnClose:Laya.Image;
		public imgLsvBgN:Laya.Image;
		public lsv:AutoTestGiftCell;
		public labTitle:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        			View.regComponent("AutoTestGiftCell",AutoTestGiftCell);

            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortRankAwardModule");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortRankCellUI extends View {
		public imgBg:Laya.Image;
		public imgRank:Laya.Image;
		public labRank:Laya.Label;
		public richName:Laya.Label;
		public labLv:Laya.Label;
		public labScore:Laya.Label;
		public imgLine:Laya.Image;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortRankCell");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortRankPanelUI extends View {
		public imgBgN:Laya.Image;
		public btnReward:Laya.Image;
		public labBtnReward:Laya.Label;
		public imgMineN:Laya.Image;
		public labMyScoreTitle:Laya.Label;
		public labMyScore:Laya.Label;
		public labMyRankTitle:Laya.Label;
		public labMyRank:Laya.Label;
		public imgEscortBg:Laya.Image;
		public labRankN:Laya.Label;
		public labNameN:Laya.Label;
		public labLv:Laya.Label;
		public labScore:Laya.Label;
		public lsv:Laya.List;
		public labNoRank:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortRankPanel");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortShipOperateModuleUI extends View {
		public imgBgN:Laya.Image;
		public btnClose:Laya.Image;
		public labTitle:Laya.Label;
		public richName:Laya.Label;
		public imgMonsterIcon:Laya.Image;
		public imgTimeBgN:Laya.Image;
		public richTimes:Laya.Label;
		public labShipDesc:Laya.Label;
		public richTitle2:Laya.Label;
		public btnTips:Laya.Image;
		public btnInfo:Laya.Image;
		public btnReward:Laya.Image;
		public btnFight:Laya.Image;
		public nodeHeadHold:Laya.Box;
		public labCostOneN:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortShipOperateModule");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortSuccessHelpModuleUI extends View {
		public imgBgN:Laya.Image;
		public imgLightN:Laya.Image;
		public imgEffBgN:Laya.Image;
		public imgWingLN:Laya.Image;
		public imgWingRN:Laya.Image;
		public imgStarN:Laya.Image;
		public imgTitleBgN:Laya.Image;
		public labTitleN:Laya.Label;
		public labKillTarget:Laya.Label;
		public labRwdTitleN:Laya.Label;
		public imgLineLN:Laya.Image;
		public imgLineRN:Laya.Image;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortSuccessHelpModule");

        }

    }
}

module ui.teamEscortModule {
    export class TeamEscortSuccessKillModuleUI extends View {
		public imgBgN:Laya.Image;
		public imgLightN:Laya.Image;
		public imgEffBgN:Laya.Image;
		public imgWingLN:Laya.Image;
		public imgWingRN:Laya.Image;
		public imgStarN:Laya.Image;
		public imgTitleBgN:Laya.Image;
		public labTitleN:Laya.Label;
		public labKillTarget:Laya.Label;
		public richKillBossDesc:Laya.Label;

        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.loadUI("teamEscortModule/TeamEscortSuccessKillModule");

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
