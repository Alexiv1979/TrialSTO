&НаКлиенте
Процедура СделатьФото(Команда)
	
	 ДанныеФото = ПолучитьДанныеФотоСнимка();    
	 
	 ЗаписатьВРегистрСведений(ДанныеФото);


КонецПроцедуры


&НаКлиенте
Процедура ЗаписатьАудио(Команда)
	ДанныеАудио = ПолучитьДанныеАудио();   
	ЗаписатьВРегистрСведений(ДанныеАудио);

КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьВидео(Команда)
	ДанныеВидео = ПолучитьДанныеВидео();     
	
	ЗаписатьВРегистрСведений(ДанныеВидео);

КонецПроцедуры  

&НаКлиенте
Функция ПолучитьДанныеФотоСнимка()

         Данные = Неопределено;

        #Если МобильноеПриложениеКлиент Тогда 
 
             Если СредстваМультимедиа.ПоддерживаетсяФотоснимок() Тогда

				   //ТипКамерыДанные = ОбщегоНазначенияСервер.ПолучитьЗначениеКонстанты("ТипКамеры");
				   //Если ТипКамерыДанные = ПредопределенноеЗначение("Перечисление.ТипКамеры.Задняя")   Тогда
                        ТипКамеры = ТипКамерыУстройства.Задняя;
				   //ИначеЕсли ТипКамерыДанные =  ПредопределенноеЗначение("Перечисление.ТипКамеры.Передняя") Тогда
				   //     ТипКамеры = ТипКамерыУстройства.Передняя;
				   //Иначе
				   //     ТипКамеры = ТипКамерыУстройства.Авто;
				   //КонецЕсли;

                  РазрешениеВысота = ПолучитьЗначениеКонстанты("РазрешениеФотоВысота");
                  РазрешениеШирина = ПолучитьЗначениеКонстанты("РазрешениеФотоШирина");

                 //для устройств IOS этот параметр игнорируется
                 пКачество = ПолучитьЗначениеКонстанты("КачествоФото");
                 Если пКачество = 0 Тогда
                      пКачество = 100;
                 КонецЕсли;

                 Если РазрешениеВысота <> 0 И РазрешениеШирина <> 0 Тогда
                       РазрешениеКамеры = Новый РазрешениеКамерыУстройства;
                       РазрешениеКамеры.Высота = РазрешениеВысота;
                       РазрешениеКамеры.Ширина = РазрешениеШирина;
                       Данные = СредстваМультимедиа.СделатьФотоснимок(ТипКамеры, РазрешениеКамеры, пКачество); 

                 Иначе
                       Данные = СредстваМультимедиа.СделатьФотоснимок(ТипКамеры, , пКачество); 
                 КонецЕсли; 

              	  Возврат Данные; 
                Иначе 
                    Сообщить("Данное устройство не поддерживает фотоснимок!") 
                КонецЕсли; 
 
                #КонецЕсли

               Возврат Данные;

		   КонецФункции                  
 	   
&НаКлиенте
Функция ПолучитьДанныеАудио()

         Данные = Неопределено;

        #Если МобильноеПриложениеКлиент Тогда 
 
			Если СредстваМультимедиа.ПоддерживаетсяАудиозапись() Тогда  
				
				Данные = СредстваМультимедиа.СделатьАудиозапись(, Истина, Истина);          
				
			  	
			 			 
			 
				//Оповещение = Новый ОписаниеОповещения("ПослеОстановкиЗаписиАудио", ЭтотОбъект, Параметры);

				//	
				//СредстваМультимедиа.ВключитьАудиозапись(Оповещение, , РасположениеКнопкиОстановкиЗаписиМультимедиа.Авто);

				
			КонецЕсли; 
 
                #КонецЕсли

            Возврат Данные;
		КонецФункции   
		
		
&НаСервереБезКонтекста
Функция ПолучитьКачествоВидеоСтрокой()    
	ВремКачествоВидеозаписи = Константы.КачествоВидезаписи.Получить();   
	
	Если ВремКачествоВидеозаписи = Перечисления.КачествоВидеозаписи.Низкое Тогда  
		Возврат "Низкое";
	ИначеЕсли ВремКачествоВидеозаписи = Перечисления.КачествоВидеозаписи.Высокое Тогда  
		Возврат "Высокое";
	Иначе
		Возврат "Авто";
	КонецЕсли;            
	             
	
КонецФункции

