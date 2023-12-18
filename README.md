# linkstack

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A LinkStack unofficial Helm chart

**Homepage:** <https://linkstack.org/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Théotime LEVEQUE | <thylong@pm.me> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity rules to constrain pod scheduling to specific node(s) matching rules. |
| autoscaling | object | `{"enabled":false,"maxReplicas":10,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | HPA rules. |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"linkstackorg/linkstack"` |  |
| image.tag | string | `"latest"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` | Name of the ingress class to route through this application |
| ingress.enabled | bool | `false` |  |
| linkstack | object | `{"backend":"sqlite","env":{"log_level":"info","php_memory_limit":"512M","tz":"Europe/Paris","upload_max_filesize":"8M"}}` | Linkstack specific configuration |
| linkstack.backend | string | `"sqlite"` | Datastore to use (either sqlite or mysql) |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | Assign pods to nodes matching specific label. |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` | Number of linkstack pods |
| resources | object | `{"limits":{"cpu":"250m","memory":"512Mi"},"requests":{"cpu":"250m","memory":"512Mi"}}` | The following values aligned with linkstack default PHP values. |
| resources.limits.memory | string | `"512Mi"` | PHP_MEMORY_LIMIT should be adjusted accordingly |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | Tolerations lift taint constraints with a tradeoff on scheduling guarantees. |
| volumeMounts | list | `[{"mountPath":"/htdocs","name":"linkstack-sqlite","readOnly":false}]` | Additional volumeMounts on the output Deployment definition. |
| volumes | list | `[{"name":"linkstack-sqlite","persistentVolumeClaim":{"claimName":"linkstack-sqlite-pvc"}}]` | Additional volumes on the output Deployment definition. |
