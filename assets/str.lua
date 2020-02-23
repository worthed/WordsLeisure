require "import"

import "android.app.*"
import "android.view.ViewGroup"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.os.Process"
import "android.webkit.CookieManager"
import "android.webkit.WebView"
import "android.webkit.WebSettings"
import "android.widget.PopupMenu"
import "android.provider.Settings$Secure"
import "android.view.*"
import "java.io.ByteArrayOutputStream"
import "java.io.ByteArrayInputStream"
import "android.widget.PullingLayout"
import "android.content.*"
import "android.view.animation.AlphaAnimation"
import "android.widget.LinearLayout"
import "android.widget.DrawerLayout"
import "android.text.Html"
import "java.util.Calendar"
import "com.androlua.LuaWebView$SimpleLuaWebViewClient"
import "com.androlua.LuaWebView$LuaWebViewClient"
import "com.androlua.LuaEditor"
import "java.util.Date"
import "android.graphics.drawable.BitmapDrawable"
import "android.view.animation.TranslateAnimation"
import "android.view.animation.AnimationSet"
import "android.view.animation.LayoutAnimationController"
import "android.view.animation.Animation"
import "android.view.animation.ScaleAnimation"
import "android.widget.RelativeLayout"
import "android.view.WindowManager"
import "android.view.animation.AlphaAnimation"
import "android.widget.ImageView"
import "android.widget.VideoView"
import "android.widget.ProgressBar"
import "android.widget.SeekBar"
import "android.widget.CircleImageView"
import "android.widget.TextView"
import "android.widget.EditText"
import "android.widget.ScrollView"
import "android.widget.HorizontalScrollView"
import "android.widget.RelativeLayout"
import "android.animation.ValueAnimator"
import "android.widget.LinearLayout"
import "android.widget.ImageView$ScaleType"
import "android.widget.FrameLayout"
import "android.widget.ProgressBar"
import "android.widget.Switch"
import "java.util.Collections"
import "android.graphics.Paint"
import "android.graphics.drawable.ColorDrawable"
import "com.androlua.Http"
import "android.animation.ObjectAnimator"
import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"
import "android.widget.PageView"
import "android.provider.MediaStore"
import "android.widget.CardView"
import "android.os.Build"
import "android.content.Intent"
import "android.view.inputmethod.InputMethodManager"
import "java.io.File"
import "android.net.Uri"
import "java.io.FileOutputStream"
import "android.content.Context"
import "android.util.DisplayMetrics"
import "android.view.View"
import "android.graphics.Bitmap"
import "android.graphics.Color"
import "android.graphics.drawable.RippleDrawable"
import "android.content.res.ColorStateList"
import "android.graphics.drawable.GradientDrawable"
import "android.widget.ListView"
import "android.widget.GridView"
import "android.graphics.Typeface"
import "android.widget.Spinner"
import "android.app.WallpaperManager"
import "android.content.pm.PackageManager"
import "android.view.animation.AccelerateDecelerateInterpolator"
import "android.renderscript.Element"
import "android.renderscript.ScriptIntrinsicBlur"
import "android.renderscript.Allocation"
import "android.renderscript.RenderScript"
import "android.app.PendingIntent"
import "android.widget.ArrayAdapter"
import "com.androlua.LuaAdapter"
import "android.widget.Toast"
--import "android.content.res.Resources$Theme"
import "android.graphics.BitmapFactory"
import "android.view.animation.*"
import "java.security.MessageDigest"

xpcall(function()
  import "words.leisure.wallpapermaker.beta.R"
end,function()
  xpcall(function()
    import "words.leisure.wallpapermaker.R"
  end,function()
    xpcall(function()
      import "com.pretend.appluagbeta.R"
    end,function()
      xpcall(function()
        import "com.pretend.appluag.R"
      end,function()
      end)
    end)
  end)
end)

-- modules and strings
cjson=require "cjson"
import "mods.t1"
服务协议=import "terms.tos2"
隐私政策=import "terms.tos"
软件许可=import "terms.copyright"
fscreen=View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN

-- system services
conman=this.getSystemService(Context.CONNECTIVITY_SERVICE)
vibman=this.getSystemService(Context.VIBRATOR_SERVICE)
packm=activity.getPackageManager()
wallman=WallpaperManager.getInstance(this)
imm=activity.getSystemService(Context.INPUT_METHOD_SERVICE)
clipboard=this.getSystemService(Context.CLIPBOARD_SERVICE)
notificationManager =activity.getSystemService(Context.NOTIFICATION_SERVICE)

-- activity info and config
local resid=activity.getResources().getIdentifier("status_bar_height","dimen","android")
if resid>0 then
  状态栏高度 = activity.getResources().getDimensionPixelSize(resid)
 else
  状态栏高度 = math.floor(w*0.07)
