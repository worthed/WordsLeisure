require "import"
import "str"

hslay={
  TextView,
  textColor=文字色,
  layout_width="fill",
  id="nr",
  textSize="18sp",
  padding="16dp",
}

bingjia=LuaAdapter(this,{},hslay)
shijia=LuaAdapter(this,{},hslay)
hunjia=LuaAdapter(this,{},hslay)
chanjia=LuaAdapter(this,{},hslay)
sangjia=LuaAdapter(this,{},hslay)
gongxiujia=LuaAdapter(this,{},hslay)
adplist={bingjia,shijia,hunjia,chanjia,sangjia,gongxiujia}

长按={
  onItemLongClick=function (p,v)
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems({"添加收藏","分享内容","复制内容"}, function (d,n)
      local hiscon=v.text
      if n==1 then
        shareText(hiscon.."\n    ——闲言APP 最好的阅读平台")
       elseif n==2 then
        copyText(hiscon.."\n    ——闲言APP 最好的阅读平台")
       elseif n==0 then
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
      text="请假条格式",
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
          spage.showPage(0)
        end,
        foreground=波纹(波纹色),
        text="病假",
        gravity="center",
        paddingLeft="22dp",
        paddingRight="22dp",
      },
      {
        TextView,
        padding="8dp",
        onClick=function (v)
          spage.showPage(1)
        end,
        foreground=波纹(波纹色),
        text="事假",
        textColor=文字色,
        --  layout_width="14dp",
        gravity="center",
        paddingLeft="22dp",
        paddingRight="22dp",
      },
      {
        TextView,
        padding="8dp",
        onClick=function (v)
          spage.showPage(2)
        end,
        foreground=波纹(波纹色),
        text="婚假",
        textColor=文字色,
        --  layout_width="14dp",
        gravity="center",
        paddingLeft="22dp",
        paddingRight="22dp",
      },
      {
        TextView,
        padding="8dp",
        onClick=function (v)
          spage.showPage(3)
        end,
        foreground=波纹(波纹色),
        text="产假",
        textColor=文字色,
        --  layout_width="14dp",
        gravity="center",
        paddingLeft="22dp",
        paddingRight="22dp",
      },
      {
        TextView,
        padding="8dp",
        onClick=function (v)
          spage.showPage(4)
        end,
        foreground=波纹(波纹色),
        text="丧假",
        textColor=文字色,
        --  layout_width="14dp",
        gravity="center",
        paddingLeft="22dp",
        paddingRight="22dp",
      },
      {
        TextView,
        padding="8dp",
        onClick=function (v)
          spage.showPage(5)
        end,
        foreground=波纹(波纹色),
        text="公休假",
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
          for s=0,5 do
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
          ListView,
          layout_width="fill",
          onItemLongClickListener=长按,
          adapter=bingjia,
          OnItemClickListener=单击,
          dividerHeight=38,
          divider=ColorDrawable(0x00000000),
          fastScrollEnabled=true,
        },
        {
          ListView,
          layout_width="fill",
          onItemLongClickListener=长按,
          adapter=shijia,
          OnItemClickListener=单击,
          dividerHeight=38,
          divider=ColorDrawable(0x00000000),
          fastScrollEnabled=true,
        },
        {
          ListView,
          layout_width="fill",
          onItemLongClickListener=长按,
          adapter=hunjia,
          OnItemClickListener=单击,
          dividerHeight=38,
          divider=ColorDrawable(0x00000000),
          fastScrollEnabled=true,
        },
        {
          ListView,
          layout_width="fill",
          onItemLongClickListener=长按,
          adapter=chanjia,
          OnItemClickListener=单击,
          dividerHeight=38,
          divider=ColorDrawable(0x00000000),
          fastScrollEnabled=true,
        },
        {
          ListView,
          layout_width="fill",
          onItemLongClickListener=长按,
          adapter=sangjia,
          OnItemClickListener=单击,
          dividerHeight=38,
          divider=ColorDrawable(0x00000000),
          fastScrollEnabled=true,
        },
        {
          ListView,
          layout_width="fill",
          onItemLongClickListener=长按,
          adapter=gongxiujia,
          OnItemClickListener=单击,
          dividerHeight=38,
          divider=ColorDrawable(0x00000000),
          fastScrollEnabled=true,
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

link="https://www.woyaoqingjia.com/zxsc/json/{x}.json"

jia={
  "bingjia",
  "shijia",
  "hunjia",
  "chanjia",
  "sangjia",
  "gongxiujia",
}

Http.get(link:gsub("{x}",jia[1]),function(code,content)
  if code==200 then
    for i,v in ipairs(cjson.decode(content)) do
      bingjia.add{
        nr="尊敬的X总：\n    您好！\n    "..
        v.kaishi..v.yuanyin..v.jiewei:gsub("<(.-)>","\n    ")..
        "请假人：XXX\n    XXXX年XX月XX日"
      }
    end
    if bingjia.getCount()>0
      nolog.setVisibility(8)
     else
      nolog.setVisibility(0)
    end
  end
end)

Http.get(link:gsub("{x}",jia[2]),function(code,content)
  if code==200 then
    for i,v in ipairs(cjson.decode(content)) do
      shijia.add{
        nr="尊敬的X总：\n    您好！\n    "..
        v.kaishi..v.yuanyin..v.jiewei:gsub("<(.-)>","\n    ")..
        "\n    请假人：XXX\n    XXXX年XX月XX日"
      }
    end
  end
end)

Http.get(link:gsub("{x}",jia[3]),function(code,content)
  if code==200 then
    for i,v in ipairs(cjson.decode(content)) do
      hunjia.add{
        nr="尊敬的X总：\n    您好！\n    "..
        v.kaishi..v.yuanyin..v.jiewei:gsub("<(.-)>","\n    ")..
        "\n    请假人：XXX\n    XXXX年XX月XX日"
      }
    end
  end
end)

Http.get(link:gsub("{x}",jia[4]),function(code,content)
  if code==200 then
    for i,v in ipairs(cjson.decode(content)) do
      chanjia.add{
        nr="尊敬的X总：\n    您好！\n    "..
        v.kaishi..v.yuanyin..v.jiewei:gsub("<(.-)>","\n    ")..
        "\n    请假人：XXX\n    XXXX年XX月XX日"
      }
    end
  end
end)

Http.get(link:gsub("{x}",jia[5]),function(code,content)
  if code==200 then
    for i,v in ipairs(cjson.decode(content)) do
      sangjia.add{
        nr="尊敬的X总：\n    您好！\n    "..
        v.kaishi..v.yuanyin..v.jiewei:gsub("<(.-)>","\n    ")..
        "\n    请假人：XXX\n    XXXX年XX月XX日"
      }
    end
  end
end)

Http.get(link:gsub("{x}",jia[6]),function(code,content)
  if code==200 then
    for i,v in ipairs(cjson.decode(content)) do
      gongxiujia.add{
        nr="尊敬的X总：\n    您好！\n    "..
        v.kaishi..v.yuanyin..v.jiewei:gsub("<(.-)>","\n    ")..
        "\n    请假人：XXX\n    XXXX年XX月XX日"
      }
    end
  end
end)