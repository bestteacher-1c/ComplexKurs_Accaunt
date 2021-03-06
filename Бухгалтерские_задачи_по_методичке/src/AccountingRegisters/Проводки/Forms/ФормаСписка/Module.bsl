

&НаКлиенте
Процедура ПереключитьАктивность(Команда)
	ТекущиеДанныеСписка = Элементы.Список.ТекущиеДанные;
	
	Если (ТекущиеДанныеСписка <> Неопределено) Тогда
		ПереключитьАктивностьНаСервере(ТекущиеДанныеСписка.Регистратор);
		Элементы.Список.Обновить();
	КонецЕсли;
	
КонецПроцедуры


// Изменение активности набора записей
// 
// Параметры:
// 	Документ - ДокументСсылка - Ссылка на регистратор набора записей
&НаСервереБезКонтекста
Процедура ПереключитьАктивностьНаСервере(Документ)

	Проводки = РегистрыБухгалтерии.Проводки.СоздатьНаборЗаписей();
	Проводки.Отбор.Регистратор.Установить(Документ);
	
	Проводки.Прочитать();
	
	ТекущаяАктивность = Проводки[0].Активность;
	
	Проводки.УстановитьАктивность(Не ТекущаяАктивность);
	
	Проводки.Записать();

КонецПроцедуры
