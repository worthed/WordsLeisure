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
      LinearLayout,
      layout_width="-2",
      layout_height="-2" ,
      layout_alignParentRight=true,
      {
        ImageView,
        src="drawable/sort.png",
        layout_height="fill",
        layout_width="44dp",
        foreground=波纹(波纹色),
        padding="9dp",
        colorFilter=图标色,
        layout_marginRight="4dp";
        id="sx";
        onClick=function ()
          if activity.getSharedData("vip_time")~=nil and activity.getSharedData("vip_time")~="已到期" and activity.getSharedData("vip_time")~="未开通" then
            pop.show()
           else
            if activity.getSharedData("password")~=nil then
              toast("筛选字数功能为Sup会员专属")
              activity.newActivity("sup")
             else
              toast("筛选字数功能为Sup会员专属，请先登录")
              activity.newActivity("login",{"sup"})
            end
          end
        end;
      };
      {
        ImageView,
        src="drawable/dots.png",
        layout_height="fill",
        layout_width="44dp",
        foreground=波纹(波纹色),
        padding="9dp",
        colorFilter=图标色,
        id="more";
        onClick=function ()
          对话框操作()
        end,
      };
    },
    {
      TextView,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      --layout_gravity="center",
      text="超级阅读",
      textSize="20sp",
      textColor=文字色,
    },
  },
  {
    TextView;
    layout_width="-1";
    layout_height="-1";
    textSize="16sp";
    textColor=文字色;
    text="尊敬的Sup会员，正在为您挑选精选文章";
    gravity="center";
  };
  {
    SwipeRefreshLayout;
    id="swipe1";
    layout_width="-1";
    layout_height="-1";
    {
      ScrollView,
      layout_width="-1";
      layout_height="-1";
      backgroundColor=背景色;
      id="loadb";
      {
        LinearLayout,
        layout_width="-1";
        layout_height="-1";
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
            LinearLayout;
            orientation="vertical";
            layout_width="-1";
            layout_height="-1";
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
              gravity="center";
              textSize="20sp";
              textColor=文字色;
              id="random_title";
              layout_marginBottom="12dp";
            };
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              gravity="center";
              textSize="14sp";
              textColor=次要文字色;
              id="random_author";
              layout_marginBottom="16dp";
            };
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              textSize="16sp";
              textColor=文字色;
              id="random_text";
              layout_marginBottom="16dp";
            };
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              gravity="center";
              textSize="12sp";
              textColor=次要文字色;
              id="random_wc";
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

local aid={swipe1}
for i=1,#aid do
  aid[i].setProgressViewOffset(true,dp2px(56),dp2px(32+56))
  aid[i].setColorSchemeColors({文字色})
  aid[i].setProgressBackgroundColorSchemeColor(背景色)
end
aid=nil

random_text.setLineSpacing(48,0.5)

swipe1.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
    getRandom()
  end})

now_content=0

function getRandom()
  swipe1.setRefreshing(true)
  if zs==0 then
    loadb.setVisibility(View.VISIBLE)
   else
    loadb.setVisibility(View.GONE)
  end
  if zs==nil then
    zs=0
    loadb.setVisibility(View.VISIBLE)
  end
  local url="https://interface.meiriyiwen.com/article/random?dev=1"
  Http.get(url,"utf8",function(code,content)
    if code==200 then
      content = cjson.decode(content)
      now_content=(content.data.date.curr)
      random_title.Text=content.data.title
      random_author.Text=content.data.author
      random_text_html=content.data.content
      random_text.Text=Html.fromHtml(random_text_html)
      random_wc.Text=tostring(tointeger(content.data.wc)).."字"
      random_date=content.data.date.curr
      if zs==1 then
        if content.data.wc<500 then
          swipe1.setRefreshing(false)
          loadb.setVisibility(View.VISIBLE)
         else
          getRandom()
        end
       elseif zs==2 then
        if content.data.wc>=500 and content.data.wc<=2000 then
          swipe1.setRefreshing(false)
          loadb.setVisibility(View.VISIBLE)
         else
          getRandom()
        end
       elseif zs==3 then
        if content.data.wc>2000 then
          swipe1.setRefreshing(false)
          loadb.setVisibility(View.VISIBLE)
         else
          getRandom()
        end
       else
        swipe1.setRefreshing(false)
      end
     else
      toast("请求数据失败")
      random_date=nil
    end
  end)
end

if pid then
  load_content=pid
  swipe1.setRefreshing(true)
  local url="https://interface.meiriyiwen.com/article/day?dev=1&date="..tostring(load_content)
  Http.get(url,"utf8",function(code,content)
    if code==200 then
      content = cjson.decode(content)
      now_content=(content.data.date.curr)
      random_title.Text=content.data.title
      random_author.Text=content.data.author
      random_text_html=content.data.content
      random_text.Text=Html.fromHtml(random_text_html)
      random_wc.Text=tostring(tointeger(content.data.wc)).."字"
      random_date=content.data.date.curr
     else
      toast("请求数据失败")
      random_date=nil
    end
    swipe1.setRefreshing(false)
  end)
 else
  getRandom()
end

pop=PopupMenu(activity,sx)
menu=pop.Menu
menu.add("默认").onMenuItemClick=function(a)
  zs=0
end
menu.add("500字以下").onMenuItemClick=function(a)
  zs=1
end
menu.add("500~2000字").onMenuItemClick=function(a)
  zs=2
end
menu.add("2000字以上").onMenuItemClick=function(a)
  zs=3
end

function 对话框操作()
  local edt=AlertDialog.Builder(this)
  -- .setCancelable(false)
  .setTitle("选择操作")
  .setItems({--[["添加收藏",]]"分享内容","复制内容"}, function (d,n)
    local hiscon=random_title.Text.."\n    "..random_text.Text
    if n==0 then
      if utf8.len(hiscon)<=100 then
        texta=utf8.sub(hiscon,1,utf8.len(hiscon)-1).."……"
       else
        texta=utf8.sub(hiscon,1,100).."……"
      end
      textn=texta.."\n（复制此消息，打开闲言APP阅读全文）\n&SR"..tostring(now_content).."&\nhttps://dwz.cn/AefmoSAc\n——闲言APP 最好的阅读平台"
      shareText(textn)
     elseif n==1 then
      copyText(hiscon.."\n    ——闲言APP 最好的阅读平台")
      --[==[elseif n==0 then
            io.open(句子收藏..os.time().."("..#hiscon..")","w+"):write([[{
soup=]].."[["..hiscon.."]]"..[[,
type=]].."[[".."超级阅读".."]]"..[[,
}]]):close()
            toast ("已加收藏，可在灵感中管理")]==]
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

random_title.onLongClick=function()
  对话框操作()
end

czts.onClick=function()
  czts.setVisibility(View.GONE)
  activity.setSharedData("superreadingts","true")
end

if activity.getSharedData("superreadingts")=="true" then
  czts.setVisibility(View.GONE)
end