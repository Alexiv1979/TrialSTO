#Область ОписаниеПеременных
Перем ФормаВладелец;
#КонецОбласти

&НаСервере
Функция ПолучитьТекущегоПользователянаСервере()     
	Возврат ОбщегоНазначенияКлиентСервер.ПолучитьТекущегоПользователя();
КонецФункции


&НаКлиенте
Функция ПолучитьПараметрыЗаписи()
	
	ПараметрыЗаписи = Новый Структура;
	
	Если Объект.Проведен Тогда
		ПараметрыЗаписи = Новый Структура("РежимЗаписи, РежимПроведения", РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Оперативный);
	Иначе	                                                                            
		ПараметрыЗаписи = Новый Структура("РежимЗаписи", РежимЗаписиДокумента.Запись);
	КонецЕсли;    
	
	Возврат ПараметрыЗаписи;
	
КонецФункции

&НаКлиенте
Процедура ПослеВводаЗначения(ВыбЗнач, Параметры) Экспорт
	Если ВыбЗнач<>Неопределено Тогда        
		
		Если Параметры.Свойство("ИмяЭлемента") Тогда         
	     	Объект.ПроведениеОсмотра[Элементы.ПроведениеОсмотра.ТекущаяСтрока][Параметры.ИмяЭлемента] = ВыбЗнач;  
			Объект.ПроведениеОсмотра[Элементы.ПроведениеОсмотра.ТекущаяСтрока].АвторЗаполнения = ПолучитьТекущегоПользователянаСервере();
		КонецЕсли;
    КонецЕсли;
КонецПроцедуры    

&НаСервере
Функция ЭтоВидвВодаКлавиатура(ВыбЗнач)
	Возврат ВыбЗнач = Перечисления.ВидВводаТекста.Клавиатура;	
КонецФункции	   

&НаСервере
Функция ИспользуемГолосовойВвод()
	Возврат Константы.ИспользоватьГолосовойВвод.Получить();
КонецФункции


&НаКлиенте
Асинх Функция ПолучитьРезультатРаспознаванияГолосовогоВвода()  
    СтруктураРезультата = Новый Структура("СтрокаВвода, ТочностьРаспознавания");	
	
	#Если МобильноеПриложениеКлиент Тогда   	

	
		ВнешнееПриложение = Новый ЗапускПриложенияМобильногоУстройства; 

				
		Если ВнешнееПриложение.ПоддерживаетсяЗапуск() Тогда 
			
			
			
			ВнешнееПриложение.Действие = "android.speech.action.RECOGNIZE_SPEECH";     
			
		    ВнешнееПриложение.ДополнительныеДанные.Добавить("android.speech.extra.LANGUAGE_MODEL","free_form");
		    ВнешнееПриложение.ДополнительныеДанные.Добавить("android.speech.extra.MAX_RESULTS",1);
		    ВнешнееПриложение.ДополнительныеДанные.Добавить("android.speech.extra.PROMPT","Говорите..."); 
	

			Результат =  Ждать ВнешнееПриложение.ЗапуститьАсинх();
		
			Если Результат.Кодрезультата = -1 И НЕ Результат.ДополнительныеДанные.Получить("query")  = Неопределено Тогда  
			   // // Штрихкод 				
			   //  QUERY = Результат.ДополнительныеДанные.Получить("query");     
			   //  
			   //  СтрокаВвода = QUERY.Значение;    
			   //ТочностьРаспознавания = Результат.ДополнительныеДанные.Получить("android.speech.extra.CONFIDENCE_SCORES").Значение[0];
			   //  
			   //  СтруктураРезультата.СтрокаВвода = СтрокаВвода;
			   //  СтруктураРезультата.ТочностьРаспознавания = ТочностьРаспознавания;

				 
			 
				 
				 //ТипШтрихКода = "";          
				 //
				 //Если НЕ Результат.ДополнительныеДанные.Получить("SCAN_RESULT_FORMAT")  = Неопределено Тогда  
				 //    SCAN_RESULT_FORMAT  = Результат.ДополнительныеДанные.Получить("SCAN_RESULT_FORMAT");   
				 //    
				 //    ТипШтрихКода = SCAN_RESULT_FORMAT.Значение; 
				 //КонецЕсли;
				 //
				 //ОбщегоНазначенияКлиентСервер.СообщениеПользователю("Тип штрихкода: " + ТипШтрихКода);

			 КонецЕсли; 		 
			
		 КонецЕсли;  
	 #КонецЕсли

  	Возврат СтруктураРезультата;
	
КонецФункции

