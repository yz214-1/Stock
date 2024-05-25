import json
import tushare as ts
import numpy as np
import pandas as pd
import sys
import datetime
import  mycommon
def updata(ts_code,ts_name,start,end):
    csv_file = pd.read_csv(mycommon.data_path+ts_code+".csv", encoding='gbk')
    #csv_file = pd.read_csv("E:\\000001.SZ.csv", encoding='gbk')
    train_data_list = []
    for i in range(len(csv_file['交易时间'])):
    	if int(str(csv_file['交易时间'][i]).replace('-', ''))>=int(start) and int(str(csv_file['交易时间'][i]).replace('-', ''))<=int(end):
        	temp = [str(csv_file['交易时间'][i]).replace('-', ''), csv_file['开盘价'][i], csv_file['最高价'][i], csv_file['最低价'][i], csv_file['收盘价'][i],
                csv_file['前收盘价'][i],
                csv_file['成交量(手)'][i], csv_file['成交额(千元)'][i]]
        	train_data_list.append(temp)
    #print(train_data_list)
    for i in range(len(train_data_list)):
        train_data_list[i][0] = int(train_data_list[i][0])
    list2 = sorted(train_data_list, key=(lambda x: x[0]))
    for i in range(len(list2)):
        temp = list2[i][5]
        list2[i][5]=list2[i][4]
        list2[i][4] = list2[i][3]
        list2[i][3] = list2[i][2]
        list2[i][2] = list2[i][1]
        list2[i][1] = temp
        list2[i][7]=list2[i][7]*1000
    dict = {
        'data': list2,
        'symbol': ts_code,
        'name': ts_name,
        'start': 6781,
        'end': 5782,
        'count': len(list2),
        'ticket': 0,
        'version': "2.0",
        'message': None,
        'code': 0
    }
    data2 = json.dumps(dict, indent=4, separators=(',', ': '), ensure_ascii=False)
    return data2

if __name__ == '__main__':
    if sys.argv[1]=='show':
        now_time = datetime.datetime.now()
        str1=str(now_time)
        str2=str1[0:4]
        str3 = str1[5:7]
        str4 = str1[8:10]
        now_date = str2 + str3 + str4
        print(updata(sys.argv[2], sys.argv[3]))
    else:
        print(updata(sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5]))