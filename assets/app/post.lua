require "import"
import "str"
import "com.michael.NoScrollListView"

--http://www.agyer.xyz/index.php/archives/1/#respond-post-1
tiezi=...
if tiezi:sub(#tiezi,#tiezi)~="/" then
  tiezi=tiezi.."/"
end
postnum=tiezi:match("archives/(.-)/")
tocomment=tiezi.."#respond-post-"..postnum
--toast(tocomment)

longclickmenu={
  onItemLongClick=function (p,v,i)
    local jz=v.getChildAt(1).text
    if title.text=="句子收录" then
      menuitem={"制作壁纸","添加收藏","分享内容","复制内容"}
     else
      menuitem={"分享内容","复制内容"}
    end
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems(menuitem, function (g,n)
      local cont=v.getChildAt(1).text
      local type=v.getChildAt(2).text
      local d=menuitem[n+1]
      -- toast(d)
      local s=cont.."    -- 来自 "..v.getChildAt(0).getChildAt(0).text.." 在帖子 "..title.text.." 里的评论\n"..tiezi.." 点击链接查看详情"
      if d=="制作壁纸" then
        toast ("正在前往编辑页面")
        this.newActivity("soup",{cont})
       elseif d=="添加收藏" then
        io.open(句子收藏..os.time().."_"..math.random(1,100),"w+"):write([[{
soup=]].."[["..cont.."]]"..[[,
type=]].."[["..type.."]]"..[[,
}]]):close()
        toast ("已加收藏，可在灵感中查看")
       elseif d=="分享内容" then
        shareText(s)
       elseif d=="复制内容" then
        copyText(s)
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
    return true
  end}

cms=LuaAdapter(this,{},{
  LinearLayout,
  layout_width="fill",
  orientation="vertical",
  padding="16dp",
  {
    FrameLayout,
    layout_width="fill",
    paddingBottom="8dp",
    {
      TextView,
      id="user",
      textColor=次要文字色,
      textSize="14sp",
      --  layout_gravity="left|center",
    },
    {
      TextView,
      id="tim",
      textColor=次要文字色,
      textSize="14sp",
      layout_gravity="right|center",
    },
  },
  {
    TextView,
    id="pl",
    textColor=文字色,
    textSize="16sp",
    -- textIsSelectable=true,
    -- paddingBottom="8dp",
    layout_gravity="left|center",
  },
  {
    TextView,
    id="fl",
    textColor=次要文字色,
    textSize="14sp",
    layout_gravity="right|center",
  },
})

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
    LinearLayout,
    layout_width="fill",
    elevation="2dp",
    layout_height="56dp" ,
    foreground=上下渐变({背景色,深透,淡透}),
  },
  {
    RelativeLayout,
    layout_width="fill",
    layout_height="56dp" ,
    gravity="center",
    padding="16dp",
    --backgroundColor=0xffffffff,
    paddingTop="8dp",
    paddingBottom="8dp",
    elevation="2dp",
    {
      ImageView,
      src="drawable/back.png",
      layout_height="fill",
      layout_width="44dp" ,
      foreground=波纹(波纹色),
      onClick=function ()
        this.finish()
      end,
      colorFilter=图标色,
      padding="9dp",
    },
    {
      ImageView,
      src="drawable/share.png",
      layout_height="fill",
      layout_width="44dp" ,
      foreground=波纹(波纹色),
      onClick=function (v)
        shareText(title.text.."\n"..tiezi.."\n点击链接查看帖子详情\n    ——闲言APP 最好的阅读平台")
      end,
      id="tiezishare",
      visibility=8,
      colorFilter=图标色,
      padding="9dp",
      layout_alignParentRight=true,
    },
    {
      TextView,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      id="title",
      paddingLeft="52dp",
      paddingRight="52dp",
      singleLine=true,
      ellipsize="end",
      textSize="20sp",
      text="帖子查看",
      textColor=文字色,
    },
  },
  {
    ScrollView,
    layout_width="fill",
    {
      LinearLayout,
      orientation="vertical",
      layout_width="fill",
      {
        FrameLayout,
        layout_width="fill",
        paddingTop="56dp" ,
        {
          TextView,
          id="postauth",
          textSize="12sp",
          paddingLeft="24dp",
          textColor=次要文字色,
        },
        {
          TextView,
          id="posttime",
          paddingRight="24dp",
          textSize="12sp",
          textColor=次要文字色,
          layout_gravity="right|center",
        },
      },
      {
        FrameLayout,
        layout_width="fill",
        --backgroundColor=0xffffffff,
        --elevation="0.25%w",
        {
          ImageView,
          src="drawable/comment.png",
          alpha=0.25,
          rotationY=180,
          adjustViewBounds=true,
          layout_width=w/2,
          colorFilter=淡色,
          layout_height=w/2,
          layout_gravity="right|bottom",
          layout_marginRight="8dp",
          layout_marginBottom="-32dp",
        },
        {
          TextView,
          textColor=文字色,
          textSize="18sp",
          id="content",
          textIsSelectable=true,
          text="帖子内容加载中...",
          padding="24dp",
          paddingBottom="48dp",
        },
      },
      {
        LinearLayout,
        layout_width="fill",
        layout_height=15,
        foreground=ColorDrawable(0x10000000),
      },
      {
        LinearLayout,
        id="nocm",
        orientation="vertical",
        visibility=8,
        layout_width='fill',
        layout_height=w,
        --paddingTop=lay_wh,
        gravity="center",
        {
          ImageView,
          src="drawable/history_empty.png",
          layout_width='fill',
          colorFilter=文字色,
          layout_height=w/5*3,
          --adjustViewBounds=true,
          padding="24dp",
        },
        {
          TextView,
          layout_gravity="center",
          text="无评论",
          textColor=次要文字色,
          textSize="22sp",
        },
      },
      {
        NoScrollListView,
        --paddingTop="16dp",
        layout_marginBottom="56dp" ,
        id="comment_list",
        adapter=cms,
        layout_width="fill",
        -- footerDividersEnabled=false,
        -- headerDividersEnabled=true,
        dividerHeight=38,
        divider=ColorDrawable(0x00000000),
        -- divider=ColorDrawable(0x10000000),
        layout_height="fill",
        onItemClickListener={
          onItemClick=function (p,v,i)
            local jz=v.getChildAt(1).text
            --[[if title.text=="句子收录" then
toast ("正在前往编辑页面")
 this.newActivity("soup",{jz})
else]]
            longclickmenu.onItemLongClick(p,v,i)
            --end
          end},
        onItemLongClickListener=longclickmenu,
        -- horizontalScrollBarEnabled=false,
      },
    },
  },
  --[[{
 LuaWebView,
 id="web",
visibility=8,
layout_width="fill",
layout_height=w,
},]]
  {
    FrameLayout,
    layout_alignParentBottom=true,
    elevation="24dp",
    layout_width="fill",
    layout_height="48dp",
    visibility=8,
    backgroundColor=背景色,
    {
      TextView,
      text="正在加载信息，稍候便可进行评论回复",
      textColor=次要文字色,
      layout_width="fill",
      foreground=波纹(波纹色),
      onClick=function ()
        web.reload()
      end,
      gravity="center",
      layout_gravity="center",
      textSize="14sp",
    },
    {
      FrameLayout,
      id="writemsg",
      --visibility=4,
      backgroundColor=背景色,
      --paddingLeft="3%w",
      paddingRight="16dp",
      paddingLeft="16dp",
      foreground=波纹(波纹色),
      onClick=function ()
        InAppBrowser(tocomment,"评论帖子",[[{
  onPageStarted=function (v,u)
err.visibility=8
title.text=v.title
sslerr.visibility=8
 if u:sub(1,4)~="http" and u:sub(1,10)~="javascript" then
    --v.stopLoading()
   v.goBack()
      showDialog("外部应用","网站请求打开外部应用，是否打开？","打开","取消", function ()
      openInBrowser(u)
     end)
  elseif u:sub(1,4)=="http" then
 local pref=this.getSharedPreferences("Cookie",0)
 local domain=Uri.parse(u).host
  --toast (domain.host)
CookieManager.getInstance().setCookie(domain,pref.getString(domain,""))
    end
    onPause()
  end,
  onPageFinished=function (v,u)
title.text=v.title
   if u:sub(1,4)=="http" then
  local perf=this.getSharedPreferences("Cookie",0)
 local domain=Uri.parse(u).host
 --toast (domain.host)
 perf.edit().putString(domain,CookieManager.getInstance().getCookie(domain)).apply()
   end
    onPause()
  end,
  shouldOverringUrlLoading=function (v,u)
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
errde.text=tostring (e)
title.text=v.title
end}]])
      end,
      layout_width="fill",
      {
        LinearLayout,
        layout_height="48dp",
        gravity="center",
        {
          ImageView,
          src="drawable/pencil.png",
          layout_width="24dp",
          layout_height="24dp",
          layout_gravity="center",
          padding="2.5dp",
          colorFilter=图标色,
        },
        {
          TextView,
          text="前往网页版写评论回复...",
          gravity="center",
          layout_gravity="center",
          textColor=次要文字色,
          textSize="14sp",
          paddingLeft="4dp",
        },
      },
      {
        LinearLayout,
        layout_gravity="right|center",
        {
          ImageView,
          src="drawable/quote.png",
          layout_width="24dp",
          layout_height="24dp",
          colorFilter=图标色,
          layout_gravity="center",
          padding="2.5dp",
        },
        {
          TextView,
          id="people",
          gravity="center",
          layout_gravity="center",
          textColor=次要文字色,
          paddingLeft="4dp",
          textSize="14sp",
        },
      },
    },
  },
}))

