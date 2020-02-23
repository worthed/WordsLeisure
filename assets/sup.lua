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
      text="Sup会员",
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
        TextView,
        text="我的会员状态：获取中",
        textSize="16sp",
        textColor=文字色,
        layout_gravity="left|center",
        padding="16dp",
        layout_height="-2",
        gravity="center",
        id="myinfo"
      },
      sort("购买Sup会员"),
      {
        FrameLayout,
        -- layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function()
          if one_month_enabled==true then
            local edt=AlertDialog.Builder(this)
            -- .setCancelable(false)
            .setTitle("选择支付方式")
            .setItems({"微信","支付宝","QQ"}, function (d,n)
              if n==1 then
                payfs="alipay"
               elseif n==2 then
                payfs="qqpay"
               elseif n==0 then
                payfs="wxpay"
                toast("微信支付请复制链接发给自己然后点击链接支付")
              end
              购买商品(t1url,t1key,payfs,os.time()*100+math.random(1,99),"","30",[[{"user":"]]..activity.getSharedData("username")..[[","num":"1"}]],t1httk)
            end)
            local ed=edt.show()
            local pw=ed.getWindow()
            .setWindowAnimations(R.style.BottomDialog_Animation)
            --.setBackgroundDrawable(ColorDrawable(0))
            .setGravity(Gravity.BOTTOM)
            圆角(pw,背景色,{0,0,0,0,0,0,0,0})
            local lp=pw.getAttributes()
            lp.width=w
            pw.setAttributes(lp)
            pw.setDimAmount(0.35)
           elseif one_month_enabled==false then
            toast("已下架")
           else
            toast("请等待价格获取完成")
          end
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="一个月：获取价格中",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
          id="one_month_info";
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          --layout_alignParentRight=true,
          layout_width="24dp",
          layout_height="24dp",
          layout_gravity="center|right",
        },
      },
      {
        FrameLayout,
        -- layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          if three_month_enabled==true then
            local edt=AlertDialog.Builder(this)
            -- .setCancelable(false)
            .setTitle("选择支付方式")
            .setItems({"微信","支付宝","QQ"}, function (d,n)
              if n==1 then
                payfs="alipay"
               elseif n==2 then
                payfs="qqpay"
               elseif n==0 then
                payfs="wxpay"
                toast("微信支付请复制链接发给自己然后点击链接支付")
              end
              购买商品(t1url,t1key,payfs,os.time()*100+math.random(1,99),"","31",[[{"user":"]]..activity.getSharedData("username")..[[","num":"3"}]],t1httk)
            end)
            local ed=edt.show()
            local pw=ed.getWindow()
            .setWindowAnimations(R.style.BottomDialog_Animation)
            --.setBackgroundDrawable(ColorDrawable(0))
            .setGravity(Gravity.BOTTOM)
            圆角(pw,背景色,{0,0,0,0,0,0,0,0})
            local lp=pw.getAttributes()
            lp.width=w
            pw.setAttributes(lp)
            pw.setDimAmount(0.35)
           elseif three_month_enabled==false then
            toast("已下架")
           else
            toast("请等待价格获取完成")
          end
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="三个月：获取价格中",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
          id="three_month_info";
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          --layout_alignParentRight=true,
          layout_width="24dp",
          layout_height="24dp",
          layout_gravity="center|right",
        },
      },
      {
        FrameLayout,
        -- layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          if one_year_enabled==true then
            local edt=AlertDialog.Builder(this)
            -- .setCancelable(false)
            .setTitle("选择支付方式")
            .setItems({"微信","支付宝","QQ"}, function (d,n)
              if n==1 then
                payfs="alipay"
               elseif n==2 then
                payfs="qqpay"
               elseif n==0 then
                payfs="wxpay"
                toast("微信支付请复制链接发给自己然后点击链接支付")
              end
              购买商品(t1url,t1key,payfs,os.time()*100+math.random(1,99),"","33",[[{"user":"]]..activity.getSharedData("username")..[[","num":"12"}]],t1httk)
            end)
            local ed=edt.show()
            local pw=ed.getWindow()
            .setWindowAnimations(R.style.BottomDialog_Animation)
            --.setBackgroundDrawable(ColorDrawable(0))
            .setGravity(Gravity.BOTTOM)
            圆角(pw,背景色,{0,0,0,0,0,0,0,0})
            local lp=pw.getAttributes()
            lp.width=w
            pw.setAttributes(lp)
            pw.setDimAmount(0.35)
           elseif one_year_enabled==false then
            toast("已下架")
           else
            toast("请等待价格获取完成")
          end
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="一年：获取价格中",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
          id="one_year_info";
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          --layout_alignParentRight=true,
          layout_width="24dp",
          layout_height="24dp",
          layout_gravity="center|right",
        },
      },
      {
        TextView,
        text="",
        textSize="14sp",
        textColor=次要文字色,
        layout_gravity="left|center",
        padding="16dp",
        layout_height="-2",
        gravity="center|left",
        id="infom"
      },
      sort("账号操作"),
      {
        FrameLayout,
        -- layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function()
          showDialog("您确定要注销账户吗","该操作不可撤销！","注销账号","取消",function ()
            activity.setSharedData("username",nil)
            activity.setSharedData("password",nil)
            activity.setSharedData("vip_time",nil)
            activity.getActivity("soup").call("退出账号")
            activity.finish()
          end,nil,0xffff4500,nil,true,nil,nil,nil)
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="注销账号",
          textSize="16sp",
          textColor="#F44336",
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
        },
      },
    },
  },
  {
    LinearLayout,
    layout_width="fill",
    layout_height="56dp" ,
    foreground=上下渐变({背景色,深透,淡透}),
  },
}))

