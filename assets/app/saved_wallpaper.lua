require "import"
import "str"

--适配器数据
wall_adp=LuaAdapter(this,{},{
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
square_adp=LuaAdapter(this,{},{
  LinearLayout,
  layout_width="fill",
  --layout_height=w/2,
  backgroundColor=背景色,
  {
    ImageView,
    scaleType="fitCenter",
    id="wp",
    layout_width="fill",
    --layout_height="fill",
  },
  {
    TextView,
    visibility=8,
    id="pa",
  },
})

单击操作={
  onItemClick=function (g,v)
    local p="file://"..v.getChildAt(1).text
    openPicture (p)
  end}

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
      layout_width="44dp" ,
      foreground=波纹(波纹色),
      onClick=function ()
        this.finish()
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
      text="已保存的图片",
      textSize="20sp",
      textColor=文字色,
    },
  },
  {
    LinearLayout,
    id="tab",
    {
      TextView,
      layout_width="50%w",
      foreground=波纹(波纹色),
      onClick=function ()
        pgs.showPage(0)
      end,
      text="壁纸",
      textColor=文字色,
      padding="8dp",
      --paddingLeft="16dp",
      --paddingRight="16dp",
      gravity="center",
    },
    {
      TextView,
      layout_width="50%w",
      foreground=波纹(波纹色),
      onClick=function ()
        pgs.showPage(1)
      end,
      text="纯文本图片",
      textColor=文字色,
      padding="8dp",
      --paddingLeft="16dp",
      --paddingRight="16dp",
      alpha=0.5,
      gravity="center",
    },
  },
  {
    RelativeLayout,
    layout_height="fill",
    {
      LinearLayout,
      id="nopic",
      orientation="vertical",
      -- visibility=8,
      layout_width='fill',
      layout_height="fill",
      --paddingTop=lay_wh,
      gravity="center",
      --gravity="center",
      {
        ImageView,
        src="drawable/package.png",
        layout_width='fill',
        colorFilter=图标色,
        layout_height=w/5*3,
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
      PageView,
      onPageChangeListener={
        onPageSelected=function (p)
          np=p
          for t=0,1 do
            tab.getChildAt(t).alpha=0.5
          end
          tab.getChildAt(p).alpha=1
          if p==0 then
            if wall_adp.getCount()>0 then
              nopic.setVisibility(8)
             else
              nopic.setVisibility(0)
            end
           else
            if square_adp.getCount()>0 then
              nopic.setVisibility(8)
             else
              nopic.setVisibility(0)
            end
          end
        end},
      id="pgs",
      pages={
        {
          GridView,
          adapter=wall_adp,
          layout_width="fill",
          layout_height="fill",
          numColumns=2,
          onItemClickListener=单击操作,
          onItemLongClickListener={
            onItemLongClick=function (g,v)
              local edt=AlertDialog.Builder(this)
              -- .setCancelable(false)
              .setTitle("选择操作")
              .setItems({"查看","设为壁纸","分享","删除"}, function (d,n)
                if n==0 then
                  local i = Intent(Intent.ACTION_VIEW)
                  local u= Uri.parse("file://"..v.getChildAt(1).text)
                  i.setDataAndType(u, "image/*")
                  this.startActivity(i)
                 elseif n==1 then
                  local hei = wallman. getDesiredMinimumHeight()
                  local wallpaper = Bitmap.createScaledBitmap(loadbitmap(v.getChildAt(1).text), w, hei, true);
                  if pcall(function ()
                      setWallpaper(wallpaper)
                    end) then
                    --toast ("设置成功")
                   else
                    -- toast ("设置失败")
                  end
                 elseif n==2 then
                  shareBitmap(loadbitmap (v.getChildAt(1).text))
                 else
                  showDialog("删除","是否删除此图片？此操作无法撤销。","删除","取消", function ()
                    deletePic(v.getChildAt(1).text)
                    onResume()
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
          id="wpaper",
          --layout_marginBottom="16%w",
        },
        {
          GridView,
          adapter=square_adp,
          layout_width="fill",
          layout_height="fill",
          numColumns=1,
          onItemClickListener=单击操作,
          onItemLongClickListener={
            onItemLongClick=function (g,v)
              local edt=AlertDialog.Builder(this)
              -- .setCancelable(false)
              .setTitle("选择操作")
              .setItems({"查看","分享","删除"}, function (d,n)
                if n==0 then
                  local i = Intent(Intent.ACTION_VIEW)
                  local u= Uri.parse("file://"..v.getChildAt(1).text)
                  i.setDataAndType(u, "image/*")
                  this.startActivity(i)
                 elseif n==1 then
                  shareBitmap(loadbitmap (v.getChildAt(1).text))
                 else
                  showDialog("删除","是否删除此图片？此操作无法撤销。","删除","取消", function ()
                    deletePic(v.getChildAt(1).text)
                    onResume()
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
          id="tonly",
          --layout_marginBottom="16%w",
        },
        --pageview
      },
    },

  },
}))

function onResume()
  wall_adp.clear()
  square_adp.clear()
  plist=getFileList(wallpaper_path)
  for o=1,#plist do
    local pt=tostring(plist[o])
    if pt:find"%.png" and not pt:find"text%_only" then
      wall_adp.insert(0,{
        wp=pt,
        pa=pt,
      })
    end
  end
  for o=1,#plist do
    local pt=tostring(plist[o])
    if pt:find"%.png" and pt:find"text%_only" then
      square_adp.insert(0,{
        wp=pt,
        pa=pt,
      })
    end
  end
  wall_adp.notifyDataSetChanged()
  square_adp.notifyDataSetChanged()
  if np==0 then
    if wall_adp.getCount()>0 then
      nopic.setVisibility(8)
     else
      nopic.setVisibility(0)
    end
   else
    if square_adp.getCount()>0 then
      nopic.setVisibility(8)
     else
      nopic.setVisibility(0)
    end
  end
end