&НаКлиенте
Процедура ПослеВыбораВидаВводаТекстаЗначения(ВыбЗнач, Параметры) Экспорт
	Если ВыбЗнач<>Неопределено Тогда        
		
		
		ТекСтрока = Параметры.ТекСтрока;  
		ИмяЭлемента = Параметры.ИмяЭлемента;  
		Если ЭтоВидвВодаКлавиатура(ВыбЗнач) Тогда // = Перечисления.ВидВводаТекста.Клавиатура Тогда  
			
			ВыбСостояние = Объект.ПроведениеОсмотра[ТекСтрока][ИмяЭлемента];  			
		   	Оповещение = Новый ОписаниеОповещения("ПослеВводаЗначения", ЭтотОбъект, Параметры);

			ПоказатьВводЗначения(Оповещение, ВыбСостояние, "Введите комментарий", Тип("Строка"));       
			
		Иначе      
			
		//	Результат = Новый Структура("Строка, Точность", Новый Массив, 0);

			
			#Если МобильноеПриложениеКлиент Тогда 
						
	//			СтруктураРезультата = ПолучитьРезультатРаспознаванияГолосовогоВвода();
			
			
			
				//СтрокаВвода = СтруктураРезультата.Значение;
				//ТочностьРаспознавания = Структурарезультата.ТочностьРаспознавания;
				
			//	ВнешнееПриложение = Новый ЗапускПриложенияМобильногоУстройства; 
			//
			//	Если ВнешнееПриложение.ПоддерживаетсяЗапуск() Тогда 
			//		ВнешнееПриложение.Действие = "android.speech.action.RECOGNIZE_SPEECH";

			//		 				
			//	
			//		Результат =  Ждать ВнешнееПриложение.ЗапуститьАсинх();
			//	
			//		Если Результат.Кодрезультата = -1 И НЕ Результат.ДополнительныеДанные.Получить("query")  = Неопределено Тогда  
			//			 Штрихкод 				
			//			 QUERY = Результат.ДополнительныеДанные.Получить("query");     
			//			 
			//			 СтрокаВвода = QUERY.Значение;    
			//		 	 ТочностьРаспознавания = Результат.ДополнительныеДанные.Получить("android.speech.extra.CONFIDENCE_SCORES").Значение[0];

			//			 
			//			 ТипШтрихКода = "";          
			//			 
			//			 Если НЕ Результат.ДополнительныеДанные.Получить("SCAN_RESULT_FORMAT")  = Неопределено Тогда  
			//			     SCAN_RESULT_FORMAT  = Результат.ДополнительныеДанные.Получить("SCAN_RESULT_FORMAT");   
			//			     
			//			     ТипШтрихКода = SCAN_RESULT_FORMAT.Значение; 
			//			 КонецЕсли;
			//			 
			//			 ОбщегоНазначенияКлиентСервер.СообщениеПользователю("Тип штрихкода: " + ТипШтрихКода);

			//		 КонецЕсли; 		 
			//		
			//	КонецЕсли;

			//
			
			
		     
			
				//НовВз = Новый ЗапускПриложенияМобильногоУстройства("android.speech.action.RECOGNIZE_SPEECH");
				//Результат = НовВз.Запустить(Истина);
				//Если Результат = 0 Тогда
				//Возврат;
				//КонецЕсли;
				//                
				//СтрокаВвода = НовВз.ДополнительныеДанные.Получить("query").Значение;
				//ТочностьРаспознавания = НовВз.ДополнительныеДанные.Получить("android.speech.extra.CONFIDENCE_SCORES").Значение[0];
			     #КонецЕсли

			
		КонецЕсли;
		
		
	    КонецЕсли;
КонецПроцедуры



