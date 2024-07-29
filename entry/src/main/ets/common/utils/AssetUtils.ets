import { asset } from '@kit.AssetStoreKit';
import { util } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

/// AssetStore 操作结果
export interface AssetStoreResult {
  isSuccess: boolean;
  error?: BusinessError;
  data?: string;
}

/// AssetStore query 操作结果
export interface AssetStoreQueryResult {
  res?: asset.AssetMap[];
  error?: BusinessError;
}

/**
 * 基于 @ohos.security.asset 的封装。可以保证『重装/删除应用而不丢失数据』。
 * @author Tanranran
 * @date 2024/5/14 22:14
 * @description
 * 关键资产存储服务提供了用户短敏感数据的安全存储及管理能力。
 * 其中，短敏感数据可以是密码类（账号/密码）、Token类（应用凭据）、其他关键明文（如银行卡号）等长度较短的用户敏感数据。
 * 可在应用卸载时保留数据。需要权限： ohos.permission.STORE_PERSISTENT_DATA。
 * 更多API可参考https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-asset-0000001815758836-V5
 * 使用例子：
 * // 增。
 const result = await AssetStore.set('key', 'value');
 if (result.isSuccess) {
 console.log('asset add succeeded')
 }

 // 删。
 AssetStore.remove('key');
 if (result.isSuccess) {
 console.log('asset remove succeeded')
 }

 // 改
 const result = await AssetStore.update('key', 'value');
 if (result.isSuccess) {
 console.log('asset update succeeded')
 }

 // 读取。
 const result = (await AssetStore.get('key'));
 if (result.isSuccess) {
 console.log('asset get succeeded, value == ', result.data)
 }
 */
export class AssetStore {
  /**
   * 新增数据
   * 添加成功，会通过 AppStorage 传值值变更，外部可通过 @StorageProp(key) value: string 观察值变化。
   * @param key           要添加的索引
   * @param value         要添加的值
   * @param isPersistent  在应用卸载时是否需要保留关键资产，默认为 true
   * @returns Promise<AssetStoreResult> 表示添加操作的异步结果
   */
  public static async set(key: string, value: string, isPersistent: boolean = true): Promise<AssetStoreResult> {
    let attr: asset.AssetMap = new Map();
    if (canIUse("SystemCapability.Security.Asset")) {
      // 关键资产别名，每条关键资产的唯一索引。
      // 类型为Uint8Array，长度为1-256字节。
      attr.set(asset.Tag.ALIAS, AssetStore.stringToArray(key));
      // 关键资产明文。
      // 类型为Uint8Array，长度为1-1024字节
      attr.set(asset.Tag.SECRET, AssetStore.stringToArray(value));

      // 关键资产同步类型>THIS_DEVICE只在本设备进行同步，如仅在本设备还原的备份场景。
      attr.set(asset.Tag.SYNC_TYPE, asset.SyncType.THIS_DEVICE);

      //枚举，新增关键资产时的冲突（如：别名相同）处理策略。OVERWRITE》抛出异常，由业务进行后续处理。
      attr.set(asset.Tag.CONFLICT_RESOLUTION,asset.ConflictResolution.THROW_ERROR)
      // 在应用卸载时是否需要保留关键资产。
      // 需要权限： ohos.permission.STORE_PERSISTENT_DATA。
      // 类型为bool。
      if (isPersistent) {
        attr.set(asset.Tag.IS_PERSISTENT, isPersistent);
      }
    }
    let result: AssetStoreResult
    if ((await AssetStore.has(key)).isSuccess) {
      result = await AssetStore.updateAssetMap(attr, attr);
    } else {
      result = await AssetStore.setAssetMap(attr);
    }
    if (result.isSuccess) {
      hilog.debug(0x1111,'AssetStore',
        `AssetStore: Asset add succeeded. Key is ${key}, value is ${value}, isPersistent is ${isPersistent}`);
      // 添加成功，会通过 AppStorage 传值值变更，外部可通过 @StorageProp(key) value: string 观察值变化。
      AppStorage.setOrCreate(key, value);
    }
    return result;
  }

  /**
   * 新增数据
   * @param attr          要添加的属性集
   * @returns Promise<AssetStoreResult> 表示添加操作的异步结果
   */
  public static async setAssetMap(attr: asset.AssetMap): Promise<AssetStoreResult> {
    try {
      if (canIUse("SystemCapability.Security.Asset")) {
        await asset.add(attr);
        return { isSuccess: true };
      }
      return { isSuccess: false, error: AssetStore.getUnSupportedPlatforms() };
    } catch (error) {
      const err = error as BusinessError;
      hilog.debug(0x1111,'AssetStore',
        `AssetStore: Failed to add Asset. Code is ${err.code}, message is ${err.message}`);
      return { isSuccess: false, error: err };
    }
  }

  /**
   * 删除数据
   * 删除成功，会通过 AppStorage 传值值变更，外部可通过 @StorageProp(key) value: string 观察值变化。
   * AppStorage API12 及以上支持 undefined 和 null类型。
   * @param key           要删除的索引
   * @returns Promise<AssetStoreResult> 表示添加操作的异步结果
   */
  public static async remove(key: string) {
    let query: asset.AssetMap = new Map();
    if (canIUse("SystemCapability.Security.Asset")) {
      // 关键资产别名，每条关键资产的唯一索引。
      // 类型为Uint8Array，长度为1-256字节。
      query.set(asset.Tag.ALIAS, AssetStore.stringToArray(key));
    }
    const result = await AssetStore.removeAssetMap(query);
    if (result.isSuccess) {
      hilog.debug(0x1111,'AssetStore', `AssetStore: Asset remove succeeded. Key is ${key}`);
      // 删除成功，会通过 AppStorage 传值值变更，外部可通过 @StorageProp(key) value: string 观察值变化。
      // AppStorage API12 及以上支持 undefined 和 null类型。
      AppStorage.setOrCreate(key, '');
    }
    return result;
  }