end
w=this.width
h=this.height
window=activity.getWindow()
DecorView=window.getDecorView()
window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
--window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)
window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
if pcall(function ()
    xpcall(function()
      window.getDecorView().setSystemUiVisibility(fscreen|View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
      window.setNavigationBarColor(0xffffffff)
    end,function()
      DecorView.setSystemUiVisibility(fscreen|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
    end)
    window.setStatusBarColor(0)
  end) then else
  DecorView.setSystemUiVisibility(fscreen)
  window.setStatusBarColor(0x35000000)
end
LuaDir=this.getLuaDir().."/"
LuaPath=this.getLuaPath()
ShortcutIcon=LuaDir.."drawable/shortcut/"

--strings
lay_wh=w*0.0175
syswallheight = wallman. getDesiredMinimumHeight()
jinnian=os.date("%Y")
if jinnian~="2019" then
  banquannian="2019 - "..jinnian
end
Copyright_AllRights="Copyright © "..(banquannian or jinnian)..", AGYS Devs.\nAll Rights Reserved."

-- application info
pack_name=this.getPackageName()
xy_p=packm.getPackageInfo(pack_name, 64)
insTime=Calendar.getInstance().setTimeInMillis(xy_p.firstInstallTime)--.getTime().toLocaleString()
--toast(insTime,os.time())
insDay=insTime.get(Calendar.DAY_OF_MONTH)
insMon=insTime.get(Calendar.MONTH)+1

-- storage and path
sdcard=Environment.getExternalStorageDirectory().getPath().."/"
data=Environment.getDataDirectory().getPath().."/"
--toast (data)
应用数据=data.."data/"..pack_name.."/"
句子数据文件夹=应用数据.."words_data/"
设置项目文件夹=应用数据.."config/"
soup_save=句子数据文件夹.."soup"
wu_save=句子数据文件夹.."wu"
pinglun_save=句子数据文件夹.."reping"
jitang_save=句子数据文件夹.."jitang"
word_save=句子数据文件夹.."word"
--window.setNavigationBarColor(0xFFB8B8B8)
bground_path=应用数据.."bground"
本地版本=xy_p.versionName
内部版本=xy_p.versionCode
soup_logs=应用数据.."soups/"
app_path=sdcard.."WordsLeisure/"
bingwall=app_path.."BingWallpaper/"
wallpaper_path=app_path.."wallpaper/"
userfonts_path=app_path.."fonts/"
appfonts_path=应用数据.."fonts/"
句子收藏=应用数据.."favourite/"
个人语录=应用数据.."user_says/"
头像壁纸=app_path.."profilepic/"
表情包=app_path.."emotion/"
备份文件夹=app_path.."backup/"
通知历史=应用数据.."notifications/"
最新通知=设置项目文件夹.."notification"
今天条数=句子数据文件夹.."todaynum"
启用浮窗=设置项目文件夹.."floatwindowenabled"
browserdon=app_path.."browser_download/"
启用通知=设置项目文件夹.."notificationenabled"
--print(File(启用通知). exists ())
nightMode=设置项目文件夹.."nightenabled"
tosagreed=设置项目文件夹.."tosagreed"
WebCache={应用数据.."app_webview/",应用数据.."cache/",应用数据.."code_cache/"}
tongjifile=设置项目文件夹.."/6dutongji"
Bootpage=设置项目文件夹.."bootpageenabled"

-- make files and dirs
File(句子数据文件夹).mkdirs()
File(设置项目文件夹).mkdirs()

-- nightmode color strings
pcall(function ()
  nmo=io.open(nightMode):read("*a")
end)
if not nmo then
  io.open(nightMode,"w+"):write("false"):close()
end
if nmo=="true" then
  nightOverlayColor=0x65000000
  if pcall(function ()
      xpcall(function()
        window.getDecorView().setSystemUiVisibility(fscreen|View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
        window.setNavigationBarColor(0xff333333)
      end,function()
        DecorView.setSystemUiVisibility(fscreen|View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
      end)
    end) then
    window.setStatusBarColor(0)
   else
    window.setStatusBarColor(0x35000000)
  end
  DecorView.setSystemUiVisibility(fscreen)
  xpcall(function()
    this.setTheme(R.style.MUKTheme)
  end,function()
    this.setTheme(android.R.style.Theme_Material_NoActionBar)
  end)
  背景色=0xff333333
  文字色=0xcbffffff
  图标色=Color.WHITE
  次要文字色=0x90ffffff
  深透=0xcb333333
  浮窗背景色=0xB3333333
  淡透=0x01333333
  bgInverse=0x30ffffff
 else
  xpcall(function()
    this.setTheme(R.style.MUKTheme_Light)
  end,function()
    this.setTheme(android.R.style.Theme_Material_Light_NoActionBar)
  end)
  背景色=Color.WHITE
  文字色=0xff222222
  次要文字色=0xff666666
  图标色=Color.BLACK
  深透=0xcbffffff
  浮窗背景色=0xB3ffffff
  淡透=0x01ffffff
  bgInverse=0x30000000
end
淡色=Color.GRAY
淡色2=0xff666666
波纹色=0xcb666666

-- functions
function 字体(t)
  return Typeface.createFromFile(File(activity.getLuaDir().."/fonts/"..t..".ttf"))
end

defaultfont=字体("defaultfont")

function dp2px(dpValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return dpValue * scale + 0.5
end

function 波纹(颜色)
  local a=this.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless})
  local c=ColorStateList(int[0].class{int{}},int{颜色})
  pcall(function () rd=RippleDrawable(c, nil, nil) end)
  return rd
end

function newLog(c,t)
  local c=tostring (c)
  if c:sub(#c,#c)=="\n" then
    c=c:sub(1,#c-1)
  end
  local t=tostring (t)
  local log=soup_logs..os.time().."("..utf8.len(c).."_"..math.random(1,100)..")"
  --File(log).createNewFile()
  io.open(log,"w+"):write([[{
soup=]].."[["..c.."]]"..[[,
type=]].."[["..t.."]]"..[[,
}]]):close()
  c,t=nil,nil
end

function 透明(id,时间,透明度)
  local alph=ObjectAnimator.ofFloat(id,"alpha",透明度)
  alph.setDuration(时间)
  alph.start()
  return alph
end

function disableDrawer(b,p)
  if not p then
    p=3
  end
  if b then
    drawer.setDrawerLockMode(DrawerLayout.LOCK_MODE_LOCKED_CLOSED,p)
   else
    drawer.setDrawerLockMode(DrawerLayout.LOCK_MODE_UNLOCKED,p)
  end
end

function Y位移(id,时间,位置)
  local trans=ObjectAnimator.ofFloat(id,"translationY",位置)
  .setDuration(时间)
  .setInterpolator(AccelerateDecelerateInterpolator())
  .start()
  return trans
end

--水印样式
function wmark_1(l,r,i,p,mtop,f,yancl,longf)
  return {
    RelativeLayout,
    padding=p or 0,
    --layout_gravity="center",
    foreground=波纹(0x30000000),
    onClick=f,
    gravity="center",
    layout_width="fill",
    paddingTop=mtop or 状态栏高度,
    {
      TextView,
      text=l..r,
      id=i,
      textSize="34sp",
      padding="12dp",
      textColor=yancl or 文字色,
      Typeface=字体("defaultfont"),
    },
  }
end

function wmark_2(t1,t2,t3,t4,i,f,mleft,ucl)
  return {
    LinearLayout,
    orientation="vertical",
    foreground=波纹(0x30000000),
    onClick=f,
    id=i,
    padding="16sp",
    paddingLeft=mleft or 0,
    gravity="center",
    layout_width="fill",
    {
      LinearLayout,
      {
        TextView,
        textSize="14sp",
        text=t1,
        textColor=淡色,
        -- alpha=0.6,
        layout_marginRight="8dp",
      },
      {
        TextView,
        textSize="20sp",
        text=t2,
        textColor=ucl or 文字色,
      },
    },
    {
      LinearLayout,
      layout_marginTop="12dp",
      {
        TextView,
        text=t3,
        textColor=淡色,
        --alpha=0.6,
        textSize="14sp",
        layout_marginRight="8dp",
      },
      {
        TextView,
        textColor=ucl or 文字色,
        textSize="20sp",
        text=t4,
      },
    },
  }
end

function page(bitmap,txt,click,i,longc,wid,textcl,imcl)
  return {
    LinearLayout,
    gravity="center",
    layout_height="fill",
    layout_width=wid or "fill",
    id=tostring (i),
    {
      LinearLayout,
      orientation="vertical",
      onLongClickListener={
        onLongClick=longc or function () end,
      },
      gravity="center",
      onClick=click,
      foreground=波纹(波纹色),
      padding="8dp",
      {
        ImageView,
        ImageBitmap=bitmap,
        layout_width="47dp",
        layout_height="47dp",
        layout_gravity="center",
        padding="12dp",
        colorFilter=imcl or 图标色,
      },
      {
        TextView,
        text=tostring (txt),
        gravity="center",
        layout_gravity="center",
        textSize="14sp",
        textColor=textcl or 淡色,
      },
    },
  }
end

function shareText(t)
  local f,e=pcall(function ()
    activity.startActivity(Intent.createChooser(Intent(Intent.ACTION_SEND)
    .setType("text/plain")
    .putExtra(Intent.EXTRA_SUBJECT, "分享")
    .putExtra(Intent.EXTRA_TEXT, t)
    .setFlags(Intent.FLAG_ACTIVITY_NEW_TASK),"分享到:"))
  end)
  if e then
    toast ("无法进行分享")
  end
end

function copyText(content)
  local clipData=ClipData.newPlainText(nil,tostring(content))
  clipboard.setPrimaryClip(clipData)
  toast ("文本已复制到剪贴板")
end

function 上下渐变(color)
  return GradientDrawable(GradientDrawable.Orientation.TOP_BOTTOM,color)
end

function 圆角(控件,背景色,角度)
  local gd=GradientDrawable()
  .setShape(GradientDrawable.RECTANGLE)
  .setColor(背景色)
  .setCornerRadii(角度)
  if 控件 then
    控件.setBackgroundDrawable(gd)
  end
  return gd
end

function setDialogButtonColor(id,button,color)
  local win=id.getWindow()
  if Build.VERSION.SDK_INT >= 22 then
    import "android.graphics.PorterDuffColorFilter"
    import "android.graphics.PorterDuff"
    local b1=id.getButton(id.BUTTON_NEUTRAL)
    local b2=id.getButton(id.BUTTON_NEGATIVE)
    local b3=id.getButton(id.BUTTON_POSITIVE)
    if button==1 then
      b3.setTextColor(color)
     elseif button==2 then
      b2.setTextColor(color)
     elseif button==3 then
      b1.setTextColor(color)
     elseif button==0 then
      b1.setTextColor(color)
      b2.setTextColor(color)
      b3.setTextColor(color)
    end
    -- b1.getPaint().setFakeBoldText(true)
    --b2.getPaint().setFakeBoldText(true)
    --b3.getPaint().setFakeBoldText(true)
   else
    return false
  end
  pcall(function () id.findViewById(android.R.id.message).setTextIsSelectable(true) end)
end

function colorPicker(posifunc,negafunc)
  --颜色选择器 by YuXuan
  local pick=AlertDialog.Builder(this)
  .setPositiveButton ("设置颜色",posifunc)
  .setNegativeButton("取消",negafunc)
  .setView(loadlayout{
    LinearLayout;
    orientation="vertical";
    layout_height="fill";
    --backgroundColor=0xffffffff,
    layout_width="fill";
    id="clpk",
    gravity="center",
    {
      CardView,
      layout_marginTop="30dp",
      layout_height="85dp";
      layout_width="85dp";
      radius=360,
      elevation="10dp",
      id="mmp5",
    };
    {
      TextView,
      text="0xFF000000",
      id="mmp4",
      layout_width="fill";
      layout_height="48dp";
      textColor=文字色,
      gravity="center",
    };
    {
      LinearLayout;
      orientation="horizontal";
      layout_height="38dp";
      layout_width="fill";
      gravity="center",
      {
        TextView,
        text="A",
        layout_width="45dp";
        layout_height="fill";
        textColor=文字色,
        gravity="center",
      };
      {
        SeekBar;
        id="seek_Ap";
        OnSeekBarChangeListener={
          onProgressChanged=function(SeekBar,progress)
            local progress=progress+1
            local e=Integer.toHexString(progress-1)
            local e=string.upper(e)
            if #e==1 then
              e="0"..e
            end
            mmp6.setText(e)
            local d="0x"..mmp6.getText()..mmp1.getText()..mmp2.getText()..mmp3.getText()
            mmp4.setText(d)
            local ys=int(d)
            圆角(mmp5,ys,{360,360,360,360,360,360,360,360})
            -- toast(isDark(d:sub(5,6),d:sub(7,8),d:sub(9,10)))
          end},
        layout_width="260dp";
        layout_height="fill";
      },
      {
        TextView,
        text="FF",
        id="mmp6",
        layout_width="45dp";
        textColor=文字色,
        layout_height="fill";
        gravity="center",
      };
    },
    {
      LinearLayout;
      orientation="horizontal";
      layout_height="38dp";
      layout_width="fill";
      gravity="center",
      {
        TextView,
        text="R",
        layout_width="45dp";
        textColor=文字色,
        layout_height="fill";
        gravity="center",
      };
      {
        SeekBar;
        OnSeekBarChangeListener={
          onProgressChanged=function(SeekBar,progress)
            local progress=progress+1
            local a=Integer.toHexString(progress-1)
            local a=string.upper(a)
            if #a==1 then
              a="0"..a
            end
            mmp1.setText(a)
            local d="0x"..mmp6.getText()..mmp1.getText()..mmp2.getText()..mmp3.getText()
            mmp4.setText(d)
            local ys=int(d)
            圆角(mmp5,ys,{360,360,360,360,360,360,360,360})
          end},
        id="seek_red";
        layout_width="260dp";
        layout_height="fill";
      },
      {
        TextView,
        textColor=文字色,
        text="00",
        id="mmp1",
        layout_width="45dp";
        layout_height="fill";
        gravity="center",
      };
    },
    {
      LinearLayout;
      orientation="horizontal";
      layout_height="38dp";
      layout_width="fill";
      gravity="center",
      {
        TextView,
        text="G",
        layout_width="45dp";
        layout_height="fill";
        textColor=文字色,
        gravity="center",
      };
      {
        SeekBar;
        id="seek_green";
        layout_width="260dp";
        layout_height="fill";
        OnSeekBarChangeListener={
          onProgressChanged=function(SeekBar,progress)
            local progress=progress+1
            local b=Integer.toHexString(progress-1)
            local b=string.upper(b)
            if #b==1 then
              b="0"..b
            end
            mmp2.setText(b)
            local d="0x"..mmp6.getText()..mmp1.getText()..mmp2.getText()..mmp3.getText()
            mmp4.setText(d)
            local ys=int(d)
            圆角(mmp5,ys,{360,360,360,360,360,360,360,360})
          end},
      },
      {
        TextView,
        text="00",
        id="mmp2",
        textColor=文字色,
        layout_width="45dp";
        layout_height="fill";
        gravity="center",
      };
    },
    {
      LinearLayout;
      orientation="horizontal";
      layout_height="38dp";
      layout_width="fill";
      gravity="center",
      {
        TextView,
        text="B",
        textColor=文字色,
        layout_width="45dp";
        layout_height="fill";
        gravity="center",
      };
      {
        SeekBar;
        id="seek_blue";
        OnSeekBarChangeListener={
          onProgressChanged=function(SeekBar,progress)
            local progress=progress+1
            local c=Integer.toHexString(progress-1)
            local c=string.upper(c)
            if #c==1 then
              c="0"..c
            end
            mmp3.setText(c)
            local d="0x"..mmp6.getText()..mmp1.getText()..mmp2.getText()..mmp3.getText()
            mmp4.setText(d)
            local ys=int(d)
            圆角(mmp5,ys,{360,360,360,360,360,360,360,360})
          end},
        layout_width="260dp";
        layout_height="fill";
      },
      {
        TextView,
        textColor=文字色,
        text="00",
        id="mmp3",
        layout_width="45dp";
        layout_height="fill";
        gravity="center",
      };
    },
  })
  local pick=pick.show()
  -- setDialogButtonColor(pick,0,0xff444444)
  --setDialogButtonColor(pick,1,0xffff4500)
  -- .setCanceledOnTouchOutside(false)
  --[[ pick.onKey=function (dial,k,e)
    --toast (e.action)
    if k==4 and e.action==0 then
      dis(pick)
      return true
    end
  end]]
  local pw=pick.getWindow()
  .setWindowAnimations(R.style.BottomDialog_Animation)
  -- .setBackgroundDrawable(ColorDrawable(0))
  .setGravity(Gravity.BOTTOM)
  圆角(pw,背景色,{0,0,0,0,0,0,0,0})
  local lp=pw.getAttributes()
  lp.width=w
  pw.setAttributes(lp)
  pw.setDimAmount(0.35)
  --Y位移(clpk,350,{h,0})
  圆角(mmp5,Color.WHITE,{360,360,360,360,360,360,360,360})
  seek_Ap.setMax(255)
  seek_Ap.setProgress(255)
  seek_red.setMax(255)
  seek_red.setProgress(0)
  seek_green.setMax(255)
  seek_green.setProgress(0)
  seek_blue.setMax(255)
  seek_blue.setProgress(0)
  seek_Ap.ProgressDrawable.setColorFilter(PorterDuffColorFilter(文字色,PorterDuff.Mode.SRC_ATOP))
  seek_Ap.Thumb.setColorFilter(PorterDuffColorFilter(文字色,PorterDuff.Mode.SRC_ATOP))
  seek_red.ProgressDrawable.setColorFilter(PorterDuffColorFilter(Color.RED,PorterDuff.Mode.SRC_ATOP))
  seek_red.Thumb.setColorFilter(PorterDuffColorFilter(Color.RED,PorterDuff.Mode.SRC_ATOP))
  seek_green.ProgressDrawable.setColorFilter(PorterDuffColorFilter(Color.GREEN,PorterDuff.Mode.SRC_ATOP))
  seek_green.Thumb.setColorFilter(PorterDuffColorFilter(Color.GREEN,PorterDuff.Mode.SRC_ATOP))
  seek_blue.ProgressDrawable.setColorFilter(PorterDuffColorFilter(Color.BLUE,PorterDuff.Mode.SRC_ATOP))
  seek_blue.Thumb.setColorFilter(PorterDuffColorFilter(Color.BLUE,PorterDuff.Mode.SRC_ATOP))
end

function getViewBitmap(view)
  view.destroyDrawingCache()
  view.setDrawingCacheEnabled(true)
  view.buildDrawingCache()
  return view.getDrawingCache()
end

function showDialog(title,msg,pb,nb,pfun,nfun,pcl,ncl,iscancelable,neu,neufun,neucl)
  local pick=AlertDialog.Builder(this)
  if title then
    pick.setTitle(title)
  end
  if msg then
    pick.setMessage(msg)
  end
  if pb then
    pick.setPositiveButton(pb,pfun)
  end
  if nb then
    pick.setNegativeButton(nb,nfun)
  end
  if neu then
    pick.setNeutralButton(neu,neufun)
  end
  if type(iscancelable)=="boolean" then
    pick.setCancelable(iscancelable)
    --toast(type(iscancelable))
  end
  local pick=pick.show()
  if type(iscancelable)=="boolean" then
    pick.setCanceledOnTouchOutside(iscancelable)
  end
  --setDialogButtonColor(pick,0,0xff444444)
  if pcl then
    setDialogButtonColor(pick,1,pcl)
  end
  if neucl then
    setDialogButtonColor(pick,3,neucl)
  end
  if ncl then
    setDialogButtonColor(pick,2,ncl)
  end
  local pw=pick.getWindow()
  .setWindowAnimations(R.style.BottomDialog_Animation)
  --.setBackgroundDrawable(ColorDrawable(0))
  .setGravity(Gravity.BOTTOM)
  圆角(pw,背景色,{0,0,0,0,0,0,0,0})
  local lp=pw.getAttributes()
  lp.width=w
  pw.setAttributes(lp)
  pw.setDimAmount(0.35)
  --Y位移(clpk,350,{h,0})
end

function shareBitmap(bm)
  local uri=Uri.parse(MediaStore.Images.Media.insertImage(this.getContentResolver(), bm, nil,nil))
  local intent=Intent()
  intent.setAction(Intent.ACTION_SEND)
  intent.setType("image/*")
  intent.putExtra(Intent.EXTRA_STREAM, uri)
  local intent=Intent.createChooser(intent, "分享")
  if pcall(function ()
      this.startActivity(intent)
    end) then else
    toast ("无法进行分享")
  end
end

function savePicture(fileName,bitmap,note,noteSuccess,noteFail)
  --toast ("正在保存")
  local f,e=pcall(function ()
    out = FileOutputStream(File(tostring(fileName)))
    bitmap.compress(Bitmap.CompressFormat.PNG,100, out)
    out.flush()
    out.close()
  end)
  if not e then
    if note~=false then
      toast ("已保存到 "..fileName)
    end
    if noteSuccess then
      toast(noteSuccess)
    end
    updateMedia(tostring (File(fileName).getParentFile()))
    return true
   else
    if note~=false then
      toast ("保存失败")
    end
    if noteFail then
      toast(noteFail)
    end
    return false
  end
end

function setViewHeight(v,h)
  local p=v.getLayoutParams()
  p.height=h
  v.setLayoutParams(p)
end

function 补间透明(id,时,始,结)
  id.startAnimation(AlphaAnimation(始,结).setDuration(时))
end

function getFileCount(path)
  local fl=File(path).listFiles()
  if fl~=nil then
    return #luajava.astable(fl)
   else
    return 0
  end
end

function getFileList(path)
  local fl=File(path).listFiles()
  if fl~=nil then
    return luajava.astable(fl)
   else
    return {}--{"no file"}
  end
end

function StrToTable(str)
  if type(str)=="string" then
    stred=nil
    pcall(function ()
      stred=loadstring("return " .. str)()
    end)
    return stred or {}
   else
    return str or {}
  end
end

function contactQQ(q)
  if pcall(function ()
      this.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("mqqwpa://im/chat?chat_type=wpa&uin="..q)))
    end) then else
    toast ("未安装QQ")
  end
end

function addQQgroup(q)
  if pcall(function ()
      this.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("mqqapi://card/show_pslcard?src_type=internal&version=1&uin="..q.."&card_type=group&source=qrcode")))
    end) then else
    toast ("未安装QQ")
  end
end

function openInBrowser(url)
  if not pcall(function ()
      activity.startActivity(Intent("android.intent.action.VIEW",Uri.parse(url)))
    end) then
    toast ("无法打开")
  end
end

function toAppStore(pn)
  local intent = Intent("android.intent.action.VIEW")
  intent .setData(Uri.parse("market://details?id="..pn))
  if not pcall(function ()
      this.startActivity(intent)
    end) then
    toast ("无法打开")
  end
end

function vibrateOnce(t)
  vibman.vibrate(t)
end

function onPause()
  --collectgarbage("count")
  collectgarbage("collect")
end

function scanMedia(path)
  local values = ContentValues()
  values.put(MediaStore.Images.Media.DATA,path)
  values.put(MediaStore.Images.Media.DISPLAY_NAME, File(path).getName())
  this.getContentResolver().insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values)
