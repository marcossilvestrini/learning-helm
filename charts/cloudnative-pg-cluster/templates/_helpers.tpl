{{/*
Define helper templates and variables here that can be reused in your chart templates.
*/}}

{{/* Common Labels */}}
{{- define "postgresql-chart.labels" -}}
  app: {{ .Chart.Name }}
  release: {{ .Release.Name }}
  heritage: {{ .Release.Service }}
{{- end }}

{{/* Common Selector */}}
{{- define "postgresql-chart.selector" -}}
  {{- with .Labels }}
    {{- . | toYaml | nindent 4 }}
  {{- end }}
{{- end }}

{{/* PostgreSQL Parameters */}}
{{- define "postgresql-chart.parameters" -}}
  parameters:
    shared_buffers: {{ .Values.postgresql.parameters.shared_buffers }}
    pg_stat_statements.max: {{ .Values.postgresql.parameters.pg_stat_statements.max }}
    pg_stat_statements.track: {{ .Values.postgresql.parameters.pg_stat_statements.track }}
    auto_explain.log_min_duration: {{ .Values.postgresql.parameters.auto_explain.log_min_duration }}
{{- end }}

{{/* Storage Configuration */}}
{{- define "postgresql-chart.storage" -}}
  storage:
    size: {{ .Values.storage.size }}
    pvcTemplate:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: {{ .Values.storage.pvcTemplate.resources.requests.storage }}
      storageClassName: {{ .Values.storage.pvcTemplate.storageClassName }}
      volumeMode: {{ .Values.storage.pvcTemplate.volumeMode }}
{{- end }}

{{/* Resources Configuration */}}
{{- define "postgresql-chart.resources" -}}
  resources:
    requests:
      memory: {{ .Values.resources.requests.memory }}
      cpu: {{ .Values.resources.requests.cpu }}
    limits:
      memory: {{ .Values.resources.limits.memory }}
      cpu: {{ .Values.resources.limits.cpu }}
{{- end }}

{{/* Affinity Configuration */}}
{{- define "postgresql-chart.affinity" -}}
  affinity:
    enablePodAntiAffinity: {{ .Values.affinity.enablePodAntiAffinity }}
    topologyKey: {{ .Values.affinity.topologyKey }}
{{- end }}

{{/* Node Maintenance Window Configuration */}}
{{- define "postgresql-chart.nodeMaintenanceWindow" -}}
  nodeMaintenanceWindow:
    inProgress: {{ .Values.nodeMaintenanceWindow.inProgress }}
    reusePVC: {{ .Values.nodeMaintenanceWindow.reusePVC }}
{{- end }}
