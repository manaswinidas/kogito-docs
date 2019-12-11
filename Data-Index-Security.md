Data index service can use quarkus OpenID Connect Adapter to enable security using bearer token authorization,
where these tokens are issued by OpenId Connect and OAuth 2.0 compliant Authorization Servers such as Keycloak.


The OpenID Connect extension allows you to define the adapter configuration using the application.properties file
which should be located at the src/main/resources directory.

## Enabling security

The Data Index Service has defined a quarkus profile to encapsulate the security configuration. In means that if the
service requires enable security it have to be started adding the  -Dquarkus.profile=keycloak.
If the 'keycloak' quarkus profile is not added, OIDC extension is disabled.

```
mvn clean compile quarkus:dev  -Dquarkus.profile=keycloak -Dkogito.protobuf.folder=/home/git/kogito-runtimes/data-index/data-index-service/src/test/resources -Dkogito.protobuf.watch=true
```


## Configuring security using the application.properties file

```
%keycloak.quarkus.oidc.enabled=true
%keycloak.quarkus.oidc.auth-server-url=http://localhost:8280/auth/realms/kogito
%keycloak.quarkus.oidc.client-id=kogito-data-index-service
%keycloak.quarkus.oidc.credentials.secret=secret
%keycloak.quarkus.http.auth.policy.role-policy1.roles-allowed=confidential
%keycloak.quarkus.http.auth.permission.roles1.paths=/graphql
%keycloak.quarkus.http.auth.permission.roles1.policy=role-policy1
```

Once the OIDC is enabled, the application needs to know some information to be able to authenticate the users and load their credentials:

*quarkus.oidc.auth-server-url* : The base URL of the OpenID Connect (OIDC) server, for example, 'https://host:port/auth'. All
the other OIDC server page and service URLs are derived from this URL. Note if you work with Keycloak OIDC server, make sure
the base URL is in the following format: 'https://host:port/auth/realms/{realm}' where '{realm}' has to be replaced by the name of
the Keycloak realm.

*quarkus.oidc.client-id*: The client-id of the application. Each application has a client-id that is used to identify the application

*quarkus.oidc.credentials.secret*: The client secret

For more info please visit: [Quarkus security - Configuring-openid-connect-adapter](https://quarkus.io/guides/security-openid-connect#configuring-using-the-application-properties-file)

Now is time to configure which resources are exposed and what are the required permissions
This default configuration explains that only users with role 'confidential' can access to /graphql endpoint

For more info please visit: [Quarkus security - Authorization of Web Endpoints using configuration](https://quarkus.io/guides/security#authorization-of-web-endpoints-using-configuration)


NOTE: When security is enabled, the GraphiQL UI is unavailable regarding the OpenID connection is configured as a service (quarkus.oidc.application-type=service)
consuming bearer tokens and not allowing token generation that would need to be configured as web-app (quarkus.oidc.application-type=web-app)