#!/usr/bin/env bash
sudo yabai --load-sa
yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

# ====== Variables =============================
gaps_top="0"
gaps_bottom="0"
gaps_left="0"
gaps_right="0"
gaps_inner="5"

# ====== Tiling settings =======================

# 状态栏
yabai -m config status_bar                    off

# 默认拆分规则 first_child second_child
yabai -m config window_placement              second_child

# 窗口布局 bsp 平铺  float 浮动
yabai -m config layout                        bsp

# 窗口间距设置
yabai -m config top_padding                   "${gaps_top}"
yabai -m config bottom_padding                "${gaps_bottom}"
yabai -m config left_padding                  "${gaps_left}"
yabai -m config right_padding                 "${gaps_right}"
yabai -m config window_gap                    "${gaps_inner}"

# 自动平衡所有窗口始终占据相同的空间
yabai -m config auto_balance                  off

# 设置鼠标是否跟随当前活动窗口并居中 默认 off 关闭  on 开启
yabai -m config mouse_follows_focus           off
# 焦点跟随鼠标 默认off: 关闭  autoraise 自动提升  autofocus 自动对焦
yabai -m config focus_follows_mouse           off

# 鼠标修饰键 意思就是按着这个键就可以使用鼠标单独修改窗口大小了
yabai -m config mouse_modifier                fn
# fn + 左键 移动
yabai -m config mouse_action1                 move
# fn + 右键
yabai -m config mouse_action2                 resize

# 浮动窗口在顶部
# version < v6.0.0
# yabai -m config window_topmost                off

# 修改窗口阴影 on 打开  off 关闭  float 只显示浮动窗口的阴影
yabai -m config window_shadow                 float

# 配置活动窗口透明度
yabai -m config window_opacity                off
yabai -m config active_window_opacity         1.0
yabai -m config normal_window_opacity         0.9
yabai -m config window_opacity_duration       0.0

# 自动平衡所有窗口始终占据相同的空间
yabai -m config auto_balance                  off
# 如果禁用自动平衡，此项属性定义的是新窗口占用的空间量。0.5意为旧窗口占用50%
yabai -m config split_ratio                   0.5

# border
# version < v6.0.0
# yabai -m config window_border                 off

# ====== List of rules =========================
# https://github.com/koekeishiya/yabai/blob/master/doc/yabai.asciidoc#rule
# yabai -m query --windows --space 获取参数

# 为了兼容Hazeover/Blurred遮罩层 version >= v6.0.0
yabai -m rule --add app=".*" sub-layer=normal

yabai -m rule --add app="Google Chrome|Floorp" space=1
yabai -m rule --add app="^Code$" space=2
yabai -m rule --add app="^Obsidian$" space=3
yabai -m rule --add app="Floorp|KeePassXC" space=4
yabai -m config --space 5 layout float
yabai -m rule --add app="^(DingTalk|WeChat|WeCom|企业微信|TencentMeeting|QQ|Microsoft Outlook|Telegram Lite)$" space=5
yabai -m config --space 6 layout float
yabai -m rule --add app="^(AnyDsesk|Parallels Desktop|NetEaseMusic|QtScrcpy|网易MuMu|Swinsian|DBeaver|HandShaker|SunloginClient)$" space=6

# 不受到yabai平铺式的限制，之前怎么弹出来就怎么弹出来
systemApp='^(System Preferences|System Information|Finder|Calendar|Mail|App Store|Activity Monitor|Dictionary)$'
manageOffApp='^(Musicat|LocalSend|PicList|spotube|Permute 3|Clash Verge|kitty|Microsoft OneNote|START|IINA|Stats|LICEcap|Imagine|PicGo|electerm|KeePassXC|AppCleaner|Pixea|PictureView|App Cleaner & Uninstaller|NeatDownloadManager|Plash|Microsoft To Do|EuDic|qBittorrent|Infuse|Sublime Text|Alfred Preferences|MacZip)$'
yabai -m rule --add app="${systemApp}|${manageOffApp}" manage=off


# 不可调整大小的窗口浮动
# yabai -m signal --add event=window_created \
#   action='yabai -m query --windows --window $YABAI_WINDOW_ID \
#   | jq -er ".\"can-resize\" or .\"is-floating\"" || \
#   yabai -m window $YABAI_WINDOW_ID --toggle float' \
#   app!="${systemApp}|${manageOffApp}"

# osascript <<< "display notification \"configuration loaded..\" with title \"Yabai\" "