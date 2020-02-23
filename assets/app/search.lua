require "import"
import "str"


hslay={
  TextView,
  textColor=文字色,
  layout_width="fill",
  id="nr",
  textSize="18sp",
  padding="16dp",
}

长按2={
  onItemLongClick=function (p,v)
    local edt=AlertDialog.Builder(this)
    -- .setCancelable(false)
    .setTitle("选择操作")
    .setItems({"制作壁纸","添加收藏","分享内容","复制内容"}, function (d,n)
      local hiscon=v.text
      if n==0 then
        toast ("正在前往编辑页面")
        this.newActivity("soup",{hiscon})
       elseif n==2 then
        shareText(hiscon.."\n    ——闲言APP 最好的阅读平台")
       elseif n==3 then
        copyText(hiscon.."\n    ——闲言APP 最好的阅读平台")
       elseif n==1 then
        io.open(句子收藏..os.time().."("..#hiscon..")","w+"):write([[{
soup=]].."[["..hiscon.."]]"..[[,
type=]].."[[搜索]]"..[[,
}]]):close()
        toast("已加收藏，可在灵感中管理")
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

单击2={
  onItemClick=function (p,v)
    长按2.onItemLongClick(p,v)
  end}

this.setContentView(loadlayout ({
  RelativeLayout,
  --id="conf",
  layout_width="fill",
  layout_height="fill",
  --visibility=4,
  backgroundColor=背景色,
  --orientation="vertical",
  --elevation="2%w",
  paddingTop=状态栏高度,
  {
    ListView,
    --OverScrollMode=2,
    layout_width="fill",
    layout_height="fill",
    id="lv",
    FastScrollEnabled=true,
    onItemLongClickListener=长按2,
    OnItemClickListener=单击2,
    dividerHeight=38,
    divider=ColorDrawable(0x00000000),
  },
  {
    LinearLayout,
    layout_width="fill",
    layout_height="56dp",
    foreground=上下渐变({背景色,深透,淡透}),
  },
  {
    LinearLayout,
    layout_width="fill",
    layout_height="56dp",
    gravity="center",
    padding="16dp",
    paddingTop="8dp",
    paddingBottom="8dp",
    --backgroundColor=背景色,
    elevation="2dp",
    {
      ImageView,
      colorFilter=图标色,
      src="drawable/back.png",
      layout_height="fill",
      layout_width="44dp",
      foreground=波纹(波纹色),
      onClick=function ()
        this.finish()
      end,
      padding="9dp",
    },
    {
      EditText,
      layout_width="fill",
      layout_height="fill",
      gravity="left|center",
      layout_marginLeft="8dp";
      --layout_gravity="center",
      layout_weight=1;
      hint="搜点什么？",
      textSize="14sp",
      textColor=文字色,
      singleLine=true;
      background="#00000000";
      hintTextColor=第二文字色;
      id="edit";
    },
    {
      ImageView,
      ColorFilter=图标色,
      src="drawable/search.png",
      padding="9dp",
      layout_width="44dp",
      layout_height="fill",
      onClick=function ()
        搜索()
      end,
      --layout_alignParentRight=true,
      layout_gravity="right|center",
      foreground=波纹(波纹色),
    },
  },
}))

lv.setAdapter(LuaAdapter(activity,{},hslay))

function dp2px(dpValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return dpValue * scale + 0.5
end

HeaderView =TextView(activity)
HeaderView.onClick=function()end
HeaderView.setLayoutParams(AbsListView.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,dp2px(56)))
lv.addHeaderView(HeaderView)

FooterView =TextView(activity)
FooterView.foreground=波纹(波纹色)
FooterView.onClick=function()下一页()end
FooterView.Text="加载下一页"
FooterView.textColor=文字色
FooterView.gravity=Gravity.CENTER
FooterView.setLayoutParams(AbsListView.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,dp2px(56)))
--lv.addFooterView(FooterView)
底部=false

json=import "mods.json"
function 更新列表(data)
  data=json.decode(data)
  adapter=LuaAdapter(activity,data,hslay)
  lv.setAdapter(adapter)