&НаКлиенте
Процедура ПроведениеОсмотраВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	 //Вставить содержимое обработчика.       
	
	
	СтандартнаяОбработка = Ложь;  

	Если Элемент <> Неопределено Тогда   
		
		ИмяТекущегоЭлемента = Элемент.ТекущийЭлемент.Имя;
		
		Если СтрНайти(ИмяТекущегоЭлемента, "Состояние") > 0 Тогда  
			ИмяЭлемента = "Состояние";
			ИмяТаблицы = СтрЗаменить(ИмяТекущегоЭлемента, ИмяЭлемента, "");    
			
		ИначеЕсли СтрНайти(ИмяТекущегоЭлемента, "Комментарий") > 0  Тогда      
			ИмяЭлемента = "Комментарий";
			ИмяТаблицы = СтрЗаменить(ИмяТекущегоЭлемента, ИмяЭлемента, "");    
			
		Иначе
			Возврат;
		КонецЕсли;  
		
		ВыбСостояние = ЭтаФОрма[ИмяТаблицы][Элемент.ТекущаяСтрока][ИмяЭлемента]; 	

			
		ДопПараметры = Новый Структура("ИмяЭлемента, ТекСтрока", ИмяЭлемента, Элемент.ТекущаяСтрока);
	   	Оповещение = Новый ОписаниеОповещения("ПослеВводаЗначения", ЭтотОбъект, ДопПараметры);    	
	  	ОповещениеВидаВыбораТекста = Новый ОписаниеОповещения("ПослеВыбораВидаВводаТекстаЗначения", ЭтотОбъект, ДопПараметры);
		
		ФормаДобавления = ПолучитьФорму("Документ.ЗаказНаряд.Форма.ФормаДобавленияКомментария", , ЭтаФорма, "ДобавитьКомментарийВСтроку");       
		ФормаДобавления.ТолькоПросмотр = ЭтаФорма.ТолькоПросмотр;
		ФормаДобавления.ОбъектОтбора = ЭтотОбъект.Объект.Ссылка;  
		ФормаДобавления.ИмяТаблицы = ИмяТаблицы;
		ФормаДобавления.НомерСтрокиОтбора = Элемент.ТекущаяСтрока;  
		ФормаДобавления.СостояниеОсмотра = Элемент.ТекущиеДанные.Состояние;                                              
		ФормаДобавления.Комментарий = Элемент.ТекущиеДанные.Комментарий;                                              
		ФормаДобавления.ВидПроводимогоОсмотра = Элемент.ТекущиеДанные.ВидПроводимогоОсмотра; 		
		ФормаДобавления.ИдентификаторыПрисоединенныхФайлов = Элемент.ТекущиеДанные.ИдентификаторыПрисоединенныхФайлов;
		ФормаДобавления.Открыть();

		
		


		
		
		
	//	Если Элемент.ТекущийЭлемент.Имя = "ПроведениеОсмотраСостояние" Тогда  		
	//		ИмяЭлемента = "Состояние";
	//	ИначеЕсли Элемент.ТекущийЭлемент.Имя = "ПроведениеОсмотраКомментарий" Тогда			
	//		ИмяЭлемента = "Комментарий";         
	//	Иначе
	//		Возврат;
	//	КонецЕсли;      
	//	
	//	ВыбСостояние = Объект.ПроведениеОсмотра[Элемент.ТекущаяСтрока][ИмяЭлемента]; 
	//		
	//	ДопПараметры = Новый Структура("ИмяЭлемента, ТекСтрока", ИмяЭлемента, Элемент.ТекущаяСтрока);
	//   	Оповещение = Новый ОписаниеОповещения("ПослеВводаЗначения", ЭтотОбъект, ДопПараметры);    	
	//  	ОповещениеВидаВыбораТекста = Новый ОписаниеОповещения("ПослеВыбораВидаВводаТекстаЗначения", ЭтотОбъект, ДопПараметры);


	//
	//	//Если ИмяЭлемента = "Состояние" Тогда      
	//	//	ПоказатьВводЗначения(Оповещение, ВыбСостояние, "Выберите состояние", Тип("ПеречислениеСсылка.ВидыСостоянийОсмотра"));  			
	//	//ИначеЕсли ИмяЭлемента = "Комментарий" Тогда                       
	//		
	//		//Если ИспользуемГолосовойВвод() Тогда
	//		//	ПоказатьВводЗначения(ОповещениеВидаВыбораТекста, ВыбСостояние, "Выберите вид ввода текста", Тип("ПеречислениеСсылка.ВидВводаТекста"));       
	//		//Иначе	                                                                                                                                         
	//		//	ПоказатьВводЗначения(Оповещение, ВыбСостояние, "Введите комментарий", Тип("Строка"));             
	//		//КонецЕсли;                                                                                          
	//		//СтруктураПараметров = Новый Структура;
	//		//СтруктураПараметров.Вставить("ОбъектОтбора", ЭтотОбъект.Объект.Ссылка); 
	//		//СтруктураПараметров.Вставить("НомерСтрокиОтбора", Элемент.ТекущаяСтрока);  
	//		//СтруктураПараметров.Вставить("ИдентификаторыПрисоединенныхФайлов", Элемент.ТекущиеДанные.ИдентификаторыПрисоединенныхФайлов);  
	//					
	//		ФормаДобавления = ПолучитьФорму("Документ.ЗаказНаряд.Форма.ФормаДобавленияКомментария", , ЭтаФорма, "ДобавитьКомментарийВСтроку");
	//		ФормаДобавления.ОбъектОтбора = ЭтотОбъект.Объект.Ссылка;
	//		ФормаДобавления.НомерСтрокиОтбора = Элемент.ТекущаяСтрока;  
	//		ФормаДобавления.СостояниеОсмотра = Элемент.ТекущиеДанные.Состояние;                                              
	//		ФормаДобавления.Комментарий = Элемент.ТекущиеДанные.Комментарий;                                              
	//		ФормаДобавления.ВидПроводимогоОсмотра = Элемент.ТекущиеДанные.ВидПроводимогоОсмотра; 		
	//		ФормаДобавления.ИдентификаторыПрисоединенныхФайлов = Элемент.ТекущиеДанные.ИдентификаторыПрисоединенныхФайлов;
	//		ФормаДобавления.Открыть();
	//		

	//		// 
	//		//
	//		//СтрокаИменФайлов = ОткрытьФормуДобавленияКомментария( , Элемент.ТекущаяСтрока); 
	//		
	//	//КонецЕсли;	
	//	
	КонецЕсли;   

КонецПроцедуры 

&НаСервере
Функция ОткрытьФормуДобавленияКомментария(ДокСсылка, ТекСтрока)    
	//Форма = ПолучитьОбщуюФорму("ОбщаяФорма.ФормаДобавленияКомментария", ЭтаФорма, "ДобавитьКомментарийВСтроку");
	//	
	//Форма.ОбъектОтбора = ДокСсылка;
	//Форма.НомерСтрокиОтбора = ТекСтрока;                      
	//
	//СтрокаИменФайлов = Форма.ОткрытьМодально();                       
	//
	//Возврат "";     
	
	
	
