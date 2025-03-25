# DevOps-проект: CI/CD, Monitoring и Logging для Django-приложения

## Структура инфраструктуры

Развернута в Yandex Cloud:
- ci — вспомогательный сервер (мониторинг, логирование)
- Kubernetes кластер: k8master + k8node

## Используемые технологии

- Terraform — для создания инфраструктуры (описание в отдельном репозитории)
- Ansible — автоматизация установки ПО на srv
- Docker — сборка контейнеров
- Prometheus + Node Exporter — мониторинг
- Grafana — визуализация метрик
- Loki — сборка логов
- Alertmanager + Telegram Bot — алертинг
- Helm — деплой приложения в кластер

---

## Мониторинг

- Prometheus: [http://130.193.44.145:9090](http://130.193.44.145:9090)
  - Метрики самого Prometheus и Node Exporter
  - Конфиг: prometheus.yml с двумя таргетами (оба UP)

- Node Exporter: собирает метрики srv  
  Проверен: метрики видны в интерфейсе Prometheus

- Grafana: [http://130.193.44.145:3000](http://130.193.44.145:3000)
  - Подключён Prometheus как datasource
  - Можно импортировать Dashboard по ID: 1860 ("Node Exporter Full")

---

## Логирование

- Loki: подключен в Grafana
  - Источник данных виден в Grafana → Explore → loki

---

## Алертинг

- Telegram-бот успешно подключён
- Получено тестовое сообщение
- Подключен chat_id