end

function updateMedia(folder)
  local li=getFileList(folder)
  for n=1,#li do
    scanMedia(tostring(li[n]))
  end
end

function deletePic(path)
  local f=File(path)
  f.delete()
  this.getContentResolver().delete(
  MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
  MediaStore.Images.Media.DATA.." LIKE ?",{f.Path})
  toast("已删除")
end

function sendNotification(t,m,l)
  notificationManager.cancel(1)
  local t=t or ""
  local m=m or ""
  local l=l or "about:blank"
  pcall(function()
    channel = NotificationChannel("1", "XianYan", NotificationManager.IMPORTANCE_DEFAULT);
    notificationManager.createNotificationChannel(channel);
  end)
  pcall(function()
    local mBuilder = Notification.Builder(this)
    .setSmallIcon(R.drawable.icon)
    .setContentTitle(t)
    .setContentText(m)
    .setAutoCancel(true)
    .setOngoing(false)
    .setTicker(t.."\n"..m)
    .setWhen(System.currentTimeMillis())
    .setPriority(Notification.PRIORITY_DEFAULT)
    .setDefaults( Notification.DEFAULT_ALL --[[| Notification.DEFAULT_VIBRATE]])
    local notificationIntent =Intent(Intent.ACTION_VIEW, Uri.parse(l))
    local pendingIntent = PendingIntent.getActivity(activity.getApplicationContext(), 0, notificationIntent, Intent.FLAG_ACTIVITY_NEW_TASK)
    mBuilder.setContentIntent(pendingIntent).setAutoCancel(true)
    notificationManager.notify(0, mBuilder.build())
  end)
