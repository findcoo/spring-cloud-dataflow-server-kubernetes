install: ## spring cloud data flow를 런칭합니다. (ENV 변수가 필요합니다. 기본값: local)
	kubectl create -f src/kubernetes/kafka/
	kubectl create -f src/kubernetes/mysql/
	kubectl create -f src/kubernetes/redis/
	kubectl create -f src/kubernetes/metrics/metrics-deployment-kafka.yaml
	kubectl create -f src/kubernetes/metrics/metrics-svc.yaml
	kubectl create -f src/kubernetes/skipper/skipper-deployment.yaml
	kubectl create -f src/kubernetes/skipper/skipper-svc.yaml
	kubectl create -f src/kubernetes/server/server-roles.yaml
	kubectl create -f src/kubernetes/server/server-rolebinding.yaml
	kubectl create -f src/kubernetes/server/service-account.yaml
	kubectl create -f src/kubernetes/server/server-config-kafka.yaml
	kubectl create -f src/kubernetes/server/server-svc.yaml
	kubectl create -f src/kubernetes/server/server-deployment.yaml

remove: ## spring cloud data flow를 제거합니다.
	kubectl delete all -l app=kafka
	kubectl delete all,pvc,secrets -l app=mysql
	kubectl delete all -l app=redis
	kubectl delete all -l app=metrics
	kubectl delete all -l app=skipper
	kubectl delete all,cm -l app=scdf-server
	kubectl delete role scdf-role
	kubectl delete rolebinding scdf-rb
	kubectl delete serviceaccount scdf-sa

url: ## minikube를 사용시, 서비스의 url을 출력합니다.
	minikube service --url scdf-server

help:
	@grep -E '^[a-zA-Z0-9._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