&НаКлиенте
Функция ПолучитьДанныеВидео()
	
	Данные = Неопределено;
	
	#Если МобильноеПриложениеКлиент Тогда 
		
		Если СредстваМультимедиа.ПоддерживаетсяВидеозапись() Тогда     
			
			КачествоВидеозаписиЗначение = КачествоВидеозаписи.Авто;
			КачествоВидеозаписиЗначениеСтрокой = ПолучитьКачествоВидеоСтрокой();
			
			
			Если КачествоВидеозаписиЗначениеСтрокой = "Низкое" Тогда 			
				КачествоВидеозаписиЗначение = КачествоВидеозаписи.Низкое;
			ИначеЕсли КачествоВидеозаписиЗначениеСтрокой = "Высокое" Тогда 			
				КачествоВидеозаписиЗначение = КачествоВидеозаписи.Высокое;
			КонецЕсли;          			
				
			Данные = СредстваМультимедиа.СделатьВидеозапись(ТипКамерыУстройства.Авто, КачествоВидеозаписиЗначение);    
			
		КонецЕсли; 
		
	#КонецЕсли
	
	Возврат Данные;
	
КонецФункции   

&НаСервере   
Функция ПолучитьЗначениеКонстанты(ИмяКонстанты)      
	 Возврат ОбщегоНазначенияКлиентСервер.ПолучитьЗначениеКонстанты(ИмяКонстанты);     
 КонецФункции   

&НаКлиенте
Процедура ЗаписатьВРегистрСведений(ДанныеФайла)   
	Если ДанныеФайла <> Неопределено Тогда 
		
		ИдентификаторФайла = "";
		
	//	ПрефиксФайла = СтрЗаменить(ИмяТаблицы, "ПроведениеОсмотра", "");
		
		ДвоичныеДанные= ДанныеФайла.ПолучитьДвоичныеДанные();  		
		СтруктураОписанияОбъекта = Новый Структура("РасширениеФайла, ТипСодержимого, ДвоичныеДанные, ПрефиксФайла",  ДанныеФайла.РасширениеФайла, ДанныеФайла.ТипСодержимого, ДвоичныеДанные, ПрефиксФайла);
		РезультатДобавления = ЗаписатьВРегистрСведенийНаСервере(ОбъектОтбора, СтруктураОписанияОбъекта, ИдентификаторФайла);

		
		ДобавитьИдентификаторВМассив(ИдентификаторФайла);  
		
		ОбновитьОтборКартинкиИФайлы();
				
	//	Элементы.Список.Обновить();
	КонецЕсли;
	
КонецПроцедуры      

&НаСервереБезКонтекста
Функция ЗаписатьВРегистрСведенийНаСервере(ОбъектОтбора, СтруктураОписанияОбъекта, ИдентификаторФайла = "")
	Возврат РегистрыСведений.КартинкиИФайлы.ДобавленаЗаписьВРегистрСведений(ОбъектОтбора, СтруктураОписанияОбъекта, ИдентификаторФайла);     	      
	
КонецФункции

&НаКлиенте
Функция ОбновитьОтборКартинкиИФайлы();   
	
	СписокИдентификаторов = ПолучитьСписокИдентификаторов();    
	
	ЭлементОтбораПоОбъекту = Неопределено;
	ЭлементОтбораПоИдентификатору = Неопределено;     	
	
	Для каждого ТекЭлемент ИЗ КартинкиИФайлы.Отбор.Элементы Цикл  
		
		Если ТекЭлемент.ЛевоеЗначение    = Новый ПолеКомпоновкиДанных("Объект") Тогда    
			ЭлементОтбораПоОбъекту = ТекЭлемент;                                         
		ИначеЕсли ТекЭлемент.ЛевоеЗначение    = Новый ПолеКомпоновкиДанных("Идентификатор") Тогда    
			ЭлементОтбораПоИдентификатору = ТекЭлемент;	
		КонецЕсли;   		         		
	КонецЦикла;        
	
	Если ЭлементОтбораПоИдентификатору = Неопределено Тогда 
		ЭлементОтбораПоОбъекту  = КартинкиИФайлы.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	КонецЕсли;
	
	Если ЭлементОтбораПоИдентификатору = Неопределено Тогда 
		ЭлементОтбораПоИдентификатору  = КартинкиИФайлы.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	КонецЕсли;
		
	
	
	// Устаналвиваем отбор по объекту
	ЭлементОтбораПоОбъекту.ЛевоеЗначение    = Новый ПолеКомпоновкиДанных("Объект");
    ЭлементОтбораПоОбъекту.ВидСравнения     = ВидСравненияКомпоновкиДанных.Равно;
    ЭлементОтбораПоОбъекту.Использование    = Истина;
    ЭлементОтбораПоОбъекту.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
    ЭлементОтбораПоОбъекту.ПравоеЗначение   = ОбъектОтбора;
	
	// Устаналвиваем отбор по идентификатору             
	
	Если СписокИдентификаторов.Количество() = 0 Тогда                                                
		ЭлементОтбораПоИдентификатору.ЛевоеЗначение    = Новый ПолеКомпоновкиДанных("Идентификатор");
	    ЭлементОтбораПоИдентификатору.ВидСравнения     = ВидСравненияКомпоновкиДанных.Равно;
	    ЭлементОтбораПоИдентификатору.Использование    = Истина;
	    ЭлементОтбораПоИдентификатору.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	    ЭлементОтбораПоИдентификатору.ПравоеЗначение   = "";         	     

	Иначе	
		ЭлементОтбораПоИдентификатору.ЛевоеЗначение    = Новый ПолеКомпоновкиДанных("Идентификатор");
	    ЭлементОтбораПоИдентификатору.ВидСравнения     = ВидСравненияКомпоновкиДанных.ВСписке;
	    ЭлементОтбораПоИдентификатору.Использование    = Истина;                                     		
	    ЭлементОтбораПоИдентификатору.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	    ЭлементОтбораПоИдентификатору.ПравоеЗначение   = СписокИдентификаторов;         	     
	КонецЕсли;	
	