КонецФункции
	

//&НаСервере
//Процедура СинхронизацияДанныхнаСервере()       
//	результатВыполнения = ОбщегоНазначенияСервер.ВыполнитьСинхронизациюНаСервере();	
//КонецПроцедуры               

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)    
	
	Если ЭтаФорма.ТолькоПросмотр Тогда
		Отказ = Истина;
	КонецЕсли;

	СтруктураДокумента = Новый Структура("ВидДока, ГУИД", "ЗаказНаряд", СокрЛП(Объект.ГУИД));      	

	Если ТекСтатус = "" ИЛИ ТекСтатус = "ЗавершеноРедактирование" 
		ИЛИ ТекСтатус = "Редактируется"	Тогда
    	Если ЭтаФорма.Модифицированность Тогда         
			ТекСтатус = "Изменен";	
		Иначе	                                                                                                     
			ТекСтатус = "ЗавершеноРедактирование";		
		КонецЕсли;
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьОсмотр(Команда)      
	ЗаписатьДокумент();

	ЗакончилиОсмотр = УстановитьЗавершениеОсмотраНаСервере();  
	Если ЗакончилиОсмотр Тогда
		
		ЗавершениеОсмотра = Истина;
		
		Если ЭтаФорма.Открыта() Тогда
			ЭтаФорма.Закрыть();           
		КонецЕсли;
		
 		// Обновляем         
		результатВыполнения = ОбщегоНазначенияСервер.ВыполнитьСинхронизациюНаСервере(Объект.Ссылка);	

		//СинхронизацияДанныхнаСервере();	  
		
		СтруктураДокумента = Новый Структура("ВидДока, ГУИД", "ЗаказНаряд", СокрЛП(Объект.ГУИД));      	
		//РезультатУстановкиСтатуса = УстановитьСтатусДокументаВАльфа(СтруктураДокумента, "ОбновленВЦБ");  
		
		РезультатУстановкиСтатуса =  ОбщегоНазначенияСервер.УстановитьСтатусДокументаВАльфа(СтруктураДокумента, "ОбновленВЦБ");
			
		Если ЭтаФорма.ВладелецФормы.Имя = "ТаблицаЗаказНарядов" Тогда    
			ЭтаФорма.ВладелецФормы.Обновить();   		
		КонецЕсли;                               		
	КонецЕсли;
	
КонецПроцедуры   

&НаКлиенте
Процедура ОбновитьДоступностьРеквизитов()
	
	//Если ОсмотрЗавершен = Неопределено Тогда  
	//	 ОсмотрЗавершен = ОсмотрЗавершен();		
	// КонецЕсли;   
	// 
	// //ЭтаФорма.ТолькоПросмотр = ОсмотрЗавершен;		
	// ЭтаФорма.Элементы.ПроведениеОсмотра.Доступность = НЕ ОсмотрЗавершен;
	// ЭтаФорма.Элементы.ЗавершитьОсмотр.Доступность = НЕ ОсмотрЗавершен;    
	
	Элементы.Состояние.Доступность = СостояниеДоступноДляРедактирования();
		
	 
КонецПроцедуры


&НаСервере 
Функция СостояниеДоступноДляРедактирования()   
	Если Объект.Состояние = Справочники.ВидыСостоянийЗаказНарядов.Заявка
		ИЛИ Объект.Состояние = Справочники.ВидыСостоянийЗаказНарядов.НачатьРаботу
		ИЛИ Объект.Состояние = Справочники.ВидыСостоянийЗаказНарядов.ВРаботе Тогда
		Возврат Истина;
	Иначе	                                    
		Возврат Ложь;
	КонецЕсли;

	
КонецФункции

&НаСервере 
Функция УстановитьЗавершениеОсмотраНаСервере()     
	
	
	Если НЕ ПроверитьЗаполнение() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Объект.СостояниеОсмотра = Перечисления.СостоянияОсмотра.ОсмотрЗавершен; 
	Объект.ДатаОкончанияОсмотра = ТекущаяДата();
	
	ДокОбъект = ДанныеФормыВЗначение(Объект, Тип("ДокументОбъект.ЗаказНаряд")); 
	
	Попытка
		ДокОбъект.записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);     
	//	ЗначениеВДанныеФорм ы(ДокОбъект, Объект);	
	
		ЗначениеВДанныеФормы(ДокОбъект, Объект);
	
	// Регистрируем для обмена        
		УзелОбменаЦентральнойБазы = Константы.УзелДляОбменаСЦентральнойБазой.Получить();
		ПланыОбмена.ЗарегистрироватьИзменения(УзелОбменаЦентральнойБазы, ДокОбъект.Ссылка);		
		
		Возврат Истина;
	Исключение	  
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = ОписаниеОшибки();
		Сообщение.Сообщить();
		Возврат Ложь;
	КонецПопытки;
КонецФункции

