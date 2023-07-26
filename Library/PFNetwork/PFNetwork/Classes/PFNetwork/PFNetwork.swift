//
//  PFNetwork.swift
//  Alamofire
//
//  Created by Ja on 2023/7/26.
//

import Foundation
import Alamofire
import ObjectMapper

public final class PFNetwork: NSObject {
    
    public static let shared: PFNetwork = PFNetwork()
    
    let header: HTTPHeaders = [:]
    
    public enum QueryResult<Value: Mappable> {
        case success(Value, BaseResponse)
        case successArray([Value], BaseResponse)
        case fail(Error?, BaseResponse?)
    }
    
    public func request<T: Mappable>(_ url: String,
                                     method: HTTPMethod = .post,
                                     parameters originParameters: Parameters? = nil,
                                     encoding: ParameterEncoding = URLEncoding.default,
                                     needMapper: Bool = true,
                                     callback: @escaping ((QueryResult<T>) -> Void)) {
        
        AF.request(url, method: method,
                   parameters: originParameters,
                   encoding: encoding,
                   headers: header).responseString { (response: AFDataResponse<String>) in
            switch response.result {
            case .success(let value):
                debugPrint("URL:",url)
                debugPrint("header",self.header)
                debugPrint("parameters:",originParameters as Any)
                debugPrint("response:",value.unicodeDescription)
                
                let lbBaseResponse = Mapper<BaseResponse>().map(JSONString: value)
                guard let res = lbBaseResponse else {
                    callback(QueryResult.fail(nil, nil))
                    break
                }
                
                if res.code != 200 {
                    callback(QueryResult.fail(nil, res))
                    break
                }
                
                if needMapper == false {
                    callback(QueryResult.success(T(map: Map())!, res))
                    break
                }
                
                guard let resultObj = res.result else {
                    if res.code == 200 {
                        callback(QueryResult.success(T(map: Map())!, res))
                        break
                    }
                    break
                }
                
                let dataArray = Mapper<T>().mapArray(JSONObject: resultObj)
                
                let dataObject = Mapper<T>().map(JSONObject: resultObj)
                
                if let dataArray = dataArray {
                    callback(QueryResult.successArray(dataArray, res))
                } else if let dataObject = dataObject{
                    callback(QueryResult.success(dataObject, res))
                } else {
                    callback(QueryResult.fail(nil, res))
                }
                
            case .failure(let fail):
                debugPrint("URL:",url)
                debugPrint("header",self.header)
                debugPrint("parameters:",originParameters as Any)
                debugPrint("response.description:",response.description)
                debugPrint("fail", fail)
                
                if let statusCode = response.response?.statusCode {
                    //                    // token失效
                    //                    if statusCode == 403 {
                    //                        NotificationCenter.default.post(name: NSNotification.Name.userTokenExpire, object: nil)
                    //                        let resonseBase = BaseResponse()
                    //                        resonseBase.ret = statusCode
                    //                        callback(QueryResult.fail(fail, resonseBase))
                    //                        return
                    //                    }
                }
                callback(QueryResult.fail(fail, nil))
                break
            }
        }
    }
}

extension Map {
    convenience init() {
        self.init()
    }
}
