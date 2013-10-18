#! /usr/bin/env python3.3
# -*- coding: UTF-8 -*-

from sql_translator import fieldMapping 

database_config={'主机（01）':{'table':'HOSTCOMPUTER','mapping':fieldMapping.host_mapping},
 '显示器（02）':{'table':'MONITOR','mapping':fieldMapping.monitor_mapping},
 '笔记本（03）':{'table':'NOTEBOOK','mapping':fieldMapping.laptop_mapping},
 '服务器（04）':{'table':'SERVER','mapping':fieldMapping.server_mapping},
 '移动设备（05）':{'table':'MOBILE','mapping':fieldMapping.mobile_mapping},
 '办公设备（06）':{'table':'OFFICEEQUIPMENT','mapping':fieldMapping.equipment_mapping},
 '办公家具（08）':{'table':'OFFICEFURNITURE','mapping':fieldMapping.furniture_mapping},
 '其他':{'table':'OTHEREQUIPMENT','mapping':fieldMapping.other_mapping},
 '虚拟':{'table':'VIRTUALEQUIPMENT','mapping':fieldMapping.virtual_mapping},
}


class Translator:
	"""tranlate data to sql"""

	def __init__(self):
		super(Translator, self).__init__()


	def translate(self,sheet_name,data_list):
		if(sheet_name not in database_config):
			return None

		sqls=[]
		config = database_config[sheet_name]
		for data in data_list:
			#print(data)
			sql = self._tranlate_sql(config['table'],config['mapping'],data)
			sqls.append(sql)

		return sqls
	
	def _tranlate_sql(self,table_name,mapping,entity_data):
		sql="insert into `fixedAsset`.`"+table_name+"` ("

		for key in mapping.keys():
			sql+='`'+key+'`,'

		sql=sql.rstrip(',')
		sql+=") values ("

		for value in mapping.values():
			v=""
			if value is not None:
				if value in entity_data:
					v=str(entity_data[value]).replace('\n','')
			sql+= r"'"+v+r"',"

		sql=sql.rstrip(',')
		sql+=");"
		
		return sql