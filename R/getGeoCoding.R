#' Get longitude and latitude through Baidu map API
#'
#' @param ak user must register their ak (key) before use.
#' @param address the address to parse
#' @param city the city of address
#' @param ret_coordtype the type of coordinate
#' @param sn not necessary
#' @param output must by json
#' @details [Detail document reference](https://lbsyun.baidu.com/index.php?title=webapi/guide/webservice-geocoding)
#'
#' @return Longitude and latitude of address
#' @export
#'
#' @examples
#' getGeoCoding(ak = '92RLPSx3RqhlaNGjGTdzL2f2iqHmgl4f', address = 'beijing')
#'
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
