require "import"
import "str"

this.setContentView(loadlayout ({
  RelativeLayout,
  layout_width="fill",
  layout_height="fill",
  --visibility=4,
  backgroundColor=背景色,
  --orientation="vertical",
  --elevation="2%w",
  paddingTop=状态栏高度,
  {
    RelativeLayout,
    layout_width="fill",
    layout_height="56dp" ,
    gravity="center",
    padding="16dp",
    --backgroundColor=0xffffffff,
    elevation="2dp",
    paddingTop="8dp",
    paddingBottom="8dp",
    {
      ImageView,
      src="drawable/back.png",
      layout_height="fill",
      layout_width="44dp",
      foreground=波纹(波纹色),
      onClick=function ()
        this.finish()
      end,
      colorFilter=图标色,
      padding="9dp",
    },
    {
      TextView,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      --layout_gravity="center",
      text="垂直领域",
      textSize="20sp",
      textColor=文字色,
    },
  },
  {
    ScrollView,
    layout_width="fill",
    {
      LinearLayout,
      layout_width="fill",
      orientation="vertical",
      {
        LinearLayout,
        paddingTop="56dp" ,
      },
      {
        LinearLayout,
        layout_width="-1",
        layout_height="-2",
        orientation="vertical",
        id="weather",
        padding="16dp";
        visibility=8,
        gravity="center";
        {
          LinearLayout,
          layout_width="-1",
          layout_height="-2",
          gravity="center";
          {
            ImageView,
            src="drawable/calendar_today.png",
            --alpha=0.25,
            adjustViewBounds=true,
            layout_width="56dp",
            colorFilter=文字色,
            layout_height="56dp";
            layout_marginRight="8dp",
            id="weathericon";
          },
          {
            LinearLayout,
            orientation="vertical",
            layout_width="fill",
            layout_height="-2",
            layout_weight="1";
            {
              TextView,
              textSize="16sp",
              textColor=文字色,
              id="ct",
              layout_marginLeft="16dp";
            },
            {
              TextView,
              textSize="14sp",
              textColor=次要文字色,
              id="tod",
              paddingTop="4dp",
              layout_marginLeft="16dp";
            },
          };
          {
            TextView,
            textSize="36sp",
            textColor=文字色,
            id="wend",
            layout_marginRight="16dp";
          },
        },
        {
          LinearLayout,
          paddingTop="8dp",
          layout_width="-1",
          layout_height="-2",
          gravity="center";
          {
            TextView,
            id="fengxiang",
            textSize="14sp",
            textColor=文字色,
            layout_marginRight="8dp",
          },
          {
            TextView,
            id="fengli",
            textSize="14sp",
            textColor=文字色,
            layout_marginRight="8dp",
          },
          {
            TextView,
            id="shidu",
            textSize="14sp",
            textColor=文字色,
            layout_marginRight="8dp",
          },
          {
            TextView,
            id="kqzl",
            textSize="14sp",
            textColor=文字色,
          },
        },
        {
          TextView,
          id="tishi",
          textSize="12sp",
          textColor=次要文字色,
          gravity="center",
          paddingTop="4dp",
        },
      },
      sort("官方"),
      {
        FrameLayout,
        onClick=function ()
          this.newActivity("app/microstorm")
        end,
        layout_width="fill",
        layout_gravity="center",
        foreground=波纹(波纹色),
        padding="16dp",
        {
          TextView,
          text="微风暴",
          textSize="16sp",
          textColor=文字色,
          layout_height="fill",
          layout_gravity="left|center",
        },
        {
          ImageView,
          src="drawable/arrow.png",
          rotation=-90,
          layout_width="26dp",
          colorFilter=图标色,
          layout_height="26dp",
          --layout_alignParentRight=true,
          layout_gravity="right|center",
        },
      },
      {
        FrameLayout,
        onClick=function ()
          this.newActivity("app/superreading")
        end,
        layout_width="fill",
        layout_gravity="center",
        foreground=波纹(波纹色),
        padding="16dp",
        {
          TextView,
          text="超级阅读",
          textSize="16sp",
          textColor=文字色,
          layout_height="fill",
          layout_gravity="left|center",
        },
        {
          ImageView,
          src="drawable/arrow.png",
          rotation=-90,
          layout_width="26dp",
          colorFilter=图标色,
          layout_height="26dp",
          --layout_alignParentRight=true,
          layout_gravity="right|center",
        },
      },
      {
        FrameLayout,
        --layout_marginTop=lay_wh*0.5,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("app/post",{"http://www.agyer.xyz/index.php/archives/6/"})
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="句子收录",
          textSize="16sp",
          layout_gravity="left|center",
          textColor=文字色,
          layout_height="fill",
        },
        {
          ImageView,
          src="drawable/arrow.png",
          rotation=-90,
          layout_width="26dp",
          colorFilter=图标色,
          layout_height="26dp",
          --layout_alignParentRight=true,
          layout_gravity="right|center",
        },
      },
      {
        FrameLayout,
        onClick=function ()
          this.newActivity("app/leave")
        end,
        layout_width="fill",
        layout_gravity="center",
        foreground=波纹(波纹色),
        padding="16dp",
        {
          TextView,
          text="请假条",
          textSize="16sp",
          textColor=文字色,
          layout_height="fill",
          layout_gravity="left|center",
        },
        {
          ImageView,
          src="drawable/arrow.png",
          rotation=-90,
          layout_width="26dp",
          colorFilter=图标色,
          layout_height="26dp",
          --layout_alignParentRight=true,
          layout_gravity="right|center",
        },
      },--[===[
      {
        FrameLayout,
        --layout_marginTop=lay_wh*0.5,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("web",{"https://www.shengqzj.com/app/index.php?i=2&c=entry&do=index&m=bsht_tbk&shopid=1718","闲言App 官方独家优惠券",[[{
  onPageStarted=function (v,u)
    title.text=v.title
  err.visibility=8
  sslerr.visibility=8
if u:sub(1,40)=="http://www.agyer.xyz/index.php/archives/" then
    this.newActivity("post",{u})
  v.goBack()
  elseif u:sub(1,4)=="http" then
 local pref=this.getSharedPreferences("Cookie",0)
 local domain=Uri.parse(u).host
--toast (domain.host)
CookieManager.getInstance().setCookie(domain,pref.getString(domain,""))
    end
    onPause()
  end,
  onPageFinished=function (v,u)
   if u:sub(1,4)=="http" then
      title.text=v.title
  local perf=this.getSharedPreferences("Cookie",0)
 local domain=Uri.parse(u).host
-- toast (domain.host)
 perf.edit().putString(domain,CookieManager.getInstance().getCookie(domain)).apply()
 --task(5000, function ()
v.loadUrl(]].."[["..[[javascript:
var down=document.getElementsByClassName("download_app");
down[0].remove();
var but=document.getElementById("share_box");
but.remove();
  ]].."]]"..[[)
--end)
   end
    onPause()
  end,
  shouldOverrideUrlLoading=function (v,u)
    if u:sub(1,4)~="http" and u:sub(1,10)~="javascript" then
  v.stopLoading()
      showDialog("外部应用","网站请求打开外部应用，是否打开？","打开","取消", function ()
      openInBrowser(u)
     end)
    end
  end,
  onReceivedSslError=function (v,h,e)
sslerr.visibility=0
sslerrde.text=tostring (e)
sslerr.getChildAt(3).onClick=function ()
  h.proceed()
 end
end,
onReceivedError=function (v,r,e)
err.visibility=0
errde.text=e
title.text=v.title
end}]]})
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="官方独家优惠券",
          textSize="16sp",
          layout_gravity="left|center",
          textColor=文字色,
          layout_height="fill",
        },
        {
          ImageView,
          src="drawable/arrow.png",
          rotation=-90,
          layout_width="26dp",
          colorFilter=图标色,
          layout_height="26dp",
          --layout_alignParentRight=true,
          layout_gravity="right|center",
        },
      },
      sort("精选"),
      {
        FrameLayout,
        --layout_marginTop=lay_wh*0.5,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("thirdparty/wallpaper/main")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="壁纸",
          textSize="16sp",
          layout_gravity="left|center",
          textColor=文字色,
          layout_height="fill",
        },
        {
          ImageView,
          src="drawable/arrow.png",
          rotation=-90,
          layout_width="26dp",
          colorFilter=图标色,
          layout_height="26dp",
          --layout_alignParentRight=true,
          layout_gravity="right|center",
        },
      },
      {
        FrameLayout,
        --layout_marginTop=lay_wh*0.5,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        id="bqb",
        visibility=8,
        onClick=function ()
          this.newActivity("thirdparty/biaoqing")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="表情包",
          textSize="16sp",
          layout_gravity="left|center",
          textColor=文字色,
          layout_height="fill",
        },
        {
          ImageView,
          src="drawable/arrow.png",
          rotation=-90,
          layout_width="26dp",
          layout_height="26dp",
          --layout_alignParentRight=true,
          layout_gravity="right|center",
          colorFilter=图标色,
        },
      },]===]
      {
        LinearLayout,
        orientation="vertical",
        id="thirdp",
        layout_width="fill",
        {
          TextView,
          text="正在加载",
          textSize="14sp",
          gravity="center",
          layout_width="fill",
          textColor=淡色,
          padding="16dp",
        },
      },
      {
        LinearLayout,
        layout_width="fill",
        visibility=8,
        orientation="vertical",
        sort("第三方"),
        {
          FrameLayout,
          --layout_marginTop=lay_wh*0.5,
          --layout_height=lay_wh,
          layout_width="fill",
          padding="16dp",
          layout_gravity="center",
          onClick=function ()
            contactQQ(2821981550)
          end,
          foreground=波纹(0x30000000),
          {
            TextView,
            text="商务广告合作",
            textSize="16sp",
            layout_gravity="left|center",
            textColor=0xff000000,
            layout_height="fill",
          },
          {
            ImageView,
            src="drawable/arrow.png",
            rotation=-90,
            layout_width="26dp",
            layout_height="26dp",
            --layout_alignParentRight=true,
            layout_gravity="right|center",
          },
        },
        {
          FrameLayout,
          layout_width="fill",
          padding="16dp",
          layout_gravity="center",
          onClick=function ()
            InAppBrowser("http://qqq.rerv.cn/","在线网站制作")
          end,
          foreground=波纹(0x30000000),
          {
            TextView,
            text="在线网站制作",
            textSize="16sp",
            layout_gravity="left|center",
            textColor=0xff000000,
            layout_height="fill",
          },
          {
            ImageView,
            src="drawable/arrow.png",
            rotation=-90,
            layout_width="26dp",
            layout_height="26dp",
            --layout_alignParentRight=true,
            layout_gravity="right|center",
          },
        },
      },
      {
        FrameLayout,
        -- layout_width="fill",
        layout_gravity="center",
        visibility=8,
        id="more",
        layout_marginTop="20dp",
        layout_marginBottom="8dp",
        {
          LinearLayout,
          backgroundColor=淡色,
          layout_width="fill",
          layout_height="0.75dp",
          layout_marginLeft="8dp",
          layout_gravity="center",
          layout_marginRight="8dp",
        },
        {
          TextView,
          text="更多有趣开发中",
          textColor=淡色,
          textSize="14sp",
          layout_height="fill",
          layout_width="wrap",
          layout_gravity="center",
          padding="8dp",
          paddingLeft="16dp",
          paddingRight="16dp",
          backgroundColor=背景色,
          gravity="center",
          layout_marginLeft="32dp",
          layout_marginRight="32dp",
        },
      },
      --发现
    },
  },
  {
    LinearLayout,
    layout_width="fill",
    layout_height="56dp" ,
    foreground=上下渐变({背景色,深透,淡透}),
  },
}))

