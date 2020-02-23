require "import"
import "str"

path,num,fontname,size=...

pcall(function () size=math.floor(tonumber(size)--[[/1024]]) end)
pcall(function () downpa=appfonts_path..fontname end)
mb=string.format("%.2f",((size or 0)/1024)/1024)

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
    LinearLayout,
    orientation="vertical",
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
        ImageView,
        src="drawable/delete.png",
        layout_height="fill",
        layout_width="44dp" ,
        foreground=波纹(波纹色),
        onClick=function ()
          local ft=File(downpa or path)
          showDialog("删除字体","是否删除 "..ft.Name.." 字体？此操作无法撤销。","删除","取消",function()
            if pcall(function ()
                ft.delete()
              end) then
              toast ("字体文件已删除")
              if downpa then
                del.setVisibility(8)
                progr.Parent.setVisibility(0)
                cont.Parent.setPadding(0,0,0,progr.Parent.height)
                nofile.setVisibility(0)
                cont.typeface=Typeface.SANS_SERIF
               else
                this.finish()
              end
             else
              toast ("无法删除字体文件")
            end
          end,nil,0xffff4500,nil,true)
        end,
        padding="9dp",
        colorFilter=图标色,
        layout_alignParentRight=true,
        id="del",
      },
      {
        TextView,
        layout_width="fill",
        layout_height="fill",
        gravity="center",
        --layout_gravity="center",
        text="字体预览",
        textSize="20sp",
        textColor=文字色,
      },
    },
    {
      TextView,
      text="要进行预览，请先下载字体文件",
      textColor=淡色,
      textSize="12sp",
      layout_width="fill",
      gravity="center",
      id="nofile",
      padding="8dp",
      paddingTop=0,
    },
  },
  {
    RelativeLayout,
    {
      LinearLayout,
      layout_width="fill",
      gravity="center",
      layout_height="fill",
      {
        TextView,
        text=[[闲言，
我们是文字狂热迷。

WordsLeisure,
We are fascinated by words.]],
        --layout_gravity="center",
        id="cont",
        --layout_width="fill",
        --layout_height="fill",
        --gravity="left|center",
        textColor=文字色,
        padding="48dp",
        textSize="22sp",
      },
    },
    {
      TextView,
      text="如预览不正常，请检查文件是否完整",
      textColor=淡色,
      textSize="12sp",
      layout_width="fill",
      gravity="center",
      visibility=8,
      id="brokentip",
      layout_alignParentBottom=true,
      padding="8dp",
    },
    {
      LinearLayout,
      orientation="vertical",
      layout_alignParentBottom=true,
      layout_width="fill",
      {
        ProgressBar,
        --layout_height=lay_wh,
        style="?android:attr/progressBarStyleHorizontal",
        layout_width="fill",
        padding="8dp",
        paddingLeft="16dp",
        paddingRight="16dp",
        id="progr",
        visibility=8,
        max=size or 0,
      },
      {
        TextView,
        id="downconf",
        --layout_height=lay_wh,
        padding="8dp",
        layout_width="fill",
        gravity="center",
        textColor=文字色,
        textSize="16sp",
        onClick=function(v)
          Http.download(path,downpa, function (c,f)
            if c==200 then
              if pcall(function () cont.typeface=Typeface.createFromFile(File(downpa)) end) then
                progr.Parent.setVisibility(8)
                cont.Parent.setPadding(0,0,0,0)
                nofile.setVisibility(8)
                if (downpa or path):sub(1,7)~="/system" then
                  del.setVisibility(0)
                end
                brokentip.setVisibility(0)
                toast ("字体文件下载完成")
               else
                del.setVisibility(8)
                brokentip.setVisibility(8)
                toast ("字体文件下载失败")
                File(downpa).delete()
              end
             else
              del.setVisibility(8)
              brokentip.setVisibility(8)
              toast ("字体文件下载失败")
              File(downpa).delete()
            end
            progr.setVisibility(8)
            onDestroy()
          end)
          progr.setVisibility(0)
          --v.setVisibility(8)
          v.onClick=function () end
          v.foreground=ColorDrawable(0)
          if not ti then
            ti=Ticker()
            ti.setPeriod(250)
            ti.onTick=function ()
              local fsize=File(downpa).length()
              progr.progress=fsize
              -- toast (fsize,progr.max)
              downconf.text="下载中 ("..string.format("%.2f",(fsize/1024)/1024).."MB/"..mb.."MB)"
            end
            ti.start()
          end
        end,
        text="下载字体并预览 ("..mb.."MB)",
        foreground=波纹(波纹色),
      },
    },
  },

}))

if path then
  if num==1 then
    --已有文件
    if pcall(function () cont.typeface=Typeface.createFromFile(File(path)) end) then
      progr.Parent.setVisibility(8)
      cont.Parent.setPadding(0,0,0,0)
      nofile.setVisibility(8)
      if (downpa or path):sub(1,7)~="/system" then
        del.setVisibility(0)
      end
      brokentip.setVisibility(0)
     else
      del.setVisibility(8)
      brokentip.setVisibility(8)
      toast ("字体预览加载失败")
      progr.Parent.setVisibility(8)
      cont.Parent.setPadding(0,0,0,0)
      nofile.text="字体预览加载失败"
    end
   else
    --需下载
    del.setVisibility(8)
    brokentip.setVisibility(8)
    progr.Parent.setVisibility(0)
    cont.Parent.setPadding(0,0,0,progr.Parent.height)
    if File(downpa).exists() then
      if pcall(function () cont.typeface=Typeface.createFromFile(File(downpa)) end) then
        progr.Parent.setVisibility(8)
        cont.Parent.setPadding(0,0,0,0)
        nofile.setVisibility(8)
        if (downpa or path):sub(1,7)~="/system" then
          del.setVisibility(0)
        end
       else
        del.setVisibility(8)
      end
    end
  end
end

if (downpa or path):sub(1,7)=="/system" then
  del.setVisibility(8)
end

Http.get("https://gitee.com/ayaka_ago/WordsLeisure/raw/master/Advertisement/adwords.txt", function (c,n)
  if c==200 then
    local n=StrToTable(n)
    cont.setText("闲言，\n"..n.cn.."。\n\nWordsLeisure,\n"..n.en..".")
  end
end)

function onDestroy()
  if ti then
    ti.stop()
  end
  -- toast ("destroyed")
end