end

function setWallpaper(bm)
  local wid=bm.width
  local hei=bm.height
  local scale=syswallheight/hei
  if pcall(function ()
      wallman.setBitmap(Bitmap.createScaledBitmap(bm,wid*scale,hei*scale,true))
    end) then
    toast ("设置成功")
   else
    toast ("设置失败")
  end
end

function getBlurBitmap(bitmap,radius)
  if radius~=0 then
    --pcall(function ()
    local output=Bitmap.createBitmap(bitmap)
    local rs=RenderScript.create(this)
    local gaussian=ScriptIntrinsicBlur.create(rs, Element.U8_4(rs))
    local In=Allocation.createFromBitmap(rs, bitmap)
    local Out=Allocation.createFromBitmap(rs, output)
    gaussian.setRadius(radius)
    gaussian.setInput(In)
    gaussian.forEach(Out)
    Out.copyTo(output)
    if Build.VERSION.SDK_INT>=23 then
      rs.releaseAllContexts()
     else
      rs.destroy()
    end
    --end)
    return output or bitmap
   else
    return bitmap
  end
  collectgarbage("collect")
end

function InAppBrowser(...)
  this.newActivity("web",{...})
end

function sort(t,b)
  return {
    FrameLayout,
    layout_width="fill",
    {
      LinearLayout,
      backgroundColor=淡色,
      layout_width="fill",
      layout_height="0.75dp",
      layout_marginLeft="14dp",
      layout_gravity="center",
      layout_marginRight="14dp",
    },
    {
      TextView,
      text=tostring (t),
      textColor=淡色,
      textSize="14sp",
      layout_height="fill",
      layout_width="wrap",
      layout_gravity="center",
      padding="8dp",
      paddingLeft="14dp",
      paddingRight="14dp",
      backgroundColor=b or 背景色,
      gravity="center",
    },
  }