КонецФункции

&НаСервере
Процедура ДобавитьИдентификаторВМассив(ИдентификаторФайла)     
	РазделительМассива = ";";
	
	МассивИдентификаторов =  РазложитьСтрокуВМассивПодстрок(ИдентификаторыПрисоединенныхФайлов, РазделительМассива);
	
	Если МассивИдентификаторов.Найти(ИдентификаторФайла) = Неопределено Тогда
		МассивИдентификаторов.Добавить(ИдентификаторФайла);   	
	КонецЕсли;                                
	
	
	ТекСтрока = "";
	Для Каждого ТекЭлемент ИЗ МассивИдентификаторов Цикл
		ТекСтрока = ТекСтрока + ?(ТекСтрока = "", "", РазделительМассива)+ СокрЛП(ТекЭлемент);
	КонецЦикла;                                                                  
		
		
	ИдентификаторыПрисоединенныхФайлов = ТекСтрока;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьСписокИдентификаторов()
	МассивИдентификаторов =  РазложитьСтрокуВМассивПодстрок(ИдентификаторыПрисоединенныхФайлов, ";");	  
	СписокИдентификаторов = Новый СписокЗначений;
	
	Для каждого ТекЭлемент ИЗ МассивИдентификаторов Цикл    
		СписокИдентификаторов.Добавить(ТекЭлемент);
	КонецЦикла;                                    
	
	Возврат СписокИдентификаторов;
	
КонецФункции

&НаСервере
Функция РазложитьСтрокуВМассивПодстрок(Строка, Разделитель = ",", ПропускатьПустыеСтроки = Неопределено, СокращатьНепечатаемыеСимволы = Ложь) Экспорт
	
	ВремСтрока = Строка;
	
	Результат = Новый Массив;
	
	// Для обеспечения обратной совместимости.
	Если ПропускатьПустыеСтроки = Неопределено Тогда
		ПропускатьПустыеСтроки = ?(Разделитель = " ", Истина, Ложь);
		Если ПустаяСтрока(ВремСтрока) Тогда 
			Если Разделитель = " " Тогда
				Результат.Добавить("");
			КонецЕсли;
			Возврат Результат;
		КонецЕсли;
	КонецЕсли;
	//
	
	Позиция = Найти(ВремСтрока, Разделитель);
	Пока Позиция > 0 Цикл
		Подстрока = Лев(ВремСтрока, Позиция - 1);
		Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Подстрока) Тогда
			Если СокращатьНепечатаемыеСимволы Тогда
				Результат.Добавить(СокрЛП(Подстрока));
			Иначе
				Результат.Добавить(Подстрока);
			КонецЕсли;
		КонецЕсли;
		ВремСтрока = Сред(ВремСтрока, Позиция + СтрДлина(Разделитель));
		Позиция = Найти(ВремСтрока, Разделитель);
	КонецЦикла;
	
	Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(ВремСтрока) Тогда
		Если СокращатьНепечатаемыеСимволы Тогда
			Результат.Добавить(СокрЛП(ВремСтрока));
		Иначе
			Результат.Добавить(ВремСтрока);
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции 





&НаКлиенте
Процедура ПриОткрытии(Отказ)   	
	
	Элементы.ДекорацияОбъектОтбора.Заголовок = Строка(ОбъектОтбора);
	Элементы.ДекорацияРаботы.Заголовок = Строка(Работы);      
	
	ПрефиксФайла = "Работы";  
	
	ОбновитьОтборКартинкиИФайлы();  

	УстановитьЦветФонаКнопок();  
	