end

function 开关分页(b,t)
  当前页数=1
  if b and 底部~=true then
    lv.addFooterView(FooterView)
    底部=true
  end
  if t then
    分页数据=json.decode(t)
  end
end

function 下一页()
  if 分页数据~=nil then
    if 当前页数+1 <= #分页数据 then
      当前页数=当前页数+1
      for v in string.gmatch(分页数据[当前页数],"【【(.-)】】") do
        if v~=nil then
          local va,vb=v:match("(.+)\\n\\n—— (.+)")
          adapter.add({nr={Text=vb.."\n\n——"..va,},})
        end
      end
      if 当前页数+1 > #分页数据 then
        if 底部 then
          lv.removeFooterView(FooterView)
          底部=false
        end
      end
     else
      if 底部 then
        lv.removeFooterView(FooterView)
        底部=false
      end
    end
  end
end

import "mods.mukmod"
mukactivity.setDataR("search_history",json.encode({}))

function 搜索()
  if 底部 then
    lv.removeFooterView(FooterView)
    底部=false
  end
  data={}
  if edit.Text=="" or edit.Text==nil then
    toast("请输入搜索内容")
   else
    search_history[#search_history+1]=edit.Text
    mukactivity.setData("search_history",json.encode(search_history))
    加载搜索记录()
    toast("加载数据中…")
    lv.setAdapter(LuaAdapter(activity,{},hslay))

    thread(function(ssc)
      require "import"
      import "org.jsoup.*"
      import "http"
      import "mods.mukmod"
      json=import "mods.json"
      local data={}
      Http.get("https://www.wncx.cn/mingyan/?q="..ssc,"utf8",function(code,content,cookie,header)
        local document3 = Jsoup.parse(content)
        local document3 = Jsoup.parse(tostring(document3.getElementsByTag("table")));
        local document3 = Jsoup.parse(tostring(document3.getElementsByTag("tr")))
        local document3 = Jsoup.parse(tostring(document3.getElementsByTag("table")))
        local document3 = tostring(document3.getElementsByTag("input"))
        local stmp=0
        local document3=document3:gsub("%<input type%=\"button\" value%=\" 查看解释 \" onclick%=\"javascript%:window%.alert%('","【【")
        :gsub("'%);\">",function(n)
          stmp=stmp+1
          local tmp1,tmp2 = math.modf(stmp/30)
          if tmp2==0 then
            return "】】|||"
           else
            return "】】"
          end
        end)

        if stmp>30 then
          分页=true
          分页数据=mukutils.split(document3,"|||")
          for v in string.gmatch(分页数据[1],"【【(.-)】】") do
            if v~=nil then
              local va,vb=v:match("(.+)\\n\\n—— (.+)")
              data[#data+1]={nr={Text=vb.."\n\n——"..va,},}
            end
          end
         else
          分页=false
          分页数据=nil
          for v in string.gmatch(document3,"【【(.-)】】") do
            if v~=nil then
              local va,vb=v:match("(.+)\\n\\n—— (.+)")
              data[#data+1]={nr={Text=vb.."\n\n——"..va,},}
            end
          end
        end
        local data=json.encode(data)
        local 分页数据=json.encode(分页数据)
        call("更新列表",data)
        call("开关分页",分页,分页数据)
      end)
    end,tostring(edit.Text))
  end
end

import "android.text.TextWatcher"

edit.addTextChangedListener(TextWatcher{
  onTextChanged=function(s, start, before, count)
    if edit.text=="" or edit.text==nil then
      pop.showAsDropDown(edit)
     else
      pop.dismiss()
    end
  end
})

--PopupWindow
Popup_layout={
  LinearLayout;
  {
    CardView;
    CardElevation="6dp";
    CardBackgroundColor=背景色;
    Radius="2dp";
    layout_width="-1";
    layout_height="-2";
    layout_margin="8dp";
    {
      GridView;
      layout_height="-1";
      layout_width="-1";
      NumColumns=1;
      id="Popup_list";
    };
  };
};

pop=PopupWindow(activity)
pop.setContentView(loadlayout(Popup_layout))
pop.setWidth(-1)
pop.setHeight(-2)

pop.setOutsideTouchable(false)
pop.setBackgroundDrawable(ColorDrawable(0x00000000))

pop.onDismiss=function()
end

Popup_list_item={
  LinearLayout;
  layout_width="-1";
  layout_height="48dp";
  {
    TextView;
    id="popadp_text";
    textColor=textc;
    layout_width="-1";
    layout_height="-1";
    textSize="14sp";
    gravity="left|center";
    paddingLeft="16dp";
  };
};

popadp=LuaAdapter(activity,Popup_list_item)

Popup_list.setAdapter(popadp)

function 加载搜索记录()
  popadp.clear()
  search_history=json.decode(mukactivity.getData("search_history"))
  search_history=muktable.unique(search_history)
  for i,v in ipairs(search_history) do
    if v~=nil and v~="" then
      popadp.add{popadp_text=v,}
    end
  end
  if #search_history~=0 then
    popadp.add{popadp_text="清空历史记录",}
   elseif #search_history==0 then
    popadp.add{popadp_text="什么都没搜过哦",}
  end
end

加载搜索记录()

Popup_list.setOnItemClickListener(AdapterView.OnItemClickListener{
  onItemClick=function(parent, v, pos,id)
    pop.dismiss()
    local s=v.Tag.popadp_text.Text
    if s=="清空历史记录" then
      mukactivity.setData("search_history",json.encode({}))
      加载搜索记录()
      toast("已清空历史记录")
     elseif s=="什么都没搜过哦" then
      toast("搜点什么吧")
     else
      edit.Text=s
      搜索()
    end
  end
})

edit.onClick=function()
  if edit.text=="" or edit.text==nil then
    pop.showAsDropDown(edit)
   else
    pop.dismiss()
  end
end

data={}
加载搜索记录()

thread(function(ssc)
  require "import"
  import "org.jsoup.*"
  import "http"
  import "mods.mukmod"
  json=import "mods.json"
  local data={}
  Http.get("https://www.wncx.cn/mingyan/?q=文字","utf8",function(code,content,cookie,header)
    local document3 = Jsoup.parse(content)
    local document3 = Jsoup.parse(tostring(document3.getElementsByTag("table")));
    local document3 = Jsoup.parse(tostring(document3.getElementsByTag("tr")))
    local document3 = Jsoup.parse(tostring(document3.getElementsByTag("table")))
    local document3 = tostring(document3.getElementsByTag("input"))
    local stmp=0
    local document3=document3:gsub("%<input type%=\"button\" value%=\" 查看解释 \" onclick%=\"javascript%:window%.alert%('","【【")
    :gsub("'%);\">",function(n)
      stmp=stmp+1
      local tmp1,tmp2 = math.modf(stmp/30)
      if tmp2==0 then
        return "】】|||"
       else
        return "】】"
      end
    end)

    if stmp>30 then
      分页=true
      分页数据=mukutils.split(document3,"|||")
      for v in string.gmatch(分页数据[1],"【【(.-)】】") do
        if v~=nil then
          if v:find("名人座右铭") then
           else
            local va,vb=v:match("(.+)\\n\\n—— (.+)")
            data[#data+1]={nr={Text=vb.."\n\n——"..va,},}
          end
        end
      end
     else
      分页=false
      分页数据=nil
      for v in string.gmatch(document3,"【【(.-)】】") do
        if v~=nil then
          if v:find("名人座右铭") then
           else
            local va,vb=v:match("(.+)\\n\\n—— (.+)")
            data[#data+1]={nr={Text=vb.."\n\n——"..va,},}
          end
        end
      end
    end
    local data=json.encode(data)
    local 分页数据=json.encode(分页数据)
    call("更新列表",data)
    call("开关分页",分页,分页数据)
  end)
end,tostring(edit.Text))
toast("加载数据中…")