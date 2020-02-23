require "import"

--T1后端云对接配置
url="http://t1.huayi-w.cn" --默认不需要修改
key="69fc5d942271e592" --个人后台的key
httk="ac7b91c34586f27764b777faa89f3e6c" --个人后台的token

t1url=url
t1key=key
t1httk=httk

cjson=import "cjson"

--本源码大部分由沐宇编写
--作者QQ：2297458214
--登录、注册布局非原创，本人只是修改了一下
--使用前请先去【T1.lua】文件里填写好自己的key、token
--本源码实现了T1后端云的大部分功能，相关函数也写好了，可以自己扩展编写更多功能！

--[[ 
T1后端云官网：http://t1.huayi-w.cn/
T1对接文档：http://doc.huayi-w.cn/1461133
T1后端云官群：6711866O3

T1后端云介绍：
T1后端云是一个免费且稳定的APP接口（API）系统；
能够大大降低开发者成本，加速APP上线；
开发者无需购买服务器开发后端程序
只要免费对接T1后端云就能实现丰富的APP功能！
--]]



--提供两种MD5方式-自己选择使用
function MD5(str)
  import "java.security.MessageDigest"
  md5 = MessageDigest.getInstance("MD5")
  local bytes = md5.digest(String(str).getBytes())
  local result = ""
  for i=0,#bytes-1 do
    local temp = string.format("%02x",(bytes[i] & 0xff))
    result =result..temp
  end
  return result
end

--[[
function MD5(str)
  import "java.security.MessageDigest"
  import "android.text.TextUtils"
  import "java.lang.StringBuffer"
  sb=StringBuffer();
  import "java.lang.Byte"
  md5=MessageDigest.getInstance("md5")
  import "java.lang.Byte"
  bytes =md5.digest(String(str).getBytes())
  result=""
  by=luajava.astable(bytes)
  for k,n in ipairs(by) do
    import "java.lang.Integer"
    temp = Integer.toHexString(n & 255);
    if #temp == 1 then
      sb.append("0")
    end
    sb.append(temp);
  end
  return sb
end
--]]

function 订单号()
  local 年月日=os.date("%Y%m%d")
  local 数组={}
  for i=1,5 do
    数组[i]=math.random(0,9)
  end
  return "T1"..年月日..数组[1]..数组[2]..数组[3]..数组[4]..数组[5]
end


----------用户系统函数op----------
function 注册账号(url,key,zh,mm,yqm,httk,ret)
  local token=MD5(key..zh..mm..httk)
  if yqm=="" then
    data="key="..key.."&user="..zh.."&pass="..mm.."&token="..token
   else
    data="key="..key.."&user="..zh.."&pass="..mm.."&invite="..yqm.."&token="..token
  end
  Http.post(url.."/user_reg.json",data,function(code,body,cookie,headers)
    if code==200 then
      ret( body)
     else
      ret( "401")
    end
  end)
end


--登录账号&获取用户信息
--[[function 登录账号(url,key,zh,mm,httk)
  local token=MD5(key..zh..mm..httk)
  data="key="..key.."&user="..zh.."&pass="..mm.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_info.json?type=info",data)
  if code==200 then
    return body
   else
    return "401"
  end
end]]
function 登录账号(url,key,zh,mm,httk,ret)
  local token=MD5(key..zh..mm..httk)
  data="key="..key.."&user="..zh.."&pass="..mm.."&token="..token
  Http.post(url.."/user_info.json?type=info",data,function(code,body,cookie,headers)
    if code==200 then
      ret( body)
     else
      ret( "401")
    end
  end)
end

