import preferences from '@ohos.data.preferences';
import { Constants } from '../common/Constants';
import { HomeGptRolesRecommend } from '../data/bean/AiApplication';
import { GptRole } from '../data/bean/GptRole';
import { AiChatRepository } from '../data/provider/AiChatRepository';
import Global from '../manager/Global';

export class AiHomeStore {

  defaultAppList: HomeGptRolesRecommend[] = [
    new HomeGptRolesRecommend("1", "学习",[
      new GptRole("-1","1","1","1","1"),
      new GptRole("-1","1","1","1","1"),
      new GptRole("-1","1","1","1","1"),
      new GptRole("-1","1","1","1","1")
    ]),
    new HomeGptRolesRecommend("2", "写作",[
      new GptRole("-1","1","1","1","1"),
      new GptRole("-1","1","1","1","1"),
      new GptRole("-1","1","1","1","1"),
      new GptRole("-1","1","1","1","1")
    ]),
    new HomeGptRolesRecommend("4", "写作",[
      new GptRole("-1","1","1","1","1"),
      new GptRole("-1","1","1","1","1"),
      new GptRole("-1","1","1","1","1"),
      new GptRole("-1","1","1","1","1")
    ])
  ];

  async init () {
    let preference = preferences.getPreferencesSync(Global.getContext().context,{name: Constants.GLOBAL_SP})
    let aiApplicationLocal = preference.getSync(Constants.AI_HOME_APPLICATION,null)
    if (!aiApplicationLocal) {
      // TODO json
    }
    let recommends = await new AiChatRepository().requestHomeRecommends(["1","2","4"]);
    this.defaultAppList = recommends;
    // TODO json
    return this.defaultAppList;
  }
}