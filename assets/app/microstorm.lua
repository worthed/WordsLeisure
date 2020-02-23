require "import"
import "str"

pid=...

rc4=import "mods.minicrypto"

import "android.support.v4.app.*"
import "android.support.v4.view.*"
import "android.support.v4.widget.*"

topbar_click=0

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
    onClick=function()
      if topbar_click+2 > tonumber(os.time()) then
        local scrollYu = ObjectAnimator.ofInt(loadb, "scrollY", {loadb.scrollY,0})
        scrollYu.setDuration(256)
        scrollYu.setInterpolator(DecelerateInterpolator());
        scrollYu.start()
       else
        topbar_click=tonumber(os.time())
      end
    end;
    {
      ImageView,
      src="drawable/back.png",
      layout_height="fill",
      layout_width="44dp",
      foreground=波纹(波纹色),
      onClick=function ()
        this.finish()
      end,
      padding="9dp",
      colorFilter=图标色,
    },
    {
      ImageView,
      src="drawable/dots.png",
      layout_height="fill",
      layout_width="44dp",
      foreground=波纹(波纹色),
      padding="9dp",
      colorFilter=图标色,
      layout_alignParentRight=true,
      onClick=function ()
        对话框操作()
      end,
    },
    {
      TextView,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      --layout_gravity="center",
      text="微风暴",
      textSize="20sp",
      textColor=文字色,
    },
  },
  {
    SwipeRefreshLayout;
    id="swipe1";
    layout_height="-1";
    layout_width="-1";
    {
      ScrollView,
      layout_height="-1";
      layout_width="-1";
      id="loadb";
      {
        LinearLayout,
        layout_width="fill",
        orientation="vertical",
        {
          LinearLayout,
          paddingTop="56dp" ,
        };
        {
          LinearLayout;
          orientation="vertical";
          layout_height="-1";
          layout_width="-1";
          {
            ImageView;
            layout_height=activity.Width/800*450;
            layout_width="-1";
            scaleType="centerCrop";
            id="pho_top";
          };
          {
            LinearLayout;
            orientation="vertical";
            layout_height="-1";
            layout_width="-1";
            padding="16dp";
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              gravity="center";
              textSize="14sp";
              textColor=次要文字色;
              background="#10000000";
              layout_marginBottom="16dp";
              text="长按标题收藏本篇，下滑刷新内容（点击此消息不再提示）";
              padding="8dp";
              id="czts";
            };
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              gravity="left|center";
              textSize="20sp";
              textColor=文字色;
              id="today_title";
              layout_marginBottom="12dp";
            };
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              gravity="left|center";
              textSize="14sp";
              textColor=次要文字色;
              id="today_author";
              layout_marginBottom="16dp";
            };
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              textSize="16sp";
              textColor=文字色;
              id="today_text";
              gravity="left|center";
              layout_marginBottom="16dp";
            };
          };
        };
      };
      --scroll
    },
  },
  {
    LinearLayout,
    layout_width="fill",
    layout_height="56dp" ,
    foreground=上下渐变({背景色,深透,淡透}),
  },
}))

function 对话框操作()
  local edt=AlertDialog.Builder(this)
  -- .setCancelable(false)
  .setTitle("选择操作")
  .setItems({"添加收藏","分享内容","复制内容"}, function (d,n)
    local hiscon=today_title.Text.."\n    "..today_text.Text
    if n==1 then
      if utf8.len(hiscon)<=100 then
        texta=utf8.sub(hiscon,1,utf8.len(hiscon)-1).."……"
       else
        texta=utf8.sub(hiscon,1,100).."……"
      end
      textn=texta.."\n（复制此消息，打开闲言APP阅读全文）\n&MS"..tostring(now_content).."&\nhttps://dwz.cn/AefmoSAc\n——闲言APP 最好的阅读平台"
      shareText(textn)
     elseif n==2 then
      copyText(hiscon.."\n    ——闲言APP 最好的阅读平台")
     elseif n==0 then
      io.open(句子收藏..os.time().."("..#hiscon..")","w+"):write([[{
soup=]].."[["..hiscon.."]]"..[[,
type=]].."[[微风暴]]"..[[,
}]]):close()
      toast ("已加收藏，可在灵感中管理")
    end
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
end

