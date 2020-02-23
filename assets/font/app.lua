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
    TextView,
    id="size",
    visibility=8,
  },
  {
    ImageView,
    src="drawable/arrow.png",
    rotation=-90,
    colorFilter=图标色,
    layout_width="24dp",
    layout_height="24dp",
    layout_gravity="center|right",
  },
}

cn_adp=LuaAdapter(this,{},fntlay)
en_adp=LuaAdapter(this,{},fntlay)

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
    paddingTop="8dp",
    paddingBottom="8dp",
    elevation="2dp",
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
      ImageView,
      src="drawable/down_folder.png",
      layout_height="fill",
      layout_width="44dp",
      foreground=波纹(波纹色),
      onClick=function ()
        this.newActivity("font/user")
      end,
      layout_alignParentRight=true,
      padding="9dp",
      colorFilter=图标色,
    },
    {
      TextView,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      --layout_gravity="center",
      text="更多字体",
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
      text="中英",
      textColor=文字色,
      padding="8dp",
      gravity="center",
    },
    {
      TextView,
      layout_width="50%w",
      text="英文",
      foreground=波纹(波纹色),
      onClick=function ()
        pgs.showPage(1)
      end,
      textColor=文字色,
      gravity="center",
      alpha=0.5,
      padding="8dp",
    },
  },
  {
    RelativeLayout,
    {
      PageView,
      onPageChangeListener={
        onPageSelected=function (p)
          curp=p
          if p==0 then
            tab.getChildAt(0).alpha=1
            tab.getChildAt(1).alpha=0.5
            if cn_adp.getCount()>0 then
              wait.Parent.setVisibility(8)
             else
              wait.text="无字体"
              local wpa=wait.Parent
              wpa.getChildAt(0).setVisibility(8)
              wpa.getChildAt(1).setVisibility(0)
            end
           else
            tab.getChildAt(1).alpha=1
            tab.getChildAt(0).alpha=0.5
            if en_adp.getCount()>0 then
              wait.Parent.setVisibility(8)
             else
              wait.text="无字体"
              local wpa=wait.Parent
              wpa.getChildAt(0).setVisibility(8)
              wpa.getChildAt(1).setVisibility(0)
            end
          end
        end},
      id="pgs",
      pages={
        {
          ListView,
          id="cng",
          --numColumns=3,
          onItemClickListener={
            onItemClick=function (g,v)
              this.newActivity("font/preview",{v.getChildAt(1).text,0,v.getChildAt(0).text,v.getChildAt(2).text})
            end},
          adapter=cn_adp,
          dividerHeight=0,
        },
        {
          ListView,
          id="eng",
          onItemClickListener={
            onItemClick=function (g,v)
              this.newActivity("font/preview",{v.getChildAt(1).text,0,v.getChildAt(0).text,v.getChildAt(2).text})
            end},
          --numColumns=3,
          adapter=en_adp,
          dividerHeight=0,
        },
        --pages
      },
    },
    {
      LinearLayout,
      layout_width="fill",
      orientation="vertical",
      layout_height="fill",
      gravity="center",
      {
        ProgressBar,
        padding="32dp",
        --visibility=4,
        layout_width="fill",
        layout_height="195dp",
      },
      {
        ImageView,
        src="drawable/package.png",
        layout_width='fill',
        colorFilter=图标色,
        layout_height="195dp",
        --adjustViewBounds=true,
        padding="32dp",
        visibility=8,
      },
      {
        TextView,
        text="加载中",
        gravity="center",
        id="wait",
        layout_width="fill",
        --  layout_height="fill",
        textColor=次要文字色,
        textSize="22sp",
      },
    },
  },
}))

Http.get("https://gitee.com/ayaka_ago/WordsLeisure/raw/master/Fonts/fonts_list.txt", function (co,n)
  if co==200 then
    local n=StrToTable(n)
    local en=n.en
    local cn=n.cn
    for e=1,#en do
      en_adp.add{
        fn=en[e].name,
        dnpath=en[e].path,
        size=en[e].size,
      }
    end
    for c=1,#cn do
      cn_adp.add{
        fn=cn[c].name,
        dnpath=cn[c].path,
        size=cn[c].size,
      }
    end
    en_adp.notifyDataSetChanged()
    cn_adp.notifyDataSetChanged()
    wait.Parent.setVisibility(8)
    wait.text="无字体"
    local wpa=wait.Parent
    wpa.getChildAt(0).setVisibility(8)
    wpa.getChildAt(1).setVisibility(0)
    if curp==0 then
      if cn_adp.getCount()<1 then
        wait.Parent.setVisibility(0)
      end
     else
      if en_adp.getCount()<1 then
        wait.Parent.setVisibility(0)
      end
    end
   else
    wait.text="无字体"
    local wpa=wait.Parent
    wpa.getChildAt(0).setVisibility(8)
    wpa.getChildAt(1).setVisibility(0)
  end
end)

toast ("数据加载中")