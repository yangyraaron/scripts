import os 

def write_sql_to_file(file_name,sqls):
	if file_name is None or file_name=='':
		return

	if sqls is None or len(sqls)==0:
		return

	if not os.path.exists(file_name):
		with open(file_name,'x') as f:
			write_sql_to_opend_file(f, sqls)
	else:
		with open(file_name,'w') as f:
			write_sql_to_opend_file(f, sqls)

def write_sql_to_opend_file(file,sqls):
	for sql in sqls:
		file.write(sql)
		file.write('\n')
		