require "import"
import "str"

--toast (insTime)
今月=os.date("%m")
今日=os.date("%d")
已装月=string.format("%.f",今月-insMon)
已装日=string.format("%.f",已装月*31+(今日-insDay))
--toast (已装月,已装日)
句列=getFileList(soup_logs)
local f=io.open(今天条数)
if pcall(function ()
    da=StrToTable(f:read("*a"))
    td=tonumber(da.count)
  end) then else
  toast ("载入数据时出错")
end
local td=td or 0
--toast (zishu)
if td>#句列 then
  句数=td
 else
  句数=#句列
end
平均=string.format("%.f",句数/已装日)
--toast (句子数,平均每天句子)
soup=0
wu=0
yan=0
rp=0
jitang=0
zishu=0
--toast(句数)
for h=1,#句列 do
  pcall(function ()
    local f=io.open(tostring(句列[h]))
    local co=StrToTable(f:read("*a"))
    local n=co.soup
    local nc=utf8.len(n)
    --toast (n,nc)
    zishu=zishu+nc
    if co.type:find"毒鸡汤" then
      soup=soup+1
     elseif co.type=="心灵鸡汤" then
      jitang=jitang+1
     elseif co.type=="云音乐热评" then
      rp=rp+1
     else
      yan=yan+1
    end
  end)
end
--toast(soup,wu,yan)

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
      padding="9dp",
      colorFilter=图标色,
    },
    {
      TextView,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      --layout_gravity="center",
      text="点滴",
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
        layout_width="fill",
        orientation="vertical",
        id="data_area",
        backgroundColor=背景色,
        sort("句子数据"),
        {
          TextView,
          text="自您 "..insMon.."月"..insDay.."日 安装 闲言APP 以来",
          textColor=次要文字色,
          textSize="16sp",
          layout_width="fill",
          gravity="center",
          padding="28dp",
          paddingTop="16dp",
          paddingBottom="16dp",
        },
        {
          TextView,
          text="一共刷了 "..句数.." 条句子",
          textColor=文字色,
          textSize="22sp",
          layout_width="fill",
          gravity="center",
          padding="28dp",
          paddingTop="16dp",
          paddingBottom="16dp",
        },
        {
          TextView,
          text="平均每天刷了 "..平均.." 条句子",
          textColor=文字色,
          textSize="20sp",
          layout_width="fill",
          gravity="center",
          padding="28dp",
          paddingTop=0,
          paddingBottom="16dp",
        },
        {
          TextView,
          text="今天刷了 "..td.." 条句子",
          textColor=文字色,
          textSize="20sp",
          layout_width="fill",
          gravity="center",
          padding="28dp",
          paddingTop=0,
          paddingBottom="16dp",
        },
        {
          TextView,
          text="共 "..jitang.." 条心灵鸡汤",
          textColor=文字色,
          textSize="16sp",
          layout_width="fill",
          gravity="center",
          padding="28dp",
          paddingTop="16dp",
          paddingBottom="16dp",
        },
        {
          TextView,
          text="共 "..soup.." 条毒鸡汤",
          textColor=文字色,
          textSize="16sp",
          layout_width="fill",
          gravity="center",
          padding="28dp",
          paddingTop=0,
          paddingBottom="16dp",
        },
        {
          TextView,
          text="共 "..yan.." 条一言",
          textColor=文字色,
          textSize="16sp",
          layout_width="fill",
          gravity="center",
          padding="28dp",
          paddingTop=0,
          paddingBottom="16dp",
        },
        {
          TextView,
          text="共 "..rp.." 条云音乐热评",
          textColor=文字色,
          textSize="16sp",
          layout_width="fill",
          gravity="center",
          padding="28dp",
          paddingTop=0,
          paddingBottom="16dp",
        },
        {
          TextView,
          text="共 "..zishu.." 个字",
          textColor=文字色,
          textSize="16sp",
          layout_width="fill",
          gravity="center",
          padding="28dp",
          paddingBottom="16dp",
          paddingTop=0,
        },
        {
          TextView,
          text="部分统计数据不包含已删除的记录",
          textColor=淡色,
          textSize="12sp",
          layout_width="fill",
          gravity="center",
          id="notice",
          -- visibility=4,
          padding="8dp",
          paddingLeft="16dp",
          paddingRight="16dp",
        },
        sort("闲言 APP"),
        --data_area
      },
      {
        TextView,
        text="生成图文报告",
        textColor=文字色,
        foreground=波纹(波纹色),
        onClick=function ()
          notice.visibility=4
          shareBitmap(getViewBitmap(data_area))
          notice.visibility=0
        end,
        --layout_height=lay_wh,
        textSize="16sp",
        gravity="center",
        layout_width="fill",
        padding="16dp",
      },
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