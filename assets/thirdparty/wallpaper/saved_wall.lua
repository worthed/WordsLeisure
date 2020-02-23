require "import"
import "str"

p=...

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
blay={
  FrameLayout,
  layout_width="fill",
  backgroundColor=背景色,
  {
    ImageView,
    --scaleType="centerCrop",
    id="wp",
    adjustViewBounds=true,
    layout_width="fill",
    -- layout_height="fill",
  },
  {
    TextView,
    visibility=8,
    id="pa",
  },
}
localpic=LuaAdapter(this,{},play)
localwall=LuaAdapter(this,{},alay)
bingwa=LuaAdapter(this,{},blay)

this.setContentView(loadlayout ( {
  LinearLayout,
  layout_width="fill",
  layout_height="fill",
  paddingTop=状态栏高度,
  backgroundColor=背景色,
  orientation="vertical",
  {
    RelativeLayout,
    layout_width="fill",
    layout_height="56dp",
    gravity="center",
    padding="16dp",
    --backgroundColor=0xffffffff,
    paddingTop="8dp",
    paddingBottom="8dp",
    elevation="2dp",
    {
      ImageView,
      colorFilter=图标色,
      src="drawable/back.png",
      layout_height="fill",
      layout_width="44dp" ,
      foreground=波纹(波纹色),
      onClick=function ()
        drawer.closeDrawer(5)
      end,
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
    LinearLayout,
    id="downtab",
    {
      TextView,
      layout_width=w/3,
      foreground=波纹(波纹色),
      onClick=function ()
        downpgs.showPage(0)
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
      layout_width=w/3,
      text="头像",
      foreground=波纹(波纹色),
      onClick=function ()
        downpgs.showPage(1)
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
      layout_width=w/3,
      text="必应壁纸",
      foreground=波纹(波纹色),
      onClick=function ()
        downpgs.showPage(2)
      end,
      textColor=文字色,
      gravity="center",
      alpha=0.5,
      -- paddingLeft="16dp",
      --paddingRight="16dp",
      padding="8dp",
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
      --paddingTop=lay_wh,
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
          nowp=p
          for t=0,2 do
            downtab.getChildAt(t).alpha=0.5
          end
          downtab.getChildAt(p).alpha=1
          if nowp==0 then
            if localwall.getCount()>0 then
              nodown.setVisibility(8)
             else
              nodown.setVisibility(0)
            end
           elseif nowp==1
            if localpic.getCount()>0 then
              nodown.setVisibility(8)
             else
              nodown.setVisibility(0)
            end
           else
            if bingwa.getCount()>0 then
              nodown.setVisibility(8)
             else
              nodown.setVisibility(0)
            end
          end
          onPause()
        end},
      layout_width="fill",
      pages={
        {
          GridView,
          adapter=localwall,
          layout_width="fill",
          numColumns=2,
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
          fastScrollEnabled=true,
        },
        {
          GridView,
          adapter=localpic,
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
          layout_width="fill",
          numColumns=2,
          fastScrollEnabled=true,
        },
        {
          GridView,
          adapter=bingwa,
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
          layout_width="fill",
          numColumns=1,
          fastScrollEnabled=true,
        },
      },
      layout_height="fill",
      layout_width="fill",
      id="downpgs",
    },
  },
}))

function onResume()
  localwall.clear()
  localpic.clear()
  bingwa.clear()
  local plist=getFileList(头像壁纸)
  for a=1,#plist do
    local pat=tostring(plist[a])
    --toast (pat)
    local bm=loadbitmap (pat)
    local bw=bm.width
    local bh=bm.height
    if bw>w/3 then
      local sc=(w/2)/bw
      bw=bw*sc
      bh=bh*sc
    end
    if not pat:find"%(pic%)" then
      pcall(function ()
        localwall.add{
          wp={
            ImageBitmap=Bitmap.createScaledBitmap(bm,bw,bh,true),
          },
          pa=pat,
        }
      end)
    end
    if pat:find"%(pic%)" then
      pcall(function ()
        localpic.add{
          wp={
            ImageBitmap=Bitmap.createScaledBitmap(bm,bw,bh,true),
          },
          pa=pat,
        }
      end)
    end
  end
  local bw=getFileList(bingwall)
  for b=1,#bw do
    local p=tostring(bw[b])
    local bm=loadbitmap (p)
    local bw=bm.width
    local bh=bm.height
    if bw>w then
      local sc=w/bw
      bw=bw*sc
      bh=bh*sc
    end
    pcall(function ()
      bingwa.add{
        wp={
          ImageBitmap=Bitmap.createScaledBitmap(bm,bw,bh,true),
        },
        pa=p,
      }
    end)
  end
  localwall.notifyDataSetChanged()
  localpic.notifyDataSetChanged()
  bingwa.notifyDataSetChanged()
  nodown.setVisibility(0)
  if nowp==0 then
    if localwall.getCount()>0 then
      nodown.setVisibility(8)
    end
   elseif nowp==1 then
    if localpic.getCount()>0 then
      nodown.setVisibility(8)
    end
   else
    if bingwa.getCount()>0 then
      nodown.setVisibility(8)
    end
  end
  updateMedia(头像壁纸)
end

downpgs.showPage(p or 0)