&НаСервере
Функция ОсмотрЗавершен()
	Возврат	Объект.СостояниеОсмотра = Перечисления.СостоянияОсмотра.ОсмотрЗавершен;
КонецФункции

//&НаСервере
//Функция ЭтоТестовыйРежимНаСервере()
//	Возврат ОбщегоНазначенияСервер.ЭтоТестовыйРежим();	
//КонецФункции

&НаКлиенте
Процедура ПриОткрытии(Отказ)       
	
	ФормаВладелец = ЭтаФорма.ВладелецФормы;
	
	ОбновитьДоступностьРеквизитов();   
	
	// Обновляем статус редактирования документа В Альфа                             
	
	СтруктураДокумента = Новый Структура("ВидДока, ГУИД", "ЗаказНаряд", СокрЛП(Объект.ГУИД));      	
	
//	Если ЭтоТестовыйРежимНаСервере() Тогда                                                         
	Если ОбщегоНазначенияСервер.ЭтоТестовыйРежим() Тогда 
		ЭтаФорма.ТолькоПросмотр = Ложь;     
		Элементы.ЗавершитьОсмотр.Доступность = Истина;               
	Иначе	
		РезультатУстановкиСтатуса = ОбщегоНазначенияСервер.УстановитьСтатусДокументаВАльфа(СтруктураДокумента, "Редактируется");     
		ТекСтатус = РезультатУстановкиСтатуса.ТекущийСтатус;	
		
		ЭтаФорма.ТолькоПросмотр = РезультатУстановкиСтатуса.ТолькоПросмотр;     
		Элементы.ЗавершитьОсмотр.Доступность = НЕ РезультатУстановкиСтатуса.ТолькоПросмотр;    
		
		Элементы.НоваяРаботаДляСогласования.Доступность = НЕ РезультатУстановкиСтатуса.ТолькоПросмотр;    
		Элементы.ДобавитьНовуюРаботу.Доступность = НЕ РезультатУстановкиСтатуса.ТолькоПросмотр;    
		Элементы.ОтменитьДобавлениеРаботы.Доступность = НЕ РезультатУстановкиСтатуса.ТолькоПросмотр; 
		
		Элементы.ПроведениеОсмотраПриемка.ТолькоПросмотр = ЭтаФорма.ТолькоПросмотр;
		Элементы.ПроведениеОсмотраЦех.ТолькоПросмотр = ЭтаФорма.ТолькоПросмотр;
	КонецЕсли;
	
	Элементы.кнПоказатьТаблицуОсмотр.Пометка = Ложь;
	ОбновитьТаблицыОсмотра();
КонецПроцедуры       


&НаСервере
Процедура ОбновитьТаблицыОсмотра()
	
	Запрос = Новый Запрос;	
	Запрос.Текст = "ВЫБРАТЬ
	|	НастройкиДоступаВидовПроводимогоОсмотра.ВидПроводимогоОсмотра КАК ВидПроводимогоОсмотра,
	|	НастройкиДоступаВидовПроводимогоОсмотра.ВидСотрудникаСервиса КАК ВидСотрудникаСервиса
	|ИЗ
	|	РегистрСведений.НастройкиДоступаВидовПроводимогоОсмотра КАК НастройкиДоступаВидовПроводимогоОсмотра";
	
	ВремТЗ = Запрос.Выполнить().Выгрузить();

	ПроведениеОсмотраПриемка.Очистить();     
	ПроведениеОсмотраЦех.Очистить();
	
	Для каждого ТекСтрока ИЗ Объект.ПроведениеОсмотра Цикл
		НайденнаяСтрока = ВремТЗ.Найти(ТекСтрока.ВидПроводимогоОсмотра, "ВидПроводимогоОсмотра");
		
		Если НайденнаяСтрока = Неопределено Тогда
			Продолжить;
		Иначе
			Если НайденнаяСтрока.ВидСотрудникаСервиса = Перечисления.ВидыСотрудниковСервиса.МастерПриемщик Тогда			
				НовСтрока = ПроведениеОсмотраПриемка.Добавить();
			Иначе                                                                                               		
				НовСтрока = ПроведениеОсмотраЦех.Добавить();	
			КонецЕсли;    
			
			Если СокрЛП(ТекСтрока.ИдентификаторСтроки) = "" Тогда
				ТекСтрока.ИдентификаторСтроки = СокрЛП(Новый УникальныйИдентификатор());
			КонецЕсли;  			
			ЗаполнитьЗначенияСвойств(НовСтрока, ТекСтрока);  
			
			НовСтрока.НомСтроки = ТекСтрока.НомерСтроки;     
					
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

//&НаСервере
//Функция УстановитьСтатусДокументаВАльфа(СтруктураДокумента, Статус) 
//	Возврат ОбщегоНазначенияСервер.УстановитьСтатусДокументаВАльфа(СтруктураДокумента, Статус);	
//КонецФункции

