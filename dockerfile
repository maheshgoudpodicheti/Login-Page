# Use an official Maven image to build the project
FROM maven:3.9.9-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Package the application (skip tests for faster build)
RUN mvn clean package -DskipTests

# --------------------------------------------------

# Use a smaller JRE image for the final run
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy built jar from previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose application port
EXPOSE 9080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