Http.get("https://raw.githubusercontent.com/DOGE-tt/WordsLeisure/master/discover.txt", function (c,n)
  thirdp.removeView(thirdp.getChildAt(0))
  if c==200 then
    local n=StrToTable(n)
    thirdp.addView(loadlayout (n))
  end
  --[[thirdp.addView(loadlayout ({
  TextView,
  text="暂无更多",
 textSize="14sp",
 gravity="center",
 layout_width="fill",
 --textColor=0xff000000,
  padding="16dp",
 }))]]
  -- more.setVisibility(0)
end)

Http.get("https://www.wubiaoqing.com/category/hot/", function (c,n)
  if c~=200 and (n:find("validate certificate") or c>=400) then
   else
    --bqb.setVisibility(0)
  end
end)

Http.get("https://www.tianqiapi.com/api/?version=v1&cityid=&appid=95813455&appsecret=AfprZJ6x", function (c,n)
  if c==200 then
    local n=cjson.decode(n)
    local city,country,cityEn,countryEn=n.city,n.country,n.cityEn,n.countryEn
    local cityId,time,today=n.cityid,n.update_time:match(" (.+)"),n.update_time:match("(.+) ")
    local date=n.data[1]
    local w1,w2,ws=date.win[1],date.win[2],date.win_speed
    local wea, temp, wea_img, humi,air_level,air_tip=date.wea,date.tem,date.wea_img,date.humidity,date.air_level,date.air_tips
    ct.setText(city.." "..wea)
    wend.Text=temp:match("(.+)C") or temp:match("(.+)℃").."°" or temp
    tod.setText(today)
    weathericon.setImageBitmap(loadbitmap("drawable/weather/"..wea_img..".png"))
    kqzl.setText("空气质量 "..air_level)
    shidu.setText("空气湿度 "..humi)
    tishi.setText(air_tip)
    fengxiang.setText(w1)
    fengli.setText("风力 "..ws)
    weather.setVisibility(0)
    --toast(w1,w2,ws,humi,air_level,air_tip)
  end
end)