end

function showTerms(s,fun)
  pcall(function ()
    agreement=io.open(tosagreed):read("*a")
  end)
  if agreement~="true" or s then
    if not s then
      nb="不同意并退出"
      nf=function ()
        io.open(tosagreed,"w+"):write("false"):close()
        Process.killProcess(Process.myPid())
      end
      nc=0xffff4500
    end
    showDialog("温馨提示",[[欢迎使用闲言!
1.为更好的提供阅读体验、交流沟通、注册认证等相关服务，我们会根据您使用服务的具体功能需要，收集必要的用户信息(可能涉及账户、交易、设备等相关信息) ;
2.未经您同意，我们不会从第三方获取、共享或对外提供您的信息;
3.您可以访问、更正、删除您的个人信息，我们也将提供注销方式。]],"确定",nil,function()
      io.open(tosagreed,"w+"):write("true"):close()
      toast("您已同意服务协议，使用愉快")
      fun()
    end, nil,nil,nil,false,nb,nf,nc)
  end
  agreement,nb,nf,nc=nil,nil,nil,nil
end

PageTransAnim={
  ZoomIn=(PageView.PageTransformer{
    transformPage=function(page,position)
      local width = page.width
      local height = page.height
      if position > 0 and position <= 1 then
        page.setTranslationX(-width * position)
        page.setPivotX(width / 2)
        page.setPivotY(height / 2)
        page.setScaleX(1 - position)
        page.setScaleY(1 - position)
      end
    end
  }),
  Cube=(PageView.PageTransformer{
    transformPage=function(page,position)
      width = page.getWidth()
      local pivotX = 0
      if (position <= 1 and position > 0) then
        pivotX = 0
       elseif position < 0 and position >= -1 then
        pivotX = width
      end
      page.setPivotX(pivotX)
      page.setRotationY(60 * position)
    end
  })
}

