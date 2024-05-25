import json
import tushare as ts
import numpy as np
import pandas as pd
import sys
import mycommon
import datetime
def updata(ts_code,ts_name,start,end):

    csv_file = pd.read_csv(mycommon.data_path+ts_code+".csv", encoding='gbk')
    #csv_file = pd.read_csv("E:\\000001.SZ.csv", encoding='gbk')
    train_data_list = []
    train_data_list1 = []
    train_data_list2 = []
    train_data_list3 = []
    train_data_list4 = []
    for i in range(len(csv_file['交易时间'])):
    	if int(str(csv_file['交易时间'][i]).replace('-', ''))>=int(start) and int(str(csv_file['交易时间'][i]).replace('-', ''))<=int(end):
        	temp = [str(csv_file['交易时间'][i]).replace('-', ''), 
                csv_file['量比'][i],
                csv_file['成交量(手)'][i], csv_file['成交额(千元)'][i]]
        	train_data_list.append(temp)
    #print(train_data_list)
    for i in range(len(train_data_list)):
        train_data_list[i][0] = int(train_data_list[i][0])
    list2 = sorted(train_data_list, key=(lambda x: x[0]))
    for i in range(len(list2)):
        list2[i][3]=list2[i][3]*1000
        train_data_list1.append(list2[i][0])
        train_data_list2.append(list2[i][1])
        train_data_list3.append(list2[i][2])
        train_data_list4.append(list2[i][3])
    print(train_data_list1)
    print(train_data_list2)
    print(train_data_list3)
    print(train_data_list4)
    return list2

if __name__ == '__main__':
		cc=updata(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])