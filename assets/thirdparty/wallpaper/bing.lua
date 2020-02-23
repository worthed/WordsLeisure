require "import"
import "str"

File(bingwall).mkdirs()
olc=function (g,vi)
  local edt=AlertDialog.Builder(this)
  -- .setCancelable(false)
  .setTitle("选择操作")
  .setItems({"查看","保存图片","设为壁纸","分享图片","分享链接","复制链接"}, function (d,n)
    local p=vi.getChildAt(3).text
    local d=vi.getChildAt(2).text
    local bm=loadbitmap (p)
    if n==0 then
      imgPreview(p,d)
     elseif n==1 then
      Http.download(p,bingwall..d..".png", function (c,n)
        if c==200 then
          toast ("下载成功")
          updateMedia(bingwall)
         else
          toast ("下载失败")
        end
      end)
     elseif n==2 then
      setWallpaper(bm)
     elseif n==3 then
      shareBitmap(bm)
     elseif n==4 then
      shareText(p)
     else
      copyText(p)
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
end

function imgPreview(ex,d)
  local edt=AlertDialog.Builder(this)
  -- .setCancelable(false)
  -- .setTitle("图片查看")
  .setView(loadlayout ({
    RelativeLayout,
    {
      LuaWebView,
      id="viewpic",
      layout_width="fill",
      verticalScrollBarEnabled=false,
      horizontalScrollBarEnabled=false,
      --overScrollMode=2,
      -- BackgroundColor=0,
      layout_height="fill",
    },
  }))
  .setNegativeButton("取消",nil)
  .setPositiveButton("下载图片",function()
    local fn=bingwall..d..".png"
    Http.download(ex,fn, function (c,n)
      if c==200 then
        toast ("下载成功，已下载到 "..fn)
        updateMedia(bingwall)
       else
        toast ("下载失败")
      end
    end)
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
  viewpic.loadUrl(ex)
  viewpic.getSettings()
  .setSupportZoom(true)
  .setBuiltInZoomControls(true)
  .setDisplayZoomControls(false)
  .setLoadWithOverviewMode(true)
  .setAppCacheEnabled(true)
  .setMixedContentMode(WebSettings.MIXED_CONTENT_COMPATIBILITY_MODE)
  .setOffscreenPreRaster(true)
  .setUseWideViewPort(true)
end

msg_list=LuaAdapter(this,{},{
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  --backgroundColor=0xffffffff,
  {
    ImageView,
    colorFilter=nightoverlay or 0,
    --gravity="center",
    id="tu",
    layout_width="fill",
    adjustViewBounds=true,
    paddingBottom="8dp",
  },
  {
    TextView,
    textColor=文字色,
    --gravity="center",
    id="des",
    padding="16dp",
    textSize="16sp",
    paddingBottom="8dp",
  },
  {
    TextView,
    textColor=次要文字色,
    textSize="14sp",
    padding="16dp",
    paddingTop=0,
    layout_gravity="right|center",
    id="dt",
  },
  {
    TextView,
    visibility=8,
    id="pt",
  },
})

this.setContentView(loadlayout ({
  LinearLayout,
  layout_width="fill",
  layout_height="fill",
  --visibility=4,
  backgroundColor=背景色,
  orientation="vertical",
  --elevation="2%w",
  paddingTop=状态栏高度,
  {
    RelativeLayout,
    layout_width="fill",
    layout_height="56dp",
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
      text="必应壁纸",
      textSize="20sp",
      textColor=文字色,
    },
    {
      ImageView,
      src="drawable/down_folder.png",
      layout_height="fill",
      layout_width="44dp" ,
      foreground=波纹(波纹色),
      onClick=function ()
        this.newActivity("thirdparty/wallpaper/saved_wall",{2})
      end,
      padding="9dp",
      colorFilter=图标色,
      layout_alignParentRight=true,
    },
  },
  {
    TextView,
    text="以下展示近 7 天的壁纸",
    textColor=淡色,
    textSize="12sp",
    layout_width="fill",
    gravity="center",
    padding="8dp",
    paddingLeft="16dp",
    paddingRight="16dp",
    paddingTop=0,
  },
  {
    RelativeLayout,
    layout_width="fill",
    layout_height="fill",
    {
      ListView,
      layout_width="fill",
      layout_height="fill",
      onItemClickListener={
        onItemClick=function (p,v)
          olc(p,v)
        end},
      onItemLongClickListener={
        onItemLongClick=function (g,vi)
          olc(g,vi)
          return true
        end},
      adapter=msg_list,
      id="ml",
      dividerHeight=0,
    },
    {
      LinearLayout,
      layout_width="fill",
      orientation="vertical",
      layout_height="fill",
      gravity="center",
      --paddingTop=lay_wh,
      id="nomsg",
      {
        ImageView,
        src="drawable/package.png",
        layout_width='fill',
        layout_height="195dp",
        --adjustViewBounds=true,
        padding="32dp",
        colorFilter=图标色,
        --visibility=8,
      },
      {
        TextView,
        text="无图片",
        gravity="center",
        id="wait",
        --  layout_width="fill",
        --  layout_height="fill",
        textColor=次要文字色,
        textSize="22sp",
      },
    },
  },
}))

Http.get("https://cn.bing.com/HPImageArchive.aspx?format=js&idx=-1&n=7&mkt=zh-CN", function (c,n)
  if c==200 then
    local n=cjson.decode(n)
    for s=1,7 do
      pcall(function ()
        local picurl="https://cn.bing.com/"..n.images[s].url
        local date=n.images[s].enddate
        local cr=n.images[s].copyright
        local wall=loadbitmap (picurl)
        local scale=w/wall.width
        msg_list.add{
          tu={
            ImageBitmap=Bitmap.createScaledBitmap(wall,w,wall.height*scale,true),
          },
          des=cr,
          dt=date,
          pt=picurl,
        }
      end)
    end
    msg_list.notifyDataSetChanged()
    if msg_list.getCount()>0 then
      nomsg.setVisibility(8)
     else
      nomsg.setVisibility(0)
    end
   else
    toast("无法加载壁纸内容")
  end
end)

toast("数据加载中")