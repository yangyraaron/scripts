#! /usr/bin/env python3.3
# -*- coding: UTF-8 -*-

from openpyxl import load_workbook
#from datetime import datetime

class TableReader:
	"""read table data from excel sheet"""
	def __init__(self, sheet,col_begin,col_end):
		self.sheet = sheet
		self.col_begin = col_begin
		self.col_end = col_end
		self.header = []

		self._build_header()

	def read(self):
		max_row_index = self.sheet.get_highest_row()

		datas=[]
		for ri in range(1,max_row_index):
			entity={}
			for ci in range(self.col_begin,self.col_end):
				cell = self.sheet.cell(row=ri,column=ci)
				str_value=""
				if cell.is_date():
					str_value=cell.value.isoformat()
				elif cell.value is None:
					str_value=''
				else:
					str_value=str(cell.value)

				entity[self.header[ci-self.col_begin]] = self._escape_sql_char(str_value)
			
			datas.append(entity)		

		return datas

	def _build_header(self):
		for hi in range(self.col_begin,self.col_end):
			header_cell = self.sheet.cell(row=0,column=hi)
			self.header.append(header_cell.value)


	def get_header(self):
		return self.header


	def _escape_sql_char(self,str):
		str = str.replace("'","\\'")
		str = str.replace('"','\\"')

		return str


		