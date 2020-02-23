require "import"
import "str"
window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)

isJumped=false

pcall(function () showBoot=io.open(Bootpage):read("*a") end)
if not showBoot then
  io.open(Bootpage,"w+"):write("true"):close()
end

this.setContentView(loadlayout ({
  FrameLayout,
  layout_width="fill",
  layout_height="fill",
  BackgroundColor=背景色,
  {
    TextView,
    layout_gravity="center",
    gravity="center",
    -- paddingTop=状态栏高度,
    -- ems=1,
    paddingBottom="90dp",
    textColor=次要文字色,
    textSize="20sp",
    id="ggy",
    text="我\n们\n是\n文\n字\n狂\n热\n迷",
    layout_marginTop="30dp";
  },
  {
    FrameLayout,
    layout_width="fill",
    paddingBottom="100dp",
    layout_height="fill",
    visibility=8,
    {
      ImageView,
      id="img",
      scaleType="centerCrop",
      layout_height="fill",
      layout_width="fill",
      colorFilter=nightOverlayColor or 0,
      -- adjustViewBounds=true,
    },
    {
      VideoView,
      id="vid",
      visibility=8,
      layout_height="fill",
      layout_width="fill",
    },
    {
      TextView,
      --  layout_marginTop=状态栏高度,
      padding="16dp",
      textSize="14sp",
      text="AD",
      id="typ",
      textColor=次要文字色,
      layout_gravity="right|top",
    },
  },
  {
    LinearLayout,
    layout_gravity="center|bottom",
    orientation="vertical",
    layout_width="fill",
    {
      FrameLayout,
      --layout_height=lay_wh,
      layout_width="fill",
      padding="16dp",
      id="bmInf",
      visibility=8,
      foreground=波纹(波纹色),
      backgroundColor=浮窗背景色,
      {
        TextView,
        id="info",
        textSize="16sp",
        textColor=文字色,
        layout_gravity="left|center",
        layout_height="fill",
        gravity="center",
        paddingRight="35dp",
        singleLine=true,
        text="闲言 - 广告位招租",
        ellipsize="end",
      },
      {
        ImageView,
        -- src="drawable/arrow.png",
        rotation=-90,
        --layout_alignParentRight=true,
        layout_width="26dp",
        id="icon",
        colorFilter=图标色,
        layout_height="26dp",
        layout_gravity="center|right",
      },
    },
    {
      FrameLayout,
      layout_width="fill",
      layout_height="120dp",
      id="logo",
      backgroundColor=背景色,
      -- layout_alignParentBottom=true,
      wmark_1("闲","言","side_xian"),
      {
        TextView,
        text="             ",
        layout_gravity="right|bottom",
        textColor=次要文字色,
        id="countdown",
        padding="10dp",
        foreground=波纹(波纹色),
        onClick=function(v)
          if not isJumped then
            isJumped=true
            v.onClick=function () end
            this.newActivity("soup",{nil,1})
            v.foreground=ColorDrawable(0)
            -- img.Parent.setVisibility(8)
            v.text="正在进入"
            this.finish()
          end
        end,
      },
      {
        ProgressBar,
        indeterminate=true,
        layout_gravity="bottom",
        layout_width="fill",
        layout_height="8dp",
        visibility=8,
        style="?android:attr/progressBarStyleHorizontal",
      },
    },
  },
}))

ggy.setLineSpacing(50,0.5)

Http.get("https://gitee.com/ayaka_ago/WordsLeisure/raw/master/Advertisement/adwords.txt", function (c,n)
  if c==200 then
    local n=StrToTable(n)
    local cn=n.cn
    if not cn:find("\n") then
      ggy.setEms(1)
      --toast("no enter")
    end
    ggy.setText(cn)
  end
end)

if math.random(1,100)>35 then
  countdown.text="加载中 | 跳过"
  Http.get("https://gitee.com/ayaka_ago/WordsLeisure/raw/master/Advertisement/boot.txt", function (c,n)
    if c==200 then
      local on=StrToTable(n)
      local n=on[math.random(2,#on)]
      if n.show and on.enabled then
        typ.text=n.type or "广告"
        if n.icon then
          icon.setImageBitmap(loadbitmap (n.icon))
          icon.rotation=0
          icon.colorFilter=0
         elseif n.action then
          icon.setImageBitmap(loadbitmap ("drawable/arrow.png"))
        end
        if n.video then
          vid.setVisibility(0)
          vid.setVideoURI(Uri.parse(n.video))
          vid.start()
          vid.setZOrderOnTop(false)
        end
        img.setImageBitmap(loadbitmap(n.img or ""))
        info.text=n.content
        if n.action then
          img.Parent.onClick=n.action
          bminf.onClick=n.action
        end
        img.Parent.setVisibilityfunction()(0)
        bmInf.setVisibility(0)
        countdown.text="跳过 | 5"
        task(1000, function ()
          countdown.text="跳过 | 4"
          task(1000, function ()
            countdown.text="跳过 | 3"
            task(1000, function ()
              countdown.text="跳过 | 2"
              task(1000, function ()
                countdown.text="跳过 | 1"
                task(1000, function ()
                  countdown.performClick()
                end)
              end)
            end)
          end)
        end)
        --有广告
       else
        --广告已关闭
        img.Parent.setVisibility(8)
        task(500, function ()
          countdown.performClick()
        end)
      end
     else
      --获取失败
      img.Parent.setVisibility(8)
      task(1000, function ()
        countdown.performClick()
      end)
    end
  end)
 else
  img.Parent.setVisibility(8)
  task(1000, function ()
    countdown.performClick()
  end)
end

if showBoot=="false" or not showBoot then
  countdown.performClick()
end

function onKeyDown(k)
  if k==4 then
    return true
  end
end

--activity.newActivity("app/saved_wallpaper.lua")