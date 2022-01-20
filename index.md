# Union Helm Registry

Add this repository using:

```bash
$ helm repo add unionai https://helm.union.ai
$ helm repo update
```

## Union Operator Helm Chart

The Union Operator Helm Chart helps you to onboard a k8s cluster to Union Cloud

### Install Union Operator

To install Union Operator, the following configuration values must be set:

- `union.cloudUrl`
- `union.appId`
- `union.appSecret`
- `union.clusterName` (Optional: By default helm generates a random string)
- `union.metadataBucketPrefix`

You can create a `values.yaml` file to set the required values, a sample `values.yaml` file is provided below:

#### Production Clusters (Connect directly to s3/gcs/... etc.)
```yaml
union:
  cloudUrl: <Union Cloud URL>
  appId: <App Id from uctl create app>
  appSecret: <App secret from uctl create app>
  metadataBucketPrefix: s3://my-s3-bucket
  unionoperator:
    storage:
      type: "s3" 
      region: "us-east-1"
```

#### Sandbox Clusters (kind, k3s, minikube... etc.)
```yaml
union:
  cloudUrl: <Union Cloud URL>
  appId: <App Id from uctl create app>
  appSecret: <App secret from uctl create app>
  metadataBucketPrefix: s3://my-s3-bucket
  configmap:
    k8s:
      plugins:
        k8s:
          default-env-vars:
            - FLYTE_AWS_ENDPOINT: "http://minio.union.svc.cluster.local:9000"
            - FLYTE_AWS_ACCESS_KEY_ID: minio
            - FLYTE_AWS_SECRET_ACCESS_KEY: miniostorage
```

Install Union Operator by running this command:

```bash
$ helm install -n union -f values.yaml --create-namespace union-operator unionai/union-operator 
```

### Upgrade Union Operator

```bash
$ helm upgrade -n union -f values.yaml --create-namespace union-operator unionai/union-operator
```
