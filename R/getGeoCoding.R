#' Geocoder of Baidu map API, https://lbsyun.baidu.com/index.php?title=webapi/guide/webservice-geocoding
#'
#' @param ak , 用户申请注册的key，自v2开始参数修改为“ak”
#' @param address , 待解析的地址。最多支持84个字节。可以输入两种样式的值，分别是： 1、标准的结构化地址信息，如北京市海淀区上地十街十号 【推荐，地址结构越完整，解析精度越高】2、支持“*路与*路交叉口”描述方式，如北一环路和阜阳路的交叉路口
#' @param city ,地址所在的城市名。用于指定上述地址所在的城市，当多个城市都有上述地址时，该参数起到过滤作用，但不限制坐标召回城市。
#' @param ret_coordtype
#' @param sn
#' @param output
#'
#' @return
#' @export
#'
#' @examples
getGeoCoding <- function(ak = NULL, address = NULL, city = NULL, ret_coordtype = 'gcj02ll', sn = NULL, output = 'json') {
   t_url = 'https://api.map.baidu.com/geocoding/v3/?'
   t_ak = paste0('ak=', ak)
   t_address = paste0('address=', address)
   t_city = paste0('city=', city)
   t_ret_coordtype = paste0('ret_coordtype=', ret_coordtype)
   t_sn = paste0('sn=', sn)
   t_output = paste0('output=', output)
   fromJSON(txt = paste(t_url, t_ak, t_address, t_city, t_ret_coordtype, t_sn, t_output, sep = '&')) %>%
      unlist() %>%
      t() %>%
      data.frame() %>%
      rename(
         lng = result.location.lng,
         lat = result.location.lat,
         precise = result.precise,
         confidence = result.confidence,
         comprehension = result.comprehension,
         level = result.level
      ) %>%
      return()
}