&НаСервере
Функция ДобавитьРаботуНаСогласование(СостояниеОсмотра, ИдентификаторСтроки)       
	
	КорректныйВидСостояния = СостояниеОсмотра = Перечисления.ВидыСостоянийОсмотра.Удов ИЛИ СостояниеОсмотра = Перечисления.ВидыСостоянийОсмотра.Крит;
	
	Если НЕ КорректныйВидСостояния Тогда
		Возврат КорректныйВидСостояния;
	КонецЕсли;                         
	
	 // проверяем что нет доабвленных работа с по текущзему виду осмотра
	НайденныеСтроки = Объект.СогласованиеРабот.НайтиСтроки(Новый Структура("ИдентификаторСтрокиОсмотра", ИдентификаторСтроки));
	
	Возврат НайденныеСтроки.Количество() = 0;	
	
КонецФункции

&НаСервере
Функция ПолучитьТекущегоПользователя()                                   
	 Возврат ОбщегоНазначенияКлиентСервер.ПолучитьТекущегоПользователя();
КонецФункции

&НаКлиенте
Асинх Процедура ДобавитьНовуюРаботуНаСогласование(Комментарий)      
	ВыбСтрока = СокрЛП(Ждать ВвестиСтрокуАсинх(Комментарий, "Добавить работу", 500));
	
	Если ЗначениеЗаполнено(ВыбСтрока) Тогда 
		
		НовСтрокаСогласование = Объект.СогласованиеРабот.Добавить();
		НовСтрокаСогласование.Работы =  ВыбСтрока;
		НовСтрокаСогласование.АвторРабот = ПолучитьТекущегоПользователя();
		НовСтрокаСогласование.ДатаРабот = ТекущаяДата();
		
	КонецЕсли;
	         	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	//Вставить содержимое обработчика    
	
	Если ВыбранноеЗначение.ФормаРедактирования = "ДобавлениеКомментария" Тогда	        
		ТекущиеДанные = Элементы[ВыбранноеЗначение.ИмяТаблицы].ТекущиеДанные; 
		
				
		ТекущиеДанные.Состояние = ВыбранноеЗначение.СостояниеОсмотра;
		ТекущиеДанные.Комментарий = ВыбранноеЗначение.Комментарий;
		ТекущиеДанные.ИдентификаторыПрисоединенныхФайлов = ВыбранноеЗначение.ИдентификаторыПрисоединенныхФайлов;  
		
		// Пока закрыл добавление рабоыт на согласование
		//Если ДобавитьРаботуНаСогласование(ВыбранноеЗначение.СостояниеОсмотра, ТекущиеДанные.ИдентификаторСтроки)
		//	И НЕ ЭтаФорма.ТолькоПросмотр Тогда		
		//	
		//	НоваяРаботаДляСогласования = ВыбранноеЗначение.Комментарий;  		
		//	 
		//	ИдентификаторСтрокиОсмотра = ТекущиеДанные.ИдентификаторСтроки;    
		//	
		//	ЭтаФорма.Элементы.ПанельФормы.ТекущаяСтраница = Элементы.СтраницаСогласованиеРабот;	
		//	
		//КонецЕсли;      
		
	ИначеЕсли ВыбранноеЗначение.ФормаРедактирования = "ИзменитьСтатусСогласованияРабот" Тогда       
		
		Элементы.СогласованиеРабот.ТекущиеДанные.АвторСогласования  = ВыбранноеЗначение.АвторСогласования;
		Элементы.СогласованиеРабот.ТекущиеДанные.ДатаСогласования  = ВыбранноеЗначение.ДатаСогласования;
		Элементы.СогласованиеРабот.ТекущиеДанные.СтатусСогласования  = ВыбранноеЗначение.СтатусСогласования;  
		Элементы.СогласованиеРабот.ТекущиеДанные.Причина = ВыбранноеЗначение.Причина;  
		Элементы.СогласованиеРабот.ТекущиеДанные.ИдентификаторыПрисоединенныхФайлов = ВыбранноеЗначение.ИдентификаторыПрисоединенныхФайлов;  
		
	ИначеЕсли ВыбранноеЗначение.ФормаРедактирования = "РедактированиеПричиныОбращения" Тогда	  
		Объект.ПричинаОбращения = ВыбранноеЗначение.ПричинаОбращения;
		
	КонецЕсли;            
	
//	Если ЭтаФорма.Модифицированность Тогда         
	//	ТекСтатус = "Изменен";	
	//Иначе	                                                                                                     
	//	ТекСтатус = "ЗавершеноРедактирование";		
	//КонецЕсли;

	ЗаписатьДокумент();	
