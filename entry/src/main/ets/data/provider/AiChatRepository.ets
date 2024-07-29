import { Request } from '../../common/net/RequestUtils'
import { HomeGptRolesRecommend } from '../bean/AiApplication';
import { List } from '@kit.ArkTS';

export class AiChatRepository {
  /**
   * 首页推荐应用
   * @param categoryIds
   * @returns
   */
  requestHomeRecommends(categoryIds: string[]) {
    let paramsMap: object = Object();
    paramsMap["categoryIds"] = categoryIds;
    return Request.get<HomeGptRolesRecommend[]>("/gpt/creator/home/recommend", paramsMap);
  }
}