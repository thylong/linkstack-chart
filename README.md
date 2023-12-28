# linkstack

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-yellow.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![Release Charts](https://github.com/thylong/linkstack-chart/actions/workflows/release.yml/badge.svg)](https://github.com/thylong/linkstack-chart/actions/workflows/release.yml)
![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A LinkStack unofficial Helm chart

This helm chart offers a way to schedule a [linstack](https://linkstack.org/) instance on a K8s cluster.

The chart currently supports:
- Basic setup with sqlite as backend
- Basic setup with mysql as backend
- PersistentVolume to store data

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

```bash
helm repo add linkstack http://thylong.com/linkstack-chart/
```

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
linkstack` to see the charts.

### Install

```bash
helm install -f values.yaml linkstack .
```

### Uninstall

```bash
helm uninstall linkstack
```

## Features considered

- [ ] Optional pre-defined Network Policy
- [ ] Optional pre-defined securityContext
- [ ] Already setup linkstack installation through Helm

## References

**Homepage:** <https://linkstack.org/>

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

## License

[![License: AGPL v3](https://img.lss.ovh/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

As of version 4.0.0, the license for this project has been updated to the GNU Affero General Public License v3.0, which explicitly requires that any modifications made to the project must be made public. This license also requires that a copyright notice and license notice be included in any copies or derivative works of the project.

Additionally, any changes made to the project must be clearly stated, and the source code for the modified version must be made available to anyone who receives the modified version. Network use of the project is also considered distribution, and as such, any network use of the project must comply with the terms of the license.

Finally, any derivative works of the project must be licensed under the same license terms as the original project.

[Read more here](https://www.gnu.org/licenses/agpl-3.0)
