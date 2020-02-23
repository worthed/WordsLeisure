require "import"
import "str"

url,ti,webClient=...
File(browserdon).mkdirs()

if webClient then webClient=StrToTable(webClient) end

this.setContentView(loadlayout ({
  LinearLayout,
  layout_width="fill",
  layout_height="fill",
  --visibility=4,
  backgroundColor=背景色,
  orientation="vertical",
  --elevation="4dp",
  paddingTop=状态栏高度,
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
      ImageView,
      src="drawable/dots.png",
      layout_height="fill",
      colorFilter=图标色,
      layout_width="44dp",
      foreground=波纹(波纹色),
      onClick=function (v)
        local pop=PopupMenu(this,v)
        local menu=pop.Menu
        menu.add("刷新").onMenuItemClick=function(a)
          webView.reload()
        end
        if webView.canGoForward() then
          menu.add("前进").onMenuItemClick=function(a)
            webView.goForward()
          end
        end
        menu.add("复制链接").onMenuItemClick=function(a)
          copyText(webView.url)
        end
        menu.add("分享链接").onMenuItemClick=function(a)
          shareText(webView.url)
        end
        menu.add("浏览器打开").onMenuItemClick=function(a)
          openInBrowser(webView.url)
        end
        pop.show()
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
      textSize="20sp",
      id="title",
      text=ti,
      textColor=文字色,
      paddingLeft="52dp",
      paddingRight="52dp",
      singleLine=true,
      ellipsize="end",
    },
  },
  {
    FrameLayout,
    layout_width="fill",
    layout_height="fill",
    {
      PullingLayout,
      -- PullDownEnabled=true,
      id="webReload",
      {
        LuaWebView,
        id="webView",
        onLongClickListener={
          onLongClick=function (v)
            local hit=v.getHitTestResult()
            local ty=hit.type
            local ex=hit.extra
            print(ty,ex,hit)
            if ty==5 then
              --InAppBrowser(ex,"图片查看")
              --toast ("click image",ex)
              --[==[local edt=AlertDialog.Builder(this)
              -- .setCancelable(false)
              --  .setTitle("图片查看")
              .setView(loadlayout (
              {
                RelativeLayout,
                layout_width="fill",
                layout_height="fill",
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
                local pat=browserdon..picurl
                --toast (pat)
                Http.download(ex,pat, function (c,n)
                  if c==200 then
                    toast ("下载成功，可在管理-浏览器下载的图片中管理")
                    updateMedia(browserdon)
                   else
                    toast ("下载失败")
                  end
                end)
                --[[ local s=savePicture(pat, loadbitmap (ex),false)
      if s then
      toast ("下载成功，已下载到 "..pat)
       updateMedia(browserdon)
           else
           toast ("下载失败")
       end]]
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
              .setUseWideViewPort(true)]==]
             elseif ty==7 then
              --toast ("click url",ex)
              local edt=AlertDialog.Builder(this)
              -- .setCancelable(false)
              .setTitle("网页链接")
              .setMessage(ex)
              .setNegativeButton("取消",nil)
              .setPositiveButton("加载该网页",function()
                webView.loadUrl(ex)
              end)
              .setNeutralButton("浏览器打开", function ()
                openInBrowser(ex)
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
            end
          end},
        layout_width="fill",
        layout_height="fill",
      },
    },
    {
      LinearLayout,
      orientation="vertical",
      --gravity="center",
      layout_width="fill",
      id="err",
      visibility=8,
      BackgroundColor=背景色,
      layout_height="fill",
      {
        TextView,
        text=":(",
        textColor=次要文字色,
        textSize="56sp",
        padding="18dp",
      },
      {
        TextView,
        textColor=文字色,
        textSize="16sp",
        padding="16dp",
        text="网页无法打开",
        layout_marginLeft="4dp",
      },
      {
        TextView,
        id="errde",
        textSize="14sp",
        padding="16dp",
        layout_marginLeft="4dp",
        textColor=淡色,
        paddingTop="8dp",
        textIsSelectable=true,
      },
      {
        TextView,
        foreground=波纹(波纹色),
        onClick=function ()
          webView.reload()
        end,
        text="刷新网页",
        textSize="14sp",
        padding="16dp",
        layout_marginLeft="4dp",
        textColor=淡色,
        --paddingTop="8dp",
      },
    },
    {
      LinearLayout,
      orientation="vertical",
      --gravity="center",
      layout_width="fill",
      id="sslerr",
      visibility=8,
      BackgroundColor=背景色,
      layout_height="fill",
      {
        TextView,
        text=":(",
        textColor=次要文字色,
        textSize="56sp",
        padding="18dp",
      },
      {
        TextView,
        textColor=文字色,
        textSize="16sp",
        padding="16dp",
        text="证书错误",
        layout_marginLeft="4dp",
      },
      {
        TextView,
        id="sslerrde",
        textSize="14sp",
        padding="16dp",
        layout_marginLeft="4dp",
        textColor=淡色,
        paddingTop="8dp",
        textIsSelectable=true,
      },
      {
        TextView,
        text="继续前往该网站（不安全）",
        textSize="14sp",
        padding="16dp",
        layout_marginLeft="4dp",
        foreground=波纹(波纹色),
        textColor=淡色,
        --paddingTop="8dp",
      },
    },
  },
}))

webView.getSettings()
.setSupportZoom(true)
.setBuiltInZoomControls(true)
.setDisplayZoomControls(false)
.setLoadWithOverviewMode(true)
.setAcceptThirdPartyCookies(true)
.setAppCacheEnabled(true)
.setDatabaseEnabled(true)
.setDomStorageEnabled(true)
.setGeolocationEnabled(true)
.setMixedContentMode(WebSettings.MIXED_CONTENT_COMPATIBILITY_MODE)
.setOffscreenPreRaster(true)
.setUseWideViewPort(true)

webView.setWebViewClient(LuaWebViewClient(webClient or {
  onPageStarted=function (v,u)
    err.visibility=8
    title.text=v.title
    sslerr.visibility=8
    if u=="http://www.agyer.xyz/index.php/archives/6/" then
      this.newActivity("post",{u})
      v.goBack()
     elseif u:sub(1,4)=="http" then
      local pref=this.getSharedPreferences("Cookie",0)
      local domain=Uri.parse(u).host
      --print (domain.host)
      CookieManager.getInstance().setCookie(domain,pref.getString(domain,""))
    end
    onPause()
  end,
  onPageFinished=function (v,u)
    title.text=v.title
    if u:sub(1,4)=="http" then
      local perf=this.getSharedPreferences("Cookie",0)
      local domain=Uri.parse(u).host
      --toast (domain.host)
      perf.edit().putString(domain,CookieManager.getInstance().getCookie(domain)).apply()
    end
    if u:find"://agys.m.vxhrrb.cn/" then
      v.loadUrl([[javascript:
var down=document.getElementsByClassName("download_app");
down[0].remove();
var but=document.getElementById("share_box");
but.remove();
]])
    end
    onPause()
  end,
  shouldOverrideUrlLoading=function (v,u)
    if u:sub(1,4)~="http" and u:sub(1,10)~="javascript" then
      v.stopLoading()
      -- print ("override",u)
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
    --  print(e)
    err.visibility=0
    errde.text=tostring (e)
    title.text=v.title
  end}))
webView.setDownloadListener{
  onDownloadStart=function(u, ua, des, ty, ln)
    --print (u, ua, des, ty, ln)
    showDialog("文件下载","文件链接\n"..u.."\n\n文件类型\n"..ty.."\n\n文件大小\n"..string.format("%.2f",(ln/1024)/1024).." MB","下载文件","取消", function ()
      openInBrowser(u)
    end)
  end}

webView.loadUrl(url)

if nightOverlayColor then
  webView.Parent.addView(loadlayout ({
    LinearLayout,
    layout_width="fill",
    layout_height="fill",
    foreground=ColorDrawable(nightOverlayColor),
    elevation="2dp",
  }))
end

webReload.onRefresh=function (v)
  webView.reload()
  v.refreshFinish(0)
  v.setPullDownEnabled(false)
end

webView.onScrollChange=function (v,x,y)
  if y>0 then
    webReload.setPullDownEnabled(false)
   else
    webReload.setPullDownEnabled(true)
    task(1000, function ()
      webReload.setPullDownEnabled(false)
    end)
  end
end