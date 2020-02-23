require "import"
import "str"

fntlay={
  FrameLayout,
  layout_width="fill",
  --layout_height=lay_wh,
  padding="16dp",
  --[[{
ProgressBar,
layout_width="fill",
layout_alignParentBottom=true,
style="?android:attr/progressBarStyleHorizontal",
max=100,
IndeterminateDrawable=ColorDrawable(0),
ProgressDrawable==ColorDrawable(0),
},]]
  {
    TextView,
    id="fn",
    maxLines=2,
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
    id="dnpath",
    visibility=8,
  },
  {
    ImageView,
    src="drawable/arrow.png",
    rotation=-90,
    colorFilter=图标色,
    layout_width="7%w",
    layout_height="7%w",
    layout_gravity="center|right",
  },
}

cn_adp=LuaAdapter(this,{},fntlay)

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
    paddingTop="8dp",
    paddingBottom="8dp",
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
      colorFilter=图标色,
      padding="9dp",
    },
    {
      TextView,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      --layout_gravity="center",
      text="系统字体",
      textSize="20sp",
      textColor=文字色,
    },
  },
  {
    RelativeLayout,
    {
      ListView,
      id="cng",
      layout_width="fill",
      --numColumns=3,
      onItemClickListener={
        onItemClick=function (g,v)
          this.newActivity("font/preview",{v.getChildAt(1).text,1})
        end},
      adapter=cn_adp,
      dividerHeight=0,
      fastScrollEnabled=true,
    },
    {
      LinearLayout,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      id="nofont",
      orientation="vertical",
      {
        ImageView,
        src="drawable/package.png",
        layout_width='fill',
        colorFilter=0xff000000,
        layout_height="195dp",
        --adjustViewBounds=true,
        padding="32dp",
        visibility=8,
      },
      {
        TextView,
        text="无字体",
        gravity="center",
        layout_width="fill",
        layout_height="fill",
        textColor=0xff000000,
        textSize="22sp",
      },
    },
  },
}))

system_fonts=getFileList("/system/fonts/")
for f=1,#system_fonts do
  local fontpath=tostring (system_fonts[f])
  cn_adp.add{
    fn=File(fontpath).getName(),
    dnpath=fontpath,
  }
end
cn_adp.notifyDataSetChanged()
if cn_adp.getCount()>0 then
  nofont.setVisibility(8)
end