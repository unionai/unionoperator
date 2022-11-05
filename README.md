# union-operator

![Version: v0.0.1](https://img.shields.io/badge/Version-v0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.0.1](https://img.shields.io/badge/AppVersion-v0.0.1-informational?style=flat-square)

Deploys Union Operator to onboard a k8s cluster to Union Cloud

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://flyteorg.github.io/flyte/ | union(flyte-core) | v1.2.0-b1 |

### SANDBOX INSTALLATION:
- [Install helm 3](https://helm.sh/docs/intro/install/)
- Install Union Operator:

```bash
helm repo add unionai https://unionai.github.io/unionoperator/
helm repo update
helm install -n union-operator -f values.yaml --create-namespace union-operator unionai/union-operator
```

Customize your installation by changing settings in a new file `values.yaml`.

Then apply your changes:
```bash
helm upgrade -f values.yaml union-operator unionai/union-operator -n union-operator
```

### CONFIGURATION NOTES:

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| minio.affinity | object | `{}` | affinity for Minio deployment |
| minio.image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| minio.image.repository | string | `"ecr.flyte.org/bitnami/minio"` | Docker image for Minio deployment |
| minio.image.tag | string | `"2021.10.13-debian-10-r0"` | Docker image tag |
| minio.nodeSelector | object | `{}` | nodeSelector for Minio deployment |
| minio.podAnnotations | object | `{}` | Annotations for Minio pods |
| minio.replicaCount | int | `1` | Replicas count for Minio deployment |
| minio.resources | object | `{"limits":{"cpu":"200m","memory":"512Mi"},"requests":{"cpu":"10m","memory":"128Mi"}}` | Default resources requests and limits for Minio deployment |
| minio.resources.limits | object | `{"cpu":"200m","memory":"512Mi"}` | Limits are the maximum set of resources needed for this pod |
| minio.resources.requests | object | `{"cpu":"10m","memory":"128Mi"}` | Requests are the minimum set of resources needed for this pod |
| minio.service | object | `{"annotations":{},"type":"NodePort"}` | Service settings for Minio |
| minio.tolerations | list | `[]` | tolerations for Minio deployment |
| union.appId | string | `"<App Id from uctl create app>"` |  |
| union.appSecret | string | `"<App Secret from uctl create app>"` |  |
| union.cloudUrl | string | `"<Union Cloud URL>"` |  |
| union.clusterName | string | `""` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[0].production[0].projectQuotaCpu.value | string | `"64"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[0].production[1].projectQuotaMemory.value | string | `"32Gi"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[0].production[2].projectQuotaNvidiaGpu.value | string | `"1"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[0].production[3].defaultUserRoleKey.value | string | `"{{ tpl .Values.userRoleAnnotationKey . }}"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[0].production[4].defaultUserRoleValue.value | string | `"{{ tpl .Values.userRoleAnnotationValue . }}"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[1].staging[0].projectQuotaCpu.value | string | `"64"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[1].staging[1].projectQuotaMemory.value | string | `"32Gi"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[1].staging[2].projectQuotaNvidiaGpu.value | string | `"1"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[1].staging[3].defaultUserRoleKey.value | string | `"{{ tpl .Values.userRoleAnnotationKey . }}"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[1].staging[4].defaultUserRoleValue.value | string | `"{{ tpl .Values.userRoleAnnotationValue . }}"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[2].development[0].projectQuotaCpu.value | string | `"64"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[2].development[1].projectQuotaMemory.value | string | `"32Gi"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[2].development[2].projectQuotaNvidiaGpu.value | string | `"1"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[2].development[3].defaultUserRoleKey.value | string | `"{{ tpl .Values.userRoleAnnotationKey . }}"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[2].development[4].defaultUserRoleValue.value | string | `"{{ tpl .Values.userRoleAnnotationValue . }}"` |  |
| union.cluster_resource_manager.config.cluster_resources.standaloneDeployment | bool | `true` |  |
| union.cluster_resource_manager.enabled | bool | `true` |  |
| union.cluster_resource_manager.service_account_name | string | `"flytepropeller"` |  |
| union.cluster_resource_manager.standalone_deploy | bool | `true` |  |
| union.cluster_resource_manager.templates[0] | object | `{"key":"a_namespace.yaml","value":"apiVersion: v1\nkind: Namespace\nmetadata:\n  name: {{ namespace }}\nspec:\n  finalizers:\n  - kubernetes\n"}` | Template for namespaces resources |
| union.cluster_resource_manager.templates[1] | object | `{"key":"b_default_service_account.yaml","value":"apiVersion: v1\nkind: ServiceAccount\nmetadata:\n  name: default\n  namespace: {{ namespace }}\n  annotations:\n    {{ defaultUserRoleKey }}: {{ defaultUserRoleValue }}\n"}` | Patch default service account |
| union.cluster_resource_manager.templates[2].key | string | `"c_project_resource_quota.yaml"` |  |
| union.cluster_resource_manager.templates[2].value | string | `"apiVersion: v1\nkind: ResourceQuota\nmetadata:\n  name: project-quota\n  namespace: {{ namespace }}\nspec:\n  hard:\n    limits.cpu: {{ projectQuotaCpu }}\n    limits.memory: {{ projectQuotaMemory }}\n    limits.nvidia.com/gpu: {{ projectQuotaNvidiaGpu }}\n"` |  |
| union.common.ingress.enabled | bool | `false` |  |
| union.configmap | object | `{"admin":{"admin":{"clientId":"{{ tpl .Values.appId . }}","clientSecretLocation":"/etc/secrets/client_secret","endpoint":"{{- printf \"dns:///%s\" (.Values.cloudUrl | trimPrefix \"dns:///\" | trimPrefix \"http://\" | trimPrefix \"https://\") -}}","insecure":false},"event":{"capacity":1000,"rate":500,"type":"admin"}},"catalog":{"catalog-cache":{"endpoint":"{{- printf \"dns:///%s\" (.Values.cloudUrl | trimPrefix \"dns:///\" | trimPrefix \"http://\" | trimPrefix \"https://\") -}}","insecure":false,"type":"datacatalog","use-admin-auth":true}},"core":{"manager":{"shard":{"shard-count":3,"type":"Hash"}},"propeller":{"downstream-eval-duration":"30s","enable-admin-launcher":true,"event-config":{"raw-output-policy":"inline"},"leader-election":{"enabled":false,"lease-duration":"15s","lock-config-map":{"name":"propeller-leader","namespace":"flyte"},"renew-deadline":"10s","retry-period":"2s"},"limit-namespace":"all","max-workflow-retries":30,"metadata-prefix":"metadata/propeller","metrics-prefix":"flyte","prof-port":10254,"queue":{"batch-size":-1,"batching-interval":"2s","queue":{"base-delay":"5s","capacity":1000,"max-delay":"120s","rate":100,"type":"maxof"},"sub-queue":{"capacity":100,"rate":10,"type":"bucket"},"type":"batch"},"rawoutput-prefix":"{{ tpl .Values.metadataBucketPrefix $ }}","workers":4,"workflow-reeval-duration":"30s"},"webhook":{"certDir":"/etc/webhook/certs","serviceName":"flyte-pod-webhook"}},"enabled_plugins":{"tasks":{"task-plugins":{"default-for-task-types":{"container":"container","container_array":"k8s-array","sidecar":"sidecar"},"enabled-plugins":["container","sidecar","k8s-array"]}}},"k8s":{"plugins":{"k8s":{"default-cpus":"100m","default-memory":"100Mi"}}},"logger":{"logger":{"level":4,"show-source":true}},"resource_manager":{"propeller":{"resourcemanager":{"type":"noop"}}},"task_logs":{"plugins":{"logs":{"cloudwatch-enabled":false,"kubernetes-enabled":true}}}}` | ----------------------------------------------------------------- CONFIGMAPS SETTINGS |
| union.configmap.admin | object | `{"admin":{"clientId":"{{ tpl .Values.appId . }}","clientSecretLocation":"/etc/secrets/client_secret","endpoint":"{{- printf \"dns:///%s\" (.Values.cloudUrl | trimPrefix \"dns:///\" | trimPrefix \"http://\" | trimPrefix \"https://\") -}}","insecure":false},"event":{"capacity":1000,"rate":500,"type":"admin"}}` | Admin Client configuration [structure](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/nodes/subworkflow/launchplan#AdminConfig) |
| union.configmap.catalog | object | `{"catalog-cache":{"endpoint":"{{- printf \"dns:///%s\" (.Values.cloudUrl | trimPrefix \"dns:///\" | trimPrefix \"http://\" | trimPrefix \"https://\") -}}","insecure":false,"type":"datacatalog","use-admin-auth":true}}` | Catalog Client configuration [structure](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/nodes/task/catalog#Config) Additional advanced Catalog configuration [here](https://pkg.go.dev/github.com/lyft/flyteplugins/go/tasks/pluginmachinery/catalog#Config) |
| union.configmap.core | object | `{"manager":{"shard":{"shard-count":3,"type":"Hash"}},"propeller":{"downstream-eval-duration":"30s","enable-admin-launcher":true,"event-config":{"raw-output-policy":"inline"},"leader-election":{"enabled":false,"lease-duration":"15s","lock-config-map":{"name":"propeller-leader","namespace":"flyte"},"renew-deadline":"10s","retry-period":"2s"},"limit-namespace":"all","max-workflow-retries":30,"metadata-prefix":"metadata/propeller","metrics-prefix":"flyte","prof-port":10254,"queue":{"batch-size":-1,"batching-interval":"2s","queue":{"base-delay":"5s","capacity":1000,"max-delay":"120s","rate":100,"type":"maxof"},"sub-queue":{"capacity":100,"rate":10,"type":"bucket"},"type":"batch"},"rawoutput-prefix":"{{ tpl .Values.metadataBucketPrefix $ }}","workers":4,"workflow-reeval-duration":"30s"},"webhook":{"certDir":"/etc/webhook/certs","serviceName":"flyte-pod-webhook"}}` | Core propeller configuration |
| union.configmap.core.propeller | object | `{"downstream-eval-duration":"30s","enable-admin-launcher":true,"event-config":{"raw-output-policy":"inline"},"leader-election":{"enabled":false,"lease-duration":"15s","lock-config-map":{"name":"propeller-leader","namespace":"flyte"},"renew-deadline":"10s","retry-period":"2s"},"limit-namespace":"all","max-workflow-retries":30,"metadata-prefix":"metadata/propeller","metrics-prefix":"flyte","prof-port":10254,"queue":{"batch-size":-1,"batching-interval":"2s","queue":{"base-delay":"5s","capacity":1000,"max-delay":"120s","rate":100,"type":"maxof"},"sub-queue":{"capacity":100,"rate":10,"type":"bucket"},"type":"batch"},"rawoutput-prefix":"{{ tpl .Values.metadataBucketPrefix $ }}","workers":4,"workflow-reeval-duration":"30s"}` | follows the structure specified [here](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/config). |
| union.configmap.enabled_plugins.tasks | object | `{"task-plugins":{"default-for-task-types":{"container":"container","container_array":"k8s-array","sidecar":"sidecar"},"enabled-plugins":["container","sidecar","k8s-array"]}}` | Tasks specific configuration [structure](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/nodes/task/config#GetConfig) |
| union.configmap.enabled_plugins.tasks.task-plugins | object | `{"default-for-task-types":{"container":"container","container_array":"k8s-array","sidecar":"sidecar"},"enabled-plugins":["container","sidecar","k8s-array"]}` | Plugins configuration, [structure](https://pkg.go.dev/github.com/flyteorg/flytepropeller/pkg/controller/nodes/task/config#TaskPluginConfig) |
| union.configmap.enabled_plugins.tasks.task-plugins.enabled-plugins | list | `["container","sidecar","k8s-array"]` | [Enabled Plugins](https://pkg.go.dev/github.com/lyft/flyteplugins/go/tasks/config#Config). Enable sagemaker*, athena if you install the backend plugins |
| union.configmap.k8s | object | `{"plugins":{"k8s":{"default-cpus":"100m","default-memory":"100Mi"}}}` | Kubernetes specific Flyte configuration |
| union.configmap.k8s.plugins.k8s | object | `{"default-cpus":"100m","default-memory":"100Mi"}` | Configuration section for all K8s specific plugins [Configuration structure](https://pkg.go.dev/github.com/lyft/flyteplugins/go/tasks/pluginmachinery/flytek8s/config) |
| union.configmap.logger | object | `{"logger":{"level":4,"show-source":true}}` | Logger configuration |
| union.configmap.resource_manager | object | `{"propeller":{"resourcemanager":{"type":"noop"}}}` | Resource manager configuration |
| union.configmap.resource_manager.propeller | object | `{"resourcemanager":{"type":"noop"}}` | resource manager configuration |
| union.configmap.task_logs | object | `{"plugins":{"logs":{"cloudwatch-enabled":false,"kubernetes-enabled":true}}}` | Section that configures how the Task logs are displayed on the UI. This has to be changed based on your actual logging provider. Refer to [structure](https://pkg.go.dev/github.com/lyft/flyteplugins/go/tasks/logs#LogConfig) to understand how to configure various logging engines |
| union.configmap.task_logs.plugins.logs.cloudwatch-enabled | bool | `false` | One option is to enable cloudwatch logging for EKS, update the region and log group accordingly |
| union.datacatalog.enabled | bool | `false` |  |
| union.enableTunnelService | bool | `false` | Enable the usage of tunnel service using cloudflare tunnels. This works only if the union services has this service enabled. |
| union.enabled | bool | `true` | Mark cluster as healthy and ready to accept incoming workflows |
| union.flyteadmin.enabled | bool | `false` |  |
| union.flyteconsole.enabled | bool | `false` |  |
| union.flytepropeller.affinity | object | `{}` | affinity for Flytepropeller deployment |
| union.flytepropeller.cacheSizeMbs | int | `0` |  |
| union.flytepropeller.client_secret | string | `"foobar"` |  |
| union.flytepropeller.clusterName | string | `" {{- $previous := lookup \"v1\" \"Secret\" (.Release.Namespace) (printf \"%v-cluster-name\" (include \"union-operator.fullname\" .)) -}} {{- if (tpl .Values.clusterName .) -}} {{- (tpl .Values.clusterName .) -}} {{- else if $previous -}} {{- $previous.data.cluster_name | b64dec -}} {{- else -}} {{- $newName := include \"newClusterName\" . -}} {{- $newName -}} {{- end -}}"` |  |
| union.flytepropeller.configPath | string | `"/etc/flyte/config/*.yaml"` | Default regex string for searching configuration files |
| union.flytepropeller.enabled | bool | `true` |  |
| union.flytepropeller.manager | bool | `true` |  |
| union.flytepropeller.nodeSelector | object | `{}` | nodeSelector for Flytepropeller deployment |
| union.flytepropeller.podAnnotations | object | `{}` | Annotations for Flytepropeller pods |
| union.flytepropeller.replicaCount | int | `1` | Replicas count for Flytepropeller deployment |
| union.flytepropeller.resources | object | `{"limits":{"cpu":"4","ephemeral-storage":"500Mi","memory":"8Gi"},"requests":{"cpu":"1","ephemeral-storage":"100Mi","memory":"500Mi"}}` | Default resources requests and limits for Flytepropeller deployment |
| union.flytepropeller.serviceAccount | object | `{"annotations":{},"create":true,"imagePullSecrets":{}}` | Configuration for service accounts for FlytePropeller |
| union.flytepropeller.serviceAccount.annotations | object | `{}` | Annotations for ServiceAccount attached to FlytePropeller pods |
| union.flytepropeller.serviceAccount.create | bool | `true` | Should a service account be created for FlytePropeller |
| union.flytepropeller.serviceAccount.imagePullSecrets | object | `{}` | ImapgePullSecrets to automatically assign to the service account |
| union.flytepropeller.tolerations | list | `[]` | tolerations for Flytepropeller deployment |
| union.flytescheduler.enabled | bool | `false` |  |
| union.metadataBucketPrefix | string | `"s3://my-s3-bucket"` |  |
| union.secrets.adminOauthClientCredentials.clientSecret | string | `"{{ tpl .Values.appSecret . }}"` |  |
| union.secrets.create | bool | `true` |  |
| union.sparkoperator | object | `{"enabled":false,"plugin_config":{"plugins":{"spark":{"spark-config-default":[{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.DefaultAWSCredentialsProviderChain"},{"spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version":"2"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.multipart.threshold":"536870912"},{"spark.blacklist.enabled":"true"},{"spark.blacklist.timeout":"5m"},{"spark.task.maxfailures":"8"}]}}}}` | Optional: Spark Plugin using the Spark Operator |
| union.sparkoperator.enabled | bool | `false` | - enable or disable Sparkoperator deployment installation |
| union.sparkoperator.plugin_config | object | `{"plugins":{"spark":{"spark-config-default":[{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.DefaultAWSCredentialsProviderChain"},{"spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version":"2"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.multipart.threshold":"536870912"},{"spark.blacklist.enabled":"true"},{"spark.blacklist.timeout":"5m"},{"spark.task.maxfailures":"8"}]}}}` | Spark plugin configuration |
| union.sparkoperator.plugin_config.plugins.spark.spark-config-default | list | `[{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.DefaultAWSCredentialsProviderChain"},{"spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version":"2"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3a.multipart.threshold":"536870912"},{"spark.blacklist.enabled":"true"},{"spark.blacklist.timeout":"5m"},{"spark.task.maxfailures":"8"}]` | Spark default configuration |
| union.storage.bucketName | string | `"my-s3-bucket-prod"` |  |
| union.storage.custom | object | `{}` | Settings for storage type custom. See https://github:com/graymeta/stow for supported storage providers/settings. |
| union.storage.gcs | string | `nil` | settings for storage type gcs |
| union.storage.s3 | object | `{"region":"us-east-1"}` | settings for storage type s3 |
| union.storage.type | string | `"sandbox"` | Sets the storage type. Supported values are sandbox, s3, gcs and custom. |
| union.unionoperator | object | `{"affinity":{},"autoscaling":{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80},"configmapOverrides":{},"fullnameOverride":"","image":{"pullPolicy":"IfNotPresent","repository":"public.ecr.aws/p0i0a9q8/unionoperator","tag":"8e7f61345d4b30617a9d3cf6184acfd6f60c074e"},"imagePullSecrets":[],"nameOverride":"","nodeSelector":{},"podAnnotations":{"prometheus.io/path":"/metrics","prometheus.io/port":"10254","prometheus.io/scrape":"true"},"podSecurityContext":{},"priorityClassName":"system-cluster-critical","replicaCount":1,"resources":{"limits":{"cpu":"4","ephemeral-storage":"500Mi","memory":"8Gi"},"requests":{"cpu":"1","ephemeral-storage":"100Mi","memory":"500Mi"}},"securityContext":{},"service":{"port":80,"type":"ClusterIP"},"serviceAccount":{"annotations":{},"create":true,"name":""},"tolerations":[]}` | ---------------------------------------------------- |
| union.userRoleAnnotationKey | string | `"foo"` |  |
| union.userRoleAnnotationValue | string | `"bar"` |  |
| union.webhook.enabled | bool | `true` | enable or disable secrets webhook |
| union.webhook.podAnnotations | object | `{}` | Annotations for webhook pods |
| union.webhook.service | object | `{"annotations":{"projectcontour.io/upstream-protocol.h2c":"grpc"},"type":"ClusterIP"}` | Service settings for the webhook |
| union.webhook.serviceAccount | object | `{"annotations":{},"create":true,"imagePullSecrets":{}}` | Configuration for service accounts for the webhook |
| union.webhook.serviceAccount.annotations | object | `{}` | Annotations for ServiceAccount attached to the webhook |
| union.webhook.serviceAccount.create | bool | `true` | Should a service account be created for the webhook |
| union.webhook.serviceAccount.imagePullSecrets | object | `{}` | ImapgePullSecrets to automatically assign to the service account |
