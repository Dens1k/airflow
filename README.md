Всем привет! Перед вами проект по использованию новых ETL-инструментов. 
---
_Тех стек: Airflow, docker, postgre_

Необходимо выгрузить файлы по поездкам такси Нью-Йорка в формате .parquet и загрузить в локальную БД Postgre для дальнейшей аналитики. 

Для выполнения вам потребуется: 

0. Установить: 
    - docker
    - python
    - dbeaver 
    - или использовать venv со всем окружением

1. Скопировать мой репозиторий:
``````
    - git clone https://github.com/Dens1k/airflow.git
``````

2. Инициализировать и запустить контейнеры:
``````
    - docker-compose build сборка проекта
    - docker-compose up airflow-init ##создание уч/з
    - docker-compose up -d ##запуск проекта
``````
3. Зайти в postgre/Airflow:
``````
    - Зайти в БД ny_taxi с логином и паролем "root" и создать таблицу из sql_scritps > ddl > yellow_taxi_data.sql
    - Запустить http://localhost:8080, а затем DAG "IngestionDag", check_pg. Таблица должна быть ~2.2 GB
    - Затем скрипт sql_scritps > dml > cost_ride.sql
``````
4. Не забудьте насладиться и отключить соединение ;)