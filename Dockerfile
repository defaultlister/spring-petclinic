FROM eclipse-temurin:17-jdk-jammy as base
WORKDIR /app

COPY src ./src

COPY .mvn/ .mvn
COPY mvnw pom.xml ./

RUN ./mvnw package -DskipTests=true 

FROM eclipse-temurin:17-jre-jammy as final
WORKDIR /final

EXPOSE 8080/tcp

COPY --from=base /app/target/spring-petclinic-*.jar /spring-petclinic.jar

CMD ["java", "-jar", "/spring-petclinic.jar"]
