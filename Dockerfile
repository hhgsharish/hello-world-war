# Stage 1: Build the Java application
FROM maven:3.8.2-openjdk-8 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package
RUN ls target/
# Stage 2: Deploy to Tomcat
FROM tomcat:jre8-temurin-focal AS deploy
COPY --from=builder /app/target/hello-world-war*.war /usr/local/tomcat/webapps/

# Expose Tomcat's default port
EXPOSE 8080
CMD ["catalina.sh", "run"]
