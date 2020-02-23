require "import"
import "str"

File(头像壁纸).mkdirs()
qwp=0
qtp=0
fp=0
otp=0

function imgPreview(ex,fn)
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
    toast ("下载中")
    local fn=fn:gsub("/","_")
    --toast (fn)
    Http.download(ex,fn, function (c,n)
      if c==200 then
        toast ("下载成功，已下载到 "..fn)
        updateMedia(头像壁纸)
       else
        toast ("下载失败")
      end
    end)
  end)
  --[[.setNeutralButton("浏览器查看", function ()
           InAppBrowser(ex)
           end)]]
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

点击操作_1={
  onItemClick=function (g,v)
    local pat=v.getChildAt(1).text
    InAppBrowser(pat,"壁纸预览")
    -- imgPreview(pat,头像壁纸..os.time()..".png")
  end}
点击操作_2={
  onItemClick=function (g,v)
    local pat=v.getChildAt(1).text
    InAppBrowser(pat,"头像预览")
    -- imgPreview(pat,头像壁纸..os.time().."(pic).png")
  end}
长按操作_1={
  onItemLongClick=function (g,v)
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems({"查看","设为壁纸","分享图片","分享链接","复制链接","下载"}, function (d,n)
      local pat=v.getChildAt(1).text
      if n==0 then
        -- InAppBrowser(pat,"壁纸预览")
        imgPreview(pat,头像壁纸..os.time()..".png")
       elseif n==1 then
        local hei = wallman. getDesiredMinimumHeight()
        local wallpaper = Bitmap.createScaledBitmap(loadbitmap(pat), w, hei, true);
        if pcall(function ()
            setWallpaper(wallpaper)
          end) then
          --toast ("设置成功")
         else
          -- toast ("设置失败")
        end
       elseif n==2 then
        shareBitmap(loadbitmap(pat))
       elseif n==3 then
        shareText(pat)
       elseif n==4 then
        copyText(pat)
       else
        toast ("下载中")
        Http.download(pat,头像壁纸..os.time()..".png", function (c,f)
          if c==200 then
            toast ("下载成功，可在下载中查看")
            updateMedia(头像壁纸)
           else
            toast ("下载失败")
          end
        end)
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
长按操作_2={
  onItemLongClick=function (g,v)
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems({"查看","分享图片","分享链接","复制链接","下载"}, function (d,n)
      local pat=v.getChildAt(1).text
      if n==0 then
        --InAppBrowser(pat,"壁纸预览")
        imgPreview(pat,头像壁纸..os.time().."(pic).png")
       elseif n==1 then
        shareBitmap(loadbitmap(pat))
       elseif n==2 then
        shareText(pat)
       elseif n==3 then
        copyText(pat)
       else
        toast ("下载中")
        Http.download(pat,头像壁纸..os.time().."(pic).png", function (c,f)
          if c==200 then
            toast ("下载成功，可在下载中查看")
            updateMedia(头像壁纸)
           else
            toast ("下载失败")
          end
        end)
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

alay={
  FrameLayout,
  layout_width="fill",
  backgroundColor=背景色,
  layout_height=w,
  {
    ImageView,
    scaleType="centerCrop",
    id="wp",
    layout_width="fill",
    layout_height="fill",
  },
  {
    TextView,
    visibility=8,
    id="pa",
  },
}
play={
  FrameLayout,
  layout_width="fill",
  backgroundColor=背景色,
  layout_height=w/2,
  {
    ImageView,
    scaleType="centerCrop",
    id="wp",
    layout_width="fill",
    layout_height="fill",
  },
  {
    TextView,
    visibility=8,
    id="pa",
  },
}
qingpic=LuaAdapter(this,{},play)
qingwall=LuaAdapter(this,{},alay)
ewall=LuaAdapter(this,{},alay)
other=LuaAdapter(this,{},alay)
--adplist={qingpic,qingwall,ewall,other}

this.setContentView(loadlayout ({
  LinearLayout,
  layout_width="fill",
  id="main",
  layout_height="fill",
  --visibility=4,
  backgroundColor=背景色,
  orientation="vertical",
  --elevation="2%w",
  paddingTop=状态栏高度,
  --[[  {
    LinearLayout,
    layout_width="fill",
    layout_height=w*0.175,
    foreground=上下渐变({0xffffffff,0xcbffffff,0x01ffffff}),
  },]]
  {
    RelativeLayout,
    layout_width="fill",
    layout_height="56dp",
    gravity="center",
    padding="16dp",
    paddingTop="8dp",
    paddingBottom="8dp",
    --backgroundColor=0xffffffff,
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
      padding="9dp",
      colorFilter=图标色,
    },
    {
      ImageView,
      src="drawable/down_folder.png",
      layout_height="fill",
      layout_width="44dp" ,
      foreground=波纹(波纹色),
      onClick=function ()
        this.newActivity("thirdparty/wallpaper/saved_wall")
      end,
      padding="9dp",
      colorFilter=图标色,
      layout_alignParentRight=true,
    },
    {
      TextView,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      --layout_gravity="center",
      text="头像壁纸",
      textSize="20sp",
      textColor=文字色,
    },
  },
  {
    LinearLayout,
    id="tab",
    {
      TextView,
      layout_width="25%w",
      foreground=波纹(波纹色),
      onClick=function ()
        pgs.showPage(0)
      end,
      text="情侣壁纸",
      textColor=文字色,
      padding="8dp",
      --paddingLeft="16dp",
      --paddingRight="16dp",
      gravity="center",
    },
    {
      TextView,
      layout_width="25%w",
      text="情侣头像",
      foreground=波纹(波纹色),
      onClick=function ()
        pgs.showPage(1)
      end,
      textColor=文字色,
      gravity="center",
      alpha=0.5,
      -- paddingLeft="16dp",
      --paddingRight="16dp",
      padding="8dp",
    },
    {
      TextView,
      layout_width="25%w",
      foreground=波纹(波纹色),
      onClick=function ()
        pgs.showPage(2)
      end,
      text="恶搞壁纸",
      textColor=文字色,
      padding="8dp",
      --paddingLeft="16dp",
      --paddingRight="16dp",
      gravity="center",
      alpha=0.5,
    },
    {
      TextView,
      layout_width="25%w",
      text="其他壁纸",
      foreground=波纹(波纹色),
      onClick=function ()
        pgs.showPage(3)
      end,
      textColor=文字色,
      gravity="center",
      alpha=0.5,
      --paddingLeft="16dp",
      --paddingRight="16dp",
      padding="8dp",
    },
  },
  {
    RelativeLayout,
    {
      LinearLayout,
      id="nopic",
      orientation="vertical",
      -- visibility=8,
      layout_width='fill',
      layout_height="fill",
      gravity="center",
      {
        ImageView,
        src="drawable/package.png",
        layout_width='fill',
        colorFilter=图标色,
        layout_height="195dp",
        --adjustViewBounds=true,
        padding="32dp",
      },
      {
        TextView,
        layout_gravity="center",
        text="无图片",
        textColor=次要文字色,
        textSize="22sp",
      },
    },
    {
      PageView,
      onPageChangeListener={
        onPageSelected=function (p)
          for t=0,3 do
            tab.getChildAt(t).alpha=0.5
          end
          tab.getChildAt(p).alpha=1
          --[[if adplist[p+1].getCount()>0 then
nopic.setVisibility(8)
else
nopic.setVisibility(0)
end]]
          onPause()
        end},
      layout_width="fill",
      pages={
        {
          PullingLayout,
          PullUpEnabled=true,
          id="qw_pull",
          {
            GridView,
            onItemLongClickListener=长按操作_1,
            adapter=qingwall,
            layout_width="fill",
            numColumns=2,
            onItemClickListener=点击操作_1,
            fastScrollEnabled=true,
          },
        },
        {
          PullingLayout,
          PullUpEnabled=true,
          id="qp_pull",
          {
            GridView,
            adapter=qingpic,
            onItemClickListener=点击操作_2,
            onItemLongClickListener=长按操作_2,
            numColumns=2,
            fastScrollEnabled=true,
          },
        },
        {
          PullingLayout,
          PullUpEnabled=true,
          id="eg_pull",
          {
            GridView,
            onItemClickListener=点击操作_1,
            onItemLongClickListener=长按操作_1,
            adapter=ewall,
            layout_width="fill",
            numColumns=2,
            fastScrollEnabled=true,
          },
        },
        {
          PullingLayout,
          PullUpEnabled=true,
          id="qt_pull",
          {
            GridView,
            adapter=other,
            onItemClickListener=点击操作_1,
            onItemLongClickListener=长按操作_1,
            layout_width="fill",
            numColumns=2,
            fastScrollEnabled=true,
          },
        },
      },
      layout_height="fill",
      layout_width="fill",
      id="pgs",
    },
  },
}))

--情侣壁纸
function getQwall(b,v)
  if v then v.PullUpEnabled=false end
  if b>9 then
    toast ("已全部加载完毕")
    if v then v.loadmoreFinish(0) end
    onPause()
   else
    --for b=1,9 do
    pcall(function ()
      Http.get("https://bizhi.nihaowua.com/qinglv/"..b, function (c,n)
        if c==200 then
          local g=n:gmatch([[<li><img class="thumb" src="(.-)" alt="]])
          for k in g do
            pcall(function ()
              local bm=loadbitmap (k)
              local bw=bm.width
              local bh=bm.height
              if bw>w/3 then
                local sc=(w/2)/bw
                bw=bw*sc
                bh=bh*sc
              end
              other.add{
                wp={
                  ImageBitmap=Bitmap.createScaledBitmap(bm,bw,bh,true),
                },
                pa=k,
              }
            end)
          end
          qwp=b
          qingwall.notifyDataSetChanged()
          onPause()
          if v then v.loadmoreFinish(0) end
         else
          if v then v.loadmoreFinish(1) end
          --toast ("加载失败")
        end
        if v then v.PullUpEnabled=true end
      end)
    end)
    --end
  end
end

--情侣头像
function getQtou(t,v)
  if v then v.PullUpEnabled=false end
  if t>33 then
    toast ("已全部加载完毕")
    if v then v.loadmoreFinish(0) end
    onPause()
   else
    --for t=1,33 do
    pcall(function ()
      Http.get("https://bizhi.nihaowua.com/touxiang/"..t, function (c,n)
        if c==200 then
          local g=n:gmatch([[<li><img class="thumb" src="(.-)" alt="]])
          for k in g do
            pcall(function ()
              local bm=loadbitmap (k)
              local bw=bm.width
              local bh=bm.height
              if bw>w/3 then
                local sc=(w/2)/bw
                bw=bw*sc
                bh=bh*sc
              end
              other.add{
                wp={
                  ImageBitmap=Bitmap.createScaledBitmap(bm,bw,bh,true),
                },
                pa=k,
              }
            end)
          end
          qtp=t
          qingpic.notifyDataSetChanged()
          onPause()
          if v then v.loadmoreFinish(0) end
         else
          if v then v.loadmoreFinish(1) end
          --toast ("加载失败")
        end
        if v then v.PullUpEnabled=true end
      end)
    end)
    --end
  end
end

--恶搞
function getFunnyWall(p,v)
  if v then v.PullUpEnabled=false end
  if p>2 then
    toast ("已全部加载完毕")
    if v then v.loadmoreFinish(0) end
    onPause()
   else
    --for e=1,2 do
    pcall(function ()
      Http.get("https://bizhi.nihaowua.com/egao/"..p, function (c,n)
        if c==200 then
          local g=n:gmatch([[<li><img class="thumb" src="(.-)" alt="]])
          for k in g do
            pcall(function ()
              local bm=loadbitmap (k)
              local bw=bm.width
              local bh=bm.height
              if bw>w/3 then
                local sc=(w/2)/bw
                bw=bw*sc
                bh=bh*sc
              end
              other.add{
                wp={
                  ImageBitmap=Bitmap.createScaledBitmap(bm,bw,bh,true),
                },
                pa=k,
              }
            end)
          end
          fp=p
          ewall.notifyDataSetChanged()
          onPause()
          if v then v.loadmoreFinish(0) end
         else
          if v then v.loadmoreFinish(1) end
          --toast ("加载失败")
        end
        if v then v.PullUpEnabled=true end
      end)
    end)
    --end
  end
end

--其他
function getOtherWall(p,v)
  if v then v.PullUpEnabled=false end
  if p>40 then
    toast ("已全部加载完毕")
    if v then v.loadmoreFinish(0) end
    onPause()
   else
    --for q=1,40 do
    pcall(function ()
      Http.get("https://bizhi.nihaowua.com/luanqi/"..p, function (c,n)
        if c==200 then
          local g=n:gmatch([[<li><img class="thumb" src="(.-)" alt="]])
          for k in g do
            pcall(function ()
              local bm=loadbitmap (k)
              local bw=bm.width
              local bh=bm.height
              if bw>w/3 then
                local sc=(w/2)/bw
                bw=bw*sc
                bh=bh*sc
              end
              other.add{
                wp={
                  ImageBitmap=Bitmap.createScaledBitmap(bm,bw,bh,true),
                },
                pa=k,
              }
            end)
          end
          otp=p
          other.notifyDataSetChanged()
          onPause()
          if other.getCount()>0 then
            nopic.setVisibility(8)
          end
          if v then v.loadmoreFinish(0) end
         else
          if v then v.loadmoreFinish(1) end
          --toast ("加载失败")
        end
        if v then v.PullUpEnabled=true end
      end)
    end)
    --end
  end
end

--pcall(function ()
getQwall(1)
getQtou(1)
getFunnyWall(1)
getOtherWall(1)
--end)

qw_pull.onLoadMore=function (v)
  getQwall(qwp+1,v)
end

qp_pull.onLoadMore=function (v)
  getQtou(qtp+1,v)
end

eg_pull.onLoadMore=function (v)
  getFunnyWall(fp+1,v)
end

qt_pull.onLoadMore=function (v)
  getOtherWall(otp+1,v)
end

Http.get("https://bizhi.nihaowua.com/", function (c,n)
  if c~=200 and (n:find("validate certificate") or c>=400) then
    showDialog("此功能暂不可用","提供图片内容的网站发生问题，无法加载图片内容。","好的")
  end
end)

toast ("数据加载中")