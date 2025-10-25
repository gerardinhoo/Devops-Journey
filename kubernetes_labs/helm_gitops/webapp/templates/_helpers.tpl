{{- define "webapp.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "webapp.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "webapp.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "webapp.labels" -}}
app.kubernetes.io/name: {{ include "webapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "webapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "webapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "webapp.serviceAccountName" -}}
{{- default (include "webapp.fullname" .) .Values.serviceAccount.name -}}
{{- end -}}