Http.get("http://t1.huayi-w.cn/user_all.json?key="..t1key.."&type=get_goods_info&goodsid=30&token="..MD5(t1key.."30"..t1httk),function(code,body,cookie,headers)
  if code==200 then
    data=cjson.decode(body)
    if data["code"]=="1" then
      one_month_info.Text="一个月："..data["money"]
      if data["zt"]=="下架" then
        one_month_enabled=false
        one_month_info.Text="一个月：暂时下架"
       else
        one_month_enabled=true
      end
     elseif data["code"]=="0" then
      toast(data["message"])
    end
   else
    toast("出现异常！")
  end
end)

Http.get("http://t1.huayi-w.cn/user_all.json?key="..t1key.."&type=get_goods_info&goodsid=31&token="..MD5(t1key.."31"..t1httk),function(code,body,cookie,headers)
  if code==200 then
    data=cjson.decode(body)
    if data["code"]=="1" then
      three_month_info.Text="三个月："..data["money"]
      if data["zt"]=="下架" then
        three_month_enabled=false
        three_month_info.Text="三个月：暂时下架"
       else
        three_month_enabled=true
      end
     elseif data["code"]=="0" then
      toast(data["message"])
    end
   else
    toast("出现异常！")
  end
end)

Http.get("http://t1.huayi-w.cn/user_all.json?key="..t1key.."&type=get_goods_info&goodsid=33&token="..MD5(t1key.."33"..t1httk),function(code,body,cookie,headers)
  if code==200 then
    data=cjson.decode(body)
    if data["code"]=="1" then
      one_year_info.Text="一年："..data["money"]
      if data["zt"]=="下架" then
        one_year_enabled=false
        one_year_info.Text="一年：暂时下架"
       else
        one_year_enabled=true
      end
     elseif data["code"]=="0" then
      toast(data["message"])
    end
   else
    toast("出现异常！")
  end
end)

function onStart()
  if activity.getSharedData("password")~=nil then
    登录账号(t1url,t1key,activity.getSharedData("username"),activity.getSharedData("password"),t1httk,function(返回值)
      if 返回值=="401" then
        toast("出现异常！")
       else
        data=cjson.decode(返回值)
        if data["code"]=="1" then
          myinfo.Text="我的会员状态："..data["vip_time"]
          activity.setSharedData("vip_time",data["vip_time"])
         elseif data["code"]=="0" then
          toast(data["message"])
        end
      end
    end)
  end
end


云文档获取(t1url,t1key,"kgegta",function(返回值)
  if 返回值=="401" then
   else
    data=cjson.decode(返回值)
    if data["code"]=="1" then
      infom.Text=Html.fromHtml(data["text"])
    end
  end
end)