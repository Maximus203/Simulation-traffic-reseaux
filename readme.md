# Network Traffic Simulator

Ce projet est un simulateur de trafic réseau qui utilise Docker pour lancer plusieurs instances de téléchargement de fichiers. Il est conçu pour tester la bande passante et la performance du réseau en simulant des téléchargements simultanés.

## Table des matières

- [Prérequis](#prérequis)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Configuration](#configuration)
- [Contribution](#contribution)
- [Licence](#licence)

## Prérequis

- Docker installé sur votre machine.
- Docker Compose installé sur votre machine.

## Installation

1. **Cloner le dépôt**

   ```bash
   git clone https://github.com/Maximus203/Simulation-traffic-reseaux
   cd network-traffic-simulator
   ```

2. **Construire l'image Docker**

   ```bash
   docker build -t printfcherif/network-traffic-simulator:latest .
   ```

## Utilisation

Pour lancer 60 instances de téléchargement, utilisez Docker Compose :

```bash
docker-compose up --scale
```

Cela lancera 60 conteneurs qui téléchargeront le fichier spécifié dans le fichier `docker-compose.yaml`.

## Configuration

### Fichiers de configuration

- **Dockerfile** : Définit l'image Docker utilisée pour les conteneurs.
- **docker-compose.yaml** : Définit les services et les configurations pour Docker Compose.
- **download.sh** : Script shell utilisé pour télécharger le fichier spécifié.
- **simple-cron** : Fichier crontab utilisé pour planifier les téléchargements.

### docker-compose.yaml

Le fichier `docker-compose.yaml` est configuré pour lancer 60 instances du service `downloader` :

```yaml
version: '1'
services:
  downloader:
    image: printfcherif/network-traffic-simulator:latest
    deploy:
      replicas: 60
    environment:
      - URL=https://releases.ubuntu.com/noble/ubuntu-24.04.1-desktop-amd64.iso
```

### Dockerfile

Le fichier `Dockerfile` est configuré pour installer les dépendances nécessaires et copier les fichiers de configuration :

```Dockerfile
FROM ubuntu:latest

RUN apt-get update && apt-get install -y wget cron
COPY download.sh /usr/local/bin/
COPY simple-cron /etc/cron.d/simple-cron
RUN chmod 0644 /etc/cron.d/simple-cron
RUN crontab /etc/cron.d/simple-cron
```

### download.sh

Le script `download.sh` est utilisé pour télécharger le fichier spécifié :

```bash
#!/bin/bash
wget $1 -O /dev/null
```

### simple-cron

Le fichier `simple-cron` est utilisé pour planifier les téléchargements :

```bash
# simple-cron
* * * * * /usr/local/bin/download.sh https://releases.ubuntu.com/noble/ubuntu-24.04.1-desktop-amd64.iso >> /var/log/cron.log 2>&1
```

## Contribution

Les contributions sont les bienvenues ! Pour contribuer à ce projet, veuillez suivre ces étapes :

1. Forker le dépôt.
2. Créer une branche pour votre fonctionnalité (`git checkout -b date-feature/votre-fonctionnalite`).
3. Committer vos modifications (`git commit -m 'Ajouter une nouvelle fonctionnalité'`).
4. Pousser la branche (`git push origin feature/votre-fonctionnalite`).
5. Ouvrir une Pull Request.

## Licence

Ce projet est sous licence MIT.
