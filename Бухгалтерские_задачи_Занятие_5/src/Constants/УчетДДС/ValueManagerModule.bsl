Процедура ПриЗаписи(Отказ)

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
		|	УчетДДС.Значение КАК Значение
		|ИЗ
		|	Константа.УчетДДС КАК УчетДДС";

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл

		Если ВыборкаДетальныеЗаписи.Значение <> ДополнительныеСвойства.ЗначениеДо Тогда

			Если ВыборкаДетальныеЗаписи.Значение = Истина Тогда

				СписокСчетовУчетаДС = Новый СписокЗначений;
				СписокСчетовУчетаДС.Добавить(ПланыСчетов.Счета.Касса);
				СписокСчетовУчетаДС.Добавить(ПланыСчетов.Счета.СчетВБанке);

				Запрос = Новый Запрос;
				Запрос.Текст = "ВЫБРАТЬ
					|	Счета.Ссылка КАК Ссылка
					|ИЗ
					|	ПланСчетов.Счета КАК Счета
					|ГДЕ
					|	Счета.Ссылка В ИЕРАРХИИ(&СписокСчетовУчетаДС)";

				Запрос.УстановитьПараметр("СписокСчетовУчетаДС", СписокСчетовУчетаДС);

			Иначе

				Запрос = Новый Запрос;
				Запрос.Текст = "ВЫБРАТЬ
					|	СчетаВидыСубконто.Ссылка
					|ИЗ
					|	ПланСчетов.Счета.ВидыСубконто КАК СчетаВидыСубконто
					|ГДЕ
					|	СчетаВидыСубконто.ВидСубконто = &ВидСубконто";

				Запрос.УстановитьПараметр("ВидСубконто", ПланыВидовХарактеристик.ВидыСубконто.ДвиженияДенежныхСредств);

			КонецЕсли;

			РезультатЗапроса = Запрос.Выполнить();

			ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

			Пока ВыборкаДетальныеЗаписи.Следующий() Цикл

				ПС_Объект = ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();

				Если ВыборкаДетальныеЗаписи.Значение = Истина Тогда

					Если ПС_Объект.ВидыСубконто.Количество() = 2 Тогда
						Продолжить;
					КонецЕсли;

					НоваяСтрока = ПС_Объект.ВидыСубконто.Добавить();
					НоваяСтрока.ВидСубконто = ПланыВидовХарактеристик.ВидыСубконто.ДвиженияДенежныхСредств;

				Иначе

					СтрокаДляУдаления = ПС_Объект.ВидыСубконто.Найти(ПланыВидовХарактеристик.ВидыСубконто.ДвиженияДенежныхСредств, "ВидСубконто");

					ПС_Объект.ВидыСубконто.Удалить(СтрокаДляУдаления);

				КонецЕсли;

				ПС_Объект.Записать();

			КонецЦикла;

		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

Процедура ПередЗаписью(Отказ)

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
		|	УчетДДС.Значение КАК Значение
		|ИЗ
		|	Константа.УчетДДС КАК УчетДДС";

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл

		ДополнительныеСвойства.Вставить("ЗначениеДо", ВыборкаДетальныеЗаписи.Значение);

	КонецЦикла;

КонецПроцедуры
