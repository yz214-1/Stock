import sys

import numpy as np
import pandas as pd
import pyecharts.options as opts
from pyecharts.charts import Pie, Grid, Line, Scatter
import matplotlib.pyplot as plt
# V1.0 移动平均线比较
from pyecharts.commons.utils import JsCode
import mycommon


def ma_analyze(ts_code, starttime, endtime):
    starttime=starttime[0:4]+"-"+starttime[4:6]+"-"+starttime[6:8]
    endtime = endtime[0:4] + "-" + endtime[4:6] + "-" + endtime[6:8]
    stock_data = pd.read_csv(mycommon.data_path+ts_code + ".csv", encoding='gbk', engine='python')
    #print(mycommon.data_path+ts_code + ".csv")
    if endtime > stock_data['交易时间'][len(stock_data['交易时间']) - 1]:
        endtime = stock_data['交易时间'][len(stock_data['交易时间']) - 1]
    if starttime < stock_data['交易时间'][0]:
        starttime = stock_data['交易时间'][0]
    ur = sys.path[0]
    # 计算简单算术移动平均线MA
    ma_list = [5, 10, 30]
    for ma in ma_list:
        stock_data['MA_' + str(ma)] = stock_data['收盘价'].rolling(ma).mean()

    # 统计日线比较情况
    datas = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    total = 0
    # 定义下标位置 0：5>10 1：5>30 2：10>30 3：5<10 4：5<30 5:10<30 6:5=10 7:10=30 8:5=30
    # 追加：9:收盘价>5 10收盘价=5 11收盘价<5
    #      12:收盘价>10 13收盘价=10 14收盘价<10
    #      15:收盘价>30 16收盘价=30 17收盘价<30
    for i in range(len(stock_data['交易时间'])):
        if (starttime <= stock_data['交易时间'][i]) & (endtime >= stock_data['交易时间'][i]) & (
                stock_data['MA_5'][i] != 'nan') & (stock_data['MA_10'][i] != 'nan') & (
                stock_data['MA_30'][i] != 'nan'):
            total += 1
            if stock_data['MA_5'][i] > stock_data['MA_10'][i]:
                datas[0] += 1
            elif stock_data['MA_5'][i] == stock_data['MA_10'][i]:
                datas[6] += 1
            else:
                datas[3] += 1

            if stock_data['MA_5'][i] > stock_data['MA_30'][i]:
                datas[1] += 1
            elif stock_data['MA_5'][i] == stock_data['MA_30'][i]:
                datas[8] += 1
            else:
                datas[4] += 1

            if stock_data['MA_10'][i] > stock_data['MA_30'][i]:
                datas[2] += 1
            elif stock_data['MA_10'][i] == stock_data['MA_30'][i]:
                datas[7] += 1
            else:
                datas[5] += 1

            if stock_data['收盘价'][i] > stock_data['MA_5'][i]:
                datas[9] += 1
            elif stock_data['收盘价'][i] == stock_data['MA_5'][i]:
                datas[10] += 1
            else:
                datas[11] += 1

            if stock_data['收盘价'][i] > stock_data['MA_10'][i]:
                datas[12] += 1
            elif stock_data['收盘价'][i] == stock_data['MA_10'][i]:
                datas[13] += 1
            else:
                datas[14] += 1

            if stock_data['收盘价'][i] > stock_data['MA_30'][i]:
                datas[15] += 1
            elif stock_data['收盘价'][i] == stock_data['MA_30'][i]:
                datas[16] += 1
            else:
                datas[17] += 1
    stock_data = stock_data.drop(
        stock_data[(stock_data['交易时间'] < starttime) | (stock_data['交易时间'] > endtime)].index)
    fn = """
            function(params) {
                if(params.name == '其他')
                    return '\\n\\n\\n' + params.name + ' : ' + params.value + '天';
                return params.name + ' : ' + params.value + '天';
            }
            """

    def new_label_opts():
        return opts.LabelOpts(formatter=JsCode(fn), position="left")

    x_data = ['5日线>10日线', '5日线>30日线', '10日线>30日线', '5日线<10日线', '5日线<30日线',
              '10日线<30日线', '5日线=10日线', '10日线=30日线', '5日线=30日线', '收盘价>5日线',
              '收盘价=5日线', '收盘价<5日线', '收盘价>10日线', '收盘价=10日线', '收盘价<10日线',
              '收盘价>30日线', '收盘价=30日线', '收盘价<30日线']
    c = (
        Pie(init_opts=opts.InitOpts(width="1100px", height="600px"))
            .add(
            "",
            [list(z) for z in zip([x_data[0], x_data[6], x_data[3]], [datas[0], datas[6], datas[3]])],
            center=["30%", "30%"],
            radius=[40, 80],
            label_opts=new_label_opts(),

        )
            .add(
            "",
            [list(z) for z in zip([x_data[1], x_data[8], x_data[4]], [datas[1], datas[8], datas[4]])],
            center=["50%", "30%"],
            radius=[40, 80],
            label_opts=new_label_opts(),
        )
            .add(
            "",
            [list(z) for z in zip([x_data[2], x_data[7], x_data[5]], [datas[1], datas[7], datas[5]])],
            center=["70%", "30%"],
            radius=[40, 80],
            label_opts=new_label_opts(),
        )
            .add(
            "",
            [list(z) for z in zip([x_data[9], x_data[10], x_data[11]], [datas[9], datas[10], datas[11]])],
            center=["30%", "70%"],
            radius=[40, 80],
            label_opts=new_label_opts(),
        )
            .add(
            "",
            [list(z) for z in zip([x_data[12], x_data[13], x_data[14]], [datas[12], datas[13], datas[14]])],
            center=["50%", "70%"],
            radius=[40, 80],
            label_opts=new_label_opts(),
        )
            .add(
            "",
            [list(z) for z in zip([x_data[15], x_data[16], x_data[17]], [datas[15], datas[16], datas[17]])],
            center=["70%", "70%"],
            radius=[40, 80],
            label_opts=new_label_opts(),
        )
            .set_global_opts(
            title_opts=opts.TitleOpts(title="日线比较"),
            legend_opts=opts.LegendOpts(
                type_="scroll", pos_top="20%", pos_left="0%", orient="vertical"
            ),

        )
            .set_series_opts(
            tooltip_opts=opts.TooltipOpts(
                trigger="item", formatter="{b}: {c} ({d}%)"
            ),
        )
            .render(path=ur+"\\mutiple_pie.html")
    )
    print("C://Users/ASUS/mutiple_pie.html")
    stock_data['MA_5_10'] = stock_data['MA_5'] - stock_data['MA_10']
    # print(stock_data['MA_5_10'][20])
    stock_data['diff'] = np.sign(stock_data['MA_5_10'])
    # print(stock_data['diff'][20])
    stock_data['signal'] = np.sign(stock_data['diff']-stock_data['diff'].shift(1))
    datacs=stock_data.loc[7100:7300]
    l = (
            Line(init_opts=opts.InitOpts(width="850px", height="450px"))
                .add_xaxis(xaxis_data=datacs['交易时间'])
                .add_yaxis(
                series_name='signal',
                # is_step=True,
                symbol="emptyCircle",
                is_symbol_show=False,
                # xaxis_index=1,
                color="#2a5caa",
                y_axis=datacs['signal'],
                label_opts=opts.LabelOpts(is_show=True),
                linestyle_opts=opts.LineStyleOpts(width=2),


            )
                .set_global_opts(
                title_opts=opts.TitleOpts(
                    title="指标：'signal'",
                    subtitle="数据源" + ts_code,
                    pos_left="center",
                    pos_top="top",
                ),

                tooltip_opts=opts.TooltipOpts(trigger="axis", axis_pointer_type="cross"),
                legend_opts=opts.LegendOpts(pos_left="left"),
                datazoom_opts=[
                    opts.DataZoomOpts(range_start=0, range_end=100),
                    opts.DataZoomOpts(type_="inside", range_start=0, range_end=100),
                ],
                xaxis_opts=opts.AxisOpts(type_="category", boundary_gap=False),
                yaxis_opts=opts.AxisOpts(name="买入卖出signal", type_="value", max_=2, min_=-2),
    )
             .render(path=ur+"\\ceshi.html")
        )
    l = (
        Line(init_opts=opts.InitOpts(width="1100px", height="600px"))
            .add_xaxis(xaxis_data=stock_data['交易时间'])
            .add_yaxis(
            series_name='换手率（%）',
            is_smooth=True,
            symbol="emptyCircle",
            is_symbol_show=False,
            # xaxis_index=1,
            color="#2a5caa",
            y_axis=stock_data['换手率（%）'],
            label_opts=opts.LabelOpts(is_show=True),
            linestyle_opts=opts.LineStyleOpts(width=2),

        )
            .set_global_opts(
            title_opts=opts.TitleOpts(
                title="指标：换手率",
                subtitle="数据源" + ts_code,
                pos_left="center",
                pos_top="top",
            ),
            tooltip_opts=opts.TooltipOpts(is_show=True,axis_pointer_type= "cross",trigger="axis", formatter=JsCode(
                """function(params){
                 var i=params[0].data[1];
                var j;
                if (i <= 3) j='正常走势';
                else if (i <= 7) j='进入相对活跃状态';
                else if (i <= 10) j='强势股的出现，股价处于高度活跃当中';
                else if (i <= 15) j='大庄密切操作';
                else j ='超过15%换手率，持续多日的话，此股也许成为最大黑马';
                return '日期：'+ params[0].data[0]+'<br/>'+'换手率：'+i +'<br/>'+'建议：'+j;
                }"""
            )),
            legend_opts=opts.LegendOpts(pos_left="left"),
            datazoom_opts=[
                opts.DataZoomOpts(range_start=0, range_end=100),
                opts.DataZoomOpts(type_="inside", range_start=0, range_end=100),
            ],
            xaxis_opts=opts.AxisOpts(type_="category", boundary_gap=False),
            yaxis_opts=opts.AxisOpts(name="换手率指标", type_="value", max_=max(stock_data['换手率（%）'])),
        )
            .set_series_opts(
            label_opts=opts.LabelOpts(is_show=False),
            markline_opts=opts.MarkLineOpts(data=[opts.MarkLineItem(y=3, name="正常走势"), opts.MarkLineItem(y=7),
                                                  opts.MarkLineItem(y=10), opts.MarkLineItem(y=15)]),
        )

    )
    l.render(path=ur+'\\huanshoulv.html')


# 按间距中的绿色按钮以运行脚本。
if __name__ == '__main__':
    #ma_analyze("000002.SZ", "20210101", "20220101")
    ma_analyze(sys.argv[1], sys.argv[3], sys.argv[4])