function getFolderSize(folderPath,conversion)
  local size = 0
  if File(folderPath). exists () then
    local fileList = luajava.astable(File(folderPath).listFiles())
    if(fileList == nil) then
      return 0
    end
    if(fileList ~= nil) then
      for count=1,#fileList do
        if(File(tostring(fileList[count])).isDirectory()) then
          size = size + getFolderSize(tostring(fileList[count]))
         else
          local singleFileSize = File(tostring(fileList[count])).length()
          size = size + singleFileSize
        end
      end
    end
    if conversion==true then
      local GB = 1024 * 1024 * 1024
      local MB = 1024 * 1024
      local KB = 1024
      local countResult = ""
      if(size / GB >= 1) then
        countResult = string.format("%.2f",size / GB).."GB"
        return countResult
       elseif (size / MB >= 1) then
        countResult = string.format("%.2f",size / MB).."MB"
        return countResult
       elseif (size / KB >= 1) then
        countResult = string.format("%.2f",size / KB).."KB"
        return countResult
       else
        countResult = size.."B"
        return countResult
      end
     else
      return size
    end
   else
    return size
  end
end

mine_type={
  ["3gp"]="video/3gpp",
  ["apk"]="application/vnd.android.package-archive",
  ["asf"]="video/x-ms-asf",
  ["avi"]="video/x-msvideo",
  ["bin"]="application/octet-stream",
  ["bmp"]="image/bmp",
  ["c"]="text/plain",
  ["class"]="application/octet-stream",
  ["conf"]="text/plain",
  ["cpp"]="text/plain",
  ["doc"]="application/msword",
  ["docx"]="application/msword",
  ["exe"]="application/octet-stream",
  ["gif"]="image/gif",
  ["gtar"]="application/x-gtar",
  ["gz"]="application/x-gzip",
  ["h"]="text/plain",
  ["htm"]="text/html",
  ["html"]="text/html",
  ["jar"]="application/java-archive",
  ["java"]="text/plain",
  ["jpeg"]="image/jpeg",
  ["JPEG"]="image/jpeg",
  ["jpg"]="image/jpeg",
  ["js"]="application/x-javascript",
  ["log"]="text/plain",
  ["m3u"]="audio/x-mpegurl",
  ["m4a"]="audio/mp4a-latm",
  ["m4b"]="audio/mp4a-latm",
  ["m4p"]="audio/mp4a-latm",
  ["m4u"]="video/vnd.mpegurl",
  ["m4v"]="video/x-m4v",
  ["mov"]="video/quicktime",
  ["mp2"]="audio/x-mpeg",
  ["mp3"]="audio/x-mpeg",
  ["mp4"]="video/mp4",
  ["mpc"]="application/vnd.mpohun.certificate",
  ["mpe"]="video/mpeg",
  ["mpeg"]="video/mpeg",
  ["mpg"]="video/mpeg",
  ["mpg4"]="video/mp4",
  ["mpga"]="audio/mpeg",
  ["msg"]="application/vnd.ms-outlook",
  ["ogg"]="audio/ogg",
  ["pdf"]="application/pdf",
  ["png"]="image/png",
  ["pps"]="application/vnd.ms-powerpoint",
  ["ppt"]="application/vnd.ms-powerpoint",
  ["pptx"]="application/vnd.ms-powerpoint",
  ["prop"]="text/plain",
  ["rar"]="application/x-rar-compressed",
  ["rc"]="text/plain",
  ["rmvb"]="audio/x-pn-realaudio",
  ["rtf"]="application/rtf",
  ["sh"]="text/plain",
  ["tar"]="application/x-tar",
  ["tgz"]="application/x-compressed",
  ["txt"]="text/plain",
  ["wav"]="audio/x-wav",
  ["wma"]="audio/x-ms-wma",
  ["wmv"]="audio/x-ms-wmv",
  ["wps"]="application/vnd.ms-works",
  ["xml"]="text/plain",
  ["z"]="application/x-compress",
  ["zip"]="application/zip",
  [""]="file/*",
}

