{{- define "helloworld-expressjs.fullname" -}}
{{- .Release.Name }}-{{ .Chart.Name }}
{{- end }}

{{- define "helloworld-expressjs.name" -}}
{{- .Chart.Name }}
{{- end }}
