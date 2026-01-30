# Stage 1: Build the JAR file
FROM maven:3.8.5-openjdk-17 AS build
# Hum 'demo' folder ke andar ka sara saman copy kar rahe hain
COPY demo/ . 
RUN mvn clean package -DskipTests

# Stage 2: Run the JAR file
FROM openjdk:17-jdk-slim
# Maven build ke baad jar file 'target' folder mein banti hai
COPY --from=build /target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]