function openFile(path)
  local path=tostring(path)
  --if not File(path).isDirectory() then
  local intent = Intent()
  .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  .setAction(Intent.ACTION_VIEW)
  local ty = getFileType(path)
  intent.setDataAndType(Uri.fromFile(File(path)), ty)
  if pcall(function ()
      this.startActivity(intent)
    end) then else
    toast ("无法选择打开方式")
  end
  --end
end

function getFileType(fileName)
  local fileName = tostring(fileName)
  local s=fileName:gmatch("%.(.+)")
  local t={}
  for k in s do
    table.insert(t,k)
  end
  if File(fileName).isDirectory() then
    return "file/*"
   else
    return mine_type[t[#t] or ""] or "file/*"
  end
end

function onNewIntent(i)
  local i=this.getIntent()
  local a=i.getAction()
  local u=i.getData()
  --toast(i,u)
  if u then
    --local n=u.getQueryParameter("name")
  end
end

function onCreate()
  onNewIntent()
  if not this.getLuaPath():find("main%.lua") then
    local inf=conman.getActiveNetworkInfo()
    if inf~=nil and inf.isAvailable() then
      --has network
     else
      showDialog("无网络连接","请检查您的网络设置，否则部分功能将不可用。","好的")
    end
  end
end

function showCopyright()
  showDialog("闲言App 软件许可",软件许可,"同意并继续",nil, function ()
    toast("您已同意软件许可，使用愉快")
  end)
end

function openPicture(p)
  local i = Intent(Intent.ACTION_VIEW)
  i.setDataAndType(Uri.parse(p), "image/*")
  this.startActivity(i)
end

function toast(...)
  local tc={...}
  local tn=tostring (tc[1])
  for h=2,#tc do
    tn=tn.."\n".. tostring (tc[h])
  end
  Toast.makeText(this,"",0)
  -- .setGravity(Gravity.CENTER,0,0)
  .setView(loadlayout ({
    TextView,
    text=tn,
    textSize="14sp",
    Background=圆角(nil,波纹色,{17,17,17,17,17,17,17,17}),
    textColor=0xcbffffff,
    -- layout_width="100%w",
    gravity="center",
    padding="10dp",
    elevation=0;
  }))
  .show()
  tn=nil
end

function makeShortcut(str,str2,bm)
  local f,e=pcall(function ()
    local intent = Intent("android.intent.action.MAIN")
    intent.addCategory("android.intent.category.DEFAULT")
    intent.setClassName(pack_name, this.class.getName())
    intent.setData(Uri.parse(str))
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    local intent2 = Intent("com.android.launcher.action.INSTALL_SHORTCUT")
    intent2.putExtra("android.intent.extra.shortcut.NAME", str2)
    intent2.putExtra("android.intent.extra.shortcut.INTENT", intent)
    intent2.putExtra("duplicate", 0)
    intent2.putExtra("android.intent.extra.shortcut.ICON", bm)
    this.sendBroadcast(intent2)
  end)
  if not e then
    toast("创建快捷方式 "..str2.." 成功")
   else
    toast("创建失败")
  end
end

function MEditText(v)
  local TransY=0
  if v.text~=nil then
    TransY=-dp2px(24/2)
  end
  return function()
    return loadlayout({
      LinearLayout;
      layout_width=v.layout_width;
      layout_height=v.layout_height;
      {
        CardView;
        CardElevation="0dp";
        CardBackgroundColor=0x219e9e9e;
        Radius="4dp";
        layout_width="-1";
        layout_height="-2";
        {
          RelativeLayout;
          focusable=true;
          layout_width="-1";
          layout_height="-2";
          focusableInTouchMode=true;
          --paddingLeft="64dp";
          --paddingRight="64dp";
          {
            EditText;
            textColor=v.textColor;
            textSize="14sp";
            gravity="center|left";
            SingleLine=v.SingleLine;
            layout_width="-1";
            layout_height="-2";
            id=v.id;
            background="#00212121";
            padding="16dp";
            paddingTop="32dp";
            text=v.text;
            InputType=v.inputType;
            OnFocusChangeListener=({
              onFocusChange=function(vw,hasFocus)
                if hasFocus then
                  vw.getParent().getChildAt(1).setTextColor(文字色)
                  if vw.text=="" then
                    vw.getParent().getChildAt(1).startAnimation(TranslateAnimation(0,0,0,-dp2px(24/2)).setDuration(100).setFillAfter(true))
                  end
                 else
                  vw.getParent().getChildAt(1).setTextColor(v.HintTextColor)
                  if #vw.Text==0 then
                    vw.getParent().getChildAt(1).TranslationY=0
                    vw.getParent().getChildAt(1).startAnimation(TranslateAnimation(0,0,-dp2px(24/2),0).setDuration(100).setFillAfter(true))
                   else
                    vw.getParent().getChildAt(1).setTextColor(文字色)
                  end

                end
              end});
          };
          {
            TextView;
            textColor=v.HintTextColor;
            text=v.hint;
            textSize="14sp";
            layout_width="-1";
            layout_height="-2";
            gravity="center|left";
            padding="16dp";
            paddingTop="24dp";
            TranslationY=TransY;
          };
        };
      };
    })
  end
end