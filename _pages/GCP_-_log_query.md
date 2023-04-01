To clip out just the MESSAGE format of the logs, use jq

`gcloud logging read "logName=projects/losers-dev-1/logs/kubelet" --limit 10 --format json | jq '.[].jsonPayload.MESSAGE`