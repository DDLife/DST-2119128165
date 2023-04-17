# modmain.lua

self

- require "screens/mapscreen"

<docs-expose>

主体逻辑:

在 #screens/mapscreen 构造完成时候, 通过 OnMouseButton 给 Player 添加 BufferedAction

</docs-expose>

## main

<docs-expose>

1. @MakePin
2. AddClassPostConstruct
   1. 坐标转化
   2. 添加移动动作

</docs-expose>

## local

### MakePin

<docs-expose>

创建 pin 的实体(Entity)

</docs-expose>

添加的属性:

- AddTransform
- AddMiniMapEntity

## SetPin

<docs-expose>

改变 pin Entity 的位置

</docs-expose>
