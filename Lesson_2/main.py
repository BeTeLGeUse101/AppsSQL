"""
ПРИМЕЧАНИЕ: Мне пришлось удалить строчки database, т.к при подключении
к локальному серверу MySQL, программа не могла найти базу данных под именем.
Необходимо было в UI MySQL Workbench создавать вручную базу данных (SCHEMAS).
Поэтому, код ниже подключается к серверу, создавая базу данных на нем,
и после коннектится к созданной БД. Так же добавил вывод запроса в GUI Dearpygui.
При запуске необходимо проверить пароль в конфиге!
"""
# Модуль tabulate преображает возвращаемый запрос в соответствующую табличку(консоль)

import pymysql
import dearpygui.dearpygui as dpg
from tabulate import tabulate
from config import host, password, user

def tabulateQuery(rows):
    # Формирование заголовков таблицы (названия столбцов)
    headers = rows[0].keys() if rows else []

    # Преобразование списка словарей в список списков
    rows = [list(row.values()) for row in rows]

    # Форматирование результатов в виде таблицы
    table = tabulate(rows, headers, tablefmt="grid")

    with dpg.window(label="table"):
        with dpg.table(header_row=True):
            for header in headers:
                dpg.add_table_column(label=header)

            for row in rows:
                with dpg.table_row():
                    for value in row:
                        dpg.add_text(str(value))
    print(table)

def main():
    try:
        connection = pymysql.connect(
            host=host,
            port=3306,
            user=user,
            password=password,
            cursorclass=pymysql.cursors.DictCursor
        )
        print("Connection to server ...OK")

        try:
            dpg.create_context()

            cursor = connection.cursor()

            # Создаем базу данных и подключаемся к ней
            cursor.execute("CREATE DATABASE IF NOT EXISTS task_1;")
            connection.commit()
            cursor.execute("USE task_1;")
            print("DB task_1 created ...OK")

            # Удаляем табличку, если она была ранее создана
            drom_query = "DROP TABLE IF EXISTS sales;"
            cursor.execute(drom_query)

            # Создаем таблицу
            creat_query = "CREATE TABLE IF NOT EXISTS sales" \
                            "(id INT PRIMARY KEY AUTO_INCREMENT," \
                            "order_date DATE NOT NULL," \
                            "count_product INT);"
            cursor.execute(creat_query)
            print("Added table 'SALES' ...OK")

            # Добавляем информацию в таблицу
            insert_query = "INSERT sales(order_date, count_product) VALUES" \
                            "('2022-01-01', 156)," \
                            "('2022-01-02', 180)," \
                            "('2022-01-03', 21)," \
                            "('2022-01-04', 124)," \
                            "('2022-01-05', 341);"
            cursor.execute(insert_query)
            connection.commit()
            print("Information added to table 'SALES'...OK")

            # Вывод данных таблицы
            print("\nТаблица 'SALES':")
            cursor.execute("SELECT * FROM sales")
            rows = cursor.fetchall()
            tabulateQuery(rows)

            # Выборка по типу заказа
            print("\nВыборка по типу заказа:")
            cursor.execute("SELECT id AS 'id order'," \
                        "CASE WHEN count_product < 100 THEN 'small order'" \
                        "WHEN count_product > 100 AND count_product < 300 THEN 'avarage order'" \
                        "WHEN count_product > 300 THEN 'big order'" \
                        "ELSE 'error'" \
                        "END AS 'order type'" \
                        "FROM sales;")
            rows = cursor.fetchall()
            tabulateQuery(rows)

            drom_query = "DROP TABLE IF EXISTS orders;"
            cursor.execute(drom_query)

            creat_query = "CREATE TABLE IF NOT EXISTS orders" \
                            "(id INT PRIMARY KEY AUTO_INCREMENT," \
                            "employee_id VARCHAR(45) NOT NULL," \
                            "amount FLOAT NOT NULL," \
                            "order_status VARCHAR(45) NOT NULL);"
            cursor.execute(creat_query)
            print("Added table 'ORDERS' ...OK")

            insert_query = "INSERT orders(employee_id, amount, order_status) VALUES" \
                            "('e03', 15.00, 'OPEN')," \
                            "('e01', 25.50, 'OPEN')," \
                            "('e05', 100.70, 'CLOSED')," \
                            "('e02', 22.18, 'OPEN')," \
                            "('e04', 9.50, 'CANCELLED');"
            cursor.execute(insert_query)
            connection.commit()
            print("Information added to table 'ORDERS'...OK")

            print("\nТаблица 'ORDERS':")
            cursor.execute("SELECT * FROM orders")
            rows = cursor.fetchall()
            tabulateQuery(rows)

            print("\nВыборка по полному статусу заказа:")
            cursor.execute("SELECT id," \
                        "CASE WHEN order_status = 'OPEN' THEN 'Order is in open state'" \
                        "WHEN order_status = 'CLOSED' THEN 'Order is closed'" \
                        "WHEN order_status = 'CANCELLED' THEN 'Order is cancelled'" \
                        "ELSE 'error'" \
                        "END AS 'full_order_status'" \
                        "FROM orders;")
            rows = cursor.fetchall()
            tabulateQuery(rows)

            dpg.create_viewport(title="Custom title", width=800, height=600)
            dpg.setup_dearpygui()
            dpg.show_viewport()
            dpg.start_dearpygui()
            dpg.destroy_context()

        finally:
            connection.close()

    except Exception as ex:
        print("Connection refused")
        print(ex)

if __name__ == "__main__":
    main()