КонецПроцедуры  


&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)   	

	СтруктураДанных = Новый Структура;
	СтруктураДанных.Вставить("ФормаРедактирования", "ИзменитьСтатусСогласованияРабот"); 
	СтруктураДанных.Вставить("НомерСтрокиОтбора", НомерСтрокиОтбора);
	СтруктураДанных.Вставить("СтатусСогласования", СтатусСогласования);
	СтруктураДанных.Вставить("АвторСогласования", АвторСогласования);
	СтруктураДанных.Вставить("ДатаСогласования", ДатаСогласования); 
	СтруктураДанных.Вставить("Причина", Причина);  
	СтруктураДанных.Вставить("ИдентификаторСтроки", ИдентификаторСтроки);   
	СтруктураДанных.Вставить("ИдентификаторыПрисоединенныхФайлов", ИдентификаторыПрисоединенныхФайлов);
	СтруктураДанных.Вставить("ИдентификаторСтрокиОсмотра", ИдентификаторСтрокиОсмотра); 	
	
	ОповеститьОВыборе(СтруктураДанных);    	

КонецПроцедуры   

&НаКлиенте
Процедура КартинкиИФайлыВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;       
	
	ТипВремФайла = "";
	
	ПОлноеИмяВремФайла = ПолучитьИмяВремФайла(Элемент.ТекущаяСтрока, ТипВремФайла);      
	
	 #Если МобильноеПриложениеКлиент Тогда 
	    НовВз = Новый ЗапускПриложенияМобильногоУстройства();
	    НовВз.Действие="android.intent.action.VIEW";   
	   // НовВз.Данные = "file://" + ПолноеИмяВремФайла;       
	   
	    НовВз.Данные = ПОлноеИмяВремФайла;   		
		НовВз.Тип = ТипВремФайла + "/*" ;    		       		 

	    НовВз.Запустить(Истина);
	    Для Каждого Стр Из НовВз.ДополнительныеДанные Цикл
	        Сообщить(Стр.Ключ+" - "+Стр.Значение);
	    КонецЦикла;   
   	#КонецЕсли       

КонецПроцедуры


	
&НаСервере
Функция ПолучитьИмяВремФайла(ТекСтрокаРегистра, ТипВремФайла)  
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	КартинкиИФайлы.Объект КАК Объект,
	               |	КартинкиИФайлы.Идентификатор КАК Идентификатор,
	               |	КартинкиИФайлы.Данные КАК Данные,
	               |	КартинкиИФайлы.Картинка КАК Картинка,
	               |	КартинкиИФайлы.ИмяФайла КАК ИмяФайла,
	               |	КартинкиИФайлы.ТипФайла КАК ТипФайла
	               |ИЗ
	               |	РегистрСведений.КартинкиИФайлы КАК КартинкиИФайлы
	               |ГДЕ
	               |	КартинкиИФайлы.Объект = &Объект
	               |	И КартинкиИФайлы.Идентификатор = &Идентификатор"; 
	Запрос.УстановитьПараметр("Объект", ТекСтрокаРегистра.Объект);
	Запрос.УстановитьПараметр("Идентификатор", ТекСтрокаРегистра.Идентификатор);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат "";
	КонецЕсли;
	
	//
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();           
	
	ДвоичныеДанные = Выборка.Данные.Получить(); 	
	
	// Получаем расширение
	
	МассивПодстрок = ОбщегоНазначенияКлиентСервер.РазложитьСтрокуВМассивПодстрок(Выборка.ИмяФайла, "."); 
	
	РасширениеВремФайла = МассивПодстрок[МассивПодстрок.Количество() - 1];   	
	
	ПолноеИмяВремФайла  = КаталогвРеменныхФайлов() + "ВремФайл." + РасширениеВремФайла;    	          
//	Сообщить(ПолноеИмяВремФайла);
	
	ТипВремФайла = СокрЛП(Выборка.ТипФайла);
	
	Если ТипВремФайла = "" Тогда			
		Если РасширениеВремФайла = 	"m4a" Тогда
			ТипВремФайла = "audio";       
		ИначеЕсли РасширениеВремФайла = "mp4" Тогда
			ТипВремФайла = "video";       
		Иначе	
			ТипВремФайла = "image"; 
		КонецЕсли;                  
  	КонецЕсли;

		
