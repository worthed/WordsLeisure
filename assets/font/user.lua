require "import"
import "str"

olc={
  ItemLongClick=function (p,v)
    local pat=cp.text..v.text
    local last=pat:sub(#pat-2,#pat)
    if File(pat).isDirectory () then
      itm={"复制文件夹路径"}
     elseif last=="ttf" or last=="otf" then
      itm={"预览字体","导入字体文件","复制文件路径"}
     else
      itm={"用其他应用打开","复制文件路径"}
    end
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems(itm, function (d,n)
      if itm[n+1]=="用其他应用打开" then
        openFile(pat)
       elseif itm[n+1]=="预览字体" then
        this.newActivity("font/preview",{pa,1})
       elseif itm[n+1]=="复制文件路径" then
        copyText(pat)
       elseif itm[n+1]=="导入字体文件" then
        local pf=File(pat)
        if pcall(function ()
            LuaUtil.copyDir(pat,userfonts_path..pf.Name)
          end) then
          onResume()
          --drawer.closeDrawer(5)
          toast ("导入成功")
         else
          toast ("导入失败")
        end
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
    --  itm=nil
    return true
  end}

fntlay={
  FrameLayout,
  layout_width="fill",
  --layout_height=lay_wh,
  padding="16dp",
  --layout_gravity="center",
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
    id="pat",
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
adp=ArrayAdapter(this,android.R.layout.simple_list_item_1)

this.setContentView(loadlayout ({
  DrawerLayout,
  DrawerListener=DrawerLayout.DrawerListener{
    onDrawerSlide=function(v,i)
      main.setTranslationX(-i*w*0.62*0.75)
      if i==1 then
        drawer.setDrawerLockMode(DrawerLayout.LOCK_MODE_LOCKED_OPEN,5)
       elseif i==0 then
        isDrawerOpen=false
        disableDrawer(true,5)
       else
        isDrawerOpen=true
        disableDrawer(false,5)
      end
    end},
  id="drawer",
  {
    LinearLayout,
    layout_width="fill",
    layout_height="fill",
    --visibility=4,
    backgroundColor=背景色,
    orientation="vertical",
    --elevation="2%w",
    paddingTop=状态栏高度,
    id="main",
    {
      RelativeLayout,
      layout_width="fill",
      layout_height="56dp" ,
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
        onClick=function ()
          drawer.openDrawer(5)
        end,
        padding="9dp",
        colorFilter=图标色,
        layout_alignParentRight=true,
      },
      {
        TextView,
        layout_width="fill",
        layout_height="fill",
        gravity="center",
        --layout_gravity="center",
        text="本地字体",
        textSize="20sp",
        textColor=文字色,
      },
    },
    {
      RelativeLayout,
      {
        ListView,
        id="cng",
        --numColumns=3,
        onItemClickListener={
          onItemClick=function (g,v)
            this.newActivity("font/preview",{v.getChildAt(1).text,1})
          end},
        adapter=cn_adp,
        onItemLongClickListener={
          onItemLongClick=function (g,vi)
            local edt=AlertDialog.Builder(this)
            -- .setCancelable(false)
            .setTitle("选择操作")
            .setItems({"预览","删除"}, function (d,n)
              if n==0 then
                this.newActivity("font/preview",{vi.getChildAt(1).text,1})
               else
                showDialog("删除字体","是否删除 "..File(vi.getChildAt(1).text).Name.." 字体？此操作无法撤销。","删除","取消", function ()
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
        dividerHeight=0,
        fastScrollEnabled=true,
      },
      {
        LinearLayout,
        id="nottf",
        orientation="vertical",
        --visibility=4,
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
          padding="33dp",
        },
        {
          TextView,
          layout_gravity="center",
          text="无字体",
          textColor=次要文字色,
          textSize="22sp",
        },
      },
    },
  },
  {
    LinearLayout,
    layout_width="100%w",
    layout_height="fill",
    layout_gravity="right",
    backgroundColor=背景色,
    orientation="vertical",
    id="imp",
    paddingTop=状态栏高度,
    onClick=function() end,
    {
      RelativeLayout,
      layout_width="fill",
      layout_height="56dp" ,
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
        layout_width="44dp",
        foreground=波纹(波纹色),
        onClick=function ()
          drawer.closeDrawer(5)
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
        text="导入字体",
        textSize="20sp",
        textColor=文字色,
      },
    },
    {
      RelativeLayout,
      layout_width="fill",
      layout_height="fill",
      {
        LinearLayout,
        layout_width="fill",
        orientation="vertical",
        {
          TextView,
          text="支持导入 OpenType 和 TrueType 字体文件",
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
          TextView,
          id="cp",
          singleLine=true,
          textSize="14sp",
          padding="8dp",
          paddingLeft="16dp",
          paddingRight="16dp",
          --paddingTop=0,
          textColor=次要文字色,
          gravity="center",
          ellipsize="end",
        },
        {
          ListView,
          id="impttf",
          --numColumns=3,
          layout_width="fill",
          onItemClickListener={
            onItemClick=function(l,v,p,s)--列表点击事件
              local 项目=tostring(v.text)
              -- print(tostring(cp.text),sdcard)
              if tostring(cp.text)==sdcard then
                路径=ls[p+1]
               else
                路径=ls[p]
              end
              --openFile(路径)
              if 项目=="../" then
                SetItem(File(cp.Text).getParentFile())
               elseif 路径.isDirectory() then
                SetItem(路径)
               elseif 路径.isFile() then
                local 路径=tostring(路径)
                if 路径:find("%.otf") or 路径:find("%.ttf") then
                  if cp.text=="/system/fonts/" then
                    toast ("系统字体，无需重复导入")
                   else
                    local pa=File(路径)
                    if pcall(function ()
                        LuaUtil.copyDir(路径,userfonts_path..pa.Name)
                      end) then
                      onResume()
                      --drawer.closeDrawer(5)
                      toast ("导入成功")
                     else
                      toast ("导入失败")
                    end
                  end
                 else
                  toast ("选择的不是字体文件")
                  olc.ItemLongClick(p,v)
                end
              end
            end},
          adapter=adp,
          dividerHeight=0,
          onItemLongClickListener={
            onItemLongClick=function (p,v)
              olc.ItemLongClick(p,v)
              return true
            end},
          fastScrollEnabled=true,
        },
      },
      {
        LinearLayout,
        id="nofile",
        orientation="vertical",
        --visibility=4,
        layout_width='fill',
        layout_height="fill",
        --paddingTop=lay_wh*2,
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
          text="无文件",
          textColor=次要文字色,
          textSize="22sp",
        },
      },
    },
  },
}))

--drawer.setDrawerLockMode(DrawerLayout.LOCK_MODE_LOCKED_CLOSED,3)

function onKeyDown(k)
  if k==4 and (isDrawerOpen==true or drawer.isDrawerOpen(5)) then
    if cp.text~=sdcard then
      SetItem(File(cp.text).getParentFile())
     else
      drawer.closeDrawer(5)
    end
    --this.finish()
    return true
  end
end

function SetItem(path)
  local path=tostring(path)
  adp.clear()
  local lj=tostring(path)
  local ends=lj:sub(#lj,#lj)
  --toast (ends)
  if ends=="/" then
    cp.Text=tostring(path)
   else
    cp.Text=tostring(path).."/"
  end
  -- print (path,sdcard)
  if cp.Text~=sdcard then
    adp.add("../")
  end
  ls=File(path).listFiles()
  if ls~=nil then
    ls=luajava.astable(File(path).listFiles())
    table.sort(ls,function(a,b)
      return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
    end)
   else
    ls={}
  end
  for index,c in ipairs(ls) do
    if c.isDirectory() then
      adp.add(c.Name.."/")
     else
      adp.add(c.Name)
    end
  end
  if adp.getCount()==1 then
    nofile.setVisibility(0)
   else
    nofile.setVisibility(8)
  end
end

SetItem(sdcard)

function onResume()
  cn_adp.clear()
  local fs=getFileList(userfonts_path)
  for g=1,#fs do
    pcall(function()
      cn_adp.insert(0,{
        fn=File(tostring(fs[g])).Name,
        pat=fs[g],
      })
    end)
  end
  local as=getFileList(appfonts_path)
  for b=1,#as do
    pcall(function()
      cn_adp.insert(0,{
        fn=File(tostring(as[b])).Name,
        pat=as[b],
      })
    end)
  end
  cn_adp.notifyDataSetChanged()
  if cn_adp.getCount()>0 then
    nottf.setVisibility(8)
   else
    nottf.setVisibility(0)
  end
end

disableDrawer(true,5)

drawer.onKey=function(v,k,e)
  if k==4 and e.action==0 and (drawer.isDrawerOpen(5) or isDrawerOpen) then
    --toast ("drawer onkey")
    if cp.text~=sdcard then
      SetItem(File(cp.text).getParentFile())
     else
      drawer.closeDrawer(5)
    end
    return true
  end
end