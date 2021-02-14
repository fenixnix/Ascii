gourment
见客户忙碌了一个上午
早饭都没有吃
我决定...
* 早点回家
    -> go_home
* 难得到这里，到处转转
    -> stroll

=== go_home ===
我步履蹒跚得走向车站
我走过这条路么？
* 继续走
    路边的景色越来越陌生
    我似乎是迷路了
    周围没有半个人影
    我只得...
        ** 往回走
            顺利得回到了出发点
            ->stroll
        ** 坐下休息休息
            ->go_home
* 找个人问问
    你方向反了，错过了最近的一班车
    而且你得知下一班车发车还有2个小时
    肚子饿了
    ->stroll
->END


=== stroll ===
我记得客户说过附近有个不错的街区可以逛逛
->find_food

=== find_food ===
我来到了街道，这里看来有不少小餐馆
* 找最近的一家店吃
->restaurant001
* 继续逛逛
->restaurant002

=== restaurant001 ===
快餐店
* 就这家
    ->END
* 继续逛逛
->restaurant002

=== restaurant002 ===
中餐馆
* 就这家
    ->END
* 继续逛逛
->restaurant003

=== restaurant003 ===
批萨店
* 就这家
    ->END
 * 再看看
    **快餐店->restaurant001
    **中餐馆->restaurant002
    **批萨店->restaurant003