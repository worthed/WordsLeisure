require "import"
import "str"

gadp=LuaAdapter(this,{},{
  LinearLayout,
  layout_width="fill",
  orientation="vertical",
  {
    ImageView,
    layout_width="fill",
    adjustViewBounds=true,
    layout_gravity="center",
    padding="24dp",
    id="ic",
  },
  {
    TextView,
    id="label",
    textSize="14sp",
    textColor=次要文字色,
    layout_gravity="center",
    padding="8dp",
  },
  {
    TextView,
    id="pt",
    visibility=8,
  },
})

this.setContentView(loadlayout ({
  RelativeLayout,
  layout_width="fill",
  layout_height="fill",
  --visibility=4,
  backgroundColor=背景色,
  --orientation="vertical",
  --elevation="2%w",
  paddingTop=状态栏高度,
  {
    ScrollView,
    layout_width="fill",
    {
      LinearLayout,
      layout_width="fill",
      orientation="vertical",
      {
        RelativeLayout,
        layout_height="56dp",
      },
      {
        TextView,
        text="选择颜色后，点击项目即可创建",
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
        FrameLayout,
        padding="16dp",
        foreground=波纹(波纹色),
        onClick=function ()
          colorPicker(function ()
            local cl=mmp4.text
            txtcolr.text=tostring(cl)
            local cl=tonumber(cl)
            refreshList(cl)
          end)
        end,
        --layout_height=lay_wh,
        layout_width="fill",
        layout_gravity="center",
        {
          TextView,
          text="图标颜色",
          textColor=文字色,
          textSize="16sp",
          layout_height="fill",
          gravity="center|left",
        },
        {
          TextView,
          text="原色",
          textColor=次要文字色,
          id="txtcolr",
          textSize="16sp",
          --layout_alignParentRight=true,
          --gravity="center",
          layout_gravity="center|right",
        },
      },
      {
        GridView,
        adapter=gadp,
        numColumns=4,
        onItemClickListener={
          onItemClick=function (p,v)
            makeShortcut(v.getChildAt(2).text,v.getChildAt(1).text,getViewBitmap(v.getChildAt(0)))
          end},
        id="grid",
        layout_width="fill",
      },
      --快捷方式
    },
  },
  {
    RelativeLayout,
    layout_width="fill",
    layout_height="56dp",
    foreground=上下渐变({背景色,深透,淡透}),
  },
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
      text="快捷方式",
      textSize="20sp",
      textColor=文字色,
    },
  },
}))

function refreshList(color)
  gadp.clear()
  gadp.add{
    ic={
      src="drawable/star.png",
      ColorFilter=color or 图标色,
    },
    label="灵感",
    pt=LuaDir.."app/favorite.lua",
  }
  gadp.add{
    ic={
      src="drawable/discover.png",
      ColorFilter=color or 图标色,
    },
    label="发现",
    pt=LuaDir.."app/discover.lua",
  }
  gadp.add{
    ic={
      src="drawable/water.png",
      ColorFilter=color or 图标色,
    },
    label="点滴",
    pt=LuaDir.."app/daily.lua",
  }
  gadp.add{
    ic={
      src="drawable/comment.png",
      ColorFilter=color or 图标色,
    },
    label="更多句子",
    pt=LuaDir.."more_source.lua",
  }
  gadp.add{
    ic={
      src="drawable/config.png",
      ColorFilter=color or 图标色,
    },
    label="设置",
    pt=LuaDir.."app/manage.lua",
  }
  gadp.notifyDataSetChanged()
  local 条数=gadp.getCount()/4
  local totalHeight = 0
  for i = 0,条数 do
    listItem = gadp.getView(i, nil, grid)
    listItem.measure(0, 0)
    totalHeight=totalHeight+listItem.getMeasuredHeight()
  end
  local lp=grid.getLayoutParams()
  -- if tostring(条数/4):find("%.") then
  lp.height=totalHeight
  --[[ else
     lp.height=totalHeight/4
   end]]
  grid.setLayoutParams(lp)
  grid.Parent.Parent.requestFocus()
  grid.Parent.Parent.smoothScrollTo(0,0)
end

refreshList()