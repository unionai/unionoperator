# union-operator

![Version: v0.0.1](https://img.shields.io/badge/Version-v0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.0.1](https://img.shields.io/badge/AppVersion-v0.0.1-informational?style=flat-square)

Deploys Union Operator to onboard a k8s cluster to Union Cloud

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://flyteorg.github.io/flyte/ | union(flyte-core) | v1.6.0 |
| https://opencost.github.io/opencost-helm-chart | opencost | v1.12.0 |

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
| minio.persistence.enabled | bool | `false` |  |
| minio.persistence.persistentVolumeClaimName | string | `""` |  |
| minio.podAnnotations | object | `{}` | Annotations for Minio pods |
| minio.replicaCount | int | `1` | Replicas count for Minio deployment |
| minio.resources | object | `{"limits":{"cpu":"200m","memory":"512Mi"},"requests":{"cpu":"10m","memory":"128Mi"}}` | Default resources requests and limits for Minio deployment |
| minio.resources.limits | object | `{"cpu":"200m","memory":"512Mi"}` | Limits are the maximum set of resources needed for this pod |
| minio.resources.requests | object | `{"cpu":"10m","memory":"128Mi"}` | Requests are the minimum set of resources needed for this pod |
| minio.service | object | `{"annotations":{},"type":"ClusterIP"}` | Service settings for Minio |
| minio.tolerations | list | `[]` | tolerations for Minio deployment |
| opencost.fullnameOverride | string | `"opencost"` |  |
| opencost.opencost.prometheus.external.enabled | bool | `false` |  |
| opencost.opencost.prometheus.internal.enabled | bool | `false` |  |
| opencost.opencost.ui.enabled | bool | `false` |  |
| union.appId | string | `"<App Id from uctl create app>"` |  |
| union.appSecret | string | `"<App Secret from uctl create app>"` |  |
| union.cloudUrl | string | `"<Union Cloud URL>"` |  |
| union.clusterName | string | `""` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[0].production[0].projectQuotaCpu.value | string | `"4096"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[0].production[1].projectQuotaMemory.value | string | `"2Ti"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[0].production[2].projectQuotaNvidiaGpu.value | string | `"256"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[0].production[3].defaultUserRoleKey.value | string | `"{{ tpl .Values.userRoleAnnotationKey . }}"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[0].production[4].defaultUserRoleValue.value | string | `"{{ tpl .Values.userRoleAnnotationValue . }}"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[1].staging[0].projectQuotaCpu.value | string | `"4096"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[1].staging[1].projectQuotaMemory.value | string | `"2Ti"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[1].staging[2].projectQuotaNvidiaGpu.value | string | `"256"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[1].staging[3].defaultUserRoleKey.value | string | `"{{ tpl .Values.userRoleAnnotationKey . }}"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[1].staging[4].defaultUserRoleValue.value | string | `"{{ tpl .Values.userRoleAnnotationValue . }}"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[2].development[0].projectQuotaCpu.value | string | `"4096"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[2].development[1].projectQuotaMemory.value | string | `"2Ti"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[2].development[2].projectQuotaNvidiaGpu.value | string | `"256"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[2].development[3].defaultUserRoleKey.value | string | `"{{ tpl .Values.userRoleAnnotationKey . }}"` |  |
| union.cluster_resource_manager.config.cluster_resources.customData[2].development[4].defaultUserRoleValue.value | string | `"{{ tpl .Values.userRoleAnnotationValue . }}"` |  |
| union.cluster_resource_manager.config.cluster_resources.standaloneDeployment | bool | `true` |  |
| union.cluster_resource_manager.enabled | bool | `true` |  |
| union.cluster_resource_manager.service_account_name | string | `"clustersync-resource"` |  |
| union.cluster_resource_manager.standalone_deploy | bool | `true` |  |
| union.cluster_resource_manager.templates[0] | object | `{"key":"a_namespace.yaml","value":"apiVersion: v1\nkind: Namespace\nmetadata:\n  name: {{ namespace }}\nspec:\n  finalizers:\n  - kubernetes\n"}` | Template for namespaces resources |
| union.cluster_resource_manager.templates[1] | object | `{"key":"b_default_service_account.yaml","value":"apiVersion: v1\nkind: ServiceAccount\nmetadata:\n  name: default\n  namespace: {{ namespace }}\n  annotations:\n    {{ defaultUserRoleKey }}: {{ defaultUserRoleValue }}\n"}` | Patch default service account |
| union.cluster_resource_manager.templates[2].key | string | `"c_project_resource_quota.yaml"` |  |
| union.cluster_resource_manager.templates[2].value | string | `"apiVersion: v1\nkind: ResourceQuota\nmetadata:\n  name: project-quota\n  namespace: {{ namespace }}\nspec:\n  hard:\n    limits.cpu: {{ projectQuotaCpu }}\n    limits.memory: {{ projectQuotaMemory }}\n    requests.nvidia.com/gpu: {{ projectQuotaNvidiaGpu }}\n"` |  |
| union.collectUsages.enabled | bool | `false` |  |
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
| union.flytepropeller.serviceAccount | object | `{"annotations":{},"create":true,"imagePullSecrets":[]}` | Configuration for service accounts for FlytePropeller |
| union.flytepropeller.serviceAccount.annotations | object | `{}` | Annotations for ServiceAccount attached to FlytePropeller pods |
| union.flytepropeller.serviceAccount.create | bool | `true` | Should a service account be created for FlytePropeller |
| union.flytepropeller.serviceAccount.imagePullSecrets | list | `[]` | ImapgePullSecrets to automatically assign to the service account |
| union.flytepropeller.tolerations | list | `[]` | tolerations for Flytepropeller deployment |
| union.flytescheduler.enabled | bool | `false` |  |
| union.metadataBucketPrefix | string | `"s3://my-s3-bucket"` |  |
| union.proxy.autoscaling.enabled | bool | `false` |  |
| union.proxy.autoscaling.maxReplicas | int | `100` |  |
| union.proxy.autoscaling.minReplicas | int | `1` |  |
| union.proxy.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| union.proxy.prof-port | int | `10254` |  |
| union.proxy.replicaCount | int | `2` |  |
| union.proxy.resources.limits.cpu | string | `"4"` |  |
| union.proxy.resources.limits.ephemeral-storage | string | `"500Mi"` |  |
| union.proxy.resources.limits.memory | string | `"8Gi"` |  |
| union.proxy.resources.requests.cpu | string | `"1"` |  |
| union.proxy.resources.requests.ephemeral-storage | string | `"100Mi"` |  |
| union.proxy.resources.requests.memory | string | `"500Mi"` |  |
| union.proxy.service.port | int | `8080` |  |
| union.proxy.serviceAccount.annotations | object | `{}` |  |
| union.proxy.serviceAccount.create | bool | `true` |  |
| union.proxy.serviceAccount.name | string | `""` |  |
| union.secrets.adminOauthClientCredentials.clientSecret | string | `"{{ tpl .Values.appSecret . }}"` |  |
| union.secrets.create | bool | `true` |  |
| union.sparkoperator | object | `{"enabled":false,"plugin_config":{"plugins":{"spark":{"spark-config-default":[{"spark.driver.cores":"1"},{"spark.executorEnv.HTTP2_DISABLE":"true"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.kubernetes.driverEnv.HTTP2_DISABLE":"true"},{"spark.network.timeout":"600s"},{"spark.executorEnv.KUBERNETES_REQUEST_TIMEOUT":100000},{"spark.executorEnv.AWS_METADATA_SERVICE_NUM_ATTEMPTS":20},{"spark.executorEnv.AWS_METADATA_SERVICE_TIMEOUT":5},{"spark.executor.heartbeatInterval":"60s"},{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.WebIdentityTokenCredentialsProvider"}]}}}}` | Optional: Spark Plugin using the Spark Operator |
| union.sparkoperator.enabled | bool | `false` | - enable or disable Sparkoperator deployment installation |
| union.sparkoperator.plugin_config | object | `{"plugins":{"spark":{"spark-config-default":[{"spark.driver.cores":"1"},{"spark.executorEnv.HTTP2_DISABLE":"true"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.kubernetes.driverEnv.HTTP2_DISABLE":"true"},{"spark.network.timeout":"600s"},{"spark.executorEnv.KUBERNETES_REQUEST_TIMEOUT":100000},{"spark.executorEnv.AWS_METADATA_SERVICE_NUM_ATTEMPTS":20},{"spark.executorEnv.AWS_METADATA_SERVICE_TIMEOUT":5},{"spark.executor.heartbeatInterval":"60s"},{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.WebIdentityTokenCredentialsProvider"}]}}}` | Spark plugin configuration |
| union.sparkoperator.plugin_config.plugins.spark.spark-config-default | list | `[{"spark.driver.cores":"1"},{"spark.executorEnv.HTTP2_DISABLE":"true"},{"spark.hadoop.fs.AbstractFileSystem.s3.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.AbstractFileSystem.s3a.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.AbstractFileSystem.s3n.impl":"org.apache.hadoop.fs.s3a.S3A"},{"spark.hadoop.fs.s3.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.s3a.acl.default":"BucketOwnerFullControl"},{"spark.hadoop.fs.s3a.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.hadoop.fs.s3n.impl":"org.apache.hadoop.fs.s3a.S3AFileSystem"},{"spark.kubernetes.allocation.batch.size":"50"},{"spark.kubernetes.driverEnv.HTTP2_DISABLE":"true"},{"spark.network.timeout":"600s"},{"spark.executorEnv.KUBERNETES_REQUEST_TIMEOUT":100000},{"spark.executorEnv.AWS_METADATA_SERVICE_NUM_ATTEMPTS":20},{"spark.executorEnv.AWS_METADATA_SERVICE_TIMEOUT":5},{"spark.executor.heartbeatInterval":"60s"},{"spark.hadoop.fs.s3a.aws.credentials.provider":"com.amazonaws.auth.WebIdentityTokenCredentialsProvider"}]` | Spark default configuration |
| union.storage.bucketName | string | `"my-s3-bucket-prod"` |  |
| union.storage.custom | object | `{}` | Settings for storage type custom. See https://github:com/graymeta/stow for supported storage providers/settings. |
| union.storage.gcs | string | `nil` | settings for storage type gcs |
| union.storage.s3 | object | `{"region":"us-east-1"}` | settings for storage type s3 |
| union.storage.type | string | `"sandbox"` | Sets the storage type. Supported values are sandbox, s3, gcs and custom. |
| union.unionoperator | object | `{"affinity":{},"autoscaling":{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80},"configmapOverrides":{},"fullnameOverride":"","image":{"pullPolicy":"IfNotPresent","repository":"public.ecr.aws/p0i0a9q8/unionoperator","tag":"d16bb9892ee0919296f6e462542bb1c6e54823fd"},"imagePullSecrets":[],"nameOverride":"","nodeSelector":{},"podAnnotations":{"prometheus.io/path":"/metrics","prometheus.io/port":"10254","prometheus.io/scrape":"true"},"podSecurityContext":{},"priorityClassName":"system-cluster-critical","replicaCount":1,"resources":{"limits":{"cpu":"4","ephemeral-storage":"500Mi","memory":"8Gi"},"requests":{"cpu":"1","ephemeral-storage":"100Mi","memory":"500Mi"}},"securityContext":{},"service":{"port":80,"type":"ClusterIP"},"serviceAccount":{"annotations":{},"create":true,"name":""},"tolerations":[]}` | ---------------------------------------------------- |
| union.unionoperatorMonitoring.dcgmExporter.arguments[0] | string | `"-f"` |  |
| union.unionoperatorMonitoring.dcgmExporter.arguments[1] | string | `"/etc/dcgm-exporter/dcp-metrics-included.csv"` |  |
| union.unionoperatorMonitoring.dcgmExporter.image.pullPolicy | string | `"IfNotPresent"` |  |
| union.unionoperatorMonitoring.dcgmExporter.image.repository | string | `"nvcr.io/nvidia/k8s/dcgm-exporter"` |  |
| union.unionoperatorMonitoring.dcgmExporter.image.tag | string | `"3.1.7-3.1.4-ubuntu20.04"` |  |
| union.unionoperatorMonitoring.dcgmExporter.kubeletPath | string | `"/var/lib/kubelet/pod-resources"` |  |
| union.unionoperatorMonitoring.dcgmExporter.nodeSelector.ami_type | string | `"AL2_x86_64_GPU"` |  |
| union.unionoperatorMonitoring.dcgmExporter.podSecurityContext | object | `{}` |  |
| union.unionoperatorMonitoring.dcgmExporter.resources.limits.cpu | string | `"100m"` |  |
| union.unionoperatorMonitoring.dcgmExporter.resources.limits.ephemeral-storage | string | `"500Mi"` |  |
| union.unionoperatorMonitoring.dcgmExporter.resources.limits.memory | string | `"400Mi"` |  |
| union.unionoperatorMonitoring.dcgmExporter.resources.requests.cpu | string | `"100m"` |  |
| union.unionoperatorMonitoring.dcgmExporter.resources.requests.ephemeral-storage | string | `"500Mi"` |  |
| union.unionoperatorMonitoring.dcgmExporter.resources.requests.memory | string | `"128Mi"` |  |
| union.unionoperatorMonitoring.dcgmExporter.securityContext.capabilities.add[0] | string | `"SYS_ADMIN"` |  |
| union.unionoperatorMonitoring.dcgmExporter.securityContext.runAsNonRoot | bool | `false` |  |
| union.unionoperatorMonitoring.dcgmExporter.securityContext.runAsUser | int | `0` |  |
| union.unionoperatorMonitoring.dcgmExporter.service.address | string | `":9400"` |  |
| union.unionoperatorMonitoring.dcgmExporter.service.port | int | `9400` |  |
| union.unionoperatorMonitoring.dcgmExporter.service.type | string | `"ClusterIP"` |  |
| union.unionoperatorMonitoring.dcgmExporter.serviceAccount.annotations | object | `{}` |  |
| union.unionoperatorMonitoring.dcgmExporter.serviceAccount.create | bool | `true` |  |
| union.unionoperatorMonitoring.dcgmExporter.serviceAccount.name | string | `""` |  |
| union.unionoperatorMonitoring.dcgmExporter.tolerations[0].effect | string | `"NoSchedule"` |  |
| union.unionoperatorMonitoring.dcgmExporter.tolerations[0].key | string | `"nvidia.com/gpu"` |  |
| union.unionoperatorMonitoring.dcgmExporter.tolerations[0].operator | string | `"Exists"` |  |
| union.unionoperatorMonitoring.dcgmExporter.tolerations[1].effect | string | `"NoSchedule"` |  |
| union.unionoperatorMonitoring.dcgmExporter.tolerations[1].key | string | `"flyte.org/node-role"` |  |
| union.unionoperatorMonitoring.dcgmExporter.tolerations[1].operator | string | `"Exists"` |  |
| union.unionoperatorMonitoring.enabled | bool | `false` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.autoscaling.enabled | bool | `false` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.image.pullPolicy | string | `"IfNotPresent"` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.image.repository | string | `"registry.k8s.io/kube-state-metrics/kube-state-metrics"` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.image.tag | string | `"v2.8.1"` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.podSecurityContext | object | `{}` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.replicaCount | int | `1` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.resources.limits.cpu | string | `"4"` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.resources.limits.ephemeral-storage | string | `"500Mi"` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.resources.limits.memory | string | `"8Gi"` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.resources.requests.cpu | string | `"1"` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.resources.requests.ephemeral-storage | string | `"100Mi"` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.resources.requests.memory | string | `"500Mi"` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.service.port | int | `8080` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.service.type | string | `"ClusterIP"` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.serviceAccount.annotations | object | `{}` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.serviceAccount.create | bool | `true` |  |
| union.unionoperatorMonitoring.kubeStateMetrics.serviceAccount.name | string | `""` |  |
| union.unionoperatorMonitoring.opencost.enabled | bool | `false` |  |
| union.unionoperatorMonitoring.opencost.scrape | bool | `false` |  |
| union.unionoperatorMonitoring.prometheus.autoscaling.enabled | bool | `false` |  |
| union.unionoperatorMonitoring.prometheus.externalUrl | string | `"/prometheus/"` |  |
| union.unionoperatorMonitoring.prometheus.image.pullPolicy | string | `"IfNotPresent"` |  |
| union.unionoperatorMonitoring.prometheus.image.repository | string | `"prom/prometheus"` |  |
| union.unionoperatorMonitoring.prometheus.image.tag | string | `"v2.43.0"` |  |
| union.unionoperatorMonitoring.prometheus.podSecurityContext.fsGroup | int | `2000` |  |
| union.unionoperatorMonitoring.prometheus.podSecurityContext.runAsNonRoot | bool | `true` |  |
| union.unionoperatorMonitoring.prometheus.podSecurityContext.runAsUser | int | `1000` |  |
| union.unionoperatorMonitoring.prometheus.replicaCount | int | `1` |  |
| union.unionoperatorMonitoring.prometheus.resources.limits.cpu | string | `"4"` |  |
| union.unionoperatorMonitoring.prometheus.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| union.unionoperatorMonitoring.prometheus.resources.limits.memory | string | `"8Gi"` |  |
| union.unionoperatorMonitoring.prometheus.resources.requests.cpu | string | `"1"` |  |
| union.unionoperatorMonitoring.prometheus.resources.requests.ephemeral-storage | string | `"500Mi"` |  |
| union.unionoperatorMonitoring.prometheus.resources.requests.memory | string | `"500Mi"` |  |
| union.unionoperatorMonitoring.prometheus.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| union.unionoperatorMonitoring.prometheus.service.port | int | `80` |  |
| union.unionoperatorMonitoring.prometheus.service.type | string | `"ClusterIP"` |  |
| union.unionoperatorMonitoring.prometheus.serviceAccount.annotations | object | `{}` |  |
| union.unionoperatorMonitoring.prometheus.serviceAccount.create | bool | `true` |  |
| union.unionoperatorMonitoring.prometheus.serviceAccount.name | string | `""` |  |
| union.unionoperatorMonitoring.prometheus.storage.className | string | `"gp2"` |  |
| union.unionoperatorMonitoring.prometheus.storage.persistent | bool | `false` |  |
| union.unionoperatorMonitoring.prometheus.storage.retention.size | string | `"400MB"` |  |
| union.unionoperatorMonitoring.prometheus.storage.sizePerReplica | string | `"1Gi"` |  |
| union.unionoperatorSparkHistoryServer.affinity | object | `{}` |  |
| union.unionoperatorSparkHistoryServer.autoscaling.enabled | bool | `false` |  |
| union.unionoperatorSparkHistoryServer.autoscaling.maxReplicas | int | `10` |  |
| union.unionoperatorSparkHistoryServer.autoscaling.minReplicas | int | `1` |  |
| union.unionoperatorSparkHistoryServer.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| union.unionoperatorSparkHistoryServer.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| union.unionoperatorSparkHistoryServer.configmapOverrides | object | `{}` |  |
| union.unionoperatorSparkHistoryServer.enabled | bool | `false` |  |
| union.unionoperatorSparkHistoryServer.image.pullPolicy | string | `"IfNotPresent"` |  |
| union.unionoperatorSparkHistoryServer.image.repository | string | `"ghcr.io/flyteorg/flytecookbook"` |  |
| union.unionoperatorSparkHistoryServer.image.tag | string | `"k8s_spark-a3b97943563cfc952b5683525763578685a93694"` |  |
| union.unionoperatorSparkHistoryServer.nodeSelector | object | `{}` |  |
| union.unionoperatorSparkHistoryServer.podSecurityContext | object | `{}` |  |
| union.unionoperatorSparkHistoryServer.replicaCount | int | `1` |  |
| union.unionoperatorSparkHistoryServer.resources.limits.cpu | string | `"4"` |  |
| union.unionoperatorSparkHistoryServer.resources.limits.ephemeral-storage | string | `"500Mi"` |  |
| union.unionoperatorSparkHistoryServer.resources.limits.memory | string | `"8Gi"` |  |
| union.unionoperatorSparkHistoryServer.resources.requests.cpu | string | `"1"` |  |
| union.unionoperatorSparkHistoryServer.resources.requests.ephemeral-storage | string | `"100Mi"` |  |
| union.unionoperatorSparkHistoryServer.resources.requests.memory | string | `"500Mi"` |  |
| union.unionoperatorSparkHistoryServer.securityContext.allowPrivilegeEscalation | bool | `true` |  |
| union.unionoperatorSparkHistoryServer.securityContext.runAsUser | int | `0` |  |
| union.unionoperatorSparkHistoryServer.service.port | int | `80` |  |
| union.unionoperatorSparkHistoryServer.service.type | string | `"ClusterIP"` |  |
| union.unionoperatorSparkHistoryServer.serviceAccount.annotations | object | `{}` |  |
| union.unionoperatorSparkHistoryServer.serviceAccount.create | bool | `true` |  |
| union.unionoperatorSparkHistoryServer.serviceAccount.name | string | `""` |  |
| union.unionoperatorSparkHistoryServer.tolerations | list | `[]` |  |
| union.userRoleAnnotationKey | string | `"foo"` |  |
| union.userRoleAnnotationValue | string | `"bar"` |  |
| union.webhook.enabled | bool | `true` | enable or disable secrets webhook |
| union.webhook.podAnnotations | object | `{}` | Annotations for webhook pods |
| union.webhook.service | object | `{"annotations":{"projectcontour.io/upstream-protocol.h2c":"grpc"},"type":"ClusterIP"}` | Service settings for the webhook |
| union.webhook.serviceAccount | object | `{"annotations":{},"create":true,"imagePullSecrets":[]}` | Configuration for service accounts for the webhook |
| union.webhook.serviceAccount.annotations | object | `{}` | Annotations for ServiceAccount attached to the webhook |
| union.webhook.serviceAccount.create | bool | `true` | Should a service account be created for the webhook |
| union.webhook.serviceAccount.imagePullSecrets | list | `[]` | ImapgePullSecrets to automatically assign to the service account |
