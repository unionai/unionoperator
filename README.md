# union-operator

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: operator-92d34872d46545f56e6808c12d6c602e2c6a95bf](https://img.shields.io/badge/AppVersion-operator--92d34872d46545f56e6808c12d6c602e2c6a95bf-informational?style=flat-square)

Deploys Union Operator to onboard a k8s cluster to Union Cloud

### SANDBOX INSTALLATION:
- [Install helm 3](https://helm.sh/docs/intro/install/)
- Install Flyte sandbox:

```bash
git clone git@github.com:unionai/unionoperator.git
cd unionoperator
helm install -n union-operator -f values.yaml --create-namespace union-operator .
```

Customize your installation by changing settings in a new file `values.yaml`.

Then apply your changes:
```bash
helm upgrade -f values.yaml union-operator . -n union-operator
```

### CONFIGURATION NOTES:

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| configmapOverrides | object | `{}` |  |
| flyte.configmap | object | `{"admin":{"admin":{"clientId":"{{- .Values.union.appId -}}","clientSecretLocation":"/etc/secrets/client_secret","endpoint":"{{- include \"union-operator.grpcUrl\" . }}"},"event":{"capacity":1000,"rate":500,"type":"admin"}},"catalog":{"catalog-cache":{"endpoint":"{{- include \"union-operator.grpcUrl\" . }}","type":"datacatalog"}},"copilot":{"plugins":{"k8s":{"co-pilot":{"image":"cr.flyte.org/flyteorg/flytecopilot:v0.0.15","name":"flyte-copilot-","start-timeout":"30s"}}}},"core":{"propeller":{"downstream-eval-duration":"30s","enable-admin-launcher":true,"leader-election":{"enabled":false,"lease-duration":"15s","lock-config-map":{"name":"propeller-leader","namespace":"flyte"},"renew-deadline":"10s","retry-period":"2s"},"limit-namespace":"all","max-workflow-retries":30,"metadata-prefix":"metadata/propeller","metrics-prefix":"flyte","prof-port":10254,"queue":{"batch-size":-1,"batching-interval":"2s","queue":{"base-delay":"5s","capacity":1000,"max-delay":"120s","rate":100,"type":"maxof"},"sub-queue":{"capacity":100,"rate":10,"type":"bucket"},"type":"batch"},"rawoutput-prefix":"{{ .Values.union.metadataBucketPrefix }}","workers":4,"workflow-reeval-duration":"30s"},"webhook":{"certDir":"/etc/webhook/certs","serviceName":"flyte-pod-webhook"}},"enabled_plugins":{"tasks":{"task-plugins":{"default-for-task-types":{"container":"container","container_array":"k8s-array","sidecar":"sidecar"},"enabled-plugins":["container","sidecar","k8s-array"]}}},"k8s":{"plugins":{"k8s":{"default-cpus":"100m","default-env-vars":[],"default-memory":"100Mi"}}},"logger":{"logger":{"level":4,"show-source":true}},"resource_manager":{"propeller":{"resourcemanager":{"type":"noop"}}},"task_logs":{"plugins":{"logs":{"cloudwatch-enabled":false,"kubernetes-enabled":true}}}}` | ------------------------------------------------------------------ Specializing your deployment using configuration ------------------------------------------------------------------- CONFIGMAPS SETTINGS |
| flyte.configmap.admin | object | `{"admin":{"clientId":"{{- .Values.union.appId -}}","clientSecretLocation":"/etc/secrets/client_secret","endpoint":"{{- include \"union-operator.grpcUrl\" . }}"},"event":{"capacity":1000,"rate":500,"type":"admin"}}` | Admin Client configuration [structure](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/nodes/subworkflow/launchplan#AdminConfig) |
| flyte.configmap.catalog | object | `{"catalog-cache":{"endpoint":"{{- include \"union-operator.grpcUrl\" . }}","type":"datacatalog"}}` | Catalog Client configuration [structure](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/nodes/task/catalog#Config) Additional advanced Catalog configuration [here](https://pkg.go.dev/github.com/lyft/flyteplugins/go/tasks/pluginmachinery/catalog#Config) |
| flyte.configmap.copilot | object | `{"plugins":{"k8s":{"co-pilot":{"image":"cr.flyte.org/flyteorg/flytecopilot:v0.0.15","name":"flyte-copilot-","start-timeout":"30s"}}}}` | Copilot configuration |
| flyte.configmap.copilot.plugins.k8s.co-pilot | object | `{"image":"cr.flyte.org/flyteorg/flytecopilot:v0.0.15","name":"flyte-copilot-","start-timeout":"30s"}` | Structure documented [here](https://pkg.go.dev/github.com/lyft/flyteplugins@v0.5.28/go/tasks/pluginmachinery/flytek8s/config#FlyteCoPilotConfig) |
| flyte.configmap.core | object | `{"propeller":{"downstream-eval-duration":"30s","enable-admin-launcher":true,"leader-election":{"enabled":false,"lease-duration":"15s","lock-config-map":{"name":"propeller-leader","namespace":"flyte"},"renew-deadline":"10s","retry-period":"2s"},"limit-namespace":"all","max-workflow-retries":30,"metadata-prefix":"metadata/propeller","metrics-prefix":"flyte","prof-port":10254,"queue":{"batch-size":-1,"batching-interval":"2s","queue":{"base-delay":"5s","capacity":1000,"max-delay":"120s","rate":100,"type":"maxof"},"sub-queue":{"capacity":100,"rate":10,"type":"bucket"},"type":"batch"},"rawoutput-prefix":"{{ .Values.union.metadataBucketPrefix }}","workers":4,"workflow-reeval-duration":"30s"},"webhook":{"certDir":"/etc/webhook/certs","serviceName":"flyte-pod-webhook"}}` | Core propeller configuration |
| flyte.configmap.core.propeller | object | `{"downstream-eval-duration":"30s","enable-admin-launcher":true,"leader-election":{"enabled":false,"lease-duration":"15s","lock-config-map":{"name":"propeller-leader","namespace":"flyte"},"renew-deadline":"10s","retry-period":"2s"},"limit-namespace":"all","max-workflow-retries":30,"metadata-prefix":"metadata/propeller","metrics-prefix":"flyte","prof-port":10254,"queue":{"batch-size":-1,"batching-interval":"2s","queue":{"base-delay":"5s","capacity":1000,"max-delay":"120s","rate":100,"type":"maxof"},"sub-queue":{"capacity":100,"rate":10,"type":"bucket"},"type":"batch"},"rawoutput-prefix":"{{ .Values.union.metadataBucketPrefix }}","workers":4,"workflow-reeval-duration":"30s"}` | follows the structure specified [here](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/config). |
| flyte.configmap.enabled_plugins.tasks | object | `{"task-plugins":{"default-for-task-types":{"container":"container","container_array":"k8s-array","sidecar":"sidecar"},"enabled-plugins":["container","sidecar","k8s-array"]}}` | Tasks specific configuration [structure](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/nodes/task/config#GetConfig) |
| flyte.configmap.enabled_plugins.tasks.task-plugins | object | `{"default-for-task-types":{"container":"container","container_array":"k8s-array","sidecar":"sidecar"},"enabled-plugins":["container","sidecar","k8s-array"]}` | Plugins configuration, [structure](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/nodes/task/config#TaskPluginConfig) |
| flyte.configmap.enabled_plugins.tasks.task-plugins.enabled-plugins | list | `["container","sidecar","k8s-array"]` | [Enabled Plugins](https://pkg.go.dev/github.com/lyft/flyteplugins/go/tasks/config#Config). Enable sagemaker*, athena if you install the backend plugins |
| flyte.configmap.k8s | object | `{"plugins":{"k8s":{"default-cpus":"100m","default-env-vars":[],"default-memory":"100Mi"}}}` | Kubernetes specific Flyte configuration |
| flyte.configmap.k8s.plugins.k8s | object | `{"default-cpus":"100m","default-env-vars":[],"default-memory":"100Mi"}` | Configuration section for all K8s specific plugins [Configuration structure](https://pkg.go.dev/github.com/lyft/flyteplugins/go/tasks/pluginmachinery/flytek8s/config) |
| flyte.configmap.logger | object | `{"logger":{"level":4,"show-source":true}}` | Logger configuration |
| flyte.configmap.resource_manager | object | `{"propeller":{"resourcemanager":{"type":"noop"}}}` | Resource manager configuration |
| flyte.configmap.resource_manager.propeller | object | `{"resourcemanager":{"type":"noop"}}` | resource manager configuration |
| flyte.configmap.task_logs | object | `{"plugins":{"logs":{"cloudwatch-enabled":false,"kubernetes-enabled":true}}}` | Section that configures how the Task logs are displayed on the UI. This has to be changed based on your actual logging provider. Refer to [structure](https://pkg.go.dev/github.com/lyft/flyteplugins/go/tasks/logs#LogConfig) to understand how to configure various logging engines |
| flyte.configmap.task_logs.plugins.logs.cloudwatch-enabled | bool | `false` | One option is to enable cloudwatch logging for EKS, update the region and log group accordingly |
| flyte.flytepropeller.affinity | object | `{}` | affinity for Flytepropeller deployment |
| flyte.flytepropeller.cacheSizeMbs | int | `0` |  |
| flyte.flytepropeller.client_secret | string | `"foobar"` |  |
| flyte.flytepropeller.configPath | string | `"/etc/flyte/config/*.yaml"` | Default regex string for searching configuration files |
| flyte.flytepropeller.enabled | bool | `true` |  |
| flyte.flytepropeller.image.pullPolicy | string | `"IfNotPresent"` |  |
| flyte.flytepropeller.image.repository | string | `"cr.flyte.org/flyteorg/flytepropeller"` | Docker image for Flytepropeller deployment |
| flyte.flytepropeller.image.tag | string | `"v0.15.17"` |  |
| flyte.flytepropeller.nodeSelector | object | `{}` | nodeSelector for Flytepropeller deployment |
| flyte.flytepropeller.podAnnotations | object | `{}` | Annotations for Flytepropeller pods |
| flyte.flytepropeller.replicaCount | int | `1` | Replicas count for Flytepropeller deployment |
| flyte.flytepropeller.resources | object | `{"limits":{"cpu":"200m","ephemeral-storage":"100Mi","memory":"200Mi"},"requests":{"cpu":"10m","ephemeral-storage":"50Mi","memory":"50Mi"}}` | Default resources requests and limits for Flytepropeller deployment |
| flyte.flytepropeller.serviceAccount | object | `{"annotations":{},"create":true,"imagePullSecrets":{}}` | Configuration for service accounts for FlytePropeller |
| flyte.flytepropeller.serviceAccount.annotations | object | `{}` | Annotations for ServiceAccount attached to FlytePropeller pods |
| flyte.flytepropeller.serviceAccount.create | bool | `true` | Should a service account be created for FlytePropeller |
| flyte.flytepropeller.serviceAccount.imagePullSecrets | object | `{}` | ImapgePullSecrets to automatically assign to the service account |
| flyte.flytepropeller.tolerations | list | `[]` | tolerations for Flytepropeller deployment |
| flyte.sparkoperator | object | `{"enabled":false,"plugin_config":{"plugins":{"spark":{"spark-config-default":[{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.DefaultAWSCredentialsProviderChain"},{"spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version":"2"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.multipart.threshold":"536870912"},{"spark.blacklist.enabled":"true"},{"spark.blacklist.timeout":"5m"},{"spark.task.maxfailures":"8"}]}}}}` | ------------------------------------------------------ Optional Plugins -------------------------------------------------------- -- Optional: Spark Plugin using the Spark Operator |
| flyte.sparkoperator.enabled | bool | `false` | - enable or disable Sparkoperator deployment installation |
| flyte.sparkoperator.plugin_config | object | `{"plugins":{"spark":{"spark-config-default":[{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.DefaultAWSCredentialsProviderChain"},{"spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version":"2"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.multipart.threshold":"536870912"},{"spark.blacklist.enabled":"true"},{"spark.blacklist.timeout":"5m"},{"spark.task.maxfailures":"8"}]}}}` | Spark plugin configuration |
| flyte.sparkoperator.plugin_config.plugins.spark.spark-config-default | list | `[{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.DefaultAWSCredentialsProviderChain"},{"spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version":"2"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.multipart.threshold":"536870912"},{"spark.blacklist.enabled":"true"},{"spark.blacklist.timeout":"5m"},{"spark.task.maxfailures":"8"}]` | Spark default configuration |
| flyte.sparkoperator.plugin_config.plugins.spark.spark-config-default[0] | object | `{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.DefaultAWSCredentialsProviderChain"}` |  it can use the serviceAccount based IAM role or ec2 metadata based. This is more in line with how AWS works |
| flyte.webhook | object | `{"enabled":true,"podAnnotations":{},"service":{"annotations":{"projectcontour.io/upstream-protocol.h2c":"grpc"},"type":"ClusterIP"},"serviceAccount":{"annotations":{},"create":true,"imagePullSecrets":{}}}` |  WEBHOOK SETTINGS |
| flyte.webhook.enabled | bool | `true` | enable or disable secrets webhook |
| flyte.webhook.podAnnotations | object | `{}` | Annotations for webhook pods |
| flyte.webhook.service | object | `{"annotations":{"projectcontour.io/upstream-protocol.h2c":"grpc"},"type":"ClusterIP"}` | Service settings for the webhook |
| flyte.webhook.serviceAccount | object | `{"annotations":{},"create":true,"imagePullSecrets":{}}` | Configuration for service accounts for the webhook |
| flyte.webhook.serviceAccount.annotations | object | `{}` | Annotations for ServiceAccount attached to the webhook |
| flyte.webhook.serviceAccount.create | bool | `true` | Should a service account be created for the webhook |
| flyte.webhook.serviceAccount.imagePullSecrets | object | `{}` | ImapgePullSecrets to automatically assign to the service account |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"public.ecr.aws/p0i0a9q8/union-public"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations."prometheus.io/path" | string | `"/metrics"` |  |
| podAnnotations."prometheus.io/port" | string | `"10254"` |  |
| podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  If not set and create is true, a name is generated using the fullname template |
| storage | object | `{"custom":{},"gcs":null,"s3":{"region":"us-east-1"},"type":"sandbox"}` | --------------------------------------------------- Core dependencies that should be configured for Flyte to work on any platform ------------------------------------------------------ STORAGE SETTINGS |
| storage.custom | object | `{}` | GCP project ID. Required for storage type gcs. projectId: -- Settings for storage type custom. See https://github:com/graymeta/stow for supported storage providers/settings. |
| storage.gcs | string | `nil` | settings for storage type gcs |
| storage.s3 | object | `{"region":"us-east-1"}` | settings for storage type s3 |
| storage.type | string | `"sandbox"` | Sets the storage type. Supported values are sandbox, s3, gcs and custom. |
| tolerations | list | `[]` |  |
| union.appId | string | `"<App Id from uctl create app>"` |  |
| union.appSecret | string | `"<App secret from uctl create app>"` |  |
| union.cloudUrl | string | `"<Union Cloud URL>"` |  |
| union.clusterName | string | `""` |  |
| union.metadataBucketPrefix | string | `"s3://my-s3-bucket"` |  |
