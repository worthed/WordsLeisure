require "import"
import "str"

pcall(function () nightOn=io.open(nightMode):read("*a") end)
if nightOn=="true" then
  nightOn=true
 else
  nightOn=false
end

pcall(function () boot=io.open(Bootpage):read("*a") end)
if boot=="true" then
  boot=true
 else
  boot=false
end

this.setContentView(loadlayout ({
  RelativeLayout,
  --id="conf",
  layout_width="fill",
  layout_height="fill",
  --visibility=4,
  backgroundColor=背景色,
  --orientation="vertical",
  --elevation="2%w",
  paddingTop=状态栏高度,
  {
    ScrollView,
    --OverScrollMode=2,
    layout_width="fill",
    id="confscr",
    --verticalScrollBarEnabled=false,
    {
      LinearLayout,
      layout_width="fill",
      gravity="center",
      orientation="vertical",
      {
        FrameLayout,
        layout_width="fill",
        layout_marginTop="56dp",
        sort("常规"),
      },
      {
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("app/inbox")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="通知推送",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          --layout_alignParentRight=true,
          layout_width="26dp",
          layout_height="26dp",
          layout_gravity="center|right",
        },
      },
      {
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("app/createShortcut")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="创建快捷方式",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          --layout_alignParentRight=true,
          layout_width="26dp",
          layout_height="26dp",
          layout_gravity="center|right",
        },
      },
      {
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("app/lab")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="功能实验室",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          --layout_alignParentRight=true,
          layout_width="26dp",
          layout_height="26dp",
          layout_gravity="center|right",
        },
      },
      {
        FrameLayout,
        layout_width="fill",
        onClick=function ()
          darktoggle.performClick()
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="夜间模式",
          textColor=文字色,
          textSize="16sp",
          padding="16dp",
          gravity="center",
          layout_height="fill",
        },
        {
          Switch,
          padding="16dp",
          checked=nightOn,
          layout_gravity="right|center",
          id="darktoggle",
        },
      },
      {
        FrameLayout,
        layout_width="fill",
        onClick=function ()
          boottoggle.performClick()
        end,
        visibility=8,
        foreground=波纹(波纹色),
        {
          TextView,
          text="显示启动页",
          textColor=文字色,
          textSize="16sp",
          padding="16dp",
          gravity="center",
          layout_height="fill",
        },
        {
          Switch,
          padding="16dp",
          checked=boot,
          layout_gravity="right|center",
          id="boottoggle",
        },
      },
      sort("数据"),
      {
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("app/saved_wallpaper")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="已保存的壁纸 / 纯文本图片",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          --layout_alignParentRight=true,
          layout_width="26dp",
          layout_height="26dp",
          layout_gravity="center|right",
        },
      },
      --[[{
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("app/browser_downpic")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="浏览器页面下载的图片",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          -- layout_alignParentRight=true,
          layout_width="26dp",
          layout_height="26dp",
          layout_gravity="center|right",
        },
      },]]
      {
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("app/data_backup")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="数据备份与恢复",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          -- layout_alignParentRight=true,
          layout_width="26dp",
          layout_height="26dp",
          layout_gravity="center|right",
        },
      },
      {
        TextView,
        text="清空历史记录",
        textColor=文字色,
        foreground=波纹(波纹色),
        onClick=function ()
          local c=getFileCount(soup_logs)
          if c>0 then
            showDialog("清空历史记录","确认删除 "..c.." 条句子记录？此操作无法撤销。\n\n将会保留一条心灵毒鸡汤的记录（如果有），不计算在历史记录内。","清空","取消",function()
              local pat=File(soup_logs)
              if pcall(function ()
                  LuaUtil.rmDir(pat)
                  pat.mkdir()
                end) then
                toast("已清空历史记录")
                io.open(今天条数,"w+"):write([[{
count="0",
date="]]..tostring(os.date("%x"))..[[",
}]]):close()
               else
                toast("无法清空历史记录")
              end
            end,nil,0xffff4500)
           else
            toast ("无历史记录")
          end
        end,
        --layout_height=lay_wh,
        textSize="16sp",
        gravity="center|left",
        layout_width="fill",
        padding="16dp",
      },
      {
        TextView,
        text="清除缓存数据",
        textColor=文字色,
        foreground=波纹(波纹色),
        onClick=function ()
          local cs=0
          for w=1,#WebCache do
            cs=cs+getFolderSize(WebCache[w])
          end
          local cuki=File(应用数据.."shared_prefs/Cookie.xml")
          if cuki.exists () then
            cs=cs+cuki.length()
          end
          local cs=string.format("%.2f",cs/1024/1024)
          --print(tonumber(cs))
          if tonumber(cs)>0 then
            showDialog("清除缓存数据","缓存数据占用 "..cs.."MB 储存空间，包含网页缓存及其他部分数据。","清空","取消",function()
              if pcall(function ()
                  for c=1,#WebCache do
                    local f=File(WebCache[c])
                    if f. exists () then
                      LuaUtil.rmDir(f)
                    end
                  end
                  if cuki.exists () then
                    cuki.delete()
                  end
                end) then
                toast ("已清除 "..cs.."MB 缓存数据")
               else
                toast ("清除失败")
              end
            end,nil,0xffff4500)
           else
            toast("没有缓存")
          end
        end,
        --layout_height=lay_wh,
        textSize="16sp",
        gravity="center|left",
        layout_width="fill",
        padding="16dp",
      },
      sort("字体"),
      {
        FrameLayout,
        -- layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("font/app")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="联网获取字体",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          --layout_alignParentRight=true,
          layout_width="26dp",
          layout_height="26dp",
          layout_gravity="center|right",
        },
      },
      {
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("font/user")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="已导入的本地字体",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          -- layout_alignParentRight=true,
          layout_width="26dp",
          layout_height="26dp",
          layout_gravity="center|right",
        },
      },
      {
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("font/system")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="系统字体",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          -- layout_alignParentRight=true,
          layout_width="26dp",
          layout_height="26dp",
          layout_gravity="right|center",
        },
      },
      sort("其他"),
      {
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("app/about")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="关于",
          layout_gravity="left|center",
          textSize="16sp",
          textColor=文字色,
          layout_height="fill",
          gravity="center",
        },
        {
          ImageView,
          colorFilter=图标色,
          src="drawable/arrow.png",
          rotation=-90,
          --layout_alignParentRight=true,
          layout_width="26dp",
          layout_height="26dp",
          layout_gravity="center|right",
        },
      },
      --设置页面
    },
  },
  {
    LinearLayout,
    layout_width="fill",
    layout_height="56dp",
    foreground=上下渐变({背景色,深透,淡透}),
  },
  {
    RelativeLayout,
    layout_width="fill",
    layout_height="56dp",
    gravity="center",
    padding="16dp",
    --backgroundColor=背景色,
    elevation="2dp",
    paddingTop="8dp",
    paddingBottom="8dp",
    {
      ImageView,
      colorFilter=图标色,
      src="drawable/back.png",
      layout_height="fill",
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
      text="设置",
      textSize="20sp",
      textColor=文字色,
    },
  },
}))

darktoggle.setOnCheckedChangeListener{
  onCheckedChanged=function (v,c)
    io.open(nightMode,"w+"):write(tostring(c)):close()
    toast ("正在更新界面")
    this.recreate()
  end}

boottoggle.setOnCheckedChangeListener{
  onCheckedChanged=function (v,c)
    io.open(Bootpage,"w+"):write(tostring(c)):close()
  end}