//	Сообщить(ТипВремФайла);
                                 
	
	Если ДвоичныеДанные <> Неопределено Тогда
		ДвоичныеДанные.Записать(ПолноеИмяВремФайла);			            
	КонецЕсли;
	
	Возврат ПолноеИмяВремФайла;	
	
КонецФункции

&НаКлиенте
Процедура КартинкиИФайлыПередУдалением(Элемент, Отказ)
	ИдентификаторыПрисоединенныхФайловБезУдаленных(ОбъектОтбора, ИдентификаторыПрисоединенныхФайлов);
КонецПроцедуры


&НаСервереБезКонтекста
Процедура ИдентификаторыПрисоединенныхФайловБезУдаленных(ОбъектОтбора, ИдентификаторыПрисоединенныхФайлов)    
	МассивИдентификаторов =  ОбщегоНазначенияКлиентСервер.РазложитьСтрокуВМассивПодстрок(ИдентификаторыПрисоединенныхФайлов, ";");  	
	
	ВремИдентификаторыПрисоединенныхФайлов = "";
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	КартинкиИФайлы.Объект КАК Объект,
	|	КартинкиИФайлы.Идентификатор КАК Идентификатор
	|ИЗ
	|	РегистрСведений.КартинкиИФайлы КАК КартинкиИФайлы
	|ГДЕ
	|	КартинкиИФайлы.Объект = &Объект
	|	И КартинкиИФайлы.Идентификатор В(&МассивИдентификаторов)";
	Запрос.УстановитьПараметр("Объект", ОбъектОтбора);      
	Запрос.УстановитьПараметр("МассивИдентификаторов", МассивИдентификаторов);   
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл  
		ВремИдентификаторыПрисоединенныхФайлов = ВремИдентификаторыПрисоединенныхФайлов + ?(ВремИдентификаторыПрисоединенныхФайлов = "", "", ";") + Выборка.Идентификатор;		
	КонецЦикла;                
	
	ИдентификаторыПрисоединенныхФайлов = ВремИдентификаторыПрисоединенныхФайлов;	
	
КонецПроцедуры


&НаКлиенте
Процедура НажатиеСогласовано(Команда)                         
	УстановитьСостояниеОсмотра("Согласовано");   
	ЭтаФорма.Закрыть();
КонецПроцедуры     


&НаКлиенте
Процедура НажатиеНеСогласовано(Команда)           
	УстановитьСостояниеОсмотра("НеСогласовано");       
КонецПроцедуры

&НаКлиенте
Процедура НажатиеНеПонадобилось(Команда)
	УстановитьСостояниеОсмотра("НеПонадобилось"); 
КонецПроцедуры    

&НаКлиенте
Процедура УстановитьСостояниеОсмотра(ВыбСостояние)
	
	СтатусСогласования = ПолучитьСостояние(ВыбСостояние);    
	
	АвторСогласования = ПолучитьТекущегоПользователянаСервере();
	ДатаСогласования  = ТекущаяДата();
	
	УстановитьЦветФонаКнопок(); 	
КонецПроцедуры   

	&НаСервере
Функция ПолучитьТекущегоПользователянаСервере()     
	Возврат ОбщегоНазначенияКлиентСервер.ПолучитьТекущегоПользователя();
КонецФункции



&НаКлиенте
Процедура УстановитьЦветФонаКнопок()   
	
	Элементы.КнопкаСогласовано.ЦветФона   = ПолучитьЦветФонаКнопки("Согласовано");  
	Элементы.КнопкаНеСогласовано.ЦветФона   = ПолучитьЦветФонаКнопки("НеСогласовано");
	Элементы.КнопкаНеПонадобилось.ЦветФона   = ПолучитьЦветФонаКнопки("НеПонадобилось");
	
КонецПроцедуры  

&НаСервере
Функция ПолучитьЦветФонаКнопки(ВыбСостояние)         
	
	Если СтатусСогласования = Перечисления.Согласован[ВыбСостояние] Тогда 		
		Возврат WebЦвета.ТемноСерый;            
	Иначе	
		Возврат WebЦвета.Белый;
	КонецЕсли;          	
	
КонецФункции


&НаСервере
Функция ПолучитьСостояние(ВыбСостояние)         
	
	Если ВыбСостояние = "Согласовано" Тогда
		Возврат Перечисления.Согласован.Согласовано;
	ИначеЕсли ВыбСостояние = "НеСогласовано" Тогда
		Возврат Перечисления.Согласован.НеСогласовано;	
	ИначеЕсли ВыбСостояние = "НеПонадобилось" Тогда
		Возврат Перечисления.Согласован.НеПонадобилось;	
	КонецЕсли;          
	
	Возврат "";
КонецФункции

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)

КонецПроцедуры


