# 历程
***
### 2024.3.30
发现在写汽车订购的时候，对于表单地提交，我开始是用这样的代码:

    <form class="ui form" onsubmit="fun4()">     
        <div class="ui button">提交订单信息</div>
    </form>
同时在验证表单提交的代码如下:

    $(document).ready(function () {
        $('.ui.form').form({
            time: {
                identifier: 'time',
                rules: [
                    {
                    type: 'regExp',
                    value:/^[1-9][0-9]?$/,
                    prompt: '时间不符合规范'
                    }
                ]
            }
            ········（此处省略N多字）  
            , {
                inline: true,
                on: 'submit',
            }
        );
        $('.submit.button').on('click', function () {
            $('.ui.form').form('validate form');
            if ($('.ui.form').form('is valid')) {
                // 验证通过，可以进入下一步
                // 进入下一步的逻辑代码
            } else {
                // 验证不通过，阻止进入下一步
                // alert('表单验证未通过，请检查输入信息');
                return false;
            }
        });
    });
然后直接点提交，发现不显示任何错误，就很奇怪。直到改动了这一处

    $('.submit.button').on('click', function () {
将其改成这样的

    $('.submit-button').on('click', function () {

它就好了，就好了，有错误出现了啊啊啊啊啊啊啊。这么玩是吧。 我接着填好表单后提交，啊啊啊啊啊，又提交不了了。
精神状态良好，啊啊啊啊啊，继续改吧。
找到错误，修改以下代码

    {
        inline: true,
        on: 'submit',
    }
改成这样

    {
        inline: true,
        on: 'submit',
        onSuccess: function () {
        fun4();
        }
    }

完整的如下：

第一处改动

    <form class="ui form" onsubmit="fun4()">     
        <div class="ui button">提交订单信息</div>
    </form>

    ***改成***

    <form class="ui form">     
        <div class="ui button submit-button">提交订单信息</div>
    </form>
第二处改动

    {
    inline: true,
    on: 'submit',
    }

    ***改成***
    
    {
        inline: true,
        on: 'submit',
        onSuccess: function () {
        fun4();
        }
    }
第三处改动

    $('.submit.button').on('click', function () {

    ***改成***

    $('.submit-button').on('click', function () {
天天写bug，每天都不重样，笑死人，又气人，又想笑。
***
### 24.3.31
* 今天还算顺利，早上将顾客以及管理界面的数据清理了一下，同时将车辆预定的时候，免去一些不必要的信息填写。
* 将订车的时候，根据需要填写的开始订车时间和退车时间，判断是否符合规范，开始订车时间不能低于目前时间，退车时间不能小于开始订车时间。
* 同时在订购车辆的时候加入预定和退车时间的数据，根据传入的时间，通过后台分析车辆状态是要为预定中还是已租车。
* 加入系统登录前自动触发更新order订单的信息，根据当前日期判断是否需要将车辆状态预定中改为已租车，已租车改为已退车。
***
### 24.4.1
* 今天好像很顺利哦，决定开始研究如何在修改租车商的信息基础上加上一个修改租车商的车辆选项。因为可能会遇到一些汽车信息需要修改的情况，所以越发觉得需要加入这个功能。 
***
### 24.4.2
* 在加入修改车辆的相关信息时，我原先是设计在进入修改车辆信息页面后，可以选择好需要修改的车辆号，然后便会显示相应的信息，租车商可以直接在原有的消息上进行修改，同时可以修改照片，然后直接提交信息进入验证信息的界面。但是在确认界面的时候发现无法将照片传入到验证的界面。所以决定进行改变。改成两种修改方式，一个是修改车辆的基本信息，一个是修改车辆的照片。两种都是通过以车辆号来找寻需要的信息进行修改。
***
### 24.4.3-4.4 
* 修养、躺平、没干活
***
### 24.4.5
* 修改一下系统忽然出现的bug，然后再进行修改编写前段时间写了的world文档，将系统修改的信息加上去。经过忙碌，算是将系统需要的内容以及该做的功能都加好了。
***