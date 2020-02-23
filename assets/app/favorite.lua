require "import"
import "str"

File(个人语录).mkdirs()
staraction={
  onItemLongClick=function (g,vi)
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems({"制作壁纸","分享内容","复制内容","删除"}, function (d,n)
      local cont=vi.getChildAt(0).text
      if n==0 then
        toast ("正在前往编辑页面")
        this.newActivity("soup",{cont})
       elseif n==1 then
        shareText(cont.."\n    ——闲言APP 最好的阅读平台")
       elseif n==2 then
        copyText(cont.."\n    ——闲言APP 最好的阅读平台")
       else
        showDialog("删除收藏","收藏内容："..vi.getChildAt(0).text.."\n\n是否删除该收藏？此操作无法撤销。","删除","取消", function ()
          File(vi.getChildAt(2).text).delete()
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
  end}

fav_adp=LuaAdapter(this,{},{
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  --backgroundColor=0xffffffff,
  {
    TextView,
    textColor=文字色,
    --gravity="center",
    id="nr",
    textSize="18sp",
    padding="16dp",
    paddingBottom="8dp",
  },
  {
    TextView,
    textColor=次要文字色,
    textSize="14sp",
    padding="16dp",
    paddingTop=0,
    --paddingBottom="8dp",
    layout_gravity="right|center",
    id="lx",
  },
  {
    TextView,
    visibility=8,
    id="lj",
  },
})
yvlu_adp=LuaAdapter(this,{},{
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  --backgroundColor=0xffffffff,
  {
    TextView,
    textColor=文字色,
    --gravity="center",
    id="nr",
    textSize="18sp",
    padding="16dp",
    --paddingBottom="8dp",
    maxLines=4,
    ellipsize="end",
  },
  {
    TextView,
    visibility=8,
    id="lx",
  },
})

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
      layout_width="44dp",
      foreground=波纹(波纹色),
      onClick=function ()
        this.finish()
      end,
      colorFilter=图标色,
      padding="9dp",
    },
    {
      ImageView,
      src="drawable/plus.png",
      layout_height="fill",
      layout_width="44dp",
      foreground=波纹(波纹色),
      padding="9dp",
      colorFilter=图标色,
      layout_alignParentRight=true,
      onClick=function ()
        saying(个人语录..os.time(),"新建语录")
      end,
      id="yvlu_add",
    },
    {
      TextView,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      --layout_gravity="center",
      text="灵感",
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
      text="收藏",
      textColor=文字色,
      padding="8dp",
      gravity="center",
    },
    {
      TextView,
      layout_width="50%w",
      text="语录",
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
          nowPage=p
          if p==0 then
            tab.getChildAt(0).alpha=1
            tab.getChildAt(1).alpha=0.5
            yvlu_add.setVisibility(8)
            if fav_adp.getCount()>0 then
              nolog.setVisibility(8)
             else
              nolog.setVisibility(0)
            end
           else
            tab.getChildAt(1).alpha=1
            tab.getChildAt(0).alpha=0.5
            yvlu_add.setVisibility(0)
            if yvlu_adp.getCount()>0 then
              nolog.setVisibility(8)
             else
              nolog.setVisibility(0)
            end
          end
          onResume()
        end},
      id="pgs",
      pages={
        {
          ListView,
          id="cng",
          --numColumns=3,
          onItemClickListener={
            onItemClick=function (g,v)
              -- toast ("正在前往编辑页面")
              --this.newActivity("soup",{v.getChildAt(0).text})
              staraction.onItemLongClick(g,v)
            end},
          adapter=fav_adp,
          onItemLongClickListener=staraction,
          dividerHeight=0,
        },
        {
          ListView,
          id="yl_list",
          onItemClickListener={
            onItemClick=function (g,v)
              saying(v.getChildAt(1).text,"编辑语录内容")
            end},
          --numColumns=3,
          onItemLongClickListener={
            onItemLongClick=function (g,vi)
              local edt=AlertDialog.Builder(this)
              -- .setCancelable(false)
              .setTitle("选择操作")
              .setItems({"编辑","制作壁纸","分享内容","复制内容","删除"}, function (d,n)
                local cont=vi.getChildAt(0).text
                if n==0 then
                  saying(vi.getChildAt(1).text,"编辑语录内容")
                 elseif n==1 then
                  toast ("正在前往编辑页面")
                  this.newActivity("soup",{cont})
                 elseif n==2 then
                  shareText(cont)
                 elseif n==3 then
                  copyText(cont)
                 else
                  showDialog("删除语录","语录内容："..vi.getChildAt(0).text.."\n\n是否删除该语录？此操作无法撤销。","删除","取消", function ()
                    File(vi.getChildAt(1).text).delete()
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
          adapter=yvlu_adp,
          dividerHeight=0,
        },
        --pages
      },
    },
    {
      LinearLayout,
      id="nolog",
      orientation="vertical",
      visibility=4,
      layout_width='fill',
      layout_height="fill",
      gravity="center",
      {
        ImageView,
        src="drawable/history_empty.png",
        layout_width='fill',
        colorFilter=图标色,
        layout_height="195dp",
        --adjustViewBounds=true,
        padding="32dp",
      },
      {
        TextView,
        layout_gravity="center",
        text="无内容",
        textColor=次要文字色,
        textSize="22sp",
      },
    },
  },
}))

