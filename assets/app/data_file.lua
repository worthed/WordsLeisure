require "import"
import "str"

--[[sys="安卓系统版本号 - "..Build.VERSION.RELEASE
.."\n设备型号 - "..Build.MANUFACTURER.." "..Build.MODEL
.."\nSDK版本号 - "..Build.VERSION.SDK
.."\n序列号 - "..Build.SERIAL
.."\n设备ID - "..Secure.getString(this.getContentResolver(), Secure.ANDROID_ID)
]]

f_adp=LuaAdapter(this,{},{
  FrameLayout,
  -- layout_height=lay_wh,
  layout_width="fill",
  {
    LinearLayout,
    layout_gravity="left|center",
    orientation="vertical",
    layout_width="fill",
    padding="16dp",
    {
      TextView,
      id="name",
      paddingBottom="8dp",
      textSize="16sp",
      textColor=文字色,
    },
    {
      TextView,
      id="describe",
      textSize="14sp",
      textColor=次要文字色,
    },
  },
  {
    TextView,
    id="path",
    visibility=8,
  },
  {
    TextView,
    id="ori",
    visibility=8,
  },
})

oc={
  onItemClick=function (p,vi)
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems({"复制原文本内容","编辑文本内容"}, function (d,n)
      local co=vi.getChildAt(2).text
      local pat=vi.getChildAt(1).text
      if n==0 then
        copyText(co)
       else
        local edt=AlertDialog.Builder(this)
        .setTitle("编辑数据内容")
        .setCancelable(false)
        .setView(loadlayout ({
          LinearLayout,
          padding="16dp",
          paddingBottom=0,
          orientation="vertical",
          layout_width="fill",
          {
            TextView,
            text="请勿随意修改，以免出现运行错误",
            textColor=0xff666666,
            textSize="12sp",
            layout_width="fill",
            gravity="center",
            padding="8dp",
            paddingTop=0,
          },
          {
            EditText,
            layout_width="fill",
            backgroundColor=0,
            textSize="16sp",
            text=tostring (co),
            id="usaying",
            textColor=文字色,
            hintTextColor=次要文字色,
            hint=Html.fromHtml(co),
          },
        }))
        .setPositiveButton("保存", function ()
          local cont=usaying.text
          if #cont<1 then
            cont=co
          end
          --   print (cont)
          io.open(pat,"w+"):write(cont):close()
          toast ("已保存")
          onResume()
          cont=nil
        end)
        .setNegativeButton("取消",nil)
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
        --[[  usaying.addTextChangedListener({
          onTextChanged=function(s)
            if #s<1 then
            --  usaying.text=co
            end
          end})]]
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
    layout_height="56dp" ,
    gravity="center",
    padding="16dp",
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
      text="数据文件",
      textSize="20sp",
      textColor=文字色,
    },
  },
  {
    TextView,
    text="以下为部分记录数据的文件，请在开发者指引下操作",
    textColor=淡色,
    textSize="12sp",
    layout_width="fill",
    gravity="center",
    padding="8dp",
    paddingTop=0,
    paddingLeft="16dp",
    paddingRight="16dp",
  },
  {
    ListView,
    id="file_ListView",
    layout_width="fill",
    --numColumns=3,
    onItemClickListener=oc,
    adapter=f_adp,
    dividerHeight=0,
    fastScrollEnabled=true,
  },
}))

function onResume()
  f_adp.clear()
  if File(bground_path).exists () then
    local f=File(bground_path)
    local c=io.open(bground_path):read("*a")
    f_adp.add({
      name=f.Name,
      describe="用于记录背景设置（图片/颜色）。\n\n文本内容：\n"..c,
      path=bground_path,
      ori=c,
    })
  end
  if File(今天条数).exists () then
    local f=File(今天条数)
    local c=io.open(今天条数):read("*a")
    pcall(function ()
      t=StrToTable(c)
      after="日期："..t.date.."\n计数："..t.count
    end)
    after=after or "分析文本内容时出错，请联系开发者。"
    f_adp.add({
      name=f.Name,
      describe="用于记录当天刷句子的数量。\n\n分析后的文本内容：\n".. after,
      path=今天条数,
      ori=c,
    })
    after=nil
  end
  if File(最新通知).exists () then
    local f=File(最新通知)
    local c=io.open(最新通知):read("*a")
    pcall(function ()
      t=StrToTable(c)
      ty=t.type
      if ty=="" then ty="无" end
      after="日期："..t.time.."\n标题："..t.title.."\n内容："..t.content.."\n类型："..ty.."\n链接："..t.url
    end)
    after=after or "分析文本内容时出错，请联系开发者。"
    f_adp.add({
      name=f.Name,
      describe="用于记录最新一条通知推送的内容。\n\n分析后的文本内容：\n".. after,
      path=最新通知,
      ori=c,
    })
  end
  f_adp.notifyDataSetChanged()
end