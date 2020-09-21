### 解决方案
那么如何解决这个问题？
思路如下：

使用

```
git checkout --orphan new_branch
```

基于当前分支创建一个独立的分支new_branch；
'''
    git checkout --orphan  new_branch
 '''
复制代码
添加所有文件变化至暂存空间

    git add -A
复制代码
提交并添加提交记录

    git commit -am "commit message"
复制代码
删除当前分支

(我的当前分支是master,个人小的项目没有使用 gitflow 工作流管理,切记master谨慎删除😁)



    git branch -D master
复制代码
重新命名当前独立分支为 master
```
   git branch -m master
```
复制代码
推送到远端分支

-f 是 --force 的缩写, 一定要谨慎使用,好多项目中你或者是别人的代码被覆盖都是这么操作的,除非只有你一个人在开发;



    git push -f origin master
