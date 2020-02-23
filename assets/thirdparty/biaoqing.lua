require "import"
import "str"

File(表情包).mkdirs()
cp=0
menu={
  onItemLongClick=function (g,v)
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems({"查看","分享链接","复制链接","下载"}, function (d,n)
      local dpa=v.getChildAt(1).text
      if n==0 then
        local ex=dpa
        local edt=AlertDialog.Builder(this)
        -- .setCancelable(false)
        --  .setTitle("图片查看")
        .setView(loadlayout (
        {
          RelativeLayout,
          paddingTop="16dp",
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
          local picurl=ex:gsub("/","_")
          local back=".png"
          if picurl:find"gif" then
            back=".gif"
          end
          local pat=表情包..os.time()..back
          --toast (pat)
          Http.download(ex,pat, function (c,n)
            if c==200 then
              toast ("下载成功，可在下载中查看")
              updateMedia(表情包)
             else
              toast ("下载失败")
            end
          end)
        end)
        --.setNeutralButton("浏览器打开", function ()
        -- openInBrowser(ex)
        --  end)
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
       elseif n==1 then
        shareText(dpa)
       elseif n==2 then
        copyText(dpa)
       else
        local back=".png"
        if dpa:find"gif" then
          back=".gif"
        end
        toast ("下载中")
        Http.download(dpa,表情包..os.time()..back, function (c,f)
          if c==200 then
            toast ("下载成功，可在下载中查看")
            updateMedia(表情包)
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

elay={
  FrameLayout,
  layout_width="fill",
  backgroundColor=背景色,
  layout_height=w/3,
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
  {
    TextView,
    elevation="2dp",
    id="gi",
    textSize="10sp",
    foreground=圆角(nil,0x50000000,{0,0,0,0,12,12,0,0}),
    textColor=0,
  },
  {
    TextView,
    id="gii",
    elevation="2dp",
    textSize="10sp",
    textColor=Color.WHITE,
  },
}
emo=LuaAdapter(this,{},elay)
localemo=LuaAdapter(this,{},elay)

this.setContentView(loadlayout ({
  DrawerLayout,
  DrawerLockMode=DrawerLayout.LOCK_MODE_LOCKED_CLOSED,
  DrawerListener=DrawerLayout.DrawerListener{
    onDrawerSlide=function(v,i)
      main.setTranslationX(-i*w*0.62*0.75)
      if i==1 then
        onResume()
        drawer.setDrawerLockMode(DrawerLayout.LOCK_MODE_LOCKED_OPEN,5)
       elseif i==0 then
        onPause()
        isDrawerOpen=false
        disableDrawer(true,5)
       else
        isDrawerOpen=true
        disableDrawer(false,5)
      end
    end},
  id="drawer",
  {
    LinearLayout,
    layout_width="fill",
    id="main",
    layout_height="fill",
    --visibility=4,
    backgroundColor=背景色,
    orientation="vertical",
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
        colorFilter=图标色,
        layout_width="44dp" ,
        foreground=波纹(波纹色),
        onClick=function ()
          this.finish()
        end,
        padding="9dp",
      },
      {
        ImageView,
        colorFilter=图标色,
        src="drawable/down_folder.png",
        layout_height="fill",
        layout_width="44dp" ,
        foreground=波纹(波纹色),
        onClick=function ()
          drawer.openDrawer(5)
        end,
        padding="9dp",
        layout_alignParentRight=true,
      },
      {
        TextView,
        layout_width="fill",
        layout_height="fill",
        gravity="center",
        --layout_gravity="center",
        text="表情包",
        textSize="20sp",
        textColor=文字色,
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
          padding="24dp",
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
        PullingLayout,
        PullUpEnabled=true,
        id="emo_pull",
        {
          GridView,
          onItemLongClickListener=menu,
          adapter=emo,
          layout_width="fill",
          numColumns=3,
          onItemClickListener={
            onItemClick=function (p,v)
              menu.onItemLongClick(p,v)
            end},
          fastScrollEnabled=true,
        },
      },
    },
  },
  {
    LinearLayout,
    id="downman",
    layout_width="100%w",
    layout_height="fill",
    layout_gravity="right",
    onClick=function () end,
    paddingTop=状态栏高度,
    backgroundColor=背景色,
    orientation="vertical",
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
        layout_width="44dp" ,
        foreground=波纹(波纹色),
        onClick=function ()
          drawer.closeDrawer(5)
        end,
        colorFilter=图标色,
        padding="9dp",
      },
      {
        TextView,
        layout_width="fill",
        layout_height="fill",
        gravity="center",
        --layout_gravity="center",
        text="已下载的图片",
        textSize="20sp",
        textColor=文字色,
      },
    },
    {
      RelativeLayout,
      {
        LinearLayout,
        id="nodown",
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
        GridView,
        adapter=localemo,
        layout_width="fill",
        numColumns=3,
        onItemClickListener={
          onItemClick=function (g,v)
            local i = Intent(Intent.ACTION_VIEW)
            local u= Uri.parse("file://"..v.getChildAt(1).text)
            i.setDataAndType(u, "image/*")
            this.startActivity(i)
          end},
        onItemLongClickListener={
          onItemLongClick=function (g,v)
            local edt=AlertDialog.Builder(this)
            -- .setCancelable(false)
            .setTitle("选择操作")
            .setItems({"查看","分享","删除"}, function (d,n)
              local dpa=v.getChildAt(1).text
              if n==0 then
                local i = Intent(Intent.ACTION_VIEW)
                local u= Uri.parse("file://"..dpa)
                i.setDataAndType(u, "image/*")
                this.startActivity(i)
               elseif n==1 then
                shareBitmap(loadbitmap (dpa))
               else
                showDialog("删除","是否删除该图片？此操作无法撤销。","删除","取消", function ()
                  deletePic(dpa)
                  refreshLocalPicList()
                end,nil,0xffff4500)
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
          end},
        fastScrollEnabled=true,
      },
    },
  },
}))

toast ("数据加载中")

function onKeyDown(k)
  if k==4 and (drawer.isDrawerOpen(5) or isDrawerOpen) then
    drawer.closeDrawer(5)
    return true
  end
end

function refreshLocalPicList()
  localemo.clear()
  local plist=getFileList(表情包)
  for a=1,#plist do
    local pat=tostring(plist[a])
    if pat:find"gif" then
      pcall(function ()
        localemo.add{
          wp=pat,
          pa=pat,
          gi=" GIF ",
          gii=" GIF ",
        }
      end)
     else
      pcall(function ()
        localemo.add{
          wp=pat,
          pa=pat,
          gi="",
          gii="",
        }
      end)
    end
  end
  localemo.notifyDataSetChanged()
  if localemo.getCount()>0 then
    nodown.setVisibility(8)
   else
    nodown.setVisibility(0)
  end
  updateMedia(表情包)
end

function onResume()
  refreshLocalPicList()
  --toast ("多项打印","测试",h)
  onPause()
end

function getEmotions(p,v)
  if v then v.PullUpEnabled=false end
  if p>3626 then
    toast ("已全部加载完毕")
    if v then v.loadmoreFinish(0) end
    onPause()
   else
    --for q=1,40 do
    pcall(function ()
      Http.get("https://www.wubiaoqing.com/category/hot/"..p.."/", function (c,n)
        if c==200 then
          local n=n:match([[<div class="gallery">
		<ul>(.-)</ul>
	</div>]])
          local g=n:gmatch([["><img src="http(.-)" class="thumb" alt="]])
          for k in g do
            local k="http"..k
            --toast (k)
            local bm=loadbitmap (k)
            local bw=bm.width
            local bh=bm.height
            if bw>w/3 then
              local sc=(w/3)/bw
              bw=bw*sc
              bh=bh*sc
            end
            if k:find"gif" then
              pcall(function ()
                emo.add{
                  wp={
                    ImageBitmap=Bitmap.createScaledBitmap(bm,bw,bh,true),
                  },
                  pa=k,
                  gi=" GIF ",
                  gii=" GIF ",
                }
              end)
             else
              pcall(function ()
                emo.add{
                  wp={
                    ImageBitmap=Bitmap.createScaledBitmap(bm,bw,bh,true),
                  },
                  pa=k,
                  gi="",
                  gii="",
                }
              end)
            end
          end
          cp=p
          emo.notifyDataSetChanged()
          onPause()
          if v then v.loadmoreFinish(0) end
         else
          if v then v.loadmoreFinish(1) end
          toast ("加载失败")
        end
        if emo.getCount()>0 then
          nopic.setVisibility(8)
        end
        if v then v.PullUpEnabled=true end
      end)
    end)
    --end
  end
end

pcall(function ()
  getEmotions(1)
end)

emo_pull.onLoadMore=function (v)
  pcall(function ()
    getEmotions(cp+1,v)
  end)
  --toast(v)
end

Http.get("https://www.wubiaoqing.com/category/hot/", function (c,n)
  if c~=200 and (n:find("validate certificate") or c>=400) then
    showDialog("此功能暂不可用","提供图片内容的网站发生问题，无法加载图片内容。","好的")
  end
end)

toast ("数据加载中")