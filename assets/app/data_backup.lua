require "import"
import "str"

File(备份文件夹).mkdirs()

adplay={
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  --backgroundColor=0xffffffff,
  {
    TextView,
    textColor=文字色,
    --gravity="center",
    id="nr",
    textSize="16sp",
    padding="16dp",
  },
  {
    TextView,
    visibility=8,
    id="lj",
  },
}
backup=LuaAdapter(this,{},adplay)
restore=LuaAdapter(this,{},adplay)

if getFileCount(句子收藏)>0 then backup.insert(0,{nr="句子收藏",lj=句子收藏}) end
if getFileCount(个人语录)>0 then backup.insert(0,{nr="个人语录",lj=个人语录}) end
if getFileCount(soup_logs)>0 then backup.insert(0,{nr="历史记录",lj=soup_logs}) end

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
      TextView,
      layout_width="fill",
      layout_height="fill",
      gravity="center",
      --layout_gravity="center",
      text="备份与恢复",
      textSize="20sp",
      textColor=文字色,
    },
  },
  {
    TextView,
    text="以下数据会在卸载 / 清除数据后丢失，建议备份",
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
    LinearLayout,
    id="tab",
    {
      TextView,
      layout_width="50%w",
      foreground=波纹(波纹色),
      onClick=function ()
        pgs.showPage(0)
      end,
      text="备份",
      textColor=文字色,
      padding="8dp",
      gravity="center",
    },
    {
      TextView,
      layout_width="50%w",
      text="恢复",
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
            nolog.setVisibility(8)
            tab.getChildAt(0).alpha=1
            tab.getChildAt(1).alpha=0.5
           else
            tab.getChildAt(1).alpha=1
            tab.getChildAt(0).alpha=0.5
            if restore.getCount()>0 then
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
          onItemClickListener={
            onItemClick=function (g,v)
              local zipTo=备份文件夹
              local zipFrom=v.getChildAt(1).text
              local backed=zipTo..File(zipFrom).Name..".zip"
              if File(backed). exists () then
                notice="\n\n检测到已有备份，再次创建将会覆盖上个备份。"
                ntc="覆盖备份"
                --toast(getFileCount(backed.."/"))
              end
              showDialog("创建备份","是否创建 "..v.getChildAt(0).text.." 的备份？此项目中共有 "..getFileCount(zipFrom).." 条记录。"..(notice or""),ntc or "创建备份","取消", function ()
                if pcall(function ()
                    LuaUtil.zip(zipFrom,zipTo)
                  end) then
                  toast("已创建备份")
                  onResume()
                 else
                  toast("创建备份失败")
                end
              end)
              notice,ntc=nil,nil
            end},
          adapter=backup,
          dividerHeight=0,
        },
        {
          ListView,
          id="yl_list",
          onItemClickListener={
            onItemClick=function (g,v)
              local zipFrom=v.getChildAt(1).text
              local unzipTo=应用数据
              showDialog("恢复备份","是否恢复 "..v.getChildAt(0).text.." 的备份？此操作将会覆盖现有的数据。","恢复备份","取消", function ()
                if pcall(function ()
                    LuaUtil.unZip(zipFrom,unzipTo)
                  end) then
                  toast("已恢复备份")
                 else
                  toast("恢复备份失败")
                end
              end,nil,nil,nil,nil,"删除备份", function ()

                showDialog("删除备份","是否删除备份？此操作无法撤销。","删除备份","取消", function ()
                  if pcall(function ()
                      File(zipFrom).delete()
                    end) then
                    toast("已删除")
                    onResume()
                   else
                    toast("删除失败")
                  end
                end,nil,0xffff4500)

              end,0xffff4500)
            end},
          adapter=restore,
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
        text="无备份",
        textColor=次要文字色,
        textSize="22sp",
      },
    },
  },
}))

function onResume()
  restore.clear()
  local bk=getFileList(备份文件夹)
  for s=1,#bk do
    local pat=tostring(bk[s])
    if pat:find("%.zip") then
      local fn=tostring(File(pat).Name):match("(.-)%.zip")
      if fn=="favourite" then
        fn="句子收藏"
       elseif fn=="soups" then
        fn="历史记录"
       elseif fn=="user_says" then
        fn="个人语录"
      end
      pcall(function ()
        restore.insert(0,{
          nr=fn,
          lj=pat,
        })
      end)
      fn=nil
    end
  end
  restore.notifyDataSetChanged()
  if nowPage==1 then
    if restore.getCount()>0 then
      nolog.setVisibility(8)
     else
      nolog.setVisibility(0)
    end
  end
end