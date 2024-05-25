var dd = <%=dataa%>;
console.log(dd);
var ddlist=dd.split("\n");
var mainContainer = document.getElementById('one');
//用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽
var resizeMainContainer = function () {
	mainContainer.style.width = window.innerWidth+'px';
	mainContainer.style.height = window.innerHeight*0.8+'px';
};
//设置div容器高宽
resizeMainContainer();
// 初始化图表
var bar_Chart = echarts.init(mainContainer);
$(window).on('resize',function(){//
//屏幕大小自适应，重置容器高宽
resizeMainContainer();
    bar_Chart.resize();
});

/*var bar=function(){
        $.ajax({
            url:"/bar",
            success:function (data) {
                bar_Chart_option.xAxis.data=data.name;
                bar_Chart_option.series[0].data=data.value;
                bar_Chart.setOption(bar_Chart_option);
            },
            error:function(xhr,type,errorThrown) {
            }
        })
}*/
var bar_Chart_option = {
    title: {
        text: '股票量比分布',
        left: 'center',
    },
    tooltip : {
        trigger: 'item',
        //formatter: "{c}"
        /*formatter: function (params) {
                  return '价格:'+params.value[0]+'</br>'+'销售量:'+params.value[1]
               }*/
    },
    xAxis: {
        type: 'category',
        name:'日期',
        nameLocation: 'center',
        nameGap:25,
        data:dd[0]
    },
    yAxis: {
        type: 'value',
        name:'量比'
    },
    series: [{
        data:dd[1],
        type:'bar',
        itemStyle:{
            normal: {
                    color: '#2c3958'
                }
        }
    }]
};
bar_Chart.setOption(bar_Chart_option);

//bar();