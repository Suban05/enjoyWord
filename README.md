# EnjoyWord: Your Personal Dictionary

EnjoyWord is a simple application for creating and managing your own dictionaries. It allows you to add new words and usage examples, as well as listen to the pronunciation of words.

## Features

* Create and manage your own dictionaries.
* Add new words and usage examples.
* Listen to audio pronunciation for added words.
* Support for multiple languages.

## Supported Languages

* English
* Spanish
* German
* French
* Italian
* Russian

## Highlights

* Audio pronunciation is available for all languages except Russian.
* Audio pronunciation is available only for words. Pronunciation of phrases, examples, and other content is not supported.

## Setup Guide

### Using Docker

You can run the app using Docker Compose.

### Step 1: Install Docker

1. Install Docker Engine by following [the official guide](https://docs.docker.com/engine/install/).
2. Start the Docker service on your machine.
3. Verify that Docker is installed correctly and running by opening a terminal and running:

```bash
docker run hello-world
```

### Step 2: Clone the repository

1. Create or navigate to a directory for your applications. For example:

```bash
cd ~/docker-apps
```

2. Clone the repository:

```bash
git clone https://github.com/Suban05/enjoyWord.git
```

Alternatively, you can download the project files and add them to a folder.

3. Navigate into the project folder. For example:

```bash
cd ~/docker-apps/enjoyWord
```

### Step 3: Create your environment file

To configure the app, create a file named `.env` where Docker will read environment variables from. For example:

```bash
touch .env
```

### Step 4: Generate the app secret key

The app requires an environment variable called `SECRET_KEY_BASE` to run. Generate it in your terminal (assuming `openssl` is installed):

```bash
openssl rand -hex 64
```

Save the generated key for the next step.

### Step 5: Populate your environment file

Open the `.env` file and add the following variables:

```
SECRET_KEY_BASE=your_generated_secret_key
DATABASE_URL=postgres://postgres:postgres@db:5432/postgres
```

### Step 6: Build and run the app

Execute these commands:

```bash
docker-compose build
docker-compose up
```

Your app is now set up and accessible at http://localhost:5000 in your web browser.

