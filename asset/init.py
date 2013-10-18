#! /usr/bin/env python3.3
# -*- coding: UTF-8 -*-

import os
import logging
from excel_data import table
from openpyxl import load_workbook
from sql_translator import translator
import sqlwriter

sheet_config={'主机（01）':{'col_begin':1,'col_end':20},
	'显示器（02）':{'col_begin':1,'col_end':13},
	'笔记本（03）':{'col_begin':1,'col_end':18},
	'服务器（04）':{'col_begin':0,'col_end':17},
	'移动设备（05）':{'col_begin':0,'col_end':10},
	'办公设备（06）':{'col_begin':0,'col_end':10},
	'办公家具（08）':{'col_begin':0,'col_end':9},
	'其他':{'col_begin':0,'col_end':8},
	'虚拟':{'col_begin':0,'col_end':8}
	}


cur_dir = os.path.dirname(os.path.abspath(__file__))
filename = cur_dir+'/固定资产模板.xlsx'

wb = load_workbook(filename=filename)

sheet_names = wb.get_sheet_names()

for sheet_name in sheet_names:
	print("read data from "+sheet_name)

	sheet = wb.get_sheet_by_name(sheet_name)

	if sheet_name in sheet_config:
		config = sheet_config[sheet_name]
		t_reader = table.TableReader(sheet,config['col_begin'],config['col_end'])
		data = t_reader.read()

		sql_translator = translator.Translator()
		sqls = sql_translator.translate(sheet_name,data)
		
		if sqls is not None:
			print("writing sql to "+sheet_name)
			sqlwriter.write_sql_to_file('{0}/sqls/{1}.sql'.format(cur_dir,sheet_name),sqls)

