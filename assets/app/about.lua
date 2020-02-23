require "import"
import "str"

pcall(function() Ayaka_donate=loadbitmap ("https://gitee.com/ayaka_ago/WordsLeisure/raw/master/Images/donate@Ayaka_ago.png") end)

ict=0
sys="安卓系统版本号 - "..Build.VERSION.RELEASE
.."\n设备型号 - "..Build.MANUFACTURER.." "..Build.MODEL
.."\nSDK版本号 - "..Build.VERSION.SDK
.."\n序列号 - "..Build.SERIAL
.."\n设备ID - "..Secure.getString(this.getContentResolver(), Secure.ANDROID_ID)

money_give=LuaAdapter(this,{},{
  FrameLayout,
  layout_width="fill",
  --layout_height=lay_wh,
  padding="16dp",
  --layout_gravity="center",
  {
    TextView,
    id="name",
    ellipsize="end",
    textColor=文字色,
    textSize="16sp",
    --layout_width="fill",
    layout_gravity="left|center",
    layout_height="fill",
    gravity="center",
  },
  {
    TextView,
    textSize="16sp",
    textColor=次要文字色,
    id="conta",
    layout_gravity="right|center",
  },
  {
    TextView,
    visibility=8,
    id="yuan",
  },
})

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
        LinearLayout,
        layout_width="fill",
        gravity="center",
        orientation="vertical",
        wmark_1("闲","言","side_xian",nil,"95dp"),
        {
          TextView,
          padding="16dp",
          text="v"..本地版本,
          layout_marginBottom="26dp",
          textSize="16sp",
          onClick=function ()
            if ict<6 then
              ict=ict+1
             else
              ict=0
              this.newActivity("app/data_file")
            end
          end,
          onLongClickListener={
            onLongClick=function ()
              showDialog("系统信息",sys,"复制信息","好的", function ()
                copyText(sys)
              end)
            end},
          textColor=淡色,
        },
      },
      {
        FrameLayout,
        -- layout_marginTop="56dp"--[[+状态栏高度]],
        layout_width="fill",
        visibility=8,
        sort("APP"),
      },
      {
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          checkUpdate(true)
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="版本状态",
          textSize="16sp",
          textColor=文字色,
          layout_gravity="left|center",
          layout_height="fill",
          gravity="center",
        },
        {
          TextView,
          textSize="16sp",
          --paddingRight="16dp",
          text="已是最新版本",
          textColor=淡色,
          layout_height="fill",
          layout_gravity="center|right",
          id="uptext",
        },
      },
      {
        FrameLayout,
        -- layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          this.newActivity("app/guide")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="使用帮助",
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
      sort("开发相关"),
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
                onClick=function()
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
          .setPositiveButton("了解",nil)
          .setNegativeButton("向我们捐赠",function()
            --give_money.performClick()
            InAppBrowser("https://www.mukapp.top/pay","捐赠")
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
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="开发人员",
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
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          local edt=AlertDialog.Builder(this)
          .setTitle("感谢名单")
          -- .setCancelable(false)
          .setView(loadlayout ({
            ScrollView,
            paddingTop="16dp",
            layout_width="fill",
            {
              LinearLayout,
              layout_width="fill",
              orientation="vertical",
              padding="8dp",
              paddingTop="16dp",
              paddingBottom=0,
              sort("捐赠名单"),
              {
                ListView,
                adapter=money_give,
                dividerHeight=0,
                layout_width="fill",
                -- layout_height=w*0.75,
                id="money_listview",
              },
              {
                LinearLayout,
                orientation="vertical",
                layout_width="fill",
                id="who_give_money",
              },
              {
                TextView,
                text="正在加载列表",
                textSize="14sp",
                gravity="center",
                layout_width="fill",
                id="mnlist_ldng",
                textColor=淡色,
                padding="16dp",
              },--[==[
              sort("技术支持"),
              {
                FrameLayout,
                --layout_height=lay_wh,
                layout_width="fill",
                onClick=function ()
                  InAppBrowser("https://www.coolapk.com/apk/com.pretend.appluag","AppLua")
                end,
                foreground=波纹(波纹色),
                padding="16dp",
                layout_gravity="center",
                {
                  TextView,
                  text="AppLua",
                  textSize="16sp",
                  textColor=文字色,
                  layout_gravity="left|center",
                  layout_height="fill",
                  gravity="center",
                },
                {
                  LinearLayout,
                  layout_gravity="center|right",
                  {
                    TextView,
                    text="Pretend°",
                    textSize="16sp",
                    textColor=次要文字色,
                    layout_gravity="center",
                    layout_height="fill",
                    gravity="center",
                    paddingRight="8dp",
                  },
                  {
                    CircleImageView,
                    src="http://q1.qlogo.cn/g?b=qq&nk=3225270551&s=640",
                    layout_width="28dp",
                    layout_height="28dp",
                  },
                },
              },
              sort("软件平台"),
              {
                FrameLayout,
                --layout_height=lay_wh,
                layout_width="fill",
                padding="16dp",
                layout_gravity="center",
                onClick=function ()
                  InAppBrowser("https://www.coolapk.com/","酷安")
                end,
                foreground=波纹(波纹色),
                {
                  TextView,
                  text="酷安",
                  textSize="16sp",
                  textColor=文字色,
                  layout_gravity="left|center",
                  layout_height="fill",
                  gravity="center",
                },
                {
                  CircleImageView,
                  src="https://www.coolapk.com/static/images/header-logo.png",
                  layout_gravity="center|right",
                  layout_width="28dp",
                  layout_height="28dp",
                },
              },
              {
                FrameLayout,
                onClick=function ()
                  InAppBrowser("http://www.huluxia.com/","葫芦侠")
                end,
                foreground=波纹(波纹色),
                --layout_height=lay_wh,
                layout_width="fill",
                padding="16dp",
                layout_gravity="center",
                {
                  TextView,
                  text="葫芦侠",
                  textSize="16sp",
                  textColor=文字色,
                  layout_gravity="left|center",
                  layout_height="fill",
                  gravity="center",
                },
                {
                  CircleImageView,
                  src="http://www.huluxia.com/img/logo_xj.png",
                  layout_gravity="center|right",
                  layout_width="28dp",
                  layout_height="28dp",
                },
              },]==]
            },
          }))
          .setNegativeButton("向我们捐赠",function()
            --give_money.performClick()
            InAppBrowser("https://www.mukapp.top/pay","捐赠")
          end)
          .setPositiveButton("了解",nil)
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
          Http.get("https://gitee.com/ayaka_ago/WordsLeisure/raw/master/money.txt", function (c,n)
            mnlist_ldng.text="感谢以上捐赠过的小伙伴\n你的捐赠是对我们的支持"
            if c==200 then
              local tn=StrToTable(n)
              who_give_money.addView(loadlayout (tn))
             else
              mnlist_ldng.text="无法加载捐赠名单"
            end
          end)
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="感谢名单",
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
          layout_width="24dp",
          layout_height="24dp",
          layout_gravity="center|right",
        },
      },
      sort("AGYS"),
      {
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
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
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          InAppBrowser("http://www.agys.top/","闲言")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="官方网站",
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
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        id="give_money",
        layout_gravity="center",
        onClick=function ()
          InAppBrowser("https://www.mukapp.top/pay","捐赠")
          --[==[local edt=AlertDialog.Builder(this)
          .setTitle("捐赠")
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
              {
                TextView,
                text="支付宝红包码 513786250 ，感谢你的捐赠\n点击复制红包码，天天领红包",
                textSize="12sp",
                textColor=次要文字色,
                onClick=function ()
                  copyText("513786250")
                end,
                gravity="center",
                layout_width="fill",
                padding="8dp",
                -- paddingTop=0,
                foreground=波纹(波纹色),
              },
              sort("支付宝"),
              {
                TextView,
                text="5147662@qq.com",
                textColor=文字色,
                textSize="20sp",
                gravity="center",
                onClick=function (v)
                  copyText(v.text)
                end,
                foreground=波纹(波纹色),
                layout_width="fill",
                padding="16dp",
              },
              {
                TextView,
                text="点击文字复制账号，向逸捐赠",
                textSize="12sp",
                gravity="center",
                layout_width="fill",
                textColor=淡色,
                padding="8dp",
              },
              sort("QQ / 微信"),
              {
                ImageView,
                ImageBitmap=Ayaka_donate,
                adjustViewBounds=true,
                ColorFilter=nightOverlayColor or 0,
                layout_gravity="center",
                onClick=function ()
                  local sp=savePicture(app_path.."donate@Ayaka_ago.png",Ayaka_donate,false)
                  if sp then
                    toast ("已保存到本地，打开QQ/微信扫码捐赠")
                   else
                    toast ("保存失败")
                  end
                end,
                layout_height="135dp",
                foreground=波纹(波纹色),
              },
              {
                TextView,
                text="点击图片保存到本地，向 Ayaka_Ago 捐赠",
                textSize="12sp",
                gravity="center",
                layout_width="fill",
                textColor=淡色,
                padding="16dp",
                paddingBottom=0,
              },
            },
          }))
          .setPositiveButton("取消",nil)
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
          --[[activity.newActivity("web",{"https://www.mukapp.top/pay","向我捐赠",{
              onPageStarted=function (v,u)
                title.text=v.title
                err.visibility=8
                sslerr.visibility=8
                onPause()
              end,
              onPageFinished=function (v,u)
                if u:sub(1,4)=="http" then
                  title.text=v.title
                  onPause()
                end
              end,
              shouldOverrideUrlLoading=function (v,u)
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
                errde.text=e
                title.text=v.title
              end}
          })]]]==]
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="捐赠",
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
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          toast("请使用酷安进行评分")
          toAppStore(pack_name)
        end,
        id="ca_star",
        foreground=波纹(波纹色),
        {
          TextView,
          text="给我们评分",
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
      sort("其他"),
      {
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          --[[ local intent = Intent()
  intent.setAction(Intent.ACTION_SEND)
   intent.putExtra(Intent.EXTRA_STREAM, Uri.fromFile(File(packm.getApplicationInfo(pack_name, 64).sourceDir)))
  intent.setType("application/vnd.android.package-archive")
   intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
if pcall(function ()
   this.startActivity(Intent.createChooser(intent, "分享 闲言App 给朋友"))
end) then else
toast ("无法进行分享")
end]]
          shareText("我发现一个好应用 - 闲言App\nhttps://www.coolapk.com/apk/words.leisure.wallpapermaker\n点击查看")
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="分享本应用",
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
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          showDialog("用户协议",服务协议,"确定",nil,function()
          end, nil,nil,nil,nil,nil,nil,nil)
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="用户协议",
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
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          showDialog("隐私政策",隐私政策,"确定",nil,function()
          end, nil,nil,nil,nil,nil,nil,nil)
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="隐私政策",
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
      --[[{
        FrameLayout,
        --layout_height=lay_wh,
        layout_width="fill",
        padding="16dp",
        layout_gravity="center",
        onClick=function ()
          showCopyright()
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="软件许可",
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
      },]]
      {
        TextView,
        layout_gravity="center",
        padding="16dp",
        textColor=淡色,
        layout_marginTop="28dp",
        text=Copyright_AllRights,
        gravity="center",
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
    paddingTop="8dp",
    paddingBottom="8dp",
    --backgroundColor=背景色,
    elevation="2dp",
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
      text="关于",
      textSize="20sp",
      textColor=文字色,
    },
  },
}))