  /**
   * 删除数据
   * @param attr          要删除的属性集
   * @returns Promise<AssetStoreResult> 表示添加操作的异步结果
   */
  public static async removeAssetMap(attr: asset.AssetMap): Promise<AssetStoreResult> {
    try {
      if (canIUse("SystemCapability.Security.Asset")) {
        await asset.remove(attr);
        return { isSuccess: true };
      }
      return { isSuccess: false };
    } catch (error) {
      const err = error as BusinessError;
      hilog.debug(0x1111,'AssetStore',
        `AssetStore: Failed to remove Asset. Code is ${err.code}, message is ${err.message}`);
      return { isSuccess: false, error: err };
    }
  }

  /**
   * 判断是否存在 数据
   * @param key 要查找的索引
   * @returns Promise<AssetStoreResult> 表示添加操作的异步结果
   */
  public static async has(key: string): Promise<AssetStoreResult> {
    if (canIUse("SystemCapability.Security.Asset")) {
      let query: asset.AssetMap = new Map();
      // 关键资产别名，每条关键资产的唯一索引。
      // 类型为Uint8Array，长度为1-256字节。
      query.set(asset.Tag.ALIAS, AssetStore.stringToArray(key));
      // 	关键资产查询返回的结果类型。
      query.set(asset.Tag.RETURN_TYPE, asset.ReturnType.ALL);

      const result = await AssetStore.getAssetMap(query);

      const res = result.res;
      if (!res) {
        return { isSuccess: false, error: result.error };
      }
      if (res.length < 1) {
        return { isSuccess: false };
      }
    }
    return { isSuccess: false };
  }

  /**
   * 查找数据
   * @param key          要查找的索引
   * @returns Promise<AssetStoreResult> 表示添加操作的异步结果
   */
  public static async get(key: string): Promise<AssetStoreResult> {
    if (canIUse("SystemCapability.Security.Asset")) {
      let query: asset.AssetMap = new Map();
      // 关键资产别名，每条关键资产的唯一索引。
      // 类型为Uint8Array，长度为1-256字节。
      query.set(asset.Tag.ALIAS, AssetStore.stringToArray(key));
      // 	关键资产查询返回的结果类型。
      query.set(asset.Tag.RETURN_TYPE, asset.ReturnType.ALL);

      const result = await AssetStore.getAssetMap(query);

      const res = result.res;
      if (!res) {
        return { isSuccess: false, error: result.error };
      }
      if (res.length < 1) {
        return { isSuccess: false };
      }
      // parse the secret.
      let secret: Uint8Array = res[0].get(asset.Tag.SECRET) as Uint8Array;
      // parse uint8array to string
      let secretStr: string = AssetStore.arrayToString(secret);
      return { isSuccess: true, data: secretStr };
    }
    return { isSuccess: false, data: "" };
  }

  /**
   * 查找数据
   * @param key          要查找的索引
   * @returns Promise<AssetStoreQueryResult> 表示添加操作的异步结果
   */
  public static async getAssetMap(query: asset.AssetMap): Promise<AssetStoreQueryResult> {
    try {
      if (canIUse("SystemCapability.Security.Asset")) {
        const res: asset.AssetMap[] = await asset.query(query);
        return { res: res };
      }
      return { error: AssetStore.getUnSupportedPlatforms() };
    } catch (error) {
      const err = error as BusinessError;
      hilog.debug(0x1111,'AssetStore',
        `AssetStore>getAssetMap: Failed to query Asset. Code is ${err.code}, message is ${err.message}`);
      return { error: err };
    }
  }


  /**
   * 更新数据
   * @param query           要更新的索引数据集
   * @param attrsToUpdate   要更新的数据集
   * @returns Promise<AssetStoreResult> 表示添加操作的异步结果
   */
  public static async updateAssetMap(query: asset.AssetMap, attrsToUpdate: asset.AssetMap): Promise<AssetStoreResult> {
    try {
      if (canIUse("SystemCapability.Security.Asset")) {
        await asset.update(query, attrsToUpdate);
        return { isSuccess: true };
      }
      return { isSuccess: false, error: AssetStore.getUnSupportedPlatforms() };
    } catch (error) {
      const err = error as BusinessError;
      hilog.debug(0x1111, 'AssetStore',
        `AssetStore: Failed to update Asset. Code is ${err.code}, message is ${err.message}`);
      return { isSuccess: false, error: err };
    }
  }

  private static stringToArray(str: string): Uint8Array {
    let textEncoder = new util.TextEncoder();
    return textEncoder.encodeInto(str);
  }

  private static arrayToString(arr: Uint8Array): string {
    let textDecoder = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    let str = textDecoder.decodeWithStream(arr, { stream: false });
    return str;
  }

  private static getUnSupportedPlatforms() {
    return { name: "AssetStore", message: "不支持该平台" } as BusinessError
  }
}
