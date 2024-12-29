#!/bin/bash

# Function to display usage information
display_usage() {
    echo "Usage: ./helpful_script.sh <operation>"
    echo "Valid operations are 'setup' and 'save'."
    exit 1
}

# Function for 'setup' operation
setup() {
    echo "Running setup..."
    pip install otter-grader numpy matplotlib datascience
    save
}

# Function for 'save' operation
save() {
    echo "Running save..."
    git add .
    git commit -m "saving commit: $(date '+%m/%d/%Y %H:%M')"
    git push
}

# Check if the script received an argument
if [ "$#" -ne 1 ] || [ "$1" == "--help" ] || [ "$1" != "setup" ] && [ "$1" != "save" ]; then
    display_usage
fi

# Get the hostname
current_hostname=$(hostname)
echo "Current hostname: $current_hostname"
# Check if hostname is "fedora" or "x1.langdon.bu.ed"
if [[ "$current_hostname" != "fedora" && "$current_hostname" != "x1.langdon.bu.edu" ]]; then
    # Place your script commands here
    echo "Running the script because the hostname is neither 'fedora' nor 'x1.langdon.bu.ed'"
else
    echo "This script won't run on hostnames 'fedora' or 'x1.langdon.bu.ed'"
    exit 0 # Exit with status code 0 to avoid angering jupyter
fi

# Get the operation argument
operation=$1

# Check for valid operation and call corresponding function
if [ "$operation" == "setup" ]; then
    setup
elif [ "$operation" == "save" ]; then
    save
fi
