#!/bin/bash

# Check if the script is run with superuser privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo"
  exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "Node.js is not installed. Please install Node.js and try again."
    exit 1
fi

# Define the project directory
PROJECT_DIR=$(pwd)

# Create the bash script to call the Node.js code
BASH_SCRIPT_PATH="/usr/local/bin/weather"

cat << EOF > $BASH_SCRIPT_PATH
#!/bin/bash

# Load environment variables from .env file
if [ -f "$PROJECT_DIR/.env" ]; then
  source "$PROJECT_DIR/.env"
#   echo "Loaded .env file successfully."
#   echo "Default city from .env: \$DEFAULT_CITY"
else
  echo "No .env file found."
fi

CITY=\${1:-\$DEFAULT_CITY}
# echo "Current city: \$CITY"

# Suppress Node.js warnings
export NODE_NO_WARNINGS=1

# Execute the JavaScript code
node -e "
const fetch = require('node-fetch');

// Get the city from command line arguments
const city = process.argv[1];

//console.log('Fetching data for:', city);

async function getCoordinates(city) {
    try {
        const response = await fetch('https://geocoding-api.open-meteo.com/v1/search?name=' + encodeURIComponent(city));
        const data = await response.json();

        if (!data.results || data.results.length === 0) {
            throw new Error('No coordinates found for city: ' + city);
        }

        return data.results[0];
    } catch (error) {
        throw new Error('Failed to fetch coordinates: ' + error.message);
    }
}

async function getAqi(coordinates) {
    try {
        const response = await fetch('https://air-quality-api.open-meteo.com/v1/air-quality?latitude=' + coordinates.latitude + '&longitude=' + coordinates.longitude + '&current=european_aqi');
        const data = await response.json();

        if (!data) {
            throw new Error('No AQI data found for the provided coordinates');
        }

        return data;
    } catch (error) {
        throw new Error('Failed to fetch AQI data: ' + error.message);
    }
}

async function main() {
    try {
        const coordinates = await getCoordinates(city);
        const aqi = await getAqi(coordinates);
        console.log('The AQI for ' + city + ' is:', aqi);
    } catch (error) {
        console.error(error);
    }
}

main();
" "\$CITY"
EOF

# Make the script executable
chmod +x $BASH_SCRIPT_PATH

# Check if node-fetch is installed locally, if not, install it
if [ ! -d "$PROJECT_DIR/node_modules/node-fetch" ]; then
    npm install node-fetch
fi

echo "Setup complete. You can now use the 'weather' command."
