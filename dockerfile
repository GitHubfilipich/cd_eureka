# ЭТАП 1: Сборка (называем этот этап "build")
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app

# Сначала копируем только pom.xml, чтобы Docker закешировал зависимости
COPY pom.xml .
RUN mvn dependency:go-offline

# Теперь копируем исходники и собираем проект
COPY src ./src
RUN mvn clean package -DskipTests -Dcheckstyle.skip

# ЭТАП 2: Запуск (финальный легкий образ)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Копируем только готовый jar из первого этапа (build)
COPY --from=build /app/target/*.jar app.jar

EXPOSE 9009
ENTRYPOINT ["java", "-jar", "app.jar"]