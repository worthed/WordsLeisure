require "import"
import "str"

句子,whole=...

pcall(function () niOn=io.open(nightMode):read("*a") end)
nOn=niOn or "false"
if nOn=="true" then
  dfDjtCl="0xFFFFFFFF"
  qjs="0x35000000"
 else
  dfDjtCl="0xFF000000"
  qjs="0x35FFFFFF"
end

pcall(function ()
  sp=io.open(soup_save):read("*a")
  savedPreviousSoup=sp
  鸡汤内容=sp
end)
--pcall(function () wp=io.open(wu_save):read("*a") end)
--pcall(function () wrp=io.open(word_save):read("*a") end)
File(soup_logs).mkdirs()
File(wallpaper_path).mkdirs()
File(句子收藏).mkdirs()

历史长按操作={
  onItemLongClick=function (g,vi)
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems({"制作壁纸","添加收藏","分享内容","复制内容","删除"}, function (d,n)
      local hiscon=vi.getChildAt(0).text
      if n==0 then
        local con=vi.getChildAt(0).text
        local ty=vi.getChildAt(1).text
        pcall(function () fl_djt.setText(con) end)
        if ty:find"毒鸡汤" then
          setSidebarItem(side_djt)
          source=1
          --[[   elseif ty=="你好污啊" then
      setSidebarItem(side_nihaowu)
   source=2]]
         elseif ty=="一言" then
          setSidebarItem(side_yiyan)
          source=3
         elseif ty=="心灵鸡汤" then
          setSidebarItem(side_jt)
          source=4
         elseif ty=="云音乐热评" then
          setSidebarItem(side_rp)
          source=5
         else

        end
        djt.text=con
        title.text=ty
        鸡汤内容=djt.text
        drawer.closeDrawer(5)
       elseif n==2 then
        shareText(hiscon.."\n    ——闲言APP 最好的阅读平台")
       elseif n==3 then
        copyText(hiscon.."\n    ——闲言APP 最好的阅读平台")
       elseif n==1 then
        local p=vi.getChildAt(2).text
        local nm=File(p).Name
        LuaUtil.copyDir(p,句子收藏..nm)
        toast ("已加收藏，可在灵感中管理")
       else
        showDialog("删除历史记录","记录内容："..hiscon.."\n\n是否删除此记录？此操作无法撤销。","删除","取消", function ()
          File(vi.getChildAt(2).text).delete()
          refreshHistory()
          toast("已删除")
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
  end}

历史单击操作={
  onItemClick=function (p,v)
    历史长按操作.onItemLongClick(p,v)
  end}

--字体列表
flay={
  LinearLayout,
  layout_width="fill",
  {
    TextView,
    textColor=次要文字色,
    --gravity="center",
    id="tn",
    textSize="16sp",
    padding="14dp",
    --ems=8,
    singleLine=true,
    ellipsize="end",
  },
  {
    TextView,
    visibility=8,
    id="fp",
  },
}
font_adp=LuaAdapter(this,{},flay)
system_fonts=getFileList("/system/fonts/")
font_adp.add{
  tn="系统默认",
  fp="default",
}

function onCreate()
  for f=1,#system_fonts do
    local fontpath=tostring (system_fonts[f])
    font_adp.add{
      tn=File(fontpath).getName(),
      fp=fontpath,
    }
  end
  if not sp then
    getSoup()
   else
    透明(pgs,350,{1,0})
    透明(getanopgs,350,{1,0})
  end
  if activity.getSharedData("password")~=nil then
    登录账号(t1url,t1key,activity.getSharedData("username"),activity.getSharedData("password"),t1httk,function(返回值)
      if 返回值=="401" then
        toast("出现异常！")
       else
        data=cjson.decode(返回值)
        if data["code"]=="1" then
          ch_title.Text=activity.getSharedData("username")
          ch_subtitle.Text="Sup到期时间:"..data["vip_time"]
          activity.setSharedData("sup",data["vip_time"])
         elseif data["code"]=="0" then
          toast(data["message"])
        end
      end
    end)
  end
end

--与导入/联网下载的字体
imported_fonts=LuaAdapter(this,{},flay)
function refreshInAppFont()
  imported_fonts.clear()
  local upf=getFileList(userfonts_path)
  for f=1,#upf do
    pcall (function ()
      local fontpath=tostring (upf[f])
      imported_fonts.add{
        tn=File(fontpath).getName(),
        fp=fontpath,
      }
    end)
  end
  local apf=getFileList(appfonts_path)
  for f=1,#apf do
    pcall(function()
      local fontpath=tostring (apf[f])
      imported_fonts.add{
        tn=File(fontpath).getName(),
        fp=fontpath,
      }
    end)
  end
  if imported_fonts.getCount()>0 then
    txtimfnt.Parent.setVisibility(0)
   else
    txtimfnt.Parent.setVisibility(8)
  end
end

--背景图显示类型
scaletype_adp=LuaAdapter(this,{},{
  TextView,
  textColor=次要文字色,
  --gravity="center",
  id="sct",
  textSize="16sp",
  padding="14dp",
  --ems=8,
  singleLine=true,
  layout_width="fill",
  ellipsize="end",
})
st={"放大剪裁","拉伸填充","居中"}
for p=1,#st do
  scaletype_adp.add{sct=st[p]}
end

--句子记录
histslay={
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  --backgroundColor=背景色,
  {
    TextView,
    textColor=文字色,
    --gravity="center",
    id="nr",
    textSize="18sp",
    padding="16dp",
    paddingBottom="10dp",
  },
  {
    TextView,
    textColor=淡色,
    textSize="14sp",
    padding="16dp",
    paddingTop=0,
    paddingBottom="8dp",
    layout_gravity="right|center",
    id="lx",
  },
  {
    TextView,
    id="lj",
    visibility=8,
  },
}
hislay={
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  --backgroundColor=背景色,
  {
    TextView,
    textColor=文字色,
    --gravity="center",
    id="nr",
    textSize="18sp",
    padding="16dp",
  },
  {
    TextView,
    visibility=8,
    id="lx",
  },
  {
    TextView,
    id="lj",
    visibility=8,
  },
}
all_hists=LuaAdapter(this,{},histslay)
du_hists=LuaAdapter(this,{},hislay)
ji_hists=LuaAdapter(this,{},hislay)
rp_hists=LuaAdapter(this,{},hislay)
--wu_hists=LuaAdapter(this,{},hislay)
yan_hists=LuaAdapter(this,{},hislay)
--历史adapter
local adps={all_hists,ji_hists,du_hists,--[[wu_hists,]]yan_hists,rp_hists}

--设置布局
this.setContentView(loadlayout({
  DrawerLayout,
  id="drawer",
  --ScrimColor=淡色,
  DrawerListener=DrawerLayout.DrawerListener{
    onDrawerSlide=function(v,i)
      if i==1 then
        djt.text=djt.text
      end
      if v==history then
        main.setTranslationX(-i*sideBar.width*0.75)
        if i==0 then
          disableDrawer(true,5)
          disableDrawer(false)
          rdopend=false
         elseif i==1 then
          disableDrawer(true)
          drawer.setDrawerLockMode(DrawerLayout.LOCK_MODE_LOCKED_OPEN,5)
          refreshHistory()
         else
          --disableDrawer(true)
          rdopend=true
        end
       elseif v==sideBar then
        --main.setTranslationX(i*sideBar.width)
        if i==1 then
          --[[local nowtime=tonumber(os.date("%H"))
          if getFileCount(soup_logs)>=100 and (nowtime>=8 and nowtime<22) then
            side_diandi.setVisibility(0)
           else
            side_diandi.setVisibility(8)
          end]]
         elseif i==0 then
          ldopend=false
         else
          ldopend=true
        end
      end
    end},
  --鸡汤主框架
  {
    RelativeLayout,
    id="main",
    BackgroundColor=背景色,
    --鸡汤顶栏部分
    {
      FrameLayout,
      padding="16dp",
      elevation="1dp",
      layout_height="56dp",
      id="main_topBar",
      paddingTop="8dp",
      layout_width="fill",
      paddingBottom="8dp",
      layout_marginTop=状态栏高度,
      {
        ImageView,
        src="drawable/menu.png",
        --id="titleicon",
        padding="9dp",
        ColorFilter=图标色,
        layout_width="44dp",
        layout_height="fill",
        onClick=function ()
          drawer.openDrawer(3)
        end,
        layout_gravity="left|center",
        foreground=波纹(波纹色),
      },
      {
        ImageView,
        ColorFilter=图标色,
        src="drawable/search.png",
        padding="9dp",
        layout_width="44dp",
        layout_height="fill",
        onClick=function ()
          activity.newActivity("app/search")
        end,
        --layout_alignParentRight=true,
        layout_gravity="right|center",
        foreground=波纹(波纹色),
        layout_marginRight="48dp";
      },
      {
        ImageView,
        ColorFilter=图标色,
        src="drawable/history.png",
        padding="9dp",
        layout_width="44dp",
        layout_height="fill",
        onClick=function ()
          drawer.openDrawer(5)
        end,
        --layout_alignParentRight=true,
        layout_gravity="right|center",
        foreground=波纹(波纹色),
      },
      {
        LinearLayout,
        layout_gravity="center",
        gravity="center",
        layout_width="fill",
        {
          ImageView,
          layout_width="44dp",
          layout_height="44dp",
        },
        {
          TextView,
          gravity="center",
          layout_marginLeft="8dp",
          layout_marginRight="8dp",
          textSize="20sp",
          text="毒鸡汤",
          id="title",
          onClick=function()
            --drawer.openDrawer(3)
          end,
          textColor=文字色,
        },
        {
          ProgressBar,
          id="pgs",
          padding="9dp",
          --visibility=4,
          layout_width="44dp",
          layout_height="44dp",
        },
      },
    },
    --背景图与鸡汤内容
    {
      RelativeLayout,
      id="ti",
      {
        ImageView,
        layout_width="fill",
        id="bg",
        layout_height="fill",
        foreground=ColorDrawable(tonumber(qjs)),
        scaleType="centerCrop",
        --adjustViewBounds=true,
        onClick=function ()
          djt.performClick()
        end,
      },
      {
        RelativeLayout,
        gravity="center",
        id="souparea",
        layout_height="fill",
        --显示鸡汤内容
        {
          TextView,
          id="djt",
          layout_width="fill",
          textSize="20sp",
          padding="32dp",
          onClick=function ()
            getSoup(function ()
              djt.y=h/2-djt.height/2
            end)
          end,
          onLongClickListener={
            onLongClick=function (v)
              -- return true
            end},
          --layout_gravity="center|left",
          textIsSelectable=true,
          --layout_height="fill",
          textColor=图标色,
          clickable=true,
          text=savedPreviousSoup or "正在盛上毒鸡汤",
        },
      },
      {
        LinearLayout,
        layout_width="fill",
        layout_height="fill",
        gravity="right|top",
        {
          LinearLayout,
          id="water_mark_main",
          visibility=8,
          wmark_1("闲","言","side_xian","9dp",nil,nil,Color.DKGRAY)
        },
      },
    },
    {
      FrameLayout,
      layout_width="fill",
      layout_height="fill",
      id="nightModeOverlay",
    },
    --鸡汤底栏
    {
      LinearLayout,
      orientation="vertical",
      gravity="center|left",
      id="main_bmbar",
      layout_width="fill",
      layout_alignParentBottom=true,
      -- clipChildren=true,
      {
        PageView,
        OverScrollMode=2,
        layout_height="96dp",
        -- clipChildren=true,
        -- clipToPadding=false,
        pages={
          page(loadbitmap("drawable/pencil.png"),"制作壁纸",function()
            makeWall()
          end,nil,nil,nil,次要文字色),
          page(loadbitmap("drawable/copy.png"),"复制内容", function ()
            copyText(djt.text.."\n    ——闲言APP 最好的阅读平台")
          end,nil,nil,nil,次要文字色),
          page(loadbitmap("drawable/share.png"),"分享内容", function ()
            shareText(djt.text.."\n    ——闲言APP 最好的阅读平台")
          end,nil,nil,nil,次要文字色),
          page(loadbitmap("drawable/save.png"),"保存分享", function ()
            Y位移(sharetype,350,{h,0})
            disableDrawer(true)
            shareshown=true
          end,nil,nil,nil,次要文字色),
        },
        layout_gravity="left|center",
        --layout_width="fill",
        offscreenPageLimit=5,
        pageMargin="-75%w",
        currentItem=1,
        id="bottom_bar";
      },
      --提示语
      {
        TextView,
        gravity="center",
        --layout_gravity="center",
        padding="8dp",
        layout_width="fill",
        layout_height="wrap",
        text="长按自由复制，点击获取另一条",
        id="notice",
        textSize="12sp",
        alpha=0.85,
        textColor=次要文字色,
      },
    },
    --设置水印
    {
      LinearLayout,
      layout_alignParentBottom=true,
      orientation="vertical",
      backgroundColor=背景色,
      y=h,
      id="wmark",
      layout_width="fill",
      elevation="10dp",
      gravity="center",
      {
        ImageView,
        src="drawable/arrow.png",
        ColorFilter=图标色,
        onClick=function ()
          Y位移(wmark,350,{0,h})
          if not isMakingWall then
            disableDrawer(false)
          end
          wmarkshown=false
        end,
        layout_width="fill",
        foreground=波纹(波纹色),
        OnTouchListener={
          onTouch=function (v,e)
            local y=e.getRawY()
            if not logY then
              logY=y
            end
            if logY>y then
              v.setRotation(180)
             else
              v.setRotation(0)
            end
            logY=y
            local hei=h-y
            if hei>=h/3.5 and hei<=(h/5)*4 and hei<=wmark.getChildAt(1).getChildAt(0).height then
              setViewHeight(wmark.getChildAt(1),hei)
            end
          end},
        onLongClickListener={
          onLongClick=function ()
            return true
          end},
        layout_height="30dp",
      },
      {
        ScrollView,
        layout_width="fill",
        layout_height=h/3.5,
        {
          LinearLayout,
          orientation="vertical",
          layout_width="fill",
          {
            FrameLayout,
            paddingRight="9dp",
            --layout_height=lay_wh,
            foreground=波纹(波纹色),
            onClick=function (v)
              v.getChildAt(1).performClick()
            end,
            layout_width="fill",
            {
              TextView,
              text="水印",
              textColor=文字色,
              padding="16dp",
              textSize="16sp",
              layout_height="fill",
              gravity="center|left",
            },
            {
              Switch,
              id="wmswt",
              layout_height="fill",
              --layout_alignParentRight=true,
              OnCheckedChangeListener={
                onCheckedChanged=function(v,isChecked)
                  if isChecked and isMakingWall then
                    water_mark_main.setVisibility(0)
                   else
                    water_mark_main.setVisibility(8)
                  end
                end},
              checked=true,
              layout_gravity="right|center",
            },
          },
          {
            TextView,
            text="水印仅在制作壁纸时显示",
            textColor=淡色,
            textSize="12sp",
            layout_width="fill",
            gravity="center",
            padding="16dp",
            paddingLeft="9dp",
            paddingRight="9dp",
          },
          sort("预览"),
          {
            LinearLayout,
            layout_gravity="center",
            gravity="center",
            --layout_height=lay_wh*2,
            id="wm_preview",
            wmark_1("闲","言","side_xian","9dp"),
          },
          sort("样式"),
          {
            HorizontalScrollView,
            horizontalScrollBarEnabled=false,
            {
              LinearLayout,
              gravity="center",
              id="wm_style_scr",
              --layout_height=lay_wh*3,
              layout_width="fill",
              wmark_1("闲","言","side_xian","9dp",nil,function (v)
                wm_preview.removeView(wm_preview.getChildAt(0))
                wm_preview.addView(loadlayout (wmark_1("闲","言","side_xian","9dp")))
                setSelectedStyleItem(v)
                water_mark_main.removeView(water_mark_main.getChildAt(0))
                water_mark_main.addView(loadlayout (wmark_1("闲","言","side_xian","9dp",nil,nil,Color.DKGRAY)))
              end,文字色),
              wmark_2("show in","闲言","by","手机","temp_2", function (v)
                wm_preview.removeView(wm_preview.getChildAt(0))
                wm_preview.addView(loadlayout (wmark_2("show in","闲言","by",Build.MANUFACTURER.." "..Build.MODEL,"temp_2")))
                setSelectedStyleItem(v)
                water_mark_main.removeView(water_mark_main.getChildAt(0))
                water_mark_main.addView(loadlayout (wmark_2("show in","闲言","by",Build.MANUFACTURER.." "..Build.MODEL,"temp_2",nil,"9dp",Color.DKGRAY)))
              end,"9dp"),
              page(loadbitmap("drawable/image.png"),"   图片水印   ",function(v)
                local bk=getViewBitmap(ti)
                wm_preview.removeView(wm_preview.getChildAt(0))
                wm_preview.addView(loadlayout ({
                  ImageView,
                  ImageBitmap=bk,
                  layout_width="14dp",
                  adjustViewBounds=true,
                }))
                setSelectedStyleItem(v)
                water_mark_main.removeView(water_mark_main.getChildAt(0))
                water_mark_main.addView(loadlayout ({
                  ImageView,
                  ImageBitmap=bk,
                  layout_width="14dp",
                  --layout_height="14dp",
                  adjustViewBounds=true,
                }))
              end,nil,nil,nil,nil,图标色),
              page(loadbitmap("drawable/textsize.png"),"   文字水印   ",function(v)
                wm_preview.removeView(wm_preview.getChildAt(0))
                wm_preview.addView(loadlayout ({
                  TextView,
                  text="闲言",
                  padding="16dp",
                  textSize="24sp",
                  textColor=文字色,
                }))
                setSelectedStyleItem(v)
                water_mark_main.removeView(water_mark_main.getChildAt(0))
                water_mark_main.addView(loadlayout ({
                  TextView,
                  text="闲言",
                  padding="16dp",
                  textSize="24sp",
                  textColor=Color.DKGRAY,
                }))
                -- twmtxt.text=""
              end,nil,nil,nil,nil,图标色),
            },
          },
          sort("外观"),
          {
            FrameLayout,
            --layout_height=lay_wh,
            layout_width="fill",
            padding="16dp",
            layout_gravity="center",
            onClick=function()
              selectWmImg()
            end,
            foreground=波纹(波纹色),
            id="sty3_contedt",
            visibility=8,
            layout_width="fill",
            {
              TextView,
              text="选择图片",
              textSize="16sp",
              textColor=文字色,
              gravity="center",
              layout_height="fill",
              layout_gravity="left|center",
            },
            {
              ImageView,
              src="drawable/arrow.png",
              rotation=-90,
              --layout_alignParentRight=true,
              layout_width="26dp",
              layout_height="26dp",
              ColorFilter=图标色,
              layout_gravity="right|center",
            },
          },
          {
            TextView,
            text="图片过大可能无法显示，GIF 仅显示第一帧",
            textColor=淡色,
            visibility=8,
            textSize="12sp",
            layout_width="fill",
            gravity="center",
            padding="16dp",
            id="pwm_note",
            paddingLeft="9dp",
            paddingRight="9dp",
          },
          {
            TextView,
            visibility=8,
            text="自定义内容",
            textColor=文字色,
            id="sty4_contedt",
            foreground=波纹(波纹色),
            onClick=function ()
              local edt=AlertDialog.Builder(this)
              .setTitle("自定义内容")
              .setCancelable(false)
              .setView(loadlayout ({
                LinearLayout,
                padding="16dp",
                paddingBottom=0,
                layout_width="fill",
                {
                  EditText,
                  layout_width="fill",
                  backgroundColor=0,
                  textSize="16sp",
                  text=wm_preview.getChildAt(0).text,
                  id="usaying",
                  hint="闲言",
                  textColor=文字色,
                  hintTextColor=次要文字色,
                },
              }))
              .setPositiveButton("设置文字", function ()
                local t=usaying.text
                if #t<1 then
                  water_mark_main.getChildAt(0).text="闲言"
                  wm_preview.getChildAt(0).text="闲言"
                 else
                  water_mark_main.getChildAt(0).text=t
                  wm_preview.getChildAt(0).text=t
                end
              end)
              .setNegativeButton("取消",nil)
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
            --layout_height=lay_wh,
            textSize="16sp",
            gravity="center|left",
            layout_width="fill",
            padding="16dp",
          },
          {
            FrameLayout,
            --layout_height=lay_wh,
            padding="16dp",
            layout_gravity="center",
            --gravity="center",
            layout_width="fill",
            {
              TextView,
              text="缩放",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center|left",
            },
            {
              SeekBar,
              layout_width="70%w",
              --id="wmscale",
              layout_gravity="center|right",
              -- layout_alignParentRight=true,
              OnSeekBarChangeListener={
                onProgressChanged=function(v,p)
                  local p=p*0.01+0.25
                  water_mark_main.scaleX=p
                  wm_preview.scaleX=p
                  water_mark_main.scaleY=p
                  wm_preview.scaleY=p
                end},
              layout_height="fill",
              max=75,
              progress=75,
            },
          },
          {
            FrameLayout,
            padding="16dp",
            --layout_height=lay_wh,
            layout_width="fill",
            {
              TextView,
              text="透明度",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center|left",
            },
            {
              SeekBar,
              layout_width="70%w",
              -- id="wmalph",
              --layout_alignParentRight=true,
              OnSeekBarChangeListener={
                onProgressChanged=function(v,p)
                  local p=1-p*0.01+0.15
                  water_mark_main.alpha=p
                  wm_preview.alpha=p
                end},
              max=85,
              --secondaryProgress=100,
              --progress=100,
              layout_gravity="center|right",
            },
          },
          sort("位置"),
          {
            LinearLayout,
            orientation="vertical",
            layout_width="fill",
            paddingRight="9dp",
            paddingLeft="9dp",
            id="wmarkpos",
            {
              RelativeLayout,
              {
                TextView,
                onClick=function (v)
                  setSelectedWmarkPos(v)
                  local wm=water_mark_main.getChildAt(0)
                  if wm then
                    water_mark_main.Parent.setGravity(Gravity.LEFT|Gravity.TOP)
                  end
                end,
                foreground=波纹(波纹色),
                text="左上",
                padding="16dp",
                textColor=文字色,
              },
              {
                TextView,
                backgroundColor=bgInverse,
                padding="16dp",
                textColor=文字色,
                onClick=function (v)
                  setSelectedWmarkPos(v)
                  local wm=water_mark_main.getChildAt(0)
                  if wm then
                    water_mark_main.Parent.setGravity(Gravity.RIGHT|Gravity.TOP)
                  end
                end,
                foreground=波纹(波纹色),
                text="右上",
                layout_alignParentRight=true,
              },
            },
            {
              RelativeLayout,
              layout_marginTop=lay_wh/2,
              {
                TextView,
                text="左下",
                padding="16dp",
                textColor=文字色,
                onClick=function (v)
                  setSelectedWmarkPos(v)
                  local wm=water_mark_main.getChildAt(0)
                  if wm then
                    water_mark_main.Parent.setGravity(Gravity.LEFT|Gravity.BOTTOM)
                  end
                end,
                foreground=波纹(波纹色),
                id="wmleftdown",
                --layout_toBottomOf="wmleftup",
                -- backgroundColor=淡色,
              },
              {
                TextView,
                textColor=文字色,
                text="右下",
                padding="16dp",
                layout_alignParentRight=true,
                onClick=function (v)
                  setSelectedWmarkPos(v)
                  local wm=water_mark_main.getChildAt(0)
                  if wm then
                    water_mark_main.Parent.setGravity(Gravity.RIGHT|Gravity.BOTTOM)
                  end
                end,
                foreground=波纹(波纹色),
                --backgroundColor=淡色,
              },
            },
          },
          --水印设置
        },
      },
    },
    --文字属性设置
    {
      LinearLayout,
      layout_alignParentBottom=true,
      orientation="vertical",
      backgroundColor=背景色,
      y=h,
      id="textset",
      elevation="10dp",
      onClick=function () end,
      gravity="center",
      layout_width="fill",
      {
        ImageView,
        src="drawable/arrow.png",
        onClick=function ()
          Y位移(textset,350,{0,h})
          tsetshown=false
        end,
        ColorFilter=图标色,
        onLongClickListener={
          onLongClick=function ()
            return true
          end},
        OnTouchListener={
          onTouch=function (v,e)
            local y=e.getRawY()
            if not logY then
              logY=y
            end
            if logY>y then
              v.setRotation(180)
             else
              v.setRotation(0)
            end
            logY=y
            local hei=h-y
            if hei>=h/3.5 and hei<=(h/5)*4 and hei<=tsetscr.getChildAt(0).height then
              setViewHeight(textset.getChildAt(1),hei)
            end
          end},
        layout_width="fill",
        foreground=波纹(波纹色),
        layout_height="30dp",
      },
      {
        ScrollView,
        layout_height=h/3.5,
        --OverScrollMode=2,
        id="tsetscr",
        layout_width="fill",
        {
          LinearLayout,
          layout_width="fill",
          orientation="vertical",
          sort("内容"),
          {
            TextView,
            text="自定义内容",
            textColor=文字色,
            foreground=波纹(波纹色),
            onClick=function ()
              local edt=AlertDialog.Builder(this)
              .setTitle("自定义内容")
              .setCancelable(false)
              .setView(loadlayout ({
                LinearLayout,
                padding="16dp",
                paddingBottom=0,
                layout_width="fill",
                {
                  EditText,
                  layout_width="fill",
                  backgroundColor=0,
                  textSize="16sp",
                  text=djt.text,
                  textColor=文字色,
                  hintTextColor=次要文字色,
                  id="usaying",
                  hint="输入句子内容",
                },
              }))
              .setPositiveButton("保存更改", function ()
                local cont=usaying.text
                djt.text=cont
              end)
              .setNegativeButton("取消",nil)
              if djt.text~=鸡汤内容 then
                edt.setNeutralButton("重置内容",function()
                  djt.text=鸡汤内容
                end)
              end
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
            --layout_height=lay_wh,
            textSize="16sp",
            gravity="center|left",
            layout_width="fill",
            padding="16dp",
          },
          {
            LinearLayout,
            foreground=波纹(波纹色),
            onClick=function ()
              getSoup(function()
                -- djt.y=h/2-djt.height/2
              end)
            end,
            layout_width="fill",
            gravity="center|left",
            {
              TextView,
              text="获取另一条",
              textColor=文字色,
              -- layout_height=lay_wh,
              textSize="16sp",
              -- layout_width="fill",
              gravity="center",
              padding="16dp",
            },
            {
              ProgressBar,
              id="getanopgs",
              -- padding="1%w",
              --visibility=4,
              layout_width="26dp",
              layout_height="26dp",
            },
          },
          {
            TextView,
            text="重置内容",
            textColor=文字色,
            gravity="center|left",
            foreground=波纹(波纹色),
            onClick=function ()
              djt.text=鸡汤内容
            end,
            textSize="16sp",
            layout_width="fill",
            --layout_height=lay_wh,
            visibility=8,
            padding="16dp",
          },
          sort("字体"),
          {
            FrameLayout,
            foreground=波纹(波纹色),
            onClick=function ()
              txtimfnt.performClick()
            end,
            --layout_height=lay_wh,
            paddingRight="9dp",
            layout_width="fill",
            layout_gravity="center",
            {
              TextView,
              text="本地",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              padding="16dp",
              gravity="center|left",
            },
            {
              Spinner,
              adapter=imported_fonts,
              --监听在底部
              id="txtimfnt",
              layout_width="70%w",
              --layout_alignParentRight=true,
              layout_height="fill",
              gravity="center",
              layout_gravity="center|right",
            },
          },
          {
            FrameLayout,
            foreground=波纹(波纹色),
            onClick=function ()
              txtfnt.performClick()
            end,
            -- layout_height=lay_wh,
            paddingRight="9dp",
            layout_width="fill",
            layout_gravity="center",
            {
              TextView,
              text="系统",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              padding="16dp",
              gravity="center|left",
            },
            {
              Spinner,
              adapter=font_adp,
              --监听在底部
              id="txtfnt",
              layout_width="70%w",
              --layout_alignParentRight=true,
              layout_height="fill",
              --gravity="center|right",
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
              src="drawable/arrow.png",
              rotation=-90,
              --layout_alignParentRight=true,
              layout_width="26dp",
              ColorFilter=图标色,
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
              text="导入本地字体",
              textSize="16sp",
              textColor=文字色,
              layout_gravity="left|center",
              layout_height="fill",
              gravity="center",
            },
            {
              ImageView,
              src="drawable/arrow.png",
              rotation=-90,
              -- layout_alignParentRight=true,
              layout_width="26dp",
              layout_height="26dp",
              ColorFilter=图标色,
              layout_gravity="center|right",
            },
          },
          sort("外观"),
          {
            FrameLayout,
            padding="16dp",
            foreground=波纹(波纹色),
            onClick=function ()
              colorPicker(function ()
                local cl=mmp4.text
                txtcolr.text=tostring(cl)
                local cl=tonumber(cl)
                djt.setTextColor(cl)
              end)
            end,
            --layout_height=lay_wh,
            layout_width="fill",
            layout_gravity="center",
            {
              TextView,
              text="颜色",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center|left",
            },
            {
              TextView,
              text=dfDjtCl,
              textColor=次要文字色,
              id="txtcolr",
              textSize="16sp",
              --layout_alignParentRight=true,
              --gravity="center",
              layout_gravity="center|right",
            },
          },
          {
            FrameLayout,
            -- layout_height=lay_wh,
            padding="16dp",
            layout_width="fill",
            layout_gravity="center",
            {
              TextView,
              text="大小",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center",
            },
            {
              SeekBar,
              layout_width="70%w",
              id="txtsize",
              --layout_alignParentRight=true,
              OnSeekBarChangeListener={
                onProgressChanged=function(v,p)
                  local p=p+14
                  djt.textSize=p
                end},
              layout_height="fill",
              max=52,
              progress=6,
              --secondaryProgress=8,
              layout_gravity="center|right",
            },
          },
          {
            FrameLayout,
            padding="16dp",
            --layout_height=lay_wh,
            layout_width="fill",
            layout_gravity="center",
            {
              TextView,
              text="透明度",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center",
            },
            {
              SeekBar,
              layout_width="70%w",
              id="txtalph",
              --layout_alignParentRight=true,
              OnSeekBarChangeListener={
                onProgressChanged=function(v,p)
                  local p=1-p*0.01+0.15
                  djt.setAlpha(p)
                end},
              max=85,
              --secondaryProgress=100,
              --progress=100,
              layout_gravity="center|right",
            },
          },
          {
            FrameLayout,
            layout_width="fill",
            -- padding="16dp",
            --layout_height=lay_wh,
            layout_gravity="center",
            {
              TextView,
              text="对齐方式",
              textColor=文字色,
              textSize="16sp",
              gravity="center",
              padding="16dp",
              layout_gravity="center|left",
              layout_height="fill",
            },
            {
              LinearLayout,
              --layout_alignParentRight=true,
              layout_width="fill",
              id="txtalign",
              -- layout_height="26dp",
              gravity="right|center",
              paddingRight="9dp",
              {
                ImageView,
                padding="16dp",
                layout_width="56dp",
                ColorFilter=图标色,
                layout_height="56dp",
                src="drawable/align_left.png",
                onClick=function (v)
                  setTextAlign(v)
                  djtGravity=1
                end,
                foreground=波纹(波纹色),
              },
              {
                ImageView,
                layout_width="56dp",
                layout_height="56dp",
                src="drawable/align_center.png",
                onClick=function (v)
                  setTextAlign(v)
                  djtGravity=2
                end,
                foreground=波纹(波纹色),
                ColorFilter=淡色,
                padding="16dp",
              },
              {
                ImageView,
                src="drawable/align_left.png",
                layout_width="56dp",
                onClick=function (v)
                  setTextAlign(v)
                  djtGravity=3
                end,
                padding="16dp",
                foreground=波纹(波纹色),
                layout_height="56dp",
                rotation=180,
                ColorFilter=淡色,
              },
            },
          },
          {
            FrameLayout,
            --layout_height=lay_wh,
            layout_gravity="center",
            padding="16dp",
            layout_width="fill",
            {
              TextView,
              text="行距",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center",
            },
            {
              SeekBar,
              id="linesc",
              layout_width="70%w",
              layout_height="fill",
              -- layout_alignParentRight=true,
              OnSeekBarChangeListener={
                onProgressChanged=function(v,p)
                  local qxd=p+1
                  --toast (p)
                  djt.setLineSpacing(qxd,1)
                  djt.text=djt.text
                end},
              max=100,
              --progress=0,
              --secondaryProgress=0,
              layout_gravity="center|right",
            },
          },
          {
            FrameLayout,
            --layout_height=lay_wh,
            layout_gravity="center",
            padding="16dp",
            layout_width="fill",
            {
              TextView,
              text="水平缩放",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center",
            },
            {
              SeekBar,
              id="txtsclx",
              layout_width="70%w",
              layout_height="fill",
              --layout_alignParentRight=true,
              OnSeekBarChangeListener={
                onProgressChanged=function(v,p)
                  local qxd=p+1
                  --toast (p)
                  djt.setTextScaleX(qxd)
                  djt.text=djt.text
                end},
              max=12,
              --progress=0,
              --secondaryProgress=0,
              layout_gravity="center|right",
            },
          },
          sort("效果"),
          {
            FrameLayout,
            paddingRight="9dp",
            --layout_height=lay_wh,
            foreground=波纹(波纹色),
            onClick=function (v)
              v.getChildAt(1).performClick()
            end,
            layout_width="fill",
            {
              TextView,
              text="粗体",
              textColor=文字色,
              padding="16dp",
              textSize="16sp",
              layout_height="fill",
              gravity="center",
            },
            {
              Switch,
              id="ctswt",
              layout_height="fill",
              -- layout_alignParentRight=true,
              OnCheckedChangeListener={
                onCheckedChanged=function(v,isChecked)
                  djt.getPaint().setFlags(getTextFlags())
                end},
              layout_gravity="center|right",
            },
          },
          {
            FrameLayout,
            --layout_height=lay_wh,
            layout_gravity="center",
            layout_width="fill",
            padding="16dp",
            {
              TextView,
              text="倾斜",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center",
            },
            {
              SeekBar,
              id="xtswt",
              layout_width="70%w",
              layout_height="fill",
              --layout_alignParentRight=true,
              OnSeekBarChangeListener={
                onProgressChanged=function(v,p)
                  local qxd=p*0.015-75*0.015/2
                  djt.getPaint().setTextSkewX(qxd)
                  djt.text=djt.text
                end},
              max=75,
              progress=75/2,
              --secondaryProgress=75/2,
              layout_gravity="center|right",
            },
          },
          {
            FrameLayout,
            paddingRight="9dp",
            foreground=波纹(波纹色),
            onClick=function (v)
              v.getChildAt(1).performClick()
            end,
            --layout_height=lay_wh,
            layout_width="fill",
            layout_gravity="center",
            {
              TextView,
              text="下划线",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              padding="16dp",
              gravity="center",
            },
            {
              Switch,
              id="ulswt",
              OnCheckedChangeListener={
                onCheckedChanged=function(v,isChecked)
                  djt.getPaint().setFlags(getTextFlags())
                end},
              layout_height="fill",
              --layout_alignParentRight=true,
              layout_gravity="center|right",
            },
          },
          {
            FrameLayout,
            paddingRight="9dp",
            foreground=波纹(波纹色),
            onClick=function (v)
              v.getChildAt(1).performClick()
            end,
            --layout_height=lay_wh,
            layout_width="fill",
            layout_gravity="center",
            {
              TextView,
              text="删除线",
              padding="16dp",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center",
            },
            {
              Switch,
              id="delswt",
              layout_height="fill",
              OnCheckedChangeListener={
                onCheckedChanged=function(v,isChecked)
                  djt.getPaint().setFlags(getTextFlags())
                end},
              -- layout_alignParentRight=true,
              layout_gravity="center|right",
            },
          },
          {
            FrameLayout,
            layout_gravity="center",
            padding="16dp",
            --layout_height=lay_wh,
            layout_width="fill",
            {
              TextView,
              text="旋转",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center",
            },
            {
              SeekBar,
              layout_height="fill",
              layout_width="70%w",
              id="rota",
              --layout_alignParentRight=true,
              OnSeekBarChangeListener={
                onProgressChanged=function(v,p)
                  djt.rotation=p
                end},
              max=360,
              layout_gravity="center|right",
            },
          },
          {
            LinearLayout,
            layout_width="fill",
            orientation="vertical",
            sort("阴影 / 发光"),
            {
              FrameLayout,
              paddingRight="9dp",
              foreground=波纹(波纹色),
              onClick=function (v)
                v.getChildAt(1).performClick()
              end,
              --layout_height=lay_wh,
              layout_width="fill",
              layout_gravity="center",
              {
                TextView,
                text="阴影 / 发光",
                textColor=文字色,
                textSize="16sp",
                layout_height="fill",
                padding="16dp",
                gravity="center",
              },
              {
                Switch,
                id="eswt",
                layout_height="fill",
                OnCheckedChangeListener={
                  onCheckedChanged=function(v,isChecked)
                    if isChecked then
                      pcall(function ()
                        -- elconf.setVisibility(0)
                        djt.setShadowLayer(elradiu.progress+1,elx.progress,ely.progress,tonumber(elcl.text))
                      end)
                     else
                      pcall(function ()
                        --  elconf.setVisibility(8)
                        djt.setShadowLayer(0,0,0,0)
                      end)
                    end
                  end},
                -- layout_alignParentRight=true,
                layout_gravity="center|right",
              },
            },
            {
              LinearLayout,
              orientation="vertical",
              --  id="elconf",
              -- visibility=8,
              layout_width="fill",
              {
                FrameLayout,
                padding="16dp",
                -- layout_height=lay_wh,
                layout_width="fill",
                layout_gravity="center",
                {
                  TextView,
                  text="模糊半径",
                  textColor=文字色,
                  textSize="16sp",
                  layout_height="fill",
                  gravity="center",
                },
                {
                  SeekBar,
                  layout_width="70%w",
                  id="elradiu",
                  -- layout_alignParentRight=true,
                  OnSeekBarChangeListener={
                    onProgressChanged=function(v,p)
                      if eswt.Checked then
                        pcall(function ()
                          local p=p+1
                          djt.setShadowLayer(p,elx.progress-(w/1.5)/2,ely.progress-(w/1.5)/2,tonumber(elcl.text))
                        end)
                      end
                    end},
                  max=0.025*w-1,
                  --secondaryProgress=0.025*w-1,
                  progress=0.025*w-1,
                  layout_gravity="center|right",
                },
              },
              {
                FrameLayout,
                padding="16dp",
                foreground=波纹(波纹色),
                onClick=function ()
                  colorPicker(function ()
                    if eswt.Checked then
                      local cl=mmp4.text
                      elcl.text=tostring(cl)
                      local cl=tonumber(cl)
                      pcall(function ()
                        djt.setShadowLayer(elradiu.progress+1,elx.progress-(w/1.5)/2,ely.progress-(w/1.5)/2,cl)
                      end)
                    end
                  end)
                end,
                --layout_height=lay_wh,
                layout_width="fill",
                layout_gravity="center",
                {
                  TextView,
                  text="颜色",
                  textColor=文字色,
                  textSize="16sp",
                  layout_height="fill",
                  gravity="center",
                },
                {
                  TextView,
                  text=dfDjtCl,
                  textColor=次要文字色,
                  id="elcl",
                  gravity="center",
                  textSize="16sp",
                  -- layout_alignParentRight=true,
                  layout_gravity="right|center",
                },
              },
              {
                FrameLayout,
                padding="16dp",
                --layout_height=lay_wh,
                layout_width="fill",
                layout_gravity="center",
                {
                  TextView,
                  text="X轴偏移",
                  textColor=文字色,
                  textSize="16sp",
                  layout_height="fill",
                  gravity="center",
                },
                {
                  SeekBar,
                  layout_width="70%w",
                  id="elx",
                  -- layout_alignParentRight=true,
                  OnSeekBarChangeListener={
                    onProgressChanged=function(v,p)
                      local p=p-(w/1.5)/2
                      if eswt.Checked then
                        pcall(function ()
                          djt.setShadowLayer(elradiu.progress+1,p,ely.progress-(w/1.5)/2,tonumber(elcl.text))
                        end)
                      end
                    end},
                  max=w/1.5,
                  progress=(w/1.5)/2,
                  --secondaryProgress=w*0.016,
                  layout_gravity="center|right",
                },
              },
              {
                FrameLayout,
                layout_gravity="center",
                -- gravity="center",
                --layout_height=lay_wh,
                padding="16dp",
                layout_width="fill",
                {
                  TextView,
                  text="Y轴偏移",
                  textColor=文字色,
                  textSize="16sp",
                  layout_height="fill",
                  gravity="center",
                },
                {
                  SeekBar,
                  layout_width="70%w",
                  layout_height="fill",
                  id="ely",
                  -- layout_alignParentRight=true,
                  OnSeekBarChangeListener={
                    onProgressChanged=function(v,p)
                      local p=p-(w/1.5)/2
                      if eswt.Checked then
                        pcall(function ()
                          djt.setShadowLayer(elradiu.progress+1,elx.progress-(w/1.5)/2,p,tonumber(elcl.text))
                        end)
                      end
                    end},
                  max=w/1.5,
                  progress=(w/1.5)/2,
                  --secondaryProgress=w*0.016,
                  layout_gravity="center|right",
                },
              },
              {
                TextView,
                text="部分设备无法设置此效果\n阴影不含删除线与下划线，部分属性会影响阴影效果",
                textColor=淡色,
                textSize="12sp",
                layout_width="fill",
                gravity="center",
                padding="16dp",
                paddingLeft="9dp",
                paddingRight="9dp",
              },
            },
          },
          sort("位置"),
          {
            FrameLayout,
            layout_width="fill",
            --  padding="16dp",
            --layout_height=lay_wh,
            layout_gravity="center",
            {
              TextView,
              text="X轴",
              padding="16dp",
              textColor=文字色,
              textSize="16sp",
              gravity="center",
              --layout_width="fill",
              layout_height="fill",
            },
            {
              LinearLayout,
              --layout_alignParentRight=true,
              layout_width="fill",
              -- id="djt_xposition",
              --layout_height="26dp",
              paddingRight="9dp",
              gravity="right|center",
              {
                ImageView,
                layout_width="56dp",
                layout_height="56dp",
                ColorFilter=图标色,
                src="drawable/minus.png",
                onClick=function (v)
                  local curx=tonumber(djt_xposition.text)
                  v.Parent.getChildAt(2).colorFilter=图标色
                  if curx>-djt.width*0.5 then
                    --v.colorFilter=图标色
                    djt.x=curx-1
                    djt_xposition.text=string.format("%.f",djt.x)
                   else
                    v.colorFilter=淡色
                  end
                end,
                padding="16dp",
                foreground=波纹(波纹色),
              },
              {
                TextView,
                padding="16dp",
                layout_width="80dp",
                id="djt_xposition",
                textSize="16sp",
                -- text="0",
                gravity="center",
                layout_gravity="center",
                textColor=文字色,
              },
              {
                ImageView,
                src="drawable/plus.png",
                layout_width="56dp",
                onClick=function (v)
                  local curx=tonumber(djt_xposition.text)
                  v.Parent.getChildAt(0).colorFilter=图标色
                  if curx<w-djt.width*0.5 then
                    djt.x=curx+1
                    djt_xposition.text=string.format("%.f",djt.x)
                   else
                    v.colorFilter=淡色
                  end
                end,
                layout_height="56dp",
                -- ColorFilter=图标色,
                padding="16dp",
                ColorFilter=图标色,
                foreground=波纹(波纹色),
              },
            },
          },
          {
            FrameLayout,
            layout_width="fill",
            --  padding="16dp",
            --layout_height=lay_wh,
            layout_gravity="center",
            {
              TextView,
              text="Y轴",
              padding="16dp",
              textColor=文字色,
              textSize="16sp",
              gravity="center",
              --layout_width="fill",
              layout_height="fill",
            },
            {
              LinearLayout,
              --layout_alignParentRight=true,
              layout_width="fill",
              -- id="djt_xposition",
              --layout_height="26dp",
              paddingRight="9dp",
              gravity="right|center",
              {
                ImageView,
                layout_width="56dp",
                layout_height="56dp",
                ColorFilter=图标色,
                src="drawable/minus.png",
                onClick=function (v)
                  local cury=tonumber(djt_yposition.text)
                  v.Parent.getChildAt(2).colorFilter=图标色
                  if cury>-djt.height*0.5 then
                    djt.y=cury-1
                    djt_yposition.text=string.format("%.f",djt.y)
                   else
                    v.colorFilter=淡色
                  end
                end,
                padding="16dp",
                foreground=波纹(波纹色),
              },
              {
                TextView,
                padding="16dp",
                layout_width="80dp",
                id="djt_yposition",
                textSize="16sp",
                gravity="center",
                layout_gravity="center",
                textColor=文字色,
              },
              {
                ImageView,
                src="drawable/plus.png",
                layout_width="56dp",
                ColorFilter=图标色,
                onClick=function (v)
                  local cury=tonumber(djt_yposition.text)
                  v.Parent.getChildAt(0).colorFilter=图标色
                  if cury<h-djt.height/2 then
                    djt.y=cury+1
                    djt_yposition.text=string.format("%.f",djt.y)
                   else
                    v.colorFilter=淡色
                  end
                end,
                layout_height="56dp",
                padding="16dp",
                foreground=波纹(波纹色),
              },
            },
          },
          {
            TextView,
            text="复位",
            id="djtresetpis",
            --layout_height=lay_wh,
            textColor=文字色,
            foreground=波纹(波纹色),
            onClick=function ()
              djt.x=0
              djt.y=h/2-djt.height/2
              djt_yposition.text=string.format("%.f",djt.y)
              djt_xposition.text="0"
            end,
            textSize="16sp",
            layout_width="fill",
            padding="16dp",
          },
          {
            TextView,
            text="退出编辑模式时将会自动复位",
            textColor=淡色,
            textSize="12sp",
            layout_width="fill",
            gravity="center",
            padding="16dp",
            paddingLeft="9dp",
            paddingRight="9dp",
          },
          sort("状态"),
          {
            TextView,
            text="重置状态",
            textColor=文字色,
            gravity="center|left",
            foreground=波纹(波纹色),
            onClick=function ()
              if tonumber(txtcolr.text)~=tonumber(文字色) then
                txtcolr.text=tostring(文字色)
                djt.textColor=文字色
              end
              if eswt.Checked then
                eswt.Checked=false
              end
              if xtswt.progress~=75/2 then
                xtswt.progress=75/2
              end
              if ctswt.Checked then
                ctswt.Checked=false
              end
              if ulswt.Checked then
                ulswt.Checked=false
              end
              if delswt.Checked then
                delswt.Checked=false
              end
              if rota.progress~=0 then
                rota.progress=0
              end
              if linesc.progress~=0 then
                linesc.progress=0
              end
              if txtalph.progress~=0 then
                txtalph.progress=0
              end
              if txtsclx.progress~=0 then
                txtsclx.progress=0
              end
              if txtsize.progress~=6 then
                txtsize.progress=6
              end
              if djtGravity~=1 then
                setTextAlign(txtalign.getChildAt(0))
              end
              --if currentSelectedFont~="monospace" then
              txtfnt.setSelection(1)
              txtfnt.setSelection(0)
              djtresetpis.performClick()
              onPause ()
            end,
            id="resettxt",
            textSize="16sp",
            layout_width="fill",
            --layout_height=lay_wh,
            padding="16dp",
          },
          {
            TextView,
            text="部分属性叠加设置可能会造成卡顿",
            textColor=淡色,
            textSize="12sp",
            layout_width="fill",
            gravity="center",
            padding="16dp",
            paddingLeft="9dp",
            paddingRight="9dp",
          },
          --文字属性
        },
      },
    },
    --设置背景图
    {
      LinearLayout,
      layout_alignParentBottom=true,
      orientation="vertical",
      backgroundColor=背景色,
      y=h,
      id="bgtype",
      elevation="10dp",
      layout_width="fill",
      gravity="center",
      {
        ImageView,
        src="drawable/arrow.png",
        onClick=function ()
          Y位移(bgtype,350,{0,h})
          if not isMakingWall then
            disableDrawer(false)
          end
          gbsshown=false
        end,
        ColorFilter=图标色,
        layout_width="fill",
        foreground=波纹(波纹色),
        OnTouchListener={
          onTouch=function (v,e)
            local y=e.getRawY()
            if not logY then
              logY=y
            end
            if logY>y then
              v.setRotation(180)
             else
              v.setRotation(0)
            end
            logY=y
            local hei=h-y
            if hei>=h/3.5 and hei<=(h/5)*4 and hei<=bgtype.getChildAt(1).getChildAt(0).height then
              setViewHeight(bgtype.getChildAt(1),hei)
            end
          end},
        onLongClickListener={
          onLongClick=function ()
            return true
          end},
        layout_height="30dp",
      },
      {
        ScrollView,
        layout_width="fill",
        layout_height=h/3.5,
        {
          LinearLayout,
          layout_width="fill",
          orientation="vertical",
          sort("背景"),
          {
            FrameLayout,
            --layout_height=lay_wh,
            layout_width="fill",
            padding="16dp",
            layout_gravity="center",
            onClick=function ()
              selectImg()
            end,
            foreground=波纹(波纹色),
            {
              TextView,
              text="选择本地图片",
              textSize="16sp",
              textColor=文字色,
              layout_gravity="left|center",
              layout_height="fill",
              gravity="center",
            },
            {
              ImageView,
              src="drawable/arrow.png",
              rotation=-90,
              -- layout_alignParentRight=true,
              layout_width="26dp",
              layout_height="26dp",
              ColorFilter=图标色,
              layout_gravity="center|right",
            },
          },
          {
            FrameLayout,
            padding="16dp",
            foreground=波纹(波纹色),
            onClick=function ()
              colorPicker(function ()
                local cl=tonumber(mmp4.text)
                bgcl.text=mmp4.text
                bg.setImageDrawable(ColorDrawable(0))
                bg.setBackgroundColor(cl)
                io.open(bground_path,"w+"):write((cl)):close()
                bgblur.Parent.visibility=8
              end)
            end,
            --layout_height=lay_wh,
            layout_width="fill",
            layout_gravity="center",
            {
              TextView,
              text="纯色背景",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center|left",
            },
            {
              TextView,
              text="0x00000000",
              textColor=次要文字色,
              id="bgcl",
              textSize="16sp",
              --layout_alignParentRight=true,
              --gravity="center",
              layout_gravity="center|right",
            },
          },
          {
            TextView,
            text="系统壁纸",
            textColor=文字色,
            foreground=波纹(波纹色),
            onClick=function ()
              local system_wall=wallman.getBitmap()
              local syswall=应用数据.."/system_wall.png"
              local save=savePicture(syswall,system_wall,false)
              if save then
                bg.setImageBitmap(system_wall)
                io.open(bground_path,"w+"):write(syswall):close()
               else
                toast("设置失败，请重试")
              end
            end,
            --layout_height=lay_wh,
            textSize="16sp",
            gravity="center|left",
            layout_width="fill",
            padding="16dp",
          },
          {
            FrameLayout,
            --layout_height=lay_wh,
            layout_width="fill",
            padding="16dp",
            layout_gravity="center",
            onClick=function (vie)
              local downed=LuaAdapter(this,{},{
                LinearLayout,
                backgroundColor=背景色,
                layout_width="fill",
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
              })
              local edt=AlertDialog.Builder(this)
              -- .setCancelable(false)
              .setTitle("已下载的壁纸")
              .setView(loadlayout ({
                RelativeLayout,
                layout_width="fill",
                --layout_height=w,
                paddingTop="9dp",
                {
                  GridView,
                  adapter=downed,
                  layout_width='fill',
                  layout_height="fill",
                  numColumns=2,
                  onItemClickListener={
                    onItemClick=function (g,v)
                      local pat=v.getChildAt(1).text
                      bg.backgroundColor=0
                      bg.ImageBitmap=loadbitmap (pat)
                      io.open(bground_path,"w+"):write(pat):close()
                      selet.dismiss()
                    end},
                  onItemLongClickListener={
                    onItemLongClick=function (g,v)
                      local edt=AlertDialog.Builder(this)
                      -- .setCancelable(false)
                      .setTitle("选择操作")
                      .setItems({"查看","设为背景","删除"}, function (d,n)
                        if n==0 then
                          local i = Intent(Intent.ACTION_VIEW)
                          local u= Uri.parse("file://"..v.getChildAt(1).text)
                          i.setDataAndType(u, "image/*")
                          this.startActivity(i)
                         elseif n==1 then
                          local pat=v.getChildAt(1).text
                          bg.backgroundColor=0
                          bg.ImageBitmap=loadbitmap (pat)
                          io.open(bground_path,"w+"):write(pat):close()
                          selet.dismiss()
                         else
                          showDialog("删除","是否删除此图片？此操作无法撤销。","删除","取消", function ()
                            deletePic(v.getChildAt(1).text)
                            refreshDownedList()
                          end,nil,0xffff4500)
                        end
                      end)
                      local sled=edt.show()
                      local pw=sled.getWindow()
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
                },
                {
                  LinearLayout,
                  id="downloaded",
                  orientation="vertical",
                  --visibility=4,
                  layout_width='fill',
                  layout_height="fill",
                  --paddingTop=lay_wh,
                  gravity="center",
                  {
                    ImageView,
                    src="drawable/package.png",
                    layout_width='fill',
                    ColorFilter=图标色,
                    layout_height="195dp",
                    --adjustViewBounds=true,
                    padding="32dp",
                    ColorFilter=图标色,
                  },
                  {
                    TextView,
                    layout_gravity="center",
                    text="无图片",
                    textColor=淡色,
                    textSize="22sp",
                  },
                },
              }))
              .setPositiveButton("取消",nil)
              .setNeutralButton("获取更多壁纸", function ()
                this.newActivity("thirdparty/wallpaper/main")
              end)
              selet=edt.show()
              local pw=selet.getWindow()
              .setWindowAnimations(R.style.BottomDialog_Animation)
              --.setBackgroundDrawable(ColorDrawable(0))
              .setGravity(Gravity.BOTTOM)
              圆角(pw,背景色,{0,0,0,0,0,0,0,0})
              local lp=pw.getAttributes()
              lp.width=w
              pw.setAttributes(lp)
              pw.setDimAmount(0.35)
              function refreshDownedList()
                local plist=getFileList(头像壁纸)
                downed.clear()
                for a=1,#plist do
                  local pat=tostring(plist[a])
                  --toast (pat)
                  if not pat:find"%(pic%)" then
                    pcall(function ()
                      downed.insert(0,{
                        wp=pat,
                        pa=pat,
                      })
                    end)
                  end
                end
                downed.notifyDataSetChanged()
                if downed.getCount()>0 then
                  downloaded.visibility=8
                 else
                  downloaded.visibility=0
                end
              end
              refreshDownedList()
            end,
            foreground=波纹(波纹色),
            {
              TextView,
              text="选择已下载的壁纸",
              textSize="16sp",
              textColor=文字色,
              layout_gravity="left|center",
              layout_height="fill",
              gravity="center",
            },
            {
              ImageView,
              src="drawable/arrow.png",
              rotation=-90,
              -- layout_alignParentRight=true,
              layout_width="26dp",
              ColorFilter=图标色,
              layout_height="26dp",
              layout_gravity="center|right",
            },
          },
          {
            TextView,
            text="支持透明背景\n图片过大可能无法显示，GIF 仅显示第一帧",
            textColor=淡色,
            textSize="12sp",
            layout_width="fill",
            gravity="center",
            padding="16dp",
            paddingLeft="9dp",
            paddingRight="9dp",
          },
          {
            TextView,
            text="重置背景",
            textColor=文字色,
            foreground=波纹(波纹色),
            onClick=function ()
              pcall(function ()
                bgr=io.open(bground_path):read("*a")
              end)
              if bgr=="0" then
                toast("已是默认背景")
               else
                --gbsshown=false
                --Y位移(bgtype,350,{0,h})
                io.open(bground_path,"w+"):write("0"):close()
                bg.setBackgroundColor(0)
                bg.setImageDrawable(ColorDrawable (0))
                bgcl.text="0x00000000"
                bgblur.Parent.visibility=8
              end
            end,
            --layout_height=lay_wh,
            textSize="16sp",
            gravity="center|left",
            layout_width="fill",
            padding="16dp",
            --id="resetBg",
          },
          sort("外观"),
          {
            FrameLayout,
            foreground=波纹(波纹色),
            onClick=function ()
              bgscal.performClick()
            end,
            --layout_height=lay_wh,
            paddingRight="9dp",
            layout_width="fill",
            layout_gravity="center",
            {
              TextView,
              text="显示",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              padding="16dp",
              gravity="center",
            },
            {
              Spinner,
              adapter=scaletype_adp,
              OnItemSelectedListener={
                onItemSelected=function(p,v,n)
                  pcall(function ()
                    local pt=v.text
                    if pt:find"放大" then
                      bg.setScaleType(ScaleType.CENTER_CROP)
                     elseif pt:find"拉伸" then
                      bg.setScaleType(ScaleType.FIT_XY)
                     else
                      bg.setScaleType(ScaleType.FIT_CENTER)
                    end
                  end)
                end},
              id="bgscal",
              layout_width="70%w",
              -- layout_alignParentRight=true,
              layout_height="fill",
              --gravity="center",
              layout_gravity="center|right",
            },
          },
          {
            FrameLayout,
            padding="16dp",
            foreground=波纹(波纹色),
            onClick=function ()
              colorPicker(function ()
                local cl=mmp4.text
                bgforecolr.text=tostring(cl)
                local cl=tonumber(cl)
                bg.foreground=ColorDrawable(cl)
                --Y位移(textset,350,{0,h})
              end)
            end,
            -- layout_height=lay_wh,
            layout_width="fill",
            layout_gravity="center",
            {
              TextView,
              text="前景色",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center",
            },
            {
              TextView,
              text=qjs,
              textColor=次要文字色,
              id="bgforecolr",
              textSize="16sp",
              -- layout_alignParentRight=true,
              layout_gravity="center|right",
              gravity="center",
            },
          },
          {
            TextView,
            text="建议选择半透明颜色",
            textColor=淡色,
            textSize="12sp",
            layout_width="fill",
            gravity="center",
            --visibility=8,
            padding="16dp",
            paddingLeft="9dp",
            paddingRight="9dp",
          },
          {
            FrameLayout,
            padding="16dp",
            foreground=波纹(波纹色),
            onClick=function ()
              colorPicker(function ()
                local cl=mmp4.text
                bgbcolr.text=tostring(cl)
                local cl=tonumber(cl)
                bg.backgroundColor=cl
                --Y位移(textset,350,{0,h})
              end)
            end,
            -- layout_height=lay_wh,
            layout_width="fill",
            layout_gravity="center",
            {
              TextView,
              text="背景色",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center",
            },
            {
              TextView,
              text="0x00000000",
              textColor=次要文字色,
              id="bgbcolr",
              textSize="16sp",
              -- layout_alignParentRight=true,
              layout_gravity="center|right",
              gravity="center",
            },
          },
          {
            FrameLayout,
            --layout_height=lay_wh,
            padding="16dp",
            layout_gravity="center",
            --gravity="center",
            --  visibility=8,
            layout_width="fill",
            {
              TextView,
              text="高斯模糊",
              textColor=文字色,
              textSize="16sp",
              layout_height="fill",
              gravity="center|left",
            },
            {
              SeekBar,
              layout_width="70%w",
              id="bgblur",
              layout_gravity="center|right",
              -- layout_alignParentRight=true,
              OnSeekBarChangeListener={
                onProgressChanged=function(v,p)
                  pcall(function ()
                    local b=loadbitmap (io.open(bground_path):read("*a"))
                    local bkg=Bitmap.createScaledBitmap(b, b.width, b.height, true)
                    local bl=getBlurBitmap(bkg,p)
                    bg.setImageBitmap(bl)
                  end)
                  -- end
                end},
              layout_height="fill",
              max=25,
              progress=0,
            },
          },
          {
            TextView,
            text="重置外观",
            textColor=文字色,
            foreground=波纹(波纹色),
            onClick=function ()
              bgblur.progress=0
              bg.backgroundColor=0
              bg.foreground=ColorDrawable(tonumber(qjs))
              bgbcolr.text="0x00000000"
              bgcl.text=""
              bgforecolr.text=qjs
              bgscal.selection=0
            end,
            --layout_height=lay_wh,
            textSize="16sp",
            gravity="center|left",
            layout_width="fill",
            padding="16dp",
          },
          --背景图设置
        },
      },
    },
    --分享或保存本地
    {
      LinearLayout,
      layout_alignParentBottom=true,
      orientation="vertical",
      backgroundColor=背景色,
      y=h,
      id="sharetype",
      elevation="10dp",
      layout_width="fill",
      gravity="center",
      {
        ImageView,
        OnTouchListener={
          onTouch=function (v,e)
            local y=e.getRawY()
            if not logY then
              logY=y
            end
            if logY>y then
              v.setRotation(180)
             else
              v.setRotation(0)
            end
            logY=y
            local hei=h-y
            if hei>=h/3.5 and hei<=(h/5)*4 and hei<=sharetype.getChildAt(1).getChildAt(0).height then
              setViewHeight(sharetype.getChildAt(1),hei)
            end
          end},
        ColorFilter=图标色,
        src="drawable/arrow.png",
        onClick=function ()
          Y位移(sharetype,350,{0,h})
          shareshown=false
          if not isMakingWall then
            disableDrawer(false)
          end
        end,
        layout_width="fill",
        foreground=波纹(波纹色),
        onLongClickListener={
          onLongClick=function ()
            return true
          end},
        layout_height="30dp",
      },
      {
        ScrollView,
        layout_width="fill",
        layout_height=h/3.5,
        {
          LinearLayout,
          layout_width="fill",
          orientation="vertical",
          sort("图片"),
          {
            TextView,
            text="保存到本地",
            textColor=文字色,
            foreground=波纹(波纹色),
            onClick=function ()
              if wmswt.Checked then
                water_mark_main.setVisibility(0)
               else
                water_mark_main.setVisibility(8)
              end
              savePicture(wallpaper_path..os.time()..".png",getViewBitmap(ti),false,"已保存，可在设置中查看","保存失败")
              if not isMakingWall then
                water_mark_main.setVisibility(8)
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
            text="分享",
            textColor=文字色,
            foreground=波纹(波纹色),
            onClick=function ()
              if wmswt.Checked then
                water_mark_main.setVisibility(0)
               else
                water_mark_main.setVisibility(8)
              end
              shareBitmap(getViewBitmap(ti))
              if not isMakingWall then
                water_mark_main.setVisibility(8)
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
            text="设为桌面壁纸",
            textColor=文字色,
            foreground=波纹(波纹色),
            onClick=function ()
              if wmswt.Checked then
                water_mark_main.setVisibility(0)
               else
                water_mark_main.setVisibility(8)
              end
              local pre=应用数据.."/previous_system_wall.png"
              local sa=savePicture(wallman.getBitmap(),pre,false)
              --local wallpaper = Bitmap.createScaledBitmap(getViewBitmap(ti), w, syswallheight, true)
              setWallpaper(getViewBitmap(ti))
              if not isMakingWall then
                water_mark_main.setVisibility(8)
              end
              --onResume()
            end,
            --layout_height=lay_wh,
            textSize="16sp",
            gravity="center|left",
            layout_width="fill",
            padding="16dp",
          },
          {
            TextView,
            text="保存的图片为 PNG 格式\n锁屏壁纸请保存后手动设置",
            textColor=淡色,
            textSize="12sp",
            layout_width="fill",
            gravity="center",
            padding="16dp",
            paddingLeft="9dp",
            paddingRight="9dp",
          },
          {
            LinearLayout,
            orientation="vertical",
            --  id="sText",
            layout_width="fill",
            --visibility=8,
            sort("文本"),
            {
              LinearLayout,
              orientation="vertical",
              id="sText",
              visibility=8,
              {
                TextView,
                text="复制内容",
                textColor=文字色,
                foreground=波纹(波纹色),
                onClick=function ()
                  copyText(djt.text.."\n    ——闲言APP 最好的阅读平台")
                end,
                --layout_height=lay_wh,
                textSize="16sp",
                gravity="center|left",
                layout_width="fill",
                padding="16dp",
              },
              {
                TextView,
                text="分享内容",
                textColor=文字色,
                foreground=波纹(波纹色),
                onClick=function ()
                  shareText(djt.text.."\n    ——闲言APP 最好的阅读平台")
                end,
                --layout_height=lay_wh,
                textSize="16sp",
                gravity="center|left",
                layout_width="fill",
                padding="16dp",
              },
            },
            {
              FrameLayout,
              --layout_height=lay_wh,
              layout_width="fill",
              padding="16dp",
              layout_gravity="center",
              onClick=function ()
                djt.backgroundColor=Color.WHITE
                savePicture(wallpaper_path..os.time().."(text_only).png",getViewBitmap(djt))
                djt.backgroundColor=0
              end,
              foreground=波纹(波纹色),
              {
                TextView,
                text="保存纯文本图片",--正方形编辑模式
                textSize="16sp",
                textColor=文字色,
                layout_gravity="left|center",
                layout_height="fill",
              },
              {
                ImageView,
                src="drawable/arrow.png",
                rotation=-90,
                visibility=8,
                -- layout_alignParentRight=true,
                layout_width="26dp",
                layout_height="26dp",
                layout_gravity="center|right",
              },
            },
            {
              TextView,
              text="纯文本图片不含水印，背景为白色",
              textColor=淡色,
              textSize="12sp",
              layout_width="fill",
              gravity="center",
              padding="16dp",
              paddingLeft="9dp",
              paddingRight="9dp",
            },
          },
          {
            LinearLayout,
            orientation="vertical",
            id="setPrev",
            layout_width="fill",
            {
              FrameLayout,
              layout_width="fill",
              {
                LinearLayout,
                backgroundColor=淡色,
                layout_width="fill",
                layout_height="0.14dp",
                layout_marginLeft="12dp",
                layout_gravity="center",
                layout_marginRight="9dp",
              },
              {
                TextView,
                text="其他",
                textColor=淡色,
                textSize="14sp",
                layout_height="fill",
                layout_width="wrap",
                layout_gravity="center",
                padding="16dp",
                paddingLeft="9dp",
                paddingRight="9dp",
                backgroundColor=背景色,
                gravity="center",
              },
            },
            {
              TextView,
              text="恢复上一个壁纸",
              textColor=淡色,
              -- id="setPrev",
              -- layout_height=lay_wh,
              foreground=波纹(波纹色),
              onClick=function ()
                local pr=应用数据.."/previous_system_wall.png"
                if File(pr).exists() then
                  this.setWallpaper(loadbitmap(pre))
                 else
                  toast ("无上个壁纸备份，无法恢复")
                end
              end,
              textSize="16sp",
              layout_width="fill",
              gravity="center|left",
              padding="16dp",
            },
          },

          --保存分享
        },
      },
    },
    --制作壁纸部分
    {
      RelativeLayout,
      id="mWall",
      --visibility=8,
      --底栏
      {
        PageView,
        OverScrollMode=2,
        id="mWall_bmBar",
        y=h,
        layout_height="96dp",
        pages={
          page(loadbitmap("drawable/textsize.png"),"文字设置",function()
            Y位移(textset,350,{h,0})
            djt_xposition.text=string.format("%.0f",djt.x)
            djt_yposition.text=string.format("%.0f",djt.y)
            disableDrawer(true)
            tsetshown=true
          end,nil,nil,nil,次要文字色),
          page(loadbitmap("drawable/image.png"),"背景设置", function ()
            gbsshown=true
            disableDrawer(true)
            Y位移(bgtype,350,{h,0})
          end,nil,nil,nil,次要文字色),
          page(loadbitmap("drawable/texture.png"),"水印设置", function ()
            Y位移(wmark,350,{h,0})
            disableDrawer(true)
            wmarkshown=true
          end,nil,nil,nil,次要文字色),
          page(loadbitmap("drawable/save.png"),"保存分享", function ()
            Y位移(sharetype,350,{h,0})
            disableDrawer(true)
            shareshown=true
          end,nil,nil,nil,次要文字色),
          page(loadbitmap("drawable/close.png"),"退出编辑", function ()
            if 句子 then
              showDialog("退出编辑","仅保存背景设置。","退出","取消",function ()
                this.finish()
              end,nil,0xffff4500,nil,false)
             else
              toMain()
            end
          end,nil,nil,nil,次要文字色),
        },
        --layout_height="wrap",
        --layout_width="fill",
        elevation="10dp",
        --clipToPadding=true,
        layout_alignParentBottom=true,
        --clipChildren=true,
        offscreenPageLimit=3,
        pageMargin="-75%w",
        currentItem=1,
        --layout_marginBottom="4%w",
      },
      --文本设置原位置
    },
  },
  --左侧侧边栏
  {
    RelativeLayout,
    layout_gravity="left",
    id="sideBar",
    backgroundColor=背景色,
    layout_width="75%w",
    onClick=function() end,
    layout_height="fill",
    {
      ScrollView,
      layout_width="fill",
      --verticalScrollBarEnabled=false,
      OverScrollMode=2,
      layout_height="fill",
      --layout_marginBottom="16%w",
      {
        LinearLayout,
        orientation="vertical",
        layout_height="fill",
        layout_width="fill",
        --padding="2%w",
        --wmark_1("闲","言","side_xian","32dp",状态栏高度+w*0.09),
        {
          RelativeLayout,
          layout_height="-2",
          layout_width="-1",
          paddingTop=状态栏高度;
          onClick=function()
            if activity.getSharedData("password")~=nil then
              showDialog("要退出账号吗","退出账号后部分功能将不可用","退出账号","取消",function ()
                activity.setSharedData("username",nil)
                activity.setSharedData("password",nil)
                activity.setSharedData("vip_time",nil)
                ch_title.Text="您还未登录账号"
                ch_subtitle.Text="立即登录，享受完美体验"
              end,nil,0xffff4500,nil,true,nil,nil,nil)
             else
              activity.newActivity("login")
            end
          end;
          foreground=波纹(波纹色);
          {
            LinearLayout,
            orientation="vertical",
            layout_height="144dp",
            layout_width="-1",
            gravity="right|top";
            {
              ImageView,
              src="drawable/sidetop",
              layout_height="112dp",
              layout_width="112dp",
              scaleType="centerCrop";
            };
          },
          {
            LinearLayout,
            orientation="vertical",
            layout_height="144dp",
            layout_width="-1",
            gravity="left|bottom";
            padding="16dp";
            {
              TextView,
              text="您还未登录账号",
              textColor=文字色,
              layout_height="-2",
              textSize="18sp",
              id="ch_title";
            },
            {
              TextView,
              text="立即登录，享受完美体验",
              textColor=次要文字色,
              layout_height="-2",
              layout_marginTop="8dp",
              textSize="14sp",
              id="ch_subtitle";
            },
          };
        };
        {
          LinearLayout,
          onClick=function(v)
            if activity.getSharedData("password")~=nil then
              activity.newActivity("sup")
             else
              toast("请先登录")
              activity.newActivity("login")
            end
          end,
          layout_width="fill",
          --layout_height="16%w",
          padding="16dp",
          foreground=波纹(波纹色),
          {
            ImageView,
            src="drawable/crown.png",
            layout_height="26dp",
            ColorFilter=图标色,
            layout_width="26dp",
          },
          {
            TextView,
            text="我的Sup会员",
            textColor=文字色,
            layout_height="fill",
            layout_marginLeft="16dp",
            textSize="16sp",
            gravity="center",
          },
        },
        sort("源"),
        {
          LinearLayout,
          id="side_djt",
          onClick=function(v)
            setSidebarItem(v)
            if source~=1 then
              source=1
              title.text="毒鸡汤"
              getSoup()
            end
            drawer.closeDrawer(3)
          end,
          layout_width="fill",
          --layout_height="16%w",
          padding="16dp",
          foreground=波纹(波纹色),
          backgroundColor=bgInverse,
          {
            ImageView,
            src="drawable/food.png",
            layout_height="26dp",
            ColorFilter=图标色,
            layout_width="26dp",
          },
          {
            TextView,
            text="毒鸡汤",
            textColor=文字色,
            layout_height="fill",
            layout_marginLeft="16dp",
            textSize="16sp",
            gravity="center",
          },
        },
        {
          LinearLayout,
          id="side_jt",
          onClick=function(v)
            setSidebarItem(v)
            if source~=4 then
              source=4
              title.text="心灵鸡汤"
              getSoup()
            end
            drawer.closeDrawer(3)
          end,
          layout_width="fill",
          --layout_height="16%w",
          padding="16dp",
          foreground=波纹(波纹色),
          --backgroundColor=0x30ff0000,
          {
            ImageView,
            src="drawable/heart.png",
            layout_height="26dp",
            ColorFilter=图标色,
            layout_width="26dp",
          },
          {
            TextView,
            text="心灵鸡汤",
            textColor=文字色,
            layout_height="fill",
            layout_marginLeft="16dp",
            textSize="16sp",
            gravity="center",
          },
        },
        --[[        {
          LinearLayout,
          onClick=function(v)
            setSidebarItem(v)
            if source~=2 then
              source=2
              title.text="你好污啊"
              getSoup()
            end
            drawer.closeDrawer(3)
          end,
          layout_width="fill",
          -- layout_height="16%w",
          id="side_nihaowu",
          padding="16dp",
          foreground=波纹(波纹色),
          --backgroundColor=0x30ffff00,
          {
            ImageView,
            src="drawable/wu.png",
            ColorFilter=图标色,
            layout_height="26dp",
            layout_width="26dp",
          },
          {
            TextView,
            text="你好污啊",
            textColor=文字色,
            layout_height="fill",
            layout_marginLeft="16dp",
            textSize="16sp",
            gravity="center",
          },
        },]]
        {
          LinearLayout,
          onClick=function(v)
            setSidebarItem(v)
            if source~=3 then
              source=3
              title.text="一言"
              getSoup()
            end
            drawer.closeDrawer(3)
          end,
          layout_width="fill",
          --layout_height="16%w",
          id="side_yiyan",
          padding="16dp",
          foreground=波纹(波纹色),
          --backgroundColor=0x3000b1ff,
          {
            ImageView,
            ColorFilter=图标色,
            src="drawable/quote.png",
            layout_height="26dp",
            layout_width="26dp",
          },
          {
            TextView,
            text="一言",
            textColor=文字色,
            layout_height="fill",
            layout_marginLeft="16dp",
            textSize="16sp",
            gravity="center",
          },
        },
        {
          LinearLayout,
          id="side_rp",
          onClick=function(v)
            setSidebarItem(v)
            if source~=5 then
              source=5
              title.text="云音乐热评"
              getSoup()
            end
            drawer.closeDrawer(3)
          end,
          layout_width="fill",
          --layout_height="16%w",
          padding="16dp",
          foreground=波纹(波纹色),
          --backgroundColor=0x30ff0000,
          {
            ImageView,
            src="drawable/comment.png",
            layout_height="26dp",
            layout_width="26dp",
            ColorFilter=图标色,
          },
          {
            TextView,
            text="云音乐热评",
            textColor=文字色,
            layout_height="fill",
            layout_marginLeft="16dp",
            textSize="16sp",
            gravity="center",
          },
        },
        --[[{
          FrameLayout,
          onClick=function ()
            this.newActivity("more_source")
          end,
          layout_width="fill",
          layout_gravity="center",
          foreground=波纹(波纹色),
          padding="16dp",
          {
            LinearLayout,
            layout_width="fill",
            --layout_height="16%w",
            {
              ImageView,
              src="drawable/dots.png",
              layout_height="26dp",
              layout_width="26dp",
              rotation=90,
              ColorFilter=图标色,
            },
            {
              TextView,
              text="更多源",
              textColor=文字色,
              layout_height="fill",
              layout_marginLeft="16dp",
              textSize="16sp",
              gravity="center",
            },
          },
          {
            ImageView,
            src="drawable/arrow.png",
            rotation=-90,
            --layout_alignParentRight=true,
            layout_width="26dp",
            layout_height="26dp",
            ColorFilter=图标色,
            layout_gravity="right|center",
          },
        },]]--[[
        {
          FrameLayout,
          onClick=function ()
            this.newActivity("app/leave")
          end,
          layout_width="fill",
          layout_gravity="center",
          foreground=波纹(波纹色),
          padding="16dp",
          {
            LinearLayout,
            layout_width="fill",
            --layout_height="16%w",
            {
              ImageView,
              src="drawable/notes.png",
              layout_height="26dp",
              layout_width="26dp",
              --rotation=90,
              ColorFilter=图标色,
            },
            {
              TextView,
              text="请假条",
              textColor=文字色,
              layout_height="fill",
              layout_marginLeft="16dp",
              textSize="16sp",
              gravity="center",
            },
          },
          {
            ImageView,
            src="drawable/arrow.png",
            rotation=-90,
            --layout_alignParentRight=true,
            layout_width="26dp",
            layout_height="26dp",
            ColorFilter=图标色,
            layout_gravity="right|center",
          },
        },]]
        sort("其他"),
        {
          FrameLayout,
          onClick=function ()
            this.newActivity("app/discover")
          end,
          layout_width="fill",
          layout_gravity="center",
          foreground=波纹(波纹色),
          padding="16dp",
          {
            LinearLayout,
            layout_width="fill",
            {
              ImageView,
              src="drawable/discover.png",
              layout_height="26dp",
              ColorFilter=图标色,
              layout_width="26dp",
            },
            {
              TextView,
              text="垂直领域",
              textColor=文字色,
              layout_height="fill",
              layout_marginLeft="16dp",
              textSize="16sp",
              gravity="center",
            },
          },
          {
            ImageView,
            src="drawable/arrow.png",
            rotation=-90,
            --layout_alignParentRight=true,
            layout_width="26dp",
            layout_height="26dp",
            ColorFilter=图标色,
            layout_gravity="right|center",
          },
        },
        {
          FrameLayout,
          onClick=function ()
            this.newActivity("app/favorite")
          end,
          layout_width="fill",
          layout_gravity="center",
          foreground=波纹(波纹色),
          padding="16dp",
          {
            LinearLayout,
            layout_width="fill",
            {
              ImageView,
              ColorFilter=图标色,
              src="drawable/star.png",
              layout_height="26dp",
              layout_width="26dp",
            },
            {
              TextView,
              text="灵感",
              textColor=文字色,
              layout_height="fill",
              layout_marginLeft="16dp",
              textSize="16sp",
              gravity="center",
            },
          },
          {
            ImageView,
            src="drawable/arrow.png",
            rotation=-90,
            --layout_alignParentRight=true,
            layout_width="26dp",
            layout_height="26dp",
            ColorFilter=图标色,
            layout_gravity="right|center",
          },
        },
        {
          FrameLayout,
          onClick=function ()
            this.newActivity("app/daily")
          end,
          layout_width="fill",
          layout_gravity="center",
          foreground=波纹(波纹色),
          padding="16dp",
          --visibility=8,
          id="side_diandi",
          {
            LinearLayout,
            layout_width="fill",
            {
              ImageView,
              src="drawable/water.png",
              layout_height="26dp",
              ColorFilter=图标色,
              layout_width="26dp",
            },
            {
              TextView,
              text="点滴",
              textColor=文字色,
              layout_height="fill",
              layout_marginLeft="16dp",
              textSize="16sp",
              gravity="center",
            },
          },
          {
            ImageView,
            src="drawable/arrow.png",
            rotation=-90,
            --layout_alignParentRight=true,
            layout_width="26dp",
            layout_height="26dp",
            ColorFilter=图标色,
            layout_gravity="right|center",
          },
        },
        {
          LinearLayout,
          onClick=function(v)
            --setSidebarItem(v)
            -- drawer.closeDrawer(3)
            this.newActivity("inbox")
          end,
          layout_width="fill",
          -- layout_height="16%w",
          --id="side_dcover",
          padding="16dp",
          visibility=8,
          foreground=波纹(波纹色),
          --backgroundColor=0x3000b1ff,
          --  id="side_inbox",
          {
            ImageView,
            src="drawable/inbox.png",
            layout_height="26dp",
            layout_width="26dp",
            ColorFilter=图标色,
          },
          {
            TextView,
            text="通知",
            textColor=文字色,
            layout_height="fill",
            layout_marginLeft="16dp",
            textSize="16sp",
            gravity="center",
          },
        },
        {
          LinearLayout,
          onClick=function(v)
            --setSidebarItem(v)
            drawer.closeDrawer(3)
            showDialog("退出应用","仅保存背景设置。","退出","取消",function ()
              this.finish()
            end,nil,0xffff4500,nil,false,"后台", function ()
              this.moveTaskToBack(true)
            end)
          end,
          layout_width="fill",
          -- layout_height="16%w",
          --id="side_dcover",
          padding="16dp",
          foreground=波纹(波纹色),
          --backgroundColor=0x3000b1ff,
          --   id="side_inbox",
          {
            ImageView,
            src="drawable/exit.png",
            layout_height="26dp",
            ColorFilter=图标色,
            layout_width="26dp",
          },
          {
            TextView,
            text="退出",
            textColor=文字色,
            layout_height="fill",
            layout_marginLeft="16dp",
            textSize="16sp",
            gravity="center",
          },
        },
        --侧滑上部项目
        {
          LinearLayout,
          layout_width="fill",
          --layout_height="16%w",
          padding="16dp",
          visibility=4,
          {
            ImageView,
            src="drawable/config.png",
            layout_height="26dp",
            ColorFilter=图标色,
            layout_width="26dp",
          },
          {
            TextView,
            text="设置",
            textColor=文字色,
            layout_height="fill",
            layout_marginLeft="16dp",
            textSize="16sp",
            gravity="center",
          },
        },
        {
          LinearLayout,
          layout_width="fill",
          --layout_height="16%w",
          padding="16dp",
          visibility=8,
          {
            ImageView,
            src="drawable/info.png",
            layout_height="fill",
            layout_width="26dp",
          },
          {
            TextView,
            text="关于",
            textColor=文字色,
            layout_height="fill",
            layout_marginLeft="16dp",
            textSize="16sp",
            gravity="center",
          },
        },
      },
    },
    --下部项目
    {
      RelativeLayout,
      --orientation="vertical",
      layout_width="fill",
      elevation="12.5dp",
      backgroundColor=背景色,
      layout_alignParentBottom=true,
      {
        LinearLayout,
        layout_width="fill",
        --layout_height="16%w",
        padding="16dp",
        -- id="side_conf",
        onClick=function(v)
          -- drawer.closeDrawer(3)
          --drawer.openDrawer(3)
          this.newActivity("app/manage")
        end,
        foreground=波纹(波纹色),
        {
          ImageView,
          src="drawable/config.png",
          layout_height="26dp",
          layout_width="26dp",
          ColorFilter=图标色,
        },
        {
          TextView,
          text="设置",
          textColor=文字色,
          layout_height="fill",
          layout_marginLeft="16dp",
          textSize="16sp",
          gravity="center",
        },
      },
      --侧滑下部项目
    },
  },
  --右侧侧边栏
  {
    RelativeLayout,
    id="history",
    layout_gravity="right",
    layout_width="100%w",
    layout_height="fill",
    backgroundColor=背景色,
    paddingTop=状态栏高度,
    onClick=function() end,
    {
      LinearLayout,
      orientation="vertical",
      {
        RelativeLayout,
        layout_width="fill",
        layout_height="56dp",
        padding="16dp",
        --elevation="1%w",
        paddingTop="8dp",
        paddingBottom="8dp",
        {
          RelativeLayout,
          layout_width="fill",
          layout_height="-1",
          gravity="center",
          {
            ImageView,
            src="drawable/back.png",
            layout_height="fill",
            ColorFilter=图标色,
            layout_width="44dp",
            foreground=波纹(波纹色),
            onClick=function ()
              disableDrawer(true,5)
              drawer.closeDrawer(5)
            end,
            padding="9dp",
          },
          {
            ImageView,
            src="drawable/search.png",
            layout_height="fill",
            layout_width="44dp",
            ColorFilter=图标色,
            foreground=波纹(波纹色),
            onClick=function(v)
              local tia=Ticker()
              tia.Period=0
              tia.onTick=function()
                history_search_w.setVisibility(View.VISIBLE)
                ViewAnimationUtils.createCircularReveal(history_search_w,activity.getWidth()-dp2px(54),dp2px(20),0,Math.hypot(history_search_w.getWidth(), history_search_w.getHeight()))
                .setInterpolator(DecelerateInterpolator())
                .setDuration(640)
                .start()
                tia.stop()
              end
              tia.start()
            end,
            layout_alignParentRight=true,
            padding="9dp",
          },--[=[
        {
          ImageView,
          src="drawable/delete.png",
          layout_height="fill",
          layout_width="44dp",
          ColorFilter=图标色,
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
                  refreshHistory()
                 else
                  toast("无法清空历史记录")
                end
              end,nil,0xffff4500)
             else
              toast ("无历史记录")
            end
          end,
          layout_alignParentRight=true,
          padding="9dp",
        },]=]
          {
            TextView,
            layout_width="fill",
            layout_height="fill",
            gravity="center",
            --layout_gravity="center",
            text="历史记录",
            textSize="20sp",
            textColor=文字色,
          },
        },
        {
          LinearLayout,
          layout_width="fill",
          layout_height="-1",
          gravity="center",
          id="history_search_w";
          backgroundColor=背景色,
          onClick=function()end;
          {
            ImageView,
            colorFilter=图标色,
            src="drawable/close.png",
            layout_height="fill",
            layout_width="44dp",
            foreground=波纹(波纹色),
            onClick=function()
              搜索开=false
              搜索词=nil
              refreshHistory()
              ViewAnimationUtils.createCircularReveal(history_search_w,activity.getWidth()-dp2px(54),dp2px(20),Math.hypot(history_search_w.getWidth(), history_search_w.getHeight()),0)
              .setInterpolator(AccelerateInterpolator())
              .setDuration(560)
              .start()
              local tia=Ticker()
              tia.Period=560
              tia.onTick=function()
                history_search_w.setVisibility(View.GONE)
                tia.stop()
              end
              tia.start()
            end,
            padding="9dp",
          },
          {
            EditText,
            layout_width="fill",
            layout_height="fill",
            gravity="left|center",
            layout_marginLeft="8dp";
            --layout_gravity="center",
            layout_weight=1;
            hint="搜点什么？",
            textSize="14sp",
            textColor=文字色,
            singleLine=true;
            background="#00000000";
            hintTextColor=第二文字色;
            id="edit";
          },
          {
            ImageView,
            ColorFilter=图标色,
            src="drawable/search.png",
            padding="9dp",
            layout_width="44dp",
            layout_height="fill",
            onClick=function()
              if edit.Text~="" and edit.Text~=nil then
                搜索词=nil
                搜索词=edit.Text
                搜索开=true
                refreshHistory()
               else
                toast("请输入搜索内容")
              end
            end,
            --layout_alignParentRight=true,
            layout_gravity="right|center",
            foreground=波纹(波纹色),
          },
        },
      };
      {
        HorizontalScrollView,
        horizontalScrollBarEnabled=false,
        {
          LinearLayout,
          id="hissorts",
          --visibility=8,
          {
            TextView,
            padding="8dp",
            onClick=function (v)
              histpgs.showPage(0)
            end,
            foreground=波纹(波纹色),
            text="全部",
            textColor=文字色,
            --  layout_width="14dp",
            gravity="center",
            paddingLeft="22dp",
            paddingRight="22dp",
          },
          {
            TextView,
            -- layout_width="14dp",
            text="心灵鸡汤",
            padding="8dp",
            paddingLeft="22dp",
            paddingRight="22dp",
            textColor=文字色,
            onClick=function (v)
              histpgs.showPage(1)
            end,
            gravity="center",
            foreground=波纹(波纹色),
          },
          {
            TextView,
            -- layout_width="14dp",
            text="毒鸡汤",
            padding="8dp",
            paddingLeft="22dp",
            paddingRight="22dp",
            textColor=文字色,
            onClick=function (v)
              histpgs.showPage(2)
            end,
            gravity="center",
            foreground=波纹(波纹色),
          },
          --[[   {
            TextView,
            padding="8dp",
            textColor=文字色,
            --layout_width="14dp",
            onClick=function (v)
              histpgs.showPage(3)
            end,
            foreground=波纹(波纹色),
            text="你好污啊",
            gravity="center",
      paddingLeft="22dp",
  paddingRight="22dp",
          },]]
          {
            TextView,
            textColor=文字色,
            text="一言",
            padding="8dp",
            onClick=function (v)
              histpgs.showPage(3)
            end,
            foreground=波纹(波纹色),
            paddingLeft="22dp",
            paddingRight="22dp",
            -- layout_width="14dp",
            gravity="center",
          },
          {
            TextView,
            textColor=文字色,
            text="云音乐热评",
            padding="8dp",
            onClick=function (v)
              histpgs.showPage(4)
            end,
            foreground=波纹(波纹色),
            -- layout_width="14dp",
            paddingLeft="22dp",
            paddingRight="22dp",
            gravity="center",
          },
        },
      },
      {
        RelativeLayout,
        {
          PageView,
          -- currentItem=1,
          onPageChangeListener={
            onPageSelected=function (p)
              histCurrentPage=p+1
              for s=0,4 do
                hissorts.getChildAt(s).setAlpha(0.5)
              end
              hissorts.getChildAt(p).setAlpha(1)
              refreshHistory()
              hissorts.Parent.smoothScrollTo(hissorts.getChildAt(p).left,0)
            end},
          id="histpgs",
          pages={
            {
              ListView,
              layout_width="fill",
              onItemLongClickListener=历史长按操作,
              adapter=all_hists,
              OnItemClickListener=历史单击操作,
              dividerHeight=38,
              divider=ColorDrawable(0x00000000),
              fastScrollEnabled=true,
              --id="hislist",
            },
            {
              ListView,
              layout_width="fill",
              adapter=ji_hists,
              OnItemClickListener=历史单击操作,
              dividerHeight=38,
              divider=ColorDrawable(0x00000000),
              onItemLongClickListener=历史长按操作,
              fastScrollEnabled=true,
            },
            {
              ListView,
              layout_width="fill",
              adapter=du_hists,
              OnItemClickListener=历史单击操作,
              dividerHeight=38,
              divider=ColorDrawable(0x00000000),
              onItemLongClickListener=历史长按操作,
              fastScrollEnabled=true,
            },
            --[[   {
              ListView,
              onItemLongClickListener=历史长按操作,
              layout_width="fill",
              adapter=wu_hists,
              OnItemClickListener=历史单击操作,
    dividerHeight=38,
    divider=ColorDrawable(0x00000000),
              fastScrollEnabled=true,
              --id="hislist",
            },]]
            {
              ListView,
              layout_width="fill",
              adapter=yan_hists,
              onItemLongClickListener=历史长按操作,
              OnItemClickListener=历史单击操作,
              dividerHeight=38,
              divider=ColorDrawable(0x00000000),
              fastScrollEnabled=true,
            },
            {
              ListView,
              layout_width="fill",
              adapter=rp_hists,
              onItemLongClickListener=历史长按操作,
              OnItemClickListener=历史单击操作,
              dividerHeight=38,
              divider=ColorDrawable(0x00000000),
              fastScrollEnabled=true,
            },
            --pages
          },
        },
        {
          LinearLayout,
          id="nolog",
          orientation="vertical",
          --visibility=4,
          layout_width='fill',
          layout_height="fill",
          gravity="center",
          {
            ImageView,
            src="drawable/history_empty.png",
            layout_width='fill',
            ColorFilter=图标色,
            layout_height="195dp",
            --adjustViewBounds=true,
            padding="32dp",
          },
          {
            TextView,
            layout_gravity="center",
            text="无记录",
            textColor=次要文字色,
            textSize="22sp",
          },
        },
      },
    },

    --右侧侧边栏
  },
}))

djt.setLineSpacing(48,0.5)

history_search_w.setVisibility(View.GONE)
搜索开=false

source=1
function getSoup(f)
  local f=f or function () end
  --toast("正在盛上毒鸡汤")
  yiyan=nil
  wuwu=nil
  yy=nil
  sp=nil
  wuu=nil
  inf=nil
  透明(pgs,350,{0,1})
  透明(getanopgs,350,{0,1})
  --pgs.setVisibility(0)
  collectgarbage("collect")
  if source==4 then

    local jz={}
    local yeshu=math.random(1,200)
    Http.get("http://www.59xihuan.cn/m/index.php?PageNo="..yeshu, function (c,con)
      if c==200 then
        local n=con:match([[list_news(.-)dede_pages]])
        local n=n:gmatch([[2rem;">(.-)<p]])
        for k in n do
          local k=k:gsub(" +",""):gsub("\n","")
          table.insert(jz,k)
        end
        local j=jz[math.random(1,#jz)]
        --print(j)
        djt.text=j or djt.text
        鸡汤内容=djt.text
        if j then
          newLog(djt.text,"心灵鸡汤")
          notice.text="干了这碗鸡汤"
          f()
          todayNumPlusOne()
          io.open(jitang_save,"w+"):write(djt.text):close()
        end
       else
        pcall(function ()
          wuwu=io.open(jitang_save):read("*a")
          djt.text=wuwu
        end)
        notice.text="鸡汤已打翻"
        vibrateOnce(15)
      end
      透明(pgs,350,{1,0})
      透明(getanopgs,350,{1,0})
    end)

   elseif source==5 then

    Http.get("https://api.4gml.com/NeteaseMusic?type=j", function (c,n)
      if c==200 then
        local user=n:match([[username":"(.-)","con]])
        local song=n:match([[name":"(.-)","songname]])
        local songer=n:match([[songname":"(.-)","userid]])
        local content=n:match([[content":"(.-)"}]])
        pcall(function () inf=content.."\n\n-- "..user.." 在 "..songer.."《"..song.."》的评论" end)
        pcall(function () inf=inf:gsub("%[心碎%]","💔"):gsub("%[公鸡%]","🐓"):gsub("%[圣诞%]","🎄"):gsub("%[皱眉%]","😕"):gsub("%[礼物%]","🎁"):gsub("%[哀伤%]","😞"):gsub("%[流感%]","😷"):gsub("%[开心%]","😊"):gsub("%[吐舌%]","😋"):gsub("%[跳舞%]","💃"):gsub("%[汗%]","😥"):gsub("%[流泪%]","😢"):gsub("%[惊恐%]","😱"):gsub("%[鬼脸%]","👻"):gsub("%[呲牙%]","😁"):gsub("%[发怒%]","😡"):gsub("%[强%]","💪"):gsub("%[星星%]","✨"):gsub("%[奸笑%]","😏"):gsub("%[呆%]","😶"):gsub("%[色%]","🤩"):gsub("%[亲亲%]","😘"):gsub("%[撇嘴%]","😒"):gsub("%[生病%]","🤒"):gsub("%[大哭%]","😭"):gsub("%[拜%]","🙏"):gsub("%[大笑%]","😆"):gsub("%[可爱%]","😇"):gsub("%[钟情%]","😍"):gsub("%[爱心%]","💕"):gsub("%[憨笑%]","😆"):gsub("\\n"," "):gsub("\\r"," "):gsub("\\/","/"):gsub("\\\"","\"") end)
        djt.text=inf or djt.text
        if inf then
          newLog(djt.text,"云音乐热评")
          notice.text="云音乐热评获取成功"
          f()
          todayNumPlusOne()
          io.open(pinglun_save,"w+"):write(djt.text):close()
        end
        鸡汤内容=djt.text
       else
        pcall(function ()
          wuwu=io.open(pinglun_save):read("*a")
          djt.text=wuwu
        end)
        notice.text="热评获取失败"
        vibrateOnce(15)
      end
      透明(pgs,350,{1,0})
      透明(getanopgs,350,{1,0})
    end)

   elseif source==1 then

    --title.text="毒鸡汤"
    Http.get("https://8zt.cc/", function (c,con)
      if c==200 then
        --toast(n)
        local sp=con:match([[font%-size: 2rem;">(.-)</]])
        --print(sp)
        djt.text=sp or djt.text
        鸡汤内容=djt.text
        if sp then
          f()
          newLog(djt.text,"毒鸡汤")
          todayNumPlusOne()
          io.open(soup_save,"w+"):write(djt.text):close()
          notice.text="干了这碗毒鸡汤"
        end
       else
        pcall(function ()
          wuwu=io.open(soup_save):read("*a")
          djt.text=wuwu
        end)
        notice.text="毒鸡汤已打翻"
        vibrateOnce(15)
      end
      透明(pgs,350,{1,0})
      透明(getanopgs,350,{1,0})
      --pgs.setVisibility(4)
      --toast(djt.x,djt.y)
    end)

   elseif source==2 then

    --title.text="你好污啊"
    Http.get("https://www.nihaowua.com/", function (c,con)
      if c==200 then
        local wuu=con:match([[润</mark></div> </header> <section> <div id=(.-)</div> </section>]])
        local wuu=wuu:match([["> <(.-)</]]):match([[>(.+)]])
        djt.text=wuu or djt.text
        if wuu then
          notice.text="变污！"
          io.open(wu_save,"w+"):write(djt.text):close()
          newLog(djt.text,"你好污啊")
          f()
          todayNumPlusOne()
        end
        鸡汤内容=djt.text
       else
        pcall(function ()
          wuwu=io.open(wu_save):read("*a")
          -- if wuwu then
          djt.text=wuwu
          -- end
        end)
        notice.text="污不起来"
        vibrateOnce(15)
      end
      透明(pgs,350,{1,0})
      透明(getanopgs,350,{1,0})
    end)

   else

    --title.text="一言"
    Http.get("https://v1.hitokoto.cn/", function (c,con)
      if c==200 then
        local yy=con:match([[hitokoto": "(.-)",
  "type]])
        local zz=con:match([[from": "(.-)",.-
  "creator"]])
        --toast (con)
        if zz and yy then
          yy=yy.."\n\n-- "..zz
          yy=yy:gsub("\\r",""):gsub("\\t","")--[[:gsub("\r\n",""):gsub("\t",""):gsub("\n","")]]:gsub("\\n",""):gsub("\\\"","")
        end
        djt.text=yy or djt.text
        鸡汤内容=djt.text
        if yy then
          notice.text="一言获取成功"
          newLog(djt.text,"一言")
          f()
          todayNumPlusOne()
          io.open(word_save,"w+"):write(djt.text):close()
         else
          pcall(function ()
            yiyan=io.open(word_save):read("*a")
            -- if yiyan then
            djt.text=yiyan
            --end
          end)
          vibrateOnce(15)
          notice.text="一言获取失败"
        end
       else
        pcall(function ()
          yiyan=io.open(word_save):read("*a")
          -- if yiyan then
          djt.text=yiyan
          --end
        end)
        vibrateOnce(15)
        notice.text="一言获取失败"
      end
      透明(pgs,350,{1,0})
      透明(getanopgs,350,{1,0})
    end)

  end
  collectgarbage("collect")
end

function selectImg()
  local intent=Intent(Intent.ACTION_PICK)
  intent.setType("image/*")
  this.startActivityForResult(intent,1)
  function onActivityResult(request,result,i)
    if i then
      -- pcall(function ()
      local cursor =this.getContentResolver ().query(i.getData(), nil, nil, nil, nil)
      cursor .moveToFirst()
      local path=cursor.getString(cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA))
      local result=loadbitmap (path)
      if result then
        bgblur.Parent.visibility=0
        io.open(bground_path,"w+"):write(path):close()
        bg.setImageBitmap(result)
        if not isMakingWall then
          disableDrawer(false)
        end
        --onResume()
        --gbsshown=false
      end
      -- end)
    end
    function onActivityResult() end
  end
end

function makeWall()
  if wmswt.Checked then
    water_mark_main.setVisibility(0)
  end
  disableDrawer(true)
  mwallvisible=true
  isMakingWall=true
  --bg.foreground=ColorDrawable(0)
  Y位移(main_topBar,350,{0,-h})
  Y位移(main_bmbar,350,{0,h})
  Y位移(mWall_bmBar,350,{h,0})
  djt.onClick=function () end
  bg.onClick=function ()
    if mwallvisible then
      mwallvisible=false
      mWall.visibility=4
      mWall.visibility=4
      补间透明(mWall,350,1,0)
     else
      mwallvisible=true
      mWall.visibility=0
      补间透明(mWall,350,0,1)
    end
  end
  --mWall.visibility=0
  补间透明(mWall,350,0,1)
  djt.setOnTouchListener{
    onTouch=function (v,e)
      local x=e.getRawX()-v.width/2
      local y=e.getRawY()-v.height/2
      -- toast(v.x,v.y)
      if x>-v.width*0.5 and x<w-v.width*0.5 then
        v.x=x
      end
      if y>-v.height*0.5 and y<h-v.height/2 then
        v.y=y
      end
      local xplus=djt_xposition.Parent.getChildAt(0)
      if x>-v.width*0.5 then
        xplus.colorFilter=图标色
       else
        xplus.colorFilter=淡色
      end
      local xminu=djt_xposition.Parent.getChildAt(2)
      if x<w-v.width*0.5 then
        xminu.colorFilter=图标色
       else
        xminu.colorFilter=淡色
      end
      local yplus=djt_yposition.Parent.getChildAt(0)
      if x>-v.width*0.5 then
        yplus.colorFilter=图标色
       else
        yplus.colorFilter=淡色
      end
      local yminu=djt_yposition.Parent.getChildAt(2)
      if x<h-v.width*0.5 then
        yminu.colorFilter=图标色
       else
        yminu.colorFilter=淡色
      end
      djt.text=djt.text
      djt_xposition.text=string.format("%.0f",v.x)
      djt_yposition.text=string.format("%.0f",v.y)
    end}
  --djt.setTextIsSelectable(false)
  djt.setClickable(true)
  djt.text=djt.text
  sText.setVisibility(0)
  pcall(function () fl_toMake.visibility=8 end)
end

function toMain()
  water_mark_main.setVisibility(8)
  disableDrawer(false)
  isMakingWall=false
  --bg.foreground=ColorDrawable(0x35FFFFFF)
  Y位移(main_topBar,350,{-h,0})
  Y位移(main_bmbar,350,{h,0})
  Y位移(mWall_bmBar,350,{0,h})
  djt.onClick=function ()
    if not 句子 then
      getSoup(function ()
        djt.y=h/2-djt.height/2
      end)
    end
  end
  bg.onClick=function ()
    djt.performClick()
  end
  --mWall.visibility=4
  补间透明(mWall,350,1,0)
  djt.setVisibility(0)
  --djtedt_con.setVisibility(4)
  isEditingdjt=false
  djt.setOnTouchListener{onTouch=function (v,e) end}
  -- djt.setTextIsSelectable(true)
  djt.setClickable(true)
  djt.x=0
  djt.y=h/2-djt.height/2
  sText.setVisibility(8)
  pcall(function () fl_toMake.visibility=0 end)
end

quittime=0
wmarkshown=false
col=1
djtGravity=1
isEditingdjt=false
gbsshown=false
isMakingWall=false
mwallvisible=true
bktime=0
shareshown=false
tsetshown=false
ldopend=false
rdopend=false

function onKeyDown(k)
  if k==4 then
    if drawer.isDrawerOpen(5) or rdopend then
      drawer.closeDrawer(5)
     elseif drawer.isDrawerOpen(3) or ldopend then
      drawer.closeDrawer(3)
     elseif wmarkshown then
      Y位移(wmark,350,{0,h})
      if not isMakingWall then
        disableDrawer(false)
      end
      wmarkshown=false
     elseif shareshown then
      Y位移(sharetype,350,{0,h})
      if not isMakingWall then
        disableDrawer(false)
      end
      shareshown=false
     elseif gbsshown then
      Y位移(bgtype,350,{0,h})
      gbsshown=false
      if not isMakingWall then
        disableDrawer(false)
      end
      gbsshown=false
     elseif isEditingdjt then
      djt.setVisibility(0)
      --djtedt_con.setVisibility(4)
      isEditingdjt=false
     elseif not mwallvisible then
      mwallvisible=true
      mWall.visibility=0
      补间透明(mWall,350,0,1)
     elseif tsetshown then
      tsetshown=false
      --disableDrawer(false)
      Y位移(textset,350,{0,h})
     elseif isMakingWall then
      if 句子 then
        if quittime<1 then
          quittime=quittime+1
          toast("再按一次返回键退出编辑")
         else
          this.finish()
        end
       else
        toMain()
      end
     elseif not 句子 then
      this.moveTaskToBack(true)
      --end
    end
    collectgarbage("collect")
    return true
  end
end

function onResume()
  --toast(djt.x,djt.y)
  local pr=应用数据.."/previous_system_wall.png"
  if File(pr). exists() then
    setPrev.setVisibility(0)
   else
    setPrev.setVisibility(8)
  end
  refreshInAppFont()
  pcall(function ()
    bgp=io.open(bground_path):read("*a")
  end)
  pcall(function () bp=loadbitmap(bgp) end)
  pcall(function () cp=ColorDrawable(tonumber(bgp)) end)
  if bp then
    bgblur.Parent.visibility=0
    bg.setImageBitmap(getBlurBitmap(bp,bgblur.progress))
   elseif cp then
    bg.setBackground(cp)
    bgblur.Parent.visibility=8
   else
    bg.setBackgroundColor(0)
  end
  pcall(function ()
    wm.removeView(xfcard)
    floa=nil
  end)
  local f=io.open(今天条数)
  if f then
    local da=StrToTable(f:read("*a"))
    local riqi=da.date
    local td=tostring(os.date("%x"))
    if riqi~=td then
      io.open(今天条数,"w+"):write([[{
count="0",
date="]]..td..[[",
}]]):close()
    end
  end
  pcall(function ()
    niOn=io.open(nightMode):read("*a")
  end)
  if nOn~=niOn then
    toast ("正在更新界面")
    this.recreate()
    nOn=niOn
  end
  collectgarbage("collect")
end

function getTextFlags()
  local flags=Paint.ANTI_ALIAS_FLAG
  if delswt.Checked then
    flags=flags|Paint.STRIKE_THRU_TEXT_FLAG
  end
  if ulswt.Checked then
    flags=flags|Paint.UNDERLINE_TEXT_FLAG
  end
  if ctswt.Checked then
    flags=flags|Paint.FAKE_BOLD_TEXT_FLAG
  end
  --toast (flags)
  djt.text=djt.text
  return flags
end

function setTextAlign(v)
  for a=0,2 do
    txtalign.getChildAt(a).setColorFilter(淡色)
  end
  v.setColorFilter(图标色)
  if v==txtalign.getChildAt(0) then
    djt.setGravity(Gravity.LEFT)
   elseif v==txtalign.getChildAt(1) then
    djt.setGravity(Gravity.CENTER)
   else
    djt.setGravity(Gravity.RIGHT)
  end
end

disableDrawer(true,5)

function setSidebarItem(v)
  side_djt.setBackgroundColor(0)
  --  side_nihaowu.setBackgroundColor(0)
  side_yiyan.setBackgroundColor(0)
  side_jt.setBackgroundColor(0)
  side_rp.setBackgroundColor(0)
  v.setBackgroundColor(bgInverse)
end

function refreshHistory()
  --历史记录
  if histCurrentPage==1 then
    all_hists.clear()
   elseif histCurrentPage==3 then
    du_hists.clear()
    --   elseif histCurrentPage==4 then
    --  wu_hists.clear()
   elseif histCurrentPage==5 then
    rp_hists.clear()
   elseif histCurrentPage==4 then
    yan_hists.clear()
   elseif histCurrentPage==2 then
    ji_hists.clear()
  end
  local fl=getFileList(soup_logs)
  for i=1,#fl do
    local lujing=tostring(fl[i])
    if 搜索开 then
      if StrToTable(io.open(lujing):read("*a")).soup:gsub(搜索词,"")~=StrToTable(io.open(lujing):read("*a")).soup then
        pcall(function()
          local content=StrToTable(io.open(lujing):read("*a"))
          if histCurrentPage==1 then
            all_hists.insert(0,{
              nr=content.soup,
              lx=content.type,
              lj=lujing,
            })
          end
          if histCurrentPage==3 and content.type:find"毒鸡汤" then
            du_hists.insert(0,{
              nr=content.soup,
              lx=content.type,
              lj=lujing,
            })
          end
          if histCurrentPage==2 and content.type=="心灵鸡汤" then
            ji_hists.insert(0,{
              nr=content.soup,
              lx=content.type,
              lj=lujing,
            })
          end
          if histCurrentPage==5 and content.type:find"热评" then
            rp_hists.insert(0,{
              nr=content.soup,
              lx=content.type,
              lj=lujing,
            })
          end
          --[[  if histCurrentPage==4 and content.type=="你好污啊" then
        wu_hists.insert(0,{
          nr=content.soup,
          lx=content.type,
          lj=lujing,
        })
      end]]
          if histCurrentPage==4 and content.type=="一言" then
            yan_hists.insert(0,{
              nr=content.soup,
              lx=content.type,
              lj=lujing,
            })
          end
        end)
      end
     else
      pcall(function()
        local content=StrToTable(io.open(lujing):read("*a"))
        if histCurrentPage==1 then
          all_hists.insert(0,{
            nr=content.soup,
            lx=content.type,
            lj=lujing,
          })
        end
        if histCurrentPage==3 and content.type:find"毒鸡汤" then
          du_hists.insert(0,{
            nr=content.soup,
            lx=content.type,
            lj=lujing,
          })
        end
        if histCurrentPage==2 and content.type=="心灵鸡汤" then
          ji_hists.insert(0,{
            nr=content.soup,
            lx=content.type,
            lj=lujing,
          })
        end
        if histCurrentPage==5 and content.type:find"热评" then
          rp_hists.insert(0,{
            nr=content.soup,
            lx=content.type,
            lj=lujing,
          })
        end
        --[[  if histCurrentPage==4 and content.type=="你好污啊" then
        wu_hists.insert(0,{
          nr=content.soup,
          lx=content.type,
          lj=lujing,
        })
      end]]
        if histCurrentPage==4 and content.type=="一言" then
          yan_hists.insert(0,{
            nr=content.soup,
            lx=content.type,
            lj=lujing,
          })
        end
      end)
    end
  end
  if 搜索开 then
    if savedPreviousSoup:gsub(搜索词,"")~=savedPreviousSoup then
      pcall(function()
        if savedPreviousSoup and (histCurrentPage==1 or histCurrentPage==3) then
          if all_hists.getCount()<1 or (all_hists.getItem(0).nr~=savedPreviousSoup and all_hists.getItem(all_hists.getCount()-1).nr~=savedPreviousSoup) then
            all_hists.add{
              nr=savedPreviousSoup,
              lx="毒鸡汤",
            }
          end
          if du_hists.getCount()<1 or (du_hists.getItem(0).nr~=savedPreviousSoup and du_hists.getItem(du_hists.getCount()-1).nr~=savedPreviousSoup) then
            du_hists.add{
              nr=savedPreviousSoup,
              lx="毒鸡汤",
            }
          end
        end
      end)
    end
   else
    pcall(function ()
      if savedPreviousSoup and (histCurrentPage==1 or histCurrentPage==3) then
        if all_hists.getCount()<1 or (all_hists.getItem(0).nr~=savedPreviousSoup and all_hists.getItem(all_hists.getCount()-1).nr~=savedPreviousSoup) then
          all_hists.add{
            nr=savedPreviousSoup,
            lx="毒鸡汤",
          }
        end
        if du_hists.getCount()<1 or (du_hists.getItem(0).nr~=savedPreviousSoup and du_hists.getItem(du_hists.getCount()-1).nr~=savedPreviousSoup) then
          du_hists.add{
            nr=savedPreviousSoup,
            lx="毒鸡汤",
          }
        end
      end
    end)
  end
  -- toast(adps[histCurrentPage].getItem(0).nr)
  if histCurrentPage==1 then
    all_hists.notifyDataSetChanged()
   elseif histCurrentPage==3 then
    du_hists.notifyDataSetChanged()
    --  elseif histCurrentPage==4 then
    --wu_hists.notifyDataSetChanged()
   elseif histCurrentPage==4 then
    yan_hists.notifyDataSetChanged()
   elseif histCurrentPage==2 then
    ji_hists.notifyDataSetChanged()
   elseif histCurrentPage==5 then
    rp_hists.notifyDataSetChanged()
  end
  if adps[histCurrentPage].getCount()>0 then
    nolog.setVisibility(8)
   else
    nolog.setVisibility(0)
  end
  --toast (histCurrentPage,adps[histCurrentPage].getCount())
  collectgarbage("collect")
end

if not 句子 then
  local f,e=io.open(tongjifile)
  if e then
    io.open(tongjifile,"w+"):write(os.date("%y-%m-%d")):close()
    Http.get("http://6du.in/0tdI9QJ", function ()end)
   else
    if io.open(tongjifile):read("*a")~=os.date("%y-%m-%d") then
      Http.get("http://6du.in/0tdI9QJ", function (c)
        if c==200 then
          io.open(tongjifile,"w+"):write(os.date("%y-%m-%d")):close()
        end
      end)
    end
  end
  Http.get("https://gitee.com/ayaka_ago/WordsLeisure/raw/master/Version/Update.txt", function (c,n)
    if c==200 then
      local n=StrToTable(n)
      if n.toUser and 本地版本<n.Ver then
        showDialog("检测到新版本",--[["当前版本 - "..本地版本.."\n"..]]"版本 - v"..n.Ver.."\n\n"..n.Changes,"在酷安下载","在浏览器下载",function ()
          openInBrowser(n.coolapkUrl)
        end,function()
          openInBrowser(n.apkUrl)
        end,nil,nil,false,"暂不更新")
      end
    end
  end)
end

wm_style_scr.getChildAt(0).backgroundColor=bgInverse
function setSelectedStyleItem(v)
  for s=0,3 do
    if s<2 then
      wm_style_scr.getChildAt(s).backgroundColor=0
     else
      wm_style_scr.getChildAt(s).getChildAt(0).backgroundColor=0
    end
  end
  sty3_contedt.setVisibility(8)
  pwm_note.setVisibility(8)
  sty4_contedt.setVisibility(8)
  if v==wm_style_scr.getChildAt(2).getChildAt(0) then
    sty3_contedt.setVisibility(0)
    pwm_note.setVisibility(0)
   elseif v==wm_style_scr.getChildAt(3).getChildAt(0) then
    sty4_contedt.setVisibility(0)
  end
  v.backgroundColor=bgInverse
end

function setSelectedWmarkPos(v)
  for k=0,1 do
    local pa=wmarkpos.getChildAt(k)
    for h=0,1 do
      pa.getChildAt(h).backgroundColor=0
    end
  end
  v.backgroundColor=bgInverse
end

function selectWmImg()
  local intent=Intent(Intent.ACTION_PICK)
  intent.setType("image/*")
  this.startActivityForResult(intent,1)
  function onActivityResult(request,result,i)
    if i then
      -- pcall(function ()
      local cursor =this.getContentResolver ().query(i.getData(), nil, nil, nil, nil)
      cursor .moveToFirst()
      local path=cursor.getString(cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA))
      local result=loadbitmap (path)
      if result then
        water_mark_main.getChildAt(0).setImageBitmap(result)
        wm_preview.getChildAt(0).setImageBitmap(result)
      end
      -- end)
    end
    function onActivityResult() end
  end
end

if not File(启用通知). exists () then
  io.open(启用通知,"w+"):write("true"):close()
end

if 句子 then
  鸡汤内容=句子
  djt.text=句子
  title.text="自定义句子"
  local topbar=title.Parent.Parent
  topbar.getChildAt(0).imageBitmap=loadbitmap ("drawable/back.png")
  topbar.getChildAt(0).onClick=function()
    this.finish()
  end
  topbar.getChildAt(1). visibility=8
  getanopgs.Parent. visibility=8
  notice.text="长按自由复制"
  makeWall()
  disableDrawer(true,3)
  disableDrawer(true,5)
 else
  --toast ("欢迎回来")
end

function onDestroy()
  --tts.shutdown()
  --toast ("activity destroyed")
  pcall(function ()
    wm.removeView(xfcard)--关闭悬浮窗
    floa=nil
  end)
end

function todayNumPlusOne()
  local f=io.open(今天条数)
  local da={}
  if f then
    pcall(function ()
      da=StrToTable(f:read("*a"))
    end)
  end
  local tody=tostring(os.date("%x"))
  local date=da.data or tody
  local num=tonumber(da.count) or 0
  --toast (tody,date)
  if date==tody then
    n=num+1 or 1
   else
    n=1
  end
  io.open(今天条数,"w+"):write([[{
count="]]..n..[[",
date="]]..tody..[[",
}]]):close()
  da=nil
  n=nil
  pcall(function ()
    fl_djt.text=djt.text
  end)
end

function onPause()
  --print ("pause")
  --collectgarbage("count")
  collectgarbage("collect")
end

if nOn=="true" then
  nightModeOverlay.setForeground(ColorDrawable(0x55000000))
end

if whole==1 then
  File(通知历史).mkdirs()

  function onPause()
    --print ("pause")
    local isFloatEnabled="false"
    pcall(function ()
      isFloatEnabled=io.open(启用浮窗):read("*a")
    end)
    if floa then
      pcall(function()wm.removeView(xfcard) end)
      floa=nil
    end
    if not 句子 then
      if isFloatEnabled=="true" and not floa then
        floa=true
        import "android.graphics.PixelFormat"
        hw=activity.getWidth()
        w=hw
        hh=activity.getHeight()
        h=hh
        wm=activity.getApplicationContext().getSystemService(Context.WINDOW_SERVICE);
        lp=WindowManager.LayoutParams()
        lp.format = PixelFormat.RGBA_8888
        lp.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
        lp.type=WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
        lp.width=WindowManager.LayoutParams.WRAP_CONTENT
        lp.height=WindowManager.LayoutParams.WRAP_CONTENT
        lp.gravity=Gravity.CENTER

        悬浮窗布局={
          LinearLayout,
          layout_width="fill",
          layout_height="fill",
          orientation="vertical",
          paddingTop=0,
          padding="8dp";
          --onClick=function () end,
          id="xfcard",
          backgroundDrawable=圆角(nil,浮窗背景色,{17,17,17,17,17,17,17,17});
          {
            LinearLayout,
            id="fl_control_top",
            --layout_gravity="bottom|center",
            gravity="center",
            layout_width="fill",
            padding="8dp";
            {
              TextView,
              textSize="14sp",
              text="闲言 - 句子浮窗",
              textColor=次要文字色,
              padding=0.025*w,
              layout_width="fill",
              layout_weight=1;
              id="xfbt";
            },
            {
              TextView,
              foreground=波纹(波纹色),
              onClick=function()
                wm.removeView(xfcard)--关闭悬浮窗
                floa=nil
              end,
              textSize="14sp",
              text="隐藏",
              textColor="#ffff4500",
              padding=0.025*w,
            },
          };
          {
            TextView,
            textColor=文字色,
            id="fl_djt",
            --textIsSelectable=true,
            textSize="16sp",
            padding="16dp",
            paddingBottom="8dp",
            text=djt.text,
            layout_width="76.25%w",
            paddingTop=0,
          },
          {
            LinearLayout,
            id="fl_control",
            --layout_gravity="bottom|center",
            gravity="center",
            layout_width="fill",
            paddingLeft="8dp";
            paddingRight="8dp";
            {
              TextView,
              textColor=次要文字色,
              text="刷新",
              foreground=波纹(波纹色),
              onClick=function ()
                getSoup()
              end,
              textSize="14sp",
              padding="10dp",
            },
            {
              TextView,
              text="复制",
              layout_marginLeft="12dp",
              textColor=次要文字色,
              textSize="14sp",
              foreground=波纹(波纹色),
              onClick=function ()
                copyText(fl_djt.text)
              end,
              padding="10dp",
            },
            {
              TextView,
              foreground=波纹(波纹色),
              onClick=function ()
                shareText(fl_djt.text)
              end,
              textSize="14sp",
              layout_marginLeft="12dp",
              text="分享",
              textColor=次要文字色,
              padding="10dp",
            },
            {
              TextView,
              text="制作壁纸",
              foreground=波纹(波纹色),
              onClick=function (v)
                local i=packm.getLaunchIntentForPackage(pack_name)
                --i.addCategory(Intent.CATEGORY_LAUNCHER)
                --i.setAction(Intent.ACTION_MAIN)
                this.startActivity(
                i)
                if not isMakingWall then
                  makeWall()
                end
                v.visibility=8
              end,
              padding="10dp",
              textSize="14sp",
              --visibility=8,
              id="fl_toMake",
              textColor=次要文字色,
              layout_marginLeft="12dp",
            },
          },
        }
        xpcall(function()
          wm.addView(loadlayout(悬浮窗布局),lp)
        end,function()
          toast("悬浮窗启动失败，请检查悬浮窗权限")
        end)

        lastX=0
        lastY=0
        vx=0
        vy=0
        xfbt.onTouch=function(v,e)
          ry=e.getRawY()--获取触摸绝对Y位置
          rx=e.getRawX()--获取触摸绝对X位置
          if e.getAction() == MotionEvent.ACTION_DOWN then
            vy=ry-e.getY()--获取视图的Y位置
            vx=rx-e.getX()--获取视图的X位置
            lastY=ry--记录按下的Y位置
            lastX=rx--记录按下的X位置
           elseif e.getAction() == MotionEvent.ACTION_MOVE then
            lp.gravity=Gravity.LEFT|Gravity.TOP --调整悬浮窗口至左上角
            lp.x=vx+(rx-lastX)-dp2px(8)--移动的相对位置
            lp.y=vy+(ry-lastY)-状态栏高度-dp2px(8)--移动的相对位置
            wm.updateViewLayout(xfcard,lp)--调整悬浮窗至指定的位置
          end
          return true
        end
      end
    end
    --collectgarbage("count")
    collectgarbage("collect")
  end

  function onResume()
    --toast(djt.x,djt.y)
    local pr=应用数据.."/previous_system_wall.png"
    if File(pr). exists() then
      setPrev.setVisibility(0)
     else
      setPrev.setVisibility(8)
    end
    refreshInAppFont()
    pcall(function ()
      bgp=io.open(bground_path):read("*a")
    end)
    pcall(function () bp=loadbitmap(bgp) end)
    pcall(function () cp=ColorDrawable(tonumber(bgp)) end)
    if bp then
      bgblur.Parent.visibility=0
      bg.setImageBitmap(getBlurBitmap(bp,bgblur.progress))
     elseif cp then
      bg.setBackground(cp)
      bgblur.Parent.visibility=8
     else
      bg.setBackgroundColor(0)
    end

    pcall(function ()
      wm.removeView(xfcard)--关闭悬浮窗
      floa=nil
    end)

    local f=io.open(今天条数)
    if f then
      local da=StrToTable(f:read("*a"))
      local riqi=da.date
      local td=tostring(os.date("%x"))
      if riqi~=td then
        io.open(今天条数,"w+"):write([[{
count="0",
date="]]..td..[[",
}]]):close()
      end
    end

    --https://gitee.com/ayaka_ago/WordsLeisure/raw/master/Advertisement/notification.txt
    Http.get("https://agys.wodemo.net/entry/520324", function (c,n)
      if c==200 then
        local n=n:match([[<div class=%"wo%-entry%-section wo%-text%-text%">(.-)</div>]]):gsub("</em>","_"):gsub("<em>","_"):gsub("&amp;","&"):gsub("&quot;","\"")
        local content=StrToTable(n)
        --print(n,dump(content))
        local isActive=content.isActive or true
        local title=content.title
        local con=content.content
        local url=content.link
        local f=io.open(最新通知)
        if f then f=f:read("*a") else f="{content=''}" end
        local co=StrToTable(f).content or ""
        if co~=con then
          io.open(最新通知,"w+"):write([[{
title=]].."[["..title.."]]"..[[,
content=]].."[["..con.."]]"..[[,
type=]].."[["..content.type.."]]"..[[,{
time=]].."[["..content.time.."]]"..[[,
url=]].."[["..url.."]]"..[[,
}]]):close()
          LuaUtil.copyDir(最新通知,通知历史..os.date("%Y-%m-%d"))
          pcall(function ()
            c=io.open(启用通知):read("*a")
          end)
          local c=c or "true"
          if isActive==true and (c=="true" or (c~="true" and c~="false")) then
            sendNotification(title,con,url)
          end
        end
        f=nil
      end
    end)

    pcall(function ()
      niOn=io.open(nightMode):read("*a")
    end)
    if nOn~=niOn then
      toast ("正在更新界面")
      this.recreate()
      nOn=niOn
    end

    collectgarbage("collect")
  end

  showTerms(nil,function()
    ti=Ticker()
    ti.Period=500
    ti.onTick=function()
      ti.stop()
      drawer.openDrawer(3)
      ti=Ticker()
      ti.Period=500
      ti.onTick=function()
        drawer.closeDrawer(3)
        ti.stop()
      end
      ti.start()
    end
    ti.start()
  end)

end

txtimfnt.setOnItemSelectedListener{
  onItemSelected=function(p,v,n)
    pcall(function () djt.setTypeface(Typeface.createFromFile(File(v.getChildAt(1).text))) end)
  end}

txtfnt.setOnItemSelectedListener{
  onItemSelected=function(p,v)
    pcall(function ()
      local pt=v.getChildAt(1).text
      if pt=="default" then
        djt.setTypeface(Typeface.SANS_SERIF)
       else
        pcall(function () djt.setTypeface(Typeface.createFromFile(File(pt))) end)
      end
    end)
  end}

--txtfnt.setSelection(2)
txtfnt.setSelection(0)

function onStart()
  if tostring(activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()):match("&(.-)&")~=nil then
    if tostring(activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()):match("&(.-)&"):sub(1,2)=="MS" then
      local url="https://www.tipsoon.com/?c=article&id="..tostring(activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()):match("&(.-)&"):match("MS(.+)")
      Http.get(url,"utf8",function(code,content)
        if code==200 then
          if content~="" then
            showDialog("要打开微风暴吗","检测到你复制了微风暴密令“&"..tostring(activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()):match("&(.-)&").."&”\n文章名："..content:match("<div class=\"w90 pL5 pR5 pT4 pB1 fL\"(.-)</div>"):match(">(.+)"),"打开文章","取消",function ()
              activity.newActivity("app/microstorm",{tostring(activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()):match("&(.-)&"):match("MS(.+)")})
              activity.getSystemService(Context.CLIPBOARD_SERVICE).setText("")
              --写入剪贴板
            end,nil,nil,nil,true,"清除剪贴板", function()
              activity.getSystemService(Context.CLIPBOARD_SERVICE).setText("")
              --写入剪贴板
            end,nil)
          end
        end
      end)
      --标题，内容，确定，取消，确定时间，取消时间，确定颜色，取消颜色，可关闭，第三按钮，fun，颜色
    end
    if tostring(activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()):match("&(.-)&"):sub(1,2)=="SR" then
      local url="https://interface.meiriyiwen.com/article/day?dev=1&date="..tostring(activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()):match("&(.-)&"):match("SR(.+)")
      Http.get(url,"utf8",function(code,content)
        if code==200 then
          content = cjson.decode(content)
          random_title=content.data.title
          showDialog("要打开超级阅读吗","检测到你复制了超级阅读密令“&"..tostring(activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()):match("&(.-)&").."&”\n文章名："..random_title,"打开文章","取消",function ()
            activity.newActivity("app/superreading",{tostring(activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()):match("&(.-)&"):match("SR(.+)")})
            activity.getSystemService(Context.CLIPBOARD_SERVICE).setText("")
            --写入剪贴板
          end,nil,nil,nil,true,"清除剪贴板", function()
            activity.getSystemService(Context.CLIPBOARD_SERVICE).setText("")
            --写入剪贴板
          end,nil)
        end
      end)
      --标题，内容，确定，取消，确定时间，取消时间，确定颜色，取消颜色，可关闭，第三按钮，fun，颜色
    end
  end
  if activity.getSharedData("password")~=nil then
    登录账号(t1url,t1key,activity.getSharedData("username"),activity.getSharedData("password"),t1httk,function(返回值)
      if 返回值=="401" then
        toast("出现异常！")
       else
        data=cjson.decode(返回值)
        if data["code"]=="1" then
          ch_title.Text=activity.getSharedData("username")
          ch_subtitle.Text="Sup到期时间:"..data["vip_time"]
          activity.setSharedData("sup",data["vip_time"])
         elseif data["code"]=="0" then
          toast(data["message"])
        end
      end
    end)
  end
end

function onResult(name,...)