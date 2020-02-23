require "import"
import "str"

pcall(function ()
  isEnabled=io.open(启用通知):read("*a")
end)
if isEnabled=="true" then
  isEnabled=true
 else
  isEnabled=false
end

msg_list=LuaAdapter(this,{},{
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  padding="16dp",
  --backgroundColor=0xffffffff,
  {
    TextView,
    textColor=文字色,
    --gravity="center",
    id="tt",
    textSize="18sp",
    paddingBottom="8dp",
  },
  {
    TextView,
    textColor=次要文字色,
    --gravity="center",
    id="nr",
    textSize="16sp",
    paddingBottom="8dp",
  },
  {
    FrameLayout,
    layout_width="fill",
    {
      TextView,
      textColor=次要文字色,
      textSize="14sp",
      layout_gravity="left|center",
      id="tp",
    },
    {
      TextView,
      textColor=次要文字色,
      textSize="14sp",
      layout_gravity="right|center",
      id="tm",
    },
  },
  {
    TextView,
    visibility=8,
    id="lj",
  },
  {
    TextView,
    visibility=8,
    id="lk",
  },
})

this.setContentView(loadlayout ({
  RelativeLayout,
  layout_width="fill",
  layout_height="fill",
  --visibility=4,
  backgroundColor=背景色,
  --  orientation="vertical",
  --elevation="2%w",
  paddingTop=状态栏高度,
  {
    ScrollView,
    layout_width="fill",
    {
      LinearLayout,
      orientation="vertical",
      layout_width="fill",
      {
        LinearLayout,
        layout_width="fill",
        layout_height="56dp" ,
      },
      {
        FrameLayout,
        layout_width="fill",
        onClick=function ()
          toggle.performClick()
        end,
        foreground=波纹(波纹色),
        {
          TextView,
          text="接收通知推送",
          textColor=文字色,
          textSize="16sp",
          padding="16dp",
          gravity="center",
          layout_height="fill",
        },
        {
          Switch,
          padding="16dp",
          layout_gravity="right|center",
          onCheckedChangeListener={
            onCheckedChanged=function (v,c)
              io.open(启用通知,"w+"):write(tostring(c)):close()
              if not c then
                io.open(最新通知,"w+"):write("{}"):close()
              end
            end},
          id="toggle",
          checked=isEnabled,
        },
      },
      {
        LinearLayout,
        id="topDivider",
        layout_width="fill",
        layout_height=15,
        foreground=ColorDrawable(0x10000000),
      },
      {
        RelativeLayout,
        layout_width="fill",
        layout_height="fill",
        {
          ListView,
          layout_width="fill",
          layout_height="fill",
          onItemClickListener={
            onItemClick=function (p,v)
              local lk=v.getChildAt(4).text
              if lk:sub(1,4)=="http" then
                InAppBrowser(lk)
               else
                openInBrowser(lk)
              end
            end},
          onItemLongClickListener={
            onItemLongClick=function (g,vi)
              local edt=AlertDialog.Builder(this)
              -- .setCancelable(false)
              .setTitle("选择操作")
              .setItems({"查看详情","分享内容","复制内容","删除"}, function (d,n)
                local cont=vi.getChildAt(0).text.."\n\n"..vi.getChildAt(1).text
                if n==0 then
                  local lk=vi.getChildAt(4).text
                  if lk:sub(1,4)=="http" then
                    InAppBrowser(lk,vi.getChildAt(0).text)
                   else
                    openInBrowser(lk)
                  end
                 elseif n==1 then
                  shareText(cont.."\n    ——闲言APP 最好的阅读平台")
                 elseif n==2 then
                  copyText(cont.."\n    ——闲言APP 最好的阅读平台")
                 else
                  showDialog("删除通知","通知内容："..cont.."\n\n是否删除该通知？此操作无法撤销。","删除","取消", function ()
                    File(vi.getChildAt(3).text).delete()
                    onResume()
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
            end},
          adapter=msg_list,
          id="ml",
          dividerHeight=38,
          divider=ColorDrawable(0x00000000),
        },
        {
          LinearLayout,
          layout_width="fill",
          orientation="vertical",
          layout_height="fill",
          gravity="center",
          paddingTop=lay_wh,
          id="nomsg",
          {
            ImageView,
            src="drawable/package.png",
            layout_width='fill',
            colorFilter=0xff000000,
            layout_height="195dp",
            --adjustViewBounds=true,
            padding="32dp",
            colorFilter=图标色,
            --visibility=8,
          },
          {
            TextView,
            text="无通知",
            gravity="center",
            id="wait",
            --  layout_width="fill",
            --  layout_height="fill",
            textColor=次要文字色,
            textSize="22sp",
          },
        },
      },
      --scroll
    },
  },
  {
    LinearLayout,
    layout_width="fill",
    layout_height="56dp" ,
    foreground=上下渐变({背景色,深透,淡透}),
  },
  {
    RelativeLayout,
    layout_width="fill",
    layout_height="56dp",
    gravity="center",
    padding="16dp",
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
      ImageView,
      src="drawable/delete.png",
      layout_height="fill",
      id="notify_del",
      colorFilter=图标色,
      layout_width="44dp",
      foreground=波纹(波纹色),
      onClick=function ()
        showDialog("清空通知","此操作无法撤销。","清空","取消",function()
          local pat=File(通知历史)
          if pcall(function ()
              LuaUtil.rmDir(pat)
              pat.mkdir()
            end) then
            toast("已清空通知")
            onResume()
           else
            toast("无法清空通知")
          end
        end,nil,0xffff4500)
      end,
      layout_alignParentRight=true,
      padding="9dp",
    },
    {
      TextView,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      --layout_gravity="center",
      text="通知推送",
      textSize="20sp",
      textColor=文字色,
    },
  },
}))

function onResume()
  msg_list.clear()
  local sl=getFileList(通知历史)
  for o=1,#sl do
    pcall(function ()
      local pat=tostring (sl[o])
      -- print (pat)
      local fi=io.open(pat)
      -- print (fi)
      local fi=fi:read("*a")
      local n=StrToTable(fi)
      --  for o=1,10 do
      msg_list.insert(0,{
        tt=n.title,
        nr=n.content,
        tp=n.type,
        tm=n.time,
        lj=pat,
        lk=n.url,
      })
      -- end
    end)
  end
  local 条数=msg_list.getCount()
  if 条数>0 then
    nomsg.setVisibility(8)
    notify_del.setVisibility(0)
   else
    nomsg.setVisibility(0)
    notify_del.setVisibility(8)
  end
  msg_list.notifyDataSetChanged()
  local totalHeight = 0
  for i = 0,条数 do
    listItem = msg_list.getView(i, nil, comment_list)
    listItem.measure(0, 0)
    totalHeight=totalHeight+listItem.getMeasuredHeight()--+ml.getDividerHeight()
  end
  local lp=ml.getLayoutParams()
  lp.height=totalHeight--+ml.getDividerHeight()*条数
  ml.setLayoutParams(lp)
  ml.Parent.Parent.Parent.smoothScrollTo(0,0)
end