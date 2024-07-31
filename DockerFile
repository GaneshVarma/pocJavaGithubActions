# Container image that runs your code
#FROM java:17
#LABEL org.opencontainers.image.source="https://github.com/GaneshVarma/pocJavaGithubActions"
FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
