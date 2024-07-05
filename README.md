# cli-aqi App

A simple Bash + Node.js app to check the AQI (Air Quality Index) of any city.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [License](#license)

## Introduction

- This app allows users to check the AQI of their local city or any given city by running a simple command in the terminal.
- Do you reside in the Terminal all day long?
- Are you scared to step out not knowing how polluted it might be?
- Well here comes a simple BASH+JS script that fetches the live AQI at your location with a simple run of the 'weather <city-name>' command

## Features

- Fetches AQI data using the Open-Meteo API.
- Simple command-line interface.
- Easily configurable with environment variables.
- Robust error handling and user-friendly messages.

## Prerequisites

- [Node.js](https://nodejs.org/) (v12.x or higher)
- npm (usually comes with Node.js)
- bash or zsh terminal

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yashxsagar/cli-aqi.git
   cd cli-aqi
   ```

2. Run the setup script:

   ```bash
   sudo ./setup.sh
   ```

   The setup script will:

   - Create and configure the necessary Node.js and Bash scripts.
   - Check for and install Node.js and `node-fetch` dependency if not already installed.

## Usage

[Configuration](#configuration)

### Check AQI for Default City

Run the following command to check the AQI for the default city:

```bash
weather
```

Run the following command to check the AQI for a different city:

```bash
weather <desired-city-name>
```

## Configuration

### Configure your default city for the script to use and display the AQI for

#### Create an environment file .env

```bash
cd cli-aqi
touch .env
```

Then, add the following line to the .env file:

```DEFAULT_CITY=<YOUR_DESIRED_CITY>```

### Changing the default city
```bash
cd cli-aqi
```

Run the following command -

```bash
echo "DEFAULT_CITY=Your_Default_City_Here" > .env
```
OR


Open .env file, and change the <YOUR_DESIRED_CITY> placeholder to the desired city, say London, Cupertino, Berlin, etc.

```
DEFAULT_CITY=<YOUR_DESIRED_CITY>
```

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