function checkUpdate(p)
  Http.get("https://gitee.com/ayaka_ago/WordsLeisure/raw/master/Version/Update.txt", function (c,n)
    if c==200 then
      local n=StrToTable(n)
      if n.toUser and 本地版本<n.Ver then
        if p~=false then
          showDialog("检测到新版本",--[["当前版本 - "..本地版本.."\n"..]]"版本 - v"..n.Ver.."\n\n"..n.Changes,"在酷安下载","在浏览器下载",function ()
            openInBrowser(n.coolapkUrl)
          end,function()
            openInBrowser(n.apkUrl)
          end,nil,nil,false,"暂不更新")
        end
        uptext.text="有新版本 v"..n.Ver
       else
        uptext.text="已是最新版本"
        if p==true then
          if n.toUser and 本地版本==n.Ver then
            showDialog("已是最新版本","v"..n.Ver.." 的更新内容\n\n"..n.Changes,"了解")
           else
            toast(uptext.text)
          end
        end
      end
     else
      uptext.text="已是最新版本"
      if p==true then
        toast(uptext.text)
      end
    end
  end)
end

checkUpdate()

pcall(function () cainfo=packm.getApplicationInfo("com.coolapk.market",64) end)
if not cainfo then
  ca_star.setVisibility(8)
end