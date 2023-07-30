# Shops_Data_mart-1T-Data-training

## Первое задание
В качестве первого задания необходимо было доработать исходную схему данных\
![Original data schema](img/original_data_schema.png)

По итогу, в схему была добавлена таблица shops, содержащая в себе id магазина, а также его имя.
Также было внесено изменение в таблицу plan - вместо shop_name теперь используется shop_id, что связывает таблицы shops и plan\
![Final data schema](img/final_data_schema.png)

## Второе задание
Был подготовлен DDL [скрипт](init_script.sql) для создания таблиц и заполнения их данными