//	МассивНаименованийФайлов = ОбщегоНазначенияКлиентСервер.РазложитьСтрокуВМассивПодстрок(ИменаПрисоединенныхФайлов, ";");
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКартинкиИФайлы(Команда)
    ОткрытьФорму("РегистрСведений.КартинкиИФайлы.ФормаСписка", Новый Структура("Объект", Объект.Ссылка), ЭтаФорма, "ОткрытьКартинкиИФайлы",,,,РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	
КонецПроцедуры

&НаКлиенте
Процедура ПричинаОбращенияНачалоВыбора(Элемент, ДанныеВыбора, ВыборДобавлением, СтандартнаяОбработка)
	ФормаРедактированияПричиныОбращения = ПолучитьФорму("Документ.ЗаказНаряд.Форма.ФормаРедактированияПричиныОбращения", , ЭтаФорма, "ДобавитьКомментарийВСтроку");
	ФормаРедактированияПричиныОбращения.ОбъектОтбора = ЭтотОбъект.Объект.Ссылка;
	ФормаРедактированияПричиныОбращения.ПричинаОбращения = СокрЛП(Элемент.ТекстРедактирования);                                              
	ФормаРедактированияПричиныОбращения.Открыть();

			
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьЗН(Команда)     
	
              
	ЭтаФорма.Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	ОбновитьДоступностьРеквизитов();

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)     
	
	СтруктураДокумента = Новый Структура("ВидДока, ГУИД", "ЗаказНаряд", СокрЛП(Объект.ГУИД));      	
		
	Если ТекСтатус = "Изменен" Тогда      
		
		Если НЕ ЗавершениеОсмотра Тогда
		
			Если НЕ ЗавершениеОсмотра Тогда
				РезультатУстановкиСтатуса = ОбщегоНазначенияСервер.УстановитьСтатусДокументаВАльфа(СтруктураДокумента, ТекСтатус);
			КонецЕсли;                 
		КонецЕсли;
		
		//Если НЕ ЭтаФорма.ТолькоПросмотр Тогда	
		//	ЗавершитьОсмотр("");
		//КонецЕсли;
		
	Иначе	
		
		Если ТекСтатус = "" ИЛИ ТекСтатус = "Редактируется" Тогда
	    	Если ЭтаФорма.Модифицированность Тогда         
				ТекСтатус = "Изменен";	
			Иначе	                                                                                                     
				ТекСтатус = "ЗавершеноРедактирование";		
			КонецЕсли;
		КонецЕсли;
		
		ЗаписатьДокумент();   
		
		Если НЕ ЭтаФорма.ТолькоПросмотр Тогда
		
			//РезультатУстановкиСтатуса = УстановитьСтатусДокументаВАльфа(СтруктураДокумента, ТекСтатус);     
			РезультатУстановкиСтатуса = ОбщегоНазначенияСервер.УстановитьСтатусДокументаВАльфа(СтруктураДокумента, ТекСтатус);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры   

&НаКлиенте
Процедура ЗаписатьДокумент()    
	Если НЕ ЭтаФорма.ТолькоПросмотр Тогда        
		
		//Заполняем таблицу Проведение просмотра из временных тьаблдц
		
		Для Каждого ТекСтрока ИЗ ПроведениеОсмотраПриемка Цикл 
			найденныеСтроки = Объект.ПроведениеОсмотра.НайтиСтроки(Новый Структура("ВидПроводимогоОсмотра", ТекСТрока.ВидПроводимогоОсмотра));
			
			Если найденныеСтроки.Количество() > 0 Тогда   
				найденныеСтроки[0].Состояние = ТекСтрока.Состояние; 
				найденныеСтроки[0].Комментарий = ТекСтрока.Комментарий; 
				найденныеСтроки[0].АвторЗаполнения = ТекСтрока.АвторЗаполнения;
				найденныеСтроки[0].ИдентификаторыПрисоединенныхФайлов = ТекСтрока.ИдентификаторыПрисоединенныхФайлов; 
				найденныеСтроки[0].ИдентификаторСтроки = ТекСтрока.ИдентификаторСтроки; 
				
				
			КонецЕсли;
		КонецЦикла;   
		
		Для Каждого ТекСтрока ИЗ ПроведениеОсмотраЦех Цикл 
			найденныеСтроки = Объект.ПроведениеОсмотра.НайтиСтроки(Новый Структура("ВидПроводимогоОсмотра", ТекСТрока.ВидПроводимогоОсмотра));
			
			Если найденныеСтроки.Количество() > 0 Тогда   
				найденныеСтроки[0].Состояние = ТекСтрока.Состояние; 
				найденныеСтроки[0].Комментарий = ТекСтрока.Комментарий; 
				найденныеСтроки[0].АвторЗаполнения = ТекСтрока.АвторЗаполнения;
				найденныеСтроки[0].ИдентификаторыПрисоединенныхФайлов = ТекСтрока.ИдентификаторыПрисоединенныхФайлов; 
				найденныеСтроки[0].ИдентификаторСтроки = ТекСтрока.ИдентификаторСтроки; 
				
				
			КонецЕсли;
		КонецЦикла;
		
		ПараметрыЗаписи = ПолучитьПараметрыЗаписи();
		Записать(ПараметрыЗаписи);              
	КонецЕсли;     	
КонецПроцедуры

&НаКлиенте
Процедура ПанельФормыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
КонецПроцедуры

&НаКлиенте
Процедура ПроведениеОсмотраЦехВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаСервере
Функция ПолучитьСтатусСогласованияНаСервере(ВыбСтатус)          
	Возврат Перечисления.Согласован[ВыбСтатус];
КонецФункции