local aid={swipe1}
for i=1,#aid do
  aid[i].setProgressViewOffset(true,dp2px(56),dp2px(32+56))
  aid[i].setColorSchemeColors({文字色})
  aid[i].setProgressBackgroundColorSchemeColor(背景色)
end
aid=nil

today_text.setLineSpacing(48,0.5)

swipe1.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
    getToday()
  end})

now_content=1

function getToday()
  load_content=math.random(1,30690)
  swipe1.setRefreshing(true)
  local url="https://www.tipsoon.com/?c=article&id="..tostring(load_content)
  Http.get(url,"utf8",function(code,content)
    if code==200 then
      --content = JSON.decode(content)
      if content~="" then
        now_content=load_content
        today_title.Text=content:match("<div class=\"w90 pL5 pR5 pT4 pB1 fL\"(.-)</div>"):match(">(.+)")
        today_author.Text=content:match("<div class=\"w90 pL5 pR5 fL size12\"(.-)</div>"):match(">(.+)")
        today_text_html=content:match("<pre style=\"text%-align%:justify%;line%-height:30px\">(.-)</pre>")
        --today_text.Text=Html.fromHtml(today_text_html)
        today_text.Text=today_text_html
        --today_wc.Text=tostring(content.data.wc).."字"
        --today_date=content.data.date.curr
        if activity.getSharedData("vip_time")~=nil and activity.getSharedData("vip_time")~="已到期" and activity.getSharedData("vip_time")~="未开通" then
          pho_top.setImageBitmap(loadbitmap(content:match("<div class=\"cover w90 pD5 fL center\">(.-)</div>"):match("<img src=\"(.-)\" class")))
          pho_top.onClick=function()
          end
         else
          pho_top.setImageBitmap(loadbitmap(activity.getLuaDir().."/drawable/microstorm_nosup.jpg"))
          pho_top.onClick=function()
            if activity.getSharedData("password")~=nil then
              activity.newActivity("sup")
             else
              toast("请先登录")
              activity.newActivity("login",{"sup"})
            end
          end
        end
       else
        getToday()
      end
     else
      toast("请求数据失败")
      --today_date=nil
    end
    swipe1.setRefreshing(false)
    --checkIfStared()
  end)
end

if pid then
  load_content=pid
  swipe1.setRefreshing(true)
  local url="https://www.tipsoon.com/?c=article&id="..tostring(load_content)
  Http.get(url,"utf8",function(code,content)
    if code==200 then
      --content = JSON.decode(content)
      if content~="" then
        now_content=load_content
        today_title.Text=content:match("<div class=\"w90 pL5 pR5 pT4 pB1 fL\"(.-)</div>"):match(">(.+)")
        today_author.Text=content:match("<div class=\"w90 pL5 pR5 fL size12\"(.-)</div>"):match(">(.+)")
        today_text_html=content:match("<pre style=\"text%-align%:justify%;line%-height:30px\">(.-)</pre>")
        --today_text.Text=Html.fromHtml(today_text_html)
        today_text.Text=today_text_html
        --today_wc.Text=tostring(content.data.wc).."字"
        --today_date=content.data.date.curr
        if activity.getSharedData("vip_time")~=nil and activity.getSharedData("vip_time")~="已到期" and activity.getSharedData("vip_time")~="未开通" then
          pho_top.setImageBitmap(loadbitmap(content:match("<div class=\"cover w90 pD5 fL center\">(.-)</div>"):match("<img src=\"(.-)\" class")))
          pho_top.onClick=function()
          end
         else
          pho_top.setImageBitmap(loadbitmap(activity.getLuaDir().."/drawable/microstorm_nosup.jpg"))
          pho_top.onClick=function()
            if activity.getSharedData("password")~=nil then
              activity.newActivity("sup")
             else
              toast("请先登录")
              activity.newActivity("login",{"sup"})
            end
          end
        end
       else
        toast("文章暂时不可用,为您自动切换文章")
        getToday()
      end
     else
      toast("请求数据失败")
      --today_date=nil
    end
    swipe1.setRefreshing(false)
    --checkIfStared()
  end)
 else
  getToday()
end

today_title.onLongClick=function()
  对话框操作()
end

czts.onClick=function()
  czts.setVisibility(View.GONE)
  activity.setSharedData("microstormts","true")
end

if activity.getSharedData("microstormts")=="true" then
  czts.setVisibility(View.GONE)
end