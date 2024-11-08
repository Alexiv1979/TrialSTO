
&НаКлиенте
Процедура НайтиПоШК(Команда)
	//#Если МобильныйКлиент Тогда    
	#Если МобильноеПриложениеКлиент Тогда    
		
		Если СредстваМультимедиа.ПоддерживаетсяСканированиеШтрихКодов() Тогда        
			ОповещениеСканирования = Новый ОписаниеОповещения("ОбработкаСканированногоШтрихкода", ЭтотОбъект);
			
			СредстваМультимедиа.ПоказатьСканированиеШтрихКодов("Сканирование штрикода", ОповещениеСканирования,, ТипШтрихКода.Все);  
			
			
			
		Иначе      
			ОбщегоНазначенияКлиентСервер.СообщениеПользователю("Не поддерживается сканирование штрих-кодов");		
			
		КонецЕсли;
		
		
	#КонецЕсли
КонецПроцедуры   

&НаКлиенте
Процедура ОбработкаСканированногоШтрихкода(Штрихкод, Результат, СОобщение, ДополнительныеПараметры) Экспорт  
	
	#Если МобильноеПриложениеКлиент Тогда    
		Если Результат И ЗначениеЗаполнено(Штрихкод) Тогда   
			ОбщегоНазначенияКлиентСервер.СообщениеПользователю(Штрихкод);    
			
			СредстваМультимедиа.ЗакрытьСканированиеШтрихКодов();

			
			//Номенклатура = ОбщегоНазначенияКлиентСервер.НайтиНоменклатуруПоШтрихКоду(Штрихкод);              
			//
			//Если Номенклатура = Неопределено Тогда
			//	ОбщегоНазначенияКлиентСервер.СообщениеПользователю("Штрихкод не найден");      
			//Иначе	                                
			//	Элементы.Список.Отображение = ОтображениеТаблицы.Список;
			//	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список,
			//	"Ссылка",
			//	Номенклатура,                                                                                                                                                      
			//	ВидСравненияКомпоновкиДанных.Равно,     
			//	,
			//	Истина,
			//	РежимОтображенияНастроекКомпоновкиДанных.БыстрыйДоступ);
			//	
			//	
			//КонецЕсли;     
			
					
		Иначе  
			ОбщегоНазначенияКлиентСервер.СообщениеПользователю("Ошибка сканирования штрихкода");		
		КонецЕсли;           
	#КонецЕсли

		
КонецПроцедуры 


&НаКлиенте
Асинх Процедура НайтиПоШКАндроид(Команда)
	#Если МобильноеПриложениеКлиент Тогда   
		Попытка      
			ВнешнееПриложение = Новый ЗапускПриложенияМобильногоУстройства; 
			
			Если ВнешнееПриложение.ПоддерживаетсяЗапуск() Тогда 
				ВнешнееПриложение.Действие = "com.google.zxing.client.android.SCAN";
				ВнешнееПриложение.Приложение = "com.google.zxing.client.android";
				ВнешнееПриложение.ДополнительныеДанные.Добавить("PROMT_MESSAGE", "Scan code");  
				
				
				Результат =  Ждать ВнешнееПриложение.ЗапуститьАсинх();
				
				Если Результат.Кодрезультата = -1 И НЕ Результат.ДополнительныеДанные.Получить("SCAN_RESULT")  = Неопределено Тогда  
					// Штрихкод 				
					 SCAN_RESULT = Результат.ДополнительныеДанные.Получить("SCAN_RESULT");     
					 ОбщегоНазначенияКлиентСервер.СообщениеПользователю("Штрихкод: " + SCAN_RESULT.Значение);

					 
					 ТипШтрихКода = "";          
					 
					 Если НЕ Результат.ДополнительныеДанные.Получить("SCAN_RESULT_FORMAT")  = Неопределено Тогда  
						 SCAN_RESULT_FORMAT  = Результат.ДополнительныеДанные.Получить("SCAN_RESULT_FORMAT");   
						 
						 ТипШтрихКода = SCAN_RESULT_FORMAT.Значение; 
					 КонецЕсли;
					 
					 ОбщегоНазначенияКлиентСервер.СообщениеПользователю("Тип штрихкода: " + ТипШтрихКода);

				 КонецЕсли; 
			КонецЕсли;
				
			Исключение     
				ОбщегоНазначенияКлиентСервер.СообщениеПользователю(ОписаниеОшибки());
		КонецПопытки;
		
		//ОбщегоНазначенияКлиентСервер.СообщениеПользователю("Не поддерживается сканирование штрих-кодов");
		//Если СредстваМультимедиа.ПоддерживаетсяСканированиеШтрихКодов() Тогда        
		//	ОповещениеСканирования = Новый ОписаниеОповещения("ОбработкаСканированногоШтрихкода", ЭтотОбъект);
		//	
		//	СредстваМультимедиа.ПоказатьСканированиеШтрихКодов("Сканирование штрикода", ОповещениеСканирования,, ТипШтрихКода.Все);
		//Иначе      
		//	ОбщегоНазначенияКлиентСервер.СообщениеПользователю("Не поддерживается сканирование штрих-кодов");		
		//	
		//КонецЕсли;
		
		
	#КонецЕсли
КонецПроцедуры

