require "import"
import "str"
import "android.animation.AnimatorSet"

padp=ArrayPageAdapter()

function funDescr(title,desc,path)
  return {
    LinearLayout,
    layout_width="fill",
    --layout_height="195dp",
    paddingTop="8dp",
    paddingBottom="8dp",
    {
      LinearLayout,
      orientation="vertical",
      padding="14dp",
      layout_width="70%w",
      {
        TextView,
        text=title,
        TextColor=文字色,
        textSize="16sp",
        paddingBottom="8dp",
      },
      {
        TextView,
        text=desc,
        TextColor=次要文字色,
        textSize="16sp",
      },
    },
    {
      CircleImageView,
      ImageBitmap=loadbitmap (path),
      scaleType="centerCrop",
      layout_width="30%w",
      layout_height="30%w",
      layout_gravity="center",
      --adjustViewBounds=true,
      colorFilter=nightOverlayColor or 0,
    },
  }
end

this.setContentView(loadlayout ({
  DrawerLayout,
  id="drawer",
  --ScrimColor=淡色,
  DrawerListener=DrawerLayout.DrawerListener{
    onDrawerSlide=function(v,i)

    end},
  {
    FrameLayout,
    layout_width="fill",
    layout_height="fill",
    --visibility=4,
    backgroundColor=背景色,
    -- orientation="vertical",
    --elevation="2%w",
    --paddingTop=状态栏高度,
    {
      ScrollView,
      layout_width="fill",
      id="scroll",
      overScrollMode=2,
      {
        LinearLayout,
        orientation="vertical",
        layout_width="fill",
        {
          FrameLayout,
          layout_width="fill",
          layout_height="100%h",
          {
            ImageView,
            layout_width="fill",
            layout_height="fill",
            --adjustViewBounds=true,
            scaleType="centerCrop",
            src="https://gitee.com/ayaka_ago/WordsLeisure/raw/master/Images/3.jpg",
            id="topPic",
            colorFilter=nightOverlayColor or 0,
          },
          {
            LinearLayout,
            orientation="vertical",
            layout_gravity="bottom",
            layout_width="fill",
            foreground=上下渐变({淡透,深透,背景色}),
            {
              TextView,
              id="ggy2",
              paddingBottom="14dp",
              paddingTop="24dp",
              textSize="24sp",
              visibility=4,
              layout_gravity="center",
              text="闲言，\n我们是文字狂热迷。",
            },
            {
              ImageView,
              src="drawable/arrow.png",
              visibility=4,
              layout_height="26dp",
              layout_marginBottom="14dp",
            },
          },
          --句子卡片

          {
            LinearLayout,
            orientation="vertical",
            layout_gravity="center|bottom",
            background=上下渐变({淡透,深透,背景色}),
            {
              TextView,
              id="ggy",
              paddingBottom="14dp",
              textSize="24sp",
              paddingTop="24dp",
              layout_width="fill",
              --gravity="center",
              layout_gravity="center",
              textColor=文字色,
              text="闲言，\n我们是文字狂热迷。",
            },
            {
              ImageView,
              src="drawable/arrow.png",
              layout_width="fill",
              layout_height="26dp",
              layout_gravity="center",
              id="scrollUpArrow",
              rotation=180,
              colorFilter=图标色,
              onClick=function (v)
                scroll.smoothScrollTo(0,v.Parent.bottom-状态栏高度)
              end,
              layout_marginBottom="14dp",
            },
          },
          --顶部
        },
        sort("概览"),
        {
          TextView,
          text="正在加载内容",
          textSize="14sp",
          gravity="center",
          layout_width="fill",
          id="gl_loading",
          textColor=淡色,
          padding="16dp",
        },
        {
          FrameLayout,
          -- orientation="vertical",
          layout_width="fill",
          id="vid_guide",
          foreground=波纹(波纹色),
          visibility=8,
          {
            ImageView,
            layout_width="fill",
            ColorFilter=nightOverlayColor or 0,
            adjustViewBounds=true,
          },
          {
            FrameLayout,
            layout_gravity="center|bottom",
            layout_width="fill",
            padding="16dp",
            BackgroundColor=浮窗背景色,
            {
              TextView,
              text="查看视频帮助",
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
        },
        {
          LinearLayout,
          orientation="vertical",
          layout_width="fill",
          id="gailan",
        },
        {
          LinearLayout,
          orientation="vertical",
          visibility=8,
          sort("展示"),
          {
            PageView,
            layout_width="fill",
            layout_height="100%h",
            id="pshow",
            onPageChangeListener={
              onPageSelected=function (p)
                curp=p
              end,
              onPageScrollStateChanged=function (s)
                if s==1 then
                  isScrolling=true
                 else
                  isScrolling=false
                end
              end},
            adapter=padp,
          },
        },
        {
          LinearLayout,
          layout_height="8dp",
        },
        sort("说明"),
        {
          TextView,
          text="正在加载内容",
          textSize="14sp",
          gravity="center",
          layout_width="fill",
          id="sm_loading",
          textColor=淡色,
          padding="16dp",
        },
        {
          LinearLayout,
          orientation="vertical",
          layout_width="fill",
          id="shuoming",
        },
        {
          FrameLayout,
          --layout_height=lay_wh,
          layout_width="fill",
          padding="16dp",
          layout_marginTop="36dp",
          layout_gravity="center",
          onClick=function ()
            addQQgroup(519241613)
          end,
          foreground=波纹(波纹色),
          {
            TextView,
            text="官方群聊",
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
            local edt=AlertDialog.Builder(this)
            .setTitle("开发人员")
            --.setCancelable(false)
            .setView(loadlayout ({
              ScrollView,
              layout_width="fill",
              {
                LinearLayout,
                layout_width="fill",
                orientation="vertical",
                padding="8dp",
                paddingTop="16dp",
                paddingBottom=0,
                sort("开发者"),
                {
                  FrameLayout,
                  --layout_height=lay_wh,
                  layout_width="fill",
                  padding="16dp",
                  layout_gravity="center",
                  onClick=function ()
                    contactQQ(1773798610)
                  end,
                  foreground=波纹(波纹色),
                  {
                    TextView,
                    text="MUK",
                    textSize="16sp",
                    textColor=文字色,
                    layout_gravity="left|center",
                    layout_height="fill",
                    gravity="center",
                  },
                  {
                    CircleImageView,
                    src="https://mukapp.top/pic/muk.png",
                    layout_width="28dp",
                    layout_height="28dp",
                    layout_gravity="center|right",
                  },
                },
                sort("技术支持"),
                {
                  FrameLayout,
                  --layout_height=lay_wh,
                  layout_width="fill",
                  padding="16dp",
                  layout_gravity="center",
                  onClick=function ()
                    contactQQ(2572560133)
                  end,
                  foreground=波纹(波纹色),
                  {
                    TextView,
                    text="Ayaka_Ago",
                    textSize="16sp",
                    textColor=文字色,
                    layout_gravity="left|center",
                    layout_height="fill",
                    gravity="center",
                  },
                  {
                    CircleImageView,
                    src="https://gitee.com/ayaka_ago/WordsLeisure/raw/master/Images/Ayaka_Ago.jpg",
                    layout_width="28dp",
                    layout_height="28dp",
                    layout_gravity="center|right",
                  },
                },
                sort("运营管理"),
                {
                  FrameLayout,
                  --layout_height=lay_wh,
                  layout_width="fill",
                  padding="16dp",
                  layout_gravity="center",
                  onClick=function ()
                    contactQQ(2821981550)
                  end,
                  foreground=波纹(波纹色),
                  {
                    TextView,
                    text="逸",
                    textSize="16sp",
                    textColor=文字色,
                    layout_gravity="left|center",
                    layout_height="fill",
                    gravity="center",
                  },
                  {
                    CircleImageView,
                    src="https://gitee.com/ayaka_ago/WordsLeisure/raw/master/Images/yi.jpg",
                    layout_width="28dp",
                    layout_height="28dp",
                    layout_gravity="center|right",
                  },
                },
              },
            }))
            .setPositiveButton("好的",nil)
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
          end,
          foreground=波纹(波纹色),
          {
            TextView,
            text="联系开发人员",
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
            layout_width="24dp",
            layout_height="24dp",
            layout_gravity="center|right",
          },
        },
        {
          TextView,
          layout_gravity="center",
          padding="16dp",
          textColor=淡色,
          text=Copyright_AllRights,
          gravity="center",
        },
        --scroll
      },
    },
    {
      LinearLayout,
      id="topbar",
      backgroundColor=背景色,
      paddingTop=状态栏高度,
      {
        RelativeLayout,
        layout_width="fill",
        layout_height="56dp" ,
        gravity="center",
        padding="16dp",
        -- elevation="2dp",
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
          id="back",
          padding="9dp",
          colorFilter=图标色,
        },
        {
          TextView,
          layout_width="fill",
          layout_height="fill",
          gravity="center",
          --layout_gravity="center",
          text="使用帮助",
          textSize="20sp",
          textColor=文字色,
        },
      },
    },
  },
}))

scroll.onScrollChange=function (v,x,y,px,py)
  if y==0 or py==0 then
    topbar.y=0
   elseif y>py and topbar.y>-topbar.height then
    local d=y-py
    topbar.y=topbar.y-d
   elseif py>y and topbar.y<0 then
    local d=py-y
    topbar.y=topbar.y+d
   elseif topbar.y>0 then
    topbar.y=0
  end
  if y>=scrollUpArrow.Parent.bottom-状态栏高度 then
    as.pause()
   elseif y==0 then
    as.resume()
  end
end

Http.get("https://gitee.com/ayaka_ago/WordsLeisure/raw/master/guide.txt", function (c,n)
  if c==200 then
    local n=StrToTable(n)
    local glob=n.glob
    local desc=n.desc
    local pg=n.page
    topPic.setImageBitmap(loadbitmap (n.toppic or ""))
    vid_guide.getChildAt(0).setImageBitmap(loadbitmap (n.vid_preview))
    vid_guide.onClick=function ()
      InAppBrowser(n.vid,"闲言 App 使用教程")
    end
    vid_guide.setVisibility(0)
    for g=1,#glob do
      local i=glob[g]
      gailan.addView(loadlayout (funDescr(i[1],i[2],i[3])))
    end
    gl_loading.setVisibility(8)
    for d=1,#desc do
      local i=desc[d]
      shuoming.addView(loadlayout (funDescr(i[1],i[2],i[3])))
    end
    sm_loading.setVisibility(8)
    pshow.Parent.setVisibility(0)
    for p=1,#pg do
      local i=pg[p]
      padp.add(loadlayout ({
        ImageView,
        src=i,
        layout_width="fill",
        layout_height="fill",
        scaleType="centerCrop",
        colorFilter=nightOverlayColor or 0,
      }))
    end
    padp.notifyDataSetChanged()
    PageCount=padp.getCount()-1
   else
    local noti="内容加载失败，请检查网络"
    gl_loading.setText(noti)
    sm_loading.setText(noti)
  end
end)

Http.get("https://gitee.com/ayaka_ago/WordsLeisure/raw/master/Advertisement/adwords.txt", function (c,n)
  if c==200 then
    local n=StrToTable(n)
    local cn=n.cn
    local t="闲言，\n"..cn.."。"
    ggy.setText(t)
    ggy2.setText(t)
  end
end)

pshow.setPageTransformer(true,PageTransAnim.ZoomIn)

--alp=ObjectAnimator.ofFloat(scrollUpArrow, "Alpha", {0,1, 0}).setRepeatCount(-1)
transY=ObjectAnimator.ofFloat(scrollUpArrow, "translationY", {h*0.015, -h*0.015,h*0.015}).setRepeatCount(-1)
as=AnimatorSet()
as.setDuration(1750)
as.play(transY)--.with(alp)
as.start()

t=Ticker()
t.setPeriod(5000)
t.onTick=function ()
  pcall(function()
    if not isScrolling then
      if curp<PageCount then
        pshow.showPage(curp+1)
       else
        pshow.showPage(0)
      end
    end
  end)
end
t.start()

function onDestroy()
  t.stop()
end