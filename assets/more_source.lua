require "import"
import "str"

mrpg=1
xypg=1
ycpg=1
mwpg=1
jtpg=1

hislay={
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  padding="16dp",
  {
    TextView,
    textColor=文字色,
    --gravity="center",
    id="nr",
    textSize="18sp",
    paddingBottom="8dp",
  },
  {
    FrameLayout,
    layout_width="fill",
    {
      TextView,
      textColor=次要文字色,
      id="aut",
      textSize="18sp",
    },
    {
      TextView,
      textColor=次要文字色,
      --gravity="center",
      id="fm",
      layout_gravity="right|center",
      textSize="18sp",
    },
  },
}

hslay={
  TextView,
  textColor=文字色,
  layout_width="fill",
  id="nr",
  textSize="18sp",
  padding="16dp",
}

mrmy=LuaAdapter(this,{},hislay)
xy=LuaAdapter(this,{},hislay)
ycjz=LuaAdapter(this,{},hslay)
mwyz=LuaAdapter(this,{},hislay)
xljt=LuaAdapter(this,{},hslay)
adplist={mwyz,xljt}

长按={
  onItemLongClick=function (p,v)
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems({"制作壁纸","添加收藏","分享内容","复制内容"}, function (d,n)
      local hiscon=v.getChildAt(0).text.."  -- "..v.getChildAt(1).getChildAt(0).text..v.getChildAt(1).getChildAt(1).text
      if n==0 then
        toast ("正在前往编辑页面")
        this.newActivity("soup",{hiscon})
       elseif n==2 then
        shareText(hiscon.."\n    ——闲言APP 最好的阅读平台")
       elseif n==3 then
        copyText(hiscon.."\n    ——闲言APP 最好的阅读平台")
       elseif n==1 then
        io.open(句子收藏..os.time().."("..#hiscon..")","w+"):write([[{
soup=]].."[["..hiscon.."]]"..[[,
type=]].."[["..cursort.."]]"..[[,
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
    return true
  end}

长按2={
  onItemLongClick=function (p,v)
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems({"制作壁纸","添加收藏","分享内容","复制内容","删除"}, function (d,n)
      local hiscon=v.text
      if n==0 then
        toast ("正在前往编辑页面")
        this.newActivity("soup",{hiscon})
       elseif n==2 then
        shareText(hiscon.."\n    ——闲言APP 最好的阅读平台")
       elseif n==3 then
        copyText(hiscon.."\n    ——闲言APP 最好的阅读平台")
       elseif n==1 then
        io.open(句子收藏..os.time().."("..#hiscon..")","w+"):write([[{
soup=]].."[["..hiscon.."]]"..[[,
type=]].."[["..cursort.."]]"..[[,
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
    return true
  end}

单击={
  onItemClick=function (p,v)
    长按.onItemLongClick(p,v)
  end}

单击2={
  onItemClick=function (p,v)
    长按2.onItemLongClick(p,v)
  end}

this.setContentView(loadlayout ({
  LinearLayout,
  backgroundColor=背景色,
  paddingTop=状态栏高度,
  orientation="vertical",
  {
    RelativeLayout,
    layout_width="fill",
    layout_height="56dp",
    gravity="center",
    padding="16dp",
    --elevation="1%w",
    paddingTop="8dp",
    paddingBottom="8dp",
    {
      ImageView,
      src="drawable/back.png",
      layout_height="fill",
      ColorFilter=图标色,
      layout_width="44dp",
      foreground=波纹(波纹色),
      onClick=function ()
        this.finish()
      end,
      padding="9dp",
    },
    {
      TextView,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      --layout_gravity="center",
      text="更多句子源",
      textSize="20sp",
      textColor=文字色,
    },
  },
  {
    HorizontalScrollView,
    horizontalScrollBarEnabled=false,
    {
      LinearLayout,
      id="hissorts",
      {
        TextView,
        padding="8dp",
        textColor=文字色,
        --layout_width="14dp",
        onClick=function (v)
          if #adplist>2 then
            spage.showPage(3)
           else
            spage.showPage(0)
          end
        end,
        foreground=波纹(波纹色),
        text="美文驿站",
        gravity="center",
        paddingLeft="22dp",
        paddingRight="22dp",
      },
      {
        TextView,
        padding="8dp",
        onClick=function (v)
          if #adplist>2 then
            spage.showPage(4)
           else
            spage.showPage(1)
          end
        end,
        foreground=波纹(波纹色),
        text="心灵鸡汤",
        textColor=文字色,
        --  layout_width="14dp",
        gravity="center",
        paddingLeft="22dp",
        paddingRight="22dp",
      },
    },
  },
  {
    RelativeLayout,
    {
      PageView,
      -- currentItem=1,
      onPageChangeListener={
        onPageSelected=function (p)
          curp=p+1
          for s=0,4 do
            (hissorts.getChildAt(s) or hissorts.getChildAt(0)).setAlpha(0.5)
          end
          (hissorts.getChildAt(p) or hissorts.getChildAt(0)).setAlpha(1)
          cursort=(hissorts.getChildAt(p) or hissorts.getChildAt(0)).text
          hissorts.Parent.smoothScrollTo((hissorts.getChildAt(p) or hissorts.getChildAt(0)).left,0)
          if (adplist[p+1] or adplist[#adplist]).getCount()>0 then
            nolog.setVisibility(8)
           else
            nolog.setVisibility(0)
          end
          -- toast(#adplist)
        end},
      id="spage",
      pages={
        {
          PullingLayout,
          PullUpEnabled=true,
          id="mwpull",
          {
            ListView,
            layout_width="fill",
            onItemLongClickListener=长按,
            adapter=mwyz,
            OnItemClickListener=单击,
            dividerHeight=38,
            divider=ColorDrawable(0x00000000),
            fastScrollEnabled=true,
          },
        },
        {
          PullingLayout,
          PullUpEnabled=true,
          id="jtpull",
          {
            ListView,
            layout_width="fill",
            onItemLongClickListener=长按2,
            adapter=xljt,
            OnItemClickListener=单击2,
            dividerHeight=38,
            divider=ColorDrawable(0x00000000),
            fastScrollEnabled=true,
          },
        },
      },
    },
    {
      LinearLayout,
      id="nolog",
      orientation="vertical",
      --visibility=4,
      layout_width='fill',
      layout_height="fill",
      gravity="center",
      {
        ImageView,
        src="drawable/history_empty.png",
        layout_width='fill',
        ColorFilter=图标色,
        layout_height="195dp",
        --adjustViewBounds=true,
        padding="32dp",
      },
      {
        TextView,
        layout_gravity="center",
        text="无内容",
        textColor=次要文字色,
        textSize="22sp",
      },
    },
  },
}))

toast("数据加载中")

function loadXinYv()
  Http.get("https://m.juzimi.com/recommend?page="..xypg, function (c,n)
    if c==200 then
      local n=n:gmatch([[<div class="views%-field%-phpcode">(.-)<div class="views%-row views%-row%-]])
      for k in n do
        local k=k:gsub("<br/>","\n")
        local w=k:match([[class="xlistju">(.-)</a></div><div class="xqjulistwafo">]])
        local a=k:match([[rel="tag" title="原作者：(.-)" class="views%-field%-field%-oriwriter%-value]])
        local f=k:match([[rel="tag" title="出自(.-)" class="active">]])
        local o=k:match([[<span class="xqjulistori" title="(.-)"><span class="xqfulunvis">]])
        if w then
          xy.add{
            nr=w,
            aut=f or "",
            fm=a or o or "",
          }
        end
      end
      xypg=xypg+1
      xy.notifyDataSetChanged()
      if curp==4 then
        if xy.getCount()>0
          nolog.setVisibility(8)
         else
          nolog.setVisibility(0)
        end
      end
      xypull.loadmoreFinish(0)
     else
      xypull.loadmoreFinish(1)
      --print(c,"心语")
    end
  end)
end

function loadJiTang()
  Http.get("http://m.59xihuan.cn/index.php?PageNo="..jtpg, function (c,con)
    if c==200 then
      local n=con:match([[列表标题(.-)dede_pages]])
      local n=n:gmatch([[2rem;">(.-)<p]])
      for k in n do
        local k=k:gsub("                            ",""):gsub("                        ",""):gsub("\n","")
        if k and utf8.len(k or "")<=162 then
          xljt.add{
            nr=k,
          }
        end
      end
      jtpg=jtpg+1
      xljt.notifyDataSetChanged()
      if curp==1 then
        if xljt.getCount()>0
          nolog.setVisibility(8)
         else
          nolog.setVisibility(0)
        end
      end
      jtpull.loadmoreFinish(0)
     else
      jtpull.loadmoreFinish(1)
      --toast(c,n)
    end
  end)
end

function loadMingYan()
  Http.get("https://m.juzimi.com/hotfamsen?page="..mrpg, function (c,n)
    if c==200 then
      local n=n:gmatch([[<div class="views%-field%-phpcode">(.-)<div class="views%-row views%-row%-]])
      for k in n do
        local k=k:gsub("<br/>","\n")
        local w=k:match([[class="xlistju">(.-)</a></div><div class="xqjulistwafo">]])
        local a=k:match([[class="views%-field%-field%-oriwriter%-value">(.-)</a><span class="views%-field%-field%-oriarticle%-value">]])
        local f=k:match([[rel="tag" title="出自(.-)" class="active">]])
        local o=k:match([[rel="tag" title="原作者：(.-)" class="views%-field%-field%-oriwriter]])
        if w then
          mrmy.add{
            nr=w,
            aut=f or "",
            fm=a or o or "",
          }
        end
      end
      mrpg=mrpg+1
      mrmy.notifyDataSetChanged()
      if curp==3 then
        if mrmy.getCount()>0
          nolog.setVisibility(8)
         else
          nolog.setVisibility(0)
        end
      end
      mrpull.loadmoreFinish(0)
     else
      mrpull.loadmoreFinish(1)
      --print(c,"名人名言")
    end
  end)
end

function loadYuanChuang()
  Http.get("https://m.juzimi.com/original/recommend?page="..ycpg, function (c,n)
    if c==200 then
      local n=n:gmatch([[<div class="views%-field%-phpcode">(.-)<div class="views%-row views%-row%-]])
      for k in n do
        local k=k:gsub("<br/>","\n")
        local w=k:match([[class="xlistju">(.-)</a></div><div class="xqjulistwafo">]])
        if w and utf8.len(w or "")<=162 then
          ycjz.add{
            nr=w,
          }
        end
      end
      ycpg=ycpg+1
      ycjz.notifyDataSetChanged()
      if curp==2 then
        if ycjz.getCount()>0
          nolog.setVisibility(8)
         else
          nolog.setVisibility(0)
        end
      end
      ycpull.loadmoreFinish(0)
     else
      ycpull.loadmoreFinish(1)
      --print(c,"原创")
    end
  end)
end

function loadMeiWen()
  Http.get("https://www.meiwenyizhan.com/page/"..mwpg, function (c,n)
    if c==200 then
      local n=n:gmatch([[<i class="label%-arrow">(.-)</p> </div> </div> <div class="kratos%-post%-meta%-new"]])
      for k in n do
        if not k:find"&hellip;" then
          local t=k:match([[/">(.-)</a></h2> </header> <div class="]])
          local k=k:match([["> <p>(.+)]]):gsub("<br/>","\n"):gsub("&nbsp;"," ")
          if k then
            mwyz.add{
              nr=k:match("(.-) ——") or k,
              fm=k:match(" ——(.+)") or t or "",
            }
          end
        end
      end
      mwpg=mwpg+1
      mwyz.notifyDataSetChanged()
      if curp==0 then
        if mwyz.getCount()>0
          nolog.setVisibility(8)
         else
          nolog.setVisibility(0)
        end
      end
      mwpull.loadmoreFinish(0)
     else
      mwpull.loadmoreFinish(1)
      --toast(c,n)
    end
  end)
end

loadJiTang()
loadMeiWen()

jtpull.onLoadMore=function ()
  loadJiTang()
end

mwpull.onLoadMore=function ()
  loadMeiWen()
end

Http.get("https://m.juzimi.com/original/", function (c,n)
  --toast(c,n)
  if c~=200 and (n:find("停止访问") or c>=400) then
    -- showDialog("部分栏目暂不可用","提供 心语、名人名言和原创句子 内容的网站发生问题，无法加载内容。","好的")
   else
    local sa=spage.getAdapter()
    sa.add(loadlayout ( {
      PullingLayout,
      PullUpEnabled=true,
      id="ycpull",
      {
        ListView,
        layout_width="fill",
        onItemLongClickListener=长按2,
        adapter=ycjz,
        OnItemClickListener=单击2,
        dividerHeight=38,
        divider=ColorDrawable(0x00000000),
        fastScrollEnabled=true,
      },
    }))
    sa.add(loadlayout ( {
      PullingLayout,
      PullUpEnabled=true,
      id="mrpull",
      {
        ListView,
        layout_width="fill",
        onItemLongClickListener=长按,
        adapter=mrmy,
        OnItemClickListener=单击,
        dividerHeight=38,
        divider=ColorDrawable(0x00000000),
        fastScrollEnabled=true,
      },
    }))
    sa.add(loadlayout ( {
      PullingLayout,
      PullUpEnabled=true,
      id="xypull",
      {
        ListView,
        layout_width="fill",
        onItemLongClickListener=长按,
        adapter=xy,
        OnItemClickListener=单击,
        dividerHeight=38,
        divider=ColorDrawable(0x00000000),
        fastScrollEnabled=true,
      },
    }))
    loadXinYv()
    loadMingYan()
    loadYuanChuang()
    xypull.onLoadMore=function ()
      loadXinYv()
    end
    mrpull.onLoadMore=function ()
      loadMingYan()
    end
    ycpull.onLoadMore=function ()
      loadYuanChuang()
    end
    hissorts.addView(loadlayout ( {
      TextView,
      -- layout_width="14dp",
      text="原创句子",
      padding="8dp",
      paddingLeft="22dp",
      paddingRight="22dp",
      textColor=文字色,
      onClick=function (v)
        spage.showPage(2)
      end,
      gravity="center",
      foreground=波纹(波纹色),
    }),2)
    hissorts.addView(loadlayout ( {
      TextView,
      -- layout_width="14dp",
      text="名人名言",
      padding="8dp",
      paddingLeft="22dp",
      paddingRight="22dp",
      textColor=文字色,
      onClick=function (v)
        spage.showPage(3)
      end,
      gravity="center",
      foreground=波纹(波纹色),
    }),3)
    hissorts.addView(loadlayout ( {
      TextView,
      padding="8dp",
      onClick=function (v)
        spage.showPage(4)
      end,
      foreground=波纹(波纹色),
      text="心语",
      textColor=文字色,
      --  layout_width="14dp",
      gravity="center",
      paddingLeft="22dp",
      paddingRight="22dp",
    }),4)
    adplist={mwyz,xljt,ycjz,mrmy,xy}
    spage.showPage(1)
    spage.showPage(0)
  end
end)