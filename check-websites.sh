#!/bin/bash

# Визначаємо масив з URL вебсайтів для перевірки
websites=(https://google.com https://facebook.com https://twitter.com)

# Визначаємо назву файлу логів
logfile="website_status.log"

# Очищуємо файл логів перед початком нової перевірки
> $logfile

# Перебираємо кожен сайт у масиві
for website in "${websites[@]}"; do
  # Використовуємо curl для надсилання HTTP GET запитів та зберігаємо HTTP статус-код
  status_code=$(curl -o /dev/null -s -w "%{http_code}\n" "$website")

  # Перевіряємо, чи статус-код дорівнює 200
  if [ $status_code -eq 200 ]; then
    echo "$website is UP" | tee -a $logfile
  else
    echo "$website is DOWN" | tee -a $logfile
  fi
done

# Виводимо повідомлення про завершення запису у файл логів
echo "Results have been logged to $logfile"

