# -*- coding: ascii -*-
# -*- coding: utf-8 -*-
import pandas as pd
import csv
import re
import io


def leerArchivo () :
    with io.open ("datos_data_engineer.tsv", 'r', encoding="UTF-16LE") as f:
        data = [line.encode('utf-8').replace('\n' , '').split('\t') for line in f.readlines()]
    return data



def escribirArchivo(data, header , filename):
    with io.open(filename , 'wb') as f:
        writer = csv.writer(f , delimiter='|')
        writer.writerow(header)
        writer.writerows(data)

def etl(df):
    leerArchivo()
    id = re.compile(r"[1-9]")
    mail = re.compile(r"['\w\.+-]+@[\w.-]+\.[a-zA-Z]{2,6}(\.[a-zA-Z]{2,6})?$")
    alfa = re.compile(r"[a-z]+")


    df["email"] = df["email"].fillna("notengomail@gmail.com")
    df0 = pd.notna(df['email']) & df['email'].str.contains(mail)
    mask_id = pd.notna(df.iloc[:, 0]) & df.iloc[:, 0].str.contains(id)
    df1 = df[mask_id]
    mask_name = pd.notna(df1['first_name']) & df1['first_name'].str.contains(alfa)
    df2 = df1[mask_name]
    mask_apellido = pd.notna(df2['last_name']) & df2['last_name'].str.contains(alfa)
    df3 = df2[mask_apellido]
    mask = pd.notna(df3['account_number'])
    df4 = df3[mask]

    df4['Verificar Cuenta'] = df4['account_number'].map(lambda x: 'Verificar' if "-" in x or "/" in x else 'OK')

    return df4

if __name__ == '__main__':
    data = leerArchivo()
    df = pd.DataFrame(data[1:], columns=data[0])
    print(df.head())
    df = etl(df)
    escribirArchivo(df.values,df.columns,'datos_data_engineer - final.csv')


