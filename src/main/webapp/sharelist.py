# coding=GBK
import tushare as ts
import numpy as np
import datetime
import io
import sys

sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
day = 1
pro = ts.pro_api(token='e99d5c5bca10e82aaafb4047ecf4b8f0121866c3dc704c19f7c68f4b')
data = pro.query('stock_basic', exchange='', list_status='L', fields='ts_code,symbol,name')
now_time = datetime.datetime.now()
yesterday = now_time - datetime.timedelta(days=day)
str1 = str(yesterday)
str2 = str1[0:4]
str3 = str1[5:7]
str4 = str1[8:10]
str5 = str2 + str3 + str4
train_data = np.array(data)
train_data_list = train_data.tolist()
df = pro.query('daily', start_date=str5, end_date=str5, fields='change,pct_chg')
df_array = np.array(df)
df_list = df_array.tolist()
while len(df_list) == 0:
    day = day + 1
    yesterday = now_time - datetime.timedelta(days=day)
    str1 = str(yesterday)
    str2 = str1[0:4]
    str3 = str1[5:7]
    str4 = str1[8:10]
    str5 = str2 + str3 + str4
    df = pro.query('daily', start_date=str5, end_date=str5, fields='change,pct_chg')
    df_array = np.array(df)
    df_list = df_array.tolist()
str6 = ''
for a in range(min(len(train_data_list), len(df_list))):
    for b in range(len(train_data_list[a])):
        str6 = str6 + train_data_list[a][b] + ' '
    str6 = str6 + str(df_list[a][0]) + ' ' + str(df_list[a][1]) + ' '

print(str6)
