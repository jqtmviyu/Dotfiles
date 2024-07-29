"显示行号
set nu

"启动时隐去援助提示
set shortmess=atI

"语法高亮
syntax on

"搜索忽略大小写
set ic

"显示文件名和路径
set laststatus=2

"文件自动检测外部更改
set autoread

"显示输入的命令
set showcmd

"不要闪烁
set novisualbell

"显示标尺，就是在右下角显示光标位置
set ruler

"共享剪切板
set clipboard=unnamed

" 禁止 c、cc、C、s、S、d、dd、D、x 和 X 命令写入寄存器
nnoremap c "_c
nnoremap cc "_cc
nnoremap C "_C
nnoremap s "_s
nnoremap S "_S
nnoremap d "_d
nnoremap dd "_dd
nnoremap D "_D
nnoremap x "_x
nnoremap X "_X
