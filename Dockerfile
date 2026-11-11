# Stage 1: Build the Maven application
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy Maven configuration
COPY pom.xml .

# Copy source code
COPY src ./src

# Build the application and execute JUnit tests
RUN mvn clean package

# Stage 2: Create lightweight runtime image
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy generated JAR from build stage
COPY --from=build /app/target/maven-github-demo-0.0.1-SNAPSHOT.jar app.jar

# Run the Grade Calculator
CMD ["java", "-cp", "app.jar", "com.example.maven_github_demo.Grade"]