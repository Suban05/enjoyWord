# EnjoyWord: Your Personal Dictionary
![image](https://github.com/Suban05/enjoyWord/assets/88084038/90774536-32b1-47a1-bd49-259932de84ff)

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

### Deploy in One Click

### Render

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

1. Click the button above
2. Sign in or create your account with [Render](https://render.com/) (FREE)
3. Give your blueprint a name
4. Select the `master` branch
5. On your computer, open a terminal and make sure you have the [openssl](https://github.com/openssl/openssl) utility installed on your computer
6. Generate your `SECRET_KEY_BASE` by running the following command in your terminal: `openssl rand -hex 64` ([docs](https://www.openssl.org/docs/man1.1.1/man1/rand.html))
7. Go back to your browser and paste this value in the "Value" field for `SECRET_KEY_BASE`
8. Click "Apply". This will take a few minutes
9. Сlick on the `EnjoyWord` "Web Service". You should see a custom URL in the format `https://enjoyword-abcd.onrender.com`. Click on it, and you'll run the `EnjoyWord` app.

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
git clone https://github.com/Suban05/EnjoyWord.git
```

Alternatively, you can download the project files and add them to a folder.

3. Navigate into the project folder. For example:

```bash
cd ~/docker-apps/EnjoyWord
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

