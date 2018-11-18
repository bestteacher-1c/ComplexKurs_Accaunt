Процедура ОбработкаПроведения(Отказ, Режим)

	Движения.Проводки.Записывать = Истина;
	
	КроссКурс = СерверныйСВызовом.ПересчитатьИзВалютыВВалюту(Валюта,,1,Дата);
	
	Для Каждого ТекСтрокаТовары Из Товары Цикл
		
		Движение = Движения.Проводки.Добавить();
		
		//--Общие для проводки -----
		
		Движение.Период = Дата;
		Движение.Сумма = ТекСтрокаТовары.Сумма * КроссКурс;
		Движение.СодержаниеПроводки = "Поступили ТМЦ";
		Движение.Организация = Организация;
		
		//--Дебет -----
		Движение.СчетДт = ТекСтрокаТовары.СчетУчета;
		//Движение.ПодразделениеДт = Подразделение;
		Бухгалтерия.ЗаполнитьПодразделениеСтороныПроводки(Движение,Подразделение,"Дт");
		
		Бухгалтерия.ЗаполнитьСубконтоСтороныПроводки(Движение,"Номенклатура", ТекСтрокаТовары.Номенклатура, "Дт");
		Бухгалтерия.ЗаполнитьСубконтоСтороныПроводки(Движение,"Склады", Склад, "Дт");
		Бухгалтерия.ЗаполнитьСубконтоСтороныПроводки(Движение,"Контрагенты", Контрагент, "Дт");
		
		Бухгалтерия.ЗаполнитьКоличествоСтороныПроводки(Движение, ТекСтрокаТовары.Количество, "Дт");
		//--Кредит ----
		Если Не ТекСтрокаТовары.СчетУчета.Забалансовый Тогда
		
			Движение.СчетКт = ПланыСчетов.Счета.Поставщики;
			Бухгалтерия.ЗаполнитьПодразделениеСтороныПроводки(Движение,Подразделение,"Кт");
			
			Бухгалтерия.ЗаполнитьСубконтоСтороныПроводки(Движение,"Контрагенты", Контрагент, "Кт");
			Бухгалтерия.ЗаполнитьСубконтоСтороныПроводки(Движение,"Договоры", Договор, "Кт");
			
			Бухгалтерия.ЗаполнитьКоличествоСтороныПроводки(Движение, ТекСтрокаТовары.Количество, "Кт");
			
			Бухгалтерия.ЗаполнитьВалютуСтороныПроводки(Движение, Валюта, ТекСтрокаТовары.Сумма, "Кт");
			
		КонецЕсли; 
		
		
	КонецЦикла;

КонецПроцедуры