function 修改积分(url,key,zh,mm,jf,httk)
  local token=MD5(key..zh..mm..jf..httk)
  data="key="..key.."&user="..zh.."&pass="..mm.."&jf="..jf.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_info.json?type=edu_jf",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 修改余额(url,key,zh,mm,money,httk)
  local token=MD5(key..zh..mm..money..httk)
  data="key="..key.."&user="..zh.."&pass="..mm.."&money="..money.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_info.json?type=edu_money",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 修改自定义内容(url,key,zh,mm,custom,httk)
  local token=MD5(key..zh..mm..custom..httk)
  data="key="..key.."&user="..zh.."&pass="..mm.."&custom="..custom.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_info.json?type=edu_custom",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 修改密码(url,key,zh,mm,xmm,httk)
  local token=MD5(key..zh..mm..xmm..httk)
  data="key="..key.."&user="..zh.."&pass="..mm.."&newpass="..xmm.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_info.json?type=changepass",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 每日签到(url,key,zh,mm,httk)
  local token=MD5(key..zh..mm..httk)
  data="key="..key.."&user="..zh.."&pass="..mm.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_info.json?type=qd",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 余额换会员(url,key,zh,mm,hys,httk)
  local token=MD5(key..zh..mm..hys..httk)
  data="key="..key.."&user="..zh.."&pass="..mm.."&num="..hys.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_info.json?type=mtv",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 余额换积分(url,key,zh,mm,jfs,httk)
  local token=MD5(key..zh..mm..jfs..httk)
  data="key="..key.."&user="..zh.."&pass="..mm.."&num="..jfs.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_info.json?type=mtj",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 抽奖(url,key,zh,mm,httk)
  local token=MD5(key..zh..mm..httk)
  data="key="..key.."&user="..zh.."&pass="..mm.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_info.json?type=cj",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 抽奖记录(url,key,zh,mm,token)
  local token=MD5(key..zh..mm..httk)
  data="key="..key.."&user="..zh.."&pass="..mm.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_info.json?type=cj_list",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 平台数据(url,key,ret)
  Http.get(url.."/user_all.json?key="..key.."&type=online",function(code,body,cookie,headers)
    if code==200 then
      ret( body)
     else
      ret( "401")
    end
  end)
end


----------用户系统函数ed----------



------------------------------以下为接口商城函数------------------------------


function 发送邮件(url,key,title,text,who,httk)
  local token=MD5(key..title..text..who..httk)
  data="key="..key.."&title="..title.."&text="..text.."&who="..who.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_all.json?type=sendmail",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 云文档获取(url,key,uid,ret)
  Http.get(url.."/user_all.json?key="..key.."&type=text&id="..uid,function(code,body,cookie,headers)
    if code==200 then
      ret( body)
     else
      ret( "401")
    end
  end)
end


function ping测试(url,url_ip)
  body,cookie,code,headers=http.get(url.."/api.json?type=ping&url="..url_ip)
  if code==200 then
    return body
   else
    return "401"
  end
end


function ip信息查询(url,ip)
  body,cookie,code,headers=http.get(url.."/api.json?type=ipinfo&ip=ip地址"..ip)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 当前客户端IP(url)
  body,cookie,code,headers=http.get(url.."/api.json?type=get_ip")
  if code==200 then
    return body
   else
    return "401"
  end
end


function 天气获取(url,city)
  body,cookie,code,headers=http.get(url.."/api.json?type=weather&city="..city)
  if code==200 then
    return body
   else
    return "401"
  end
end


----------短信轰炸函数op----------


function 短信轰炸(url,key,tel,num,httk)
  local token=MD5(key..tel..num..httk)
  data="key="..key.."&tel="..tel.."&num="..num.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_all.json?type=telboom_add",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 轰炸状态(url,key,tel,httk)
  local token=MD5(key..tel..httk)
  data="key="..key.."&tel="..tel.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_all.json?type=telboom_sel",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 停止轰炸(url,key,tel,httk)
  local token=MD5(key..tel..httk)
  data="key="..key.."&tel="..tel.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_all.json?type=telboom_stop",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 添加白名单(url,key,tel,httk)
  local token=MD5(key..tel..httk)
  data="key="..key.."&tel="..tel.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_all.json?type=bmd_add",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 移除白名单(url,key,tel,httk)
  local token=MD5(key..tel..httk)
  data="key="..key.."&tel="..tel.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_all.json?type=bmd_del",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


function 查询白名单(url,key,tel,httk)
  local token=MD5(key..tel..httk)
  data="key="..key.."&tel="..tel.."&token="..token
  body,cookie,code,headers=http.post(url.."/user_all.json?type=bmd_sel",data)
  if code==200 then
    return body
   else
    return "401"
  end
end


----------短信轰炸函数ed----------



----------支付系统函数op----------


function 发起支付(url,key,paytype,orderid,paymsg,money,httk)
  local token=MD5(key..paytype..orderid..paymsg..money..httk)
  local 支付链接=url.."/pay.do?key="..key.."&paytype="..paytype.."&orderid="..orderid.."&paymsg="..paymsg.."&money="..money.."&token="..token
  浏览器打开(支付链接)
end


function 购买商品(url,key,paytype,orderid,paymsg,goodsid,goodsval,httk)
  local token=MD5(key..paytype..orderid..paymsg..goodsid..goodsval..httk)
  local 支付链接=url.."/pay.do?key="..key.."&paytype="..paytype.."&orderid="..orderid.."&paymsg="..paymsg.."&goodsid="..goodsid.."&goodsval="..goodsval.."&token="..token
  InAppBrowser(支付链接)
end


----------支付系统函数ed----------