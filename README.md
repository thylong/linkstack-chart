# linkstack

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A LinkStack unofficial Helm chart

This helm chart offers a way to schedule a [linkstack](https://linkstack.org/) instance on a K8s cluster.

The chart currently supports:
- Basic setup with sqlite as backend
- Basic setup with mysql as backend
- PersistentVolume to store data

## Getting Started

### Requirement

Helm (version >= 3) and a functional kubernetes cluster (>=1.24) are the sole dependencies.

## Install

To install a simple linkstack instance with sqlite as a backend:
```bash
helm repo add linkstack https://thylong.github.io/linkstack-chart

helm install linkstack linkstack/linkstack
```

### Enable litestream

You can provide a `values.yaml` file with custom configuration.
To run sqlite with [litestream](https://litestream.io/) as a sidecar, create the following file:

```yaml
# Example of values.yaml
# [...]
litestream:
  enabled: true
  image:
    repository: litestream/litestream
    pullPolicy: IfNotPresent
    tag: "latest"
  limits:
    cpu: 250m
    memory: 256Mi
  requests:
    cpu: 125m
    memory: 128Mi
  path: /htdocs/database/database.sqlite
  url: "s3://<your_s3_bucket>/<path_to_specific_directory>"
  region: "<your_s3_bucket_region>"
  skipVerify: true
  volumeMounts:
    - name: linkstack-litestream
      mountPath: /etc/litestream.yml
      subPath: litestream.yml
# [...]
```

Your will have to create a K8s secret to access the S3 bucket:

```bash
kubectl create secret generic litestream \
    --from-literal=LITESTREAM_ACCESS_KEY_ID="my_access_key_id" \
    --from-literal=LITESTREAM_SECRET_ACCESS_KEY="my_secret_access_key"
```

Then run :

```bash
helm repo add linkstack https://thylong.github.io/linkstack-chart

helm install linkstack linkstack/linkstack --values=values.yaml
```

## Features considered

- [x] Optional pre-defined Network Policy
- [x] Optional pre-defined securityContext
- [x] SQLite disaster recovery with litestream
- [ ] Already setup linkstack installation through Helm

## References

**Homepage:** <https://linkstack.org/>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity rules to constrain pod scheduling to specific node(s) matching rules. |
| autoscaling | object | `{"enabled":false,"maxReplicas":10,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | HPA rules. |
| fullnameOverride | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` | Name of the ingress class to route through this application |
| ingress.enabled | bool | `false` |  |
| linkstack | object | `{"backend":"sqlite","env":{"log_level":"info","php_memory_limit":"512M","tz":"Europe/Paris","upload_max_filesize":"8M"},"image":{"pullPolicy":"IfNotPresent","repository":"linkstackorg/linkstack","tag":"latest"},"resources":{"limits":{"cpu":"250m","memory":"512Mi"},"requests":{"cpu":"250m","memory":"512Mi"}},"volumeMounts":[{"mountPath":"/htdocs","name":"linkstack-sqlite","readOnly":false}]}` | Linkstack container specific configuration |
| linkstack.backend | string | `"sqlite"` | Datastore to use (either sqlite or mysql) |
| linkstack.resources.limits.memory | string | `"512Mi"` | PHP_MEMORY_LIMIT should be adjusted accordingly |
| linkstack.volumeMounts | list | `[{"mountPath":"/htdocs","name":"linkstack-sqlite","readOnly":false}]` | Additional volumeMounts on the output Deployment definition. |
| litestream | object | `{"enabled":false,"image":{"pullPolicy":"IfNotPresent","repository":"litestream/litestream","tag":"latest"},"path":"/htdocs/database/database.sqlite","region":"eu-west-1","resources":{"limits":{"cpu":"250m","memory":"256Mi"},"requests":{"cpu":"125m","memory":"128Mi"}},"skipVerify":true,"url":"s3://linkstack-backup/litestream","volumeMounts":[{"mountPath":"/etc/litestream.yml","name":"linkstack-litestream","subPath":"litestream.yml"}]}` | Litestream sidecar specific configuration (sqlite disaster-recovery tool) This configuration won't be used if sqlite is not selected as backend. |
| nameOverride | string | `""` |  |
| namespace | string | `""` | Specifies in which namespace linkstack release should be deployed Will be deployed to the default namespace if not specified |
| networkPolicy | object | `{"enabled":false,"ports":[{"port":443},{"port":80}]}` | Restrict network permissions using Kubernetes L4 network policies |
| nodeSelector | object | `{}` | Assign pods to nodes matching specific label. |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` | Number of linkstack pods |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | Tolerations lift taint constraints with a tradeoff on scheduling guarantees. |
| volumes | list | `[{"name":"linkstack-sqlite","persistentVolumeClaim":{"claimName":"linkstack-sqlite-pvc"}},{"configMap":{"name":"linkstack-litestream"},"name":"linkstack-litestream"}]` | Additional volumes on the output Deployment definition. |

## License

[![License: AGPL v3](https://img.lss.ovh/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

As of version 4.0.0, the license for this project has been updated to the GNU Affero General Public License v3.0, which explicitly requires that any modifications made to the project must be made public. This license also requires that a copyright notice and license notice be included in any copies or derivative works of the project.

Additionally, any changes made to the project must be clearly stated, and the source code for the modified version must be made available to anyone who receives the modified version. Network use of the project is also considered distribution, and as such, any network use of the project must comply with the terms of the license.

Finally, any derivative works of the project must be licensed under the same license terms as the original project.

[Read more here](https://www.gnu.org/licenses/agpl-3.0)
