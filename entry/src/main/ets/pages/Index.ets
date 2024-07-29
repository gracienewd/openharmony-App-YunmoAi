import  {HomeComponent} from  "./home/index"
import BuiPopup, { BuiPopupController } from '../views/dialog/BuiPopup';

@Entry
@Component
struct Index {
  @State message: string = 'Home';
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController()

  dialogController:BuiPopupController={} as BuiPopupController

  @Builder
  TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 }).margin({bottom: 10})
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#FFFFFFFF' : '#FF999999')
    }
    .margin({bottom: 10})
    .width('100%')
    .backgroundColor($r("app.color.app_background"))
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }

  build() {
    RelativeContainer() {
      Tabs({ barPosition: BarPosition.End,controller:this.tabsController }) {
        TabContent() {
          Column(){
            HomeComponent()
          }.alignItems(HorizontalAlign.Start).height('100%')
        }
        .tabBar(
          this.TabBuilder("首页", 0, $r('app.media.tab_home_sel'), $r('app.media.tab_home_unsel'))
        )

        TabContent() {
          Text('推荐的内容').fontSize(30)
        }
        .tabBar(
          this.TabBuilder("对话", 1, $r('app.media.tab_chat_sel'), $r('app.media.tab_chat_unsel'))
        )

        TabContent() {
          Text('发现的内容').fontSize(30)
        }
        .tabBar(
          this.TabBuilder("角色", 2, $r('app.media.tab_trasure_sel'), $r('app.media.tab_trasure_unsel'))
        )

        TabContent() {
          Text('我的内容').fontSize(30)
        }
        .tabBar(
          this.TabBuilder("AI创作", 3, $r('app.media.tab_creator_sel'), $r('app.media.tab_creator_unsel'))
        )

        TabContent() {
          Text('我的内容').fontSize(30)
        }
        .tabBar(
          this.TabBuilder("我的", 4, $r('app.media.tab_mine_sel'), $r('app.media.tab_mine_unsel'))
        )
      }
      .onChange((index) => {
        this.currentIndex = index
        if (index == 1) {
          this.dialogController.open();
        }
      })
      .backgroundColor($r('app.color.app_background'))

      BuiPopup({
        controller: this.dialogController ,
        slot:()=>{
          this.buildPopContent();
        }
      });
    }
    .backgroundColor($r('app.color.app_background'))
    .height('100%')
    .width('100%')
  }

  @Builder
  buildPopContent() {
    Column() {
      Text("我可以是任意内容")
    }.backgroundColor("white").width("100%")
    .borderRadius({
      topLeft:16,
      topRight:16
    }).constraintSize({minHeight:200})
  }

}

