require "import"
import "str"

menu={
  onItemLongClick=function (g,v)
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems({"查看","分享","删除"}, function (d,n)
      local dpa=v.getChildAt(1).text
      if n==0 then
        openPicture("file://"..dpa)
       elseif n==1 then
        shareBitmap(loadbitmap (dpa))
       else
        showDialog("删除","是否删除此图片？此操作无法撤销。","删除","取消", function ()
          deletePic(dpa)
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
  end}

emo=LuaAdapter(this,{},{
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
    textColor=0xffffffff,
  },
})

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
      src="drawable/back.png",
      layout_height="fill",
      colorFilter=图标色,
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
      text="下载的图片",
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
      onItemLongClickListener=menu,
      adapter=emo,
      layout_width="fill",
      numColumns=3,
      onItemClickListener={
        onItemClick=function (p,v)
          openPicture("file://"..v.getChildAt(1).text)
        end},
      fastScrollEnabled=true,
    },
  },
}))

function onResume()
  emo.clear()
  local plist=getFileList(browserdon)
  for o=1,#plist do
    local pt=tostring(plist[o])
    if pt:find"%.gif" then
      emo.insert(0,{
        wp=pt,
        pa=pt,
        gi=" GIF ",
        gii=" GIF ",
      })
     else
      emo.insert(0,{
        wp=pt,
        pa=pt,
        gi="",
        gii="",
      })
    end
  end
  emo.notifyDataSetChanged()
  if emo.getCount()>0 then
    nopic.setVisibility(8)
   else
    nopic.setVisibility(0)
  end
end