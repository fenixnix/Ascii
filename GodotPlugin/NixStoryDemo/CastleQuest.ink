#title:Castle Quest
Castle Quest 

VAR visit_town = false
VAR know_sage = false
VAR gear = false
VAR potion = false
VAR sword = false
VAR life = 0

->start

=== start
# scn:op
很久很久以前
有个魔王滥杀无辜、恶贯满盈，诸国深受其害
>
我背井离乡，一个人踏上了讨伐魔王的征程

* 前往魔王城
->castle_forest

* 先在村庄做点准备
->town

=== town
#nrt
#clear
#scn:scn_town
你来到了村庄，你准备
* 拜访村长家
    #close
    #scn:scn_town_cheif
    #cha:npc00
    #dlg
    听说你要去讨伐魔王
    去拜访一下村头的小屋吧
    那里住着位贤者
    他对魔王比较了解
    ~ know_sage = true
    >
    #clear
    #close
    ->town

* 去铁匠铺
#scn:scn_blacksmith
#cha:npc01
#dlg
    听说你要去魔王城？
    真是勇气可嘉
    这边有一套我年轻时穿的装备
    不嫌弃就拿去用吧
    ** [收下装备]

    获得冒险者套装#colour green
    ~ gear = true
    >
    #clear
    #close
    ->town
* {know_sage} 拜访贤者
    #scn:scn_sage
    ->sage_hut
* 该去魔王城了
    ->castle_forest
-
->town

=== sage_hut
#cha:npc02
#dlg
你终于来了，年轻人
想要打倒魔王,必须要掌握时空的力量才行
去西边的山洞看看吧，那里有你需要的东西

* [去西边的山洞]
 -> west_cave

=== west_cave
# scn:scn_cave
这里盘踞着一伙强盗
{not gear:->end_01}
你打败了他们
在洞穴深处
获得时钟剑 # colour green
~ sword = true
* 返回村庄
->town

=== castle_forest
# scn:scn_forest
#nrt
在去往魔王城的森林
你发现有一直商队正受到强盗的劫掠
* 救下商队
    {not gear:->end_01}
    我三下五除二打跑了强盗。
    商队头领感谢涕零，拿出一大袋金币想以此作为回报
    ** [好人有好报，收下]
    我收下了金币
    ->save
    ** [婉拒，这点小事]
    头领见我不收，打量了一下我，
    从怀中的贴身口袋里掏出一个闪亮的水晶瓶，交给我说：
    “这是用凤凰羽毛提取的药剂，能让人起死回生。
    也许这个对你有用”
    我想着去魔王城危险重重，这个也许派的上用场
    向头领表示感谢，收下了药剂。
    ~ potion = true
    ->save
* 直接去魔王城
    -> to_castle

= save
    商队一再表示感谢，继续赶路去了
    -> to_castle
-
= to_castle
就快接近魔王城了
# scn:scn_castle_gate
路边的树丛突然蹿出几个魔王卫兵
{not gear:->end_00}
{sword:->battle_easy|->battle_hard}
= battle_easy
你举起时钟剑，所有的卫兵都停了下来，一动不动
你轻轻松松得打败了他们
->castle
= battle_hard
你使劲了浑身解数，将卫兵都打翻在地
你精疲力竭，还受了几处伤
->castle

=== castle
#scn:scn_castle
你终于来到了魔王城
来到城门下
大门似乎知道了你的到来，吱吱呀呀得缓缓打开
里面漆黑一片
*[进去]
-
#nrt
#clear
{not sword:->end_04}
进入魔王城
你举起时钟剑，以防万一
双眼适应了黑暗
小心翼翼得走向城堡深处
魔王从王座上缓缓起身
#scn:scn_boss_battle
你二话不说挥剑冲向了魔王
不知道打了多久，双方不相上下
魔王:我认可你的能力，人类。不如放下武器我将和你平分这整个世界，如何？
* 我已经筋疲力尽，只得答应:好吧，但你要保证绝不再入侵我们的家园
    你已经十分疲劳，没有十分的把握能打倒魔王。于是你决定接受谈判。
    但当你刚刚放松警惕的同时，魔王突然偷袭你。
    你被贪婪蒙蔽了内心。灵魂永远被魔王奴役着
    Ending：大意了...
    ->END

* 对于邪恶的魔王我无法妥协
    虽然我已经力竭，但是魔王似乎也好不到哪里去。
    我努力至今不就是为了这一战么。
    {potion:->end_02}
    ->end_03

=== end_00
#scn：end_0
    你手无寸铁，双拳难敌四手
    很快败下阵来
    你被五花大绑拖回了魔王城
    在暗无天日的地牢里度过余生
    ->END

=== end_01
#scn：end_1
    你手无寸铁，马上被打翻在地
    被卖到魔王城当奴隶...
    ->END

=== end_02
#scn：end_2
    我摸到了商队给的药剂，一口喝下。
    力量充满了全身
    魔王已是强弩之末，绝望得看着我把剑刺入了他的胸膛。
    他愤怒得狂吼着，拼尽了最后一丝力气。
    我飞快得跑出了大门
    城堡在我身后轰然倒塌...
    ->END

=== end_03
#scn：end_3
    也不知道继续战斗了多久。
    我拼尽了最后一丝气力刺入了魔王的胸膛。魔王以不可置信的眼神看着我。
    随着魔王身体的消散，魔王城也跟着崩坏坍塌
    我无奈得倒在了地上，与城堡同归于尽.....
    ->END

=== end_04
#scn：end_4
    周边的黑暗迅速吞噬了我
    我渐渐失去了意识
    ->END

=== END