import { BuiPopupController } from './dialog/BuiPopup';

export default  class RouteManager {

  private constructor() { }
  private static instance: RouteManager;

  public static getInstance(): RouteManager {
    if (!RouteManager.instance) {
      RouteManager.instance = new RouteManager();
    }
    return RouteManager.instance;
  }

  dialogController:BuiPopupController={} as BuiPopupController
}

