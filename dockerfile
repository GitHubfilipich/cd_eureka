# Используем легковесный образ JRE
FROM eclipse-temurin:17-jre-alpine

# Директория приложения внутри контейнера
WORKDIR /app

# Копируем скомпилированный jar-файл (уточните имя файла после сборки)
COPY target/*.jar app.jar

# Открываем порт Eureka
EXPOSE 9009

# Запускаем приложение
ENTRYPOINT ["java", "-jar", "app.jar"]
