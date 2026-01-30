# Stage 1: Build the JAR file using Java 21
FROM maven:3.9.6-eclipse-temurin-21 AS build
COPY demo/ . 
RUN mvn clean package -DskipTests

# Stage 2: Run the application using Java 21
# 'jammy' is more stable for Java 21
FROM eclipse-temurin:21-jdk-jammy
COPY --from=build /target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]