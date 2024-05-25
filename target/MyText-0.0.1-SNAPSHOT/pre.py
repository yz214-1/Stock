import sys
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import math
from keras.models import Sequential
from keras.layers import Dense, Activation, Dropout, LSTM
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error
from tensorflow.keras import optimizers
import mycommon
import time

def creat_dataset(dataset, look_back=1):
    dataX, dataY = [], []
    for i in range(len(dataset)-look_back-1):
        a = dataset[i: (i+look_back)]
        dataX.append(a)
        dataY.append(dataset[i+look_back])
    return np.array(dataX), np.array(dataY)

def pre(ts_code,ts_name,start,end):
    url = sys.path[0]
    data = pd.read_csv(mycommon.data_path+ts_code+".csv", encoding='gbk')
    data_1 = data.loc[:, ['交易时间', '开盘价', '最高价', '最低价', '收盘价', '成交量(手)', '成交额(千元)', '换手率（%）', '换手率（自由流通股）']]
    data_1['交易时间'] = pd.to_datetime(data_1['交易时间'], format='%Y/%m/%d')
    data_1.index = data_1['交易时间']
    data_1 = data_1.sort_index(ascending=True, axis=0)  # 升序，按照index
    data_2 = data.loc[:, ['交易时间', '收盘价']]
    data_2['交易时间'] = pd.to_datetime(data_2['交易时间'], format='%Y/%m/%d')
    # data_2.insert(data_2.shape[0], 'instrument', 0)
    data_2.rename(columns={'收盘价': 'close'}, inplace=True)
    data_2.rename(columns={'交易时间': 'date'}, inplace=True)
    data_2 = data_2[(data_2['date'] >= start ) & (data_2['date'] <= end )]
    data_2.index = data_2.date
    data_2.drop('date', axis=1, inplace=True)

    dataset = data_2.values
    scaler = MinMaxScaler(feature_range=(0, 1))
    dataset = scaler.fit_transform(dataset.reshape(-1, 1))
    train_size = int(len(dataset) * 0.8)
    test_size = len(dataset) - train_size
    train, test = dataset[0: train_size], dataset[train_size: len(dataset)]
    look_back = 200
    trainX, trainY = creat_dataset(train, look_back)
    testX, testY = creat_dataset(test, look_back)

    model = Sequential()
    # model.add(LSTM(input_dim=layers[0],output_dim=layers[1],return_sequences=True))
    model.add(LSTM(200, input_shape=(200, 1), return_sequences=True))
    # units：输出维度
    # input_dim：输入维度，当使用该层为模型首层时，应指定该值（或等价的指定input_shape)
    # return_sequences：布尔值，默认False，控制返回类型。若为True则返回整个序列，否则仅返回输出序列的最后一个输出
    # input_length：当输入序列的长度固定时，该参数为输入序列的长度。当需要在该层后连接Flatten层，然后又要连接Dense层时，需要指定该参数，否则全连接的输出无法计算出来。
    model.add(Dropout(0.2))
    model.add(LSTM(200, return_sequences=False))
    model.add(Dropout(0.2))
    model.add(Dense(1))
    model.add(Activation("linear"))
    rms = optimizers.RMSprop(learning_rate=0.0001, rho=0.9, epsilon=1e-06)
    model.compile(loss="mse", optimizer=rms)

    model.fit(
        trainX,
        trainY,
        batch_size=512,
        epochs=1,
        validation_split=0.05
    )

    trainPredict = model.predict(trainX)
    testPredict = model.predict(testX)
    trainPredict = scaler.inverse_transform(trainPredict)
    trainY = scaler.inverse_transform(trainY)
    testPredict = scaler.inverse_transform(testPredict)
    testY = scaler.inverse_transform(testY)

    trainPredictPlot = np.empty_like(dataset)
    trainPredictPlot[:] = np.nan
    trainPredictPlot = np.reshape(trainPredictPlot, (dataset.shape[0], 1))
    trainPredictPlot[look_back: len(trainPredict) + look_back, :] = trainPredict
    testPredictPlot = np.empty_like(dataset)
    testPredictPlot[:] = np.nan
    testPredictPlot = np.reshape(testPredictPlot, (dataset.shape[0], 1))
    testPredictPlot[len(trainPredict) + (look_back * 2) + 1: len(dataset) - 1, :] = testPredict

    timee=data_2.index
    font2 = {'family' : 'Times New Roman','weight' : 'normal','size'   : 23,}
    fig2 = plt.figure(facecolor='white')
    ax = fig2.add_subplot(111)
    ax.plot(timee,scaler.inverse_transform(dataset),label='True Data')
    plt.plot(timee,trainPredictPlot)
    plt.plot(timee,testPredictPlot)
    plt.legend()
    #解决中文显示问题
    plt.rcParams['font.sans-serif']=['SimHei']
    plt.rcParams['axes.unicode_minus'] = False
    plt.title('股票实际数据及预测数据')
    ax.title.set_size(25)
    plt.ylabel('price',font2)
    plt.xlabel('date',font2)
    figure=plt.gcf()
    figure.set_size_inches(20,10)
    #plt.savefig(url+"\\"+ts_code.replace(".",""))
    plt.savefig(url+"\000001SZ.png")
    plt.show()
    return 0

if __name__ == '__main__':
    pre("000001.SZ", "jjjjj", "199550101", "20220101")
    #pre(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])