FROM maven:3.8.6-openjdk-18-slim AS MAVEN_BUILD
# copy the source tree and the pom.xml to our new container 
COPY ./ ./
# package our application code 
RUN mvn clean package 
FROM eclipse-temurin:17.0.6_10-jre-alpine
ENV JAVA_OPTS="-Xms512m -Xms512m  -Djava.security.egd=file:/dev/./urandom"
COPY --from=MAVEN_BUILD target/webapp-0.0.1-SNAPSHOT.jar webapp-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "webapp-0.0.1-SNAPSHOT.jar"] 