function onResume()
  fav_adp.clear()
  yvlu_adp.clear()
  local gr=getFileList(个人语录)
  for r=1,#gr do
    local pat=tostring(gr[r])
    --if not pat:find("%.") then
    local yvlu=io.open(pat):read("*a")
    pcall(function ()
      yvlu_adp.insert(0,{
        nr=yvlu,
        lx=pat,
      })
    end)
    --end
  end
  local sc=getFileList(句子收藏)
  for s=1,#sc do
    local pat=tostring(sc[s])
    --if not pat:find("%.") then
    local fa=io.open(pat):read("*a")
    local con=StrToTable(fa)
    pcall(function ()
      if con.type=="微风暴" then
       else
        fav_adp.insert(0,{
          nr=con.soup,
          lx=con.type,
          lj=pat,
        })
      end
    end)
    --end
  end
  fav_adp.notifyDataSetChanged()
  yvlu_adp.notifyDataSetChanged()
  if nowPage==0 then
    if fav_adp.getCount()>0 then
      nolog.setVisibility(8)
     else
      nolog.setVisibility(0)
    end
   else
    if yvlu_adp.getCount()>0 then
      nolog.setVisibility(8)
     else
      nolog.setVisibility(0)
    end
  end
end

function saying(pat,title)
  --File(pat).createNewFile()
  local f=io.open(tostring(pat))
  if f then
    con=f:read("*a")
  end
  local edt=AlertDialog.Builder(this)
  .setTitle(title or "语录")
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
      text=con or "",
      id="usaying",
      hint="输入句子内容",
      textColor=文字色,
      hintTextColor=次要文字色,
    },
  }))
  .setPositiveButton("保存", function ()
    local cont=usaying.text
    if utf8.len(cont)>0 then
      io.open(pat,"w+"):write(cont):close()
      toast ("已保存")
     else
      pcall(function () File(pat).delete() end)
      toast ("未写入任何内容")
    end
    onResume()
  end)
  .setNegativeButton("取消",nil)
  .setNeutralButton("保存并制作壁纸", function ()
    local cont=usaying.text
    if utf8.len(cont)>0 then
      io.open(pat,"w+"):write(cont):close()
      toast ("已保存，正在前往编辑页面")
      this.newActivity("soup",{cont})
     else
      pcall(function () File(pat).delete() end)
      toast ("未写入任何内容")
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
  con=nil
end