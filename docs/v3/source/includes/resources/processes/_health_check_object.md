### The health_check object

Name | Type | Description
---- | ---- | -----------
**type** | _string_ | The type of health check to perform. Valid values are `http`, `port`, and `process`. Default is `port`.
**data.timeout** | _integer_ | The duration in seconds that health checks can fail before the process is restarted.
**data.invocation_timeout** | _integer_ | The timeout in seconds for individual health check requests for `http` and `port` health checks.
**data.endpoint** | _string_ | The endpoint called to determine if the app is healthy. This key is only present for `http` health checks.