function getPostContent()
  Http.get(tiezi, function (c,cn)
    if c==200 then
      cms.clear()
      local tit=cn:match("title>(.-)</title"):match("(.-) %-")
      title.text=tit or "未知帖子"
      local msg=cn:match("articleBody(.-)keywords"):gsub("<p>",""):gsub("</p>",""):gsub("<br />",""):gsub("<br>",""):gsub("<br/>",""):gsub([[">
            ]],""):gsub([[

        </div>
        <p itemprop="]],""):gsub([[<a href="]],""):gsub([[">]],""):gsub([[</a>]],"")
      content.text=msg or "这条帖子走丢了"
      local auth=cn:match([[rel="author">(.-)</a></li>]])
      postauth.text="By "..auth or "unknown"
      local ftsj=cn:match([[itemprop="datePublished">(.-)</time></li>]])
      posttime.text=ftsj or "404"
      local 评论部分=cn:gmatch("comment%-author(.-)comment%-reply")
      for p in 评论部分 do
        local p=(p or ""):gsub("<br />","\n"):gsub("<br>",""):gsub("<br/>",""):gsub("<p>",""):gsub("</p>","\n")
        local p=p.."comment-reply"
        local d=p:match([[datetime(.-)</time></a>]]):match([[>(.+)]]):gsub("st,",","):gsub("nd,",","):gsub("th,",","):gsub(" at",",")
        local u=p:match([[alt="(.-)" width="32"]])
        local com=p:match("commentText(.-)comment%-reply"):match([[">
    (.-)
    </div]])
        --toast (com)
        local fenlei=com:match("句子分类%[(.-)%]") or ""
        cms.add{
          pl=com:gsub(fenlei,""):gsub("句子分类%[%]","") or com,
          user=u,
          tim=d,
          fl=fenlei,
        }
      end
      writemsg.Parent.visibility=0
      cms.notifyDataSetChanged()
      local 条数=cms.getCount()
      people.text=""..条数
      --writemsg.visibility=0
      tiezishare.visibility=0
      if 条数>0 then
        nocm.visibility=8
       else
        nocm.visibility=0
      end
      --[[local totalHeight = 0
      for i = 0,条数 do
        listItem = cms.getView(i, nil, comment_list)
        listItem.measure(0, 0)
        totalHeight=totalHeight+listItem.getMeasuredHeight()+comment_list.getDividerHeight()
      end
      local lp=comment_list.getLayoutParams()
      lp.height=totalHeight+comment_list.getDividerHeight()*条数
      comment_list.setLayoutParams(lp)]]
      -- comment_list.Parent.Parent.smoothScrollTo(0,0)
    end
  end)
end

--[[web.setWebViewClient(LuaWebViewClient(webClient or {
  onPageStarted=function (v,u)
     if u~=tiezi and not u:find("javascript") then
--v.loadUrl(tiezi)
--toast ("start reloading")
    end
 loadFinished=false
writemsg.visibility=4
    onPause()
  end,
  onPageFinished=function (v,u)
  if u~=tiezi then
--v.loadUrl(tiezi)
--toast ("finished reloading")
writemsg.visibility=4
else
loadFinished=true
writemsg.visibility=0
    end
    onPause()
  end,
  shouldOverringUrlLoading=function (v,u)
   if u~=tiezi and not u:find("javascript") then
--v.stopLoading()
toast ("override stopped")
    end
  end}))
web.setDownloadListener{onDownloadStart=function() end}
web.loadUrl(tiezi)]]

getPostContent()

function write_comment_dialog()
  local edt=AlertDialog.Builder(this)
  .setTitle("评论回复")
  .setCancelable(false)
  .setView(loadlayout ({
    ScrollView,
    layout_width="fill",
    {
      LinearLayout,
      padding="20dp",
      paddingBottom=0,
      layout_width="fill",
      orientation="vertical",
      layout_width="fill",
      {
        LinearLayout,
        --padding="6.5%w",
        paddingBottom="8dp",
        layout_width="fill",
        orientation="vertical",
        layout_width="fill",
        {
          TextView,
          text="昵称",
          textColor=0xff444444,
          textSize="16sp",
          --gravity="top|center",
          --layout_gravity="top|center",
          layout_height="fill",
          paddingRight="16dp",
        },
        {
          EditText,
          layout_width="fill",
          textColor=0xff000000,
          backgroundColor=0,
          textSize="16sp",
          singleLine=true,
          inputType="textPersonName",
          id="uname",
          text=名 or "",
          hint="闲言用户",
        },
      },
      {
        LinearLayout,
        -- padding="6.5%w",
        paddingBottom="8dp",
        layout_width="fill",
        orientation="vertical",
        layout_width="fill",
        {
          TextView,
          text="邮箱",
          textColor=0xff444444,
          textSize="16sp",
          --gravity="top|center",
          --layout_gravity="top|center",
          layout_height="fill",
          paddingRight="16dp",
        },
        {
          EditText,
          layout_width="fill",
          textColor=0xff000000,
          backgroundColor=0,
          textSize="16sp",
          singleLine=true,
          id="uemail",
          inputType="textEmailAddress",
          --digits="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-@",
          hint="输入邮箱地址，可不填",
          text=邮箱 or "",
        },
      },
      {
        LinearLayout,
        --padding="6.5%w",
        paddingBottom="8dp",
        layout_width="fill",
        orientation="vertical",
        layout_width="fill",
        {
          TextView,
          text="网址",
          textColor=0xff444444,
          textSize="16sp",
          --gravity="top|center",
          --layout_gravity="top|center",
          layout_height="fill",
          paddingRight="16dp",
        },
        {
          EditText,
          layout_width="fill",
          textColor=0xff000000,
          text=网站 or "",
          backgroundColor=0,
          textSize="16sp",
          id="ulink",
          inputType="textUri",
          hint="http(s)://\n输入个人网站地址，可不填",
        },
      },
      {
        TextView,
        text="评论内容",
        textColor=0xff444444,
        textSize="16sp",
        --gravity="top|center",
        --layout_gravity="top|center",
        layout_height="fill",
        paddingRight="16dp",
      },
      {
        EditText,
        layout_width="fill",
        textColor=0xff000000,
        backgroundColor=0,
        text=评论 or "",
        textSize="16sp",
        id="ucomm",
        hint="输入评论回复\n不相关的内容将会被删除",
      },
    },
  }))
  .setPositiveButton("发送评论", function ()
    local cont=ucomm.text
    local ema=uemail.text
    local nm=uname.text
    if nm=="" then
      nm="闲言用户"
    end
    local lk=ulink.text
    web.loadUrl([[javascript:
var edt=document.getElementsByClassName("text");
edt[1].value="]]..nm..[[";
edt[2].value="]]..ema..[[";
edt[3].value="]]..lk..[[";
var ta=document.getElementsByClassName("textarea");
ta[0].value="]]..cont..[[";
var sub=document.getElementsByClassName("submit");
sub[1].click();
]])
    --[[
document.getElementById("comment-form").submit();
]]
    getPostContent()
    onPause()
  end)
  .setNegativeButton("取消",nil)
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
  uemail.addTextChangedListener({
    onTextChanged=function(s,start,before,count)
      if #s>0 then
        if not tostring(s):find("@") then
          uemail.error="邮箱地址中缺少@字符"
         else
          邮箱=tostring(s)
        end
      end
    end})
  ulink.addTextChangedListener({
    onTextChanged=function(s,start,before,count)
      if #s>0 then
        if not tostring(s):find("httl") then
          ulink.error="网站地址中缺少http://"
         else
          网站=tostring(s)
        end
      end
    end})
  uname.addTextChangedListener({
    onTextChanged=function(s,start,before,count)
      if #s<1 then
        uname.text="闲言用户"
      end
      名=uname.text
    end})
  ucomm.addTextChangedListener({
    onTextChanged=function(s,start,before,count)
      if #s>0 then
        评论=tostring(s)
      end
    end})
end