&НаКлиенте
Процедура ДобавитьНовуюРаботу(Команда)
	Если ЗначениеЗаполнено(НоваяРаботаДляСогласования) Тогда 
		
		НовСтрокаСогласование = Объект.СогласованиеРабот.Добавить();
		НовСтрокаСогласование.Работы =  НоваяРаботаДляСогласования;
		НовСтрокаСогласование.АвторРабот = ПолучитьТекущегоПользователя();
		НовСтрокаСогласование.ДатаРабот = ТекущаяДата();    
		НовСтрокаСогласование.СтатусСогласования = ПолучитьСтатусСогласованияНаСервере("НеУказан");
		НовСтрокаСогласование.ИдентификаторСтроки = Строка(Новый УникальныйИдентификатор());
		НовСтрокаСогласование.ИдентификаторСтрокиОсмотра = ИдентификаторСтрокиОсмотра;
		
		НоваяРаботаДляСогласования = "";    
		ИдентификаторСтрокиОсмотра = "";  
		
		ЗаписатьДокумент();		
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОтменитьДобавлениеРаботы(Команда)        
	НоваяРаботаДляСогласования = "";
КонецПроцедуры

&НаКлиенте
Процедура СогласованиеРаботСтатусСогласованияПриИзменении(Элемент)
	
	
КонецПроцедуры

&НаКлиенте
Процедура СогласованиеРаботВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;  

	Если Элемент <> Неопределено Тогда   
		
		ИмяТекущегоЭлемента = Элемент.ТекущийЭлемент.Имя;
		
		Если СтрНайти(ИмяТекущегоЭлемента, "СтатусСогласования") > 0  
			ИЛИ СтрНайти(ИмяТекущегоЭлемента, "АвторРабот") > 0
			ИЛИ СтрНайти(ИмяТекущегоЭлемента, "АвторСогласования") > 0 
			ИЛИ СтрНайти(ИмяТекущегоЭлемента, "ДатаСогласования") > 0
			ИЛИ СтрНайти(ИмяТекущегоЭлемента, "Причина") > 0 Тогда  
			ИмяЭлемента = "СтатусСогласования";
	
		Иначе
			Возврат;
		КонецЕсли;  
		
		ВыбСтатусСогласования = ЭтаФОрма.Элементы.СогласованиеРабот.ТекущиеДанные[ИмяЭлемента]; 	

			
		ДопПараметры = Новый Структура("ИмяЭлемента, ТекСтрока", ИмяЭлемента, Элемент.ТекущаяСтрока);
	   	Оповещение = Новый ОписаниеОповещения("ПослеВводаЗначения", ЭтотОбъект, ДопПараметры);    	
	  	ОповещениеВидаВыбораТекста = Новый ОписаниеОповещения("ПослеВыбораВидаВводаТекстаЗначения", ЭтотОбъект, ДопПараметры);
		
		ФормаДобавления = ПолучитьФорму("Документ.ЗаказНаряд.Форма.ФормаСогласованияРабот", , ЭтаФорма, "ИзменитьСтатусСогласованияРабот");
		ФормаДобавления.ОбъектОтбора = ЭтотОбъект.Объект.Ссылка;      
		ФормаДобавления.НомерСтрокиОтбора = Элемент.ТекущаяСтрока;    	
		ФормаДобавления.Работы = Элемент.ТекущиеДанные.Работы;            
		ФормаДобавления.АвторРабот = Элемент.ТекущиеДанные.АвторРабот;        
		ФормаДобавления.ДатаРабот = Элемент.ТекущиеДанные.ДатаРабот;                
		ФормаДобавления.СтатусСогласования = Элемент.ТекущиеДанные.СтатусСогласования;          
		ФормаДобавления.АвторСогласования = Элемент.ТекущиеДанные.АвторСогласования;       
		ФормаДобавления.ДатаСогласования = Элемент.ТекущиеДанные.ДатаСогласования;     
		ФормаДобавления.Причина = СокрЛП(Элемент.ТекущиеДанные.Причина);	
		ФормаДобавления.ИдентификаторСтроки = Элемент.ТекущиеДанные.ИдентификаторСтроки;        
		ФормаДобавления.ИдентификаторСтрокиОсмотра = Элемент.ТекущиеДанные.ИдентификаторСтрокиОсмотра;   
		ФормаДобавления.ИдентификаторыПрисоединенныхФайлов = Элемент.ТекущиеДанные.ИдентификаторыПрисоединенныхФайлов;

		ФормаДобавления.Открыть();
		
	КонецЕсли;   


КонецПроцедуры

&НаКлиенте
Процедура ПоазатьТаблицуОсмотр(Команда)
	Элементы.ОсмотрГлавная.Видимость = НЕ Элементы.кнПоказатьТаблицуОсмотр.Пометка;   
	Элементы.кнПоказатьТаблицуОсмотр.Пометка = НЕ Элементы.кнПоказатьТаблицуОсмотр.Пометка;
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтатусЗавершениеРедактирования(Команда)
	// Вставить содержимое обработчика.
КонецПроцедуры


ЗавершениеОсмотра = Ложь;
