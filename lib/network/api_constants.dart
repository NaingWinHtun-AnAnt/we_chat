const baseUrl = "https://fcm.googleapis.com/";

/// end points
const endPointNotificationSend = "fcm/send";

/// firebase messaging server key
const serverKey =
    "AAAAucZD_1k:APA91bHTGUxCas3QYrg8VsIzfknQ4Y7OpI_zmN5GRYOVQucLhGhRGRv79M8XgzfW80QoirAUb3yysXx8KTz9Mz4izII9VkuVwfd3b8F8G-yk5tE5NrzjwOsVBSu3WhzKiz2QV1f0LRDD";

/// headers name
const paramAuthorization = "Authorization";
const paramContentType = "Content-Type";
const paramAcceptEncoding = "Accept-Encoding";
const paramConnection = "Connection";

/// headers value
const valueAuthorization = "key=$serverKey";
const valueContentType = "application/json";
const valueAcceptEncoding = "gzip, deflate, br";
const valueConnection = "keep-alive";
