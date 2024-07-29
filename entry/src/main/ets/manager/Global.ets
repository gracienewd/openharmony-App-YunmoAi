import { DeviceUtils } from '../common/utils/DeviceUtils';

export default class Global {
  private constructor() { }
  private static instance: Global;

  public context ?: Context;

  public deviceId ?: string;

  public static getContext(): Global {
    if (!Global.instance) {
      Global.instance = new Global();
    }
    return Global.instance;
  }

  async init() {
    this.deviceId = await DeviceUtils.getDeviceId();
    console.log("deviceId",this.deviceId);
  }

}
