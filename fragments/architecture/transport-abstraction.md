The session object does not make HTTP calls directly. Instead, it delegates to
a transport interface that defines a single method for posting JSON payloads:

- **URL**: The fully-qualified endpoint URL.
- **Payload**: The `runCommandJSON` request body.
- **Headers**: Authentication, CSRF token, and optional gateway headers.
- **Timeout**: Per-request timeout duration.
- **TLS verification**: Whether to verify server certificates.

The transport returns a response object containing the HTTP status code,
response body, and response headers.

The default implementation wraps the language's standard HTTP client. Tests
inject a mock transport to avoid network calls, making the entire command
pipeline testable without an MQ server.
