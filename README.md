# OS-explore

原计划使用AT&T汇编进行编写，没想到直接卡到第三个上面了，结果与intel汇编不同，而且无法通过已知方法进行重现。

```
.data
// the_secret: .ascii "X" 如果在这里定义，那么后面无法显示X

mov $'1', %al
int $0x10
mov the_secret, %al
// 此处对应的取地址指令是 mov $the_secret, %al 或 lea the_secret，%al 但是这两个任何一个都没办法通过编译，比较诡异
int $0x10
```