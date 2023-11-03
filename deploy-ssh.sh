#!/bin/bash

# Define the local directory where your repository exists.
LOCAL_REPO_DIR="."

# Function to perform a git pull.
git_pull() {
  echo "Attempting git pull..."
  git pull origin main
}

# Function to execute Python script.
run_python_script() {
  echo "Executing Python script..."
  python3 merge_json.py
}

# Navigate to the local repository directory.
if [ -d "$LOCAL_REPO_DIR" ]; then
  cd "$LOCAL_REPO_DIR" || exit 1
  
  # Try to pull the latest changes from the remote repository.
  if git_pull; then
    echo "Git pull successful."
    
    # Execute the Python script here.
    if run_python_script; then
      echo "Python script executed successfully."
    else
      echo "Python script execution failed."
    fi

  else
    echo "Git pull failed. Discarding local changes and pulling anew."
    
    # Discard local changes and uncommitted files.
    git reset --hard HEAD
    git clean -fd
    
    # Perform a git pull again.
    git_pull
  fi
else
  echo "Local repository directory does not exist."
fi
